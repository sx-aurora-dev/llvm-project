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
#include "llvm/IR/Type.h"

// Penalty cost factor to make vectorization unappealing (see
// makeVectorOpsExpensive).
static const unsigned ProhibitiveCost = 2048;

static llvm::Type *GetVectorElementType(llvm::Type *Ty) {
  return llvm::cast<llvm::FixedVectorType>(Ty)->getElementType();
}

static unsigned GetVectorNumElements(llvm::Type *Ty) {
  return llvm::cast<llvm::FixedVectorType>(Ty)->getNumElements();
}

static bool IsMaskType(llvm::Type *Ty) {
  return Ty->isVectorTy() &&
         GetVectorElementType(Ty)->getPrimitiveSizeInBits() == 1;
}

static llvm::Type *getVectorElementType(llvm::Type *Ty) {
  return llvm::cast<llvm::FixedVectorType>(Ty)->getElementType();
}

static llvm::Type *getLaneType(llvm::Type *Ty) {
  using namespace llvm;
  if (!isa<VectorType>(Ty))
    return Ty;
  return getVectorElementType(Ty);
}

static bool isVectorLaneType(llvm::Type &ElemTy) {
  // check element sizes for vregs
  if (ElemTy.isIntegerTy()) {
    unsigned ScaBits = ElemTy.getScalarSizeInBits();
    return ScaBits == 1 || ScaBits == 32 || ScaBits == 64;
  }
  if (ElemTy.isPointerTy()) {
    return true;
  }
  if (ElemTy.isFloatTy() || ElemTy.isDoubleTy()) {
    return true;
  }
  return false;
}

namespace llvm {

class VETTIImpl : public BasicTTIImplBase<VETTIImpl> {
  using BaseT = BasicTTIImplBase<VETTIImpl>;
  using TTI = TargetTransformInfo;
  friend BaseT;

  const VESubtarget *ST;
  const VETargetLowering *TLI;

  const VESubtarget *getST() const { return ST; }
  const VETargetLowering *getTLI() const { return TLI; }

  static bool makeVectorOpsExpensive();

  bool enableVPU() const { return getST()->enableVPU(); }

  static bool isSupportedReduction(Intrinsic::ID ReductionID, bool Unordered) {
#define VEC_VP_CASE(SUFFIX)                                                    \
  case Intrinsic::vp_reduce_##SUFFIX:                                          \
  case Intrinsic::vector_reduce_##SUFFIX:

    switch (ReductionID) {
      // FP
      VEC_VP_CASE(fadd)
      VEC_VP_CASE(fmin)
      VEC_VP_CASE(fmax)
      VEC_VP_CASE(fmul)
      return true;

      // Int
      VEC_VP_CASE(add)
      VEC_VP_CASE(and)
      VEC_VP_CASE(or)
      VEC_VP_CASE(xor)
      VEC_VP_CASE(smax)
      return true;

    default:
      // TODO: Support more reductions by isel-legalizing into existing ones (eg
      // smin -> smax, ..).
      return false;
    }
#undef VEC_VP_CASE
  }

public:
  explicit VETTIImpl(const VETargetMachine *TM, const Function &F)
      : BaseT(TM, F.getParent()->getDataLayout()), ST(TM->getSubtargetImpl(F)),
        TLI(ST->getTargetLowering()) {}

  unsigned getNumberOfRegisters(unsigned ClassID) const {
    bool VectorRegs = (ClassID == 1);
    if (!makeVectorOpsExpensive() && enableVPU() && VectorRegs) {
      return 64;
    }

    return 0;
  }

  TypeSize getRegisterBitWidth(TargetTransformInfo::RegisterKind K) const {
    switch (K) {
    case TargetTransformInfo::RGK_Scalar:
      return TypeSize::getFixed(64);
    case TargetTransformInfo::RGK_FixedWidthVector:
      // TODO report vregs once vector isel is stable.
      return makeVectorOpsExpensive()
                 ? TypeSize::getFixed(0)
                 : TypeSize::getFixed(StandardVectorWidth * 64);
    case TargetTransformInfo::RGK_ScalableVector:
      return TypeSize::getScalable(0);
    }

    llvm_unreachable("Unsupported register kind");
  }

