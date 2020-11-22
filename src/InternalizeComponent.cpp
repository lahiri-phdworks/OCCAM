//
// OCCAM
//
// Copyright (c) 2011-2018, SRI International
//
//  All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// * Redistributions of source code must retain the above copyright notice, this
//   list of conditions and the following disclaimer.
//
// * Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
//
// * Neither the name of SRI International nor the names of its contributors may
//   be used to endorse or promote products derived from this software without
//   specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#include "llvm/ADT/SmallSet.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/Module.h"
#include "llvm/Pass.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/IPO.h"

#include "Interfaces.h"

#include <fstream>
#include <string>
#include <vector>

using namespace llvm;

static cl::list<std::string> Interfaces(
    "Pinternalize-wrt-interfaces", cl::NotHidden,
    cl::desc("specifies the interface to internalize with respect to"));

static cl::opt<std::string> KeepExternalFile(
    "Pkeep-external",
    cl::desc("<file> : list of function names to be whitelisted"),
    cl::init(""));

static cl::opt<unsigned>
    FixpointTreshold("Pinternalize-fixpoint-threshold",
                     cl::desc("Limit of fixpoint iterations during global dead "
                              "code elimination refinement"),
                     cl::init(5));

namespace previrt {

static Value *stripBitCastCE(Constant *C) {
  if (ConstantExpr *CE = dyn_cast<ConstantExpr>(C)) {
    if (CE->getOpcode() == AddrSpaceCastInst::BitCast) {
      return CE->getOperand(0);
    }
  }
  return C;
}

// Whether the definition of a symbol can be discarded if it is not
// used in *other* compilation units.
static bool isDiscardableIfUnusedExternally(GlobalValue &GV) {
  GlobalValue::LinkageTypes Linkage = GV.getLinkage();
  return (// Ignore local linkages since the linker does not resolve them
	  !(GlobalValue::isLocalLinkage(Linkage)) && 
	  // Ignore appending linkage values since the linker
	  // doesn't resolve them.	  
	  Linkage != GlobalValue::AppendingLinkage &&
	  // We can't internalize available_externally globals because this
	  // can break function pointer equality.
	  Linkage != GlobalValue::AvailableExternallyLinkage &&
	  // We don't internalize if the global can be replaced with
	  // something non-equivalent
	  !GlobalValue::isInterposableLinkage(Linkage));

  // FIXME: There is an extra condition that we are not currently
  // checking but LTO.cpp does:
  // 
  // Functions and read-only variables with linkonce_odr and
  // weak_odr linkage can be internalized. We can't internalize
  // linkonce_odr and weak_odr variables which are both modified
  // and read somewhere in the program because reads and writes
  // will become inconsistent.
}

static bool setInternalLinkage(GlobalValue &GV) {
  
  auto printLinkage = [](GlobalValue &V, llvm::raw_ostream &o) {
    switch(V.getLinkage()) {
    case GlobalValue::ExternalLinkage:
    o << "ExternalLinkage"; break;
    case GlobalValue::AvailableExternallyLinkage:
    o << "AvailableExternallyLinkage"; break;    
    case GlobalValue::LinkOnceAnyLinkage:
    o << "LinkOnceAnyLinkage"; break;
    case GlobalValue::LinkOnceODRLinkage:
    o << "LinkOnceODRLinkage"; break;
    case GlobalValue::WeakAnyLinkage:
    o << "WeakAnyLinkage"; break;
    case GlobalValue::WeakODRLinkage:
    o << "WeakODRLinkage"; break;
    case GlobalValue::AppendingLinkage:
    o << "AppendingLinkage"; break;
    case GlobalValue::InternalLinkage:
    o << "InternalLinkage"; break;
    case GlobalValue::PrivateLinkage:
    o << "PrivateLinkage"; break;
    case GlobalValue::ExternalWeakLinkage:
    o << "ExternalWeakLinkage"; break;
    case GlobalValue::CommonLinkage:
    o << "CommonLinkage"; break;
    default: ;;
    }
  };

  auto printVisibility = [](GlobalValue &V, llvm::raw_ostream &o) {
    switch(V.getVisibility()) {
    case GlobalValue::DefaultVisibility:
    o << "DefaultVisibility"; break;
    case GlobalValue::HiddenVisibility:
    o << "HiddenVisibility"; break;    
    case GlobalValue::ProtectedVisibility:
    o << "ProtectedVisibility"; break;
    default: ;;
    }
  };

  errs() << "Internalizing '" << GV.getName() << "' ";
  printLinkage(GV, llvm::errs());
  errs() << " ";
  printVisibility(GV, llvm::errs());
  errs() << "\n";    
  GV.setLinkage(GlobalValue::InternalLinkage);
  return true;
}

class InternalizePass: public ModulePass {
public:
  // The current module is internalized with respect to m_interfaces
  ComponentInterface m_interfaces;
  
  static char ID;

  bool MinimizeComponent(Module &M);
  
public:
  
  InternalizePass() : ModulePass(ID) {}
  virtual ~InternalizePass() = default;

  virtual bool runOnModule(Module &M) {
    
    errs() << "InternalizePass\n";
    for (std::string input : Interfaces) {
      errs() << "Reading file '" << input << "'...";
      if (m_interfaces.readFromFile(input)) {
        errs() << "success\n";
      } else {
        errs() << "failed\n";
      }
    }
    errs() << "Done reading.\n";
    
    return MinimizeComponent(M);
  }

