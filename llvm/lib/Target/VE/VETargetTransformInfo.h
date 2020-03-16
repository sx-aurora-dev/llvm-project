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
#include "llvm/IR/Instructions.h"
#include "llvm/IR/PredicatedInst.h"
#include "llvm/IR/Type.h"

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
        TLI(ST->getTargetLowering()) {}

  unsigned getNumberOfRegisters(unsigned ClassID) const { return 64; }

  unsigned getRegisterBitWidth(bool Vector) const {
    if (Vector) {
      return 256 * 64;
    }
    return 64;
  }

  unsigned getMinVectorRegisterBitWidth() const { return 256 * 64; }

  static bool
  isLegalMemDataType(Type& DT) {
    if (DT.isIntegerTy()) {
      unsigned ScaBits = DT.getScalarSizeInBits();
      return ScaBits == 32 || ScaBits == 64;
    }
    if (DT.isPointerTy()) {
      return true;
    } 
    if (DT.isFloatTy() || DT.isDoubleTy()) {
      return true;
    }
    return false;
  }

  // Load & Store {
  bool isLegalMaskedLoad(Type *DataType, MaybeAlign Alignment) {
    return DataType->getPrimitiveSizeInBits() == 1 ||
           isLegalMemDataType(*DataType);
  }
  bool isLegalMaskedStore(Type *DataType, MaybeAlign Alignment) {
    return DataType->getPrimitiveSizeInBits() == 1 ||
           isLegalMemDataType(*DataType);
  }
  bool isLegalMaskedGather(Type *ScaDataType, MaybeAlign Alignment) {
    return isLegalMemDataType(*ScaDataType);
  };
  bool isLegalMaskedScatter(Type *ScaDataType, MaybeAlign Alignment) {
    return isLegalMemDataType(*ScaDataType);
  }
  // } Load & Store

  /// LLVM-VP Support
  /// {

  /// \returns True if the vector length parameter should be folded into the
  /// vector mask.
  bool
  shouldFoldVectorLengthIntoMask(const PredicatedInstruction &PredInst) const {
    return false; // FIXME (return true for masking operations)
  }

  /// \returns False if this VP op should be replaced by a non-VP op or an
  /// unpredicated op plus a select.
  bool supportsVPOperation(const PredicatedInstruction &PredInst) const {
    switch (PredInst.getOpcode()) {
    default:
      break;

    // Non-opcode VP ops
    case Instruction::Call:
      // vp mask operations unsupported
      if (PredInst.isVectorReduction())
        return !PredInst.getType()->isIntOrIntVectorTy(1);
      break;

    // vp mask operations unsupported
    case Instruction::And:
    case Instruction::Or:
    case Instruction::Xor:
      auto ITy = PredInst.getType();
      if (!ITy->isVectorTy())
        break;
      if (!ITy->isIntOrIntVectorTy(1))
        break;
      return false;
    }

    // be optimistic by default
    return true;
  }

  /// }

  bool shouldExpandReduction(const IntrinsicInst *II) const {
    return false; // never expand reductions
  }
};

} // namespace llvm

#endif // LLVM_LIB_TARGET_VE_VETARGETTRANSFORMINFO_H
