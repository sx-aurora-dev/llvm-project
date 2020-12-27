//===- VETargetTransformInfo.h - VE specific TTI ------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
/// \file
/// This file a TargetTransformInfo::Concept conforming object specific to the
/// VE target machine. It uses the target's detailed information to
/// provide more precise answers to certain TTI queries, while letting the
/// target independent and default TTI implementations handle the rest.
///
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_VE_VETARGETTRANSFORMINFO_H
#define LLVM_LIB_TARGET_VE_VETARGETTRANSFORMINFO_H

#include "VE.h"
#include "VETargetMachine.h"
#include "llvm/Analysis/TargetTransformInfo.h"
#include "llvm/CodeGen/BasicTTIImpl.h"

namespace llvm {

class VETTIImpl : public BasicTTIImplBase<VETTIImpl> {
  using BaseT = BasicTTIImplBase<VETTIImpl>;
  friend BaseT;

  const VESubtarget *ST;
  const VETargetLowering *TLI;

  const VESubtarget *getST() const { return ST; }
  const VETargetLowering *getTLI() const { return TLI; }

  bool enableVPU() const { return getST()->enableVPU(); }
  bool intrinsic() const { return getST()->intrinsic(); }
  // Experimental simd-style fixed length vectorization
  bool simd() const { return getST()->simd(); }

public:
  explicit VETTIImpl(const VETargetMachine *TM, const Function &F)
      : BaseT(TM, F.getParent()->getDataLayout()), ST(TM->getSubtargetImpl(F)),
        TLI(ST->getTargetLowering()) {}

  unsigned getNumberOfRegisters(unsigned ClassID) const {
    bool VectorRegs = (ClassID == 1);
    if (VectorRegs) {
      if (simd())
        return 64;
      // TODO report vregs once vector isel is stable.
      return 0;
    }

    return 64;
  }

  unsigned getRegisterBitWidth(bool Vector) const {
    if (Vector) {
      if (simd())
        return 256 * 64;
      // TODO report vregs once vector isel is stable.
      return 0;
    }
    return 64;
  }

  unsigned getMinVectorRegisterBitWidth() const {
    // Let's say 8 vector length minimum.
    // TODO: Need to implement experimental vectorization first, then
    //       evaluate minimum vector length for the best performance.
    if (simd())
      return 8 * 64;
    // TODO report vregs once vector isel is stable.
    return 0;
  }

  bool isLegalMaskedLoad(Type *DataType, MaybeAlign Alignment) {
#if 1
    // Enabling masked load causes "Cannot select ...masked_load..."
    // error in test-suite/SingleSource/Benchmarks/BenchmarkGame/fannkuch.c.
    // So, disable this temporary.
    return false;
#else
    return true;
#endif
  }

  bool isLegalMaskedGather(Type *DataType, MaybeAlign Alignment) {
      //if (DataType->getVectorNumElements() != 256) {
      //  return false;
      //}
#if 1
      // Enabling masked gather causes "Cannot select ...masked_gather..."
      // error in test-suite/SingleSource/Benchmarks/Misc/ReedSolomon.c.  So,
      // disable this temporary.
      return false;
#else
      return true;
#endif
  };

  bool isLegalMaskedScatter(Type *DataType, MaybeAlign Alignment) {
      //if (DataType->getVectorNumElements() != 256) {
      //  return false;
      //}
#if 1
      // Enabling masked scatter causes "Cannot select ...masked_scatter..."
      // error in test-suite/SingleSource/Regression/C/bigstack.c.  So,
      // disable this temporary.
      return false;
#else
      return true;
#endif
  };

};

} // namespace llvm

#endif // LLVM_LIB_TARGET_VE_VETARGETTRANSFORMINFO_H