  unsigned getMinVectorRegisterBitWidth() const {
    return !makeVectorOpsExpensive() && enableVPU()
               ? StandardVectorWidth * 64
               : 0;
  }

  static bool isBoolTy(Type *Ty) { return Ty->getPrimitiveSizeInBits() == 1; }

  unsigned getVRegCapacity(Type &ElemTy) const {
    if (ElemTy.isIntegerTy() && ElemTy.getPrimitiveSizeInBits() <= 32)
      return PackedVectorWidth;
    if (ElemTy.isFloatTy())
      return PackedVectorWidth;
    return StandardVectorWidth;
  }

  bool isBitVectorType(Type &DT) {
    auto VTy = dyn_cast<VectorType>(&DT);
    if (!VTy)
      return false;
    return isBoolTy(GetVectorElementType(VTy)) &&
           GetVectorNumElements(VTy) <=
               getVRegCapacity(*GetVectorElementType(VTy));
  }

  bool isVectorRegisterType(Type &DT) const {
    if (!enableVPU())
      return false;

    auto VTy = dyn_cast<VectorType>(&DT);
    if (!VTy)
      return false;
    auto &ElemTy = *GetVectorElementType(VTy);

    // Oversized vector.
    if (getVRegCapacity(ElemTy) < GetVectorNumElements(VTy))
      return false;

    return isVectorLaneType(ElemTy);
  }

  // Load & Store {
  bool isLegalMaskedLoad(Type *DataType, MaybeAlign Alignment) {
    if (!enableVPU())
      return false;
    return isVectorLaneType(*getLaneType(DataType));
  }
  bool isLegalMaskedStore(Type *DataType, MaybeAlign Alignment) {
    if (!enableVPU())
      return false;
    return isVectorLaneType(*getLaneType(DataType));
  }
  bool isLegalMaskedGather(Type *DataType, MaybeAlign Alignment) {
    if (!enableVPU())
      return false;
    return isVectorLaneType(*getLaneType(DataType));
  };
  bool isLegalMaskedScatter(Type *DataType, MaybeAlign Alignment) {
    if (!enableVPU())
      return false;
    return isVectorLaneType(*getLaneType(DataType));
  }
  // } Load & Store

  /// Heuristics {
  /// \return The maximum interleave factor that any transform should try to
  /// perform for this target. This number depends on the level of parallelism
  /// and the number of execution units in the CPU.
  unsigned getMaxInterleaveFactor(unsigned VF) const {
    // FIXME: Values > 1 trigger miscompiles (invalid BC generated)
    return 1;
  }

  bool prefersVectorizedAddressing() { return true; }

  bool supportsEfficientVectorElementLoadStore() { return false; }

  // Following implementation conflicts with dd2dbf7.
  // Also following code seems incorrect.  Therefore, removing them.
#if 0
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
#endif

  InstructionCost getMemoryOpCost(
      unsigned Opcode, Type *Src, Align Alignment, unsigned AddressSpace,
      TTI::TargetCostKind CostKind,
      TTI::OperandValueInfo OpInfo = {TTI::OK_AnyValue, TTI::OP_None},
      const Instruction *I = nullptr) const {
    return getMaskedMemoryOpCost(Opcode, Src, Alignment, AddressSpace,
                                 CostKind);
  }

  InstructionCost
  getGatherScatterOpCost(unsigned Opcode, Type *DataTy, const Value *Ptr,
                         bool VariableMask,
                         Align Alignment,
                         TTI::TargetCostKind CostKind,
                         const Instruction *I = nullptr) const {
    return getMaskedMemoryOpCost(Opcode, DataTy, Align(), 0, CostKind);
  }

