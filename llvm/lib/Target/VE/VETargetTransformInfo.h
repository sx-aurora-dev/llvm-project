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
#include "llvm/IR/Intrinsics.h"
#include "llvm/IR/PredicatedInst.h"
#include "llvm/IR/Type.h"

static llvm::Type* GetVectorElementType(llvm::Type *Ty) {
  return llvm::cast<llvm::FixedVectorType>(Ty)->getElementType();
}

static unsigned GetVectorNumElements(llvm::Type *Ty) {
  return llvm::cast<llvm::FixedVectorType>(Ty)->getNumElements();
}

static bool IsMaskType(llvm::Type *Ty) {
  return Ty->isVectorTy() &&
         GetVectorElementType(Ty)->getPrimitiveSizeInBits() == 1;
}

static llvm::Type *GetLaneType(llvm::Type *Ty) {
  using namespace llvm;
  if (!isa<VectorType>(Ty))
    return Ty;
  return GetVectorElementType(Ty);
}

namespace llvm {

class VETTIImpl : public BasicTTIImplBase<VETTIImpl> {
  using BaseT = BasicTTIImplBase<VETTIImpl>;
  friend BaseT;

  const VESubtarget *ST;
  const VETargetLowering *TLI;

  const VESubtarget *getST() const { return ST; }
  const VETargetLowering *getTLI() const { return TLI; }

  bool enableVPU() const { return getST()->enableVPU(); }
  bool hasPackedMode() const { return getST()->hasPackedMode(); }

  static bool isSupportedReduction(Intrinsic::ID ReductionID, bool Unordered) {
    switch (ReductionID) {
    ///// FP reductions (supported in in ordered and un-ordered mode)
    case Intrinsic::vp_reduce_fadd:
    case Intrinsic::experimental_vector_reduce_v2_fadd:
    case Intrinsic::vector_reduce_fadd:
    // case Intrinsic::experimental_vector_reduce_fmin: // TODO
    // case Intrinsic::experimental_vector_reduce_fmax: // TODO
    // case Intrinsic::experimental_vector_reduce_smin: // TODO
    // case Intrinsic::experimental_vector_reduce_smax: // TODO
    // case Intrinsic::experimental_vector_reduce_umin: // TODO
    // case Intrinsic::experimental_vector_reduce_umax: // TODO
      return true;

    ///// FP reduction (Ordered only)
    case Intrinsic::experimental_vector_reduce_v2_fmul:
    case Intrinsic::vector_reduce_fmul:
      return !Unordered;

    ///// int arith
    case Intrinsic::vp_reduce_add:
    case Intrinsic::experimental_vector_reduce_add:

    ///// bit arith
    case Intrinsic::vp_reduce_or:
    case Intrinsic::vp_reduce_and:
    case Intrinsic::vp_reduce_xor:
    case Intrinsic::experimental_vector_reduce_or:
    case Intrinsic::experimental_vector_reduce_and:
    case Intrinsic::experimental_vector_reduce_xor:
      return true;

    // Otw, run standard reduction expansion
    default:
      return false;
    }
  }

public:
  explicit VETTIImpl(const VETargetMachine *TM, const Function &F)
      : BaseT(TM, F.getParent()->getDataLayout()), ST(TM->getSubtargetImpl(F)),
        TLI(ST->getTargetLowering()) {}

  unsigned getNumberOfRegisters(unsigned ClassID) const {
    bool VectorRegs = (ClassID == 1);
    if (!enableVPU() && VectorRegs) {
      return 0;
    }
    return 64;
  }

  unsigned getRegisterBitWidth(bool Vector) const {
    if (Vector) {
      return enableVPU() ? 256 * 64 : 0;
    }
    return 64;
  }

  unsigned getMinVectorRegisterBitWidth() const {
    return enableVPU() ? 256 * 64 : 0;
  }

  static bool isBoolTy(Type *Ty) { return Ty->getPrimitiveSizeInBits() == 1; }

  unsigned getVRegCapacity(Type &ElemTy) const {
    unsigned PackLimit = getST()->hasPackedMode() ? 512 : 256;
    if (ElemTy.isIntegerTy() && ElemTy.getPrimitiveSizeInBits() <= 32)
      return PackLimit;
    if (ElemTy.isFloatTy())
      return PackLimit;
    return 256;
  }

  bool isBitVectorType(Type &DT) {
    auto VTy = dyn_cast<VectorType>(&DT);
    if (!VTy)
      return false;
    return isBoolTy(GetVectorElementType(VTy)) &&
           GetVectorNumElements(VTy) <=
               getVRegCapacity(*GetVectorElementType(VTy));
  }

  bool isVectorLaneType(Type &ElemTy) const {
    // check element sizes for vregs
    if (ElemTy.isIntegerTy()) {
      unsigned ScaBits = ElemTy.getScalarSizeInBits();
      return ScaBits == 32 || ScaBits == 64;
    }
    if (ElemTy.isPointerTy()) {
      return true;
    }
    if (ElemTy.isFloatTy() || ElemTy.isDoubleTy()) {
      return true;
    }
    return false;
  }

