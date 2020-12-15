//===-- VVPISelLowering.cpp - VE DAG Lowering Implementation --------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file implements the interfaces that VE uses to lower LLVM code into a
// selection DAG.
//
//===----------------------------------------------------------------------===//

#include "MCTargetDesc/VEMCExpr.h"
#include "VEISelLowering.h"
#include "VEInstrBuilder.h"
#include "VEMachineFunctionInfo.h"
#include "VERegisterInfo.h"
#include "VETargetMachine.h"
// #include "VETargetObjectFile.h"
#include "llvm/ADT/StringSwitch.h"
#include "llvm/CodeGen/CallingConvLower.h"
#include "llvm/CodeGen/MachineFrameInfo.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineJumpTableInfo.h"
#include "llvm/CodeGen/MachineModuleInfo.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/CodeGen/SelectionDAG.h"
#include "llvm/CodeGen/TargetLoweringObjectFileImpl.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Intrinsics.h"
#include "llvm/IR/IntrinsicsVE.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/KnownBits.h"

#include "CustomDAG.h"
#include "ShuffleSynthesis.h"

using namespace llvm;

static bool isLegalVectorVT(EVT VT) {
  if (!VT.isVector())
    return false;
  auto ElemVT = VT.getVectorElementType();
  return (ElemVT == MVT::i1 || ElemVT == MVT::i32 || ElemVT == MVT::f32 ||
          ElemVT == MVT::i64 || ElemVT == MVT::f64);
}

static bool isScalarOrWidenableVT(EVT VT) {
  if (!VT.isVector())
    return true;
  return isLegalVectorVT(VT);
}

/// \p returns Whether all operands are scalar or legaliz-able by widening
/// alone.
// Expansion to VVP implictly implement 'Widening' as its only legalization
// strategy. We fallback to whatever LLVM is doing otherwise.
static bool hasWidenableSourceVTs(SDNode &N) {
  for (unsigned i = 0; i < N.getNumOperands(); ++i) {
    EVT SourceVT = N.getOperand(i).getValueType();
    if (!isScalarOrWidenableVT(SourceVT))
      return false;
  }
  return true;
}

static bool shouldLowerToVVP(SDNode &N) {
  // Already a target node
  if (IsVVPOrVEC(N.getOpcode()))
    return false;

  // Do not VVP expand mask loads/stores
  // FIXME this leaves dangling VP mask stores if not properly legalized
  auto MemN = dyn_cast<MemSDNode>(&N);
  if (MemN && IsMaskType(MemN->getMemoryVT())) {
    return false;
  }

  Optional<EVT> IdiomVT = getIdiomaticType(&N);
  if (!IdiomVT.hasValue() || !isLegalVectorVT(*IdiomVT))
    return false;

  // Promote if the result type is not a legal vector
  EVT ResVT = N.getValueType(0);
  if (ResVT.isVector() && !isLegalVectorVT(ResVT)) {
    return false;
  }

  // Also promote if any operand type is illegal.
  return hasWidenableSourceVTs(N);
}

/// Whether this VVP node needs widening
static bool OpNeedsWidening(SDNode &Op) {
  // Do not widen operations that do not yield a vector value
  if (!Op.getValueType(0).isVector())
    return false;

  // Otw, widen this VVP operation to the native vector width
  Optional<EVT> OpVecTyOpt = getIdiomaticType(&Op);
  if (!OpVecTyOpt.hasValue() || !OpVecTyOpt->isVector())
    return false;
  EVT OpVecTy = OpVecTyOpt.getValue();

  unsigned OpVectorLength = OpVecTy.getVectorNumElements();
  assert((OpVectorLength <= PackedWidth) &&
         "Operation should have been split during legalization");
  return (OpVectorLength != StandardVectorWidth) &&
         (OpVectorLength != PackedWidth);
}

static bool isSETCC(unsigned OC) {
  switch (OC) {
  default:
    return false;
  case ISD::SETCC:
  case ISD::VP_SETCC:
  case VEISD::VVP_SETCC:
    return true;
  }
}

/// \returns the VVP_* SDNode opcode corresponsing to \p OC.
static Optional<unsigned> getVVPOpcode(unsigned OC) {
  switch (OC) {
#define ADD_VVP_OP(VVPNAME, SDNAME)                                            \
  case VEISD::VVPNAME:                                                         \
  case ISD::SDNAME:                                                            \
    return VEISD::VVPNAME;
#include "VVPNodes.def"
  }
  return None;
}

/// Load & Store Properties {
static SDValue getLoadStoreChain(SDValue Op) {
  if (Op->getOpcode() == VEISD::VVP_LOAD) {
    return Op->getOperand(0);
  }
  if (Op->getOpcode() == VEISD::VVP_STORE) {
    return Op->getOperand(0);
  }
  if (MemSDNode *MemN = dyn_cast<MemSDNode>(Op.getNode())) {
    return MemN->getChain();
  }
  if (Op->isVP()) {
    return Op->getOperand(0);
  }
  return SDValue();
}

static SDValue getLoadStorePtr(SDValue Op) {
  if (Op->getOpcode() == VEISD::VVP_LOAD) {
    return Op->getOperand(1);
  }
  if (Op->getOpcode() == VEISD::VVP_STORE) {
    return Op->getOperand(2);
  }
  if (auto *MemN = dyn_cast<MaskedLoadStoreSDNode>(Op.getNode())) {
    return MemN->getBasePtr();
  }
  if (auto *MemN = dyn_cast<VPLoadStoreSDNode>(Op.getNode())) {
    return MemN->getBasePtr();
  }
  if (auto *MemN = dyn_cast<MemSDNode>(Op.getNode())) {
    return MemN->getBasePtr();
  }
  return SDValue();
}

static EVT getMemoryDataVT(SDValue Op) {
  if (MemSDNode *MemN = dyn_cast<MemSDNode>(Op.getNode())) {
    return MemN->getMemoryVT();
  }
  abort();
}

static SDValue getStoreData(SDValue Op) {
  if (Op->getOpcode() == VEISD::VVP_STORE) {
    return Op->getOperand(1);
  }
  if (auto *StoreN = dyn_cast<StoreSDNode>(Op.getNode())) {
    return StoreN->getValue();
  }
  if (auto *StoreN = dyn_cast<MaskedStoreSDNode>(Op.getNode())) {
    return StoreN->getValue();
  }
  if (auto *StoreN = dyn_cast<VPStoreSDNode>(Op.getNode())) {
    return StoreN->getValue();
  }
  return SDValue();
}

static SDValue getLoadPassthru(SDValue Op) {
  if (MaskedLoadSDNode *MaskedN = dyn_cast<MaskedLoadSDNode>(Op.getNode())) {
    return MaskedN->getPassThru();
  }
  return SDValue();
}

static SDValue getLoadStoreMask(SDValue Op) {
  if (auto *MaskedN = dyn_cast<MaskedLoadStoreSDNode>(Op.getNode())) {
    return MaskedN->getMask();
  }
  if (auto *VPLoadN = dyn_cast<VPLoadStoreSDNode>(Op.getNode())) {
    return VPLoadN->getMask();
  }
  return SDValue();
}

static SDValue getLoadStoreAVL(SDValue Op) {
  if (auto *VPLoadN = dyn_cast<VPLoadStoreSDNode>(Op.getNode())) {
    return VPLoadN->getVectorLength();
  }
  return SDValue();
}

/// } Load & Store Properties

/// Gather & Scatter Properties {

static SDValue getGatherScatterMask(SDValue Op) {
  if (auto *MaskedN = dyn_cast<MaskedGatherScatterSDNode>(Op.getNode())) {
    return MaskedN->getMask();
  }
  if (auto *VPLoadN = dyn_cast<VPGatherScatterSDNode>(Op.getNode())) {
    return VPLoadN->getMask();
  }
  return SDValue();
}

/// } Gather & Scatter Properties

static SDValue getNodeMask(SDValue Op) {
  // load, store
  auto LSMask = getLoadStoreMask(Op);
  if (LSMask)
    return LSMask;

  // gather, scatter
  auto GSMask = getGatherScatterMask(Op);
  if (GSMask)
    return GSMask;

  // VP node?
  auto PosOpt = Op->getVPMaskPos();
  if (!PosOpt)
    return SDValue();
  return Op->getOperand(PosOpt.getValue());
}

static SDValue getNodeAVL(SDValue Op) {
  // This is only available for VP SDNodes
  auto PosOpt = Op->getVPVectorLenPos();
  if (!PosOpt)
    return SDValue();
  return Op->getOperand(PosOpt.getValue());
}

static SDValue getSplitPtrOffset(CustomDAG &CDAG, SDValue Ptr,
                                 uint64_t ElemBytes, PackElem Part) {
  if (Part == PackElem::Lo)
    return Ptr;
  return CDAG.getNode(ISD::ADD, MVT::i64,
                      {Ptr, CDAG.getConstant(ElemBytes, MVT::i64)});
}

static Optional<unsigned> GetVVPForVP(unsigned VPOC) {
  switch (VPOC) {
#define HANDLE_VP_TO_VVP(VP_ISD, VVP_VEISD)                                    \
  case ISD::VP_ISD:                                                            \
    return VEISD::VVP_VEISD;
#include "VVPNodes.def"

  default:
    return None;
  }
}

static SDValue PeekThroughCasts(SDValue Op) {
  switch (Op.getOpcode()) {
  default:
    return Op;

  case ISD::AssertSext:
  case ISD::AssertZext:
  case ISD::AssertAlign:
  case ISD::ANY_EXTEND:
  case ISD::ZERO_EXTEND:
  case ISD::SIGN_EXTEND:
  case ISD::TRUNCATE:
    return PeekThroughCasts(Op.getOperand(0));
  }
}

static SDValue PeekForMask(SDValue Op) {
  while (Op.getOpcode() == ISD::BITCAST) {
    Op = Op.getOperand(0);
  }

  if (IsMaskType(Op.getValueType()))
    return Op;
  return SDValue();
}

static SDValue fixUpOperation(SDValue Val, EVT LegalVT, CustomDAG &CDAG) {
  if (Val.getValueType() == LegalVT)
    return Val;

  // SelectionDAGBuilder does not respect TLI::getCCResultVT (do a fixup here)
  if (Val.getOpcode() == ISD::SETCC && Val.getValueType() == MVT::i1) {
    SDNode *N = Val.getNode();
    return CDAG.getNode(ISD::SETCC, LegalVT,
                        {N->getOperand(0), N->getOperand(1), N->getOperand(2)});
  }

  return SDValue();
}

static SDValue getSplatValue(SDNode *N) {
  if (auto *BuildVec = dyn_cast<BuildVectorSDNode>(N)) {
    return BuildVec->getSplatValue();
  }
  return SDValue();
}

