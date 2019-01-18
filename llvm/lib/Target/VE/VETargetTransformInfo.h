//===- VETargetTransformInfo.h - VE specific TTI ------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
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
//#include "VESubtarget.h"
#include "VETargetMachine.h"
//#include "llvm/ADT/ArrayRef.h"
#include "llvm/Analysis/TargetTransformInfo.h"
#include "llvm/CodeGen/BasicTTIImpl.h"
//#include "llvm/IR/Function.h"
//#include "llvm/IR/Intrinsics.h"
//#include <cstdint>

namespace llvm {

class VETTIImpl : public BasicTTIImplBase<VETTIImpl> {
  using BaseT = BasicTTIImplBase<VETTIImpl>;
  friend BaseT;

  const VESubtarget *ST;
  const VETargetLowering *TLI;

  const VESubtarget *getST() const { return ST; }
  const VETargetLowering *getTLI() const { return TLI; }

public:
  explicit VETTIImpl(const VETargetMachine *TM, const Function &F)
      : BaseT(TM, F.getParent()->getDataLayout()), ST(TM->getSubtargetImpl(F)),
        TLI(ST->getTargetLowering()){}

  unsigned getNumberOfRegisters(bool Vector) {
    if (Vector) {
      return 64;
    }
    return 64;
  }

  unsigned getRegisterBitWidth(bool Vector) const {
      if (Vector) {
          return 256*64;
      }
      return 64;
  }

  unsigned getMinVectorRegisterBitWidth() const { return 256*64; }

  bool isLegalMaskedLoad(Type *DataType) {
    return true;
  }

  bool isLegalMaskedGather(Type *DataType) {
      //if (DataType->getVectorNumElements() != 256) {
      //  return false;
      //}
      return true;
  };

  bool isLegalMaskedScatter(Type *DataType) {
      //if (DataType->getVectorNumElements() != 256) {
      //  return false;
      //}
      return true;
  };

};

}

#endif // LLVM_LIB_TARGET_AARCH64_AARCH64TARGETTRANSFORMINFO_H