  InstructionCost
  getMaskedMemoryOpCost(unsigned Opcode, Type *Src, Align Alignment,
                        unsigned AddressSpace,
                        TTI::TargetCostKind CostKind) const {
    if (isa<FixedVectorType>(Src) && (!isVectorRegisterType(*Src)))
      return ProhibitiveCost * GetVectorNumElements(Src);
    return 1;
  }

  bool haveFastSqrt(Type *Ty) {
    // float, double or a vector thereof
    return Ty->isFPOrFPVectorTy() && !makeVectorOpsExpensive() &&
           (isVectorLaneType(*Ty) || isVectorRegisterType(*Ty));
  }
  /// } Heuristics

  /// LLVM-VP Support
  /// {

  bool supportsScalableVectors() const { return false; }

  bool hasActiveVectorLength(unsigned Opcode, Type *DataType,
                             Align Alignment) const {
    return true;
  }

  TargetTransformInfo::VPLegalization
  getVPLegalizationStrategy(const VPIntrinsic &VPI) const {
    using VPTransform = TargetTransformInfo::VPLegalization;
    return TargetTransformInfo::VPLegalization(
        /* EVLParamStrategy */ VPTransform::Legal,
        /* OperatorStrategy */ supportsVPOperation(VPI) ? VPTransform::Legal
                                                       : VPTransform::Convert);
  }

  /// \returns False if this VP op should be replaced by a non-VP op or an
  /// unpredicated op plus a select.
  bool supportsVPOperation(const VPIntrinsic &VPI) const {
    if (!enableVPU())
      return false;

    // Cannot be widened into a legal VVP op
    auto EC = VPI.getStaticVectorLength();
    if (EC.isScalable())
      return false;

    if (EC.getFixedValue() > PackedVectorWidth)
      return false;

    // Bail on yet-unimplemented reductions
    if (isa<VPReductionIntrinsic>(VPI)) {
      auto FPRed = dyn_cast<FPMathOperator>(&VPI);
      bool Unordered = FPRed ? VPI.getFastMathFlags().allowReassoc() : true;
      return isSupportedReduction(VPI.getIntrinsicID(), Unordered);
    }

    std::optional<unsigned> OpCodeOpt = VPI.getFunctionalOpcode();
    unsigned OpCode = OpCodeOpt ? *OpCodeOpt : Instruction::Call;

    switch (OpCode) {
    default:
      break;

    // Unsupported ops (TODO native VP legalization)
    case Instruction::FPToUI:
    case Instruction::UIToFP:
      return false;

    // Non-opcode VP ops
    case Instruction::Call:
      // vp mask operations unsupported
      if (isa<VPReductionIntrinsic>(VPI))
        return !VPI.getType()->isIntOrIntVectorTy(1);
      break;

    // TODO mask scatter&gather
    // vp mask load/store unsupported (FIXME)
    case Instruction::Load:
      return !IsMaskType(VPI.getType());

    case Instruction::Store:
      return !IsMaskType(VPI.getOperand(0)->getType());

    // vp mask operations unsupported
    case Instruction::And:
    case Instruction::Or:
    case Instruction::Xor:
      auto ITy = VPI.getType();
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

  void getUnrollingPreferences(Loop *L, ScalarEvolution &,
                               TargetTransformInfo::UnrollingPreferences &UP,
                               OptimizationRemarkEmitter *ORE);

  bool shouldBuildRelLookupTables() const {
    // NEC nld doesn't support relative lookup tables.  It shows following
    // errors.  So, we disable it at the moment.
    //   /opt/nec/ve/bin/nld: src/CMakeFiles/cxxabi_shared.dir/cxa_demangle.cpp
    //   .o(.rodata+0x17b4): reloc against `.L.str.376': error 2
    //   /opt/nec/ve/bin/nld: final link failed: Nonrepresentable section on
    //   output
    return false;
  }

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