void VETargetLowering::initVPUActions() {
  if (!Subtarget->enableVPU())
    return;

  // Vector length legalization
  auto LegalizeVectorLength = [&](unsigned VL) -> unsigned {
    if (this->Subtarget->hasPackedMode()) {
      return VL > StandardVectorWidth ? PackedWidth : StandardVectorWidth;
    } else {
      return StandardVectorWidth;
    }
  };

  // all builtin opcodes
  // auto AllOCs = llvm::make_range<unsigned>(1, ISD::BUILTIN_OP_END); // TODO
  // use this

  const ISD::NodeType END_OF_OCLIST = ISD::DELETED_NODE;

  // Unsupported vector ops (expand for all vector types)
  // This is most
  const ISD::NodeType AllExpandOCs[] = {
      // won't implement
      ISD::CONCAT_VECTORS, ISD::MERGE_VALUES,

      // not directly supported
      ISD::FNEG, ISD::FABS, ISD::FCBRT, ISD::FSIN, ISD::FCOS, ISD::FPOWI,
      ISD::FPOW, ISD::FLOG, ISD::FLOG2, ISD::FLOG10, ISD::FEXP, ISD::FEXP2,
      ISD::FCEIL, ISD::FTRUNC, ISD::FRINT, ISD::FNEARBYINT, ISD::FROUND,
      ISD::FFLOOR, ISD::LROUND, ISD::LLROUND, ISD::LRINT, ISD::LLRINT,

      // break down into SETCC + (V)SELECT
      ISD::SELECT_CC,
      ISD::ANY_EXTEND, // TODO sub-register insertion
      ISD::ANY_EXTEND_VECTOR_INREG,

      // TODO
      ISD::ROTL, ISD::ROTR, ISD::BSWAP, ISD::BITREVERSE, ISD::CTLZ,
      ISD::CTLZ_ZERO_UNDEF, ISD::CTTZ, ISD::CTTZ_ZERO_UNDEF, ISD::ADDC,
      ISD::ADDCARRY, ISD::MULHS, ISD::MULHU, ISD::SMUL_LOHI, ISD::UMUL_LOHI,

      // genuinely  unsupported
      ISD::FP_TO_UINT, ISD::UINT_TO_FP, ISD::UREM, ISD::SREM, ISD::SDIVREM,
      ISD::UDIVREM, ISD::FP16_TO_FP, ISD::FP_TO_FP16, END_OF_OCLIST};

  // FIXME should differentiate this..
  const ISD::NodeType AllLegalOCs[] = {ISD::BITCAST, END_OF_OCLIST};

  const ISD::NodeType AllCustomOCs[] = {ISD::SELECT, END_OF_OCLIST};

  // Memory vector ops
  const ISD::NodeType MemoryOCs[] = {// memory
                                     ISD::LOAD,     ISD::STORE, ISD::MGATHER,
                                     ISD::MSCATTER, ISD::MLOAD, ISD::MSTORE,
                                     END_OF_OCLIST};

  // vector construction operations
  const ISD::NodeType VectorTransformOCs[]{
      ISD::BUILD_VECTOR,
      // ISD::CONCAT_VECTORS, // always expanded
      ISD::EXTRACT_SUBVECTOR, ISD::INSERT_SUBVECTOR, ISD::SCALAR_TO_VECTOR,
      ISD::VECTOR_SHUFFLE, END_OF_OCLIST};

  // (Otw legal) Operations to promote to a larger vector element type (i8 and
  // i16 elems)
  const ISD::NodeType IntArithOCs[] = {
      // arithmetic
      ISD::ADD,  ISD::SUB,  ISD::MUL, ISD::SDIV, ISD::UDIV,
      ISD::SREM, ISD::UREM, ISD::AND, ISD::OR,   ISD::XOR,
      ISD::SDIV, ISD::SHL,  ISD::SRA, ISD::SRL,  END_OF_OCLIST};

  const ISD::NodeType FPArithOCs[] = {
      ISD::FMA,  ISD::FABS,      ISD::FSUB,     ISD::FDIV,    ISD::FMUL,
      ISD::FNEG, ISD::FP_EXTEND, ISD::FP_ROUND, END_OF_OCLIST};

  const ISD::NodeType ToIntCastOCs[] = {
      // casts
      ISD::TRUNCATE, ISD::SIGN_EXTEND_VECTOR_INREG,
      ISD::ZERO_EXTEND_VECTOR_INREG, ISD::FP_TO_SINT, END_OF_OCLIST};

  const ISD::NodeType ToFPCastOCs[] = {// casts
                                       ISD::FP_EXTEND, ISD::SINT_TO_FP,
                                       END_OF_OCLIST};

  //
  // reductions
  const ISD::NodeType IntReductionOCs[] = {
      ISD::VECREDUCE_ADD,  ISD::VECREDUCE_MUL,  ISD::VECREDUCE_AND,
      ISD::VECREDUCE_OR,   ISD::VECREDUCE_XOR,  ISD::VECREDUCE_SMIN,
      ISD::VECREDUCE_SMAX, ISD::VECREDUCE_UMIN, ISD::VECREDUCE_UMAX,
      END_OF_OCLIST};

  // reductions
  const ISD::NodeType FPReductionOCs[] = {
      ISD::VECREDUCE_FADD, ISD::VECREDUCE_FMUL, ISD::VECREDUCE_FMIN,
      ISD::VECREDUCE_FMAX, END_OF_OCLIST};

  // reductions
  const ISD::NodeType FPOrderedReductionOCs[] = {
      ISD::VECREDUCE_SEQ_FADD, ISD::VECREDUCE_SEQ_FMUL, END_OF_OCLIST};

  // Convenience Opcode loops
  auto ForAll_Opcodes = [](const ISD::NodeType *OCs,
                           std::function<void(unsigned)> Functor) {
    while (*OCs != END_OF_OCLIST) {
      Functor(*OCs);
      ++OCs;
    }
  };

  auto ForAll_setOperationAction = [&](const ISD::NodeType *OCs, MVT VT,
                                       LegalizeAction Act) {
    ForAll_Opcodes(OCs, [this, VT, Act](unsigned OC) {
      this->setOperationAction(OC, VT, Act);
    });
  };

  // Helpers for specifying trunc+store & load+ext legalization
  // expand all trunc/extend memory ops with this VALUE type
  auto ExpandMemory_TruncExtend_ToValue = [&](MVT ValVT) {
    for (MVT MemVT : MVT::vector_valuetypes()) {
      setTruncStoreAction(ValVT, MemVT, Expand);
      setLoadExtAction(ISD::SEXTLOAD, ValVT, MemVT, Expand);
      setLoadExtAction(ISD::ZEXTLOAD, ValVT, MemVT, Expand);
      setLoadExtAction(ISD::EXTLOAD, ValVT, MemVT, Expand);
    }
  };

  // expand all trunc/extend memory ops with this MEMORY type
  auto ExpandMemory_TruncExtend_ToMemory = [&](MVT MemVT) {
    for (MVT ValVT : MVT::vector_valuetypes()) {
      setTruncStoreAction(ValVT, MemVT, Expand);
      setLoadExtAction(ISD::SEXTLOAD, ValVT, MemVT, Expand);
      setLoadExtAction(ISD::ZEXTLOAD, ValVT, MemVT, Expand);
      setLoadExtAction(ISD::EXTLOAD, ValVT, MemVT, Expand);
    }
  };

  // The simple cases (always expand, custom or legal)
  for (MVT VT : MVT::vector_valuetypes()) {
    // expand all trunc+store, load+ext nodes
    ExpandMemory_TruncExtend_ToValue(VT);
    ExpandMemory_TruncExtend_ToMemory(VT);

    // Expand all operation on vector types on the list
    ForAll_setOperationAction(AllLegalOCs, VT, Legal);
    ForAll_setOperationAction(AllExpandOCs, VT, Expand);
    ForAll_setOperationAction(AllCustomOCs, VT, Custom);
  }

  // Short vector elements (EXCLUDING masks)
  for (MVT VT : MVT::vector_valuetypes()) {
    MVT ElemVT = VT.getVectorElementType();
    unsigned W = VT.getVectorNumElements();

    // Use default splitting for vlens > 512
    if (W > PackedWidth)
      continue;

    // Promotion rule, accept native element bit sizes
    unsigned ElemBits = ElemVT.getScalarSizeInBits();

    if ((ElemBits == 1) || (ElemBits >= 64))
      continue;

    ///// [32, 64) lane bits /////
    if (ElemBits >= 32) {
      // Directly select the legal promotion target
      MVT PromotedElemVT = ElemVT.isInteger() ? MVT::i64 : MVT::f64;
      MVT PromoteToVT =
          MVT::getVectorVT(PromotedElemVT, LegalizeVectorLength(W));

      setOperationPromotedToType(ISD::FP_TO_UINT, VT, PromoteToVT);
      setOperationPromotedToType(ISD::UINT_TO_FP, VT, PromoteToVT);
    }

    ///// (1 - 32) lane bits /////
    if (ElemBits >= 32)
      continue;

    {
      // Directly select the legal promotion target
      MVT PromotedElemVT = ElemVT.isInteger() ? MVT::i32 : MVT::f32;
      MVT PromoteToVT =
          MVT::getVectorVT(PromotedElemVT, LegalizeVectorLength(W));
      auto PromotionAction = [&](unsigned OC) {
        setOperationPromotedToType(OC, VT, PromoteToVT);
      };

      // fp16
      ForAll_Opcodes(FPArithOCs, PromotionAction);
      ForAll_Opcodes(FPReductionOCs, PromotionAction);
      ForAll_Opcodes(FPOrderedReductionOCs, PromotionAction);
      // i8, i16
      ForAll_Opcodes(IntArithOCs, PromotionAction);
      ForAll_Opcodes(IntReductionOCs, PromotionAction);
      ForAll_Opcodes(MemoryOCs, PromotionAction);
      ForAll_Opcodes(ToIntCastOCs, PromotionAction);
      ForAll_Opcodes(ToFPCastOCs, PromotionAction);
    }
  }

  for (unsigned OC : {ISD::INSERT_VECTOR_ELT, ISD::EXTRACT_VECTOR_ELT}) {
    setOperationAction(OC, MVT::v512i32, Custom);
    setOperationAction(OC, MVT::v512f32, Custom);
  }

  // All mask ops
  for (MVT MaskVT : MVT::vector_valuetypes()) {
    if (MaskVT.isScalableVector())
      continue;
    if (MaskVT.getVectorElementType() != MVT::i1)
      continue;

    // Mask producing operations
    setOperationAction(ISD::INSERT_VECTOR_ELT, MaskVT, Expand);
    setOperationAction(ISD::EXTRACT_VECTOR_ELT, MaskVT, Custom);

    // Lower to vvp_trunc
    setOperationAction(ISD::TRUNCATE, MaskVT, Custom);

    // Custom lower mask ops
    setOperationAction(ISD::STORE, MaskVT, Custom);
    setOperationAction(ISD::LOAD, MaskVT, Custom);

    ForAll_setOperationAction(IntReductionOCs, MaskVT, Custom);
    ForAll_setOperationAction(VectorTransformOCs, MaskVT, Custom);

    // Custom packed expansion
    if (MaskVT.getVectorElementCount().getFixedValue() > StandardVectorWidth) {
      setOperationAction(ISD::CONCAT_VECTORS, MaskVT, Custom);
    }
  }

  // vNt32, vNt64 ops (legal element types)
  for (MVT VT : MVT::vector_valuetypes()) {
    MVT ElemVT = VT.getVectorElementType();
    unsigned ElemBits = ElemVT.getScalarSizeInBits();
    if (ElemBits != 32 && ElemBits != 64)
      continue;

    ForAll_setOperationAction(VectorTransformOCs, VT, Custom);
    ForAll_setOperationAction(MemoryOCs, VT, Custom);

    // VE doesn't have instructions for fp<->uint, so expand them by llvm
    if (ElemBits == 64) {
      setOperationAction(ISD::FP_TO_UINT, VT, Expand);
      setOperationAction(ISD::UINT_TO_FP, VT, Expand);
    }

    // Translate all ops with legal element types to VVP_* nodes
#define ADD_VVP_OP(VVP_NAME, ISD_NAME)                                         \
  setOperationAction(ISD::ISD_NAME, VT, Custom);
#include "VVPNodes.def"
  }

  // X -> vp_* funnel
  for (MVT VT : MVT::vector_valuetypes()) {
    LegalizeAction Action;
    // FIXME query available vector width for this Op
    const unsigned WidthLimit = Subtarget->hasPackedMode() ? 512 : 256;
    if (isLegalVectorVT(VT) && VT.getVectorNumElements() <= WidthLimit) {
      // We perform custom widening as necessary
      Action = Custom;
    } else {
      // Cannot do custom element type legalization at this point
      Action = Expand;
    }

    // llvm.masked.* -> vvp lowering
    setOperationAction(ISD::MSCATTER, VT, Custom);
    setOperationAction(ISD::MGATHER, VT, Custom);
    setOperationAction(ISD::MLOAD, VT, Custom);
    setOperationAction(ISD::MSTORE, VT, Custom);

    // VP -> VVP lowering
#define BEGIN_REGISTER_VP_SDNODE(VP_NAME, LEGALPOS, VP_TEXT, MASK_POS,         \
                                 LEN_POS)                                      \
  setOperationAction(ISD::VP_NAME, VT, Action);
#include "llvm/IR/VPIntrinsics.def"
  }

  // Reduction ops are mapped with their result type
  for (MVT ResVT : {MVT::f64, MVT::f32, MVT::i64, MVT::i32}) {
#define ADD_REDUCE_VVP_OP(VVP_NAME, ISD_NAME)                                  \
  setOperationAction(ISD::ISD_NAME, ResVT, Custom);
#include "VVPNodes.def"
  }

  // CUSTOM HANDLERS FOR VECTOR INSTRUCTIONS
  // horizontal reductions
  setOperationAction(ISD::VECREDUCE_ADD, MVT::i32, Custom);
  setOperationAction(ISD::VECREDUCE_ADD, MVT::i64, Custom);

  setOperationAction(ISD::VECREDUCE_OR, MVT::i32, Custom);
  setOperationAction(ISD::VECREDUCE_OR, MVT::i64, Custom);

  // re-write vector setcc to use a predicate mask
  setOperationAction(ISD::SETCC, MVT::v256i64, Custom);
  setOperationAction(ISD::SETCC, MVT::v256i32, Custom);

  // truncate of X to i1 -> X
  // setOperationAction(ISD::TRUNCATE, MVT::v256i32, Custom); // should not
  // generate invalid valid SETCC in the first place
  setOperationAction(ISD::VSELECT, MVT::v256i1, Custom);
}

