#pragma once

#include "SpecializationPolicy.h"
#include "llvm/ADT/SmallSet.h"
#include "llvm/Analysis/CallGraph.h"
#include "llvm/Analysis/LoopInfo.h"
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>

#include "utils/QueryOracleClient.h"
#include <cstdlib>
#include <random>
#include <vector>

namespace previrt {

class MLPolicy : public SpecializationPolicy {

  typedef llvm::SmallSet<llvm::Function *, 32> FunctionSet;

  llvm::CallGraph &cg;
  llvm::Pass &pass;
  SpecializationPolicy *const delegate;
  std::string *database = new std::string();
  const float epsilon;
  std::string *s = new std::string();
  std::string *state_encoded = new std::string();
  std::vector<float> *trace = new std::vector<float>();

  const bool use_grpc;
  FunctionSet rec_functions;

  void markRecursiveFunctions();
  bool isRecursive(llvm::Function *f) const;
  bool allowSpecialization(llvm::Function *f) const;
  std::vector<unsigned> getInstructionCount(llvm::Function *f) const;
  unsigned getLoopCount(llvm::Function *f) const;
  std::vector<unsigned> getModuleFeatures(llvm::Function *caller) const;
  bool random_with_prob(const double prob) const;
  void pushToTrace(const int v) const;

public:
  MLPolicy(SpecializationPolicy *delegate, llvm::CallGraph &cg,
           llvm::Pass &pass, std::string database, const float epsilon,
           const bool use_grpc);

  virtual ~MLPolicy();

  virtual bool intraSpecializeOn(llvm::CallSite CS,
                                 std::vector<llvm::Value *> &marks) override;

  virtual bool interSpecializeOn(const llvm::Function &F,
                                 const std::vector<InterfaceType> &args,
                                 const ComponentInterface &interface,
                                 llvm::SmallBitVector &marks) override;
};
} // end namespace previrt