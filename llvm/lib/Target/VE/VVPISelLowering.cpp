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

#include "ShuffleSynthesis.h"
#include "VECustomDAG.h"

#ifdef DEBUG_TYPE
#undef DEBUG_TYPE
#endif
#define DEBUG_TYPE "vvp-lower"

using namespace llvm;

// VE has no masked VLD. Ignore the mask, keep the AVL.
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

  std::optional<EVT> IdiomVT = getIdiomaticType(&N);
  if (!IdiomVT.has_value() || !isLegalVectorVT(*IdiomVT))
    return false;

  // Promote if the result type is not a legal vector
  EVT ResVT = N.getValueType(0);
  if (ResVT.isVector() && !isLegalVectorVT(ResVT)) {
    return false;
  }

  // Also promote if any operand type is illegal.
  return hasWidenableSourceVTs(N);
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

static bool isEvenNumber(SDValue AVL) {
  auto ConstAVL = dyn_cast<ConstantSDNode>(AVL);
  if (!ConstAVL)
    return false;

  return (ConstAVL->getZExtValue() % 2 == 0);
}

static bool isPackableLoadStore(SDValue Op) {
  SDValue AVL = getNodeAVL(Op);
  SDValue Mask = getNodeMask(Op);
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

SDValue VETargetLowering::computeGatherScatterAddress(
    VECustomDAG &CDAG, SDValue BasePtr, SDValue Scale, SDValue Index,
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
          splitVectorOp(ScaledIndex, CDAG, VVPExpansionMode::ToNativeWidth);
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
  return splitVectorOp(ResPtr, CDAG, VVPExpansionMode::ToNativeWidth);
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
  unsigned TargetWidth = (ResTy.getVectorNumElements() > StandardVectorWidth)
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
  std::optional<EVT> OpVecTyOpt = getIdiomaticType(N);
  assert(OpVecTyOpt.has_value());
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

SDValue VETargetLowering::expandSELECT(SDValue MaskV, SDValue OnTrueV,
                                       SDValue OnFalseV, EVT LegalResVT,
                                       VECustomDAG &CDAG, SDValue AVL) const {
  // Expand vNi1 selects into a boolean expression
  if (isMaskType(LegalResVT)) {
    auto NotMaskV = CDAG.getNot(MaskV, LegalResVT);

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
    CondVecV = CDAG.getMaskCast(CondVecV, AVL);
  } else {
    CondVecV = MaskV;
  }

  // Create a plain vector selection
  return CDAG.getSelect(LegalResVT, OnTrueV, OnFalseV, CondVecV, AVL);
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

  std::vector<SDValue> Created;

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
        CDAG.getSelect(Ty, OneBroadcast, ZeroBroadcast, Operand, AVL);
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
  SDValue AVL = CDAG.getConstant(
      *minVectorLength(ResTy.getVectorNumElements(), VecLenHint), MVT::i32);

  return CDAG.getBroadcast(NativeResTy, Op.getOperand(0), AVL);
}

TargetLowering::LegalizeAction
VETargetLowering::getActionForExtendedType(unsigned Op, EVT VT) const {
  assert(Op != ISD::DELETED_NODE &&
         "Inconsistent state: shouldn't be called on deleted nodes");
  // FIXME: ISD::DELETED_NODE is used as a redunant ISD_NAME in VVPNodes.def. We
  // use an explicit if cascade and rely on the compiler to optimize it down
  // into a switch.
#define ADD_VVP_OP(VVP_NAME, ISD_NAME)                                         \
  if ((Op == VEISD::VVP_NAME) || (Op == ISD::ISD_NAME))                        \
    return Custom;
#include "VVPNodes.def"
  return Expand;
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

SDValue VETargetLowering::splitPackedLoadStore(SDValue Op, VECustomDAG &CDAG,
                                               VVPExpansionMode Mode) const {
  LLVM_DEBUG(dbgs() << "splitPackedLoadStore: "; Op->print(dbgs());
             dbgs() << "\n");
  auto VVPOC = *getVVPOpcode(Op.getOpcode());
  assert((VVPOC == VEISD::VVP_LOAD) || (VVPOC == VEISD::VVP_STORE));

  VVPWideningInfo WidenInfo = pickResultType(CDAG, Op, Mode);

  EVT DataVT = *getIdiomaticVectorType(Op.getNode());
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
        CDAG.getTargetSplitMask(WidenInfo, PackedMask, PackedAVL, Part);
    SplitTM.AVL = CDAG.annotateLegalAVL(SplitTM.AVL);

    // Keep track of the (higher) lvl.
    if (Part == PackElem::Hi)
      UpperPartAVL = SplitTM.AVL;

    // Drop the mask (for loads).
    if (VVPOC == VEISD::VVP_LOAD && OptimizeVectorMemory)
      SplitTM.Mask = CDAG.getUniformConstMask(Packing::Normal, true);

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
  SDValue FusedChains = CDAG.getNode(ISD::TokenFactor, MVT::Other, ChainVec);

  // Chain only [store]
  if (PackData)
    return FusedChains;

  // re-pack into full packed vector result
  EVT PackedVT = CDAG.legalizeVectorType(Op, Mode);
  SDValue PackedVals = CDAG.getPack(PackedVT, PartOps[(int)PackElem::Lo],
                                    PartOps[(int)PackElem::Hi], UpperPartAVL);

  // Put the passthru back in
  if (Passthru) {
    PackedVals = CDAG.getSelect(PackedVT, PackedVals, Passthru, PackedMask,
                                UpperPartAVL);
  }

  return CDAG.getMergeValues({PackedVals, FusedChains});
}

SDValue VETargetLowering::splitMaskArithmetic(SDValue Op,
                                              SelectionDAG &DAG) const {
  VECustomDAG CDAG(*this, DAG, Op);
  SDValue AVL =
      CDAG.getConstant(Op.getValueType().getVectorNumElements(), MVT::i32);
  SDValue A = Op->getOperand(0);
  SDValue B = Op->getOperand(1);
  SDValue LoA = CDAG.getUnpack(MVT::v256i1, A, PackElem::Lo, AVL);
  SDValue HiA = CDAG.getUnpack(MVT::v256i1, A, PackElem::Hi, AVL);
  SDValue LoB = CDAG.getUnpack(MVT::v256i1, B, PackElem::Lo, AVL);
  SDValue HiB = CDAG.getUnpack(MVT::v256i1, B, PackElem::Hi, AVL);
  unsigned Opc = Op.getOpcode();
  auto LoRes = CDAG.getNode(Opc, MVT::v256i1, {LoA, LoB});
  auto HiRes = CDAG.getNode(Opc, MVT::v256i1, {HiA, HiB});
  return CDAG.getPack(MVT::v512i1, LoRes, HiRes, AVL);
}

SDValue VETargetLowering::lowerToVVP(SDValue Op, SelectionDAG &DAG) const {
  // Can we represent this as a VVP node.
  const unsigned Opcode = Op->getOpcode();
  auto VVPOpcodeOpt = getVVPOpcode(Opcode);
  if (!VVPOpcodeOpt)
    return SDValue();
  unsigned VVPOpcode = VVPOpcodeOpt.value();
  const bool FromVP = ISD::isVPOpcode(Opcode);

  // The representative and legalized vector type of this operation.
  VECustomDAG CDAG(*this, DAG, Op);
  // Dispatch to complex lowering functions.
  switch (VVPOpcode) {
  case VEISD::VVP_LOAD:
  case VEISD::VVP_STORE:
    return lowerVVP_LOAD_STORE(Op, CDAG);
  case VEISD::VVP_GATHER:
  case VEISD::VVP_SCATTER:
    return lowerVVP_GATHER_SCATTER(Op, CDAG);
  }

  EVT OpVecVT = *getIdiomaticVectorType(Op.getNode());
  EVT LegalVecVT = getTypeToTransformTo(*DAG.getContext(), OpVecVT);
  auto Packing = getTypePacking(LegalVecVT.getSimpleVT());

  SDValue AVL;
  SDValue Mask;

  if (FromVP) {
    // All upstream VP SDNodes always have a mask and avl.
    auto MaskIdx = ISD::getVPMaskIdx(Opcode);
    auto AVLIdx = ISD::getVPExplicitVectorLengthIdx(Opcode);
    if (MaskIdx)
      Mask = Op->getOperand(*MaskIdx);
    if (AVLIdx)
      AVL = Op->getOperand(*AVLIdx);
  }

  // Materialize default mask and avl.
  if (!AVL)
    AVL = CDAG.getConstant(OpVecVT.getVectorNumElements(), MVT::i32);
  if (!Mask)
    Mask = CDAG.getConstantMask(Packing, true);

  assert(LegalVecVT.isSimple());
  if (isVVPUnaryOp(VVPOpcode))
    return CDAG.getNode(VVPOpcode, LegalVecVT, {Op->getOperand(0), Mask, AVL});
  if (isVVPBinaryOp(VVPOpcode))
    return CDAG.getNode(VVPOpcode, LegalVecVT,
                        {Op->getOperand(0), Op->getOperand(1), Mask, AVL});
  if (isVVPReductionOp(VVPOpcode)) {
    auto SrcHasStart = hasReductionStartParam(Op->getOpcode());
    SDValue StartV = SrcHasStart ? Op->getOperand(0) : SDValue();
    SDValue VectorV = Op->getOperand(SrcHasStart ? 1 : 0);
    return CDAG.getLegalReductionOpVVP(VVPOpcode, Op.getValueType(), StartV,
                                       VectorV, Mask, AVL, Op->getFlags());
  }

  switch (VVPOpcode) {
  default:
    llvm_unreachable("lowerToVVP called for unexpected SDNode.");
  case VEISD::VVP_FFMA: {
    // VE has a swizzled operand order in FMA (compared to LLVM IR and
    // SDNodes).
    auto X = Op->getOperand(2);
    auto Y = Op->getOperand(0);
    auto Z = Op->getOperand(1);
    return CDAG.getNode(VVPOpcode, LegalVecVT, {X, Y, Z, Mask, AVL});
  }
  case VEISD::VVP_SELECT: {
    auto Mask = Op->getOperand(0);
    auto OnTrue = Op->getOperand(1);
    auto OnFalse = Op->getOperand(2);
    return CDAG.getNode(VVPOpcode, LegalVecVT, {OnTrue, OnFalse, Mask, AVL});
  }
  case VEISD::VVP_SETCC: {
    EVT LegalResVT = getTypeToTransformTo(*DAG.getContext(), Op.getValueType());
    auto LHS = Op->getOperand(0);
    auto RHS = Op->getOperand(1);
    auto Pred = Op->getOperand(2);
    return CDAG.getNode(VVPOpcode, LegalResVT, {LHS, RHS, Pred, Mask, AVL});
  }
  }
}

SDValue VETargetLowering::lowerVVP_LOAD_STORE(SDValue Op,
                                              VECustomDAG &CDAG) const {
  auto VVPOpc = *getVVPOpcode(Op->getOpcode());
  const bool IsLoad = (VVPOpc == VEISD::VVP_LOAD);

  // Shares.
  SDValue BasePtr = getMemoryPtr(Op);
  SDValue Mask = getNodeMask(Op);
  SDValue Chain = getNodeChain(Op);
  SDValue AVL = getNodeAVL(Op);
  // Store specific.
  SDValue Data = getStoredValue(Op);
  // Load specific.
  SDValue PassThru = getNodePassthru(Op);

  SDValue StrideV = getLoadStoreStride(Op, CDAG);

  auto DataVT = *getIdiomaticVectorType(Op.getNode());
  auto Packing = getTypePacking(DataVT);

  // TODO: Infer lower AVL from mask.
  if (!AVL)
    AVL = CDAG.getConstant(DataVT.getVectorNumElements(), MVT::i32);

  // Default to the all-true mask.
  if (!Mask)
    Mask = CDAG.getConstantMask(Packing, true);

  if (IsLoad) {
    MVT LegalDataVT = getLegalVectorType(
        Packing, DataVT.getVectorElementType().getSimpleVT());

    auto NewLoadV = CDAG.getNode(VEISD::VVP_LOAD, {LegalDataVT, MVT::Other},
                                 {Chain, BasePtr, StrideV, Mask, AVL});

    if (!PassThru || PassThru->isUndef())
      return NewLoadV;

    // Convert passthru to an explicit select node.
    SDValue DataV = CDAG.getNode(VEISD::VVP_SELECT, DataVT,
                                 {NewLoadV, PassThru, Mask, AVL});
    SDValue NewLoadChainV = SDValue(NewLoadV.getNode(), 1);

    // Merge them back into one node.
    return CDAG.getMergeValues({DataV, NewLoadChainV});
  }

  // VVP_STORE
  assert(VVPOpc == VEISD::VVP_STORE);
  return CDAG.getNode(VEISD::VVP_STORE, Op.getNode()->getVTList(),
                      {Chain, Data, BasePtr, StrideV, Mask, AVL});
}

SDValue VETargetLowering::lowerVVP_GATHER_SCATTER(SDValue Op,
                                                  VECustomDAG &CDAG) const {
  EVT DataVT = *getIdiomaticVectorType(Op.getNode());
  auto Packing = getTypePacking(DataVT);
  MVT LegalDataVT =
      getLegalVectorType(Packing, DataVT.getVectorElementType().getSimpleVT());

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

  // TODO: Infer lower AVL from mask.
  if (!AVL)
    AVL = CDAG.getConstant(DataVT.getVectorNumElements(), MVT::i32);

  // Default to the all-true mask.
  if (!Mask)
    Mask = CDAG.getConstantMask(Packing, true);

  SDValue AddressVec =
      CDAG.getGatherScatterAddress(BasePtr, Scale, Index, Mask, AVL);
  if (IsScatter)
    return CDAG.getNode(VEISD::VVP_SCATTER, MVT::Other,
                        {Chain, StoredValue, AddressVec, Mask, AVL});

  // Gather.
  SDValue NewLoadV = CDAG.getNode(VEISD::VVP_GATHER, {LegalDataVT, MVT::Other},
                                  {Chain, AddressVec, Mask, AVL});

  if (!PassThru)
    return NewLoadV;

  // TODO: Use vvp_select
  SDValue DataV = CDAG.getNode(VEISD::VVP_SELECT, LegalDataVT,
                               {NewLoadV, PassThru, Mask, AVL});
  SDValue NewLoadChainV = SDValue(NewLoadV.getNode(), 1);
  return CDAG.getMergeValues({DataV, NewLoadChainV});
}

SDValue VETargetLowering::splitVectorOp(SDValue Op, VECustomDAG &CDAG,
                                        VVPExpansionMode Mode) const {
  LLVM_DEBUG(dbgs() << "::splitVectorOp: "; CDAG.print(dbgs(), Op) << "\n");
  auto OcOpt = getVVPOpcode(Op.getOpcode());
  assert(OcOpt.has_value());
  unsigned VVPOC = OcOpt.value();

  // Special cases ('impure' SIMD instructions)
  if (VVPOC == VEISD::VVP_LOAD || VVPOC == VEISD::VVP_STORE)
    return splitPackedLoadStore(Op, CDAG, Mode);
  else if (VVPOC == VEISD::VVP_GATHER || VVPOC == VEISD::VVP_SCATTER)
    return splitGatherScatter(Op, CDAG, Mode);

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
        CDAG.getTargetSplitMask(WidenInfo, PackedMask, PackedAVL, Part);

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

    if (maySafelyIgnoreMask(VVPOC))
      SplitTM.Mask = CDAG.getUniformConstMask(MVT::v256i1, true);

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
  SDValue PackedVals = CDAG.getPack(PackedVT, PartOps[(int)PackElem::Lo],
                                    PartOps[(int)PackElem::Hi], UpperPartAVL);

  // Value only node.
  if (!HasChain) {
    return PackedVals;
  }

  // Merge the chains.
  SDValue LowChain = PartOps[(int)PackElem::Lo].getValue(1);
  SDValue HiChain = PartOps[(int)PackElem::Hi].getValue(1);
  SmallVector<SDValue, 2> ChainVec({LowChain, HiChain});
  SDValue FusedChains = CDAG.getNode(ISD::TokenFactor, MVT::Other, ChainVec);
  return CDAG.getMergeValues({PackedVals, FusedChains});
}

SDValue VETargetLowering::legalizePackedAVL(SDValue Op,
                                            VECustomDAG &CDAG) const {
  LLVM_DEBUG(dbgs() << "::legalizePackedAVL\n";);
  // Only required for VEC and VVP ops.
  if (!isVVPOrVEC(Op->getOpcode()))
    return Op;

  // Operation already has a legal AVL.
  auto AVL = getNodeAVL(Op);
  if (isLegalAVL(AVL))
    return Op;

  // Legalize mask & avl.
  auto WidenInfo = pickResultType(CDAG, Op, VVPExpansionMode::ToNativeWidth);
  auto MaskPos = getMaskPos(Op->getOpcode());
  auto AVLPos = getAVLPos(Op->getOpcode());
  auto TargetMasks =
      CDAG.getTargetMask(WidenInfo, getNodeMask(Op), getNodeAVL(Op));

  // Check whether we can safely drop the mask.
  if (MaskPos && IgnoreMasks && maySafelyIgnoreMask(Op->getOpcode()))
    TargetMasks.Mask =
        CDAG.getUniformConstMask(TargetMasks.Mask.getValueType(), true);

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

VVPWideningInfo VETargetLowering::pickResultType(VECustomDAG &CDAG, SDValue Op,
                                                 VVPExpansionMode Mode) const {
  std::optional<EVT> VecVTOpt = getIdiomaticType(Op.getNode());
  if (!VecVTOpt.has_value() || !VecVTOpt.value().isVector()) {
    LLVM_DEBUG(if (VecVTOpt) dbgs()
               << "VecVT: " << VecVTOpt->getEVTString() << "\n");
    LLVM_DEBUG(dbgs() << "\tno idiomatic vector VT.\n");
    return VVPWideningInfo();
  }
  EVT OpVecVT = VecVTOpt.value();

  // try to narrow the vector length
  std::optional<unsigned> NarrowLen = peekForNarrow(Op);
  unsigned OpVectorLength =
      NarrowLen ? NarrowLen.value() : OpVecVT.getVectorNumElements();

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
  bool NeedsPackedMasking = false;
  if (VectorWidth > StandardVectorWidth) {
    NeedsPackedMasking = (OpVectorLength % 2 != 0);
    PackedMode = true;
  }

  // Do we need to fold the predicating effect of the AVL into the mask (due to
  // the coarse-grained nature of AVL in packed mode)?
  // TODO: Does not need masking if AVL is a power-of-two.
  NeedsPackedMasking |= PackedMode && (bool)getNodeAVL(Op);

  return VVPWideningInfo(ResultVT, OpVectorLength, PackedMode,
                         NeedsPackedMasking);
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
  if (isMaskArithmetic(Op)) {
    if (isPackedMaskType(Op.getValueType())) {
      LLVM_DEBUG(dbgs() << "Splitting packed mask arithmetic!\n");
      return splitMaskArithmetic(Op, DAG);
    }
    return Op;
  }

  std::optional<EVT> OpVecTyOpt = getIdiomaticType(Op.getNode());
  EVT OpVecTy = OpVecTyOpt.value();

  if (!OpVecTyOpt.has_value()) {
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
    return splitVectorOp(Op, CDAG, Mode);

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
    return lowerVVP_LOAD_STORE(Op, DAG, Mode);

  case ISD::MGATHER:
  case ISD::MSCATTER:
    return lowerVVP_GATHER_SCATTER(Op, DAG, Mode);
  }

  auto VVPOC = getVVPOpcode(Op.getOpcode());
  if (!VVPOC)
    return SDValue();

  ///// Translate to a VVP layer operation (VVP_* or VEC_*) /////
  bool IsBinaryOp = isVVPBinaryOp(*VVPOC);
  bool IsUnaryOp = isVVPUnaryOp(*VVPOC);
  bool IsConvOp = isVVPConversionOp(*VVPOC);
  bool IsReduceOp = isVVPReductionOp(*VVPOC);

  // Generate a mask and an AVL.
  // auto TargetMasks = CDAG.getTargetMask(WidenInfo, SDValue(), SDValue());
  VETargetMasks MaskingArgs;
  unsigned NumElems = OpVecTy.getVectorNumElements();
  MaskingArgs.AVL = CDAG.getConstant(NumElems, MVT::i32);
  MaskingArgs.Mask = CDAG.getUniformConstMask(OpVecTy, true);

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
    assert(VVPOC.has_value());
    return CDAG.getNode(VVPOC.value(), ResVecTy,
                        {LegalOperands[0], MaskingArgs.Mask, MaskingArgs.AVL});
  }

  if (IsBinaryOp) {
    assert(VVPOC.has_value());
    auto VVPN = CDAG.getLegalBinaryOpVVP(*VVPOC, ResVecTy, LegalOperands[0],
                                         LegalOperands[1], MaskingArgs.Mask,
                                         MaskingArgs.AVL, Op->getFlags());
    return VVPN;
  }

  switch (VVPOC.value()) {
  case VEISD::VVP_FFMA: {
    // VE has a swizzled operand order in FMA (compared to LLVM IR and
    // SDNodes).
    return CDAG.getNode(VVPOC.value(), ResVecTy,
                        {LegalOperands[2], LegalOperands[0], LegalOperands[1],
                         MaskingArgs.Mask, MaskingArgs.AVL});
  }
  case VEISD::VVP_SETCC: {
    return CDAG.getNode(VVPOC.value(), ResVecTy,
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
  }

  if (IsConvOp) {
    return CDAG.getLegalConvOpVVP(VVPOC.value(), ResVecTy, LegalOperands[0],
                                  MaskingArgs.Mask, MaskingArgs.AVL);
  }

  if (IsReduceOp) {
    auto HasStartV = getVVPReductionStartParamPos(VVPOC.value());
    SDValue StartV = HasStartV ? LegalOperands[0] : SDValue();
    SDValue VectorV = HasStartV ? LegalOperands[1] : LegalOperands[0];
    assert(VVPOC.has_value());
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
    auto AllTrueMask = CDAG.getUniformConstMask(MVT::v256i1, true);
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
  SDValue AVL = getNodeAVL(Op);
  SDValue Mask = getNodeMask(Op);
  // TODO: this can be refined.. the mask has to be compactable for stores.
  bool IsPackable = isPackableLoadStore(Op);
  if (!IsPackable)
    return splitPackedLoadStore(Op, CDAG, VVPExpansionMode::ToNativeWidth);

  // Packed load/store require special treatment
  // - The mask refers to packs of 2x32 elements
  // - A VLD/VST for 64bits has a different byte order than 2x32bit op (32bit
  // elements swapped).
  auto WidenInfo = pickResultType(CDAG, Op, VVPExpansionMode::ToNativeWidth);
  auto TargetMask = CDAG.getTargetMask(WidenInfo, Mask, AVL);

  SDValue PackStride = getLoadStoreStride(Op, CDAG);
  auto DoubledStride = getSplitPtrStride(PackStride, CDAG);
  auto NormalMask = CDAG.getUniformConstMask(MVT::v256i1, true);
  auto Chain = Op->getOperand(0);
  SDValue PackPtr = getMemoryPtr(Op);

  TargetMask.AVL = CDAG.annotateLegalAVL(TargetMask.AVL);

  // Be optimistic about loads.. (FIXME: implies OptimizeVectorMemory cl::opt).
  if (Op->getOpcode() == VEISD::VVP_LOAD) {
    SDValue LoadV = CDAG.getVVPLoad(Op.getValueType(), Chain, PackPtr,
                                    DoubledStride, NormalMask, TargetMask.AVL);

    SDValue SwappedValue =
        CDAG.getSwap(LoadV.getValueType(), LoadV, TargetMask.AVL);
    return CDAG.getMergeValues({SwappedValue, SDValue(LoadV.getNode(), 1)});
  }

  SDValue PackedMask = getNodeMask(Op);
  SDValue PackedData = Op->getOperand(1);
  SDValue SwappedData =
      CDAG.getSwap(PackedData.getValueType(), PackedData, TargetMask.AVL);

  assert(isAllTrueMask(PackedMask) && "TODO in-place expand masked VST");
  return CDAG.getVVPStore(Chain, SwappedData, PackPtr, DoubledStride,
                          NormalMask, TargetMask.AVL);
}

SDValue VETargetLowering::legalizeVM_POPCOUNT(SDValue Op,
                                              SelectionDAG &DAG) const {
  LLVM_DEBUG(dbgs() << "::LegalizeVM_POPCOUNT\n";);
  auto Mask = Op->getOperand(0);
  auto AVL = Op->getOperand(1);
  if (!isPackedVectorType(Mask.getValueType()))
    return Op;

  VECustomDAG CDAG(*this, DAG, Op);
  SDValue LoMask = CDAG.getUnpack(MVT::v256i1, Mask, PackElem::Lo, AVL);
  SDValue LoCount = CDAG.getMaskPopcount(LoMask, AVL);
  SDValue HiMask = CDAG.getUnpack(MVT::v256i1, Mask, PackElem::Hi, AVL);
  SDValue HiCount = CDAG.getMaskPopcount(HiMask, AVL);
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
  std::optional<EVT> OpVecTyOpt = getIdiomaticType(Op.getNode());
  assert(OpVecTyOpt);
  EVT OpVecTy = OpVecTyOpt.value();

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
    return splitVectorOp(Op, CDAG, VVPExpansionMode::ToNativeWidth);

  // This is a packed mode operation -> we (may) need to legalize AVL to refer
  // to packs (2x32) instead of elements (32).
  return legalizePackedAVL(Op, CDAG);
}

SDValue VETargetLowering::splitGatherScatter(SDValue Op, VECustomDAG &CDAG,
                                             VVPExpansionMode Mode) const {

  LLVM_DEBUG(dbgs() << "::splitGatherScatter\n";);

  SDValue PackAVL = getNodeAVL(Op);
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
  EVT LegalDataVT = CDAG.legalizeVectorType(Op, Mode);
  const bool SplitPassThru = PackPassThru && isOverPackedType(OldDataVT);

  EVT SplitDataVT = CDAG.splitVectorType(OldDataVT);

  bool IsOverPackedSplit = isOverPackedType(OldDataVT);

  SDValue PartOps[2];
  SmallVector<SDValue, 2> PartChains(2);
  SDValue UpperPartAVL; // we will use this for packing things back together
  for (PackElem Part : {PackElem::Hi, PackElem::Lo}) {
    // BaseBtr := BasePtr + Scale * Offset.

    auto SplitTM = CDAG.getTargetSplitMask(WidenInfo, PackMask, PackAVL, Part);

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
      PartOp = CDAG.getSelect(SplitDataVT, PartOp, PartPassThru, SplitTM.Mask,
                              SplitTM.AVL);
    }

    PartOps[(int)Part] = PartOp;
  }

  // Join chains.
  SDValue FusedChains = CDAG.getNode(ISD::TokenFactor, MVT::Other, PartChains);

  if (IsScatter)
    return FusedChains;

  SDValue RePackedValue =
      CDAG.getPack(LegalDataVT, PartOps[(int)PackElem::Lo],
                   PartOps[(int)PackElem::Hi], UpperPartAVL);

  // Packed passthru?
  if (PackPassThru && !SplitPassThru)
    RePackedValue = CDAG.getSelect(LegalDataVT, RePackedValue, PackPassThru,
                                   PackMask, PackAVL);

  return CDAG.getMergeValues({RePackedValue, FusedChains});
}

SDValue VETargetLowering::lowerVVP_GATHER_SCATTER(SDValue Op, SelectionDAG &DAG,
                                                  VVPExpansionMode Mode,
                                                  VecLenOpt VecLenHint) const {
  LLVM_DEBUG(dbgs() << "::lowerVVP_GATHER_SCATTER\n";);

  VECustomDAG CDAG(*this, DAG, Op);
  auto MemN = cast<MemSDNode>(Op.getNode());
  EVT OldDataVT = MemN->getMemoryVT();
  EVT LegalDataVT = LegalizeVectorType(OldDataVT, Op, DAG, Mode);

  SDValue AVL = getNodeAVL(Op);
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
    return splitGatherScatter(Op, CDAG, Mode);

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
    return CDAG.getNarrow(LegalVecTy, SrcVec, NarrowLen);
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
    return splitVectorOp(Op, CDAG, Mode);

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

  case ISD::EXPERIMENTAL_VP_STRIDED_LOAD:
  case ISD::VP_LOAD:
  case ISD::EXPERIMENTAL_VP_STRIDED_STORE:
  case ISD::VP_STORE:
    return lowerVVP_LOAD_STORE(Op, DAG, VVPExpansionMode::ToNativeWidth);

  case ISD::VP_GATHER:
  case ISD::VP_SCATTER:
    return lowerVVP_GATHER_SCATTER(Op, DAG, VVPExpansionMode::ToNativeWidth,
                                   std::nullopt);

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
    return splitVectorOp(Op, CDAG, Mode);

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

SDValue VETargetLowering::lowerVVP_LOAD_STORE(SDValue Op, SelectionDAG &DAG,
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
  SDValue AVL = getNodeAVL(Op);
  // Store specific.
  SDValue Data = getStoredValue(Op);
  // Load specific.
  SDValue PassThru = getNodePassthru(Op);
  SDValue StrideV = getLoadStoreStride(Op, CDAG);

  if (PassThru && PassThru->isUndef())
    PassThru = SDValue();

  MemSDNode &MemN = *cast<MemSDNode>(Op.getNode());
  EVT OldDataVT = MemN.getMemoryVT();
  EVT LegalDataVT = LegalizeVectorType(OldDataVT, Op, DAG, Mode);

  // Eagerly split over-packed vectors.
  if (isOverPackedType(OldDataVT))
    return splitPackedLoadStore(Op, CDAG, Mode);

  // Infer a AVL value from all available hints.
  AVL = CDAG.inferAVL(AVL, Mask, OldDataVT);

  // Default to the all-true mask.
  if (!Mask) {
    Packing P = getPackingForVT(LegalDataVT);
    Mask = CDAG.getUniformConstMask(P, true);
  }

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
  if (SDValue ActualMaskV = PeekForMask(SrcV)) {
    // FIXME: Need to translate index!
    assert((Op.getValueType() == MVT::i64) && "not a proper mask extraction");
    VECustomDAG CDAG(*this, DAG, Op);
    return CDAG.getInsertMask(ActualMaskV, ElemV, IndexV);
  }

  // Overpacked operation.
  if (VecVT == MVT::v512i64 || VecVT == MVT::v512f64) {
    if (!isa<ConstantSDNode>(IndexV)) {
      errs() << "TODO: Cannot lower dynamic index element insert!\n";
      abort();
    }
    uint64_t ConstIdx = cast<ConstantSDNode>(IndexV)->getZExtValue();
    auto Part = getPartForLane(ConstIdx);
    VECustomDAG CDAG(*this, DAG, Op);

    // Meaningful AVL, unused in codegen.
    SDValue AVL = CDAG.getConstant(256, MVT::i32);

    // Split into part to keep and part to modify.
    auto PartVT = (VecVT == MVT::v512i64) ? MVT::v256i64 : MVT::v256f64;
    auto UnpackedMod = CDAG.getUnpack(PartVT, SrcV, Part, AVL);
    auto UnpackedKeep = CDAG.getUnpack(PartVT, SrcV, getOtherPart(Part), AVL);

    // Insert into subreg.
    auto PackIdx = CDAG.getConstant(ConstIdx / 2, IndexV.getValueType());
    auto PartInsert = CDAG.getNode(ISD::INSERT_VECTOR_ELT, PartVT,
                                   {UnpackedMod, ElemV, PackIdx});
    auto LoweredInsert = lowerSIMD_INSERT_VECTOR_ELT(PartInsert, DAG);

    // Re-package.
    SDValue NewLo = Part == PackElem::Lo ? LoweredInsert : UnpackedKeep;
    SDValue NewHi = Part == PackElem::Hi ? LoweredInsert : UnpackedKeep;
    return CDAG.getPack(VecVT, NewLo, NewHi, AVL);
  }

  return lowerSIMD_INSERT_VECTOR_ELT(Op, DAG);
}

SDValue VETargetLowering::lowerVVP_EXTRACT_VECTOR_ELT(SDValue Op,
                                                      SelectionDAG &DAG) const {
  SDValue SrcV = Op->getOperand(0);
  SDValue IndexV = Op->getOperand(1);
  EVT VecVT = SrcV.getValueType();

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

    auto ResV = CDAG.getExtractMask(MaskV, AdjIndexV);
    ResV = CDAG.getScalarShift(MVT::i64, ResV, ShiftAmount);

    // Convert back to actual result type
    return CDAG.DAG.getAnyExtOrTrunc(ResV, CDAG.DL, Op.getValueType());
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
    SDValue AVL = CDAG.getConstant(256, MVT::i32);

    // Split-off part to extract from.
    auto PartVT = (VecVT == MVT::v512i64) ? MVT::v256i64 : MVT::v256f64;
    auto UnpackedMod = CDAG.getUnpack(PartVT, SrcV, Part, AVL);

    // Extract from subreg.
    auto PackIdx = CDAG.getConstant(ConstIdx / 2, IndexV.getValueType());
    SDValue ExtractFromPart = CDAG.getNode(
        ISD::EXTRACT_VECTOR_ELT, Op.getValueType(), {UnpackedMod, PackIdx});

    return lowerSIMD_EXTRACT_VECTOR_ELT(ExtractFromPart, DAG);
  }

  // Dynamic extraction or packed extract.
  return lowerSIMD_EXTRACT_VECTOR_ELT(Op, DAG);
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
  return CDAG.getPack(LegalResVT, LoRes, HiRes,
                      CDAG.getConstant(256, MVT::i32));
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

  // FIXME: ISD::DELETED_NODE used repeatedly in VVPNodes.def as a marker for
  // VVP ops without matching SDNode. Building an if-cascade and letting the
  // compiler optimize down into the switch we actually want.
#define ADD_VVP_OP(VVP_NAME, ISD_NAME)                                         \
  if (Op.getOpcode() == ISD::ISD_NAME)                                         \
    return lowerToVVP(Op, DAG, VVPExpansionMode::ToNativeWidth);
#include "VVPNodes.def"

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
    return lowerToVVP(Op, DAG, VVPExpansionMode::ToNativeWidth);

    ///// Lower this VVP operation ////
    // 1. Legalize AVL and Mask if this is a proper packed operation.
    // 2. Split the operation if it does not support packed mode
#define ADD_VVP_OP(VVP_NAME, ...) case VEISD::VVP_NAME:
#include "VVPNodes.def"
  case VEISD::VM_POPCOUNT:
  case VEISD::VEC_TOMASK:
  case VEISD::VEC_BROADCAST:
  case VEISD::VEC_VMV:
  case VEISD::VEC_SEQ:
    // AVL already legalized.
    if (getAnnotatedNodeAVL(Op).second)
      return Op;
    return legalizeInternalVectorOp(Op, DAG);

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
