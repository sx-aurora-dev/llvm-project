//===-- VEISelLowering.cpp - VE DAG Lowering Implementation ---------------===//
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

#include "VEISelLowering.h"
#include "MCTargetDesc/VEMCExpr.h"
#include "VEInstrBuilder.h"
#include "VEMachineFunctionInfo.h"
#include "VERegisterInfo.h"
#include "VETargetMachine.h"
#include "llvm/ADT/StringSwitch.h"
#include "llvm/ADT/iterator_range.h"
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
#include "llvm/IR/IntrinsicsVE.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/KnownBits.h"

#define DEBUG_TYPE "ve-lower"

#include "CustomDAG.h"
#include "ShuffleSynthesis.h"

using namespace llvm;

static bool isLegalVectorVT(EVT VT) {
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

static bool shouldExpandToVVP(SDNode &N) {
  // Already a target node
  if (IsVVPOrVEC(N.getOpcode()))
    return false;

  Optional<EVT> IdiomVT = getIdiomaticType(&N);
  if (!IdiomVT.hasValue() || !isLegalVectorVT(*IdiomVT))
    return false;

  // Only expand to VP if the element type is legal. Otw, defer to LLVM for
  // legalization.
  return hasWidenableSourceVTs(N);
}

/// Whether this VVP node needs widening
static bool OpNeedsWidening(SDNode &Op) {
  // Do not widen operations that do not yield a vector value
  if (!Op.getValueType(0).isVector())
    return false;

  // Otw, widen this VVP operation to the native vector width
  Optional<EVT> OpVecTyOpt = getIdiomaticType(&Op);
  if (!OpVecTyOpt.hasValue())
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

//===----------------------------------------------------------------------===//
// Calling Convention Implementation
//===----------------------------------------------------------------------===//

static bool allocateFloat(unsigned ValNo, MVT ValVT, MVT LocVT,
                          CCValAssign::LocInfo LocInfo,
                          ISD::ArgFlagsTy ArgFlags, CCState &State) {
  switch (LocVT.SimpleTy) {
  case MVT::f32: {
    // Allocate stack like below
    //    0      4
    //    +------+------+
    //    | empty| float|
    //    +------+------+
    // Use align=8 for dummy area to align the beginning of these 2 area.
    State.AllocateStack(4, 8); // for empty area
    // Use align=4 for value to place it at just after the dummy area.
    unsigned Offset = State.AllocateStack(4, 4); // for float value area
    State.addLoc(CCValAssign::getMem(ValNo, ValVT, Offset, LocVT, LocInfo));
    return true;
  }
  default:
    return false;
  }
}

#include "VEGenCallingConv.inc"

bool VETargetLowering::CanLowerReturn(
    CallingConv::ID CallConv, MachineFunction &MF, bool IsVarArg,
    const SmallVectorImpl<ISD::OutputArg> &Outs, LLVMContext &Context) const {
  CCAssignFn *RetCC = RetCC_VE;
  SmallVector<CCValAssign, 16> RVLocs;
  CCState CCInfo(CallConv, IsVarArg, MF, RVLocs, Context);
  return CCInfo.CheckReturn(Outs, RetCC);
}

SDValue VETargetLowering::LowerBitcast(SDValue Op, SelectionDAG &DAG) const {
  if (Op.getSimpleValueType() == MVT::v256i64 &&
      Op.getOperand(0).getSimpleValueType() == MVT::v256f64) {
    LLVM_DEBUG(dbgs() << "Lowering bitcast of similar types.\n");
    return Op.getOperand(0);
  } else {
    return Op;
  }
}

SDValue VETargetLowering::LowerTRUNCATE(SDValue Op, SelectionDAG &DAG) const {
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

SDValue VETargetLowering::ExpandSELECT(SDValue Op,
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

#if 0
SDValue VETargetLowering::LowerSELECT_CC(SDValue Op, SelectionDAG &DAG) const {
  SDLoc dl(Op);
  LLVM_DEBUG(dbgs() << "Lowering SELECT_CC\n");

  // only lower mask blends this way
  MVT Ty = Op.getSimpleValueType();
  if (!Ty.isVector())
    return Op;
  if (Ty.getVectorElementType() != MVT::i1)
    return Op;

  SDValue A = Op.getOperand(0);
  SDValue B = Op.getOperand(1);
  SDValue X = Op.getOperand(2);
  SDValue Y = Op.getOperand(3);
  SDValue CC = Op.getOperand(4);

  assert(A.getSimpleValueType() == MVT::i64);
  assert(X.getSimpleValueType() == MVT::v256i1);

  MVT CastVecTy = MVT::v256i64; // FIXME vectorize scalar type for broadcast
  MVT VecTy = Op.getSimpleValueType();

  CustomDAG CDAG(DAG, dl);

  // lift to a vector compare
  SDValue Abc = CDAG.CreateBroadcast(CastVecTy, A);
  SDValue Bbc = CDAG.CreateBroadcast(CastVecTy, B);

  auto VecCmp = DAG.getNode(ISD::SETCC, dl, MVT::v256i1, {Abc, Bbc, CC});
  return DAG.getSelect(dl, VecTy, VecCmp, X, Y);
}
#endif

SDValue
VETargetLowering::LowerSETCCInVectorArithmetic(SDValue Op,
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

  CustomDAG CDAG(DAG, dl);

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

    // errs() << "Needs expansion: "; Operand.dump(); errs() << " for user: ";
    // Op.dump();

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

SDValue VETargetLowering::LowerSCALAR_TO_VECTOR(SDValue Op, SelectionDAG &DAG,
                                                VVPExpansionMode Mode,
                                                VecLenOpt VecLenHint) const {
  SDLoc DL(Op);

  EVT ResTy = Op.getValueType();
  EVT NativeResTy = LegalizeVectorType(ResTy, Op, DAG, Mode);

  // FIXME
  Optional<SDValue> OptVL = EVLToVal(
      MinVectorLength(ResTy.getVectorNumElements(), VecLenHint), DL, DAG);

  CustomDAG CDAG(DAG, DL);
  return CDAG.CreateBroadcast(NativeResTy, Op.getOperand(0), OptVL);
}

static EVT getSplitVT(EVT OldValVT, CustomDAG &CDAG) {
  return CDAG.getVectorVT(OldValVT.getVectorElementType(), StandardVectorWidth);
}

static SDValue extractSubElem(SDValue Op, CustomDAG &CDAG, SubElem Part,
                              SDValue AVL) {
  EVT OldValVT = Op.getValue(0).getValueType();
  if (!OldValVT.isVector())
    return Op;

  // TODO peek through pack operations
  return CDAG.CreateUnpack(getSplitVT(OldValVT, CDAG), Op, Part, AVL);
}

SDValue VETargetLowering::ExpandToSplitVVP(SDValue Op, SelectionDAG &DAG,
                                           VVPExpansionMode Mode,
                                           SDValue AVL) const {
  auto OcOpt = GetVVPOpcode(Op.getOpcode());
  assert(OcOpt.hasValue());
  unsigned VVPOC = OcOpt.getValue();

  CustomDAG CDAG(DAG, Op);

  EVT ResVT = getSplitVT(Op.getValue(0).getValueType(), CDAG);

  // request the parts
  SDValue PartOps[2];
  for (SubElem Part : {SubElem::Lo, SubElem::Hi}) {
    SmallVector<SDValue, 4> OpVec;
    for (unsigned i = 0; i < Op.getNumOperands(); ++i) {
      SDValue PartV = extractSubElem(Op.getOperand(i), CDAG, Part, AVL);
      OpVec.push_back(PartV);
    }
    // attach Mask
    SDValue TrueMask = CDAG.createUniformConstMask(256, true);
    OpVec.push_back(TrueMask);
    // attach AVL
    OpVec.push_back(AVL);
    PartOps[(int)Part] = CDAG.getNode(VVPOC, ResVT, OpVec);
  }

  // re-package into a proper packed operation
  EVT PackedVT =
      LegalizeVectorType(Op.getValue(0).getValueType(), Op, CDAG.DAG, Mode);
  return CDAG.CreatePack(PackedVT, PartOps[(int)SubElem::Lo],
                         PartOps[(int)SubElem::Hi], AVL);
}

SDValue VETargetLowering::ExpandToVVP(SDValue Op, SelectionDAG &DAG,
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

  // try to narrow the vector length
  Optional<unsigned> NarrowLen = PeekForNarrow(Op);
  unsigned OpVectorLength =
      NarrowLen ? NarrowLen.getValue() : OpVecTy.getVectorNumElements();

  LLVM_DEBUG(dbgs() << "\t detected AVL:" << OpVectorLength << "\n";);

  ///// Decide for a vector width /////
  // This also takes care of splitting
  // TODO improve packed matching logic
  // Switch to packed mode (TODO where appropriate)
  unsigned VectorWidth = 0;
  bool NeedsPackedMasking = false;
  bool PackedMode = false;

  if (Mode == VVPExpansionMode::ToNativeWidth) {
    LLVM_DEBUG(dbgs() << "\t expanding to native width\n";);

    if (OpVectorLength > StandardVectorWidth) {
      // packed mode only available for 32bit elements up to 512 elements
      EVT RawElemTy = OpVecTy.getVectorElementType();
      if (!RawElemTy.isSimple())
        return SDValue();
      MVT ElemTy = RawElemTy.getSimpleVT();

      if ((ElemTy != MVT::i32 && ElemTy != MVT::f32) ||
          (OpVectorLength > PackedWidth)) {
        LLVM_DEBUG(dbgs() << "\tToNative: Over-sized data type\n";);
        return SDValue();
      }

      VectorWidth = PackedWidth;
    } else {
      VectorWidth = StandardVectorWidth;
    }

  } else if (Mode == VVPExpansionMode::ToNextWidth) {
    LLVM_DEBUG(dbgs() << "\t expanding to next width\n";);

    EVT NextDestVecTy = getTypeToTransformTo(*DAG.getContext(), OpVecTy);
    LLVM_DEBUG(dbgs() << "\t OpVecTy: " << OpVecTy.getEVTString() << "\n";);
    LLVM_DEBUG(dbgs() << "\t NextTy: " << NextDestVecTy.getEVTString()
                      << "\n";);

    VectorWidth = NextDestVecTy.getVectorNumElements();
    assert((NextDestVecTy.getVectorElementType() ==
            OpVecTy.getVectorElementType()) &&
           "unexpected change of element type!");

    // bail if LLVM decides to split
    if (!NextDestVecTy.isVector() || (NextDestVecTy.getVectorNumElements() <
                                      OpVecTy.getVectorNumElements())) {
      LLVM_DEBUG(dbgs() << "\tToNext: LLVM decided to split\n";);
      return SDValue();
    }
  }

  //// Does this expansion imply packed mode? /////
  LLVM_DEBUG(dbgs() << "\tSelected target width: " << VectorWidth << "\n";);
  if (VectorWidth > StandardVectorWidth) {
    NeedsPackedMasking = (OpVectorLength % 2 != 0);
    VectorWidth = PackedWidth;
    PackedMode = true;
    if (!Subtarget->hasPackedMode()) {
      LLVM_DEBUG(dbgs() << "\tPacked operations not enabled (set "
                           "-mattr=+packed to enable)!\n";);
      return SDValue(); // possibly redundant
    }
  }

  ///// Translate to a VVP layer operation (VVP_* or VEC_*) /////
  bool isTernaryOp = false;
  bool isBinaryOp = false;
  bool isUnaryOp = false;
  bool isStoreOp = false;
  bool isConvOp = false;
  bool isReduceOp = false;

  switch (Op->getOpcode()) {
  default:
    return SDValue(); // default on this node

  case ISD::BUILD_VECTOR:
  case ISD::VECTOR_SHUFFLE:
    return LowerVectorShuffleOp(Op, DAG, Mode);

  case ISD::EXTRACT_SUBVECTOR:
    return LowerEXTRACT_SUBVECTOR(Op, DAG, Mode);
  case ISD::SCALAR_TO_VECTOR:
    return LowerSCALAR_TO_VECTOR(Op, DAG, Mode);

  case ISD::LOAD:
  case ISD::MLOAD:
    return LowerMLOAD(Op, DAG, Mode);

  case ISD::MSTORE:
    return LowerMSTORE(Op, DAG);

  case ISD::MGATHER:
  case ISD::VP_GATHER:
  case ISD::MSCATTER:
  case ISD::VP_SCATTER:
    return LowerMGATHER_MSCATTER(Op, DAG, Mode);

  case ISD::STORE:
    isStoreOp = true;
    break;

  case ISD::SELECT:
    isTernaryOp = true;
    break;

#define REGISTER_UNARY_VVP_OP(VVP_NAME, NATIVE_ISD)                            \
  case ISD::NATIVE_ISD:                                                        \
    isUnaryOp = true;                                                          \
    break;
#define REGISTER_BINARY_VVP_OP(VVP_NAME, NATIVE_ISD)                           \
  case ISD::NATIVE_ISD:                                                        \
    isBinaryOp = true;                                                         \
    break;
#define REGISTER_TERNARY_VVP_OP(VVP_NAME, NATIVE_ISD)                          \
  case ISD::NATIVE_ISD:                                                        \
    isTernaryOp = true;                                                        \
    break;

#define REGISTER_ICONV_VVP_OP(VVP_NAME, NATIVE_ISD)                            \
  case ISD::NATIVE_ISD:                                                        \
    isConvOp = true;                                                           \
    break;
#define REGISTER_FPCONV_VVP_OP(VVP_NAME, NATIVE_ISD)                           \
  case ISD::NATIVE_ISD:                                                        \
    isConvOp = true;                                                           \
    break;

#define REGISTER_REDUCE_VVP_OP(VVP_NAME, NATIVE_ISD)                           \
  case ISD::NATIVE_ISD:                                                        \
    isReduceOp = true;                                                         \
    break;
#include "VVPNodes.inc"
  }

  // Select VVP Op
  Optional<unsigned> VVPOC = GetVVPOpcode(Op.getOpcode());
  assert(VVPOC.hasValue() &&
         "TODO implement this operation in the VVP isel layer");

  // Select the AVL
  CustomDAG CDAG(DAG, Op);
  unsigned AdjustedLen = PackedMode ? (OpVectorLength + 1) / 2 : OpVectorLength;
  SDValue LenVal = CDAG.getConstant(AdjustedLen, MVT::i32);

  // Is packed mode an option for this OC?
  if (PackedMode && !SupportsPackedMode(VVPOC.getValue())) {
    return ExpandToSplitVVP(Op, DAG, Mode, LenVal);
  }

  // Over-sized even for packed
  if (OpVectorLength > VectorWidth) {
    LLVM_DEBUG(dbgs() << "LowerToVVP: Over-sized vector operation\n");
    return SDValue();
  }

  ///// Widen the actual result type /////
  // FIXME We cannot use the idiomatic type here since that type reflects the
  // operatino vector width (and the element type does not matter as much).
  EVT OldResVT = Op.getValue(0)->getValueType(0);
  EVT ResVecTy = LegalizeVectorType(OldResVT, Op, DAG, Mode);

  /// Use the eventual native vector width for all newly generated operands
  // we do not want to go through ::ReplaceNodeResults again only to have them
  // widened
  unsigned NativeVectorWidth = (OpVectorLength > StandardVectorWidth)
                                   ? PackedWidth
                                   : StandardVectorWidth;
  MVT NativeMaskTy = MVT::getVectorVT(MVT::i1, NativeVectorWidth);

  SDValue MaskVal = CDAG.CreateBroadcast(
      NativeMaskTy,
      CDAG.getConstant(-1, MVT::i1, MVT::i32)); // cannonical type for i1
  assert(!NeedsPackedMasking && "TODO implement packed mask generation");

  // legalize all operands
  SmallVector<SDValue, 4> LegalOperands;
  for (unsigned i = 0; i < Op->getNumOperands(); ++i) {
    LegalOperands.push_back(LegalizeVecOperand(Op->getOperand(i), DAG));
  }

  if (isUnaryOp) {
    assert(VVPOC.hasValue());
    return CDAG.getNode(VVPOC.getValue(), ResVecTy,
                        {LegalOperands[0], MaskVal, LenVal});
  }

  if (isBinaryOp) {
    assert(VVPOC.hasValue());
    return CDAG.getNode(VVPOC.getValue(), ResVecTy,
                        {LegalOperands[0], LegalOperands[1], MaskVal, LenVal});
  }

  if (isTernaryOp) {
    assert(VVPOC.hasValue());
    switch (VVPOC.getValue()) {
    case VEISD::VVP_FFMA: {
      // VE has a swizzled operand order in FMA (compared to LLVM IR and
      // SDNodes).
      return CDAG.getNode(VVPOC.getValue(), ResVecTy,
                          {LegalOperands[2], LegalOperands[0], LegalOperands[1],
                           MaskVal, LenVal});
    }
    case VEISD::VVP_SETCC: {
      return CDAG.getNode(VVPOC.getValue(), ResVecTy,
                          {LegalOperands[0], LegalOperands[1], LegalOperands[2],
                           MaskVal, LenVal});
    }
    case VEISD::VVP_SELECT: {
      return ExpandSELECT(Op, LegalOperands, ResVecTy, CDAG, LenVal);
    }
    default:
      llvm_unreachable("Unexpected ternary operator!");
    }
  }

  if (isStoreOp) {
    SDValue ChainVal = Op->getOperand(0);
    SDValue PtrVal = Op->getOperand(1);
    SDValue DataVal = Op->getOperand(2);
    MVT ChainTy = MVT::Other;

    return CDAG.getNode(
        VEISD::VVP_STORE, ChainTy,
        {ChainVal, PtrVal, LegalizeVecOperand(DataVal, DAG), MaskVal, LenVal});
  }

  if (isConvOp) {
    return CDAG.getNode(VVPOC.getValue(), ResVecTy,
                        {LegalOperands[0], MaskVal, LenVal});
  }

  if (isReduceOp) {
    // FIXME
    SDValue Attempt = LowerVECREDUCE(Op, DAG);
    if (Attempt)
      return Attempt;

    auto PosOpt = getReductionStartParamPos(VVPOC.getValue());
    if (PosOpt) {
      return CDAG.getNode(
          VVPOC.getValue(), ResVecTy,
          {LegalOperands[0], LegalOperands[1], MaskVal, LenVal});
    }

    return CDAG.getNode(VVPOC.getValue(), ResVecTy,
                        {LegalOperands[0], MaskVal, LenVal});
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

#if 0
// TODO DCE
SDValue VETargetLowering::LowerSETCC(SDValue Op, SelectionDAG &DAG) const {
  SDLoc dl(Op);

  // re-adjust vector SETCCs to a v256i1 type
  MVT Ty = Op.getSimpleValueType();
  if (!Ty.isVector())
    return Op;

  if (Ty.getVectorElementType() == MVT::i1)
    return Op;

  LLVM_DEBUG(dbgs() << "Translating vector SETCC to vector mask register\n");

  // this may cause incosistencies in users that needed SETCC to have a v256i64
  // type we fix those up again in ::LowerVectorArithmetic by selecting based on
  // the SETCC result.
  return DAG.getNode(ISD::SETCC, dl, MVT::v256i1, Op.getOperand(0),
                     Op.getOperand(1), Op.getOperand(2));
}
#endif

SDValue VETargetLowering::LowerMGATHER_MSCATTER(SDValue Op, SelectionDAG &DAG,
                                                VVPExpansionMode Mode,
                                                VecLenOpt VecLenHint) const {
  LLVM_DEBUG(dbgs() << "Lowering MGATHER or MSCATTER\n");
  // dbgs() << "\nNext Instr:\n";
  // Op.dumpr(&DAG);

  Optional<EVT> OpVecTyOpt = getIdiomaticType(Op.getNode());
  EVT OpVecTy = OpVecTyOpt.getValue();

  EVT LegalResVT =
      LegalizeVectorType(OpVecTy, Op, DAG, Mode); // vector result type
  CustomDAG CDAG(DAG, Op);

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

SDValue VETargetLowering::LowerEXTRACT_SUBVECTOR(SDValue Op, SelectionDAG &DAG,
                                                 VVPExpansionMode Mode) const {
  auto SrcVec = Op.getOperand(0);
  auto BaseIdxN = Op.getOperand(1);

  assert(isa<ConstantSDNode>(BaseIdxN) && "TODO dynamic extract");
  CustomDAG CDAG(DAG, Op);
  EVT LegalVecTy = LegalizeVectorType(Op.getValueType(), Op, DAG, Mode);

  int64_t ShiftVal = cast<ConstantSDNode>(BaseIdxN)->getSExtValue();

  // Trivial case
  if (ShiftVal == 0) {
    unsigned NarrowLen = Op.getValueType().getVectorNumElements();
    return CDAG.createNarrow(LegalVecTy, SrcVec, NarrowLen);
  }

  // non-trivial mask shift
  return LowerVectorShuffleOp(Op, DAG, Mode);

#if 0
  // Legacy code path
  // Shift by a constant amount
  assert (ShiftVal != 0);
  unsigned DestNumElems = Op.getValueType().getVectorNumElements();
  unsigned PackedVL =
      IsPackedType(Op.getValueType()) ? (DestNumElems + 1) / 2 : DestNumElems;
  return CDAG.createElementShift(LegalVecTy, SrcVec, ShiftVal,
                                 CDAG.getConstEVL(PackedVL));
#endif
}

static Optional<unsigned> GetVVPForVP(unsigned VPOC) {
  switch (VPOC) {
#define HANDLE_VP_TO_VVP(VP_ISD, VVP_VEISD)                                    \
  case ISD::VP_ISD:                                                            \
    return VEISD::VVP_VEISD;
#include "VVPNodes.inc"

  default:
    return None;
  }
}

SDValue VETargetLowering::LowerVPToVVP(SDValue Op, SelectionDAG &DAG) const {
  auto OCOpt = GetVVPForVP(Op.getOpcode());
  assert(OCOpt.hasValue());

  switch (Op.getOpcode()) {
  case ISD::VP_VSHIFT:
    // Lowered to VEC_VMV (inverted shift amount)
    return LowerVP_VSHIFT(Op, DAG);

  case ISD::VP_LOAD:
    return LowerMLOAD(Op, DAG, VVPExpansionMode::ToNativeWidth);
  case ISD::VP_STORE:
    return LowerMSTORE(Op, DAG);

  case ISD::VP_GATHER:
  case ISD::VP_SCATTER:
    return LowerMGATHER_MSCATTER(Op, DAG, VVPExpansionMode::ToNativeWidth,
                                 None);

  default:
    break;
  }

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

  // Create a matching CP_* node
  auto NewN = DAG.getNode(VVPOC, dl, Op.getValueType(), OpVec);
  NewN->setFlags(Op->getFlags());
  return NewN;
}

SDValue VETargetLowering::LowerMLOAD(SDValue Op, SelectionDAG &DAG,
                                     VVPExpansionMode Mode,
                                     VecLenOpt VecLenHint) const {
  LLVM_DEBUG(dbgs() << "Lowering VP/MLOAD\n");
  LLVM_DEBUG(Op.dumpr(&DAG));
  CustomDAG CDAG(DAG, Op);

  SDValue BasePtr;
  SDValue Mask;
  SDValue Chain;
  SDValue PassThru;
  SDValue OpVectorLength;

  MemSDNode *MemN = cast<MemSDNode>(Op.getNode());
  LoadSDNode *LoadN = dyn_cast<LoadSDNode>(Op.getNode());
  MaskedLoadSDNode *MaskedN = dyn_cast<MaskedLoadSDNode>(Op.getNode());
  VPLoadSDNode *VPLoadN = dyn_cast<VPLoadSDNode>(Op.getNode());

  BasePtr = MemN->getBasePtr();
  Chain = MemN->getChain();

  // infer Mask & Passthru
  if (MaskedN) {
    Mask = MaskedN->getMask();
    PassThru = MaskedN->getPassThru();
  } else if (VPLoadN) {
    Mask = VPLoadN->getMask();
  }

  // infer AVL
  if (LoadN || MaskedN) {
    // Infer the AVL
    Optional<EVT> OpVecTyOpt = getIdiomaticType(Op.getNode());
    EVT OpVecTy = OpVecTyOpt.getValue();
    OpVectorLength = CDAG.getConstEVL(OpVecTy.getVectorNumElements());

  } else if (VPLoadN) {
    Mask = VPLoadN->getMask();
    OpVectorLength = VPLoadN->getVectorLength();
  }

  // minimize vector length
  OpVectorLength = ReduceVectorLength(Mask, OpVectorLength, VecLenHint, DAG);

  EVT DataVT = LegalizeVectorType(Op.getNode()->getValueType(0), Op, DAG, Mode);
  MVT ChainVT = Op.getNode()->getSimpleValueType(1);

  // Patch in an all-true mask if required
  if (!Mask) {
    Mask = CDAG.createUniformConstMask(DataVT.getVectorNumElements(), true);
  }

  auto NewLoadV = CDAG.getNode(VEISD::VVP_LOAD, {DataVT, ChainVT},
                               {Chain, BasePtr, Mask, OpVectorLength});

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

SDValue VETargetLowering::LowerMSTORE(SDValue Op, SelectionDAG &DAG) const {
  LLVM_DEBUG(dbgs() << "Lowering VP/MSTORE\n");
  LLVM_DEBUG(Op.dumpr(&DAG));
  SDLoc dl(Op);

  SDValue BasePtr;
  SDValue Mask;
  SDValue Chain;
  SDValue Data;
  SDValue OpVectorLength;

  MaskedStoreSDNode *MaskedN = dyn_cast<MaskedStoreSDNode>(Op.getNode());
  VPStoreSDNode *VPStoreN = dyn_cast<VPStoreSDNode>(Op.getNode());

  if (MaskedN) {
    BasePtr = MaskedN->getBasePtr();
    Mask = MaskedN->getMask();
    Chain = MaskedN->getChain();
    Data = MaskedN->getValue();

    // Infer the AVL
    // TODO set to the highest set bit in the mask operand
    Optional<EVT> OpVecTyOpt = getIdiomaticType(Op.getNode());
    assert(OpVecTyOpt.hasValue());
    EVT OpVecTy = OpVecTyOpt.getValue();
    OpVectorLength =
        DAG.getConstant(OpVecTy.getVectorNumElements(), dl, MVT::i32);

  } else if (VPStoreN) {
    BasePtr = VPStoreN->getBasePtr();
    Mask = VPStoreN->getMask();
    Chain = VPStoreN->getChain();
    OpVectorLength = VPStoreN->getVectorLength();
    Data = VPStoreN->getValue();
  }

  return DAG.getNode(VEISD::VVP_STORE, dl, Op.getNode()->getVTList(),
                     {Chain, Data, BasePtr, Mask, OpVectorLength});
}

SDValue VETargetLowering::LowerVP_VSHIFT(SDValue Op, SelectionDAG &DAG) const {
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

static SDValue PeekThroughCasts(SDValue Op) {
  switch (Op.getOpcode()) {
  default:
    return Op;

  case ISD::ANY_EXTEND:
  case ISD::ZERO_EXTEND:
  case ISD::SIGN_EXTEND:
  case ISD::TRUNCATE:
    return PeekThroughCasts(Op.getOperand(0));
  }
}

SDValue VETargetLowering::LowerVECREDUCE(SDValue Op, SelectionDAG &DAG) const {
  ////  def : Pat<(vecreduce_add v256i1:$vy), (PCVM v256i1:$vy,
  ////                     (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
  ////
  ////  // "any" mask test // TODO do we need to set sign bit proper?
  ////  def : Pat<(vecreduce_or v256i1:$vy), (vecreduce_add v256i1:$vy))>;

  SDLoc dl(Op);

  auto V = Op->getOperand(0);
  EVT VTy = V.getValueType();
  if (VTy != MVT::v256i1)
    return SDValue();

  auto AVL = DAG.getConstant(VTy.getVectorNumElements(), dl, MVT::i32);

  SDValue Result;
  switch (Op->getOpcode()) {
  default:
    llvm_unreachable("not anticipated!");

  case ISD::VECREDUCE_AND:
  case ISD::VECREDUCE_XOR:
    llvm_unreachable("TODO implement");

  case ISD::VECREDUCE_OR: // reduce "any" case to PopCnt(V) != 0
  {
    assert(Op.getOperand(0).getSimpleValueType() == MVT::v256i1);
    SDValue popCount =
        DAG.getNode(VEISD::VEC_POPCOUNT, dl, MVT::i64, {Op.getOperand(0), AVL});
    Result =
        DAG.getSetCC(dl, MVT::i32, popCount, DAG.getConstant(0, dl, MVT::i64),
                     ISD::CondCode::SETNE);

    break;
  }

  case ISD::VECREDUCE_ADD: // reduce "add" case to popcount
  {
    auto VecOp = PeekThroughCasts(Op->getOperand(0));

    if (VecOp.getSimpleValueType() != MVT::v256i1)
      return Op;

    Result = DAG.getNode(VEISD::VEC_POPCOUNT, dl, MVT::i64, {VecOp, AVL});
    break;
  }
  }

  // cast type as required
  auto resTy = Op.getSimpleValueType();
  if (Result.getSimpleValueType() != resTy) {
    assert(resTy == MVT::i32);

    // SDValue SubReg32 = DAG.getTargetConstant(VE::sub_i32, dl, MVT::i32);

    // extract subreg as required
    SDValue Lo32 =
        DAG.getTargetExtractSubreg(VE::sub_i32, dl, MVT::i32, Result);
    return Lo32;
  }

  return Result;
}

SDValue
VETargetLowering::LowerReturn(SDValue Chain, CallingConv::ID CallConv,
                              bool IsVarArg,
                              const SmallVectorImpl<ISD::OutputArg> &Outs,
                              const SmallVectorImpl<SDValue> &OutVals,
                              const SDLoc &DL, SelectionDAG &DAG) const {
  // CCValAssign - represent the assignment of the return value to locations.
  SmallVector<CCValAssign, 16> RVLocs;

  // CCState - Info about the registers and stack slot.
  CCState CCInfo(CallConv, IsVarArg, DAG.getMachineFunction(), RVLocs,
                 *DAG.getContext());

  // Analyze return values.
  CCInfo.AnalyzeReturn(Outs, RetCC_VE);

  SDValue Flag;
  SmallVector<SDValue, 4> RetOps(1, Chain);

  // Copy the result values into the output registers.
  for (unsigned i = 0; i != RVLocs.size(); ++i) {
    CCValAssign &VA = RVLocs[i];
    assert(VA.isRegLoc() && "Can only return in registers!");
    SDValue OutVal = OutVals[i];

    // Integer return values must be sign or zero extended by the callee.
    switch (VA.getLocInfo()) {
    case CCValAssign::Full:
      break;
    case CCValAssign::SExt:
      OutVal = DAG.getNode(ISD::SIGN_EXTEND, DL, VA.getLocVT(), OutVal);
      break;
    case CCValAssign::ZExt:
      OutVal = DAG.getNode(ISD::ZERO_EXTEND, DL, VA.getLocVT(), OutVal);
      break;
    case CCValAssign::AExt:
      OutVal = DAG.getNode(ISD::ANY_EXTEND, DL, VA.getLocVT(), OutVal);
      break;
    default:
      llvm_unreachable("Unknown loc info!");
    }

    assert(!VA.needsCustom() && "Unexpected custom lowering");
    Chain = DAG.getCopyToReg(Chain, DL, VA.getLocReg(), OutVal, Flag);

    // Guarantee that all emitted copies are stuck together with flags.
    Flag = Chain.getValue(1);
    RetOps.push_back(DAG.getRegister(VA.getLocReg(), VA.getLocVT()));
  }

  RetOps[0] = Chain; // Update chain.

  // Add the flag if we have it.
  if (Flag.getNode())
    RetOps.push_back(Flag);

  return DAG.getNode(VEISD::RET_FLAG, DL, MVT::Other, RetOps);
}

SDValue VETargetLowering::LowerFormalArguments(
    SDValue Chain, CallingConv::ID CallConv, bool IsVarArg,
    const SmallVectorImpl<ISD::InputArg> &Ins, const SDLoc &DL,
    SelectionDAG &DAG, SmallVectorImpl<SDValue> &InVals) const {
  MachineFunction &MF = DAG.getMachineFunction();

  // Get the base offset of the incoming arguments stack space.
  unsigned ArgsBaseOffset = 176;
  // Get the size of the preserved arguments area
  unsigned ArgsPreserved = 64;

  // Analyze arguments according to CC_VE.
  SmallVector<CCValAssign, 16> ArgLocs;
  CCState CCInfo(CallConv, IsVarArg, DAG.getMachineFunction(), ArgLocs,
                 *DAG.getContext());
  // Allocate the preserved area first.
  CCInfo.AllocateStack(ArgsPreserved, 8);
  // We already allocated the preserved area, so the stack offset computed
  // by CC_VE would be correct now.
  CCInfo.AnalyzeFormalArguments(Ins, CC_VE);

  for (unsigned i = 0, e = ArgLocs.size(); i != e; ++i) {
    CCValAssign &VA = ArgLocs[i];
    if (VA.isRegLoc()) {
      // This argument is passed in a register.
      // All integer register arguments are promoted by the caller to i64.

      // Create a virtual register for the promoted live-in value.
      unsigned VReg =
          MF.addLiveIn(VA.getLocReg(), getRegClassFor(VA.getLocVT()));
      SDValue Arg = DAG.getCopyFromReg(Chain, DL, VReg, VA.getLocVT());

      // Get the high bits for i32 struct elements.
      if (VA.getValVT() == MVT::i32 && VA.needsCustom())
        Arg = DAG.getNode(ISD::SRL, DL, VA.getLocVT(), Arg,
                          DAG.getConstant(32, DL, MVT::i32));

      // The caller promoted the argument, so insert an Assert?ext SDNode so we
      // won't promote the value again in this function.
      switch (VA.getLocInfo()) {
      case CCValAssign::SExt:
        Arg = DAG.getNode(ISD::AssertSext, DL, VA.getLocVT(), Arg,
                          DAG.getValueType(VA.getValVT()));
        break;
      case CCValAssign::ZExt:
        Arg = DAG.getNode(ISD::AssertZext, DL, VA.getLocVT(), Arg,
                          DAG.getValueType(VA.getValVT()));
        break;
      default:
        break;
      }

      // Truncate the register down to the argument type.
      if (VA.isExtInLoc())
        Arg = DAG.getNode(ISD::TRUNCATE, DL, VA.getValVT(), Arg);

      InVals.push_back(Arg);
      continue;
    }

    // The registers are exhausted. This argument was passed on the stack.
    assert(VA.isMemLoc());
    // The CC_VE_Full/Half functions compute stack offsets relative to the
    // beginning of the arguments area at %fp+176.
    unsigned Offset = VA.getLocMemOffset() + ArgsBaseOffset;
    unsigned ValSize = VA.getValVT().getSizeInBits() / 8;
    int FI = MF.getFrameInfo().CreateFixedObject(ValSize, Offset, true);
    InVals.push_back(
        DAG.getLoad(VA.getValVT(), DL, Chain,
                    DAG.getFrameIndex(FI, getPointerTy(MF.getDataLayout())),
                    MachinePointerInfo::getFixedStack(MF, FI)));
  }

  if (!IsVarArg)
    return Chain;

  // This function takes variable arguments, some of which may have been passed
  // in registers %s0-%s8.
  //
  // The va_start intrinsic needs to know the offset to the first variable
  // argument.
  // TODO: need to calculate offset correctly once we support f128.
  unsigned ArgOffset = ArgLocs.size() * 8;
  VEMachineFunctionInfo *FuncInfo = MF.getInfo<VEMachineFunctionInfo>();
  // Skip the 176 bytes of register save area.
  FuncInfo->setVarArgsFrameOffset(ArgOffset + ArgsBaseOffset);

  return Chain;
}

// FIXME? Maybe this could be a TableGen attribute on some registers and
// this table could be generated automatically from RegInfo.
Register VETargetLowering::getRegisterByName(const char *RegName, LLT VT,
                                             const MachineFunction &MF) const {
  Register Reg = StringSwitch<Register>(RegName)
                     .Case("sp", VE::SX11)    // Stack pointer
                     .Case("fp", VE::SX9)     // Frame pointer
                     .Case("sl", VE::SX8)     // Stack limit
                     .Case("lr", VE::SX10)    // Link regsiter
                     .Case("tp", VE::SX14)    // Thread pointer
                     .Case("outer", VE::SX12) // Outer regiser
                     .Case("info", VE::SX17)  // Info area register
                     .Case("got", VE::SX15)   // Global offset table register
                     .Case("plt", VE::SX16)  // Procedure linkage table register
                     .Case("usrcc", VE::UCC) // User clock counter
                     .Default(0);

  if (Reg)
    return Reg;

  report_fatal_error("Invalid register name global variable");
}

// This functions returns true if CalleeName is a ABI function that returns
// a long double (fp128).
static bool isFP128ABICall(const char *CalleeName) {
  static const char *const ABICalls[] = {
      "_Q_add",   "_Q_sub",    "_Q_mul",  "_Q_div",  "_Q_sqrt",
      "_Q_neg",   "_Q_itoq",   "_Q_stoq", "_Q_dtoq", "_Q_utoq",
      "_Q_lltoq", "_Q_ulltoq", nullptr};
  for (const char *const *I = ABICalls; *I != nullptr; ++I)
    if (strcmp(CalleeName, *I) == 0)
      return true;
  return false;
}

//===----------------------------------------------------------------------===//
// TargetLowering Implementation
//===----------------------------------------------------------------------===//

SDValue VETargetLowering::LowerCall(TargetLowering::CallLoweringInfo &CLI,
                                    SmallVectorImpl<SDValue> &InVals) const {
  SelectionDAG &DAG = CLI.DAG;
  SDLoc DL = CLI.DL;
  SDValue Chain = CLI.Chain;
  auto PtrVT = getPointerTy(DAG.getDataLayout());

  // VE target does not yet support tail call optimization.
  CLI.IsTailCall = false;

  // Get the base offset of the outgoing arguments stack space.
  unsigned ArgsBaseOffset = 176;
  // Get the size of the preserved arguments area
  unsigned ArgsPreserved = 8 * 8u;

  // Analyze operands of the call, assigning locations to each operand.
  SmallVector<CCValAssign, 16> ArgLocs;
  CCState CCInfo(CLI.CallConv, CLI.IsVarArg, DAG.getMachineFunction(), ArgLocs,
                 *DAG.getContext());
  // Allocate the preserved area first.
  CCInfo.AllocateStack(ArgsPreserved, 8);
  // We already allocated the preserved area, so the stack offset computed
  // by CC_VE would be correct now.
  CCInfo.AnalyzeCallOperands(CLI.Outs, CC_VE);

  // VE requires to use both register and stack for varargs or no-prototyped
  // functions.
  bool UseBoth = CLI.IsVarArg;

  // Analyze operands again if it is required to store BOTH.
  SmallVector<CCValAssign, 16> ArgLocs2;
  CCState CCInfo2(CLI.CallConv, CLI.IsVarArg, DAG.getMachineFunction(),
                  ArgLocs2, *DAG.getContext());
  if (UseBoth)
    CCInfo2.AnalyzeCallOperands(CLI.Outs, CC_VE2);

  // Get the size of the outgoing arguments stack space requirement.
  unsigned ArgsSize = CCInfo.getNextStackOffset();

  // Keep stack frames 16-byte aligned.
  ArgsSize = alignTo(ArgsSize, 16);

  // Adjust the stack pointer to make room for the arguments.
  // FIXME: Use hasReservedCallFrame to avoid %sp adjustments around all calls
  // with more than 6 arguments.
  Chain = DAG.getCALLSEQ_START(Chain, ArgsSize, 0, DL);

  // Collect the set of registers to pass to the function and their values.
  // This will be emitted as a sequence of CopyToReg nodes glued to the call
  // instruction.
  SmallVector<std::pair<unsigned, SDValue>, 8> RegsToPass;

  // Collect chains from all the memory opeations that copy arguments to the
  // stack. They must follow the stack pointer adjustment above and precede the
  // call instruction itself.
  SmallVector<SDValue, 8> MemOpChains;

  // VE needs to get address of callee function in a register
  // So, prepare to copy it to SX12 here.

  // If the callee is a GlobalAddress node (quite common, every direct call is)
  // turn it into a TargetGlobalAddress node so that legalize doesn't hack it.
  // Likewise ExternalSymbol -> TargetExternalSymbol.
  SDValue Callee = CLI.Callee;

  bool IsPICCall = isPositionIndependent();

  // PC-relative references to external symbols should go through $stub.
  // If so, we need to prepare GlobalBaseReg first.
  const TargetMachine &TM = DAG.getTarget();
  const Module *Mod = DAG.getMachineFunction().getFunction().getParent();
  const GlobalValue *GV = nullptr;
  if (auto *G = dyn_cast<GlobalAddressSDNode>(Callee))
    GV = G->getGlobal();
  bool Local = TM.shouldAssumeDSOLocal(*Mod, GV);
  bool UsePlt = !Local;
  MachineFunction &MF = DAG.getMachineFunction();

  // Turn GlobalAddress/ExternalSymbol node into a value node
  // containing the address of them here.
  if (GlobalAddressSDNode *G = dyn_cast<GlobalAddressSDNode>(Callee)) {
    if (IsPICCall) {
      if (UsePlt)
        Subtarget->getInstrInfo()->getGlobalBaseReg(&MF);
      Callee = DAG.getTargetGlobalAddress(G->getGlobal(), DL, PtrVT, 0, 0);
      Callee = DAG.getNode(VEISD::GETFUNPLT, DL, PtrVT, Callee);
    } else {
      Callee =
          makeHiLoPair(Callee, VEMCExpr::VK_VE_HI32, VEMCExpr::VK_VE_LO32, DAG);
    }
  } else if (ExternalSymbolSDNode *E = dyn_cast<ExternalSymbolSDNode>(Callee)) {
    if (IsPICCall) {
      if (UsePlt)
        Subtarget->getInstrInfo()->getGlobalBaseReg(&MF);
      Callee = DAG.getTargetExternalSymbol(E->getSymbol(), PtrVT, 0);
      Callee = DAG.getNode(VEISD::GETFUNPLT, DL, PtrVT, Callee);
    } else {
      Callee =
          makeHiLoPair(Callee, VEMCExpr::VK_VE_HI32, VEMCExpr::VK_VE_LO32, DAG);
    }
  }

  RegsToPass.push_back(std::make_pair(VE::SX12, Callee));

  for (unsigned i = 0, e = ArgLocs.size(); i != e; ++i) {
    CCValAssign &VA = ArgLocs[i];
    SDValue Arg = CLI.OutVals[i];

    // Promote the value if needed.
    switch (VA.getLocInfo()) {
    default:
      llvm_unreachable("Unknown location info!");
    case CCValAssign::Full:
      break;
    case CCValAssign::SExt:
      Arg = DAG.getNode(ISD::SIGN_EXTEND, DL, VA.getLocVT(), Arg);
      break;
    case CCValAssign::ZExt:
      Arg = DAG.getNode(ISD::ZERO_EXTEND, DL, VA.getLocVT(), Arg);
      break;
    case CCValAssign::AExt:
      Arg = DAG.getNode(ISD::ANY_EXTEND, DL, VA.getLocVT(), Arg);
      break;
    }

    if (VA.isRegLoc()) {
      RegsToPass.push_back(std::make_pair(VA.getLocReg(), Arg));
      if (!UseBoth)
        continue;
      VA = ArgLocs2[i];
    }

    assert(VA.isMemLoc());

    // Create a store off the stack pointer for this argument.
    SDValue StackPtr = DAG.getRegister(VE::SX11, PtrVT);
    // The argument area starts at %fp+176 in the callee frame,
    // %sp+176 in ours.
    SDValue PtrOff =
        DAG.getIntPtrConstant(VA.getLocMemOffset() + ArgsBaseOffset, DL);
    PtrOff = DAG.getNode(ISD::ADD, DL, PtrVT, StackPtr, PtrOff);
    MemOpChains.push_back(
        DAG.getStore(Chain, DL, Arg, PtrOff, MachinePointerInfo()));
  }

  // Emit all stores, make sure they occur before the call.
  if (!MemOpChains.empty())
    Chain = DAG.getNode(ISD::TokenFactor, DL, MVT::Other, MemOpChains);

  // Build a sequence of CopyToReg nodes glued together with token chain and
  // glue operands which copy the outgoing args into registers. The InGlue is
  // necessary since all emitted instructions must be stuck together in order
  // to pass the live physical registers.
  SDValue InGlue;
  for (unsigned i = 0, e = RegsToPass.size(); i != e; ++i) {
    Chain = DAG.getCopyToReg(Chain, DL, RegsToPass[i].first,
                             RegsToPass[i].second, InGlue);
    InGlue = Chain.getValue(1);
  }

  // Build the operands for the call instruction itself.
  SmallVector<SDValue, 8> Ops;
  Ops.push_back(Chain);
  for (unsigned i = 0, e = RegsToPass.size(); i != e; ++i)
    Ops.push_back(DAG.getRegister(RegsToPass[i].first,
                                  RegsToPass[i].second.getValueType()));

  // Add a register mask operand representing the call-preserved registers.
  const VERegisterInfo *TRI = Subtarget->getRegisterInfo();
  const uint32_t *Mask =
      TRI->getCallPreservedMask(DAG.getMachineFunction(), CLI.CallConv);
  assert(Mask && "Missing call preserved mask for calling convention");
  Ops.push_back(DAG.getRegisterMask(Mask));

  // Make sure the CopyToReg nodes are glued to the call instruction which
  // consumes the registers.
  if (InGlue.getNode())
    Ops.push_back(InGlue);

  // Now the call itself.
  SDVTList NodeTys = DAG.getVTList(MVT::Other, MVT::Glue);
  Chain = DAG.getNode(VEISD::CALL, DL, NodeTys, Ops);
  InGlue = Chain.getValue(1);

  // Revert the stack pointer immediately after the call.
  Chain = DAG.getCALLSEQ_END(Chain, DAG.getIntPtrConstant(ArgsSize, DL, true),
                             DAG.getIntPtrConstant(0, DL, true), InGlue, DL);
  InGlue = Chain.getValue(1);

  // Now extract the return values. This is more or less the same as
  // LowerFormalArguments.

  // Assign locations to each value returned by this call.
  SmallVector<CCValAssign, 16> RVLocs;
  CCState RVInfo(CLI.CallConv, CLI.IsVarArg, DAG.getMachineFunction(), RVLocs,
                 *DAG.getContext());

  // Set inreg flag manually for codegen generated library calls that
  // return float.
  if (CLI.Ins.size() == 1 && CLI.Ins[0].VT == MVT::f32 && !CLI.CS)
    CLI.Ins[0].Flags.setInReg();

  RVInfo.AnalyzeCallResult(CLI.Ins, RetCC_VE);

  // Copy all of the result registers out of their specified physreg.
  for (unsigned i = 0; i != RVLocs.size(); ++i) {
    CCValAssign &VA = RVLocs[i];
    unsigned Reg = VA.getLocReg();

    // When returning 'inreg {i32, i32 }', two consecutive i32 arguments can
    // reside in the same register in the high and low bits. Reuse the
    // CopyFromReg previous node to avoid duplicate copies.
    SDValue RV;
    if (RegisterSDNode *SrcReg = dyn_cast<RegisterSDNode>(Chain.getOperand(1)))
      if (SrcReg->getReg() == Reg && Chain->getOpcode() == ISD::CopyFromReg)
        RV = Chain.getValue(0);

    // But usually we'll create a new CopyFromReg for a different register.
    if (!RV.getNode()) {
      RV = DAG.getCopyFromReg(Chain, DL, Reg, RVLocs[i].getLocVT(), InGlue);
      Chain = RV.getValue(1);
      InGlue = Chain.getValue(2);
    }

    // Get the high bits for i32 struct elements.
    if (VA.getValVT() == MVT::i32 && VA.needsCustom())
      RV = DAG.getNode(ISD::SRL, DL, VA.getLocVT(), RV,
                       DAG.getConstant(32, DL, MVT::i32));

    // The callee promoted the return value, so insert an Assert?ext SDNode so
    // we won't promote the value again in this function.
    switch (VA.getLocInfo()) {
    case CCValAssign::SExt:
      RV = DAG.getNode(ISD::AssertSext, DL, VA.getLocVT(), RV,
                       DAG.getValueType(VA.getValVT()));
      break;
    case CCValAssign::ZExt:
      RV = DAG.getNode(ISD::AssertZext, DL, VA.getLocVT(), RV,
                       DAG.getValueType(VA.getValVT()));
      break;
    default:
      break;
    }

    // Truncate the register down to the return value type.
    if (VA.isExtInLoc())
      RV = DAG.getNode(ISD::TRUNCATE, DL, VA.getValVT(), RV);

    InVals.push_back(RV);
  }

  return Chain;
}

/// isFPImmLegal - Returns true if the target can instruction select the
/// specified FP immediate natively. If false, the legalizer will
/// materialize the FP immediate as a load from a constant pool.
bool VETargetLowering::isFPImmLegal(const APFloat &Imm, EVT VT,
                                    bool ForCodeSize) const {
  return VT == MVT::f32 || VT == MVT::f64;
}

/// Determine if the target supports unaligned memory accesses.
///
/// This function returns true if the target allows unaligned memory accesses
/// of the specified type in the given address space. If true, it also returns
/// whether the unaligned memory access is "fast" in the last argument by
/// reference. This is used, for example, in situations where an array
/// copy/move/set is converted to a sequence of store operations. Its use
/// helps to ensure that such replacements don't generate code that causes an
/// alignment error (trap) on the target machine.
bool VETargetLowering::allowsMisalignedMemoryAccesses(EVT VT,
                                                      unsigned AddrSpace,
                                                      unsigned Align,
                                                      MachineMemOperand::Flags,
                                                      bool *Fast) const {
  if (Fast) {
    // It's fast anytime on VE
    *Fast = true;
  }
  return true;
}

bool VETargetLowering::canMergeStoresTo(unsigned AddressSpace, EVT MemVT,
                                        const SelectionDAG &DAG) const {
  // Do not merge to float value size (128 bytes) if no implicit
  // float attribute is set.
  bool NoFloat = DAG.getMachineFunction().getFunction().hasFnAttribute(
      Attribute::NoImplicitFloat);

  if (NoFloat) {
    unsigned MaxIntSize = 64;
    return (MemVT.getSizeInBits() <= MaxIntSize);
  }
  return true;
}

TargetLowering::AtomicExpansionKind
VETargetLowering::shouldExpandAtomicRMWInIR(AtomicRMWInst *AI) const {
  if (AI->getOperation() == AtomicRMWInst::Xchg) {
    const DataLayout &DL = AI->getModule()->getDataLayout();
    if (DL.getTypeStoreSize(AI->getValOperand()->getType()) == 2)
      return AtomicExpansionKind::CmpXChg; // Uses cas instruction for 2byte
                                           // atomic_swap
    return AtomicExpansionKind::None;      // Uses ts1am instruction
  }
  return AtomicExpansionKind::CmpXChg;
}

void VETargetLowering::initSPUActions() {
  const auto &TM = getTargetMachine();

  /// Load & Store {
  for (MVT FPVT : MVT::fp_valuetypes()) {
    for (MVT OtherFPVT : MVT::fp_valuetypes()) {
      // Turn FP extload into load/fpextend
      setLoadExtAction(ISD::EXTLOAD, FPVT, OtherFPVT, Expand);

      // Turn FP truncstore into trunc + store.
      setTruncStoreAction(FPVT, OtherFPVT, Expand);
    }
  }

  // VE doesn't have i1 sign extending load
  for (MVT VT : MVT::integer_valuetypes()) {
    setLoadExtAction(ISD::SEXTLOAD, VT, MVT::i1, Promote);
    setLoadExtAction(ISD::ZEXTLOAD, VT, MVT::i1, Promote);
    setLoadExtAction(ISD::EXTLOAD, VT, MVT::i1, Promote);
    setTruncStoreAction(VT, MVT::i1, Expand);
  }
  /// } Load & Store

  // Custom legalize address nodes into LO/HI parts.
  MVT PtrVT = MVT::getIntegerVT(TM.getPointerSizeInBits(0));
  setOperationAction(ISD::BlockAddress, PtrVT, Custom);
  setOperationAction(ISD::GlobalAddress, PtrVT, Custom);
  setOperationAction(ISD::GlobalTLSAddress, PtrVT, Custom);
  setOperationAction(ISD::ConstantPool, PtrVT, Custom);

  // VE doesn't have BRCOND
  setOperationAction(ISD::BRCOND, MVT::Other, Expand);

  // BRIND/BR_JT are not implemented yet.
  //   FIXME: BRIND instruction is implemented, but JumpTable is not yet.
  setOperationAction(ISD::BRIND, MVT::Other, Expand);
  setOperationAction(ISD::BR_JT, MVT::Other, Expand);

  setOperationAction(ISD::EH_SJLJ_SETJMP, MVT::i32, Custom);
  setOperationAction(ISD::EH_SJLJ_LONGJMP, MVT::Other, Custom);
  setOperationAction(ISD::EH_SJLJ_SETUP_DISPATCH, MVT::Other, Custom);
  if (TM.Options.ExceptionModel == ExceptionHandling::SjLj)
    setLibcallName(RTLIB::UNWIND_RESUME, "_Unwind_SjLj_Resume");

  setTargetDAGCombine(ISD::FADD);
  // setTargetDAGCombine(ISD::FMA);

  // ATOMICs.
  // Atomics are supported on VE.
  setMaxAtomicSizeInBitsSupported(64);
  setMinCmpXchgSizeInBits(32);
  setSupportsUnalignedAtomics(false);

  // Use custom inserter, LowerATOMIC_FENCE, for ATOMIC_FENCE.
  setOperationAction(ISD::ATOMIC_FENCE, MVT::Other, Custom);

  for (MVT VT : MVT::integer_valuetypes()) {
    // Several atomic operations are converted to VE instructions well.
    // Additional memory fences are generated in emitLeadingfence and
    // emitTrailingFence functions.
    setOperationAction(ISD::ATOMIC_LOAD, VT, Legal);
    setOperationAction(ISD::ATOMIC_STORE, VT, Legal);
    setOperationAction(ISD::ATOMIC_CMP_SWAP, VT, Legal);
    setOperationAction(ISD::ATOMIC_SWAP, VT, Legal);

    setOperationAction(ISD::ATOMIC_CMP_SWAP_WITH_SUCCESS, VT, Expand);

    // FIXME: not supported "atmam" isntructions yet
    setOperationAction(ISD::ATOMIC_LOAD_ADD, VT, Expand);
    setOperationAction(ISD::ATOMIC_LOAD_SUB, VT, Expand);
    setOperationAction(ISD::ATOMIC_LOAD_AND, VT, Expand);
    setOperationAction(ISD::ATOMIC_LOAD_OR, VT, Expand);

    // VE doesn't have follwing instructions
    setOperationAction(ISD::ATOMIC_LOAD_CLR, VT, Expand);
    setOperationAction(ISD::ATOMIC_LOAD_XOR, VT, Expand);
    setOperationAction(ISD::ATOMIC_LOAD_NAND, VT, Expand);
    setOperationAction(ISD::ATOMIC_LOAD_MIN, VT, Expand);
    setOperationAction(ISD::ATOMIC_LOAD_MAX, VT, Expand);
    setOperationAction(ISD::ATOMIC_LOAD_UMIN, VT, Expand);
    setOperationAction(ISD::ATOMIC_LOAD_UMAX, VT, Expand);
  }

  // FIXME: VE's I128 stuff is not investigated yet
#if 0
  // These libcalls are not available in 32-bit.
  setLibcallName(RTLIB::SHL_I128, nullptr);
  setLibcallName(RTLIB::SRL_I128, nullptr);
  setLibcallName(RTLIB::SRA_I128, nullptr);
#endif

  for (MVT VT : MVT::fp_valuetypes()) {
    // VE has no sclar FMA instruction
    setOperationAction(ISD::FMA, VT, Expand);
    setOperationAction(ISD::FMAD, VT, Expand);
    setOperationAction(ISD::FREM, VT, Expand);
    setOperationAction(ISD::FNEG, VT, Expand);
    setOperationAction(ISD::FABS, VT, Expand);
    setOperationAction(ISD::FSQRT, VT, Expand);
    setOperationAction(ISD::FSIN, VT, Expand);
    setOperationAction(ISD::FCOS, VT, Expand);
    setOperationAction(ISD::FPOWI, VT, Expand);
    setOperationAction(ISD::FPOW, VT, Expand);
    setOperationAction(ISD::FLOG, VT, Expand);
    setOperationAction(ISD::FLOG2, VT, Expand);
    setOperationAction(ISD::FLOG10, VT, Expand);
    setOperationAction(ISD::FEXP, VT, Expand);
    setOperationAction(ISD::FEXP2, VT, Expand);
    setOperationAction(ISD::FCEIL, VT, Expand);
    setOperationAction(ISD::FTRUNC, VT, Expand);
    setOperationAction(ISD::FRINT, VT, Expand);
    setOperationAction(ISD::FNEARBYINT, VT, Expand);
    setOperationAction(ISD::FROUND, VT, Expand);
    setOperationAction(ISD::FFLOOR, VT, Expand);
    setOperationAction(ISD::FMINNUM, VT, Expand);
    setOperationAction(ISD::FMAXNUM, VT, Expand);
    setOperationAction(ISD::FMINIMUM, VT, Expand);
    setOperationAction(ISD::FMAXIMUM, VT, Expand);
    setOperationAction(ISD::FSINCOS, VT, Expand);
  }

  // FIXME: VE's FCOPYSIGN is not investivated yet
  setOperationAction(ISD::FCOPYSIGN, MVT::f128, Expand);
  setOperationAction(ISD::FCOPYSIGN, MVT::f64, Expand);
  setOperationAction(ISD::FCOPYSIGN, MVT::f32, Expand);

  // FIXME: VE's SHL_PARTS and others are not investigated yet.
  setOperationAction(ISD::SHL_PARTS, MVT::i32, Expand);
  setOperationAction(ISD::SRA_PARTS, MVT::i32, Expand);
  setOperationAction(ISD::SRL_PARTS, MVT::i32, Expand);
  setOperationAction(ISD::SHL_PARTS, MVT::i64, Expand);
  setOperationAction(ISD::SRA_PARTS, MVT::i64, Expand);
  setOperationAction(ISD::SRL_PARTS, MVT::i64, Expand);

  // Expands to [SU]MUL_LOHI.
  setOperationAction(ISD::MULHU, MVT::i32, Expand);
  setOperationAction(ISD::MULHS, MVT::i32, Expand);

  setOperationAction(ISD::UMUL_LOHI, MVT::i64, Expand);
  setOperationAction(ISD::SMUL_LOHI, MVT::i64, Expand);
  setOperationAction(ISD::MULHU, MVT::i64, Expand);
  setOperationAction(ISD::MULHS, MVT::i64, Expand);

  setOperationAction(ISD::UMULO, MVT::i64, Custom);
  setOperationAction(ISD::SMULO, MVT::i64, Custom);

  setOperationAction(ISD::BITREVERSE, MVT::i32, Promote);
  setOperationAction(ISD::BITREVERSE, MVT::i64, Legal);
  setOperationAction(ISD::BSWAP, MVT::i32, Legal);
  setOperationAction(ISD::BSWAP, MVT::i64, Legal);
  setOperationAction(ISD::CTPOP, MVT::i32, Legal);
  setOperationAction(ISD::CTPOP, MVT::i64, Legal);
  setOperationAction(ISD::CTLZ, MVT::i32, Legal);
  setOperationAction(ISD::CTLZ, MVT::i64, Legal);
  setOperationAction(ISD::CTTZ, MVT::i32, Promote);
  setOperationAction(ISD::CTTZ, MVT::i64, Expand);
  setOperationAction(ISD::ROTL, MVT::i32, Expand);
  setOperationAction(ISD::ROTL, MVT::i64, Expand);
  setOperationAction(ISD::ROTR, MVT::i32, Expand);
  setOperationAction(ISD::ROTR, MVT::i64, Expand);

  // Use the default implementation.
  setOperationAction(ISD::STACKSAVE, MVT::Other, Expand);
  setOperationAction(ISD::STACKRESTORE, MVT::Other, Expand);

  // Expand DYNAMIC_STACKALLOC
  setOperationAction(ISD::DYNAMIC_STACKALLOC, MVT::i32, Custom);
  setOperationAction(ISD::DYNAMIC_STACKALLOC, MVT::i64, Custom);

  // LOAD/STORE for f128 needs to be custom lowered to expand two loads/stores
  setOperationAction(ISD::LOAD, MVT::f128, Custom);
  setOperationAction(ISD::STORE, MVT::f128, Custom);

  // VE has FAQ, FSQ, FMQ, and FCQ
  setOperationAction(ISD::FADD, MVT::f128, Legal);
  setOperationAction(ISD::FSUB, MVT::f128, Legal);
  setOperationAction(ISD::FMUL, MVT::f128, Legal);
  setOperationAction(ISD::FDIV, MVT::f128, Expand);
  setOperationAction(ISD::FSQRT, MVT::f128, Expand);
  setOperationAction(ISD::FP_EXTEND, MVT::f128, Legal);
  setOperationAction(ISD::FP_ROUND, MVT::f128, Legal);

  // Other configurations related to f128.
  setOperationAction(ISD::SELECT, MVT::f128, Legal);
  setOperationAction(ISD::SELECT_CC, MVT::f128, Legal);
  setOperationAction(ISD::SETCC, MVT::f128, Legal);
  setOperationAction(ISD::BR_CC, MVT::f128, Legal);

  setOperationAction(ISD::INTRINSIC_VOID, MVT::Other, Custom);
  setOperationAction(ISD::INTRINSIC_W_CHAIN, MVT::Other, Custom);
  setOperationAction(ISD::INTRINSIC_WO_CHAIN, MVT::Other, Custom);

  // TRAP to expand (which turns it into abort).
  setOperationAction(ISD::TRAP, MVT::Other, Expand);

  // On most systems, DEBUGTRAP and TRAP have no difference. The "Expand"
  // here is to inform DAG Legalizer to replace DEBUGTRAP with TRAP.
  setOperationAction(ISD::DEBUGTRAP, MVT::Other, Expand);

  /// VAARG handling {
  setOperationAction(ISD::VASTART, MVT::Other, Custom);
  // VAARG needs to be lowered to access with 8 bytes alignment.
  setOperationAction(ISD::VAARG, MVT::Other, Custom);
  // Use the default implementation.
  setOperationAction(ISD::VACOPY, MVT::Other, Expand);
  setOperationAction(ISD::VAEND, MVT::Other, Expand);
  /// } VAARG handling

  // VE has no REM or DIVREM operations.
  for (MVT IntVT : MVT::integer_valuetypes()) {
    setOperationAction(ISD::UREM, IntVT, Expand);
    setOperationAction(ISD::SREM, IntVT, Expand);
    setOperationAction(ISD::SDIVREM, IntVT, Expand);
    setOperationAction(ISD::UDIVREM, IntVT, Expand);
  }

  /// Conversion {
  // VE doesn't have instructions for fp<->uint, so expand them by llvm
  setOperationAction(ISD::FP_TO_UINT, MVT::i32, Promote);
  setOperationAction(ISD::UINT_TO_FP, MVT::i32, Promote);
  setOperationAction(ISD::FP_TO_UINT, MVT::i64, Expand);
  setOperationAction(ISD::UINT_TO_FP, MVT::i64, Expand);

  // fp16 not supported
  for (MVT FPVT : MVT::fp_valuetypes()) {
    setOperationAction(ISD::FP16_TO_FP, FPVT, Expand);
    setOperationAction(ISD::FP_TO_FP16, FPVT, Expand);
  }
  /// } Conversion
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

      // TODO
      ISD::FSQRT,

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
      ISD::BSWAP, ISD::BITREVERSE, ISD::CTLZ, ISD::CTLZ_ZERO_UNDEF, ISD::CTTZ,
      ISD::CTTZ_ZERO_UNDEF, ISD::ADDC, ISD::ADDCARRY, ISD::MULHS, ISD::MULHU,
      ISD::SMUL_LOHI, ISD::UMUL_LOHI,

      // genuinely  unsupported
      ISD::UREM, ISD::SREM, ISD::SDIVREM, ISD::UDIVREM, ISD::FP16_TO_FP,
      ISD::FP_TO_FP16, END_OF_OCLIST};

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

  const ISD::NodeType ToIntCastOCs[] = {// casts
                                        ISD::TRUNCATE,
                                        ISD::SIGN_EXTEND_VECTOR_INREG,
                                        ISD::ZERO_EXTEND_VECTOR_INREG,
                                        ISD::FP_TO_SINT,
                                        ISD::FP_TO_UINT,
                                        END_OF_OCLIST};

  const ISD::NodeType ToFPCastOCs[] = {// casts
                                       ISD::FP_EXTEND, ISD::SINT_TO_FP,
                                       ISD::UINT_TO_FP, END_OF_OCLIST};

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
      ISD::VECREDUCE_STRICT_FADD, ISD::VECREDUCE_STRICT_FMUL, END_OF_OCLIST};

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

  // All mask ops
  for (MVT MaskVT : MVT::vector_valuetypes()) {
    if (MaskVT.getVectorElementType() != MVT::i1)
      continue;

    // Mask producing operations
    setOperationAction(ISD::INSERT_VECTOR_ELT, MaskVT, Expand);
    setOperationAction(ISD::EXTRACT_VECTOR_ELT, MaskVT, Custom);

    // Lower to vvp_trunc
    setOperationAction(ISD::TRUNCATE, MaskVT, Custom);

    // Custom lower mask ops
    setOperationAction(ISD::STORE, MaskVT, Custom);
    // setOperationAction(ISD::LOAD, MaskVT, Custom);
    // FIXME vm loads,stores should be symmetric?

    ForAll_setOperationAction(IntReductionOCs, MaskVT, Custom);
    ForAll_setOperationAction(VectorTransformOCs, MaskVT, Custom);
  }

  // Special rules for aliased mask types
  if (Subtarget->isVELIntrinsicMode()) {
    for (MVT MaskVT : {MVT::v4i64, MVT::v8i64}) {
      // Mask producing operations
      setOperationAction(ISD::INSERT_VECTOR_ELT, MaskVT, Expand);
      setOperationAction(ISD::EXTRACT_VECTOR_ELT, MaskVT, Custom);
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
#define REGISTER_VVP_OP(VVP_NAME, ISD_NAME)                                    \
  setOperationAction(ISD::ISD_NAME, VT, Custom);
#include "VVPNodes.inc"
  }

  // X -> vp_* funnel
  for (MVT VT : MVT::vector_valuetypes()) {
    LegalizeAction Action;
    if ((VT.getVectorNumElements() == 256) ||
        (VT.getVectorNumElements() == 512)) {
      Action = Custom;
    } else {
      Action = Expand; // custom expansion to native-width operation
    }

    // llvm.masked.* -> vvp lowering
    setOperationAction(ISD::MSCATTER, VT, Custom);
    setOperationAction(ISD::MGATHER, VT, Custom);
    setOperationAction(ISD::MLOAD, VT, Custom);
    setOperationAction(ISD::MSTORE, VT, Custom);

    // VP -> VVP lowering
#define REGISTER_VP_SDNODE(VP_NAME, VP_TEXT, MASK_POS, LEN_POS)                \
  setOperationAction(ISD::VP_NAME, VT, Action);
#include "llvm/IR/VPIntrinsics.def"
  }

  // Reduction ops are mapped with their result type
  for (MVT ResVT : {MVT::f64, MVT::f32, MVT::i64, MVT::i32}) {
#define REGISTER_REDUCE_VVP_OP(VVP_NAME, ISD_NAME)                             \
  setOperationAction(ISD::ISD_NAME, ResVT, Custom);
#include "VVPNodes.inc"
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
  /// } Vector Lowering
}

void VETargetLowering::initRegisterClasses() {
  // Set up the register classes.
  // SPU registers
  addRegisterClass(MVT::i32, &VE::I32RegClass);
  addRegisterClass(MVT::i64, &VE::I64RegClass);
  addRegisterClass(MVT::f32, &VE::F32RegClass);
  addRegisterClass(MVT::f64, &VE::I64RegClass);
  addRegisterClass(MVT::f128, &VE::F128RegClass);

  // VPU registers
  if (Subtarget->enableVPU()) {
    addRegisterClass(MVT::v256i32, &VE::V64RegClass);
    addRegisterClass(MVT::v256i64, &VE::V64RegClass);
    addRegisterClass(MVT::v256f32, &VE::V64RegClass);
    addRegisterClass(MVT::v256f64, &VE::V64RegClass);
    addRegisterClass(MVT::v256i1, &VE::VMRegClass);

    if (Subtarget->hasPackedMode()) {
      addRegisterClass(MVT::v512i32, &VE::V64RegClass);
      addRegisterClass(MVT::v512f32, &VE::V64RegClass);
      addRegisterClass(MVT::v512i1, &VE::VM512RegClass);
    }

    // Support mask DT for target intrinsics
    if (Subtarget->isVELIntrinsicMode()) {
      addRegisterClass(MVT::v4i64, &VE::VMRegClass);
      addRegisterClass(MVT::v8i64, &VE::VM512RegClass);
    }
  }
}

VETargetLowering::VETargetLowering(const TargetMachine &TM,
                                   const VESubtarget &STI)
    : TargetLowering(TM), Subtarget(&STI) {
  // Instructions which use registers as conditionals examine all the
  // bits (as does the pseudo SELECT_CC expansion). I don't think it
  // matters much whether it's ZeroOrOneBooleanContent, or
  // ZeroOrNegativeOneBooleanContent, so, arbitrarily choose the
  // former.
  setBooleanContents(ZeroOrOneBooleanContent);
  setBooleanVectorContents(ZeroOrOneBooleanContent);

  LLVM_DEBUG(dbgs() << "VPU MODE:       " << Subtarget->enableVPU() << "\n";
             dbgs() << "PACKED MODE:    " << Subtarget->hasPackedMode() << "\n";
             dbgs() << "VELINTRIN MODE: " << Subtarget->isVELIntrinsicMode()
                    << "\n";);

  ///// Registers //////
  initRegisterClasses();

  /////// set operation actions /////
  initSPUActions();
  initVPUActions();

  setStackPointerRegisterToSaveRestore(VE::SX11);

  // Set function alignment to 16 bytes
  setMinFunctionAlignment(Align(16));

  // VE stores all argument by 8 bytes alignment
  setMinStackArgumentAlignment(Align(8));

  computeRegisterProperties(Subtarget->getRegisterInfo());
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

const char *VETargetLowering::getTargetNodeName(unsigned Opcode) const {
#define TARGET_NODE_CASE(NAME)                                                 \
  case VEISD::NAME:                                                            \
    return "VEISD::" #NAME;
  switch ((VEISD::NodeType)Opcode) {
  case VEISD::FIRST_NUMBER:
    break;
    TARGET_NODE_CASE(CMPICC)
    TARGET_NODE_CASE(CMPFCC)
    TARGET_NODE_CASE(BRICC)
    TARGET_NODE_CASE(BRXCC)
    TARGET_NODE_CASE(BRFCC)
    TARGET_NODE_CASE(SELECT)
    TARGET_NODE_CASE(SELECT_ICC)
    TARGET_NODE_CASE(SELECT_XCC)
    TARGET_NODE_CASE(SELECT_FCC)
    TARGET_NODE_CASE(EH_SJLJ_SETJMP)
    TARGET_NODE_CASE(EH_SJLJ_LONGJMP)
    TARGET_NODE_CASE(EH_SJLJ_SETUP_DISPATCH)
    TARGET_NODE_CASE(Hi)
    TARGET_NODE_CASE(Lo)
    TARGET_NODE_CASE(FTOI)
    TARGET_NODE_CASE(ITOF)
    TARGET_NODE_CASE(FTOX)
    TARGET_NODE_CASE(XTOF)
    TARGET_NODE_CASE(MAX)
    TARGET_NODE_CASE(MIN)
    TARGET_NODE_CASE(FMAX)
    TARGET_NODE_CASE(FMIN)
    TARGET_NODE_CASE(GETFUNPLT)
    TARGET_NODE_CASE(GETSTACKTOP)
    TARGET_NODE_CASE(GETTLSADDR)
    TARGET_NODE_CASE(MEMBARRIER)
    TARGET_NODE_CASE(CALL)
    TARGET_NODE_CASE(RET_FLAG)
    TARGET_NODE_CASE(GLOBAL_BASE_REG)
    TARGET_NODE_CASE(FLUSHW)
    TARGET_NODE_CASE(Wrapper)

    TARGET_NODE_CASE(VEC_BROADCAST)
    TARGET_NODE_CASE(VEC_NARROW)
    TARGET_NODE_CASE(VEC_SEQ)
    TARGET_NODE_CASE(VEC_VMV)
    TARGET_NODE_CASE(VEC_REDUCE_ANY)
    TARGET_NODE_CASE(VEC_POPCOUNT)
    TARGET_NODE_CASE(VEC_TOMASK)

    TARGET_NODE_CASE(VEC_UNPACK_LO)
    TARGET_NODE_CASE(VEC_UNPACK_HI)
    TARGET_NODE_CASE(VEC_PACK)
    TARGET_NODE_CASE(VEC_SWAP)

    TARGET_NODE_CASE(VM_INSERT)
    TARGET_NODE_CASE(VM_EXTRACT)

    TARGET_NODE_CASE(REPL_F32)
    TARGET_NODE_CASE(REPL_I32)
#define ADD_VVP_OP(VVP_NAME) TARGET_NODE_CASE(VVP_NAME)
#include "VVPNodes.inc"
  }
  return nullptr;
}

EVT VETargetLowering::getSetCCResultType(const DataLayout &,
                                         LLVMContext &Context, EVT VT) const {
  if (!VT.isVector())
    return MVT::i32;
  return EVT::getVectorVT(Context, MVT::i1, VT.getVectorElementCount());
}

/// isMaskedValueZeroForTargetNode - Return true if 'Op & Mask' is known to
/// be zero. Op is expected to be a target specific node. Used by DAG
/// combiner.
void VETargetLowering::computeKnownBitsForTargetNode(const SDValue Op,
                                                     KnownBits &Known,
                                                     const APInt &DemandedElts,
                                                     const SelectionDAG &DAG,
                                                     unsigned Depth) const {
  KnownBits Known2;
  Known.resetAll();

  switch (Op.getOpcode()) {
  default:
    break;
  case VEISD::SELECT_ICC:
  case VEISD::SELECT_XCC:
  case VEISD::SELECT_FCC:
    Known = DAG.computeKnownBits(Op.getOperand(1), Depth + 1);
    Known2 = DAG.computeKnownBits(Op.getOperand(0), Depth + 1);

    // Only known if known in both the LHS and RHS.
    Known.One &= Known2.One;
    Known.Zero &= Known2.Zero;
    break;
  }
}

// Convert to a target node and set target flags.
SDValue VETargetLowering::withTargetFlags(SDValue Op, unsigned TF,
                                          SelectionDAG &DAG) const {
  if (const GlobalAddressSDNode *GA = dyn_cast<GlobalAddressSDNode>(Op))
    return DAG.getTargetGlobalAddress(GA->getGlobal(), SDLoc(GA),
                                      GA->getValueType(0), GA->getOffset(), TF);

  if (const ConstantPoolSDNode *CP = dyn_cast<ConstantPoolSDNode>(Op))
    return DAG.getTargetConstantPool(CP->getConstVal(), CP->getValueType(0),
                                     CP->getAlignment(), CP->getOffset(), TF);

  if (const BlockAddressSDNode *BA = dyn_cast<BlockAddressSDNode>(Op))
    return DAG.getTargetBlockAddress(BA->getBlockAddress(), Op.getValueType(),
                                     0, TF);

  if (const ExternalSymbolSDNode *ES = dyn_cast<ExternalSymbolSDNode>(Op))
    return DAG.getTargetExternalSymbol(ES->getSymbol(), ES->getValueType(0),
                                       TF);

  llvm_unreachable("Unhandled address SDNode");
}

// Split Op into high and low parts according to HiTF and LoTF.
// Return an ADD node combining the parts.
SDValue VETargetLowering::makeHiLoPair(SDValue Op, unsigned HiTF, unsigned LoTF,
                                       SelectionDAG &DAG) const {
  SDLoc DL(Op);
  EVT VT = Op.getValueType();
  SDValue Hi = DAG.getNode(VEISD::Hi, DL, VT, withTargetFlags(Op, HiTF, DAG));
  SDValue Lo = DAG.getNode(VEISD::Lo, DL, VT, withTargetFlags(Op, LoTF, DAG));
  return DAG.getNode(ISD::ADD, DL, VT, Hi, Lo);
}

// Build SDNodes for producing an address from a GlobalAddress, ConstantPool,
// or ExternalSymbol SDNode.
SDValue VETargetLowering::makeAddress(SDValue Op, SelectionDAG &DAG) const {
  SDLoc DL(Op);
  EVT PtrVT = Op.getValueType();

  // Handle PIC mode first. VE needs a got load for every variable!
  if (isPositionIndependent()) {
    // GLOBAL_BASE_REG codegen'ed with call. Inform MFI that this
    // function has calls.
    MachineFrameInfo &MFI = DAG.getMachineFunction().getFrameInfo();
    MFI.setHasCalls(true);

    if (dyn_cast<ConstantPoolSDNode>(Op) != nullptr ||
        (dyn_cast<GlobalAddressSDNode>(Op) != nullptr &&
         dyn_cast<GlobalAddressSDNode>(Op)->getGlobal()->hasLocalLinkage())) {
      // Create following instructions for local linkage PIC code.
      //     lea %s35, %gotoff_lo(.LCPI0_0)
      //     and %s35, %s35, (32)0
      //     lea.sl %s35, %gotoff_hi(.LCPI0_0)(%s35)
      //     adds.l %s35, %s15, %s35                  ; %s15 is GOT
      // FIXME: use lea.sl %s35, %gotoff_hi(.LCPI0_0)(%s35, %s15)
      SDValue HiLo = makeHiLoPair(Op, VEMCExpr::VK_VE_GOTOFF_HI32,
                                  VEMCExpr::VK_VE_GOTOFF_LO32, DAG);
      SDValue GlobalBase = DAG.getNode(VEISD::GLOBAL_BASE_REG, DL, PtrVT);
      return DAG.getNode(ISD::ADD, DL, PtrVT, GlobalBase, HiLo);
    }
    // Create following instructions for not local linkage PIC code.
    //     lea %s35, %got_lo(.LCPI0_0)
    //     and %s35, %s35, (32)0
    //     lea.sl %s35, %got_hi(.LCPI0_0)(%s35)
    //     adds.l %s35, %s15, %s35                  ; %s15 is GOT
    //     ld     %s35, (,%s35)
    // FIXME: use lea.sl %s35, %gotoff_hi(.LCPI0_0)(%s35, %s15)
    SDValue HiLo = makeHiLoPair(Op, VEMCExpr::VK_VE_GOT_HI32,
                                VEMCExpr::VK_VE_GOT_LO32, DAG);
    SDValue GlobalBase = DAG.getNode(VEISD::GLOBAL_BASE_REG, DL, PtrVT);
    SDValue AbsAddr = DAG.getNode(ISD::ADD, DL, PtrVT, GlobalBase, HiLo);
    return DAG.getLoad(PtrVT, DL, DAG.getEntryNode(), AbsAddr,
                       MachinePointerInfo::getGOT(DAG.getMachineFunction()));
  }

  // This is one of the absolute code models.
  switch (getTargetMachine().getCodeModel()) {
  default:
    llvm_unreachable("Unsupported absolute code model");
  case CodeModel::Small:
  case CodeModel::Medium:
  case CodeModel::Large:
    // abs64.
    return makeHiLoPair(Op, VEMCExpr::VK_VE_HI32, VEMCExpr::VK_VE_LO32, DAG);
  }
}

static Instruction *callIntrinsic(IRBuilder<> &Builder, Intrinsic::ID Id) {
  Module *M = Builder.GetInsertBlock()->getParent()->getParent();
  Function *Func = Intrinsic::getDeclaration(M, Id);
  return Builder.CreateCall(Func, {});
}

Instruction *VETargetLowering::emitLeadingFence(IRBuilder<> &Builder,
                                                Instruction *Inst,
                                                AtomicOrdering Ord) const {
  switch (Ord) {
  case AtomicOrdering::NotAtomic:
  case AtomicOrdering::Unordered:
    llvm_unreachable("Invalid fence: unordered/non-atomic");
  case AtomicOrdering::Monotonic:
  case AtomicOrdering::Acquire:
    return nullptr; // Nothing to do
  case AtomicOrdering::Release:
  case AtomicOrdering::AcquireRelease:
    return callIntrinsic(Builder, Intrinsic::ve_fencem1);
  case AtomicOrdering::SequentiallyConsistent:
    if (!Inst->hasAtomicStore())
      return nullptr; // Nothing to do
    return callIntrinsic(Builder, Intrinsic::ve_fencem3);
  }
  llvm_unreachable("Unknown fence ordering in emitLeadingFence");
}

Instruction *VETargetLowering::emitTrailingFence(IRBuilder<> &Builder,
                                                 Instruction *Inst,
                                                 AtomicOrdering Ord) const {
  switch (Ord) {
  case AtomicOrdering::NotAtomic:
  case AtomicOrdering::Unordered:
    llvm_unreachable("Invalid fence: unordered/not-atomic");
  case AtomicOrdering::Monotonic:
  case AtomicOrdering::Release:
    return nullptr; // Nothing to do
  case AtomicOrdering::Acquire:
  case AtomicOrdering::AcquireRelease:
    return callIntrinsic(Builder, Intrinsic::ve_fencem2);
  case AtomicOrdering::SequentiallyConsistent:
    return callIntrinsic(Builder, Intrinsic::ve_fencem3);
  }
  llvm_unreachable("Unknown fence ordering in emitTrailingFence");
}

/// Custom Lower {

SDValue VETargetLowering::LowerGlobalAddress(SDValue Op,
                                             SelectionDAG &DAG) const {
  return makeAddress(Op, DAG);
}

SDValue VETargetLowering::LowerConstantPool(SDValue Op,
                                            SelectionDAG &DAG) const {
  return makeAddress(Op, DAG);
}

SDValue VETargetLowering::LowerBlockAddress(SDValue Op,
                                            SelectionDAG &DAG) const {
  return makeAddress(Op, DAG);
}

SDValue
VETargetLowering::LowerToTLSGeneralDynamicModel(SDValue Op,
                                                SelectionDAG &DAG) const {
  SDLoc dl(Op);

  // Generate following code:
  //   t1: ch,glue = callseq_start t0, 0, 0
  //   t2: i64,ch,glue = VEISD::GETTLSADDR t1, label, t1:1
  //   t3: ch,glue = callseq_end t2, 0, 0, t2:2
  //   t4: i64,ch,glue = CopyFromReg t3, Register:i64 $sx0, t3:1
  SDValue Label = withTargetFlags(Op, 0, DAG);
  EVT PtrVT = Op.getValueType();

  // Lowering the machine isd will make sure everything is in the right
  // location.
  SDValue Chain = DAG.getEntryNode();
  SDVTList NodeTys = DAG.getVTList(MVT::Other, MVT::Glue);
  const uint32_t *Mask = Subtarget->getRegisterInfo()->getCallPreservedMask(
      DAG.getMachineFunction(), CallingConv::C);
  Chain = DAG.getCALLSEQ_START(Chain, 64, 0, dl);
  SDValue Args[] = {Chain, Label, DAG.getRegisterMask(Mask), Chain.getValue(1)};
  Chain = DAG.getNode(VEISD::GETTLSADDR, dl, NodeTys, Args);
  Chain = DAG.getCALLSEQ_END(Chain, DAG.getIntPtrConstant(64, dl, true),
                             DAG.getIntPtrConstant(0, dl, true),
                             Chain.getValue(1), dl);
  Chain = DAG.getCopyFromReg(Chain, dl, VE::SX0, PtrVT, Chain.getValue(1));

  // GETTLSADDR will be codegen'ed as call. Inform MFI that function has calls.
  MachineFrameInfo &MFI = DAG.getMachineFunction().getFrameInfo();
  MFI.setHasCalls(true);

  // Also generate code to prepare a GOT register if it is PIC.
  if (isPositionIndependent()) {
    MachineFunction &MF = DAG.getMachineFunction();
    Subtarget->getInstrInfo()->getGlobalBaseReg(&MF);
  }

  return Chain;
}

SDValue VETargetLowering::LowerToTLSLocalExecModel(SDValue Op,
                                                   SelectionDAG &DAG) const {
  SDLoc dl(Op);
  EVT PtrVT = getPointerTy(DAG.getDataLayout());

  // Generate following code:
  //   lea %s0, Op@tpoff_lo
  //   and %s0, %s0, (32)0
  //   lea.sl %s0, Op@tpoff_hi(%s0)
  //   add %s0, %s0, %tp
  // FIXME: use lea.sl %s0, Op@tpoff_hi(%tp, %s0) for better performance
  SDValue HiLo = makeHiLoPair(Op, VEMCExpr::VK_VE_TPOFF_HI32,
                              VEMCExpr::VK_VE_TPOFF_LO32, DAG);
  return DAG.getNode(ISD::ADD, dl, PtrVT, DAG.getRegister(VE::SX14, PtrVT),
                     HiLo);
}

SDValue VETargetLowering::LowerGlobalTLSAddress(SDValue Op,
                                                SelectionDAG &DAG) const {
  // Current implementation of nld doesn't allow local exec model code
  // described in VE-tls_v1.1.pdf (*1) as its input.  The nld accept
  // only general dynamic model and optimize it whenever.  So, here
  // we need to generate only general dynamic model code sequence.
  //
  // *1: https://www.nec.com/en/global/prod/hpc/aurora/document/VE-tls_v1.1.pdf
  return LowerToTLSGeneralDynamicModel(Op, DAG);
}

SDValue VETargetLowering::LowerEH_SJLJ_SETJMP(SDValue Op,
                                              SelectionDAG &DAG) const {
  SDLoc dl(Op);
  return DAG.getNode(VEISD::EH_SJLJ_SETJMP, dl,
                     DAG.getVTList(MVT::i32, MVT::Other), Op.getOperand(0),
                     Op.getOperand(1));
}

SDValue VETargetLowering::LowerEH_SJLJ_LONGJMP(SDValue Op,
                                               SelectionDAG &DAG) const {
  SDLoc dl(Op);
  return DAG.getNode(VEISD::EH_SJLJ_LONGJMP, dl, MVT::Other, Op.getOperand(0),
                     Op.getOperand(1));
}

SDValue VETargetLowering::LowerEH_SJLJ_SETUP_DISPATCH(SDValue Op,
                                                      SelectionDAG &DAG) const {
  SDLoc dl(Op);
  return DAG.getNode(VEISD::EH_SJLJ_SETUP_DISPATCH, dl, MVT::Other,
                     Op.getOperand(0));
}

SDValue VETargetLowering::LowerVASTART(SDValue Op, SelectionDAG &DAG) const {
  MachineFunction &MF = DAG.getMachineFunction();
  VEMachineFunctionInfo *FuncInfo = MF.getInfo<VEMachineFunctionInfo>();
  auto PtrVT = getPointerTy(DAG.getDataLayout());

  // Need frame address to find the address of VarArgsFrameIndex.
  MF.getFrameInfo().setFrameAddressIsTaken(true);

  // vastart just stores the address of the VarArgsFrameIndex slot into the
  // memory location argument.
  SDLoc DL(Op);
  SDValue Offset =
      DAG.getNode(ISD::ADD, DL, PtrVT, DAG.getRegister(VE::SX9, PtrVT),
                  DAG.getIntPtrConstant(FuncInfo->getVarArgsFrameOffset(), DL));
  const Value *SV = cast<SrcValueSDNode>(Op.getOperand(2))->getValue();
  return DAG.getStore(Op.getOperand(0), DL, Offset, Op.getOperand(1),
                      MachinePointerInfo(SV));
}

SDValue VETargetLowering::LowerVAARG(SDValue Op, SelectionDAG &DAG) const {
  SDNode *Node = Op.getNode();
  EVT VT = Node->getValueType(0);
  SDValue InChain = Node->getOperand(0);
  SDValue VAListPtr = Node->getOperand(1);
  EVT PtrVT = VAListPtr.getValueType();
  const Value *SV = cast<SrcValueSDNode>(Node->getOperand(2))->getValue();
  SDLoc DL(Node);
  SDValue VAList =
      DAG.getLoad(PtrVT, DL, InChain, VAListPtr, MachinePointerInfo(SV));
  SDValue Chain = VAList.getValue(1);
  SDValue NextPtr;

  if (VT == MVT::f128) {
    // Alignment
    int Align = 16;
    VAList = DAG.getNode(ISD::ADD, DL, PtrVT, VAList,
                         DAG.getConstant(Align - 1, DL, PtrVT));
    VAList = DAG.getNode(ISD::AND, DL, PtrVT, VAList,
                         DAG.getConstant(-Align, DL, PtrVT));
    // Increment the pointer, VAList, by 16 to the next vaarg.
    NextPtr =
        DAG.getNode(ISD::ADD, DL, PtrVT, VAList, DAG.getIntPtrConstant(16, DL));
  } else if (VT == MVT::f32) {
    // float --> need special handling like below.
    //    0      4
    //    +------+------+
    //    | empty| float|
    //    +------+------+
    // Increment the pointer, VAList, by 8 to the next vaarg.
    NextPtr =
        DAG.getNode(ISD::ADD, DL, PtrVT, VAList, DAG.getIntPtrConstant(8, DL));
    // Then, adjust VAList.
    unsigned InternalOffset = 4;
    VAList = DAG.getNode(ISD::ADD, DL, PtrVT, VAList,
                         DAG.getConstant(InternalOffset, DL, PtrVT));
  } else {
    // Increment the pointer, VAList, by 8 to the next vaarg.
    NextPtr =
        DAG.getNode(ISD::ADD, DL, PtrVT, VAList, DAG.getIntPtrConstant(8, DL));
  }

  // Store the incremented VAList to the legalized pointer.
  InChain = DAG.getStore(Chain, DL, NextPtr, VAListPtr, MachinePointerInfo(SV));

  // Load the actual argument out of the pointer VAList.
  // We can't count on greater alignment than the word size.
  return DAG.getLoad(VT, DL, InChain, VAList, MachinePointerInfo(),
                     std::min(PtrVT.getSizeInBits(), VT.getSizeInBits()) / 8);
}

SDValue VETargetLowering::LowerDYNAMIC_STACKALLOC(SDValue Op,
                                                  SelectionDAG &DAG) const {
  // Generate following code.
  //   (void)__llvm_grow_stack(size);
  //   ret = GETSTACKTOP;        // pseudo instruction
  SDLoc dl(Op);

  // Get the inputs.
  SDNode *Node = Op.getNode();
  SDValue Chain = Op.getOperand(0);
  SDValue Size = Op.getOperand(1);
  MaybeAlign Alignment(Op.getConstantOperandVal(2));
  EVT VT = Node->getValueType(0);

  // Chain the dynamic stack allocation so that it doesn't modify the stack
  // pointer when other instructions are using the stack.
  Chain = DAG.getCALLSEQ_START(Chain, 0, 0, dl);

  const TargetFrameLowering &TFI = *Subtarget->getFrameLowering();
  const Align StackAlign(TFI.getStackAlignment());
  bool NeedsAlign = Alignment && Alignment > StackAlign;

  // Prepare arguments
  TargetLowering::ArgListTy Args;
  TargetLowering::ArgListEntry Entry;
  Entry.Node = Size;
  Entry.Ty = Entry.Node.getValueType().getTypeForEVT(*DAG.getContext());
  Args.push_back(Entry);
  if (NeedsAlign) {
    Entry.Node = DAG.getConstant(~(Alignment->value() - 1ULL), dl, VT);
    Entry.Ty = Entry.Node.getValueType().getTypeForEVT(*DAG.getContext());
    Args.push_back(Entry);
  }
  Type *RetTy = Type::getVoidTy(*DAG.getContext());

  EVT PtrVT = Op.getValueType();
  SDValue Callee;
  if (NeedsAlign) {
    Callee = DAG.getTargetExternalSymbol("__llvm_grow_stack_align", PtrVT, 0);
  } else {
    Callee = DAG.getTargetExternalSymbol("__llvm_grow_stack", PtrVT, 0);
  }

  TargetLowering::CallLoweringInfo CLI(DAG);
  CLI.setDebugLoc(dl)
      .setChain(Chain)
      .setCallee(CallingConv::VE_LLVM_GROW_STACK, RetTy, Callee,
                 std::move(Args))
      .setDiscardResult(true);
  std::pair<SDValue, SDValue> pair = LowerCallTo(CLI);
  Chain = pair.second;
  SDValue Result = DAG.getNode(VEISD::GETSTACKTOP, dl, VT, Chain);
  if (NeedsAlign) {
    Result = DAG.getNode(ISD::ADD, dl, VT, Result,
                         DAG.getConstant((Alignment->value() - 1ULL), dl, VT));
    Result = DAG.getNode(ISD::AND, dl, VT, Result,
                         DAG.getConstant(~(Alignment->value() - 1ULL), dl, VT));
  }
  //  Chain = Result.getValue(1);
  Chain = DAG.getCALLSEQ_END(Chain, DAG.getIntPtrConstant(0, dl, true),
                             DAG.getIntPtrConstant(0, dl, true), SDValue(), dl);

  SDValue Ops[2] = {Result, Chain};
  return DAG.getMergeValues(Ops, dl);
}

static SDValue LowerFRAMEADDR(SDValue Op, SelectionDAG &DAG,
                              const VETargetLowering &TLI,
                              const VESubtarget *Subtarget) {
  SDLoc dl(Op);
  unsigned Depth = cast<ConstantSDNode>(Op.getOperand(0))->getZExtValue();

  MachineFunction &MF = DAG.getMachineFunction();
  MachineFrameInfo &MFI = MF.getFrameInfo();
  MFI.setFrameAddressIsTaken(true);

  EVT PtrVT = Op.getValueType();

  // Naked functions never have a frame pointer, and so we use r1. For all
  // other functions, this decision must be delayed until during PEI.
  const VERegisterInfo *RegInfo = Subtarget->getRegisterInfo();
  Register FrameReg = RegInfo->getFrameRegister(MF);

  SDValue FrameAddr =
      DAG.getCopyFromReg(DAG.getEntryNode(), dl, FrameReg, PtrVT);
  while (Depth--)
    FrameAddr = DAG.getLoad(PtrVT, dl, DAG.getEntryNode(), FrameAddr,
                            MachinePointerInfo());
  return FrameAddr;
}

static SDValue LowerRETURNADDR(SDValue Op, SelectionDAG &DAG,
                               const VETargetLowering &TLI,
                               const VESubtarget *Subtarget) {
  MachineFunction &MF = DAG.getMachineFunction();
  MachineFrameInfo &MFI = MF.getFrameInfo();
  MFI.setReturnAddressIsTaken(true);

  if (TLI.verifyReturnAddressArgumentIsConstant(Op, DAG))
    return SDValue();

  SDLoc dl(Op);
  unsigned Depth = cast<ConstantSDNode>(Op.getOperand(0))->getZExtValue();

  auto PtrVT = TLI.getPointerTy(MF.getDataLayout());

  if (Depth > 0) {
    SDValue FrameAddr = LowerFRAMEADDR(Op, DAG, TLI, Subtarget);
    SDValue Offset = DAG.getConstant(8, dl, MVT::i64);
    return DAG.getLoad(PtrVT, dl, DAG.getEntryNode(),
                       DAG.getNode(ISD::ADD, dl, PtrVT, FrameAddr, Offset),
                       MachinePointerInfo());
  }

  // Just load the return address off the stack.
  SDValue RetAddrFI = DAG.getFrameIndex(1, PtrVT);
  return DAG.getLoad(PtrVT, dl, DAG.getEntryNode(), RetAddrFI,
                     MachinePointerInfo());
}

// Lower a f128 load into two f64 loads.
static SDValue LowerF128Load(SDValue Op, SelectionDAG &DAG) {
  SDLoc dl(Op);
  LoadSDNode *LdNode = dyn_cast<LoadSDNode>(Op.getNode());
  assert(LdNode && LdNode->getOffset().isUndef() && "Unexpected node type");

  SDValue BasePtr = LdNode->getBasePtr();
  if (dyn_cast<FrameIndexSDNode>(BasePtr.getNode())) {
    // For the case of frame index, expanding it here cause dependency
    // problem.  So, treat it as a legal and expand it in eliminateFrameIndex
    return Op;
  }

  unsigned alignment = LdNode->getAlignment();
  if (alignment > 8)
    alignment = 8;

  SDValue Lo64 =
      DAG.getLoad(MVT::f64, dl, LdNode->getChain(), LdNode->getBasePtr(),
                  LdNode->getPointerInfo(), alignment,
                  LdNode->isVolatile() ? MachineMemOperand::MOVolatile
                                       : MachineMemOperand::MONone);
  EVT addrVT = LdNode->getBasePtr().getValueType();
  SDValue HiPtr = DAG.getNode(ISD::ADD, dl, addrVT, LdNode->getBasePtr(),
                              DAG.getConstant(8, dl, addrVT));
  SDValue Hi64 =
      DAG.getLoad(MVT::f64, dl, LdNode->getChain(), HiPtr,
                  LdNode->getPointerInfo(), alignment,
                  LdNode->isVolatile() ? MachineMemOperand::MOVolatile
                                       : MachineMemOperand::MONone);

  SDValue SubRegEven = DAG.getTargetConstant(VE::sub_even, dl, MVT::i32);
  SDValue SubRegOdd = DAG.getTargetConstant(VE::sub_odd, dl, MVT::i32);

  // VE stores Hi64 to 8(addr) and Lo64 to 0(addr)
  SDNode *InFP128 =
      DAG.getMachineNode(TargetOpcode::IMPLICIT_DEF, dl, MVT::f128);
  InFP128 = DAG.getMachineNode(TargetOpcode::INSERT_SUBREG, dl, MVT::f128,
                               SDValue(InFP128, 0), Hi64, SubRegEven);
  InFP128 = DAG.getMachineNode(TargetOpcode::INSERT_SUBREG, dl, MVT::f128,
                               SDValue(InFP128, 0), Lo64, SubRegOdd);
  SDValue OutChains[2] = {SDValue(Lo64.getNode(), 1),
                          SDValue(Hi64.getNode(), 1)};
  SDValue OutChain = DAG.getNode(ISD::TokenFactor, dl, MVT::Other, OutChains);
  SDValue Ops[2] = {SDValue(InFP128, 0), OutChain};
  return DAG.getMergeValues(Ops, dl);
}

SDValue VETargetLowering::LowerLOAD(SDValue Op, SelectionDAG &DAG) const {
  LoadSDNode *LdNode = cast<LoadSDNode>(Op.getNode());

  if (LdNode->getMemoryVT().isVector())
    return ExpandToVVP(Op, DAG, VVPExpansionMode::ToNativeWidth);

  EVT MemVT = LdNode->getMemoryVT();
  if (MemVT == MVT::f128)
    return LowerF128Load(Op, DAG);

  return Op;
}

static SDValue LowerI1Store(SDValue Op, SelectionDAG &DAG) {
  SDLoc dl(Op);
  StoreSDNode *StNode = dyn_cast<StoreSDNode>(Op.getNode());
  assert(StNode && StNode->getOffset().isUndef() && "Unexpected node type");

  SDValue BasePtr = StNode->getBasePtr();
  if (dyn_cast<FrameIndexSDNode>(BasePtr.getNode())) {
    // For the case of frame index, expanding it here cause dependency
    // problem.  So, treat it as a legal and expand it in eliminateFrameIndex
    return Op;
  }

  unsigned alignment = StNode->getAlignment();
  if (alignment > 8)
    alignment = 8;
  EVT addrVT = BasePtr.getValueType();
  EVT MemVT = StNode->getMemoryVT();
  if (MemVT == MVT::v256i1 || MemVT == MVT::v4i64) {
    SDValue OutChains[4];
    for (int i = 0; i < 4; ++i) {
      SDNode *V =
          DAG.getMachineNode(VE::svm_smI, dl, MVT::i64, StNode->getValue(),
                             DAG.getTargetConstant(i, dl, MVT::i64));
      SDValue Addr = DAG.getNode(ISD::ADD, dl, addrVT, BasePtr,
                                 DAG.getConstant(8 * i, dl, addrVT));
      OutChains[i] =
          DAG.getStore(StNode->getChain(), dl, SDValue(V, 0), Addr,
                       MachinePointerInfo(), alignment,
                       StNode->isVolatile() ? MachineMemOperand::MOVolatile
                                            : MachineMemOperand::MONone);
    }
    return DAG.getNode(ISD::TokenFactor, dl, MVT::Other, OutChains);
  }

  if (MemVT == MVT::v512i1 || MemVT == MVT::v8i64) {
    SDValue OutChains[8];
    for (int i = 0; i < 8; ++i) {
      SDNode *V =
          DAG.getMachineNode(VE::svm_sMI, dl, MVT::i64, StNode->getValue(),
                             DAG.getTargetConstant(i, dl, MVT::i64));
      SDValue Addr = DAG.getNode(ISD::ADD, dl, addrVT, BasePtr,
                                 DAG.getConstant(8 * i, dl, addrVT));
      OutChains[i] =
          DAG.getStore(StNode->getChain(), dl, SDValue(V, 0), Addr,
                       MachinePointerInfo(), alignment,
                       StNode->isVolatile() ? MachineMemOperand::MOVolatile
                                            : MachineMemOperand::MONone);
    }
    return DAG.getNode(ISD::TokenFactor, dl, MVT::Other, OutChains);
  }

  // Otherwise, ask llvm to expand it.
  return SDValue();
}

// Lower a f128 store into two f64 stores.
static SDValue LowerF128Store(SDValue Op, SelectionDAG &DAG) {
  SDLoc dl(Op);
  StoreSDNode *StNode = dyn_cast<StoreSDNode>(Op.getNode());
  assert(StNode && StNode->getOffset().isUndef() && "Unexpected node type");

  SDValue BasePtr = StNode->getBasePtr();
  if (dyn_cast<FrameIndexSDNode>(BasePtr.getNode())) {
    // For the case of frame index, expanding it here cause dependency
    // problem.  So, treat it as a legal and expand it in eliminateFrameIndex
    return Op;
  }

  SDValue SubRegEven = DAG.getTargetConstant(VE::sub_even, dl, MVT::i32);
  SDValue SubRegOdd = DAG.getTargetConstant(VE::sub_odd, dl, MVT::i32);

  SDNode *Hi64 = DAG.getMachineNode(TargetOpcode::EXTRACT_SUBREG, dl, MVT::i64,
                                    StNode->getValue(), SubRegEven);
  SDNode *Lo64 = DAG.getMachineNode(TargetOpcode::EXTRACT_SUBREG, dl, MVT::i64,
                                    StNode->getValue(), SubRegOdd);

  unsigned alignment = StNode->getAlignment();
  if (alignment > 8)
    alignment = 8;

  // VE stores Hi64 to 8(addr) and Lo64 to 0(addr)
  SDValue OutChains[2];
  OutChains[0] =
      DAG.getStore(StNode->getChain(), dl, SDValue(Lo64, 0),
                   StNode->getBasePtr(), MachinePointerInfo(), alignment,
                   StNode->isVolatile() ? MachineMemOperand::MOVolatile
                                        : MachineMemOperand::MONone);
  EVT addrVT = StNode->getBasePtr().getValueType();
  SDValue HiPtr = DAG.getNode(ISD::ADD, dl, addrVT, StNode->getBasePtr(),
                              DAG.getConstant(8, dl, addrVT));
  OutChains[1] =
      DAG.getStore(StNode->getChain(), dl, SDValue(Hi64, 0), HiPtr,
                   MachinePointerInfo(), alignment,
                   StNode->isVolatile() ? MachineMemOperand::MOVolatile
                                        : MachineMemOperand::MONone);
  return DAG.getNode(ISD::TokenFactor, dl, MVT::Other, OutChains);
}

SDValue VETargetLowering::LowerSTORE(SDValue Op, SelectionDAG &DAG) const {
  SDLoc dl(Op);
  StoreSDNode *St = cast<StoreSDNode>(Op.getNode());

  EVT MemVT = St->getMemoryVT();

  if (MemVT == MVT::v256i1 || MemVT == MVT::v512i1)
    return LowerI1Store(Op, DAG);

  if (MemVT == MVT::f128)
    return LowerF128Store(Op, DAG);

  if (MemVT.isVector())
    return ExpandToVVP(Op, DAG, VVPExpansionMode::ToNativeWidth);

  // Otherwise, this store is legal
  return Op;
}

// Custom lower UMULO/SMULO for VE. This code is similar to ExpandNode()
// in LegalizeDAG.cpp except the order of arguments to the library function.
static SDValue LowerUMULO_SMULO(SDValue Op, SelectionDAG &DAG,
                                const VETargetLowering &TLI) {
  unsigned opcode = Op.getOpcode();
  assert((opcode == ISD::UMULO || opcode == ISD::SMULO) && "Invalid Opcode.");

  bool isSigned = (opcode == ISD::SMULO);
  EVT VT = MVT::i64;
  EVT WideVT = MVT::i128;
  SDLoc dl(Op);
  SDValue LHS = Op.getOperand(0);

  if (LHS.getValueType() != VT)
    return Op;

  SDValue ShiftAmt = DAG.getConstant(63, dl, VT);

  SDValue RHS = Op.getOperand(1);
  SDValue HiLHS = DAG.getNode(ISD::SRA, dl, VT, LHS, ShiftAmt);
  SDValue HiRHS = DAG.getNode(ISD::SRA, dl, MVT::i64, RHS, ShiftAmt);
  SDValue Args[] = {LHS, HiLHS, RHS, HiRHS};

  TargetLowering::MakeLibCallOptions CallOptions;
  CallOptions.setSExt(isSigned);
  SDValue MulResult =
      TLI.makeLibCall(DAG, RTLIB::MUL_I128, WideVT, Args, CallOptions, dl)
          .first;
  SDValue BottomHalf = DAG.getNode(ISD::EXTRACT_ELEMENT, dl, VT, MulResult,
                                   DAG.getIntPtrConstant(0, dl));
  SDValue TopHalf = DAG.getNode(ISD::EXTRACT_ELEMENT, dl, VT, MulResult,
                                DAG.getIntPtrConstant(1, dl));
  if (isSigned) {
    SDValue Tmp1 = DAG.getNode(ISD::SRA, dl, VT, BottomHalf, ShiftAmt);
    TopHalf = DAG.getSetCC(dl, MVT::i32, TopHalf, Tmp1, ISD::SETNE);
  } else {
    TopHalf = DAG.getSetCC(dl, MVT::i32, TopHalf, DAG.getConstant(0, dl, VT),
                           ISD::SETNE);
  }
  // MulResult is a node with an illegal type. Because such things are not
  // generally permitted during this phase of legalization, ensure that
  // nothing is left using the node. The above EXTRACT_ELEMENT nodes should have
  // been folded.
  assert(MulResult->use_empty() && "Illegally typed node still in use!");

  SDValue Ops[2] = {BottomHalf, TopHalf};
  return DAG.getMergeValues(Ops, dl);
}

SDValue VETargetLowering::LowerATOMIC_FENCE(SDValue Op,
                                            SelectionDAG &DAG) const {
  SDLoc DL(Op);
  AtomicOrdering FenceOrdering = static_cast<AtomicOrdering>(
      cast<ConstantSDNode>(Op.getOperand(1))->getZExtValue());
  SyncScope::ID FenceSSID = static_cast<SyncScope::ID>(
      cast<ConstantSDNode>(Op.getOperand(2))->getZExtValue());

  // VE uses Release consistency, so need a fence instruction if it is a
  // cross-thread fence.
  if (FenceSSID == SyncScope::System) {
    switch (FenceOrdering) {
    case AtomicOrdering::NotAtomic:
    case AtomicOrdering::Unordered:
    case AtomicOrdering::Monotonic:
      // No need to generate fencem instruction here.
      break;
    case AtomicOrdering::Acquire:
      // Generate "fencem 2" as acquire fence.
      return SDValue(
          DAG.getMachineNode(VE::FENCEload, DL, MVT::Other, Op.getOperand(0)),
          0);
    case AtomicOrdering::Release:
      // Generate "fencem 1" as release fence.
      return SDValue(
          DAG.getMachineNode(VE::FENCEstore, DL, MVT::Other, Op.getOperand(0)),
          0);
    case AtomicOrdering::AcquireRelease:
    case AtomicOrdering::SequentiallyConsistent:
      // Generate "fencem 3" as acq_rel and seq_cst fence.
      // FIXME: "fencem 3" doesn't wait for for PCIe device accesses,
      //        so  seq_cst may require more instruction for them.
      return SDValue(DAG.getMachineNode(VE::FENCEloadstore, DL, MVT::Other,
                                        Op.getOperand(0)),
                     0);
    }
  }

  // MEMBARRIER is a compiler barrier; it codegens to a no-op.
  return DAG.getNode(VEISD::MEMBARRIER, DL, MVT::Other, Op.getOperand(0));
}

SDValue VETargetLowering::LowerINTRINSIC_WO_CHAIN(SDValue Op,
                                                  SelectionDAG &DAG) const {
  SDLoc dl(Op);
  unsigned IntNo = cast<ConstantSDNode>(Op.getOperand(0))->getZExtValue();
  switch (IntNo) {
  default:
    return SDValue(); // Don't custom lower most intrinsics.
  case Intrinsic::thread_pointer: {
    report_fatal_error("Intrinsic::thread_point is not implemented yet");
  }
  case Intrinsic::eh_sjlj_lsda: {
    MachineFunction &MF = DAG.getMachineFunction();
    const TargetLowering &TLI = DAG.getTargetLoweringInfo();
    MVT PtrVT = TLI.getPointerTy(DAG.getDataLayout());
    const VETargetMachine *TM =
        static_cast<const VETargetMachine *>(&DAG.getTarget());

    // Creat GCC_except_tableXX string.  The real symbol for that will be
    // generated in EHStreamer::emitExceptionTable() later.  So, we just
    // borrow it's name here.
    TM->getStrList()->push_back(std::string(
        (Twine("GCC_except_table") + Twine(MF.getFunctionNumber())).str()));
    SDValue Addr =
        DAG.getTargetExternalSymbol(TM->getStrList()->back().c_str(), PtrVT, 0);
    if (isPositionIndependent()) {
      Addr = makeHiLoPair(Addr, VEMCExpr::VK_VE_GOTOFF_HI32,
                          VEMCExpr::VK_VE_GOTOFF_LO32, DAG);
      SDValue GlobalBase = DAG.getNode(VEISD::GLOBAL_BASE_REG, dl, PtrVT);
      return DAG.getNode(ISD::ADD, dl, PtrVT, GlobalBase, Addr);
    } else {
      return makeHiLoPair(Addr, VEMCExpr::VK_VE_HI32, VEMCExpr::VK_VE_LO32,
                          DAG);
    }
  }
  }
}

SDValue VETargetLowering::LowerINTRINSIC_W_CHAIN(SDValue Op,
                                                 SelectionDAG &DAG) const {
  SDLoc dl(Op);
  unsigned IntNo = cast<ConstantSDNode>(Op.getOperand(1))->getZExtValue();
  switch (IntNo) {
  default:
    return SDValue(); // Don't custom lower most intrinsics.
  }
}

SDValue VETargetLowering::LowerINTRINSIC_VOID(SDValue Op,
                                              SelectionDAG &DAG) const {
  SDLoc dl(Op);
  unsigned IntNo = cast<ConstantSDNode>(Op.getOperand(1))->getZExtValue();
  switch (IntNo) {
  default:
    return SDValue(); // Don't custom lower most intrinsics.
  }
}

// Should we expand the build vector with shuffles?
bool VETargetLowering::shouldExpandBuildVectorWithShuffles(
    EVT VT, unsigned DefinedValues) const {
#if 1
  // FIXME: Change this to true or expression once we implement custom
  // expansion of VECTOR_SHUFFLE completely.

  // Not use VECTOR_SHUFFLE to expand BUILD_VECTOR atm.  Because, it causes
  // infinity expand loop between both instructions since VECTOR_SHUFFLE
  // is not implemented completely yet.
  return false;
#else
  return DefinedValues < 3;
#endif
}

static SDValue PeekForMask(SDValue Op) {
  while (Op.getOpcode() == ISD::BITCAST) {
    Op = Op.getOperand(0);
  }

  if (IsMaskType(Op.getValueType()))
    return Op;
  return SDValue();
}

SDValue VETargetLowering::LowerINSERT_VECTOR_ELT(SDValue Op,
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
          SDValue(DAG.getMachineNode(VE::lvsl_svI, dl, i64, {Vec, HalfIdx}), 0);
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
          SDValue(DAG.getMachineNode(VE::lsv_vvIs, dl, Vec.getSimpleValueType(),
                                     {Vec, HalfIdx, CombinedVal}),
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

    CustomDAG CDAG(DAG, Op);
    return CDAG.CreateInsertMask(ActualMaskV, ElemV, IndexV);
  }

  // Insertion is legal for other V64 types.
  return Op;
}

SDValue VETargetLowering::LowerEXTRACT_VECTOR_ELT(SDValue Op,
                                                  SelectionDAG &DAG) const {
  assert(Op.getOpcode() == ISD::EXTRACT_VECTOR_ELT && "Unknown opcode!");
  EVT VT = Op.getOperand(0).getValueType();

  SDValue SrcV = Op.getOperand(0);
  SDValue IndexV = Op.getOperand(1);

  // Special treatements for packed V64 types.
  if (VT == MVT::v512i32 || VT == MVT::v512f32) {
    // Example of codes:
    //   %packed_v = extractelt %vr, %idx / 2
    //   %v = %packed_v >> (%idx % 2 * 32)
    //   %res = %v & 0xffffffff

    SDValue Vec = Op.getOperand(0);
    SDValue Idx = Op.getOperand(1);
    EVT i64 = EVT::getIntegerVT(*DAG.getContext(), 64);
    EVT i32 = EVT::getIntegerVT(*DAG.getContext(), 32);
    EVT f32 = EVT::getFloatingPointVT(32);
    SDLoc dl(Op);
    SDValue Result = Op;
    if (0 /* Idx->isConstant() */) {
      // FIXME: optimized implementation using constant values
    } else {
      SDValue SetEq = DAG.getCondCode(ISD::SETEQ);
      SDValue ZeroConst = DAG.getConstant(0, dl, i64);
      SDValue OneConst = DAG.getConstant(1, dl, i64);
      SDValue ThirtyTwoConst = DAG.getConstant(32, dl, i64);
      SDValue LowBits = DAG.getConstant(0xFFFFFFFF, dl, i64);
      SDValue HalfIdx = DAG.getNode(ISD::SRL, dl, i64, {Idx, OneConst});
      SDValue PackedVal =
          SDValue(DAG.getMachineNode(VE::lvsl_svI, dl, i64, {Vec, HalfIdx}), 0);
      SDValue IdxLSB = DAG.getNode(ISD::AND, dl, i64, {Idx, OneConst});
      SDValue ShiftIdx =
          DAG.getNode(ISD::SELECT_CC, dl, i64,
                      {IdxLSB, ZeroConst, ZeroConst, ThirtyTwoConst, SetEq});
      SDValue ShiftedVal =
          DAG.getNode(ISD::SRL, dl, i64, {PackedVal, ShiftIdx});
      SDValue MaskedVal = DAG.getNode(ISD::AND, dl, i64, {ShiftedVal, LowBits});
      // In v512i32 and v512f32, Both i32 and f32 values are placed from Low32.
      SDValue SubLow32 = DAG.getTargetConstant(VE::sub_i32, dl, MVT::i32);
      Result = SDValue(DAG.getMachineNode(TargetOpcode::EXTRACT_SUBREG, dl, i32,
                                          MaskedVal, SubLow32),
                       0);
      if (VT == MVT::v512f32) {
        Result = DAG.getBitcast(f32, Result);
      }
    }
    return Result;
  }

  // Lowering to VM_EXTRACT
  if (SDValue ActualMaskV = PeekForMask(SrcV)) {
    auto IndexC = dyn_cast<ConstantSDNode>(IndexV);
    assert(IndexC);
    assert(Op.getValueType().isScalarInteger());
    // unsigned ResSize = Op.getValueType().getSizeInBits(); // Implicit
    EVT MaskVT = Op.getOperand(0).getValueType();
    unsigned PartSize = MaskVT.getVectorElementType().getSizeInBits();

    const unsigned SXRegSize = 64;

    CustomDAG CDAG(DAG, Op);

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

SDValue VETargetLowering::LowerVectorShuffleOp(SDValue Op, SelectionDAG &DAG,
                                               VVPExpansionMode Mode) const {
  SDLoc DL(Op);
  std::unique_ptr<MaskView> MView(requestMaskView(Op.getNode()));

  EVT LegalResVT = LegalizeVectorType(Op.getValueType(), Op, DAG, Mode);

  CustomDAG CDAG(DAG, Op);

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

#if 0
SDValue VETargetLowering::LowerVECTOR_SHUFFLE(SDValue Op, SelectionDAG &DAG,
                                              VVPExpansionMode Mode) const {
  LLVM_DEBUG(dbgs() << "Lowering Shuffle\n");

  return LowerVectorShuffle(Op, DAG, Mode);
#if 0
  // BROKEN LEGACY CODE
  SDValue firstVec = ShuffleInstr->getOperand(0);
  int firstVecLength = firstVec.getSimpleValueType().getVectorNumElements();
  SDValue secondVec = ShuffleInstr->getOperand(1);
  int secondVecLength = secondVec.getSimpleValueType().getVectorNumElements();

  MVT ElementType = Op.getSimpleValueType().getScalarType();
  int resultSize = Op.getSimpleValueType().getVectorNumElements();

  CustomDAG CDAG(DAG, DL);

  if (ShuffleInstr->isSplat()) {
    int index = ShuffleInstr->getSplatIndex();
    if (index >= firstVecLength) {
      index -= firstVecLength;
      SDValue elem = DAG.getNode(
          ISD::EXTRACT_VECTOR_ELT, DL, ElementType,
          {secondVec,
           DAG.getConstant(index, DL,
                           EVT::getIntegerVT(*DAG.getContext(), 64))});
      return CDAG.CreateBroadcast(Op.getSimpleValueType(), elem);
    } else {
      SDValue elem = DAG.getNode(
          ISD::EXTRACT_VECTOR_ELT, DL, ElementType,
          {firstVec, DAG.getConstant(
                         index, DL, EVT::getIntegerVT(*DAG.getContext(), 64))});
      return CDAG.CreateBroadcast(Op.getSimpleValueType(), elem);
    }
  }

  // Supports v256 shuffles only atm.
  if (firstVecLength != 256 || secondVecLength != 256 || resultSize != 256) {
    LLVM_DEBUG(dbgs() << "Invalid vector lengths\n");
    return SDValue();
  }

  int firstrot = 256;
  int secondrot = 256;
  int firstsecond = 256;
  bool inv_order;

  if (ShuffleInstr->getMaskElt(0) < 256) {
    inv_order = false;
  } else {
    inv_order = true;
  }

  for (int i = 0; i < 256; i++) {
    int mask_value = ShuffleInstr->getMaskElt(i);

    if (mask_value < 0) // Undef
      continue;

    if (mask_value < 256) {
      if (firstsecond != 256 && !inv_order) {
        LLVM_DEBUG(dbgs() << "Mixing\n");
        return SDValue();
      }

      if (firstsecond == 256 && inv_order)
        firstsecond = i;

      if (firstrot == 256)
        firstrot = i - mask_value;
      else if (firstrot != i - mask_value) {
        LLVM_DEBUG(dbgs() << "Bad first rot\n");
        return SDValue();
      }
    } else { // mask_value >= 256
      if (firstsecond != 256 && inv_order) {
        LLVM_DEBUG(dbgs() << "Mixing\n");
        return SDValue();
      }

      if (firstsecond == 256 && !inv_order)
        firstsecond = i;

      mask_value -= 256;

      if (secondrot == 256)
        secondrot = i - mask_value;
      else if (secondrot != i - mask_value) {
        LLVM_DEBUG(dbgs() << "Bad second rot\n");
        return SDValue();
      }
    }
  }

  if (firstrot < 0)
    firstrot *= -1;
  else
    firstrot = 256 - firstrot;
  if (secondrot < 0)
    secondrot *= -1;
  else
    secondrot = 256 - secondrot;

  EVT i32 = EVT::getIntegerVT(*DAG.getContext(), 32);
  EVT i64 = EVT::getIntegerVT(*DAG.getContext(), 64);
  EVT v256i1 = EVT::getVectorVT(*DAG.getContext(),
                                EVT::getIntegerVT(*DAG.getContext(), 1), 256);

  SDValue VL = SDValue(
      DAG.getMachineNode(VE::LEA32zzi, DL, MVT::i32,
                         DAG.getTargetConstant(resultSize, DL, MVT::i32)),
      0);
  // SDValue VL = DAG.getTargetConstant(resultSize, DL, MVT::i32);
  SDValue firstrotated =
      firstrot % 256 != 0
          ? SDValue(
                DAG.getMachineNode(
                    VE::vmv_vIvl, DL, firstVec.getSimpleValueType(),
                    {DAG.getConstant(firstrot % 256, DL, i32), firstVec, VL}),
                0)
          : firstVec;
  SDValue secondrotated =
      secondrot % 256 != 0
          ? SDValue(
                DAG.getMachineNode(
                    VE::vmv_vIvl, DL, secondVec.getSimpleValueType(),
                    {DAG.getConstant(secondrot % 256, DL, i32), secondVec, VL}),
                0)
          : secondVec;

  int block = firstsecond / 64;
  int secondblock = firstsecond % 64;

  SDValue Mask = DAG.getUNDEF(v256i1);

  for (int i = 0; i < block; i++) {
    // set blocks to all 0s
    SDValue mask = inv_order ? DAG.getConstant(0xffffffffffffffff, DL, i64)
                             : DAG.getConstant(0, DL, i64);
    SDValue index = DAG.getTargetConstant(i, DL, i64);
    Mask = SDValue(
        DAG.getMachineNode(VE::lvm_mmIs, DL, v256i1, {Mask, index, mask}), 0);
  }

  SDValue mask = DAG.getConstant(0xffffffffffffffff, DL, i64);
  if (!inv_order)
    mask = DAG.getNode(ISD::SRL, DL, i64,
                       {mask, DAG.getConstant(secondblock, DL, i64)});
  else
    mask = DAG.getNode(ISD::SHL, DL, i64,
                       {mask, DAG.getConstant(64 - secondblock, DL, i64)});
  Mask = SDValue(
      DAG.getMachineNode(VE::lvm_mmIs, DL, v256i1,
                         {Mask, DAG.getTargetConstant(block, DL, i64), mask}),
      0);

  for (int i = block + 1; i < 4; i++) {
    // set blocks to all 1s
    SDValue mask = inv_order ? DAG.getConstant(0, DL, i64)
                             : DAG.getConstant(0xffffffffffffffff, DL, i64);
    SDValue index = DAG.getTargetConstant(i, DL, i64);
    Mask = SDValue(
        DAG.getMachineNode(VE::lvm_mmIs, DL, v256i1, {Mask, index, mask}), 0);
  }

  SDValue returnValue =
      SDValue(DAG.getMachineNode(VE::vmrg_vvvml, DL, Op.getSimpleValueType(),
                                 {firstrotated, secondrotated, Mask, VL}),
              0);
  return returnValue;
/// }
#endif
}
#endif

SDValue VETargetLowering::LowerOperation(SDValue Op, SelectionDAG &DAG) const {
  LLVM_DEBUG(dbgs() << "LowerOp: "; Op.dump(&DAG); dbgs() << "\n";);

  switch (Op.getOpcode()) {
  default:
    llvm_unreachable("Should not custom lower this!");

  case ISD::RETURNADDR:
    return LowerRETURNADDR(Op, DAG, *this, Subtarget);
  case ISD::FRAMEADDR:
    return LowerFRAMEADDR(Op, DAG, *this, Subtarget);
  case ISD::BlockAddress:
    return LowerBlockAddress(Op, DAG);
  case ISD::GlobalAddress:
    return LowerGlobalAddress(Op, DAG);
  case ISD::GlobalTLSAddress:
    return LowerGlobalTLSAddress(Op, DAG);
  case ISD::ConstantPool:
    return LowerConstantPool(Op, DAG);
  case ISD::EH_SJLJ_SETJMP:
    return LowerEH_SJLJ_SETJMP(Op, DAG);
  case ISD::EH_SJLJ_LONGJMP:
    return LowerEH_SJLJ_LONGJMP(Op, DAG);
  case ISD::EH_SJLJ_SETUP_DISPATCH:
    return LowerEH_SJLJ_SETUP_DISPATCH(Op, DAG);
  case ISD::VASTART:
    return LowerVASTART(Op, DAG);
  case ISD::VAARG:
    return LowerVAARG(Op, DAG);
  case ISD::DYNAMIC_STACKALLOC:
    return LowerDYNAMIC_STACKALLOC(Op, DAG);
  case ISD::UMULO:
  case ISD::SMULO:
    return LowerUMULO_SMULO(Op, DAG, *this);
  case ISD::ATOMIC_FENCE:
    return LowerATOMIC_FENCE(Op, DAG);
  case ISD::INTRINSIC_VOID:
    return LowerINTRINSIC_VOID(Op, DAG);
  case ISD::INTRINSIC_W_CHAIN:
    return LowerINTRINSIC_W_CHAIN(Op, DAG);
  case ISD::INTRINSIC_WO_CHAIN:
    return LowerINTRINSIC_WO_CHAIN(Op, DAG);
  case ISD::BITCAST:
    return LowerBitcast(Op, DAG);

  case ISD::BUILD_VECTOR:
  case ISD::VECTOR_SHUFFLE:
    return LowerVectorShuffleOp(Op, DAG, VVPExpansionMode::ToNativeWidth);

  case ISD::EXTRACT_SUBVECTOR:
    return LowerEXTRACT_SUBVECTOR(Op, DAG, VVPExpansionMode::ToNativeWidth);
  case ISD::SCALAR_TO_VECTOR:
    return LowerSCALAR_TO_VECTOR(Op, DAG, VVPExpansionMode::ToNativeWidth);

  case ISD::INSERT_VECTOR_ELT:
    return LowerINSERT_VECTOR_ELT(Op, DAG);
  case ISD::EXTRACT_VECTOR_ELT:
    return LowerEXTRACT_VECTOR_ELT(Op, DAG);

    // case ISD::VECREDUCE_OR:
    // case ISD::VECREDUCE_AND:
    // case ISD::VECREDUCE_XOR:

  case ISD::LOAD:
    return LowerLOAD(Op, DAG);
  case ISD::MLOAD:
    return LowerMLOAD(Op, DAG, VVPExpansionMode::ToNativeWidth);
  case ISD::STORE:
    return LowerSTORE(Op, DAG);
  case ISD::MSTORE:
    return LowerMSTORE(Op, DAG);
  case ISD::MSCATTER:
  case ISD::MGATHER:
    return LowerMGATHER_MSCATTER(Op, DAG, VVPExpansionMode::ToNativeWidth,
                                 None);

    // modify the return type of SETCC on vectors to v256i1
    // case ISD::SETCC: return LowerSETCC(Op, DAG);
#if 0
  case ISD::SELECT_CC:
    return LowerSELECT_CC(Op, DAG);
#endif

    // case ISD::TRUNCATE: return LowerTRUNCATE(Op, DAG);

    ///// LLVM-VP --> vvp_* /////
#define REGISTER_VP_SDNODE(VP_NAME, VP_TEXT, MASK_POS, LEN_POS)                \
  case ISD::VP_NAME:
#include "llvm/IR/VPIntrinsics.def"
    return LowerVPToVVP(Op, DAG);

    ///// non-VP --> vvp_* with native type /////
    // Convert this standard vector op to VVP
  case ISD::SELECT:
    // FIXME List all operation that correspond to a VVP operation here
#define REGISTER_ICONV_VVP_OP(VVP_NAME, ISD_NAME) case ISD::ISD_NAME:
#define REGISTER_FPCONV_VVP_OP(VVP_NAME, ISD_NAME) case ISD::ISD_NAME:
#define REGISTER_UNARY_VVP_OP(VVP_NAME, ISD_NAME) case ISD::ISD_NAME:
#define REGISTER_BINARY_VVP_OP(VVP_NAME, ISD_NAME) case ISD::ISD_NAME:
#define REGISTER_TERNARY_VVP_OP(VVP_NAME, ISD_NAME) case ISD::ISD_NAME:
#define REGISTER_REDUCE_VVP_OP(VVP_NAME, ISD_NAME) case ISD::ISD_NAME:
#include "VVPNodes.inc"
    return ExpandToVVP(Op, DAG, VVPExpansionMode::ToNativeWidth);

    ///// Widen this VVP operation to the vector type /////
    // Use a native vector type for this VVP_* operation
    // FIXME List all VVP ops with vector results here
#define REGISTER_ICONV_VVP_OP(VVP_NAME, ISD_NAME) case VEISD::VVP_NAME:
#define REGISTER_FPCONV_VVP_OP(VVP_NAME, ISD_NAME) case VEISD::VVP_NAME:
#define REGISTER_UNARY_VVP_OP(VVP_NAME, ISD_NAME) case VEISD::VVP_NAME:
#define REGISTER_BINARY_VVP_OP(VVP_NAME, ISD_NAME) case VEISD::VVP_NAME:
#define REGISTER_TERNARY_VVP_OP(VVP_NAME, ISD_NAME) case VEISD::VVP_NAME:
#include "VVPNodes.inc"

  case VEISD::VEC_BROADCAST:
  case VEISD::VEC_SEQ:
    return WidenVVPOperation(LowerSETCCInVectorArithmetic(Op, DAG), DAG,
                             VVPExpansionMode::ToNativeWidth);

  // "forget" about the narrowing
  case VEISD::VEC_NARROW: {
    return Op->getOperand(0);
  }
  }
}

/// } Custom Lower

/// Return the entry encoding for a jump table in the
/// current function.  The returned value is a member of the
/// MachineJumpTableInfo::JTEntryKind enum.
unsigned VETargetLowering::getJumpTableEncoding() const {
  // VE doesn't support GOT32 style of labels in the current version of nas.
  // So, we generates a following entry for each jump table.
  //    .4bytes  .LBB0_2-<function name>
  if (isPositionIndependent())
    return MachineJumpTableInfo::EK_Custom32;

  // Otherwise, use the normal jump table encoding heuristics.
  return TargetLowering::getJumpTableEncoding();
}

const MCExpr *VETargetLowering::LowerCustomJumpTableEntry(
    const MachineJumpTableInfo *MJTI, const MachineBasicBlock *MBB,
    unsigned uid, MCContext &Ctx) const {
  assert(isPositionIndependent());
  // VE doesn't support GOT32 style of labels in the current version of nas.
  // So, we generates a following entry for each jump table.
  //    .4bytes  .LBB0_2-<function name>
  auto Value = MCSymbolRefExpr::create(MBB->getSymbol(), Ctx);
  MCSymbol *Sym = Ctx.getOrCreateSymbol(MBB->getParent()->getName().data());
  auto Base = MCSymbolRefExpr::create(Sym, Ctx);
  return MCBinaryExpr::createSub(Value, Base, Ctx);
}

void VETargetLowering::SetupEntryBlockForSjLj(MachineInstr &MI,
                                              MachineBasicBlock *MBB,
                                              MachineBasicBlock *DispatchBB,
                                              int FI) const {
  DebugLoc DL = MI.getDebugLoc();
  MachineFunction *MF = MBB->getParent();
  MachineRegisterInfo *MRI = &MF->getRegInfo();
  const VEInstrInfo *TII = Subtarget->getInstrInfo();

  const TargetRegisterClass *TRC = &VE::I64RegClass;
  Register Tmp1 = MRI->createVirtualRegister(TRC);
  Register Tmp2 = MRI->createVirtualRegister(TRC);
  Register VR = MRI->createVirtualRegister(TRC);
  unsigned Op = VE::STrii;

  if (isPositionIndependent()) {
    // Create following instructions for local linkage PIC code.
    //     lea %Tmp1, DispatchBB@gotoff_lo
    //     and %Tmp2, %Tmp1, (32)0
    //     lea.sl %Tmp3, DispatchBB@gotoff_hi(%Tmp2)
    //     adds.l %VR, %s15, %Tmp3                  ; %s15 is GOT
    // FIXME: use lea.sl %BReg, .LJTI0_0@gotoff_hi(%Tmp2, %s15)
    unsigned Tmp3 = MRI->createVirtualRegister(&VE::I64RegClass);
    BuildMI(*MBB, MI, DL, TII->get(VE::LEAzii), Tmp1)
        .addImm(0)
        .addImm(0)
        .addMBB(DispatchBB, VEMCExpr::VK_VE_GOTOFF_LO32);
    BuildMI(*MBB, MI, DL, TII->get(VE::ANDrm0), Tmp2).addReg(Tmp1).addImm(32);
    BuildMI(*MBB, MI, DL, TII->get(VE::LEASLrii), Tmp3)
        .addReg(Tmp2)
        .addImm(0)
        .addMBB(DispatchBB, VEMCExpr::VK_VE_GOTOFF_HI32);
    BuildMI(*MBB, MI, DL, TII->get(VE::ADXrr), VR)
        .addReg(VE::SX15)
        .addReg(Tmp3);
  } else {
    // lea     %Tmp1, DispatchBB@lo
    // and     %Tmp2, %Tmp1, (32)0
    // lea.sl  %VR, DispatchBB@hi(%Tmp2)
    BuildMI(*MBB, MI, DL, TII->get(VE::LEAzii), Tmp1)
        .addImm(0)
        .addImm(0)
        .addMBB(DispatchBB, VEMCExpr::VK_VE_LO32);
    BuildMI(*MBB, MI, DL, TII->get(VE::ANDrm0), Tmp2).addReg(Tmp1).addImm(32);
    BuildMI(*MBB, MI, DL, TII->get(VE::LEASLrii), VR)
        .addReg(Tmp2)
        .addImm(0)
        .addMBB(DispatchBB, VEMCExpr::VK_VE_HI32);
  }

  MachineInstrBuilder MIB = BuildMI(*MBB, MI, DL, TII->get(Op));
  addFrameReference(MIB, FI, 56 + 16);
  MIB.addReg(VR);
}

MachineBasicBlock *
VETargetLowering::emitEHSjLjSetJmp(MachineInstr &MI,
                                   MachineBasicBlock *MBB) const {
  DebugLoc DL = MI.getDebugLoc();
  MachineFunction *MF = MBB->getParent();
  const TargetInstrInfo *TII = Subtarget->getInstrInfo();
  const TargetRegisterInfo *TRI = Subtarget->getRegisterInfo();
  MachineRegisterInfo &MRI = MF->getRegInfo();

  const BasicBlock *BB = MBB->getBasicBlock();
  MachineFunction::iterator I = ++MBB->getIterator();

  // Memory Reference
  SmallVector<MachineMemOperand *, 2> MMOs(MI.memoperands_begin(),
                                           MI.memoperands_end());
  Register BufReg = MI.getOperand(1).getReg();

  Register DstReg;

  DstReg = MI.getOperand(0).getReg();
  const TargetRegisterClass *RC = MRI.getRegClass(DstReg);
  assert(TRI->isTypeLegalForClass(*RC, MVT::i32) && "Invalid destination!");
  (void)TRI;
  Register mainDstReg = MRI.createVirtualRegister(RC);
  Register restoreDstReg = MRI.createVirtualRegister(RC);

  // For v = setjmp(buf), we generate
  //
  // thisMBB:
  //  buf[3] = %s17 iff %s17 is used as BP
  //  buf[1] = restoreMBB
  //  SjLjSetup restoreMBB
  //
  // mainMBB:
  //  v_main = 0
  //
  // sinkMBB:
  //  v = phi(main, restore)
  //
  // restoreMBB:
  //  %s17 = buf[3] = iff %s17 is used as BP
  //  v_restore = 1

  MachineBasicBlock *thisMBB = MBB;
  MachineBasicBlock *mainMBB = MF->CreateMachineBasicBlock(BB);
  MachineBasicBlock *sinkMBB = MF->CreateMachineBasicBlock(BB);
  MachineBasicBlock *restoreMBB = MF->CreateMachineBasicBlock(BB);
  MF->insert(I, mainMBB);
  MF->insert(I, sinkMBB);
  MF->push_back(restoreMBB);
  restoreMBB->setHasAddressTaken();

  // Transfer the remainder of BB and its successor edges to sinkMBB.
  sinkMBB->splice(sinkMBB->begin(), MBB,
                  std::next(MachineBasicBlock::iterator(MI)), MBB->end());
  sinkMBB->transferSuccessorsAndUpdatePHIs(MBB);

  // thisMBB:
  Register LabelReg = MRI.createVirtualRegister(&VE::I64RegClass);
  Register Tmp1 = MRI.createVirtualRegister(&VE::I64RegClass);
  Register Tmp2 = MRI.createVirtualRegister(&VE::I64RegClass);

  if (isPositionIndependent()) {
    // Create following instructions for local linkage PIC code.
    //     lea %Tmp1, restoreMBB@gotoff_lo
    //     and %Tmp2, %Tmp1, (32)0
    //     lea.sl %Tmp3, restoreMBB@gotoff_hi(%Tmp2)
    //     adds.l %LabelReg, %s15, %Tmp3                  ; %s15 is GOT
    // FIXME: use lea.sl %BReg, .LJTI0_0@gotoff_hi(%Tmp2, %s15)
    Register Tmp3 = MRI.createVirtualRegister(&VE::I64RegClass);
    BuildMI(*MBB, MI, DL, TII->get(VE::LEAzii), Tmp1)
        .addImm(0)
        .addImm(0)
        .addMBB(restoreMBB, VEMCExpr::VK_VE_GOTOFF_LO32);
    BuildMI(*MBB, MI, DL, TII->get(VE::ANDrm0), Tmp2).addReg(Tmp1).addImm(32);
    BuildMI(*MBB, MI, DL, TII->get(VE::LEASLrii), Tmp3)
        .addReg(Tmp2)
        .addImm(0)
        .addMBB(restoreMBB, VEMCExpr::VK_VE_GOTOFF_HI32);
    BuildMI(*MBB, MI, DL, TII->get(VE::ADXrr), LabelReg)
        .addReg(VE::SX15)
        .addReg(Tmp3);
  } else {
    // lea     %Tmp1, restoreMBB@lo
    // and     %Tmp2, %Tmp1, (32)0
    // lea.sl  %LabelReg, restoreMBB@hi(%Tmp2)
    BuildMI(*MBB, MI, DL, TII->get(VE::LEAzii), Tmp1)
        .addImm(0)
        .addImm(0)
        .addMBB(restoreMBB, VEMCExpr::VK_VE_LO32);
    BuildMI(*MBB, MI, DL, TII->get(VE::ANDrm0), Tmp2).addReg(Tmp1).addImm(32);
    BuildMI(*MBB, MI, DL, TII->get(VE::LEASLrii), LabelReg)
        .addReg(Tmp2)
        .addImm(0)
        .addMBB(restoreMBB, VEMCExpr::VK_VE_HI32);
  }

  // Store BP
  const VEFrameLowering *TFI = Subtarget->getFrameLowering();
  if (TFI->hasBP(*MF)) {
    // store BP in buf[3]
    MachineInstrBuilder MIB = BuildMI(*MBB, MI, DL, TII->get(VE::STrii));
    MIB.addReg(BufReg);
    MIB.addImm(0);
    MIB.addImm(24);
    MIB.addReg(VE::SX17);
    MIB.setMemRefs(MMOs);
  }

  // Store IP
  MachineInstrBuilder MIB = BuildMI(*MBB, MI, DL, TII->get(VE::STrii));
  MIB.add(MI.getOperand(1));
  MIB.addImm(0);
  MIB.addImm(8);
  MIB.addReg(LabelReg);
  MIB.setMemRefs(MMOs);

  // SP/FP are already stored in jmpbuf before `llvm.eh.sjlj.setjmp`.

  // Setup
  MIB =
      BuildMI(*thisMBB, MI, DL, TII->get(VE::EH_SjLj_Setup)).addMBB(restoreMBB);

  const VERegisterInfo *RegInfo = Subtarget->getRegisterInfo();
  MIB.addRegMask(RegInfo->getNoPreservedMask());
  thisMBB->addSuccessor(mainMBB);
  thisMBB->addSuccessor(restoreMBB);

  // mainMBB:
  BuildMI(mainMBB, DL, TII->get(VE::LEAzii), mainDstReg)
      .addImm(0)
      .addImm(0)
      .addImm(0);
  mainMBB->addSuccessor(sinkMBB);

  // sinkMBB:
  BuildMI(*sinkMBB, sinkMBB->begin(), DL, TII->get(VE::PHI), DstReg)
      .addReg(mainDstReg)
      .addMBB(mainMBB)
      .addReg(restoreDstReg)
      .addMBB(restoreMBB);

  // restoreMBB:
  if (TFI->hasBP(*MF)) {
    // Restore BP from buf[3].  The address of buf is in SX10.
    // FIXME: Better to not use SX10 here
    MachineInstrBuilder MIB =
        BuildMI(restoreMBB, DL, TII->get(VE::LDrii), VE::SX17);
    MIB.addReg(VE::SX10);
    MIB.addImm(0);
    MIB.addImm(24);
    MIB.setMemRefs(MMOs);
  }
  BuildMI(restoreMBB, DL, TII->get(VE::LEAzii), restoreDstReg)
      .addImm(0)
      .addImm(0)
      .addImm(1);
  BuildMI(restoreMBB, DL, TII->get(VE::BCRLa)).addMBB(sinkMBB);
  restoreMBB->addSuccessor(sinkMBB);

  MI.eraseFromParent();
  return sinkMBB;
}

MachineBasicBlock *
VETargetLowering::emitEHSjLjLongJmp(MachineInstr &MI,
                                    MachineBasicBlock *MBB) const {
  DebugLoc DL = MI.getDebugLoc();
  MachineFunction *MF = MBB->getParent();
  const TargetInstrInfo *TII = Subtarget->getInstrInfo();
  MachineRegisterInfo &MRI = MF->getRegInfo();

  // Memory Reference
  SmallVector<MachineMemOperand *, 2> MMOs(MI.memoperands_begin(),
                                           MI.memoperands_end());
  Register BufReg = MI.getOperand(0).getReg();

  Register Tmp = MRI.createVirtualRegister(&VE::I64RegClass);
  // Since FP is only updated here but NOT referenced, it's treated as GPR.
  const Register FP = VE::SX9;
  const Register SP = VE::SX11;

  MachineInstrBuilder MIB;

  MachineBasicBlock *thisMBB = MBB;

  // Reload FP
  MIB = BuildMI(*thisMBB, MI, DL, TII->get(VE::LDrii), FP);
  MIB.addReg(BufReg);
  MIB.addImm(0);
  MIB.addImm(0);
  MIB.setMemRefs(MMOs);

  // Reload IP
  MIB = BuildMI(*thisMBB, MI, DL, TII->get(VE::LDrii), Tmp);
  MIB.addReg(BufReg);
  MIB.addImm(0);
  MIB.addImm(8);
  MIB.setMemRefs(MMOs);

  // Copy BufReg to SX10 for later use in setjmp
  // FIXME: Better to not use SX10 here
  BuildMI(*thisMBB, MI, DL, TII->get(VE::ORri), VE::SX10)
      .addReg(BufReg)
      .addImm(0);

  // Reload SP
  MIB = BuildMI(*thisMBB, MI, DL, TII->get(VE::LDrii), SP);
  MIB.add(MI.getOperand(0)); // we can preserve the kill flags here.
  MIB.addImm(0);
  MIB.addImm(16);
  MIB.setMemRefs(MMOs);

  // Jump
  BuildMI(*thisMBB, MI, DL, TII->get(VE::BAri)).addReg(Tmp).addImm(0);

  MI.eraseFromParent();
  return thisMBB;
}

MachineBasicBlock *
VETargetLowering::EmitSjLjDispatchBlock(MachineInstr &MI,
                                        MachineBasicBlock *BB) const {
  DebugLoc DL = MI.getDebugLoc();
  MachineFunction *MF = BB->getParent();
  MachineFrameInfo &MFI = MF->getFrameInfo();
  MachineRegisterInfo *MRI = &MF->getRegInfo();
  const VEInstrInfo *TII = Subtarget->getInstrInfo();
  int FI = MFI.getFunctionContextIndex();

  // Get a mapping of the call site numbers to all of the landing pads they're
  // associated with.
  DenseMap<unsigned, SmallVector<MachineBasicBlock *, 2>> CallSiteNumToLPad;
  unsigned MaxCSNum = 0;
  for (auto &MBB : *MF) {
    if (!MBB.isEHPad())
      continue;

    MCSymbol *Sym = nullptr;
    for (const auto &MI : MBB) {
      if (MI.isDebugInstr())
        continue;

      assert(MI.isEHLabel() && "expected EH_LABEL");
      Sym = MI.getOperand(0).getMCSymbol();
      break;
    }

    if (!MF->hasCallSiteLandingPad(Sym))
      continue;

    for (unsigned CSI : MF->getCallSiteLandingPad(Sym)) {
      CallSiteNumToLPad[CSI].push_back(&MBB);
      MaxCSNum = std::max(MaxCSNum, CSI);
    }
  }

  // Get an ordered list of the machine basic blocks for the jump table.
  std::vector<MachineBasicBlock *> LPadList;
  SmallPtrSet<MachineBasicBlock *, 32> InvokeBBs;
  LPadList.reserve(CallSiteNumToLPad.size());

  for (unsigned CSI = 1; CSI <= MaxCSNum; ++CSI) {
    for (auto &LP : CallSiteNumToLPad[CSI]) {
      LPadList.push_back(LP);
      InvokeBBs.insert(LP->pred_begin(), LP->pred_end());
    }
  }

  assert(!LPadList.empty() &&
         "No landing pad destinations for the dispatch jump table!");

  // Create the MBBs for the dispatch code.

  // Shove the dispatch's address into the return slot in the function context.
  MachineBasicBlock *DispatchBB = MF->CreateMachineBasicBlock();
  DispatchBB->setIsEHPad(true);

  MachineBasicBlock *TrapBB = MF->CreateMachineBasicBlock();
  BuildMI(TrapBB, DL, TII->get(VE::TRAP));
  BuildMI(TrapBB, DL, TII->get(VE::NOP));
  DispatchBB->addSuccessor(TrapBB);

  MachineBasicBlock *DispContBB = MF->CreateMachineBasicBlock();
  DispatchBB->addSuccessor(DispContBB);

  // Insert MBBs.
  MF->push_back(DispatchBB);
  MF->push_back(DispContBB);
  MF->push_back(TrapBB);

  // Insert code into the entry block that creates and registers the function
  // context.
  SetupEntryBlockForSjLj(MI, BB, DispatchBB, FI);

  // Create the jump table and associated information
  unsigned JTE = getJumpTableEncoding();
  MachineJumpTableInfo *JTI = MF->getOrCreateJumpTableInfo(JTE);
  unsigned MJTI = JTI->createJumpTableIndex(LPadList);

  const VERegisterInfo &RI = TII->getRegisterInfo();
  // Add a register mask with no preserved registers.  This results in all
  // registers being marked as clobbered.
  BuildMI(DispatchBB, DL, TII->get(VE::NOP))
      .addRegMask(RI.getNoPreservedMask());

  if (isPositionIndependent()) {
    // Force to generate GETGOT, since current implementation doesn't recover
    // GOT register correctly.
    BuildMI(DispatchBB, DL, TII->get(VE::GETGOT), VE::SX15);
  }

  // IReg is used as an index in a memory operand and therefore can't be SP
  unsigned IReg = MRI->createVirtualRegister(&VE::I64RegClass);
  addFrameReference(BuildMI(DispatchBB, DL, TII->get(VE::LDLZXrii), IReg), FI,
                    8);
  if (LPadList.size() < 64) {
    BuildMI(DispatchBB, DL, TII->get(VE::BCRLir))
        .addImm(VECC::CC_ILE)
        .addImm(LPadList.size())
        .addReg(IReg)
        .addMBB(TrapBB);
  } else {
    assert(LPadList.size() <= 0x7FFFFFFF && "Too large Landing Pad!");
    Register TmpReg = MRI->createVirtualRegister(&VE::I64RegClass);
    BuildMI(DispatchBB, DL, TII->get(VE::LEAzii), TmpReg)
        .addImm(0)
        .addImm(0)
        .addImm(LPadList.size());
    BuildMI(DispatchBB, DL, TII->get(VE::BCRLrr))
        .addImm(VECC::CC_ILE)
        .addReg(TmpReg)
        .addReg(IReg)
        .addMBB(TrapBB);
  }

  Register BReg = MRI->createVirtualRegister(&VE::I64RegClass);

  Register Tmp1 = MRI->createVirtualRegister(&VE::I64RegClass);
  Register Tmp2 = MRI->createVirtualRegister(&VE::I64RegClass);

  if (isPositionIndependent()) {
    // Create following instructions for local linkage PIC code.
    //     lea %Tmp1, .LJTI0_0@gotoff_lo
    //     and %Tmp2, %Tmp1, (32)0
    //     lea.sl %Tmp3, .LJTI0_0@gotoff_hi(%Tmp2)
    //     adds.l %BReg, %s15, %Tmp3                  ; %s15 is GOT
    // FIXME: use lea.sl %BReg, .LJTI0_0@gotoff_hi(%Tmp2, %s15)
    Register Tmp3 = MRI->createVirtualRegister(&VE::I64RegClass);
    BuildMI(DispContBB, DL, TII->get(VE::LEAzii), Tmp1)
        .addImm(0)
        .addImm(0)
        .addJumpTableIndex(MJTI, VEMCExpr::VK_VE_GOTOFF_LO32);
    BuildMI(DispContBB, DL, TII->get(VE::ANDrm0), Tmp2).addReg(Tmp1).addImm(32);
    BuildMI(DispContBB, DL, TII->get(VE::LEASLrii), Tmp3)
        .addReg(Tmp2)
        .addImm(0)
        .addJumpTableIndex(MJTI, VEMCExpr::VK_VE_GOTOFF_HI32);
    BuildMI(DispContBB, DL, TII->get(VE::ADXrr), BReg)
        .addReg(VE::SX15)
        .addReg(Tmp3);
  } else {
    // lea     %Tmp1, .LJTI0_0@lo
    // and     %Tmp2, %Tmp1, (32)0
    // lea.sl  %BReg, .LJTI0_0@hi(%Tmp2)
    BuildMI(DispContBB, DL, TII->get(VE::LEAzii), Tmp1)
        .addImm(0)
        .addImm(0)
        .addJumpTableIndex(MJTI, VEMCExpr::VK_VE_LO32);
    BuildMI(DispContBB, DL, TII->get(VE::ANDrm0), Tmp2).addReg(Tmp1).addImm(32);
    BuildMI(DispContBB, DL, TII->get(VE::LEASLrii), BReg)
        .addReg(Tmp2)
        .addImm(0)
        .addJumpTableIndex(MJTI, VEMCExpr::VK_VE_HI32);
  }

  switch (JTE) {
  case MachineJumpTableInfo::EK_BlockAddress: {
    // Generate simple block address code for no-PIC model.

    Register TReg = MRI->createVirtualRegister(&VE::I64RegClass);
    Register Tmp1 = MRI->createVirtualRegister(&VE::I64RegClass);
    Register Tmp2 = MRI->createVirtualRegister(&VE::I64RegClass);

    // sll     Tmp1, IReg, 3
    BuildMI(DispContBB, DL, TII->get(VE::SLLri), Tmp1).addReg(IReg).addImm(3);
    // FIXME: combine these add and lds into "lds     TReg, *(BReg, Tmp1)"
    // adds.l  Tmp2, BReg, Tmp1
    BuildMI(DispContBB, DL, TII->get(VE::ADXrr), Tmp2)
        .addReg(Tmp1)
        .addReg(BReg);
    // lds     TReg, *(Tmp2)
    BuildMI(DispContBB, DL, TII->get(VE::LDrii), TReg)
        .addReg(Tmp2)
        .addImm(0)
        .addImm(0);

    // jmpq *(TReg)
    BuildMI(DispContBB, DL, TII->get(VE::BAri)).addReg(TReg).addImm(0);
    break;
  }
  case MachineJumpTableInfo::EK_Custom32: {
    // for the case of PIC, generates these codes

    assert(isPositionIndependent());
    Register OReg = MRI->createVirtualRegister(&VE::I64RegClass);
    Register TReg = MRI->createVirtualRegister(&VE::I64RegClass);

    Register Tmp1 = MRI->createVirtualRegister(&VE::I64RegClass);
    Register Tmp2 = MRI->createVirtualRegister(&VE::I64RegClass);

    // sll     Tmp1, IReg, 2
    BuildMI(DispContBB, DL, TII->get(VE::SLLri), Tmp1).addReg(IReg).addImm(2);
    // FIXME: combine these add and ldl into "ldl.zx   OReg, *(BReg, Tmp1)"
    // add     Tmp2, BReg, Tmp1
    BuildMI(DispContBB, DL, TII->get(VE::ADXrr), Tmp2)
        .addReg(Tmp1)
        .addReg(BReg);
    // ldl.zx  OReg, *(Tmp2)
    BuildMI(DispContBB, DL, TII->get(VE::LDLZXrii), OReg)
        .addReg(Tmp2)
        .addImm(0)
        .addImm(0);

    // Create following instructions for local linkage PIC code.
    //     lea %Tmp3, fun@gotoff_lo
    //     and %Tmp4, %Tmp3, (32)0
    //     lea.sl %Tmp5, fun@gotoff_hi(%Tmp4)
    //     adds.l %BReg2, %s15, %Tmp5                  ; %s15 is GOT
    // FIXME: use lea.sl %BReg2, fun@gotoff_hi(%Tmp4, %s15)
    Register Tmp3 = MRI->createVirtualRegister(&VE::I64RegClass);
    Register Tmp4 = MRI->createVirtualRegister(&VE::I64RegClass);
    Register Tmp5 = MRI->createVirtualRegister(&VE::I64RegClass);
    Register BReg2 = MRI->createVirtualRegister(&VE::I64RegClass);
    const char *FunName = DispContBB->getParent()->getName().data();
    BuildMI(DispContBB, DL, TII->get(VE::LEAzii), Tmp3)
        .addImm(0)
        .addImm(0)
        .addExternalSymbol(FunName, VEMCExpr::VK_VE_GOTOFF_LO32);
    BuildMI(DispContBB, DL, TII->get(VE::ANDrm0), Tmp4).addReg(Tmp3).addImm(32);
    BuildMI(DispContBB, DL, TII->get(VE::LEASLrii), Tmp5)
        .addReg(Tmp4)
        .addImm(0)
        .addExternalSymbol(FunName, VEMCExpr::VK_VE_GOTOFF_HI32);
    BuildMI(DispContBB, DL, TII->get(VE::ADXrr), BReg2)
        .addReg(VE::SX15)
        .addReg(Tmp5);

    // adds.l  TReg, BReg2, OReg
    BuildMI(DispContBB, DL, TII->get(VE::ADXrr), TReg)
        .addReg(OReg)
        .addReg(BReg2);
    // jmpq *(TReg)
    BuildMI(DispContBB, DL, TII->get(VE::BAri)).addReg(TReg).addImm(0);
    break;
  }
  default:
    llvm_unreachable("Unexpected jump table encoding");
  }

  // Add the jump table entries as successors to the MBB.
  SmallPtrSet<MachineBasicBlock *, 8> SeenMBBs;
  for (auto &LP : LPadList)
    if (SeenMBBs.insert(LP).second)
      DispContBB->addSuccessor(LP);

  // N.B. the order the invoke BBs are processed in doesn't matter here.
  SmallVector<MachineBasicBlock *, 64> MBBLPads;
  const MCPhysReg *SavedRegs = MF->getRegInfo().getCalleeSavedRegs();
  for (MachineBasicBlock *MBB : InvokeBBs) {
    // Remove the landing pad successor from the invoke block and replace it
    // with the new dispatch block.
    // Keep a copy of Successors since it's modified inside the loop.
    SmallVector<MachineBasicBlock *, 8> Successors(MBB->succ_rbegin(),
                                                   MBB->succ_rend());
    // FIXME: Avoid quadratic complexity.
    for (auto MBBS : Successors) {
      if (MBBS->isEHPad()) {
        MBB->removeSuccessor(MBBS);
        MBBLPads.push_back(MBBS);
      }
    }

    MBB->addSuccessor(DispatchBB);

    // Find the invoke call and mark all of the callee-saved registers as
    // 'implicit defined' so that they're spilled.  This prevents code from
    // moving instructions to before the EH block, where they will never be
    // executed.
    for (auto &II : reverse(*MBB)) {
      if (!II.isCall())
        continue;

      DenseMap<Register, bool> DefRegs;
      for (auto &MOp : II.operands())
        if (MOp.isReg())
          DefRegs[MOp.getReg()] = true;

      MachineInstrBuilder MIB(*MF, &II);
      for (unsigned RI = 0; SavedRegs[RI]; ++RI) {
        Register Reg = SavedRegs[RI];
        if (!DefRegs[Reg])
          MIB.addReg(Reg, RegState::ImplicitDefine | RegState::Dead);
      }

      break;
    }
  }

  // Mark all former landing pads as non-landing pads.  The dispatch is the only
  // landing pad now.
  for (auto &LP : MBBLPads)
    LP->setIsEHPad(false);

  // The instruction is gone now.
  MI.eraseFromParent();
  return BB;
}

MachineBasicBlock *
VETargetLowering::EmitInstrWithCustomInserter(MachineInstr &MI,
                                              MachineBasicBlock *BB) const {
  switch (MI.getOpcode()) {
  default:
    llvm_unreachable("Unknown Custom Instruction!");
  case VE::EH_SjLj_Setup_Dispatch:
    return EmitSjLjDispatchBlock(MI, BB);
  case VE::EH_SjLj_LongJmp:
    return emitEHSjLjLongJmp(MI, BB);
  case VE::EH_SjLj_SetJmp:
    return emitEHSjLjSetJmp(MI, BB);
  }
}

//===----------------------------------------------------------------------===//
//                         VE Inline Assembly Support
//===----------------------------------------------------------------------===//

/// getConstraintType - Given a constraint letter, return the type of
/// constraint it is for this target.
VETargetLowering::ConstraintType
VETargetLowering::getConstraintType(StringRef Constraint) const {
  if (Constraint.size() == 1) {
    switch (Constraint[0]) {
    default:
      break;
    case 'r':
    case 'f':
    case 'e':
      return C_RegisterClass;
    case 'I': // SIMM13
      return C_Other;
    }
  }

  return TargetLowering::getConstraintType(Constraint);
}

TargetLowering::ConstraintWeight
VETargetLowering::getSingleConstraintMatchWeight(AsmOperandInfo &info,
                                                 const char *constraint) const {
  ConstraintWeight weight = CW_Invalid;
  Value *CallOperandVal = info.CallOperandVal;
  // If we don't have a value, we can't do a match,
  // but allow it at the lowest weight.
  if (!CallOperandVal)
    return CW_Default;

  // Look at the constraint type.
  switch (*constraint) {
  default:
    weight = TargetLowering::getSingleConstraintMatchWeight(info, constraint);
    break;
  case 'I': // SIMM13
    if (ConstantInt *C = dyn_cast<ConstantInt>(info.CallOperandVal)) {
      if (isInt<13>(C->getSExtValue()))
        weight = CW_Constant;
    }
    break;
  }
  return weight;
}

/// LowerAsmOperandForConstraint - Lower the specified operand into the Ops
/// vector.  If it is invalid, don't add anything to Ops.
void VETargetLowering::LowerAsmOperandForConstraint(SDValue Op,
                                                    std::string &Constraint,
                                                    std::vector<SDValue> &Ops,
                                                    SelectionDAG &DAG) const {
  SDValue Result(nullptr, 0);

  // Only support length 1 constraints for now.
  if (Constraint.length() > 1)
    return;

  char ConstraintLetter = Constraint[0];
  switch (ConstraintLetter) {
  default:
    break;
  case 'I':
    if (ConstantSDNode *C = dyn_cast<ConstantSDNode>(Op)) {
      if (isInt<13>(C->getSExtValue())) {
        Result = DAG.getTargetConstant(C->getSExtValue(), SDLoc(Op),
                                       Op.getValueType());
        break;
      }
      return;
    }
  }

  if (Result.getNode()) {
    Ops.push_back(Result);
    return;
  }
  TargetLowering::LowerAsmOperandForConstraint(Op, Constraint, Ops, DAG);
}

std::pair<unsigned, const TargetRegisterClass *>
VETargetLowering::getRegForInlineAsmConstraint(const TargetRegisterInfo *TRI,
                                               StringRef Constraint,
                                               MVT VT) const {
  if (Constraint.size() == 1) {
    switch (Constraint[0]) {
    case 'r':
      return std::make_pair(0U, &VE::I64RegClass);
    case 'f':
      if (VT == MVT::f32 || VT == MVT::f64)
        return std::make_pair(0U, &VE::I64RegClass);
      else if (VT == MVT::f128)
        return std::make_pair(0U, &VE::F128RegClass);
      llvm_unreachable("Unknown ValueType for f-register-type!");
      break;
    case 'e':
      if (VT == MVT::f32 || VT == MVT::f64)
        return std::make_pair(0U, &VE::I64RegClass);
      else if (VT == MVT::f128)
        return std::make_pair(0U, &VE::F128RegClass);
      llvm_unreachable("Unknown ValueType for e-register-type!");
      break;
    }

  } else if (!Constraint.empty() && Constraint.size() <= 5 &&
             Constraint[0] == '{' && *(Constraint.end() - 1) == '}') {
    // constraint = '{r<d>}'
    // Remove the braces from around the name.
    StringRef name(Constraint.data() + 1, Constraint.size() - 2);
    // Handle register aliases:
    //       r0-r7   -> g0-g7
    //       r8-r15  -> o0-o7
    //       r16-r23 -> l0-l7
    //       r24-r31 -> i0-i7
    uint64_t intVal = 0;
    if (name.substr(0, 1).equals("r") &&
        !name.substr(1).getAsInteger(10, intVal) && intVal <= 31) {
      const char regTypes[] = {'g', 'o', 'l', 'i'};
      char regType = regTypes[intVal / 8];
      char regIdx = '0' + (intVal % 8);
      char tmp[] = {'{', regType, regIdx, '}', 0};
      std::string newConstraint = std::string(tmp);
      return TargetLowering::getRegForInlineAsmConstraint(TRI, newConstraint,
                                                          VT);
    }
  }

  return TargetLowering::getRegForInlineAsmConstraint(TRI, Constraint, VT);
}

bool VETargetLowering::isOffsetFoldingLegal(
    const GlobalAddressSDNode *GA) const {
  // The VE target isn't yet aware of offsets.
  return false;
}

static SDValue fixUpOperation(SDValue Val, EVT LegalVT, SelectionDAG &DAG) {
  if (Val.getValueType() == LegalVT)
    return Val;

  // SelectionDAGBuilder does not respect TLI::getCCResultVT (do a fixup here)
  if (Val.getOpcode() == ISD::SETCC && Val.getValueType() == MVT::i1) {
    CustomDAG CDAG(DAG, Val);
    SDNode *N = Val.getNode();
    return CDAG.getNode(ISD::SETCC, LegalVT,
                        {N->getOperand(0), N->getOperand(1), N->getOperand(2)});
  }

  return SDValue();
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
  if (!N->getValueType(0).isVector() && shouldExpandToVVP(*N)) {
    SDValue FixedOp =
        ExpandToVVP(SDValue(N, 0), DAG, VVPExpansionMode::ToNativeWidth);
    N = FixedOp.getNode();
  } else if (!IsVVPOrVEC(N->getOpcode())) {
    LLVM_DEBUG(
        dbgs() << "\t Not a VP/VEC Op ->defaulting to standard expansion\n";);
    return;
  }

  // Expansion defer to LLVM for lowering
  if (!N) {
    LLVM_DEBUG(dbgs() << "\t Default to standard expansion\n";);
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
      FixedOp = fixUpOperation(Op, OpDestVecTy, DAG);
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

  } else if (shouldExpandToVVP(*N)) {
    // Lower this to a VVP (or VEC_) op with the next expected result type
    ResN = ExpandToVVP(SDValue(N, ValIdx), DAG, VVPExpansionMode::ToNextWidth)
               .getNode();
  } else {
    // Otw, let LLVM do its expansion
    ResN = nullptr;
  }

  // Expansion defer to LLVM for lowering
  if (!ResN) {
    LLVM_DEBUG(dbgs() << "\t Default to standard expansion\n";);
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

// Override to enable LOAD_STACK_GUARD lowering on Linux.
bool VETargetLowering::useLoadStackGuardNode() const {
  if (!Subtarget->isTargetLinux())
    return TargetLowering::useLoadStackGuardNode();
  return true;
}

// Override to disable global variable loading on Linux.
void VETargetLowering::insertSSPDeclarations(Module &M) const {
  if (!Subtarget->isTargetLinux())
    return TargetLowering::insertSSPDeclarations(M);
}

void VETargetLowering::finalizeLowering(MachineFunction &MF) const {
  TargetLoweringBase::finalizeLowering(MF);
}
