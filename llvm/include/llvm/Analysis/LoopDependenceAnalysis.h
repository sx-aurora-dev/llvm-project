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

#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/PassManager.h"

namespace llvm {

class Loop;

using ConstVF = Optional<size_t>;

// Iteration dependence descriptor for a given loop.
// @baziotis: This is the actual interface. Everyting below is just boilerplate
// to fit things into LLVM's pass framework.
struct LoopDependence {
  /// The maximum vectorization factor for this loop. That is, how many
  /// iterations can be run in parallel. Or `None` if
  /// all loop iterations may be run in parallel. A vectorization factor of `1`
  /// indicates that the loop has to be executed sequentially.
  ConstVF VectorizationFactor;

  /// TODO (sometime in the future)
  /// Return an \c IRPredicate that describes under which condition the
  /// iterations of the loop have a minimum dependence distance of \p DepDist.
  //
  // IRPredicate getParallelPrecondition(DepDist);

  static LoopDependence getWorstPossible() {
    LoopDependence LD;
    LD.VectorizationFactor = 1;
    return LD;
  }

  static LoopDependence getBestPossible() {
    LoopDependence LD;
    LD.VectorizationFactor = 1;
    return LD;
  }

  bool isWorse(size_t V) const {
    if (!VectorizationFactor.hasValue())
      return true;
    size_t VF = VectorizationFactor.getValue();
    return (V < VF);
  }

  void possiblyPessimize(size_t V) {
    if (isWorse(V))
      VectorizationFactor = V;
  }

  bool isWorstPossible() const {
    if (!VectorizationFactor.hasValue())
      return false;
    return (VectorizationFactor.getValue() == 1);
  }
};

/// Interface to query \c LoopDependence information per loop in the analyzed
/// function.
class LoopDependenceInfo {
public:
  LoopDependenceInfo(Function &F, ScalarEvolution &SE, TargetLibraryInfo &TLI,
                     AAResults &AA, DominatorTree &DT, LoopInfo &LI);

  const LoopDependence getDependenceInfo(const Loop &L) const;

private:
  ScalarEvolution &SE;
  const TargetLibraryInfo &TLI;
  AAResults &AA;
  DominatorTree &DT;
  LoopInfo &LI;
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
