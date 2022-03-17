//===-- VVPISelLowering.cpp - VE DAG Lowering Implementation --------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file implements the lowering and legalization of vector instructions to
// VVP_*layer SDNodes.
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
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/KnownBits.h"

#include "VECustomDAG.h"
#include "ShuffleSynthesis.h"

#ifdef DEBUG_TYPE
#undef DEBUG_TYPE
#endif
#define DEBUG_TYPE "vvp-lower"

using namespace llvm;

// VE has no masked VLD. Ignore the mask, keep the AVL.
static cl::opt<bool> AssumeBestAlignment("ve-assume-best-alignment", cl::init(false),
                                         cl::desc("Assume optimal alignment for all vector load/stores (ie packed float ptrs are aligned to 8 bytes"),
                                         cl::Hidden);

static cl::opt<bool> OptimizeVectorMemory("ve-fast-mem", cl::init(true),
                                          cl::desc("Drop VLD masks"),
                                          cl::Hidden);

static cl::opt<bool>
    IgnoreMasks("ve-ignore-masks", cl::init(true),
                cl::desc("Drop all masks in side-effect free operations."),
                cl::Hidden);

static cl::opt<bool>
    OptimizeSplitAVL("ve-optimize-split-avl", cl::init(true),
                     cl::desc("Avoid LVL switching for split operations"),
                     cl::Hidden);

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

static bool isMaskArithmetic(SDNode &N) {
  switch (N.getOpcode()) {
  default:
    return false;
  case ISD::AND:
  case ISD::XOR:
  case ISD::OR:
    return isPackedMaskType(N.getValueType(0));
  }
}