EVT VETargetLowering::LegalizeVectorType(EVT ResTy, SDValue Op,
                                         SelectionDAG &DAG,
                                         VVPExpansionMode Mode) const {

  if (!ResTy.isVector())
    return ResTy;

  if (Mode == VVPExpansionMode::ToNextWidth) {
    return getTypeToTransformTo(*DAG.getContext(), ResTy);
  }

  // Clamp to 256/512 depending on the mode
  assert(ResTy.isVector());
  unsigned TargetWidth = (Subtarget->hasPackedMode() &&
                          ResTy.getVectorNumElements() > StandardVectorWidth)
                             ? PackedWidth
                             : StandardVectorWidth;

  // Use vXi1 as result type in native widening mode
  bool UseBitElem = isSETCC(Op.getOpcode());
  EVT ElemVT = UseBitElem ? MVT::i1 : ResTy.getVectorElementType();

  return EVT::getVectorVT(*DAG.getContext(), ElemVT, TargetWidth);
}

// Legal result type - but illegal operand type
// FIXME Use this to ExpandTOVVP vector operation that do not yield a vector
// result
void VETargetLowering::LowerOperationWrapper(
    SDNode *N, SmallVectorImpl<SDValue> &Results, SelectionDAG &DAG,
    std::function<SDValue(SDValue)> WidenedOpCB) const {
  LLVM_DEBUG(dbgs() << "LowerOperationWrapper: "; N->dump(&DAG););

  // custom lowering only desired for VPU mode
  if (!Subtarget->enableVPU())
    return;

  // if the SDNode has a chain operator on the value output instead
  unsigned NumResults = N->getNumValues();
  assert(NumResults > 0);
  assert(NumResults <= 2);
  int ValIdx = NumResults - 1;

  // void/non-vector that needs lowering? -> expand to VVP
  if (!N->getValueType(0).isVector() && shouldLowerToVVP(*N)) {
    SDValue FixedOp =
        lowerToVVP(SDValue(N, 0), DAG, VVPExpansionMode::ToNativeWidth);
    N = FixedOp.getNode();
  } else if (!IsVVPOrVEC(N->getOpcode())) {
    LLVM_DEBUG(
        dbgs() << "\t Not a VP/VEC Op ->defaulting to standard expansion\n";);
    return;
  }

  // Expansion defer to LLVM for lowering
  if (!N) {
    LLVM_DEBUG(dbgs() << "\tDefault to standard expansion\n";);
    return;
  }

  // Legalize the operands of this VVP op
  unsigned NumOp = N->getNumOperands();
  std::vector<SDValue> FixedOperands;
  for (unsigned i = 0; i < NumOp; ++i) {
    SDValue Op = N->getOperand(i);

    SDValue FixedOp = Op;

    // SETCC

    // Re-use widened nodes from ReplaceNodeResult
    EVT OpDestVecTy =
        getTypeToTransformTo(*DAG.getContext(), Op.getValueType());

    if (OpDestVecTy != Op.getValueType()) {
      // run custom widenings first
      CustomDAG CDAG(*this, DAG, Op);
      FixedOp = fixUpOperation(Op, OpDestVecTy, CDAG);
      if (!FixedOp) {
        FixedOp = WidenedOpCB(Op);
      }
      assert(FixedOp && "No legal operand available!");
    }

    FixedOperands.push_back(FixedOp);
  }

  // Otw, clone the operation in every regard
  SDLoc DL(N);
  SDNode *NewN =
      DAG.getNode(N->getOpcode(), DL, N->getVTList(), FixedOperands).getNode();
  // assert((NewN->getNode() != N) && "node was not changed!");
  NewN->setFlags(N->getFlags());

  // Otw, fiddle the chain result back in
  if (NumResults == 2) {
    Results.push_back(SDValue(NewN, 0));
  }

  // attach the value output
  Results.push_back(SDValue(NewN, ValIdx));
}

// Illegal result type
void VETargetLowering::ReplaceNodeResults(SDNode *N,
                                          SmallVectorImpl<SDValue> &Results,
                                          SelectionDAG &DAG) const {

  LLVM_DEBUG(dbgs() << "ReplaceNodeResult: "; N->dump(&DAG););

  // custom lowering only desired for VPU mode
  if (!Subtarget->enableVPU())
    return;

  unsigned NumResults = N->getNumValues();
  assert(NumResults > 0);

  // recognized reductions
  if (N->getOpcode() == ISD::EXTRACT_VECTOR_ELT) {
    const ISD::NodeType RecognizedOCList[] = {ISD::ADD, ISD::MUL, ISD::OR,
                                              ISD::XOR, ISD::AND};

    ISD::NodeType RedOC;
    SDValue RedRootV = DAG.matchBinOpReduction(N, RedOC, RecognizedOCList);
    if (RedRootV) {
      LLVM_DEBUG(dbgs() << "Matched a shuffle reduction pattern!\n";);
    }
  }

  // if the SDNode has a chain operator on the value output instead
  assert(NumResults <= 2);
  int ValIdx = NumResults - 1;

  SDNode *ResN = nullptr;
  if (IsVVPOrVEC(N->getOpcode())) {
    // FIXME abort() here!!! must not create VVP ops with illegal result type!
    // VVP ops already have a legal result type
    ResN = WidenVVPOperation(SDValue(N, 0), DAG, VVPExpansionMode::ToNextWidth)
               .getNode();

  } else if (shouldLowerToVVP(*N)) {
    // Lower this to a VVP (or VEC_) op with the next expected result type
    ResN = lowerToVVP(SDValue(N, ValIdx), DAG, VVPExpansionMode::ToNextWidth)
               .getNode();
  } else {
    LLVM_DEBUG(dbgs() << "\tShould not widen to VVP\n";);
    // Otw, let LLVM do its expansion
    ResN = nullptr;
  }

  // Expansion defer to LLVM for lowering
  if (!ResN) {
    LLVM_DEBUG(dbgs() << "\tDefault to standard expansion\n";);
    return;
  }

  // Otw, fiddle the chain result back in
  if (NumResults == 2) {
    Results.push_back(SDValue(ResN, 0));
  }

  // attach the value output
  Results.push_back(SDValue(ResN, ValIdx));
}

VETargetLowering::LegalizeTypeAction
VETargetLowering::getPreferredVectorAction(MVT VT) const {
  if (!Subtarget->enableVPU())
    return TypeScalarizeVector;

  // The default action for one element vectors is to scalarize
  if (VT.getVectorNumElements() == 1)
    return TypeScalarizeVector;

  // Split oversized vectors
  if (VT.getVectorNumElements() > 512)
    return TypeSplitVector;

  // Promote short element vectors to i32
  if ((VT.getVectorElementType() != MVT::i1) && VT.isInteger() &&
      (VT.getVectorElementType().getSizeInBits() < 32))
    return TypePromoteInteger;

  // The default action for an odd-width vector is to widen.
  // This should also widen vNi1 vectors to v256i1/v512i1
  return TypeWidenVector;
}
SDValue VETargetLowering::lowerVVP_Bitcast(SDValue Op, SelectionDAG &DAG) const {
  if (Op.getSimpleValueType() == MVT::v256i64 &&
      Op.getOperand(0).getSimpleValueType() == MVT::v256f64) {
    LLVM_DEBUG(dbgs() << "Lowering bitcast of similar types.\n");
    return Op.getOperand(0);
  } else {
    return Op;
  }
}

