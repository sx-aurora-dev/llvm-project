//===----------- LoopDependenceAnalysis.cpp - Iter Dependences -------------==//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// Internal pass that prints loop hotness stats based on `branch_weights`
// metadata provided by profiling.
//
//===----------------------------------------------------------------------===//

#include <llvm/Analysis/LoopHotnessStats.h>
#include <llvm/Analysis/LoopInfo.h>

using namespace llvm;

//#define DEBUG_TYPE "print<loop-hotness>"

llvm::PreservedAnalyses LoopHotnessStats::run(Function &F,
                                              FunctionAnalysisManager &FAM) {
  LoopInfo &LI = FAM.getResult<LoopAnalysis>(F);
  for (const Loop *L : LI) {
    os << "Loop : " << *L << "\n";
  }
  return llvm::PreservedAnalyses::all();
}