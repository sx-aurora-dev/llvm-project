//===- VETargetTransformInfo.cpp - VE specific TTI pass ---------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
/// \file
/// This file implements a TargetTransformInfo analysis pass specific to the
/// VE target machine. It uses the target's detailed information to provide
/// more precise answers to certain TTI queries, while letting the target
/// independent and default TTI implementations handle the rest.
///
//===----------------------------------------------------------------------===//

#include "VETargetTransformInfo.h"
#include "VESubtarget.h"
#include "llvm/Analysis/TargetTransformInfo.h"
#include "llvm/CodeGen/ValueTypes.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/User.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Transforms/Utils/LoopPeel.h"
#include "llvm/Transforms/Utils/UnrollLoop.h"

namespace llvm {
cl::opt<bool>
    EnableVectorUnroll("ve-unroll-vector", cl::init(false), cl::NotHidden,
                       cl::desc("Unroll vector loops (work in progress)"));

cl::opt<bool> ExpensiveVector(
    "ve-expensive-vector", cl::init(true),
    cl::desc(
        "Discourage vectorization by hiding all vector registers, ops in TTI"),
    cl::NotHidden);
} // namespace llvm

using namespace llvm;

#define DEBUG_TYPE "vetti"

bool VETTIImpl::makeVectorOpsExpensive() { return ExpensiveVector; }

static bool IsVectorLoop(Loop *L) {
  for (const auto *BB : L->blocks()) {
    for (const auto &I : *BB) {
      const auto *VecTy = dyn_cast<FixedVectorType>(I.getType());
      if (VecTy)
        return true;
    }
  }
  return false;
}

static unsigned ComputeUnrollFactor(Loop *L) {
  unsigned NumVecArith = 0;
  unsigned NumVecLoad = 0;
  unsigned NumCalls = 0;

  // minimal number of vector instructions in the loop.
  const unsigned MinPayload = 9;
  // maximal number of vops we should not cross by unrolling.
  const unsigned MaxPayload = 36;

  for (const auto *BB : L->blocks()) {
    for (const auto &I : *BB) {
      const auto *VecTy = dyn_cast<FixedVectorType>(I.getType());
      // vector payload
      if (VecTy && !I.mayReadOrWriteMemory()) {
        ++NumVecArith;
        continue;
      }
      //.function calls  -> roadblock
      if (isa<CallInst>(I) && !isa<IntrinsicInst>(I)) {
        ++NumCalls;
        continue;
      }
      // vector load
      if (VecTy && I.mayReadFromMemory() && I.mayWriteToMemory()) {
        ++NumVecLoad;
        continue;
      }
    }
  }

  // No benefit in unrolling calls
  if (NumCalls > 0)
    return 0;

  unsigned Payload = NumVecArith + NumVecLoad;
  if (Payload == 0)
    return 0;

  // Number of unrolls to get at least MinPayload.
  unsigned AtLeastTimes = (MinPayload + (Payload - 1)) / Payload;
  unsigned AtMostTimes = (MaxPayload + (Payload - 1)) / Payload;

  return std::min(AtLeastTimes, AtMostTimes);
}

/// Unrolling {
// Unroll inner-most vector loops
void VETTIImpl::getUnrollingPreferences(Loop *L, ScalarEvolution &SE,
                             TargetTransformInfo::UnrollingPreferences &UP,
                             OptimizationRemarkEmitter *ORE) {
  // Default settings for scalar loops
  if (!L->isInnermost() || !IsVectorLoop(L))
    return;

  // Run the vector loop heuristics.
  if (!EnableVectorUnroll)
    return;
  unsigned Factor = ComputeUnrollFactor(L);
  if (Factor > 1) {
    UP.PartialThreshold = UINT_MAX;
    UP.MaxCount = UP.Count = Factor;
    UP.Force = true;
  }

  UP.Runtime = UP.Partial = true;
}
/// } Unrolling