SDValue VETargetLowering::lowerVVP_TRUNCATE(SDValue Op, SelectionDAG &DAG) const {
  LLVM_DEBUG(dbgs() << "Simplifying vector TRUNCATE\n");

  // eliminate redundant truncates of "i1"
  MVT Ty = Op.getSimpleValueType();
  if (!Ty.isVector())
    return Op;

  // not truncation bool
  MVT OpTy = Op.getOperand(0).getSimpleValueType();
  if (OpTy.getVectorElementType() != MVT::i1)
    return Op;

  // truncate $x to i1  ---> $x
  return Op.getOperand(0);
}
SDValue VETargetLowering::lowerVVP_BUILD_VECTOR(SDValue Op,
                                                SelectionDAG &DAG) const {
  SDLoc DL(Op);
  unsigned NumEls = Op.getValueType().getVectorNumElements();
  MVT ElemVT = Op.getSimpleValueType().getVectorElementType();

  if (SDValue ScalarV = getSplatValue(Op.getNode())) {
    // lower to VEC_BROADCAST
    MVT LegalResVT = MVT::getVectorVT(ElemVT, 256);

    auto AVL = DAG.getConstant(NumEls, DL, MVT::i32);
    return DAG.getNode(VEISD::VEC_BROADCAST, DL, LegalResVT, Op.getOperand(0),
                       AVL);
  }

  // Expand
  return SDValue();
}

SDValue VETargetLowering::expandSELECT(SDValue Op,
                                       SmallVectorImpl<SDValue> &LegalOperands,
                                       EVT LegalResVT, CustomDAG &CDAG,
                                       SDValue AVL) const {
  SDValue MaskV = LegalOperands[0];
  SDValue OnTrueV = LegalOperands[1];
  SDValue OnFalseV = LegalOperands[2];

  // Expand vNi1 selects into a boolean expression
  if (Op.getValueType().getVectorElementType() == MVT::i1) {
    auto NotMaskV = CDAG.createNot(MaskV, LegalResVT);

    return CDAG.getNode(
        ISD::OR, LegalResVT,
        {CDAG.getNode(ISD::AND, LegalResVT, {NotMaskV, OnFalseV}),
         CDAG.getNode(ISD::AND, LegalResVT, {MaskV, OnTrueV})});
  }

  // We need a boolean vector for the selection condition
  // If this is an ISD::SELECT, we need to broadcast the condition first
  SDValue CondVecV;

  EVT LegalMaskVT =
      CDAG.getVectorVT(MVT::i1, LegalResVT.getVectorNumElements());

  if (!MaskV.getValueType().isVector()) {
    CondVecV = CDAG.CreateBroadcast(LegalMaskVT, MaskV, AVL);
    CondVecV = CDAG.createMaskCast(CondVecV, AVL);
  } else {
    CondVecV = MaskV;
  }

  // Create a plain vector selection
  return CDAG.createSelect(LegalResVT, OnTrueV, OnFalseV, CondVecV, AVL);
}

SDValue
VETargetLowering::lowerSETCCInVectorArithmetic(SDValue Op,
                                               SelectionDAG &DAG) const {
  SDLoc dl(Op);
  LLVM_DEBUG(dbgs() << "Lowering SETCC Operands in Vector Arithmetic\n");

  // this only applies to vector yielding operations that are not v256i1
  EVT Ty = Op.getValueType();
  if (!Ty.isVector())
    return Op;
  if (Ty.getVectorElementType() == MVT::i1)
    return Op;

  // only create an integer expansion if requested to do so
  std::vector<SDValue> FixedOperandList;
  bool NeededExpansion = false;

  CustomDAG CDAG(*this, DAG, dl);

  for (size_t i = 0; i < Op->getNumOperands(); ++i) {
    // check whether this is an v256i1 SETCC
    auto Operand = Op->getOperand(i);
    if ((Operand->getOpcode() != ISD::SETCC) ||
        !IsMaskType(Operand.getSimpleValueType())) {
      FixedOperandList.push_back(Operand);
      continue;
    }

    EVT RawElemTy = Ty.getScalarType();
    assert(RawElemTy.isSimple());
    MVT ElemTy = RawElemTy.getSimpleVT();

    // materialize an integer expansion
    // vselect (MaskReplacement, VEC_BROADCAST(1), VEC_BROADCAST(0))
    auto ConstZero = DAG.getConstant(0, dl, ElemTy);
    auto ZeroBroadcast = CDAG.CreateBroadcast(Ty, ConstZero);

    auto ConstOne = DAG.getConstant(1, dl, ElemTy);
    auto OneBroadcast = CDAG.CreateBroadcast(Ty, ConstOne);

    auto Expanded = DAG.getSelect(dl, Ty, Operand, OneBroadcast, ZeroBroadcast);
    FixedOperandList.push_back(Expanded);
    NeededExpansion = true;
  }

  if (!NeededExpansion)
    return Op;

  // re-materialize the operator
  return DAG.getNode(Op.getOpcode(), dl, Op.getSimpleValueType(),
                     FixedOperandList);
}

SDValue
VETargetLowering::lowerVVP_SCALAR_TO_VECTOR(SDValue Op, SelectionDAG &DAG,
                                            VVPExpansionMode Mode,
                                            VecLenOpt VecLenHint) const {
  SDLoc DL(Op);

  EVT ResTy = Op.getValueType();
  CustomDAG CDAG(*this, DAG, Op);
  EVT NativeResTy = CDAG.legalizeVectorType(Op, Mode);

  // FIXME
  Optional<SDValue> OptVL = EVLToVal(
      MinVectorLength(ResTy.getVectorNumElements(), VecLenHint), DL, DAG);

  return CDAG.CreateBroadcast(NativeResTy, Op.getOperand(0), OptVL);
}

TargetLowering::LegalizeAction
VETargetLowering::getActionForExtendedType(unsigned Op, EVT VT) const {
  switch (Op) {
#define ADD_VVP_OP(VVP_NAME, ISD_NAME)                                         \
  case ISD::ISD_NAME:                                                          \
  case VEISD::VVP_NAME:
#include "VVPNodes.def"
    return Custom;
  default:
    return Expand;
  }
}

TargetLowering::LegalizeAction
VETargetLowering::getCustomOperationAction(SDNode &Op) const {
  // Always custom-lower VEC_NARROW to eliminate it
  if (Op.getOpcode() == VEISD::VEC_NARROW)
    return Custom;
  // Otw, only custom lower to perform due widening
  if (IsVVPOrVEC(Op.getOpcode()) && OpNeedsWidening(Op))
    return Custom;
  return Legal;
}

SDValue VETargetLowering::ExpandToSplitLoadStore(SDValue Op, SelectionDAG &DAG,
                                                 VVPExpansionMode Mode) const {
  LLVM_DEBUG(dbgs() << "ExpandToSplitLoadStore: "; Op->print(dbgs());
             dbgs() << "\n");
  auto OcOpt = GetVVPOpcode(Op.getOpcode());
  assert(OcOpt.hasValue());
  unsigned VVPOC = OcOpt.getValue();
  assert((VVPOC == VEISD::VVP_LOAD) || (VVPOC == VEISD::VVP_STORE));

  CustomDAG CDAG(*this, DAG, Op);

  VVPWideningInfo WidenInfo = pickResultType(CDAG, Op, Mode);

  EVT DataVT = getMemoryDataVT(Op);
  EVT ResVT = CDAG.getSplitVT(DataVT);

  SDValue Passthru = getLoadPassthru(Op);

  // analyze the operation
  SDValue PackedMask = getNodeMask(Op);
  SDValue PackedAVL = getNodeAVL(Op);
  SDValue PackData = getStoreData(Op);

  unsigned ChainResIdx = PackData ? 0 : 1;

  // Stride info
  // EVT DataVT = LegalizeVectorType(getMemoryDataVT(Op), Op, DAG, Mode);
  uint64_t ElemBytes =
      getMemoryDataVT(Op).getVectorElementType().getStoreSize();

  // request the parts
  SDValue PartOps[2];

  SDValue UpperPartAVL; // we will use this for packing things back together
  for (PackElem Part : {PackElem::Lo, PackElem::Hi}) {
    // VP ops already have an explicit mask and AVL. When expanding from non-VP
    // attach those additional inputs here.
    auto SplitTM =
        CDAG.createTargetSplitMask(WidenInfo, PackedMask, PackedAVL, Part);

    if (Part == PackElem::Hi) {
      UpperPartAVL = SplitTM.AVL;
    }

    // Attach non-predicating value operands
    SmallVector<SDValue, 4> OpVec;

    // Chain
    OpVec.push_back(getLoadStoreChain(Op));

    // Data
    if (PackData) {
      SDValue PartData = CDAG.extractPackElem(PackData, Part, SplitTM.AVL);
      OpVec.push_back(PartData);
    }

    // Ptr & Stride
    // Push (ptr + ElemBytes * <Part>, 2 * ElemBytes)
    SDValue PackPtr = getLoadStorePtr(Op);
    OpVec.push_back(getSplitPtrOffset(CDAG, PackPtr, ElemBytes, Part));
    OpVec.push_back(CDAG.getConstant(2 * ElemBytes, MVT::i64));

    // add predicating args and generate part node
    OpVec.push_back(SplitTM.Mask);
    OpVec.push_back(SplitTM.AVL);

    if (PackData) {
      // store
      PartOps[(int)Part] = CDAG.getNode(VVPOC, MVT::Other, OpVec);
    } else {
      // load
      PartOps[(int)Part] = CDAG.getNode(VVPOC, {ResVT, MVT::Other}, OpVec);
    }
  }

  // merge the chains
  SDValue LowChain = SDValue(PartOps[(int)PackElem::Lo].getNode(), ChainResIdx);
  SDValue HiChain = SDValue(PartOps[(int)PackElem::Hi].getNode(), ChainResIdx);
  SmallVector<SDValue, 2> ChainVec({LowChain, HiChain});
  SDValue FusedChains = DAG.getTokenFactor(CDAG.DL, ChainVec);

  // Chain only [store]
  if (PackData) {
    return FusedChains;
  }

  // re-pack into full packed vector result
  EVT PackedVT = CDAG.legalizeVectorType(Op, Mode);
  SDValue PackedVals =
      CDAG.CreatePack(PackedVT, PartOps[(int)PackElem::Lo],
                      PartOps[(int)PackElem::Hi], UpperPartAVL);

  // Put the passthru back in
  if (Passthru) {
    PackedVals = CDAG.createSelect(PackedVT, PackedVals, Passthru, PackedMask,
                                   UpperPartAVL);
  }

  return CDAG.getMergeValues({PackedVals, FusedChains});
}

SDValue VETargetLowering::ExpandToSplitReduction(SDValue Op, SelectionDAG &DAG,
                                                 VVPExpansionMode Mode) const {
  abort();
}