  virtual void getAnalysisUsage(AnalysisUsage &AU) const {}
};
  
/*
 * Remove unused code after considering dependencies with other
 * modules.
 * 
 * IMPORTANT: the caller must ensure that the m_interfaces reflects
 * all possible direct calls to M's functions.
 *
 * We do it in two steps:
 *
 * 1) Make internal any function or global if no direct call or
 * reference to them from other modules **and** its address hasn't
 * been taken (this last part take care of indirect calls).
 * 
 * 2) Leverage LLVM dead code elimination.
 */
bool InternalizePass::MinimizeComponent(Module &M) {

  errs() << "InternalizePass::runOnModule: " << M.getModuleIdentifier() << "\n";

  bool modified = false;
  // for stats
  int internalized_functions = 0;
  int internalized_globals = 0;

  std::set<std::string> keep_external;
  if (KeepExternalFile != "") {
    std::ifstream infile(KeepExternalFile);
    if (infile.is_open()) {
      std::string line;
      while (std::getline(infile, line)) {
        keep_external.insert(line);
      }
      infile.close();
    } else {
      errs() << "Warning: ignored whitelist because something failed.\n";
    }
  }

  // If we cannot internalize an alias we shouldn't either its
  // aliasee.
  SmallSet<Value *, 16> keepAliasees;
  std::vector<GlobalAlias *> unusedAliases;
  for (auto &alias : M.aliases()) {
    if (alias.hasName() && keep_external.count(alias.getName())) {
      errs() << "Did not internalize " << alias.getName()
             << " because it is whitelisted.\n";
      // If this alias cannot be remove make sure its aliasee is not
      // removed either.
      keepAliasees.insert(stripBitCastCE(alias.getAliasee()));
      continue;
    }

    if (!m_interfaces.hasReference(alias.getName()) && alias.use_empty()) {
      errs() << "Remove unused alias " << alias.getName() << "\n";
      unusedAliases.push_back(&alias);
    } else {
      // If this alias cannot be remove make sure its aliasee is not
      // removed either.
      //
      // Important to remove bitcast to calls
      Value *aliaseeV = stripBitCastCE(alias.getAliasee());
      errs() << "Alias " << alias.getName() << " to be kept and so its aliasee "
             << aliaseeV->getName() << "\n";
      keepAliasees.insert(aliaseeV);
    }
  }

  // Set all functions that are not in the interface to internal linkage only
  for (auto &f : M) {
    if (f.hasName() && keep_external.count(f.getName())) {
      errs() << "Did not internalize " << f.getName()
             << " because it is whitelisted.\n";
      continue;
    }

    if ( // f has a body
        !f.isDeclaration() &&
        // f is discardable if unused in other compilation units
        isDiscardableIfUnusedExternally(f) &&
        // No other compilation unit calls f
        !m_interfaces.hasCall(f.getName()) &&
	// The address of f has not been taken
	!f.hasAddressTaken() &&
	// No other compilation unit mentions f
        !m_interfaces.hasReference(f.getName()) &&
        // there is no an alias to f that we want to keep
        !keepAliasees.count(&f)) {

      if (setInternalLinkage(f)) {
        internalized_functions++;
        modified = true;
      }
    }
  }

  // Set all initialized global variables that are not referenced in
  // the interface to "localized linkage" only
  for (auto &gv : M.globals()) {
    if (gv.hasName() && keep_external.count(gv.getName())) {
      errs() << "Did not internalize " << gv.getName()
             << " because it is whitelisted.\n";
      continue;
    }

    if (gv.hasInitializer() &&
        // global is unused 
        !m_interfaces.hasReference(gv.getName()) &&
	// global can be removed if unused
        isDiscardableIfUnusedExternally(gv) &&
        // there is no an alias to the global that we want to keep
        !keepAliasees.count(&gv)) {

      if (setInternalLinkage(gv)) {
        internalized_globals++;
        modified = true;
      }
    }
  }

  // GlobalDCE does not remove a function if it has an alias.
  // We remove an alias if it is not referenced in other modules and
  // it has no uses within this module
  while (!unusedAliases.empty()) {
    modified = true;
    GlobalAlias *alias = unusedAliases.back();
    unusedAliases.pop_back();
    errs() << "Removing alias " << alias->getName() << " before calling DCE\n";
    alias->eraseFromParent();
  }

  if (!modified) {
    /// HACK: do not remove this line. The python code searches for it ...            
    errs() << "...no progress...\n";
    return false;
  }

  // Perform global dead code elimination until fixpoint or
  // threshold is reached.
  legacy::PassManager dceMgr, mcMgr;
  ModulePass *modulePassDCE = createGlobalDCEPass();
  ModulePass *constantMergePass = createConstantMergePass();
  dceMgr.add(modulePassDCE);
  mcMgr.add(constantMergePass);

  bool moreToDo = true;
  bool change_dce = false;
  bool change_mc = false;
  unsigned int iters = 0;

  while (moreToDo && iters < FixpointTreshold) {
    change_dce = dceMgr.run(M);
    change_mc = mcMgr.run(M);
    moreToDo = (change_dce || change_mc);
    ++iters;
  }

  if (change_dce) {
    errs() << "GlobalDCE still had more to do\n";
  }
  if (change_mc) {
    errs() << "MergeConstants still had more to do\n";
  }

  /// HACK: do not remove this line. The python code searches for it ...      
  errs() << "...progress...\n";
  
  errs() << "Progress:"
         << " internalized functions = " << internalized_functions
         << " internalized globals = " << internalized_globals << "\n";
  return true;
}


char InternalizePass::ID;
} // end namespace previrt

static RegisterPass<previrt::InternalizePass>
    X("Pinternalize", "hide/eliminate all non-external dependencies", false,
      false);