  bool isVectorRegisterType(Type &DT) {
    auto VTy = dyn_cast<VectorType>(&DT);
    if (!VTy)
      return false;
    auto &ElemTy = *GetVectorElementType(VTy);

    // oversized vector
    if (getVRegCapacity(ElemTy) < GetVectorNumElements(VTy))
      return false;

    return isVectorLaneType(ElemTy);
  }

  // Load & Store {
  bool isLegalMaskedLoad(Type *DataType, MaybeAlign Alignment) {
    if (!enableVPU())
      return false;
    return isVectorLaneType(*GetLaneType(DataType));
  }
  bool isLegalMaskedStore(Type *DataType, MaybeAlign Alignment) {
    if (!enableVPU())
      return false;
    return isVectorLaneType(*GetLaneType(DataType));
  }
  bool isLegalMaskedGather(Type *DataType, MaybeAlign Alignment) {
    if (!enableVPU())
      return false;
    return isVectorLaneType(*GetLaneType(DataType));
  };
  bool isLegalMaskedScatter(Type *DataType, MaybeAlign Alignment) {
    if (!enableVPU())
      return false;
    return isVectorLaneType(*GetLaneType(DataType));
  }
  // } Load & Store

  /// Heuristics {
  /// \return The maximum interleave factor that any transform should try to
  /// perform for this target. This number depends on the level of parallelism
  /// and the number of execution units in the CPU.
  unsigned getMaxInterleaveFactor(unsigned VF) const {
    return 3; // 3 FMA units available
  }

  bool prefersVectorizedAddressing() { return true; }

  bool supportsEfficientVectorElementLoadStore() { return false; }

  unsigned getScalarizationOverhead(VectorType *Ty, const APInt &DemandedElts,
                                    bool Insert, bool Extract) const {
    auto VecTy = dyn_cast<FixedVectorType>(Ty);
    if (!VecTy)
      return 1;
    return VecTy->getNumElements();
  }

  unsigned getOperandsScalarizationOverhead(ArrayRef<const Value *> Args,
                                            unsigned VF) const {
    return Args.size() * VF;
  }

  unsigned getMemoryOpCost(unsigned Opcode, Type *Src, Align Alignment,
                           unsigned AddressSpace,
                           TargetTransformInfo::TargetCostKind CostKind,
                           const Instruction *I = nullptr) const {
    return getMaskedMemoryOpCost(Opcode, Src, Alignment, AddressSpace, CostKind);
  }

  unsigned getMaskedMemoryOpCost(unsigned Opcode, Type *Src, Align Alignment,
                                 unsigned AddressSpace,
                                 TargetTransformInfo::TargetCostKind CostKind) const {
    if (isa<VectorType>(*Src) && !isVectorLaneType(*Src)) {
      return GetVectorNumElements(Src);
    }
    return 1;
  }

  bool haveFastSqrt(Type *Ty) {
    // float, double or a vector thereof
    return Ty->isFPOrFPVectorTy() &&
           (isVectorLaneType(*Ty) || isVectorRegisterType(*Ty));
  }
  /// } Heuristics

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
    if (!enableVPU())
      return false;

    auto VPI = dyn_cast<VPIntrinsic>(&PredInst);
    if (!VPI)
      return true;

    // Cannot be widened into a legal VVP op
    auto EC = VPI->getStaticVectorLength();
    if (EC.isScalable())
      return false;

    if (EC.getFixedValue() > (hasPackedMode() ? 512 : 256))
      return false;

    // Bail on yet-unimplemented reductions
    if (VPI->isReductionOp()) {
      auto FPRed = dyn_cast<FPMathOperator>(VPI);
      bool Unordered = FPRed ? VPI->getFastMathFlags().allowReassoc() : true;
      return isSupportedReduction(VPI->getIntrinsicID(), Unordered);
    }

    switch (PredInst.getOpcode()) {
    default:
      break;

    // Unsupported ops (TODO native VP legalization)
    case Instruction::FPToUI:
    case Instruction::UIToFP:
      return false;

    // Non-opcode VP ops
    case Instruction::Call:
      // vp mask operations unsupported
      if (PredInst.isVectorReduction())
        return !PredInst.getType()->isIntOrIntVectorTy(1);
      break;

    // TODO mask scatter&gather
    // vp mask load/store unsupported (FIXME)
    case Instruction::Load:
      return !IsMaskType(PredInst.getType());

    case Instruction::Store:
      return !IsMaskType(PredInst.getOperand(0)->getType());

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
    if (!enableVPU())
      return true;

    auto FPRed = dyn_cast<FPMathOperator>(II);
    bool Unordered = FPRed ? II->getFastMathFlags().allowReassoc() : true;
    return !isSupportedReduction(II->getIntrinsicID(), Unordered);
  }
};

} // namespace llvm

#endif // LLVM_LIB_TARGET_VE_VETARGETTRANSFORMINFO_H