SDValue VETargetLowering::ExpandToSplitVVP(SDValue Op, SelectionDAG &DAG,
                                           VVPExpansionMode Mode) const {
  LLVM_DEBUG(dbgs() << "ExpandToSplitVVP: "; Op->print(dbgs()); dbgs() << "\n");
  auto OcOpt = GetVVPOpcode(Op.getOpcode());
  assert(OcOpt.hasValue());
  unsigned VVPOC = OcOpt.getValue();

  CustomDAG CDAG(*this, DAG, Op);

  // Special cases ('impure' SIMD instructions)
  if (IsVVPReduction(VVPOC)) {
    return ExpandToSplitReduction(Op, DAG, Mode);
  } else if (VVPOC == VEISD::VVP_LOAD || VVPOC == VEISD::VVP_STORE) {
    return ExpandToSplitLoadStore(Op, DAG, Mode);
  }

  EVT ResVT = CDAG.getSplitVT(Op.getValue(0).getValueType());

  // analyze the operation
  VVPWideningInfo WidenInfo = pickResultType(CDAG, Op, Mode);
  SDValue PackedMask = getNodeMask(Op);
  SDValue PackedAVL = getNodeAVL(Op);

  // request the parts
  SDValue PartOps[2];

  bool HasChain = false;
  SDValue UpperPartAVL; // we will use this for packing things back together
  for (PackElem Part : {PackElem::Lo, PackElem::Hi}) {
    // VP ops already have an explicit mask and AVL. When expanding from non-VP
    // attach those additional inputs here.
    auto SplitTM =
        CDAG.createTargetSplitMask(WidenInfo, PackedMask, PackedAVL, Part);

    if (Part == PackElem::Hi) {
      UpperPartAVL = SplitTM.AVL;
    }

    // Attach non-predicating value operands
    SmallVector<SDValue, 4> OpVec;
    for (unsigned i = 0; i < Op.getNumOperands(); ++i) {
      SDValue OpV = Op.getOperand(i);

      if (OpV == PackedAVL)
        continue;
      if (OpV == PackedMask)
        continue;

      if (OpV.getValueType() == MVT::Other) {
        // Chain operand
        HasChain = true;
        OpVec.push_back(OpV);
      } else {
        // Value operand
        SDValue PartV =
            CDAG.extractPackElem(Op.getOperand(i), Part, SplitTM.AVL);
        OpVec.push_back(PartV);
      }
    }

    // add predicating args and generate part node
    OpVec.push_back(SplitTM.Mask);
    OpVec.push_back(SplitTM.AVL);
    PartOps[(int)Part] = CDAG.getNode(VVPOC, ResVT, OpVec);
  }

  // re-package into a proper packed operation
  EVT PackedVT = CDAG.legalizeVectorType(Op, Mode);
  SDValue PackedVals =
      CDAG.CreatePack(PackedVT, PartOps[(int)PackElem::Lo],
                      PartOps[(int)PackElem::Hi], UpperPartAVL);

  // Value only node
  if (!HasChain) {
    return PackedVals;
  }

  // merge the chains
  SDValue LowChain = PartOps[(int)PackElem::Lo].getValue(1);
  SDValue HiChain = PartOps[(int)PackElem::Hi].getValue(1);
  SmallVector<SDValue, 2> ChainVec({LowChain, HiChain});
  SDValue FusedChains = DAG.getTokenFactor(CDAG.DL, ChainVec);
  return CDAG.getMergeValues({PackedVals, FusedChains});
}

VVPWideningInfo VETargetLowering::pickResultType(CustomDAG &CDAG, SDValue Op,
                                                 VVPExpansionMode Mode) const {
  Optional<EVT> VecVTOpt = getIdiomaticType(Op.getNode());
  if (!VecVTOpt.hasValue() || !VecVTOpt.getValue().isVector()) {
    LLVM_DEBUG(dbgs() << "\tno idiomatic vector VT.\n");
    return VVPWideningInfo();
  }
  EVT OpVecVT = VecVTOpt.getValue();

  // try to narrow the vector length
  Optional<unsigned> NarrowLen = PeekForNarrow(Op);
  unsigned OpVectorLength =
      NarrowLen ? NarrowLen.getValue() : OpVecVT.getVectorNumElements();

  LLVM_DEBUG(dbgs() << "\tdetected AVL:" << OpVectorLength << "\n";);

  // Select the target vector width
  unsigned VectorWidth;
  if (OpVectorLength > StandardVectorWidth) {
    // packed mode only available for 32bit elements up to 512 elements
    EVT RawElemTy = OpVecVT.getVectorElementType();
    if (!RawElemTy.isSimple()) {
      LLVM_DEBUG(dbgs() << "\tToNative: Not a simple element type\n";);
      return VVPWideningInfo();
    }
    MVT ElemTy = RawElemTy.getSimpleVT();

    if ((ElemTy != MVT::i32 && ElemTy != MVT::f32) ||
        (OpVectorLength > PackedWidth)) {
      LLVM_DEBUG(dbgs() << "\tToNative: Over-sized data type\n";);
      return VVPWideningInfo();
    }

    VectorWidth = PackedWidth;
  } else {
    VectorWidth = StandardVectorWidth;
  }

  // Pick a legal vector type
  EVT ResultVT;
  if (Mode == VVPExpansionMode::ToNativeWidth) {
    LLVM_DEBUG(dbgs() << "\texpanding to native width\n";);

    ResultVT = EVT::getVectorVT(CDAG.getContext(),
                                OpVecVT.getVectorElementType(), VectorWidth);

  } else if (Mode == VVPExpansionMode::ToNextWidth) {
    LLVM_DEBUG(dbgs() << "\texpanding to next width\n";);

    ResultVT = getTypeToTransformTo(CDAG.getContext(), OpVecVT);
  }

  LLVM_DEBUG(dbgs() << "\tOpVecTy: " << OpVecVT.getEVTString() << "\n";);
  LLVM_DEBUG(dbgs() << "\tNextTy: " << ResultVT.getEVTString() << "\n";);

  VectorWidth = ResultVT.getVectorNumElements();
  assert((ResultVT.getVectorElementType() == OpVecVT.getVectorElementType()) &&
         "unexpected change of element type!");

  // bail if LLVM decides to split
  if (!ResultVT.isVector() ||
      (ResultVT.getVectorNumElements() < OpVecVT.getVectorNumElements())) {
    LLVM_DEBUG(dbgs() << "\tLLVM decided to split\n";);
    return VVPWideningInfo();
  }

  //// Does this expansion imply packed mode? /////
  LLVM_DEBUG(dbgs() << "\tSelected target width: " << VectorWidth << "\n";);
  bool PackedMode = false;
  bool NeedsPackedMasking = false;
  if (VectorWidth > StandardVectorWidth) {
    NeedsPackedMasking = (OpVectorLength % 2 != 0);
    PackedMode = true;
    if (!Subtarget->hasPackedMode()) {
      LLVM_DEBUG(dbgs() << "\tPacked operations not enabled (set "
                           "-mattr=+packed to enable)!\n";);
      return VVPWideningInfo(); // possibly redundant
    }
  }

  // Does this operation have a dynamic AVL?
  NeedsPackedMasking |= PackedMode && (bool)getNodeAVL(Op);

  return VVPWideningInfo(ResultVT, OpVectorLength, PackedMode,
                         NeedsPackedMasking);
}

SDValue VETargetLowering::lowerToVVP(SDValue Op, SelectionDAG &DAG,
                                     VVPExpansionMode Mode) const {
  LLVM_DEBUG(dbgs() << "Expand to VVP node\n");

  Optional<EVT> OpVecTyOpt = getIdiomaticType(Op.getNode());
  EVT OpVecTy = OpVecTyOpt.getValue();

  if (!OpVecTyOpt.hasValue()) {
    LLVM_DEBUG(dbgs() << "LowerToVVP: cannot infer idiomatic vector type\n");
    return SDValue();
  }

  // not a vector operation // TODO adjust for reductions
  if (!OpVecTy.isVector()) {
    LLVM_DEBUG(dbgs() << "LowerToVVP: not a vector operation\n");
    return SDValue();
  }

  // VP -> VVP expansion
  if (Op->isVP()) {
    return lowerVPToVVP(Op, DAG, Mode);
  }

  ///// Decide for a vector width /////
  // This also takes care of splitting
  // TODO improve packed matching logic
  // Switch to packed mode (TODO where appropriate)
  CustomDAG CDAG(*this, DAG, Op);
  VVPWideningInfo WidenInfo = pickResultType(CDAG, Op, Mode);

  if (!WidenInfo.isValid()) {
    LLVM_DEBUG(dbgs() << "Cannot derive widening info\n";);
    return SDValue();
  }

  ///// Translate to a VVP layer operation (VVP_* or VEC_*) /////
  bool isTernaryOp = false;
  bool isBinaryOp = false;
  bool isUnaryOp = false;
  bool isConvOp = false;
  bool isReduceOp = false;

  switch (Op->getOpcode()) {
  default:
    return SDValue(); // default on this node

  case ISD::BUILD_VECTOR:
  case ISD::VECTOR_SHUFFLE:
    return lowerVectorShuffleOp(Op, DAG, Mode);

  case ISD::EXTRACT_SUBVECTOR:
    return lowerVVP_EXTRACT_SUBVECTOR(Op, DAG, Mode);
  case ISD::SCALAR_TO_VECTOR:
    return lowerVVP_SCALAR_TO_VECTOR(Op, DAG, Mode);

  case ISD::LOAD:
  case ISD::MLOAD:
    return lowerVVP_MLOAD(Op, DAG, Mode);

  case ISD::STORE:
  case ISD::MSTORE:
    return lowerVVP_MSTORE(Op, DAG);

  case ISD::MGATHER:
  case ISD::MSCATTER:
    return lowerVVP_MGATHER_MSCATTER(Op, DAG, Mode);

  case ISD::SELECT:
    isTernaryOp = true;
    break;

#define ADD_UNARY_VVP_OP(VVP_NAME, NATIVE_ISD)                                 \
  case ISD::NATIVE_ISD:                                                        \
    isUnaryOp = true;                                                          \
    break;
#define ADD_BINARY_VVP_OP(VVP_NAME, NATIVE_ISD)                                \
  case ISD::NATIVE_ISD:                                                        \
    isBinaryOp = true;                                                         \
    break;
#define ADD_TERNARY_VVP_OP(VVP_NAME, NATIVE_ISD)                               \
  case ISD::NATIVE_ISD:                                                        \
    isTernaryOp = true;                                                        \
    break;

#define ADD_ICONV_VVP_OP(VVP_NAME, NATIVE_ISD)                                 \
  case ISD::NATIVE_ISD:                                                        \
    isConvOp = true;                                                           \
    break;
#define ADD_FPCONV_VVP_OP(VVP_NAME, NATIVE_ISD)                                \
  case ISD::NATIVE_ISD:                                                        \
    isConvOp = true;                                                           \
    break;

#define ADD_REDUCE_VVP_OP(VVP_NAME, NATIVE_ISD)                                \
  case ISD::NATIVE_ISD:                                                        \
    isReduceOp = true;                                                         \
    break;
#include "VVPNodes.def"
  }

  // Select VVP Op
  Optional<unsigned> VVPOC = GetVVPOpcode(Op.getOpcode());
  assert(VVPOC.hasValue() &&
         "TODO implement this operation in the VVP isel layer");

  // Is packed mode an option for this OC?
  if (WidenInfo.PackedMode && !SupportsPackedMode(VVPOC.getValue())) {
    return ExpandToSplitVVP(Op, DAG, Mode);
  }

  // Generate a mask and an AVL
  auto TargetMasks = CDAG.createTargetMask(WidenInfo, SDValue(), SDValue());

  ///// Widen the actual result type /////
  // FIXME We cannot use the idiomatic type here since that type reflects the
  // operatino vector width (and the element type does not matter as much).
  EVT ResVecTy = CDAG.legalizeVectorType(Op, Mode);

  // legalize all operands
  SmallVector<SDValue, 4> LegalOperands;
  for (unsigned i = 0; i < Op->getNumOperands(); ++i) {
    LegalOperands.push_back(LegalizeVecOperand(Op->getOperand(i), DAG));
  }

  if (isUnaryOp) {
    assert(VVPOC.hasValue());
    return CDAG.getNode(VVPOC.getValue(), ResVecTy,
                        {LegalOperands[0], TargetMasks.Mask, TargetMasks.AVL});
  }

  if (isBinaryOp) {
    assert(VVPOC.hasValue());
    return CDAG.getNode(VVPOC.getValue(), ResVecTy,
                        {LegalOperands[0], LegalOperands[1], TargetMasks.Mask,
                         TargetMasks.AVL});
  }

  if (isTernaryOp) {
    assert(VVPOC.hasValue());
    switch (VVPOC.getValue()) {
    case VEISD::VVP_FFMA: {
      // VE has a swizzled operand order in FMA (compared to LLVM IR and
      // SDNodes).
      return CDAG.getNode(VVPOC.getValue(), ResVecTy,
                          {LegalOperands[2], LegalOperands[0], LegalOperands[1],
                           TargetMasks.Mask, TargetMasks.AVL});
    }
    case VEISD::VVP_SETCC: {
      return CDAG.getNode(VVPOC.getValue(), ResVecTy,
                          {LegalOperands[0], LegalOperands[1], LegalOperands[2],
                           TargetMasks.Mask, TargetMasks.AVL});
    }
    case VEISD::VVP_SELECT: {
      return expandSELECT(Op, LegalOperands, ResVecTy, CDAG, TargetMasks.AVL);
    }
    default:
      llvm_unreachable("Unexpected ternary operator!");
    }
  }

  if (isConvOp) {
    return CDAG.getNode(VVPOC.getValue(), ResVecTy,
                        {LegalOperands[0], TargetMasks.Mask, TargetMasks.AVL});
  }

  if (isReduceOp) {
    // FIXME
    // SDValue Attempt = LowerVECREDUCE(Op, DAG);
    // if (Attempt)
    //  return Attempt;

    auto PosOpt = getVVPReductionStartParamPos(VVPOC.getValue());
    if (PosOpt) {
      return CDAG.getNode(VVPOC.getValue(), ResVecTy,
                          {LegalOperands[0], LegalOperands[1], TargetMasks.Mask,
                           TargetMasks.AVL});
    }

    return CDAG.getNode(VVPOC.getValue(), ResVecTy,
                        {LegalOperands[0], TargetMasks.Mask, TargetMasks.AVL});
  }

  llvm_unreachable("Cannot lower this op to VVP");

  abort(); // TODO implement
}

