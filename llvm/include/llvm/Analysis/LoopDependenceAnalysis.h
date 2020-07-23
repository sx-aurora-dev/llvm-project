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

#ifndef LLVM_ANALYSIS_LOOPDEPENDENCEANALYSIS_H
#define LLVM_ANALYSIS_LOOPDEPENDENCEANALYSIS_H

#include <llvm/IR/PassManager.h>
#include <llvm/IR/Function.h>

namespace llvm {

class Loop;

using ConstDepDist = Optional<size_t>;

// Iteration dependence descriptor for a given loop.
// @baziotis: This is the actual interface. Everyting below is just boilerplate
// to fit things into LLVM's pass framework.
struct LoopDependence {
  /// The minimum dependence distance for iterations of this loop. Or `None` if
  /// all loop iterations may be run in parallel. A dependence distance of `1`
  /// indicates that the loop has to be executed sequentially.
  ConstDepDist DepDist;

  /// TODO (sometime in the future)
  /// Return an \c IRPredicate that describes under which condition the
  /// iterations of the loop have a minimum dependence distance of \p DepDist.
  //
  // IRPredicate getParallelPrecondition(DepDist);
};

/// Interface to query \c LoopDependence information per loop in the analyzed
/// function.
class LoopDependenceInfo {
public:
  // TODO implement
  LoopDependenceInfo(Function &F, FunctionAnalysisManager &FAM);

  // TODO implement
  const LoopDependence &getDependenceInfo(Loop &L);
};

/// Analysis pass that exposes the \c LoopDependenceInfo for a function.
// Note (TODO): we use a FunctionPass for more flexibility. Potentially switch
// to a LoopPass sometime if that should work out fine.
class LoopDependenceAnalysis
    : public AnalysisInfoMixin<LoopDependenceAnalysis> {
  friend AnalysisInfoMixin<LoopDependenceAnalysis>;
  static AnalysisKey Key;

public:
  typedef LoopDependenceInfo Result;

  LoopDependenceInfo run(Function &F, FunctionAnalysisManager &FAM);
};

} // namespace llvm

#endif // LLVM_ANALYSIS_LOOPDEPENDENCEANALYSIS_H
