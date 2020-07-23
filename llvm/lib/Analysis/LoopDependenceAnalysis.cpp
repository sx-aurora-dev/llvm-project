//===----------- LoopDependenceAnalysis.cpp - Iter Dependences -------------==//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// The implementation for the loop memory dependence that was originally
// developed for the loop vectorizer.
//
//===----------------------------------------------------------------------===//

#include <llvm/Analysis/LoopDependenceAnalysis.h>

using namespace llvm;

#define DEBUG_TYPE "loop-dependence"

AnalysisKey LoopDependenceAnalysis::Key;

LoopDependenceInfo LoopDependenceAnalysis::run(Function &F,
                                               FunctionAnalysisManager &FAM) {
  return LoopDependenceInfo(F, FAM);
}

LoopDependenceInfo::LoopDependenceInfo(Function &F,
                                       FunctionAnalysisManager &FAM) {
  abort(); // TODO do stuff
}
