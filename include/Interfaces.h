//
// OCCAM
//
// Copyright (c) 2011-2016, SRI International
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

#pragma once

#include "llvm/ADT/StringMap.h"
#include "llvm/ADT/iterator.h"
#include "llvm/ADT/iterator_range.h"
#include "llvm/IR/Function.h"

#include <iterator>
#include <map>
#include <memory>
#include <set>
#include <string>
#include <vector>

#include "InterfaceTypes.h"

namespace llvm {
  class raw_ostream;
}
namespace previrt {

// FIXME: it should be a StringRef
typedef std::string FunctionHandle;

class ComponentInterface;
 
/* Class to represent a callsite in the interface.
 *
 * An interface's callsite replaces callsite's arguments with types
 * (InterfaceType).
 */
class CallInfo {
  unsigned count;
  std::vector<InterfaceType> args;

public:

  using const_iterator = std::vector<InterfaceType>::const_iterator;
  
  unsigned num_args() const { return args.size(); }

  const_iterator args_begin() const { return args.begin();}

  const_iterator args_end() const { return args.end();}  

  const std::vector<InterfaceType>& get_args() const { return args;}
  
  unsigned &get_count() { return count;}

  unsigned get_count() const { return count;}  
  
  int refines(llvm::User::op_iterator begin, llvm::User::op_iterator end);

  FRIEND_SERIALIZERS(CallInfo, proto::CallInfo)

  // Convert a LLVM CallSite to an Interface callsite
  static CallInfo *Create(llvm::User::op_iterator, llvm::User::op_iterator,
                          unsigned count = 0);
  static CallInfo *Create(unsigned len, unsigned count = 0);
  static CallInfo *Create(const std::vector<InterfaceType> &,
                          unsigned count = 0);

  friend class ComponentInterface;
};

/*
 * Class that represents the interface of a module or set of modules
 * (i.e., component).
 *
 * An interface for M records both external calls done by M and calls
 * to M's functions from other modules.
 */
class ComponentInterface {
public:
  using FunctionIterator = llvm::StringMapKeyIterator<std::vector<CallInfo *>>;
  using CallIterator = std::vector<CallInfo *>::const_iterator;

private:

  // to record direct calls to functions defined in other modules
  llvm::StringMap<std::vector<CallInfo *>> m_calls;
  // to record any external symbol used in the current module.
  std::set<std::string> m_references;

public:

  ComponentInterface() = default;
  
  virtual ~ComponentInterface();

  // Record current module makes an external call
  void callTo(FunctionHandle f, llvm::User::op_iterator args_begin,
	      llvm::User::op_iterator args_end);

  // Record that Module's function f may be called from other modules
  void callFrom(const llvm::Function *f);

  // Record symbol as external
  void reference(llvm::StringRef symbol);

  CallInfo *getOrCreateCall(FunctionHandle f,
                            const std::vector<InterfaceType> &args);

  // iteration over the functions
  FunctionIterator begin() const;
  FunctionIterator end() const;

  // iteration over the calls to a function
  CallIterator call_begin(llvm::StringRef) const;
  CallIterator call_end(llvm::StringRef) const;

  bool hasReference(llvm::StringRef ref) const {
    return m_references.count(ref) > 0;}
  
  bool hasCall(llvm::StringRef ref) const {
    return m_calls.find(ref) != m_calls.end();
  }

  bool readFromFile(const std::string &filename);

  void write(llvm::raw_ostream &o) const;

  void dump() const;
  
  friend llvm::raw_ostream &operator<<(llvm::raw_ostream &o, const ComponentInterface &I) {
    I.write(o);
    return o;
  }
  
  FRIEND_SERIALIZERS(ComponentInterface, proto::ComponentInterface)
};

/* Mark callsite arguments with some marker.
 * These markings are used to know which callsite argument will be
 * specialized (i.e., replaced by constant value) or not.
 *
 * Given callsite foo(a,b,c,d,e,f) and b and d are the arguments to
 * be specialized:
 *
 *   function = "foo"
 *   args = [1,3]
 */
class CallRewrite {
  FunctionHandle function;
  std::vector<unsigned> args;

public:
  CallRewrite() {}
  CallRewrite(FunctionHandle h, const std::vector<unsigned> &a);
  CallRewrite(const CallRewrite &);

  const std::vector<unsigned>& get_args() const { return args;}
  
  const FunctionHandle& get_function() const { return function;}
  
  FRIEND_SERIALIZERS(CallRewrite, proto::CallRewrite)
};

/*
 * For a given interface, keep track whether a callsite argument
 * will be rewritten (specialized) or not.
 */
class ComponentInterfaceTransform {

  using CMap = std::map<const CallInfo *const, const CallRewrite>;
  using FMap = std::map<FunctionHandle, CMap>;

  class FMapKeyIterator : public llvm::iterator_adaptor_base<
                              FMapKeyIterator, FMap::const_iterator,
                              std::forward_iterator_tag, FunctionHandle> {
    using base =
        llvm::iterator_adaptor_base<FMapKeyIterator, FMap::const_iterator,
                                    std::forward_iterator_tag, FunctionHandle>;

  public:
    FMapKeyIterator() = default;
    explicit FMapKeyIterator(FMap::const_iterator Iter)
        : base(std::move(Iter)) {}

    FunctionHandle &operator*() {
      Key = this->wrapped()->first;
      return Key;
    }

  private:
    FunctionHandle Key;
  };

  std::unique_ptr<ComponentInterface> interface;
  FMap rewrites;

public:
  using FunctionIterator = FMapKeyIterator;
  using FunctionRange = llvm::iterator_range<FMapKeyIterator>;

  ComponentInterfaceTransform() = default;
  virtual ~ComponentInterfaceTransform() = default;

  FunctionIterator begin() const { return FMapKeyIterator(rewrites.begin()); }

  FunctionIterator end() const { return FMapKeyIterator(rewrites.end()); }

  FunctionRange functions() const { return llvm::make_range(begin(), end()); }

  void rewrite(FunctionHandle, const CallInfo *const, FunctionHandle,
               const std::vector<unsigned> &);
  void rewrite(FunctionHandle, const CallInfo *const, const CallRewrite &);

  void dump() const;

  const ComponentInterface &getInterface() const;

  bool hasInterface() const { return interface != nullptr; }

  unsigned rewriteCount() const;

  const CallRewrite *lookupRewrite(FunctionHandle, llvm::User::op_iterator,
                                   llvm::User::op_iterator) const;

  const CallRewrite *lookupRewrite(FunctionHandle, const CallInfo *const) const;

  bool readInterfaceFromFile(const std::string &);
  bool readTransformFromFile(const std::string &);

public:
  /* Allocate interface and populate from a file */
  FRIEND_SERIALIZERS(ComponentInterfaceTransform,
                     proto::ComponentInterfaceTransform)
  friend void ::previrt::codeInto<proto::ComponentInterface,
                                  ComponentInterfaceTransform>(
      const proto::ComponentInterface &, ComponentInterfaceTransform &);
};
}
