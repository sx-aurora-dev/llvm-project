//==- llvm/NOELLE/LoopDistribution/LoopDistribution.h - Loop Distribution Pass
//-*- C++ -*-==//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// NOELLE Transformer Interface
// 
// TODO: Eventually, this should do analysis and cost-modeling, calling the utilities
// like LoopDistribution, LoopInterchange etc. as simple functions.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_NOELLE_TRANSFORMER
#define LLVM_NOELLE_TRANSFORMER

#include "llvm/IR/Module.h"
#include "llvm/IR/PassManager.h"

namespace llvm {

class NOELLETransformer : public PassInfoMixin<NOELLETransformer> {
public:
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &MAM);
};

} // namespace llvm

#endif // LLVM_NOELLE_TRANSFORMER