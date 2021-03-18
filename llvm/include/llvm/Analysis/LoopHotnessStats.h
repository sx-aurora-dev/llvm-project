//==- llvm/Analysis/LoopDependenceAnalysis.h - Iter Dependences -*- C++ -*-==//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_ANALYSIS_LOOPHOTNESSSTATS_H
#define LLVM_ANALYSIS_LOOPHOTNESSSTATS_H

#include <llvm/IR/Function.h>
#include <llvm/IR/PassManager.h>

namespace llvm {

/// Prints loop hotness statistics based on `branch_weights` profiling metadata.
class LoopHotnessStats : public PassInfoMixin<LoopHotnessStats> {
public:
  explicit LoopHotnessStats(llvm::raw_ostream &os_) : os(os_) {}
  llvm::PreservedAnalyses run(Function &F, FunctionAnalysisManager &FAM);

private:
  llvm::raw_ostream &os;
};

} // namespace llvm

#endif // LLVM_ANALYSIS_LOOPHOTNESSSTATS_H