SDValue VETargetLowering::WidenVVPOperation(SDValue Op, SelectionDAG &DAG,
                                            VVPExpansionMode Mode) const {
  LLVM_DEBUG(dbgs() << "Widen this VVP operation\n");

  // Expand this directly to the right VVP node
  // assert (IsVVP(Op.getOpcode()));

  if (!Op.getValueType().isVector()) {
    LLVM_DEBUG(dbgs() << "\tdoes not produce a vector result (FIXME)\n");
    return Op;
  }

  // Otw, widen this VVP operation to the next OR native vector width
  Optional<EVT> OpVecTyOpt = getIdiomaticType(Op.getNode());
  assert(OpVecTyOpt.hasValue());
  EVT OpVecTy = OpVecTyOpt.getValue();

  EVT NewResultType;

  if (Mode == VVPExpansionMode::ToNativeWidth) {
    // Determine a reasonable VL for this op
    Optional<unsigned> NarrowLen = PeekForNarrow(Op);
    unsigned OpVectorLength =
        NarrowLen ? NarrowLen.getValue() : OpVecTy.getVectorNumElements();

    assert((OpVectorLength <= PackedWidth) &&
           "Operation should have been split during legalization");

    unsigned VectorWidth = (OpVectorLength > StandardVectorWidth)
                               ? PackedWidth
                               : StandardVectorWidth;

    // result type fixup for SETCC
    if (Op.getOpcode() == VEISD::VVP_SETCC) {
      // VVP_SETCC has to return vXi1
      NewResultType = MVT::getVectorVT(MVT::i1, VectorWidth);
    } else {
      // Otw, simply widen the result vector
      NewResultType = MVT::getVectorVT(
          OpVecTy.getVectorElementType().getSimpleVT(), VectorWidth);
    }
  } else {
    // Simply go for the next requested type
    NewResultType = getTypeToTransformTo(*DAG.getContext(), Op.getValueType());
  }

  // Copy the operand list
  unsigned NumOp = Op->getNumOperands();
  std::vector<SDValue> FixedOperands;
  for (unsigned i = 0; i < NumOp; ++i) {
    SDValue OpVal = Op->getOperand(i);
    FixedOperands.push_back(OpVal);
  }

  // Otw, clone the operation in every regard
  SDLoc DL(Op);
  SDValue NewN = DAG.getNode(Op->getOpcode(), DL, NewResultType, FixedOperands);
  // assert((NewN->getNode() != N) && "node was not changed!");
  NewN->setFlags(Op->getFlags());
  return NewN;
}

SDValue VETargetLowering::lowerVVP_MGATHER_MSCATTER(SDValue Op, SelectionDAG &DAG,
                                                VVPExpansionMode Mode,
                                                VecLenOpt VecLenHint) const {
  LLVM_DEBUG(dbgs() << "Lowering MGATHER or MSCATTER\n");
  // dbgs() << "\nNext Instr:\n";
  // Op.dumpr(&DAG);

  Optional<EVT> OpVecTyOpt = getIdiomaticType(Op.getNode());
  EVT OpVecTy = OpVecTyOpt.getValue();

  CustomDAG CDAG(*this, DAG, Op);
  auto MemN = cast<MemSDNode>(Op.getNode());
  EVT LegalResVT = LegalizeVectorType(MemN->getMemoryVT(), Op, DAG, Mode);

  SDValue OpVectorLength;
  SDValue Index;
  SDValue BasePtr;
  SDValue Mask;
  SDValue Chain;
  SDValue Scale;
  SDValue PassThru;
  SDValue Source;

  if (Op.getOpcode() == ISD::MGATHER || Op.getOpcode() == ISD::MSCATTER) {
    MaskedGatherScatterSDNode *N =
        cast<MaskedGatherScatterSDNode>(Op.getNode());

    OpVectorLength = CDAG.getConstant(OpVecTy.getVectorNumElements(), MVT::i32);
    Index = N->getIndex();
    BasePtr = N->getBasePtr();
    Mask = N->getMask();
    Chain = N->getChain();
    Scale = N->getScale();
  } else if (Op.getOpcode() == ISD::VP_GATHER ||
             Op.getOpcode() == ISD::VP_SCATTER) {
    VPGatherScatterSDNode *N = cast<VPGatherScatterSDNode>(Op.getNode());

    OpVectorLength = N->getVectorLength(); // TODO packed mode legalization!!!!
    Index = N->getIndex();
    BasePtr = N->getBasePtr();
    Mask = N->getMask();
    Chain = N->getChain();
    Scale = N->getScale();
  } else {
    llvm_unreachable("Unexpected SDNode in lowering function");
  }

  if (Op.getOpcode() == ISD::MGATHER) {
    MaskedGatherSDNode *N = cast<MaskedGatherSDNode>(Op.getNode());
    PassThru = N->getPassThru();
  } else if (Op.getOpcode() == ISD::MSCATTER) {
    MaskedScatterSDNode *N = cast<MaskedScatterSDNode>(Op.getNode());
    Source = N->getValue();
  } else if (Op.getOpcode() == ISD::VP_GATHER) {
    PassThru = CDAG.DAG.getUNDEF(Op.getValueType());
  } else if (Op.getOpcode() == ISD::VP_SCATTER) {
    VPScatterSDNode *N = cast<VPScatterSDNode>(Op.getNode());
    Source = N->getValue();
  }

  // Legalize the index type
  EVT IndexVT = CDAG.getVectorVT(Index.getValueType().getVectorElementType(),
                                 LegalResVT.getVectorNumElements());

  // Widen the index
  Index = CDAG.widenOrNarrow(IndexVT, Index);

  // apply scale
  SDValue ScaledIndex;
  if (isOneConstant(Scale)) {
    ScaledIndex = Index;
  } else {
    SDValue ScaleBroadcast =
        CDAG.CreateBroadcast(IndexVT, Scale, OpVectorLength);
    ScaledIndex = CDAG.getNode(VEISD::VVP_MUL, IndexVT,
                               {Index, ScaleBroadcast, Mask, OpVectorLength});
  }

  // add basePtr
  SDValue addresses;
  if (isNullConstant(BasePtr)) {
    addresses = ScaledIndex;
  } else {
    // re-constitute pointer vector (basePtr + index * scale)
    SDValue BaseBroadcast =
        CDAG.CreateBroadcast(IndexVT, BasePtr, OpVectorLength);
    addresses =
        CDAG.getNode(VEISD::VVP_ADD, IndexVT,
                     {BaseBroadcast, ScaledIndex, Mask, OpVectorLength});
  }

  // try to shrink the VL
  OpVectorLength = ReduceVectorLength(Mask, OpVectorLength,
                                      IndexVT.getVectorNumElements(), DAG);

  if (Op.getOpcode() == ISD::MGATHER || Op.getOpcode() == ISD::VP_GATHER) {
    EVT ChainVT = Op.getNode()->getValueType(1);

    SDValue NewLoadV = CDAG.getNode(VEISD::VVP_GATHER, {LegalResVT, ChainVT},
                                    {Chain, addresses, Mask, OpVectorLength});

    if (PassThru.isUndef()) {
      return NewLoadV;
    }

    // re-introduce passthru as a select // TODO CDAG.getSelect
    SDValue DataV =
        CDAG.DAG.getSelect(CDAG.DL, LegalResVT, Mask, NewLoadV, PassThru);
    SDValue NewLoadChainV = SDValue(NewLoadV.getNode(), 1);
    return CDAG.getMergeValues({DataV, NewLoadChainV});

  } else {
    SDValue store =
        CDAG.getNode(VEISD::VVP_SCATTER, Op.getNode()->getVTList(),
                     {Chain, Source, addresses, Mask, OpVectorLength});
    // store.dumpr(&DAG);
    return store;
  }
}