static bool shouldLowerToVVP(SDNode &N) {
  // Already a target node
  if (isVVPOrVEC(N.getOpcode()))
    return false;

  // Mask arithmetic is unpredicated -> do not lower.
  if (isMaskArithmetic(N))
    return false;

  // Do not VVP expand mask loads/stores
  // FIXME this leaves dangling VP mask stores if not properly legalized
  auto MemN = dyn_cast<MemSDNode>(&N);
  if (MemN && isMaskType(MemN->getMemoryVT())) {
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
static bool OpNeedsSplitting(SDNode &Op) {
  // Otw, widen this VVP operation to the native vector width
  Optional<EVT> OpVecTyOpt = getIdiomaticType(&Op);
  if (!OpVecTyOpt.hasValue() || !OpVecTyOpt->isVector())
    return false;

  EVT OpVecTy = OpVecTyOpt.getValue();
  return !supportsPackedMode(Op.getOpcode(), OpVecTy);
#if 0
  unsigned OpVectorLength = OpVecTy.getVectorNumElements();
  assert((OpVectorLength <= PackedVectorWidth) &&
         "Operation should have been split during legalization");
  return (OpVectorLength != StandardVectorWidth) &&
         (OpVectorLength != PackedVectorWidth);
#endif
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

/// Load & Store Properties {
static SDValue getNodeChain(SDValue Op) {
  switch (Op->getOpcode()) {
  case VEISD::VVP_LOAD:
  case VEISD::VVP_GATHER:
  case VEISD::VVP_STORE:
  case VEISD::VVP_SCATTER:
    return Op->getOperand(0);
  }
  if (MemSDNode *MemN = dyn_cast<MemSDNode>(Op.getNode())) {
    return MemN->getChain();
  }
  // FIXME: Redundant
  if (Op->isVP()) {
    return Op->getOperand(0);
  }
  return SDValue();
}

static SDValue getMemoryPtr(SDValue Op) {
  switch (Op->getOpcode()) {
  case VEISD::VVP_GATHER:
  case VEISD::VVP_LOAD:
    return Op->getOperand(1);
  case VEISD::VVP_SCATTER:
  case VEISD::VVP_STORE:
    return Op->getOperand(2);
  }
  if (auto *MemN = dyn_cast<MemSDNode>(Op.getNode())) {
    return MemN->getBasePtr();
  }
  return SDValue();
}

static EVT getMemoryDataVT(SDValue Op) {
  if (MemSDNode *MemN = dyn_cast<MemSDNode>(Op.getNode()))
    return MemN->getMemoryVT();
  if ((Op->getOpcode() == VEISD::VVP_LOAD) ||
      (Op->getOpcode() == VEISD::VVP_STORE))
    return *getIdiomaticType(Op.getNode());
  abort();
}

static SDValue getLoadStoreStride(SDValue Op, VECustomDAG &CDAG) {
  if (Op->getOpcode() == VEISD::VVP_STORE) {
    return Op->getOperand(3);
  }
  if (Op->getOpcode() == VEISD::VVP_LOAD) {
    return Op->getOperand(2);
  }

  if (isa<MemSDNode>(Op.getNode())) {
    // Regular MLOAD/MSTORE/LOAD/STORE
    // No stride argument -> use the contiguous element size as stride.
    uint64_t ElemStride =
        getMemoryDataVT(Op).getVectorElementType().getStoreSize();
    return CDAG.getConstant(ElemStride, MVT::i64);
  }
  abort();
}

static SDValue getStoredValue(SDValue Op) {
  switch (Op->getOpcode()) {
  case VEISD::VVP_STORE:
  case VEISD::VVP_SCATTER:
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
  if (auto *StoreN = dyn_cast<MaskedScatterSDNode>(Op.getNode())) {
    return StoreN->getValue();
  }
  if (auto *StoreN = dyn_cast<VPScatterSDNode>(Op.getNode())) {
    return StoreN->getValue();
  }
  return SDValue();
}

/// } Load & Store Properties

static SDValue getSplitPtrOffset(SDValue Ptr, SDValue ByteStride, PackElem Part,
                                 VECustomDAG &CDAG) {
  // High starts at base ptr but has more significant bits in the 64bit vector
  // element.
  if (Part == PackElem::Hi)
    return Ptr;
  return CDAG.getNode(ISD::ADD, MVT::i64, {Ptr, ByteStride});
}
static SDValue getSplitPtrStride(SDValue PackStride, VECustomDAG &CDAG) {
  if (auto ConstBytes = dyn_cast<ConstantSDNode>(PackStride))
    return CDAG.getConstant(2 * ConstBytes->getSExtValue(), MVT::i64);
  return CDAG.getNode(ISD::SHL, MVT::i64,
                      {PackStride, CDAG.getConstant(1, MVT::i32)});
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

  if (isMaskType(Op.getValueType()))
    return Op;
  return SDValue();
}

static bool hasChain(SDNode &N) {
  return isa<MemSDNode>(N) || N.isStrictFPOpcode() || N.isMemIntrinsic();
}

static bool IgnoreOperandForVVPLowering(const SDNode *N, unsigned OpIdx) {
  if (OpIdx == 1 && (N->getOpcode() == ISD::FP_ROUND))
    return true;
  return false;
}

static bool maySafelyIgnoreMask(unsigned VVPOpcode) {
  if (!IgnoreMasks)
    return false;

  // Most arithmetic is safe without mask.
  if (isVVPTernaryOp(VVPOpcode))
    return VVPOpcode != VEISD::VVP_SELECT;
  if (isVVPBinaryOp(VVPOpcode)) {
    switch (VVPOpcode) {
    default:
      return true;
    case VEISD::VVP_UREM:
    case VEISD::VVP_SREM:
    case VEISD::VVP_UDIV:
    case VEISD::VVP_SDIV:
    case VEISD::VVP_FDIV:
      return false;
    }
  }
  return false;
}

static Align getAlign(SDValue Op) {
  auto ConstN = dyn_cast<ConstantSDNode>(Op);
  // TODO: Not being fancy here, only need to know whether AVL is even or odd.
  if (ConstN)
    return Align((ConstN->getZExtValue() % 2 == 0) ? 2 : 1);

  auto AAN = dyn_cast<AssertAlignSDNode>(Op);
  if (!AAN)
    return Align(1);
  return AAN->getAlign();
}

static bool isEvenNumber(SDValue AVL) { return getAlign(AVL).value() % 2 == 0; }

static bool isPackableLoadStore(SDValue Op) {
  SDValue AVL = getAnnotatedNodeAVL(Op).first;
  SDValue Mask = getNodeMask(Op);

  // Ignore the mask and odd-valued AVL when optimizing memops.
  if ((Op->getOpcode() == VEISD::VVP_LOAD) && OptimizeVectorMemory)
    return true;

  return isAllTrueMask(Mask) && isEvenNumber(AVL);
}

static bool getUniqueInsertion(SDNode *N, unsigned &UniqueIdx) {
  if (!isa<BuildVectorSDNode>(N))
    return false;
  const auto *BVN = cast<BuildVectorSDNode>(N);

  // Find first non-undef insertion.
  unsigned Idx;
  for (Idx = 0; Idx < BVN->getNumOperands(); ++Idx) {
    auto ElemV = BVN->getOperand(Idx);
    if (!ElemV->isUndef())
      break;
  }
  // Remember insertion.
  UniqueIdx = Idx++;
  // Verify that all other insertions are undef.
  for (; Idx < BVN->getNumOperands(); ++Idx) {
    auto ElemV = BVN->getOperand(Idx);
    if (!ElemV->isUndef())
      return false;
  }
  return true;
}

static SDValue getGatherScatterIndex(SDValue Op) {
  if (auto *N = dyn_cast<MaskedGatherScatterSDNode>(Op.getNode())) {
    return N->getIndex();
  }
  if (auto *N = dyn_cast<VPGatherScatterSDNode>(Op.getNode())) {
    return N->getIndex();
  }
  return SDValue();
}

static SDValue getGatherScatterScale(SDValue Op) {
  if (auto *N = dyn_cast<MaskedGatherScatterSDNode>(Op.getNode())) {
    return N->getScale();
  }
  if (auto *N = dyn_cast<VPGatherScatterSDNode>(Op.getNode())) {
    return N->getScale();
  }
  return SDValue();
}

static SDValue getNodePassthru(SDValue Op) {
  if (auto *N = dyn_cast<MaskedGatherSDNode>(Op.getNode())) {
    return N->getPassThru();
  }
  if (auto *N = dyn_cast<MaskedLoadSDNode>(Op.getNode())) {
    return N->getPassThru();
  }
  return SDValue();
}

SDValue
VETargetLowering::computeGatherScatterAddress(VECustomDAG &CDAG, SDValue BasePtr,
                                              SDValue Scale, SDValue Index,
                                              SDValue Mask, SDValue AVL) const {
  EVT IndexVT = Index.getValueType();
  bool SplitOps = isOverPackedType(IndexVT);

  // Apply scale.
  SDValue ScaledIndex;
  if (!Scale || isOneConstant(Scale)) {
    ScaledIndex = Index;
  } else {
    SDValue ScaleBroadcast = CDAG.getBroadcast(IndexVT, Scale, AVL);
    ScaledIndex = CDAG.getNode(VEISD::VVP_MUL, IndexVT,
                               {Index, ScaleBroadcast, Mask, AVL});
    if (SplitOps)
      ScaledIndex =
          splitVectorOp(ScaledIndex, CDAG.DAG, VVPExpansionMode::ToNativeWidth);
  }

  // Add basePtr.
  if (isNullConstant(BasePtr)) {
    return ScaledIndex;
  }
  // re-constitute pointer vector (basePtr + index * scale)
  SDValue BaseBroadcast = CDAG.getBroadcast(IndexVT, BasePtr, AVL);
  auto ResPtr = CDAG.getNode(VEISD::VVP_ADD, IndexVT,
                             {BaseBroadcast, ScaledIndex, Mask, AVL});
  if (!SplitOps)
    return ResPtr;
  return splitVectorOp(ResPtr, CDAG.DAG, VVPExpansionMode::ToNativeWidth);
}

static const MVT AllVectorVTs[] = {MVT::v256i32, MVT::v512i32, MVT::v256i64,
                                   MVT::v256f32, MVT::v512f32, MVT::v256f64,
                                   MVT::v512f64, MVT::v512i64};
static const MVT PackedVectorVTs[] = {MVT::v512i32, MVT::v512f32, MVT::v512f64,
                                      MVT::v512i64};

void VETargetLowering::initRegisterClasses_VVP() {
  // VVP-based backend.
  for (MVT VecVT : AllVectorVTs)
    if (!isPackedVectorType(VecVT) || Subtarget->hasPackedMode())
      addRegisterClass(VecVT, &VE::V64RegClass);

  addRegisterClass(MVT::v256i1, &VE::VMRegClass);
  if (Subtarget->hasPackedMode()) {
    addRegisterClass(MVT::v512f64, &VE::VPRegClass);
    addRegisterClass(MVT::v512i64, &VE::VPRegClass);
    addRegisterClass(MVT::v512i1, &VE::VM512RegClass);
  }
  return;
}

void VETargetLowering::initVPUActions() {
  if (!Subtarget->enableVPU())
    return;

  // The entry token is the first node to be legalized in the SelectionDAG.
  // Use this to reset the visited internal vector instruction set.
  // setOperationAction(ISD::EntryToken, MVT::Other, Custom);
  setTargetDAGCombine(ISD::EntryToken);

  // Expand CopyToReg(vec_pack (lo, hi)) for over-packed register.
  // This makes register allocation more efficient (less vreg moves).
  if (Subtarget->hasPackedMode()) {
    setTargetDAGCombine(ISD::CopyToReg);
    // Live-ins are expanded in ::LowerFormalArguments.
    // setTargetDAGCombine(ISD::CopyFromReg);
  }

  // Vector length legalization
  auto LegalizeVectorLength = [&](unsigned VL) -> unsigned {
    if (this->Subtarget->hasPackedMode()) {
      return VL > StandardVectorWidth ? PackedVectorWidth : StandardVectorWidth;
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
      ISD::FCEIL, ISD::FRINT, ISD::FNEARBYINT, ISD::FTRUNC, ISD::FFLOOR,
      ISD::LROUND, ISD::LLROUND, ISD::FROUND, ISD::LRINT, ISD::LLRINT,

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
    unsigned W = VT.getVectorMinNumElements();

    // Use default splitting for vlens > 512
    if (W > PackedVectorWidth)
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

  for (MVT PackedVT : PackedVectorVTs) {
    setOperationAction(ISD::INSERT_VECTOR_ELT, PackedVT, Custom);
    setOperationAction(ISD::EXTRACT_VECTOR_ELT, PackedVT.getVectorElementType(),
                       Custom);
    setOperationAction(ISD::EXTRACT_VECTOR_ELT, PackedVT, Custom);
  }

  // All mask ops.
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

    // Custom split packed mask operations.
    if (isPackedVectorType(MaskVT))
      ForAll_setOperationAction(IntArithOCs, MaskVT, Custom);
  }

  // Packed mask arithmetic.
  for (unsigned Opc : {ISD::AND, ISD::XOR, ISD::OR})
    setOperationAction(Opc, MVT::v512i1, Custom);

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
#define MAP_VVP_OP(VVP_NAME, ISD_NAME)                                         \
  setOperationAction(ISD::ISD_NAME, VT, Custom);
#include "VVPNodes.def"
  }

  // X -> vp_* funnel
  for (MVT VT : MVT::vector_valuetypes()) {
    LegalizeAction Action;
    // FIXME query available vector width for this Op
    const unsigned WidthLimit = Subtarget->hasPackedMode() ? 512 : 256;
    if (isLegalVectorVT(VT) && VT.getVectorMinNumElements() <= WidthLimit) {
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
  setOperationAction(ISD::VSELECT, MVT::v512i1, Custom);
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
                             ? PackedVectorWidth
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
    std::function<SDValue(SDValue)> PromotedOpCB,
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
  } else if (!isVVPOrVEC(N->getOpcode())) {
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

    // Re-use widened nodes from ReplaceNodeResult
    EVT OpDestTy = getTypeToTransformTo(*DAG.getContext(), Op.getValueType());

    if (OpDestTy != Op.getValueType()) {
      if (OpDestTy.isVector())
        FixedOp = WidenedOpCB(Op);
      else
        FixedOp = PromotedOpCB(Op);
      assert(FixedOp && "No legal operand available!");
    }

    FixedOperands.push_back(FixedOp);
  }

  // Legalize the result type of this node.

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

SDNode *
VETargetLowering::widenInternalVectorOperation(SDNode *N,
                                               SelectionDAG &DAG) const {
  LLVM_DEBUG(dbgs() << "::widenInternalVectorOp: "; N->dump(&DAG););
  VECustomDAG CDAG(*this, DAG, N);

  unsigned NumResults = N->getNumValues();
  assert(NumResults > 0);

  // if the SDNode has a chain operator on the value output instead
  assert(NumResults <= 2);
  int ValueIdx = NumResults - 1;
  EVT ResVT = N->getValueType(ValueIdx);
  if (!ResVT.isVector())
    return nullptr;

#if 0
   // Otw, widen this VVP operation to the next OR native vector width
  Optional<EVT> OpVecTyOpt = getIdiomaticType(N);
  assert(OpVecTyOpt.hasValue());
  EVT OpVecTy = OpVecTyOpt.getValue();
#endif

  // Simply go for the next requested type
  EVT NewResultType = getTypeToTransformTo(*DAG.getContext(), ResVT);

  // Copy the operand list
  unsigned NumOp = N->getNumOperands();
  std::vector<SDValue> FixedOperands;
  for (unsigned i = 0; i < NumOp; ++i) {
    SDValue OpVal = N->getOperand(i);
    FixedOperands.push_back(OpVal);
  }

  // Otw, clone the operation in every regard

  return CDAG
      .getNode(N->getOpcode(), NewResultType, FixedOperands, N->getFlags())
      .getNode();
}

// Illegal result type
void VETargetLowering::ReplaceNodeResults(SDNode *N,
                                          SmallVectorImpl<SDValue> &Results,
                                          SelectionDAG &DAG) const {

  // We are replacing node results again -> drop stale SDNode info.
  LLVM_DEBUG(dbgs() << "ReplaceNodeResult: "; N->dump(&DAG););

  // custom lowering only desired for VPU mode
  if (!Subtarget->enableVPU())
    return;

  unsigned NumResults = N->getNumValues();
  assert(NumResults > 0);

  // if the SDNode has a chain operator on the value output instead
  assert(NumResults <= 2);
  int ValIdx = NumResults - 1;

  SDNode *ResN = nullptr;
#if 0
  if (isVVPOrVEC(N->getOpcode())) {
    // FIXME abort() here!!! must not create VVP ops with illegal result type!
    // VVP ops already have a legal result type
    ResN = WidenVVPOperation(SDValue(N, 0), DAG, VVPExpansionMode::ToNextWidth)
               .getNode();

  } else
#endif
  if (shouldLowerToVVP(*N)) {
    // Lower this to a VVP (or VEC_) op with the next expected result type
    ResN = lowerToVVP(SDValue(N, ValIdx), DAG, VVPExpansionMode::ToNextWidth)
               .getNode();
  } else if (isVVPOrVEC(N->getOpcode())) {
    // Type legalization widens vector EVTs such as <3 x i64> to the next MVT
    // before widening to the legal vector width. Instead of touching that part,
    // we simply follow the widening steps by widening the VVP operations as
    // necessary.
    ResN = widenInternalVectorOperation(N, DAG);
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
  if (VT.getVectorMinNumElements() == 1)
    return TypeScalarizeVector;

  // Split oversized vectors
  if (VT.getVectorMinNumElements() > 512)
    return TypeSplitVector;

  // Promote short element vectors to i32
  if ((VT.getVectorElementType() != MVT::i1) && VT.isInteger() &&
      (VT.getVectorElementType().getSizeInBits() < 32))
    return TypePromoteInteger;

  // The default action for an odd-width vector is to widen.
  // This should also widen vNi1 vectors to v256i1/v512i1
  return TypeWidenVector;
}

SDValue VETargetLowering::lowerVVP_Bitcast(SDValue Op,
                                           SelectionDAG &DAG) const {
  if (Op.getSimpleValueType() == MVT::v256i64 &&
      Op.getOperand(0).getSimpleValueType() == MVT::v256f64) {
    LLVM_DEBUG(dbgs() << "Lowering bitcast of similar types.\n");
    return Op.getOperand(0);
  } else {
    return Op;
  }
}

SDValue VETargetLowering::lowerVVP_TRUNCATE(SDValue Op,
                                            SelectionDAG &DAG) const {
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

SDValue VETargetLowering::expandSELECT(SDValue MaskV, SDValue OnTrueV, SDValue OnFalseV,
                                       EVT LegalResVT, VECustomDAG &CDAG,
                                       SDValue AVL) const {
  // Expand vNi1 selects into a boolean expression
  if (isMaskType(LegalResVT)) {
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
    CondVecV = CDAG.getBroadcast(LegalMaskVT, MaskV, AVL);
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
  if (isMaskType(Ty))
    return Op;

  // only create an integer expansion if requested to do so
  std::vector<SDValue> FixedOperandList;
  bool NeededExpansion = false;

  auto MaskPos = getMaskPos(Op.getOpcode());
  VECustomDAG CDAG(*this, DAG, dl);

  // Identify AVL
  SDValue AVL = getNodeAVL(Op);
  assert(AVL);

  for (int i = 0; i < (int)Op->getNumOperands(); ++i) {
    // check whether this is an v256i1 SETCC
    auto Operand = Op->getOperand(i);
    // Do not expand the mask if it is used as a predicate.
    if (MaskPos && (i == *MaskPos)) {
      FixedOperandList.push_back(Operand);
      continue;
    }

    // Only expand SETCC with a vNi1 type.
    if ((Operand->getOpcode() != ISD::SETCC) ||
        !isMaskType(Operand.getSimpleValueType())) {
      FixedOperandList.push_back(Operand);
      continue;
    }

    // Go ahead and re-write to a vNi32 type (using VSELECT).
    EVT RawElemTy = Ty.getScalarType();
    assert(RawElemTy.isSimple());
    MVT ElemTy = RawElemTy.getSimpleVT();

    // materialize an integer expansion
    // vselect (MaskReplacement, VEC_BROADCAST(1), VEC_BROADCAST(0))
    auto ConstZero = CDAG.getConstant(0, ElemTy);
    auto ZeroBroadcast = CDAG.getBroadcast(Ty, ConstZero, AVL);

    auto ConstOne = CDAG.getConstant(1, ElemTy);
    auto OneBroadcast = CDAG.getBroadcast(Ty, ConstOne, AVL);

    auto Expanded =
        CDAG.createSelect(Ty, OneBroadcast, ZeroBroadcast, Operand, AVL);
    FixedOperandList.push_back(Expanded);
    NeededExpansion = true;
  }

  if (!NeededExpansion)
    return Op;

  // Re-materialize the operator.
  auto Ret =
      CDAG.getLegalOpVVP(Op.getOpcode(), Op.getValueType(), FixedOperandList);
  return Ret;
}

SDValue
VETargetLowering::lowerVVP_SCALAR_TO_VECTOR(SDValue Op, SelectionDAG &DAG,
                                            VVPExpansionMode Mode,
                                            VecLenOpt VecLenHint) const {
  SDLoc DL(Op);

  EVT ResTy = Op.getValueType();
  VECustomDAG CDAG(*this, DAG, Op);
  EVT NativeResTy = CDAG.legalizeVectorType(Op, Mode);

  // FIXME
  SDValue AVL = CDAG.getConstEVL(
      *minVectorLength(ResTy.getVectorNumElements(), VecLenHint));

  return CDAG.getBroadcast(NativeResTy, Op.getOperand(0), AVL);
}

TargetLowering::LegalizeAction
VETargetLowering::getActionForExtendedType(unsigned Op, EVT VT) const {
  switch (Op) {
#define REGISTER_VVP_OP(VVP_NAME) case VEISD::VVP_NAME:
#define MAP_VVP_OP(VVP_NAME, ISD_NAME) case ISD::ISD_NAME:
#include "VVPNodes.def"
    return Custom;
  default:
    return Expand;
  }
}

TargetLowering::LegalizeAction
VETargetLowering::getCustomOperationAction(SDNode &Op) const {
  switch (Op.getOpcode()) {
  // Always custom-lower VEC_NARROW to eliminate it
  case VEISD::VEC_NARROW:
    return Custom;
  // Created by us, always legal.
  case VEISD::VM_EXTRACT:
  case VEISD::VM_INSERT:
    return Legal;
  }
  // Do not custom lower packing support.
  if (isPackingSupportOpcode(Op.getOpcode()))
    return Legal;
  // Otw, only custom lower to perform due widening
  if (isVVPOrVEC(Op.getOpcode()))
    return Custom;
  return Legal;
}

SDValue VETargetLowering::splitLoadStore(SDValue Op, SelectionDAG &DAG,
                                         VVPExpansionMode Mode) const {
  LLVM_DEBUG(dbgs() << "splitLoadStore: "; Op->print(dbgs()); dbgs() << "\n");
  auto VVPOC = *getVVPOpcode(Op.getOpcode());
  assert((VVPOC == VEISD::VVP_LOAD) || (VVPOC == VEISD::VVP_STORE));

  VECustomDAG CDAG(*this, DAG, Op);

  VVPWideningInfo WidenInfo = pickResultType(CDAG, Op, Mode);

  EVT DataVT = getMemoryDataVT(Op);
  EVT ResVT = CDAG.splitVectorType(DataVT);

  SDValue Passthru = getNodePassthru(Op);

  // analyze the operation
  SDValue PackedMask = getNodeMask(Op);
  SDValue PackedAVL = getAnnotatedNodeAVL(Op).first;
  SDValue PackPtr = getMemoryPtr(Op);
  SDValue PackData = getStoredValue(Op);
  SDValue PackStride = getLoadStoreStride(Op, CDAG);

  unsigned ChainResIdx = PackData ? 0 : 1;

  // request the parts
  SDValue PartOps[2];

  SDValue UpperPartAVL; // we will use this for packing things back together
  for (PackElem Part : {PackElem::Hi, PackElem::Lo}) {
    // VP ops already have an explicit mask and AVL. When expanding from non-VP
    // attach those additional inputs here.
    auto SplitTM =
        CDAG.createTargetSplitMask(WidenInfo, PackedMask, PackedAVL, Part);
    SplitTM.AVL = CDAG.annotateLegalAVL(SplitTM.AVL);

    // Keep track of the (higher) lvl.
    if (Part == PackElem::Hi)
      UpperPartAVL = SplitTM.AVL;

    // Drop the mask (for loads).
    if (VVPOC == VEISD::VVP_LOAD && OptimizeVectorMemory)
      SplitTM.Mask = CDAG.createUniformConstMask(Packing::Normal, true);

    // Attach non-predicating value operands
    SmallVector<SDValue, 4> OpVec;

    // Chain
    OpVec.push_back(getNodeChain(Op));

    // Data
    if (PackData) {
      SDValue PartData = CDAG.extractPackElem(PackData, Part, SplitTM.AVL);
      OpVec.push_back(PartData);
    }

    // Avoid `lvl`s at the cost of accessing an off-by-one index.
    if (OptimizeSplitAVL && OptimizeVectorMemory)
      SplitTM.AVL = UpperPartAVL;

    // Ptr & Stride
    // Push (ptr + ElemBytes * <Part>, 2 * ElemBytes)
    // Stride info
    // EVT DataVT = LegalizeVectorType(getMemoryDataVT(Op), Op, DAG, Mode);
    OpVec.push_back(getSplitPtrOffset(PackPtr, PackStride, Part, CDAG));
    OpVec.push_back(getSplitPtrStride(PackStride, CDAG));

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
  if (PackData)
    return FusedChains;

  // re-pack into full packed vector result
  EVT PackedVT = CDAG.legalizeVectorType(Op, Mode);
  SDValue PackedVals =
      CDAG.createPack(PackedVT, PartOps[(int)PackElem::Lo],
                      PartOps[(int)PackElem::Hi], UpperPartAVL);

  // Put the passthru back in
  if (Passthru) {
    PackedVals = CDAG.createSelect(PackedVT, PackedVals, Passthru, PackedMask,
                                   UpperPartAVL);
  }

  return CDAG.getMergeValues({PackedVals, FusedChains});
}

SDValue VETargetLowering::legalizePackedAVL(SDValue Op,
                                            VECustomDAG &CDAG) const {
  LLVM_DEBUG(dbgs() << "::legalizePackedAVL\n";);
  // Only required for VEC and VVP ops.
  if (!isVVPOrVEC(Op->getOpcode()))
    return Op;

  // Operation already has a legal AVL.
  auto AVLPair = getAnnotatedNodeAVL(Op);
  if (AVLPair.second)
    return Op;
  auto AVL = AVLPair.first;

  // Legalize mask & avl.
  auto WidenInfo = pickResultType(CDAG, Op, VVPExpansionMode::ToNativeWidth);
  auto MaskPos = getMaskPos(Op->getOpcode());
  auto AVLPos = getAVLPos(Op->getOpcode());
  auto TargetMasks =
      CDAG.createTargetMask(WidenInfo, getNodeMask(Op), AVL);

  // Check whether we can safely drop the mask.
  if (MaskPos && IgnoreMasks && maySafelyIgnoreMask(Op->getOpcode()))
    TargetMasks.Mask =
        CDAG.createUniformConstMask(TargetMasks.Mask.getValueType(), true);

  // TODO: Peephole short-cut (if op not changed).
  TargetMasks.AVL = CDAG.annotateLegalAVL(TargetMasks.AVL);

  // Copy the operand list.
  int NumOp = Op->getNumOperands();
  std::vector<SDValue> FixedOperands;
  for (int i = 0; i < NumOp; ++i) {
    if (MaskPos && (i == *MaskPos)) {
      FixedOperands.push_back(TargetMasks.Mask);
    } else if (AVLPos && (i == *AVLPos)) {
      FixedOperands.push_back(TargetMasks.AVL);
    } else {
      FixedOperands.push_back(Op->getOperand(i));
    }
  }

  // Clone the operation with fixed operands.
  auto Flags = Op->getFlags();
  SDValue NewN =
      CDAG.getNode(Op->getOpcode(), Op->getVTList(), FixedOperands, Flags);
  return NewN;
}

SDValue VETargetLowering::splitVectorOp(SDValue Op, SelectionDAG &DAG,
                                        VVPExpansionMode Mode) const {
  VECustomDAG CDAG(*this, DAG, Op);

  LLVM_DEBUG(dbgs() << "::splitVectorOp: "; CDAG.print(dbgs(), Op) << "\n");
  auto OcOpt = getVVPOpcode(Op.getOpcode());
  assert(OcOpt.hasValue());
  unsigned VVPOC = OcOpt.getValue();

  // Special cases ('impure' SIMD instructions)
  if (VVPOC == VEISD::VVP_LOAD || VVPOC == VEISD::VVP_STORE)
    return splitLoadStore(Op, DAG, Mode);
  else if (VVPOC == VEISD::VVP_GATHER || VVPOC == VEISD::VVP_SCATTER)
    return splitGatherScatter(Op, DAG, Mode);

  EVT ResVT = CDAG.splitVectorType(Op.getValue(0).getValueType());

  // analyze the operation
  VVPWideningInfo WidenInfo = pickResultType(CDAG, Op, Mode);
  SDValue PackedMask = getNodeMask(Op);
  SDValue PackedAVL = getAnnotatedNodeAVL(Op).first;
  auto AVLPos = getAVLPos(Op->getOpcode());
  auto MaskPos = getMaskPos(Op->getOpcode());

  // request the parts
  SDValue PartOps[2];

  bool HasChain = false;

  SDValue UpperPartAVL; // we will use this for packing things back together
  for (PackElem Part : {PackElem::Hi, PackElem::Lo}) {
    // VP ops already have an explicit mask and AVL. When expanding from non-VP
    // attach those additional inputs here.
    auto SplitTM =
        CDAG.createTargetSplitMask(WidenInfo, PackedMask, PackedAVL, Part);

    // This will be a legal AVL.
    SplitTM.AVL = CDAG.annotateLegalAVL(SplitTM.AVL);

    if (Part == PackElem::Hi) {
      UpperPartAVL = SplitTM.AVL;
    }

    // Attach non-predicating value operands
    SmallVector<SDValue, 4> OpVec;
    for (unsigned i = 0; i < Op.getNumOperands(); ++i) {
      SDValue OpV = Op.getOperand(i);

      if (AVLPos && ((int)i) == *AVLPos)
        continue;
      if (MaskPos && ((int)i) == *MaskPos)
        continue;

      // Ignore some metataoperands.
      if (IgnoreOperandForVVPLowering(Op.getNode(), i))
        continue;

      if (OpV.getValueType() == MVT::Other) {
        // Potential chain operand.
        HasChain = hasChain(*Op.getNode());
        OpVec.push_back(OpV);
      } else {
        // Value operand
        SDValue PartV =
            CDAG.extractPackElem(Op.getOperand(i), Part, SplitTM.AVL);
        OpVec.push_back(PartV);
      }
    }

    // Ignore the mask where possible.
    if (OptimizeSplitAVL)
      SplitTM.AVL = UpperPartAVL;
    if (IgnoreMasks && maySafelyIgnoreMask(VVPOC))
      SplitTM.Mask = CDAG.createUniformConstMask(MVT::v256i1, true);

    // Add predicating args and generate part node.
    OpVec.push_back(SplitTM.Mask);
    OpVec.push_back(SplitTM.AVL);
    // Emit legal VVP nodes.
    PartOps[(int)Part] =
        CDAG.getLegalOpVVP(VVPOC, ResVT, OpVec, Op->getFlags());
  }

  // Use a scalar reducer.
  if (isVVPReductionOp(VVPOC)) {
    bool IsMaskReduction = isMaskType(Op.getOperand(0).getValueType());
    // Scalar join.
    unsigned JoinOpcode = getScalarReductionOpcode(VVPOC, IsMaskReduction);
    return CDAG.getNode(JoinOpcode, ResVT, PartOps);
  }

  // Re-package vectors.
  EVT PackedVT = CDAG.legalizeVectorType(Op, Mode);
  SDValue PackedVals =
      CDAG.createPack(PackedVT, PartOps[(int)PackElem::Lo],
                      PartOps[(int)PackElem::Hi], UpperPartAVL);

  // Value only node.
  if (!HasChain) {
    return PackedVals;
  }

  // Merge the chains.
  SDValue LowChain = PartOps[(int)PackElem::Lo].getValue(1);
  SDValue HiChain = PartOps[(int)PackElem::Hi].getValue(1);
  SmallVector<SDValue, 2> ChainVec({LowChain, HiChain});
  SDValue FusedChains = DAG.getTokenFactor(CDAG.DL, ChainVec);
  return CDAG.getMergeValues({PackedVals, FusedChains});
}

VVPWideningInfo VETargetLowering::pickResultType(VECustomDAG &CDAG, SDValue Op,
                                                 VVPExpansionMode Mode) const {
  Optional<EVT> VecVTOpt = getIdiomaticType(Op.getNode());
  if (!VecVTOpt.hasValue() || !VecVTOpt.getValue().isVector()) {
    LLVM_DEBUG(if (VecVTOpt) dbgs()
               << "VecVT: " << VecVTOpt->getEVTString() << "\n");
    LLVM_DEBUG(dbgs() << "\tno idiomatic vector VT.\n");
    return VVPWideningInfo();
  }
  EVT OpVecVT = VecVTOpt.getValue();

  // try to narrow the vector length
  Optional<unsigned> NarrowLen = peekForNarrow(Op);
  unsigned OpVectorLength =
      NarrowLen ? NarrowLen.getValue() : OpVecVT.getVectorNumElements();

  LLVM_DEBUG(dbgs() << "\tdetected AVL:" << OpVectorLength << "\n";);

  // Select the target vector width
  unsigned VectorWidth;
  if (OpVectorLength > StandardVectorWidth) {
    // packed mode only available for 32bit elements up to 512 elements
    // (virtually also for 64bit elements).
    EVT RawElemTy = OpVecVT.getVectorElementType();
    if (!RawElemTy.isSimple()) {
      LLVM_DEBUG(dbgs() << "\tToNative: Not a simple element type\n";);
      return VVPWideningInfo();
    }
    MVT ElemTy = RawElemTy.getSimpleVT();

    if ((ElemTy != MVT::i1 && ElemTy != MVT::i32 && ElemTy != MVT::f32 &&
         ElemTy != MVT::f64 && ElemTy != MVT::i64) ||
        (OpVectorLength > PackedVectorWidth)) {
      LLVM_DEBUG(dbgs() << "\tToNative: Over-sized data type\n";);
      return VVPWideningInfo();
    }

    VectorWidth = PackedVectorWidth;
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
  if (VectorWidth > StandardVectorWidth) {
    PackedMode = true;
    if (!Subtarget->hasPackedMode()) {
      LLVM_DEBUG(dbgs() << "\tPacked operations not enabled (set "
                           "-mattr=+packed to enable)!\n";);
      return VVPWideningInfo(); // possibly redundant
    }
  }

  // Analyze whether/how the AVL needs to be folded (odd-values AVL possible).
  bool NeedsPackedMasking = false;
  if (PackedMode) {
    // Do we need to fold the predicating effect of the AVL into the mask (due to
    // the coarse-grained nature of AVL in packed mode)?
    auto AVL = getAnnotatedNodeAVL(Op).first;
    if (AVL) {
      NeedsPackedMasking = PackedMode && !isEvenNumber(AVL);
      LLVM_DEBUG(dbgs() << "\tAVL: "; CDAG.print(dbgs(), AVL) << "\n";);
    } else {
      NeedsPackedMasking = (OpVectorLength % 2 != 0);
    }
    LLVM_DEBUG(dbgs() << "\tPacked Masking: " << NeedsPackedMasking << "\n";);
  }

  return VVPWideningInfo(ResultVT, OpVectorLength, PackedMode,
                         NeedsPackedMasking);
}

SDValue VETargetLowering::splitVectorArithmetic(SDValue Op,
                                                SelectionDAG &DAG) const {
  LLVM_DEBUG(dbgs() << "::splitMaskArithmetic\n");
  VECustomDAG CDAG(*this, DAG, Op);
  SDValue AVL = CDAG.getConstEVL(Op.getValueType().getVectorNumElements());
  SDValue A = Op->getOperand(0);
  SDValue B = Op->getOperand(1);
  SDValue LoA = CDAG.createUnpack(MVT::v256i1, A, PackElem::Lo, AVL);
  SDValue HiA = CDAG.createUnpack(MVT::v256i1, A, PackElem::Hi, AVL);
  SDValue LoB = CDAG.createUnpack(MVT::v256i1, B, PackElem::Lo, AVL);
  SDValue HiB = CDAG.createUnpack(MVT::v256i1, B, PackElem::Hi, AVL);
  unsigned Opc = Op.getOpcode();
  auto LoRes = CDAG.getNode(Opc, MVT::v256i1, {LoA, LoB});
  auto HiRes = CDAG.getNode(Opc, MVT::v256i1, {HiA, HiB});
  return CDAG.createPack(MVT::v512i1, LoRes, HiRes, AVL);
}

SDValue getSelectMask(SDValue Op) {
  switch (Op->getOpcode()) {
  case ISD::VSELECT:
  case ISD::SELECT:
  case ISD::VP_SELECT:
  case ISD::VP_MERGE:
    return Op->getOperand(0);
  case VEISD::VVP_SELECT:
    return Op->getOperand(2);
  default:
    break;
  }
  return SDValue();
}

SDValue getSelectOnTrueVal(SDValue Op) {
  switch (Op->getOpcode()) {
  case ISD::VSELECT:
  case ISD::SELECT:
  case ISD::VP_SELECT:
  case ISD::VP_MERGE:
    return Op->getOperand(1);
  case VEISD::VVP_SELECT:
    return Op->getOperand(0);
  default:
    break;
  }
  return SDValue();
}

SDValue getSelectOnFalseVal(SDValue Op) {
  switch (Op->getOpcode()) {
  case ISD::VSELECT:
  case ISD::SELECT:
  case ISD::VP_SELECT:
  case ISD::VP_MERGE:
    return Op->getOperand(2);
  case VEISD::VVP_SELECT:
    return Op->getOperand(1);
  default:
    break;
  }
  return SDValue();
}

SDValue VETargetLowering::lowerToVVP(SDValue Op, SelectionDAG &DAG,
                                     VVPExpansionMode Mode) const {

  LLVM_DEBUG(dbgs() << "::lowerToVVP\n");
  if (isMaskArithmetic(*Op.getNode())) {
    if (isPackedMaskType(Op.getValueType())) {
      LLVM_DEBUG(dbgs() << "Splitting packed mask arithmetic!\n");
      return splitVectorArithmetic(Op, DAG);
    }
    return Op;
  }

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
  if (Op->isVP())
    return lowerVPToVVP(Op, DAG, Mode);

  ///// Decide for a vector width /////
  VECustomDAG CDAG(*this, DAG, Op);
  VVPWideningInfo WidenInfo = pickResultType(CDAG, Op, Mode);

  if (!WidenInfo.isValid()) {
    LLVM_DEBUG(dbgs() << "Cannot derive widening info\n";);
    return SDValue();
  }

  // (64bit) packed required -> split!
  EVT ElemVT = OpVecTy.getVectorElementType();
  const bool IsOverPacked =
      ElemVT.getScalarSizeInBits() > 32 && WidenInfo.PackedMode;
  if (IsOverPacked)
    return splitVectorOp(Op, DAG, Mode);

  // Specialized code paths for normal or (32bit) packed.
  switch (Op->getOpcode()) {
  case ISD::BUILD_VECTOR:
  case ISD::VECTOR_SHUFFLE:
    return lowerVectorShuffleOp(Op, DAG, Mode);

  case ISD::EXTRACT_SUBVECTOR:
    return lowerVVP_EXTRACT_SUBVECTOR(Op, DAG, Mode);
  case ISD::SCALAR_TO_VECTOR:
    return lowerVVP_SCALAR_TO_VECTOR(Op, DAG, Mode);

  case ISD::LOAD:
  case ISD::MLOAD:
  case ISD::STORE:
  case ISD::MSTORE:
    return lowerVVP_MLOAD_MSTORE(Op, DAG, Mode);

  case ISD::MGATHER:
  case ISD::MSCATTER:
    return lowerVVP_MGATHER_MSCATTER(Op, DAG, Mode);
  }

  auto VVPOC = getVVPOpcode(Op.getOpcode());
  if (!VVPOC)
    return SDValue();

  ///// Translate to a VVP layer operation (VVP_* or VEC_*) /////
  bool IsTernaryOp = isVVPTernaryOp(*VVPOC);
  bool IsBinaryOp = isVVPBinaryOp(*VVPOC);
  bool IsUnaryOp = isVVPUnaryOp(*VVPOC);
  bool IsConvOp = isVVPConversionOp(*VVPOC);
  bool IsReduceOp = isVVPReductionOp(*VVPOC);

  // Generate a mask and an AVL.
  // auto TargetMasks = CDAG.createTargetMask(WidenInfo, SDValue(), SDValue());
  TargetMasks MaskingArgs;
  unsigned NumElems = OpVecTy.getVectorNumElements();
  MaskingArgs.AVL = CDAG.getConstEVL(NumElems);
  MaskingArgs.Mask = CDAG.createUniformConstMask(OpVecTy, true);

  ///// Widen the actual result type /////
  // FIXME We cannot use the idiomatic type here since that type reflects the
  // operatino vector width (and the element type does not matter as much).
  EVT ResVecTy = CDAG.legalizeVectorType(Op, Mode);

  // Copy operand list for new node.
  SmallVector<SDValue, 4> LegalOperands;
  for (unsigned i = 0; i < Op->getNumOperands(); ++i) {
    LegalOperands.push_back(Op->getOperand(i));
  }

  if (IsUnaryOp) {
    assert(VVPOC.hasValue());
    return CDAG.getNode(VVPOC.getValue(), ResVecTy,
                        {LegalOperands[0], MaskingArgs.Mask, MaskingArgs.AVL});
  }

  if (IsBinaryOp) {
    assert(VVPOC.hasValue());
    auto VVPN = CDAG.getLegalBinaryOpVVP(*VVPOC, ResVecTy, LegalOperands[0],
                                         LegalOperands[1], MaskingArgs.Mask,
                                         MaskingArgs.AVL, Op->getFlags());
    return VVPN;
  }

  if (IsTernaryOp) {
    assert(VVPOC.hasValue());
    switch (VVPOC.getValue()) {
    case VEISD::VVP_FFMA: {
      // VE has a swizzled operand order in FMA (compared to LLVM IR and
      // SDNodes).
      return CDAG.getNode(VVPOC.getValue(), ResVecTy,
                          {LegalOperands[2], LegalOperands[0], LegalOperands[1],
                           MaskingArgs.Mask, MaskingArgs.AVL});
    }
    case VEISD::VVP_SETCC: {
      return CDAG.getNode(VVPOC.getValue(), ResVecTy,
                          {LegalOperands[0], LegalOperands[1], LegalOperands[2],
                           MaskingArgs.Mask, MaskingArgs.AVL});
    }
    case VEISD::VVP_SELECT: {
      SDValue CondMask = getSelectMask(Op);
      SDValue OnTrue = getSelectOnTrueVal(Op);
      SDValue OnFalse = getSelectOnFalseVal(Op);
      return expandSELECT(CondMask, OnTrue, OnFalse, ResVecTy, CDAG,
                          MaskingArgs.AVL);
    }
    default:
      llvm_unreachable("Unexpected ternary operator!");
    }
  }

  if (IsConvOp) {
    return CDAG.getLegalConvOpVVP(VVPOC.getValue(), ResVecTy, LegalOperands[0],
                                  MaskingArgs.Mask, MaskingArgs.AVL);
  }

  if (IsReduceOp) {
    auto HasStartV = getVVPReductionStartParamPos(VVPOC.getValue());
    SDValue StartV = HasStartV ? LegalOperands[0] : SDValue();
    SDValue VectorV = HasStartV ? LegalOperands[1] : LegalOperands[0];
    assert(VVPOC.hasValue());
    return CDAG.getLegalReductionOpVVP(*VVPOC, ResVecTy, StartV, VectorV,
                                       MaskingArgs.Mask, MaskingArgs.AVL,
                                       Op->getFlags());
  }

  llvm_unreachable("Cannot lower this op to VVP");

  abort(); // TODO implement
}

SDValue VETargetLowering::legalizeInternalLoadStoreOp(SDValue Op,
                                                      VECustomDAG &CDAG) const {
  LLVM_DEBUG(dbgs() << "Legalize this VVP LOAD, STORE\n");

  EVT DataVT = *getIdiomaticType(Op.getNode());

  // Ignore the VLD mask as an optimization.
  if (!isPackedVectorType(DataVT) &&
      (Op->getOpcode() == VEISD::VVP_LOAD && OptimizeVectorMemory)) {
    auto AllTrueMask = CDAG.createUniformConstMask(MVT::v256i1, true);
    SDValue LegalAVL = CDAG.annotateLegalAVL(Op.getOperand(4));
    return CDAG.getVVPLoad(Op.getValueType(), Op.getOperand(0),
                           Op.getOperand(1), Op.getOperand(2), AllTrueMask,
                           LegalAVL);
  }

  if (!isPackedVectorType(DataVT)) {
    LLVM_DEBUG(dbgs() << "Legal!\n");
    return Op;
  }

  // TODO: Get better at inferring 'even' AVLs and all true masks.
  SDValue AVL = getAnnotatedNodeAVL(Op).first;
  SDValue Mask = getNodeMask(Op);
  // TODO: this can be refined.. the mask has to be compactable for stores.
  bool IsPackable = isPackableLoadStore(Op);
  if (!IsPackable)
    return splitLoadStore(Op, CDAG.DAG, VVPExpansionMode::ToNativeWidth);

  // Packed load/store require special treatment
  // - The mask refers to packs of 2x32 elements
  // - A VLD/VST for 64bits has a different byte order than 2x32bit op (32bit elements swapped).
  auto WidenInfo = pickResultType(CDAG, Op, VVPExpansionMode::ToNativeWidth);
  auto TargetMask = CDAG.createTargetMask(WidenInfo, Mask, AVL);

  SDValue PackStride = getLoadStoreStride(Op, CDAG);
  auto DoubledStride = getSplitPtrStride(PackStride, CDAG);
  auto NormalMask = CDAG.createUniformConstMask(MVT::v256i1, true);
  auto Chain = Op->getOperand(0);
  SDValue PackPtr = getMemoryPtr(Op);

  TargetMask.AVL = CDAG.annotateLegalAVL(TargetMask.AVL);

  // Be optimistic about loads.. (FIXME: implies OptimizeVectorMemory cl::opt).
  if (Op->getOpcode() == VEISD::VVP_LOAD) {
    SDValue LoadV = CDAG.getVVPLoad(Op.getValueType(), Chain, PackPtr, DoubledStride,
                                    NormalMask, TargetMask.AVL);

    SDValue SwappedValue = CDAG.createSwap(LoadV.getValueType(), LoadV, TargetMask.AVL);
    return CDAG.getMergeValues({SwappedValue, SDValue(LoadV.getNode(), 1)});
  }

  SDValue PackedMask = getNodeMask(Op);
  SDValue PackedData = Op->getOperand(1);
  SDValue SwappedData = CDAG.createSwap(PackedData.getValueType(), PackedData, TargetMask.AVL);

  assert(isAllTrueMask(PackedMask) && "TODO in-place expand masked VST");
  return CDAG.getVVPStore(Chain, SwappedData, PackPtr, DoubledStride, NormalMask,
                          TargetMask.AVL);
}

SDValue VETargetLowering::legalizeVM_POPCOUNT(SDValue Op,
                                              SelectionDAG &DAG) const {
  LLVM_DEBUG(dbgs() << "::LegalizeVM_POPCOUNT\n";);
  auto Mask = Op->getOperand(0);
  auto AVL = Op->getOperand(1);
  if (!isPackedVectorType(Mask.getValueType()))
    return Op;

  VECustomDAG CDAG(*this, DAG, Op);
  SDValue LoMask = CDAG.createUnpack(MVT::v256i1, Mask, PackElem::Lo, AVL);
  SDValue LoCount = CDAG.createMaskPopcount(LoMask, AVL);
  SDValue HiMask = CDAG.createUnpack(MVT::v256i1, Mask, PackElem::Hi, AVL);
  SDValue HiCount = CDAG.createMaskPopcount(HiMask, AVL);
  return CDAG.getNode(ISD::ADD, MVT::i64, {LoCount, HiCount});
}

SDValue VETargetLowering::legalizeInternalVectorOp(SDValue Op,
                                                   SelectionDAG &DAG) const {
  LLVM_DEBUG(dbgs() << "Legalize this VVP or VEC operation: ";
             Op->print(dbgs(), &DAG); dbgs() << "\n");
  // Already legal.
  if (isPackingSupportOpcode(Op->getOpcode()))
    return Op;

  // Otw, widen this VVP operation to the next OR native vector width
  Optional<EVT> OpVecTyOpt = getIdiomaticType(Op.getNode());
  assert(OpVecTyOpt);
  EVT OpVecTy = OpVecTyOpt.getValue();

  // Check how this should be handled.
  VECustomDAG CDAG(*this, DAG, Op);
  VVPWideningInfo WidenInfo =
      pickResultType(CDAG, Op, VVPExpansionMode::ToNativeWidth);
  unsigned VVPOpc = Op->getOpcode();
  switch (VVPOpc) {
  default:
    break;
  case VEISD::VM_POPCOUNT:
    return legalizeVM_POPCOUNT(Op, DAG);

    // More refined treatment of masked load/store.
  case VEISD::VVP_LOAD:
  case VEISD::VVP_STORE:
    return legalizeInternalLoadStoreOp(Op, CDAG);
  }

  // Do we need to perform splitting?
  if (WidenInfo.PackedMode && !supportsPackedMode(VVPOpc, OpVecTy))
    return splitVectorOp(Op, DAG, VVPExpansionMode::ToNativeWidth);

  // This is a packed mode operation -> we (may) need to legalize AVL to refer
  // to packs (2x32) instead of elements (32).
  return legalizePackedAVL(Op, CDAG);
}

SDValue VETargetLowering::splitGatherScatter(SDValue Op, SelectionDAG &DAG,
                                             VVPExpansionMode Mode) const {

  LLVM_DEBUG(dbgs() << "::splitGatherScatter\n";);

  VECustomDAG CDAG(*this, DAG, Op);

  SDValue PackAVL = getAnnotatedNodeAVL(Op).first;
  SDValue Chain = getNodeChain(Op);
  SDValue BasePtr = getMemoryPtr(Op);
  SDValue Scale = getGatherScatterScale(Op);
  SDValue PackPassThru = getNodePassthru(Op);
  SDValue PackStoredValue = getStoredValue(Op);
  SDValue PackIndex = getGatherScatterIndex(Op);
  SDValue PackMask = getNodeMask(Op);

  if (PackPassThru && PackPassThru->isUndef())
    PackPassThru = SDValue();

  VVPWideningInfo WidenInfo = pickResultType(CDAG, Op, Mode);

  const bool IsScatter = (bool)PackStoredValue;
  const unsigned ChainResIdx = IsScatter ? 0 : 1;

  EVT OldDataVT =
      IsScatter ? PackStoredValue.getValueType() : Op.getValueType();
  EVT LegalDataVT = LegalizeVectorType(OldDataVT, Op, DAG, Mode);
  const bool SplitPassThru = PackPassThru && isOverPackedType(OldDataVT);

  EVT SplitDataVT = CDAG.splitVectorType(OldDataVT);

  bool IsOverPackedSplit = isOverPackedType(OldDataVT);

  SDValue PartOps[2];
  SmallVector<SDValue, 2> PartChains(2);
  SDValue UpperPartAVL; // we will use this for packing things back together
  for (PackElem Part : {PackElem::Hi, PackElem::Lo}) {
    // BaseBtr := BasePtr + Scale * Offset.

    auto SplitTM =
        CDAG.createTargetSplitMask(WidenInfo, PackMask, PackAVL, Part);

    // Only splitting non-over-packed packed will result in a legal AVL.
    if (!IsOverPackedSplit)
      SplitTM.AVL = CDAG.annotateLegalAVL(SplitTM.AVL);

    // Keep track of the (higher) lvl.
    if (Part == PackElem::Hi)
      UpperPartAVL = SplitTM.AVL;

    // Expand to index computation.
    // If splitGatherScatter is called on a VVP_GATHER or VVP_SCATTER node this
    // has already happened during lower(VP)ToVVP.
    SDValue PartPtr;
    if (PackIndex) {
      SDValue PartIndex = CDAG.extractPackElem(PackIndex, Part, SplitTM.AVL);
      PartPtr = computeGatherScatterAddress(CDAG, BasePtr, Scale, PartIndex,
                                            SplitTM.Mask, SplitTM.AVL);
    } else {
      PartPtr = CDAG.extractPackElem(BasePtr, Part, SplitTM.AVL);
    }

    // Scatter.
    SDValue PartOp;
    if (IsScatter) {
      SDValue PartStoredValue =
          CDAG.extractPackElem(PackStoredValue, Part, SplitTM.AVL);
      PartOp = CDAG.getVVPScatter(Chain, PartStoredValue, PartPtr, SplitTM.Mask,
                                  SplitTM.AVL);
    } else {
      // Gather.
      PartOp = CDAG.getVVPGather(SplitDataVT, Chain, PartPtr, SplitTM.Mask,
                                 SplitTM.AVL);
    }

    PartChains[(int)Part] = SDValue(PartOp.getNode(), ChainResIdx);

    // Overpacked passthru.
    if (SplitPassThru && PackPassThru) {
      SDValue PartPassThru =
          CDAG.extractPackElem(PackPassThru, Part, SplitTM.AVL);
      PartOp = CDAG.createSelect(SplitDataVT, PartOp, PartPassThru,
                                 SplitTM.Mask, SplitTM.AVL);
    }

    PartOps[(int)Part] = PartOp;
  }

  // Join chains.
  SDValue FusedChains = DAG.getTokenFactor(CDAG.DL, PartChains);

  if (IsScatter)
    return FusedChains;

  SDValue RePackedValue =
      CDAG.createPack(LegalDataVT, PartOps[(int)PackElem::Lo],
                      PartOps[(int)PackElem::Hi], UpperPartAVL);

  // Packed passthru?
  if (PackPassThru && !SplitPassThru)
    RePackedValue = CDAG.createSelect(LegalDataVT, RePackedValue, PackPassThru,
                                      PackMask, PackAVL);

  return CDAG.getMergeValues({RePackedValue, FusedChains});
}

SDValue
VETargetLowering::lowerVVP_MGATHER_MSCATTER(SDValue Op, SelectionDAG &DAG,
                                            VVPExpansionMode Mode,
                                            VecLenOpt VecLenHint) const {
  LLVM_DEBUG(dbgs() << "::lowerVVP_MGATHER_MSCATTER\n";);

  VECustomDAG CDAG(*this, DAG, Op);
  auto MemN = cast<MemSDNode>(Op.getNode());
  EVT OldDataVT = MemN->getMemoryVT();
  EVT LegalDataVT = LegalizeVectorType(OldDataVT, Op, DAG, Mode);

  SDValue AVL = getAnnotatedNodeAVL(Op).first;
  SDValue Index = getGatherScatterIndex(Op);
  SDValue BasePtr = getMemoryPtr(Op);
  SDValue Mask = getNodeMask(Op);
  SDValue Chain = getNodeChain(Op);
  SDValue Scale = getGatherScatterScale(Op);
  SDValue PassThru = getNodePassthru(Op);
  SDValue StoredValue = getStoredValue(Op);
  if (PassThru && PassThru->isUndef())
    PassThru = SDValue();

  bool IsScatter = (bool)StoredValue;

  // Immediately split over-packed operations.
  EVT DataVT = IsScatter ? StoredValue.getValueType() : Op.getValueType();
  if (isOverPackedType(DataVT))
    return splitGatherScatter(Op, DAG, Mode);

  // Infer AVL.
  AVL = CDAG.inferAVL(AVL, Mask, OldDataVT);

  // Legalize the index type..
  EVT IndexVT = CDAG.getVectorVT(Index.getValueType().getVectorElementType(),
                                 LegalDataVT.getVectorNumElements());

  // Widen the index.
  Index = CDAG.widenOrNarrow(IndexVT, Index);

  SDValue AddressVec =
      computeGatherScatterAddress(CDAG, BasePtr, Scale, Index, Mask, AVL);
  if (IsScatter)
    return CDAG.getVVPScatter(Chain, StoredValue, AddressVec, Mask, AVL);

  // Gather.
  SDValue NewLoadV =
      CDAG.getVVPGather(LegalDataVT, Chain, AddressVec, Mask, AVL);

  if (!PassThru)
    return NewLoadV;

  // TODO: Use vvp_select
  SDValue DataV =
      CDAG.DAG.getSelect(CDAG.DL, LegalDataVT, Mask, NewLoadV, PassThru);
  SDValue NewLoadChainV = SDValue(NewLoadV.getNode(), 1);
  return CDAG.getMergeValues({DataV, NewLoadChainV});
}

SDValue
VETargetLowering::lowerVVP_EXTRACT_SUBVECTOR(SDValue Op, SelectionDAG &DAG,
                                             VVPExpansionMode Mode) const {
  auto SrcVec = Op.getOperand(0);
  auto BaseIdxN = Op.getOperand(1);

  assert(isa<ConstantSDNode>(BaseIdxN) && "TODO dynamic extract");
  VECustomDAG CDAG(*this, DAG, Op);
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

SDValue VETargetLowering::lowerReduction_VPToVVP(SDValue Op, SelectionDAG &DAG,
                     VVPExpansionMode Mode) const {
  LLVM_DEBUG(dbgs() << "::lowerReduction_VPToVVP\n");

  // Check whether this should be Widened to VVP
  VECustomDAG CDAG(*this, DAG, Op);
  VVPWideningInfo WidenInfo = pickResultType(CDAG, Op, Mode);

  if (!WidenInfo.isValid()) {
    LLVM_DEBUG(dbgs() << "Cannot Custom-VVP-widen this VP operator.\n");
    return SDValue();
  }

  // (64bit) packed required -> split!
  auto OpVecTy = *getIdiomaticType(Op.getNode());
  EVT ElemVT = OpVecTy.getVectorElementType();
  const bool IsOverPacked =
      ElemVT.getScalarSizeInBits() > 32 && WidenInfo.PackedMode;
  if (IsOverPacked)
    return splitVectorOp(Op, DAG, Mode);

  // create suitable mask and avl parameters (accounts for packing)
  PosOpt MaskPos = Op->getVPMaskPos();
  PosOpt AVLPos = Op->getVPVectorLenPos();
  SDValue Mask = getNodeMask(Op);
  SDValue AVL = getNodeAVL(Op);

  unsigned OPC = Op->getOpcode();
  unsigned VVPOC = *getVVPOpcode(OPC);

  std::vector<SDValue> OpVec;
  // Default.
  unsigned NumOps = Op.getNumOperands();
  for (unsigned i = 0; i < NumOps; ++i) {
    if (MaskPos && (i == MaskPos)) {
      OpVec.push_back(Mask);
      continue;
    }
    if (AVLPos && (i == AVLPos)) {
      OpVec.push_back(AVL);
      continue;
    }
    OpVec.push_back(Op.getOperand(i));
  }
  // Create a matching VVP_* node
  EVT NewResVT = CDAG.legalizeVectorType(Op, Mode);
  assert(WidenInfo.isValid() && "Cannot widen this VP op into VVP");
  SDValue NewV = CDAG.getLegalOpVVP(VVPOC, NewResVT, OpVec);
  NewV->setFlags(Op->getFlags());
  return NewV;
}

SDValue VETargetLowering::lowerVPToVVP(SDValue Op, SelectionDAG &DAG,
                                       VVPExpansionMode Mode) const {
  LLVM_DEBUG(dbgs() << "::lowerVPToVVP\n");
  auto VVPOC = getVVPForVP(Op.getOpcode());
  if (VVPOC && isVVPReductionOp(*VVPOC))
    return lowerReduction_VPToVVP(Op, DAG, Mode);

  // TODO VP reductions
  switch (Op.getOpcode()) {
  case ISD::VP_VSHIFT:
    // Lowered to VEC_VMV (inverted shift amount)
    return lowerVP_VSHIFT(Op, DAG);

  case ISD::VP_LOAD:
  case ISD::VP_STORE:
    return lowerVVP_MLOAD_MSTORE(Op, DAG, VVPExpansionMode::ToNativeWidth);

  case ISD::VP_GATHER:
  case ISD::VP_SCATTER:
    return lowerVVP_MGATHER_MSCATTER(Op, DAG, VVPExpansionMode::ToNativeWidth,
                                     None);

  default:
    break;
  }


  // Check whether this should be Widened to VVP
  VECustomDAG CDAG(*this, DAG, Op);
  VVPWideningInfo WidenInfo = pickResultType(CDAG, Op, Mode);

  if (!WidenInfo.isValid()) {
    LLVM_DEBUG(dbgs() << "Cannot Custom-VVP-widen this VP operator.\n");
    return SDValue();
  }

  // (64bit) packed required -> split!
  auto OpVecTy = *getIdiomaticType(Op.getNode());
  EVT ElemVT = OpVecTy.getVectorElementType();
  const bool IsOverPacked =
      ElemVT.getScalarSizeInBits() > 32 && WidenInfo.PackedMode;
  if (IsOverPacked)
    return splitVectorOp(Op, DAG, Mode);

  // create suitable mask and avl parameters (accounts for packing)
  PosOpt MaskPos = Op->getVPMaskPos();
  PosOpt AVLPos = Op->getVPVectorLenPos();
  SDValue Mask = getNodeMask(Op);
  SDValue AVL = getNodeAVL(Op);

  std::vector<SDValue> OpVec;
  if (*VVPOC == VEISD::VVP_FFMA) {
    // Custom FMA re-ordering..
    OpVec.push_back(Op->getOperand(2));
    OpVec.push_back(Op->getOperand(0));
    OpVec.push_back(Op->getOperand(1));
    OpVec.push_back(Mask);
    OpVec.push_back(AVL);
  } else if (*VVPOC == VEISD::VVP_SELECT) {
    OpVec.push_back(getSelectOnTrueVal(Op));
    OpVec.push_back(getSelectOnFalseVal(Op));
    OpVec.push_back(Mask);
    OpVec.push_back(AVL);
  } else {
    // Default.
    unsigned NumOps = Op.getNumOperands();
    for (unsigned i = 0; i < NumOps; ++i) {
      if (MaskPos && (i == MaskPos)) {
        OpVec.push_back(Mask);
        continue;
      }
      if (AVLPos && (i == AVLPos)) {
        OpVec.push_back(AVL);
        continue;
      }
      OpVec.push_back(Op.getOperand(i));
    }
  }

  // Create a matching VVP_* node
  EVT NewResVT = CDAG.legalizeVectorType(Op, Mode);
  assert(WidenInfo.isValid() && "Cannot widen this VP op into VVP");
  SDValue NewV = CDAG.getLegalOpVVP(*VVPOC, NewResVT, OpVec);
  NewV->setFlags(Op->getFlags());
  return NewV;
}

// static bool isMisalignedVectorLoadStore(SDValue MemoryOp,  ) {
// }

SDValue VETargetLowering::lowerVVP_MLOAD_MSTORE(SDValue Op, SelectionDAG &DAG,
                                                VVPExpansionMode Mode,
                                                VecLenOpt VecLenHint) const {
  LLVM_DEBUG(dbgs() << "Lowering VP/MLOAD/MSTORE to VVP\n");
  LLVM_DEBUG(Op.dumpr(&DAG));
  VECustomDAG CDAG(*this, DAG, Op);

  auto VVPOpc = *getVVPOpcode(Op->getOpcode());
  const bool IsLoad = (VVPOpc == VEISD::VVP_LOAD);

  // Shares.
  SDValue BasePtr = getMemoryPtr(Op);
  SDValue Mask = getNodeMask(Op);
  SDValue Chain = getNodeChain(Op);
  SDValue AVL = getAnnotatedNodeAVL(Op).first;
  // Store specific.
  SDValue Data = getStoredValue(Op);
  // Load specific.
  SDValue PassThru = getNodePassthru(Op);
  if (PassThru && PassThru->isUndef())
    PassThru = SDValue();

  MemSDNode &MemN = *cast<MemSDNode>(Op.getNode());
  EVT OldDataVT = MemN.getMemoryVT();
  EVT LegalDataVT = LegalizeVectorType(OldDataVT, Op, DAG, Mode);

  // Eagerly split over-packed vectors.
  if (isOverPackedType(OldDataVT))
    return splitLoadStore(Op, DAG, Mode);

  // Eagerly split un-aligned vector loads.
  if (!AssumeBestAlignment) {
    // FIXME: This only catches the un-aligned packed-mode case.
    auto Align = MemN.getAlign();
    if (isPackedVectorType(OldDataVT) && Align.value() < 8) 
      return splitLoadStore(Op, DAG, Mode);
  }

  // Infer a AVL value from all available hints.
  AVL = CDAG.inferAVL(AVL, Mask, OldDataVT);

  // Default to the all-true mask.
  if (!Mask) {
    Packing P = getPackingForVT(LegalDataVT);
    Mask = CDAG.createUniformConstMask(P, true);
  }

  uint64_t ElemBytes = LegalDataVT.getVectorElementType().getStoreSize();
  auto StrideV = CDAG.getConstant(ElemBytes, MVT::i64);

  if (IsLoad) {
    // Emit.
    auto NewLoadV = CDAG.getNode(VEISD::VVP_LOAD, {LegalDataVT, MVT::Other},
                                 {Chain, BasePtr, StrideV, Mask, AVL});

    if (!PassThru)
      return NewLoadV;

    // Re-introduce passthru as a select.
    // TODO: Use vvp_select.
    SDValue DataV = CDAG.DAG.getSelect(CDAG.DL, Op.getSimpleValueType(), Mask,
                                       NewLoadV, PassThru);
    SDValue NewLoadChainV = SDValue(NewLoadV.getNode(), 1);

    // Merge them back into one node.
    return CDAG.getMergeValues({DataV, NewLoadChainV});
  }

  // VVP_STORE
  assert(VVPOpc == VEISD::VVP_STORE);
  return CDAG.getNode(VEISD::VVP_STORE, Op.getNode()->getVTList(),
                      {Chain, Data, BasePtr, StrideV, Mask, AVL});
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

  // Lowering to VM_INSERT
  EVT VecVT = Op.getValueType();
  SDValue SrcV = Op.getOperand(0);
  SDValue ElemV = Op.getOperand(1);
  SDValue IndexV = Op.getOperand(2);
  VECustomDAG CDAG(*this, DAG, Op);

  if (SDValue ActualMaskV = PeekForMask(SrcV)) {
    // FIXME: Need to translate index!
    assert((Op.getValueType() == MVT::i64) && "not a proper mask extraction");
    return CDAG.createInsertMask(ActualMaskV, ElemV, IndexV);
  }

  // FIXME: Fallback to dynamic index implementation.
  if (!isa<ConstantSDNode>(IndexV)) {
    return lowerSIMD_INSERT_VECTOR_ELT(Op, DAG);
  }

  uint64_t ConstIdx = cast<ConstantSDNode>(IndexV)->getZExtValue();

  // Packed insert.
  if (VecVT == MVT::v512i32 || VecVT == MVT::v512f32) {
    // ZExt Idx to i64.
    auto IdxVT = IndexV.getValueType();
    if (IdxVT == MVT::i32)
      IndexV = CDAG.getNode(ISD::ZERO_EXTEND, MVT::i64, IndexV);

    uint64_t ConstIdx = cast<ConstantSDNode>(IndexV)->getZExtValue();
    SDValue HalfConstIdx = CDAG.getConstant(ConstIdx / 2, MVT::i64);

    MVT ElemVT = ElemV.getSimpleValueType();
    bool InsertFromLo = ElemVT == MVT::i32;
    bool InsertIntoLo = ConstIdx % 2;

    // Upcast Val to i64.
    auto ElemSubRegIdx = (ElemVT == MVT::f32) ? VE::sub_f32 : VE::sub_i32;
    ElemV = CDAG.getTargetInsertSubreg(ElemSubRegIdx, MVT::i64, ElemV,
                                       CDAG.getUndef(MVT::i64));

    // TODO: Factor into CustomDAG {
    // Move to right position and zero-fill opposing 32bit subreg
    bool ShiftUp = (!InsertIntoLo && InsertFromLo);
    bool ShiftDown = (InsertIntoLo && !InsertFromLo);
    if (ShiftUp) {
      ElemV = CDAG.getNode(ISD::SHL, MVT::i64, {ElemV, CDAG.getConstant(32, MVT::i32)});
    } else if (ShiftDown) {
      ElemV = CDAG.getNode(ISD::SRL, MVT::i64, {ElemV, CDAG.getConstant(32, MVT::i32)});
    } else {
      // Right position -> only zero fill.
      // Inverted mask to keep the passthru element.
      SDValue ElemMask = CDAG.getConstant(
          InsertFromLo  ? 0x00000000FFFFFFFFUL : 0xFFFFFFFF00000000UL, MVT::i64);
      ElemV = CDAG.getNode(ISD::AND, MVT::i64, {ElemV, ElemMask});
    }
    // } TODO: Factor into CustomDAG

    // Re-cast SrcV (passthru) to v256i64.
    SDValue Passthru = DAG.getBitcast(MVT::v256i64, SrcV);
    SDValue PackedElt = CDAG.getNode(ISD::EXTRACT_VECTOR_ELT, MVT::i64, {Passthru, HalfConstIdx});
    
    // Extract element and zero out opposing part.
    SDValue PTMask = CDAG.getConstant(
        InsertIntoLo ? 0xFFFFFFFF00000000UL : 0x00000000FFFFFFFFUL, MVT::i64);
    SDValue MaskedPT = CDAG.getNode(ISD::AND, MVT::i64, {PackedElt, PTMask});

    // Blend passthru and new elements
    PackedElt = CDAG.getNode(ISD::OR, MVT::i64, {ElemV, MaskedPT});

    // Re-insert modifier 64 bit chunk
    SDValue WithElement = CDAG.getNode(ISD::INSERT_VECTOR_ELT, MVT::v256i64,
                                       {Passthru, PackedElt, HalfConstIdx});

    // Re-cast to original type.
    return DAG.getBitcast(VecVT, WithElement);
  }

  // Overpacked operation.
  if (VecVT == MVT::v512i64 || VecVT == MVT::v512f64) {
    auto Part = getPartForLane(ConstIdx);

    // Meaningful AVL, unused in codegen.
    SDValue AVL = CDAG.getConstEVL(256);

    // Split into part to keep and part to modify.
    auto PartVT = (VecVT == MVT::v512i64) ? MVT::v256i64 : MVT::v256f64;
    auto UnpackedMod = CDAG.createUnpack(PartVT, SrcV, Part, AVL);
    auto UnpackedKeep =
        CDAG.createUnpack(PartVT, SrcV, getOtherPart(Part), AVL);

    // Insert into subreg.
    auto PackIdx = CDAG.getConstant(ConstIdx / 2, IndexV.getValueType());
    auto PartInsert = CDAG.getNode(ISD::INSERT_VECTOR_ELT, PartVT,
                                   {UnpackedMod, ElemV, PackIdx});
    auto LoweredInsert = lowerSIMD_INSERT_VECTOR_ELT(PartInsert, DAG);

    // Re-package.
    SDValue NewLo = Part == PackElem::Lo ? LoweredInsert : UnpackedKeep;
    SDValue NewHi = Part == PackElem::Hi ? LoweredInsert : UnpackedKeep;
    return CDAG.createPack(VecVT, NewLo, NewHi, AVL);
  }

  llvm_unreachable("Unsupported insert_vector_elt");
}

SDValue VETargetLowering::lowerVVP_EXTRACT_VECTOR_ELT(SDValue Op,
                                                      SelectionDAG &DAG) const {
  SDValue SrcV = Op->getOperand(0);
  SDValue IndexV = Op->getOperand(1);
  MVT VecVT = SrcV.getSimpleValueType();

  // Lowering to VM_EXTRACT
  if (SDValue MaskV = PeekForMask(SrcV)) {
    auto IndexC = dyn_cast<ConstantSDNode>(IndexV);
    // assert(IndexC && "Mask extraction at dynamic offset not implemented!");
    if (!IndexC)
      return SDValue(); // Expand.

    assert(Op.getValueType().isScalarInteger());
    // unsigned ResSize = Op.getValueType().getSizeInBits(); // Implicit
    EVT MaskVT = Op.getOperand(0).getValueType();
    unsigned PartSize = MaskVT.getVectorElementType().getSizeInBits();

    const unsigned SXRegSize = 64;

    VECustomDAG CDAG(*this, DAG, Op);

    // determine the adjusted extraction index
    SDValue AdjIndexV = IndexV;
    unsigned ShiftAmount = 0;
    if (PartSize != 64) {
      unsigned PartIdx = IndexC->getZExtValue();
      unsigned AbsOffset = PartSize * PartIdx; // bit offset
      unsigned ActualPart =
          AbsOffset / SXRegSize; // actual part when chunked into 64bit elements
      assert(ActualPart < getMaskBits(MaskVT) / SXRegSize &&
             "Mask bits out of range!");
      AdjIndexV = CDAG.getConstant(ActualPart, MVT::i32);

      // Missing shift amount to isolate the wanted bit
      ShiftAmount = AbsOffset - (ActualPart * SXRegSize);
    }

    auto ResV = CDAG.createExtractMask(MaskV, AdjIndexV);
    ResV = CDAG.createScalarShift(MVT::i64, ResV, ShiftAmount);

    // Convert back to actual result type
    return CDAG.DAG.getAnyExtOrTrunc(ResV, CDAG.DL, Op.getValueType());
  }

  if (!isa<ConstantSDNode>(IndexV)) {
    // Dynamic extraction or packed extract.
    return lowerSIMD_EXTRACT_VECTOR_ELT(Op, DAG);
  }

  uint64_t ConstIdx = cast<ConstantSDNode>(IndexV)->getZExtValue();
  VECustomDAG CDAG(*this, DAG, Op);
  
  // Packed extract.
  if (VecVT == MVT::v512i32 || VecVT == MVT::v512f32) {
    bool ExtractLo = ConstIdx % 2;

    // ZExt Idx to i64.
    auto IdxVT = IndexV.getValueType();
    if (IdxVT == MVT::i32)
      IndexV = CDAG.getNode(ISD::ZERO_EXTEND, MVT::i64, IndexV);

    MVT ElemVT = VecVT.getVectorElementType();
    SDValue HalfConstIdx = CDAG.getConstant(ConstIdx / 2, MVT::i64);

    // Re-cast SrcV (passthru) to v256i64.
    SDValue Passthru = DAG.getBitcast(MVT::v256i64, SrcV);
    SDValue PackedElt = CDAG.getNode(ISD::EXTRACT_VECTOR_ELT, MVT::i64, {Passthru, HalfConstIdx});

    // FIXME: Redundant  
    // Shift to right position
    bool ImplicitZExt = false;
    bool ShiftUp = (ExtractLo && ElemVT == MVT::f32);
    if (ShiftUp) {
      PackedElt = CDAG.getNode(ISD::SHL, MVT::i64, {PackedElt, CDAG.getConstant(32, MVT::i32)});
    }
    bool ShiftDown = (!ExtractLo && ElemVT == MVT::i32);
    if (ShiftDown) {
      PackedElt = CDAG.getNode(ISD::SRL, MVT::i64, {PackedElt, CDAG.getConstant(32, MVT::i32)});
      ImplicitZExt = true;
    }

    // Convert type
    auto ElemSubRegIdx = (ElemVT == MVT::f32) ? VE::sub_f32 : VE::sub_i32;
    SDValue Res = CDAG.getTargetExtractSubreg(ElemVT, ElemSubRegIdx, PackedElt);
    if (ElemVT == MVT::i32 && !ImplicitZExt) {
      // ABI assumes zext i32 in scalar registers.
      Res = DAG.getZExtOrTrunc(Res, CDAG.DL, MVT::i64);
      return CDAG.getTargetExtractSubreg(ElemVT, VE::sub_i32, Res);
    }
    return Res;
  }

  // Overpacked operation.
  if (VecVT == MVT::v512i64 || VecVT == MVT::v512f64) {
    if (!isa<ConstantSDNode>(IndexV)) {
      errs() << "TODO: Cannot lower dynamic index element extract!\n";
      abort();
    }
    uint64_t ConstIdx = cast<ConstantSDNode>(IndexV)->getZExtValue();
    auto Part = getPartForLane(ConstIdx);
    VECustomDAG CDAG(*this, DAG, Op);

    // Meaningful AVL, unused in codegen.
    SDValue AVL = CDAG.getConstEVL(256);

    // Split-off part to extract from.
    auto PartVT = (VecVT == MVT::v512i64) ? MVT::v256i64 : MVT::v256f64;
    auto UnpackedMod = CDAG.createUnpack(PartVT, SrcV, Part, AVL);

    // Extract from subreg.
    auto PackIdx = CDAG.getConstant(ConstIdx / 2, IndexV.getValueType());
    SDValue ExtractFromPart = CDAG.getNode(
        ISD::EXTRACT_VECTOR_ELT, Op.getValueType(), {UnpackedMod, PackIdx});

    return lowerSIMD_EXTRACT_VECTOR_ELT(ExtractFromPart, DAG);
  }

  llvm_unreachable("Unsupported extract_vector_element");
}

SDValue VETargetLowering::synthesizeView(MaskView &MV, EVT LegalResVT,
                                         VECustomDAG &CDAG) const {
  if (isMaskType(LegalResVT)) {
    MaskShuffleAnalysis MSA(MV, CDAG);
    return MSA.synthesize(CDAG, LegalResVT);
  }

  ShuffleAnalysis LoVSA(MV);
  if (LoVSA.analyze() == ShuffleAnalysis::CanSynthesize)
    return LoVSA.synthesize(CDAG, LegalResVT);
  return SDValue();
}

SDValue VETargetLowering::splitVectorShuffle(SDValue Op, VECustomDAG &CDAG,
                                             VVPExpansionMode Mode) const {
  EVT LegalResVT = CDAG.legalizeVectorType(Op, Mode);
  SplitView Split = requestSplitView(Op.getNode(), CDAG);
  assert(Split.isValid() && "Could not split this over-packed vector shuffle");

  EVT LegalSplitVT = CDAG.splitVectorType(LegalResVT);

  // Synthesize 'lo'
  SDValue LoRes = synthesizeView(*Split.LoView, LegalSplitVT, CDAG);
  assert(LoRes && "Could not synthesize 'lo' shuffle.");

  // Synthesize 'hi'
  SDValue HiRes = synthesizeView(*Split.HiView, LegalSplitVT, CDAG);
  assert(HiRes && "Could not synthesize 'lo' shuffle.");

  // Re-package
  return CDAG.createPack(LegalResVT, LoRes, HiRes, CDAG.getConstEVL(256));
}

SDValue VETargetLowering::lowerVectorShuffleOp(SDValue Op, SelectionDAG &DAG,
                                               VVPExpansionMode Mode) const {
  VECustomDAG CDAG(*this, DAG, Op);

  std::unique_ptr<MaskView> MView(requestMaskView(Op.getNode()));

  EVT LegalResVT = CDAG.legalizeVectorType(Op, Mode);

#if 0
  // mask to shift + OR expansion
  if (isMaskType(Op.getValueType())) {
    // TODO isMaskType(Op.getValueType())) {
    MaskShuffleAnalysis MSA(*MView.get(), CDAG);
    return MSA.synthesize(CDAG, LegalResVT);
  }
#endif

  // If there is just one element, expand to INSERT_VECTOR_ELT.
  unsigned UniqueIdx;
  if (getUniqueInsertion(Op.getNode(), UniqueIdx)) {
    SDValue AccuV = DAG.getUNDEF(Op.getValueType());
    auto ElemV = Op->getOperand(UniqueIdx);
    SDValue IdxV = CDAG.getConstant(UniqueIdx, MVT::i64);
    return CDAG.getNode(ISD::INSERT_VECTOR_ELT, Op.getValueType(),
                        {AccuV, ElemV, IdxV});
  }

  LLVM_DEBUG(dbgs() << "Lowering Shuffle (non-vmask path)\n");
  // ShuffleVectorSDNode *ShuffleInstr =
  // cast<ShuffleVectorSDNode>(Op.getNode());

  // Try to synthesize in one go
  if (isOverPackedType(LegalResVT))
    return splitVectorShuffle(Op, CDAG, Mode);

  std::unique_ptr<MaskView> VecView(requestMaskView(Op.getNode()));
  assert(VecView && "Cannot lower this shufffle..");
  SDValue Res = synthesizeView(*VecView, LegalResVT, CDAG);
  if (Res)
    return Res;

  assert(isPackedVectorType(LegalResVT) &&
         "normal and over-packed EVTs should have been lowered by now!");
  return splitVectorShuffle(Op, CDAG, Mode);
}

SDValue VETargetLowering::LowerOperation_VVP(SDValue Op,
                                             SelectionDAG &DAG) const {
  LLVM_DEBUG(dbgs() << "LowerOp_VVP: "; Op.dump(&DAG); dbgs() << "\n";);

  switch (Op.getOpcode()) {
  default:
    llvm_unreachable("Should not custom lower this!");
  case ISD::BITCAST:
    return lowerVVP_Bitcast(Op, DAG);

  // Element transfer.
  case ISD::INSERT_VECTOR_ELT:
    return lowerVVP_INSERT_VECTOR_ELT(Op, DAG);
  case ISD::EXTRACT_VECTOR_ELT:
    return lowerVVP_EXTRACT_VECTOR_ELT(Op, DAG);

    // vector composition
#if 0
  case ISD::CONCAT_VECTORS:
    return lowerVVP_CONCAT_VECTOR(Op, DAG);
#endif
  case ISD::BUILD_VECTOR:
  case ISD::VECTOR_SHUFFLE:
    return lowerVectorShuffleOp(Op, DAG, VVPExpansionMode::ToNativeWidth);

  case ISD::EXTRACT_SUBVECTOR:
    return lowerVVP_EXTRACT_SUBVECTOR(Op, DAG, VVPExpansionMode::ToNativeWidth);
  case ISD::SCALAR_TO_VECTOR:
    return lowerVVP_SCALAR_TO_VECTOR(Op, DAG, VVPExpansionMode::ToNativeWidth);

    ///// LLVM-VP --> vvp_* /////
#define BEGIN_REGISTER_VP_SDNODE(VP_NAME, ...) case ISD::VP_NAME:
#include "llvm/IR/VPIntrinsics.def"
    return lowerVPToVVP(Op, DAG, VVPExpansionMode::ToNativeWidth);

    ///// non-VP --> vvp_* with native type /////
    // Convert this standard vector op to VVP
  case ISD::MLOAD:
  case ISD::MSTORE:
  case ISD::SELECT:
#define MAP_VVP_OP(VVP_NAME, ISD_NAME) case ISD::ISD_NAME:
#include "VVPNodes.def"
    return lowerToVVP(Op, DAG, VVPExpansionMode::ToNativeWidth);

    ///// Lower this VVP operation ////
    // 1. Legalize AVL and Mask if this is a proper packed operation.
    // 2. Split the operation if it does not support packed mode
#define REGISTER_VVP_OP(VVP_NAME) case VEISD::VVP_NAME:
#include "VVPNodes.def"
  case VEISD::VM_POPCOUNT:
  case VEISD::VEC_TOMASK:
  case VEISD::VEC_BROADCAST:
  case VEISD::VEC_VMV:
  case VEISD::VEC_SEQ: {
    if (getAnnotatedNodeAVL(Op).second)
      return Op;
    SDValue LegalVecOp =
        legalizeInternalVectorOp(lowerSETCCInVectorArithmetic(Op, DAG), DAG);
    return LegalVecOp;
  }

  // "forget" about the narrowing
  case VEISD::VEC_NARROW:
    return Op->getOperand(0);
  }
}

#if 0
SDValue VETargetLowering::lowerVVP_CONCAT_VECTOR(SDValue Op,
                                                 SelectionDAG &DAG) const {
  auto VT = Op.getValueType();
  assert(VT.getVectorElementType() == MVT::i1);

  // LLVM expansion
  if (VT.getVectorNumElements() <= 256) {
    return SDValue();
  }

  // Interleave the subregisteres
  VECustomDAG CDAG(*this, DAG, Op);
  auto LoInsert = CDAG.getTargetInsertSubreg(
      VE::sub_vm_lo, VT, CDAG.getImplicitDef(VT), Op->getOperand(0));
  return CDAG.getTargetInsertSubreg(VE::sub_vm_hi, VT, LoInsert,
                                    Op->getOperand(1));
}
#endif