SDValue
VETargetLowering::lowerVVP_EXTRACT_SUBVECTOR(SDValue Op, SelectionDAG &DAG,
                                             VVPExpansionMode Mode) const {
  auto SrcVec = Op.getOperand(0);
  auto BaseIdxN = Op.getOperand(1);

  assert(isa<ConstantSDNode>(BaseIdxN) && "TODO dynamic extract");
  CustomDAG CDAG(*this, DAG, Op);
  EVT LegalVecTy = CDAG.legalizeVectorType(Op, Mode);

  int64_t ShiftVal = cast<ConstantSDNode>(BaseIdxN)->getSExtValue();

  // Trivial case
  if (ShiftVal == 0) {
    unsigned NarrowLen = Op.getValueType().getVectorNumElements();
    return CDAG.createNarrow(LegalVecTy, SrcVec, NarrowLen);
  }

  // non-trivial mask shift
  return lowerVectorShuffleOp(Op, DAG, Mode);
}

SDValue VETargetLowering::lowerVPToVVP(SDValue Op, SelectionDAG &DAG,
                                       VVPExpansionMode Mode) const {
  auto OCOpt = GetVVPForVP(Op.getOpcode());
  assert(OCOpt.hasValue());

  // TODO VP reductions
  switch (Op.getOpcode()) {
  case ISD::VP_VSHIFT:
    // Lowered to VEC_VMV (inverted shift amount)
    return lowerVP_VSHIFT(Op, DAG);

  case ISD::VP_LOAD:
    return lowerVVP_MLOAD(Op, DAG, VVPExpansionMode::ToNativeWidth);
  case ISD::VP_STORE:
    return lowerVVP_MSTORE(Op, DAG);

  case ISD::VP_GATHER:
  case ISD::VP_SCATTER:
    return lowerVVP_MGATHER_MSCATTER(Op, DAG, VVPExpansionMode::ToNativeWidth,
                                 None);

  default:
    break;
  }

  // Check whether this should be Widened to VVP
  CustomDAG CDAG(*this, DAG, Op);
  VVPWideningInfo WidenInfo = pickResultType(CDAG, Op, Mode);

  if (!WidenInfo.isValid()) {
    LLVM_DEBUG(dbgs() << "Cannot Custom-VVP-widen this VP operator.\n");
    return SDValue();
  }

  // Split into two v256 ops?
  if (WidenInfo.PackedMode && !SupportsPackedMode(OCOpt.getValue())) {
    return ExpandToSplitVVP(Op, DAG, Mode);
  }

  // Otw, opt for direct VVP_* lowering
  SDLoc dl(Op);
  unsigned VVPOC = OCOpt.getValue();
  std::vector<SDValue> OpVec;

  if (VVPOC == VEISD::VVP_FFMA) {
    OpVec.push_back(LegalizeVecOperand(Op->getOperand(2), DAG));
    OpVec.push_back(LegalizeVecOperand(Op->getOperand(0), DAG));
    OpVec.push_back(LegalizeVecOperand(Op->getOperand(1), DAG));
    OpVec.push_back(LegalizeVecOperand(Op->getOperand(3), DAG));
    OpVec.push_back(LegalizeVecOperand(Op->getOperand(4), DAG));

  } else {
    unsigned NumOps = Op.getNumOperands();
    for (unsigned i = 0; i < NumOps; ++i) {
      OpVec.push_back(LegalizeVecOperand(Op.getOperand(i), DAG));
    }
  }

  EVT NewResVT = CDAG.legalizeVectorType(Op, Mode);

  // Create a matching VVP_* node
  assert(WidenInfo.isValid() && "Cannot widen this VP op into VVP");
  SDValue NewV = DAG.getNode(VVPOC, dl, NewResVT, OpVec);
  NewV->setFlags(Op->getFlags());
  return NewV;
}

SDValue VETargetLowering::lowerVVP_MLOAD(SDValue Op, SelectionDAG &DAG,
                                     VVPExpansionMode Mode,
                                     VecLenOpt VecLenHint) const {
  LLVM_DEBUG(dbgs() << "Lowering VP/MLOAD\n");
  LLVM_DEBUG(Op.dumpr(&DAG));
  CustomDAG CDAG(*this, DAG, Op);

  SDValue BasePtr = getLoadStorePtr(Op);
  SDValue Mask = getLoadStoreMask(Op);
  SDValue Chain = getLoadStoreChain(Op);
  SDValue PassThru = getLoadPassthru(Op);
  SDValue AVL = getLoadStoreAVL(Op);

  MemSDNode *MemN = cast<MemSDNode>(Op.getNode());

  // analyze the vector length
  VVPWideningInfo WidenInfo = pickResultType(CDAG, Op, Mode);

  // Split for packed mode
  if (WidenInfo.NeedsPackedMasking) {
    return ExpandToSplitVVP(Op, DAG, Mode);
  }

  // minimize vector length
  AVL = ReduceVectorLength(Mask, AVL, VecLenHint, DAG);

  EVT DataVT = LegalizeVectorType(MemN->getMemoryVT(), Op, DAG, Mode);
  MVT ChainVT = Op.getNode()->getSimpleValueType(1);

  // create suitable mask and avl parameters (accounts for packing)
  auto TargetMasks = CDAG.createTargetMask(WidenInfo, Mask, AVL);

  // emit
  uint64_t ElemBytes = DataVT.getVectorElementType().getStoreSize();
  uint64_t PackedBytes = WidenInfo.PackedMode ? 2 * ElemBytes : ElemBytes;
  auto StrideV = CDAG.getConstant(PackedBytes, MVT::i64);
  auto NewLoadV = CDAG.getNode(
      VEISD::VVP_LOAD, {DataVT, ChainVT},
      {Chain, BasePtr, StrideV, TargetMasks.Mask, TargetMasks.AVL});

  if (!PassThru || PassThru.isUndef()) {
    return NewLoadV;
  }

  // re-introduce passthru as a select
  SDValue DataV = CDAG.DAG.getSelect(CDAG.DL, Op.getSimpleValueType(), Mask,
                                     NewLoadV, PassThru);
  SDValue NewLoadChainV = SDValue(NewLoadV.getNode(), 1);

  // merge them back into one node
  return CDAG.getMergeValues({DataV, NewLoadChainV});
}

SDValue VETargetLowering::lowerVVP_MSTORE(SDValue Op, SelectionDAG &DAG) const {
  VVPExpansionMode Mode = VVPExpansionMode::ToNativeWidth;
  LLVM_DEBUG(dbgs() << "Lowering VP/MSTORE\n");
  LLVM_DEBUG(Op.dumpr(&DAG));
  CustomDAG CDAG(*this, DAG, Op);

  SDValue BasePtr = getLoadStorePtr(Op);
  SDValue Data = getStoreData(Op);
  SDValue Mask = getLoadStoreMask(Op);
  SDValue Chain = getLoadStoreChain(Op);
  assert(Data);
  SDValue AVL = getLoadStoreAVL(Op);

  VVPWideningInfo WidenInfo = pickResultType(CDAG, Op, Mode);

  // Split for packed mode
  if (WidenInfo.NeedsPackedMasking) {
    return ExpandToSplitVVP(Op, DAG, Mode);
  }

  // minimize vector length
  AVL = ReduceVectorLength(Mask, AVL, None, DAG);

  // create suitable mask and avl parameters (accounts for packing)
  auto TargetMasks = CDAG.createTargetMask(WidenInfo, Mask, AVL);

  uint64_t ElemBytes =
      Data.getValueType().getVectorElementType().getStoreSize();
  uint64_t PackedBytes = WidenInfo.PackedMode ? 2 * ElemBytes : ElemBytes;
  auto StrideV = CDAG.getConstant(PackedBytes, MVT::i64);

  return CDAG.getNode(
      VEISD::VVP_STORE, Op.getNode()->getVTList(),
      {Chain, Data, BasePtr, StrideV, TargetMasks.Mask, TargetMasks.AVL});
}

SDValue VETargetLowering::lowerVP_VSHIFT(SDValue Op, SelectionDAG &DAG) const {
  SDLoc DL(Op);

  // (V, A, mask, avl)
  auto V = Op.getOperand(0);
  auto A = Op.getOperand(1);
  auto Mask = Op.getOperand(2);
  auto Avl = Op.getOperand(3);

  auto AmountTy = A.getSimpleValueType();
  assert(V.getSimpleValueType().getVectorNumElements() == 256 &&
         "not implemented for other sizes!!");

  // invert amount
  SDNodeFlags Flags;
  Flags.setNoUnsignedWrap(true);
  auto InverseA = DAG.getNode(ISD::SUB, DL, A.getSimpleValueType(),
                              DAG.getConstant(256, DL, AmountTy), A, Flags);

  return DAG.getNode(VEISD::VEC_VMV, DL, Op.getSimpleValueType(),
                     {V, InverseA, Mask, Avl});
}

SDValue VETargetLowering::lowerVVP_INSERT_VECTOR_ELT(SDValue Op,
                                                 SelectionDAG &DAG) const {
  assert(Op.getOpcode() == ISD::INSERT_VECTOR_ELT && "Unknown opcode!");
  EVT VT = Op.getOperand(0).getValueType();

  // Special treatements for packed V64 types.
  if (VT == MVT::v512i32 || VT == MVT::v512f32) {
    // Example of codes:
    //   %packed_v = extractelt %vr, %idx / 2
    //   %packed_v &= 0xffffffff << ((%idx % 2) ? 0 : 32)
    //   %packed_v |= %val << (%idx % 2 * 32)
    //   %vr = insertelt %vr, %packed_v, %idx / 2

    SDValue Vec = Op.getOperand(0);
    SDValue Val = Op.getOperand(1);
    SDValue Idx = Op.getOperand(2);
    EVT i64 = EVT::getIntegerVT(*DAG.getContext(), 64);
    EVT i32 = EVT::getIntegerVT(*DAG.getContext(), 32);
    SDLoc dl(Op);
    // In v512i32 and v512f32, both i32 and f32 values are placed from Low32,
    // therefore convert f32 to i32 first.
    SDValue I32Val = Val;
    if (VT == MVT::v512f32) {
      I32Val = DAG.getBitcast(i32, Val);
    }
    SDValue Result = Op;
    if (0 /* Idx->isConstant()*/) {
      // FIXME: optimized implementation using constant values
    } else {
      SDValue SetEq = DAG.getCondCode(ISD::SETEQ);
      // SDValue CcEq = DAG.getConstant(VECC::CC_IEQ, dl, i64);
      SDValue ZeroConst = DAG.getConstant(0, dl, i64);
      SDValue OneConst = DAG.getConstant(1, dl, i64);
      SDValue ThirtyTwoConst = DAG.getConstant(32, dl, i64);
      SDValue HighMask = DAG.getConstant(0xFFFFFFFF00000000, dl, i64);
      SDValue HalfIdx = DAG.getNode(ISD::SRL, dl, i64, {Idx, OneConst});
      SDValue PackedVal =
          SDValue(DAG.getMachineNode(VE::LVSvr, dl, i64, {Vec, HalfIdx}), 0);
      SDValue IdxLSB = DAG.getNode(ISD::AND, dl, i64, {Idx, OneConst});
      SDValue ShiftIdx =
          DAG.getNode(ISD::SELECT_CC, dl, i64,
                      {IdxLSB, ZeroConst, ZeroConst, ThirtyTwoConst, SetEq});
      SDValue Mask = DAG.getNode(ISD::SRL, dl, i64, {HighMask, ShiftIdx});
      SDValue MaskedVal = DAG.getNode(ISD::AND, dl, i64, {PackedVal, Mask});
      SDValue BaseVal = SDValue(
          DAG.getMachineNode(TargetOpcode::IMPLICIT_DEF, dl, MVT::i64), 0);
      // In v512i32 and v512f32, Both i32 and f32 values are placed from Low32.
      SDValue SubLow32 = DAG.getTargetConstant(VE::sub_i32, dl, MVT::i32);
      SDValue I64Val =
          SDValue(DAG.getMachineNode(TargetOpcode::INSERT_SUBREG, dl, MVT::i64,
                                     BaseVal, I32Val, SubLow32),
                  0);
      SDValue ShiftedVal = DAG.getNode(ISD::SHL, dl, i64, {I64Val, ShiftIdx});
      SDValue CombinedVal =
          DAG.getNode(ISD::OR, dl, i64, {ShiftedVal, MaskedVal});
      Result =
          SDValue(DAG.getMachineNode(VE::LSVrr_v, dl, Vec.getSimpleValueType(),
                                     {HalfIdx, CombinedVal, Vec}),
                  0);
    }
    return Result;
  }

  // Lowering to VM_EXTRACT
  SDValue SrcV = Op.getOperand(0);
  SDValue ElemV = Op.getOperand(1);
  SDValue IndexV = Op.getOperand(2);
  if (SDValue ActualMaskV = PeekForMask(SrcV)) {
    assert((Op.getValueType() == MVT::i64) && "not a proper mask extraction");
    CustomDAG CDAG(*this, DAG, Op);
    return CDAG.CreateInsertMask(ActualMaskV, ElemV, IndexV);
  }

  // Insertion is legal for other V64 types.
  return Op;
}

SDValue VETargetLowering::lowerVVP_EXTRACT_VECTOR_ELT(SDValue Op,
                                                  SelectionDAG &DAG) const {
  SDValue SrcV = Op->getOperand(0);
  SDValue IndexV = Op->getOperand(1);

  auto IndexC = dyn_cast<ConstantSDNode>(IndexV);
  if (!IndexC) return lowerSIMD_EXTRACT_VECTOR_ELT(Op, DAG);

  // Lowering to VM_EXTRACT
  if (SDValue ActualMaskV = PeekForMask(SrcV)) {
    assert(IndexC);
    assert(Op.getValueType().isScalarInteger());
    // unsigned ResSize = Op.getValueType().getSizeInBits(); // Implicit
    EVT MaskVT = Op.getOperand(0).getValueType();
    unsigned PartSize = MaskVT.getVectorElementType().getSizeInBits();

    const unsigned SXRegSize = 64;

    CustomDAG CDAG(*this, DAG, Op);

    // determine the adjusted extraction index
    SDValue AdjIndexV = IndexV;
    unsigned ShiftAmount = 0;
    if (PartSize != 64) {
      unsigned PartIdx = IndexC->getZExtValue();
      unsigned AbsOffset = PartSize * PartIdx; // bit offset
      unsigned ActualPart =
          AbsOffset / SXRegSize; // actual part when chunked into 64bit elements
      assert(ActualPart < GetMaskBits(MaskVT) / SXRegSize &&
             "Mask bits out of range!");
      AdjIndexV = CDAG.getConstant(ActualPart, MVT::i32);

      // Missing shift amount to isolate the wanted bit
      ShiftAmount = AbsOffset - (ActualPart * SXRegSize);
    }

    auto ResV = CDAG.CreateExtractMask(ActualMaskV, AdjIndexV);
    ResV = CDAG.createScalarShift(MVT::i64, ResV, ShiftAmount);

    // Convert back to actual result type
    return CDAG.DAG.getAnyExtOrTrunc(ResV, CDAG.DL, Op.getValueType());
  }

  // Extraction is legal for other V64 types.
  return Op;
}

SDValue VETargetLowering::lowerVectorShuffleOp(SDValue Op, SelectionDAG &DAG,
                                               VVPExpansionMode Mode) const {
  SDLoc DL(Op);
  std::unique_ptr<MaskView> MView(requestMaskView(Op.getNode()));

  CustomDAG CDAG(*this, DAG, Op);
  EVT LegalResVT = CDAG.legalizeVectorType(Op, Mode);

  // mask to shift + OR expansion
  if (IsMaskType(Op.getValueType())) {
    // TODO IsMaskType(Op.getValueType())) {
    MaskShuffleAnalysis MSA(*MView.get(), CDAG);
    return MSA.synthesize(CDAG, LegalResVT);
  }

  LLVM_DEBUG(dbgs() << "Lowering Shuffle (non-vmask path)\n");
  // ShuffleVectorSDNode *ShuffleInstr =
  // cast<ShuffleVectorSDNode>(Op.getNode());

  std::unique_ptr<MaskView> VecView(requestMaskView(Op.getNode()));
  assert(VecView && "Cannot lower this shufffle..");

  ShuffleAnalysis VSA(*VecView);
  if (VSA.analyze() == ShuffleAnalysis::CanSynthesize)
    return VSA.synthesize(CDAG, LegalResVT);

  // fallback to LLVM and hope for the best
  return SDValue();
}

SDValue VETargetLowering::LowerOperation_VVP(SDValue Op,
                                             SelectionDAG &DAG) const {
  LLVM_DEBUG(dbgs() << "LowerOp: "; Op.dump(&DAG); dbgs() << "\n";);

  switch (Op.getOpcode()) {
  default:
    llvm_unreachable("Should not custom lower this!");
  case ISD::EXTRACT_VECTOR_ELT:
    return lowerVVP_EXTRACT_VECTOR_ELT(Op, DAG);
  case ISD::INSERT_VECTOR_ELT:
    return lowerVVP_INSERT_VECTOR_ELT(Op, DAG);

  case ISD::BITCAST:
    return lowerVVP_Bitcast(Op, DAG);

  // vector composition
  case ISD::CONCAT_VECTORS:
    return lowerVVP_CONCAT_VECTOR(Op, DAG);
  case ISD::BUILD_VECTOR:
  case ISD::VECTOR_SHUFFLE:
    return lowerVectorShuffleOp(Op, DAG, VVPExpansionMode::ToNativeWidth);

  case ISD::EXTRACT_SUBVECTOR:
    return lowerVVP_EXTRACT_SUBVECTOR(Op, DAG, VVPExpansionMode::ToNativeWidth);
  case ISD::SCALAR_TO_VECTOR:
    return lowerVVP_SCALAR_TO_VECTOR(Op, DAG, VVPExpansionMode::ToNativeWidth);

    // case ISD::VECREDUCE_OR:
    // case ISD::VECREDUCE_AND:
    // case ISD::VECREDUCE_XOR:

  case ISD::MLOAD:
    return lowerVVP_MLOAD(Op, DAG, VVPExpansionMode::ToNativeWidth);
  case ISD::MSTORE:
    return lowerVVP_MSTORE(Op, DAG);
  case ISD::MSCATTER:
  case ISD::MGATHER:
    return lowerVVP_MGATHER_MSCATTER(Op, DAG, VVPExpansionMode::ToNativeWidth,
                                 None);

    // modify the return type of SETCC on vectors to v256i1
    // case ISD::SETCC: return LowerSETCC(Op, DAG);

    // case ISD::TRUNCATE: return LowerTRUNCATE(Op, DAG);

    ///// LLVM-VP --> vvp_* /////
#define BEGIN_REGISTER_VP_SDNODE(VP_NAME, ...) case ISD::VP_NAME:
#include "llvm/IR/VPIntrinsics.def"
    return lowerVPToVVP(Op, DAG, VVPExpansionMode::ToNativeWidth);

    ///// non-VP --> vvp_* with native type /////
    // Convert this standard vector op to VVP
  case ISD::SELECT:
    // FIXME List all operation that correspond to a VVP operation here
#define ADD_ICONV_VVP_OP(VVP_NAME, ISD_NAME) case ISD::ISD_NAME:
#define ADD_FPCONV_VVP_OP(VVP_NAME, ISD_NAME) case ISD::ISD_NAME:
#define ADD_UNARY_VVP_OP(VVP_NAME, ISD_NAME) case ISD::ISD_NAME:
#define ADD_BINARY_VVP_OP(VVP_NAME, ISD_NAME) case ISD::ISD_NAME:
#define ADD_TERNARY_VVP_OP(VVP_NAME, ISD_NAME) case ISD::ISD_NAME:
#define ADD_REDUCE_VVP_OP(VVP_NAME, ISD_NAME) case ISD::ISD_NAME:
#include "VVPNodes.def"
    return lowerToVVP(Op, DAG, VVPExpansionMode::ToNativeWidth);

    ///// Widen this VVP operation to the vector type /////
    // Use a native vector type for this VVP_* operation
    // FIXME List all VVP ops with vector results here
#define ADD_ICONV_VVP_OP(VVP_NAME, ISD_NAME) case VEISD::VVP_NAME:
#define ADD_FPCONV_VVP_OP(VVP_NAME, ISD_NAME) case VEISD::VVP_NAME:
#define ADD_UNARY_VVP_OP(VVP_NAME, ISD_NAME) case VEISD::VVP_NAME:
#define ADD_BINARY_VVP_OP(VVP_NAME, ISD_NAME) case VEISD::VVP_NAME:
#define ADD_TERNARY_VVP_OP(VVP_NAME, ISD_NAME) case VEISD::VVP_NAME:
#include "VVPNodes.def"

  case VEISD::VEC_BROADCAST:
  case VEISD::VEC_SEQ:
    return WidenVVPOperation(lowerSETCCInVectorArithmetic(Op, DAG), DAG,
                             VVPExpansionMode::ToNativeWidth);

  // "forget" about the narrowing
  case VEISD::VEC_NARROW:
    return Op->getOperand(0);
    // case ISD::LOAD - is taking care of VVP widening.
  }
}

SDValue VETargetLowering::lowerVVP_CONCAT_VECTOR(SDValue Op,
                                                 SelectionDAG &DAG) const {
  auto VT = Op.getValueType();
  assert(VT.getVectorElementType() == MVT::i1);

  // LLVM expansion
  if (VT.getVectorNumElements() <= 256) {
    return SDValue();
  }

  // Interleave the subregisteres
  CustomDAG CDAG(*this, DAG, Op);
  auto LoInsert = CDAG.getTargetInsertSubreg(
      VE::sub_vm_even, VT, CDAG.getImplicitDef(VT), Op->getOperand(0));
  return CDAG.getTargetInsertSubreg(VE::sub_vm_odd, VT, LoInsert,
                                    Op->getOperand(1));
}
