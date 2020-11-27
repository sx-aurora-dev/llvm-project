//===-- CustomDAG.h - VE Custom DAG Nodes ------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file defines the interfaces that VE uses to lower LLVM code into a
// selection DAG.
//
//===----------------------------------------------------------------------===//

#include "CustomDAG.h"
#include "VE.h"
#include "VEISelLowering.h"
#include "llvm/CodeGen/SelectionDAG.h"
#include "llvm/CodeGen/TargetLowering.h"

#ifndef DEBUG_TYPE
#define DEBUG_TYPE "customdag"
#endif

namespace llvm {

/// Packing {

template <> Packing getPackingForMaskBits(const LaneBits MB) {
  return Packing::Normal;
}
template <> Packing getPackingForMaskBits(const PackedLaneBits MB) {
  return Packing::Dense;
}
    
/// } Packing

PosOpt GetVVPOpcode(unsigned OpCode) {
  if (IsVVP(OpCode))
    return OpCode;

  switch (OpCode) {
  default:
    return None;

  case ISD::SCALAR_TO_VECTOR:
    return VEISD::VEC_BROADCAST;

  case ISD::SELECT: // additional alias next to VSELECT
    return VEISD::VVP_SELECT;

#define HANDLE_VP_TO_VVP(VP_ID, VVP_NAME)                                      \
  case ISD::VP_ID:                                                             \
    return VEISD::VVP_NAME;

#define ADD_VVP_OP(VVP_NAME, NATIVE_ISD)                                  \
  case ISD::NATIVE_ISD:                                                        \
    return VEISD::VVP_NAME;
#include "VVPNodes.def"
  }
}

bool IsVVPReduction(unsigned Opcode) {
  switch (Opcode) {
  default:
    return false;

#define ADD_REDUCE_VVP_OP(VVPID, ...)                                     \
  case VEISD::VVPID:                                                           \
    return true;
#include "VVPNodes.def"
  }
}

bool SupportsPackedMode(unsigned Opcode) {
  switch (Opcode) {
  default:
    return false;

#define REGISTER_PACKED(VVP_NAME)                                              \
  case VEISD::VVP_NAME:                                                        \
    return true;
#include "VVPNodes.def"
  }
}

#define IF_IN_VEISD_RANGE(STARTOC, ENDOC)                                      \
  if ((VEISD::STARTOC <= OC) && (OC <= VEISD::ENDOC))

bool IsVVPOrVEC(unsigned OC) {
  IF_IN_VEISD_RANGE(VEC_FIRST, VEC_LAST) { return true; }
  IF_IN_VEISD_RANGE(VM_FIRST, VM_LAST) { return true; }

  return IsVVP(OC);
}
#undef IF_IN_VEISD_RANGE

bool IsVVP(unsigned Opcode) {
  switch (Opcode) {
  default:
    return false;
#define ADD_VVP_OP(VVP_NAME, NATIVE_ISD)                                       \
  case VEISD::VVP_NAME:                                                        \
    return true;
#include "VVPNodes.def"
  }
}

// Choses the widest element type
EVT getLargestConvType(SDNode *Op) {
  EVT ResVT = Op->getValueType(0);
  EVT OpVT = Op->getOperand(0).getValueType();
  return ResVT.getStoreSizeInBits() > OpVT.getStoreSizeInBits() ? ResVT : OpVT;
}

/// Node Properties {

PosOpt getVVPReductionStartParamPos(unsigned VVPOC) {
  switch (VVPOC) {
  case VEISD::VVP_REDUCE_SEQ_FADD:
  case VEISD::VVP_REDUCE_SEQ_FMUL:
    return 0;
  default:
    return None;
  }
}

PosOpt getVPReductionVectorParamPos(unsigned VPISD) {
  PosOpt VecPos;
  switch (VPISD) {
  default:
    break;
#define BEGIN_REGISTER_VP_SDNODE(VPISD, ...) case ISD::VPISD:
#define HANDLE_VP_REDUCTION(ACCUPOS, VECTORPOS, ...) VecPos = VECTORPOS;
#define END_REGISTER_VP_SDNODE(VPISD) break;
#include "llvm/IR/VPIntrinsics.def"
  }
  return VecPos;
}

PosOpt getIntrinReductionVectorParamPos(unsigned ISD) {
  switch (ISD) {
    case ISD::VECREDUCE_ADD:
    case ISD::VECREDUCE_MUL:
    case ISD::VECREDUCE_AND:
    case ISD::VECREDUCE_OR:
    case ISD::VECREDUCE_XOR:
    case ISD::VECREDUCE_UMIN:
    case ISD::VECREDUCE_UMAX:
    case ISD::VECREDUCE_SMIN:
    case ISD::VECREDUCE_SMAX:
    case ISD::VECREDUCE_FADD:
    case ISD::VECREDUCE_FMUL:
    case ISD::VECREDUCE_FMIN:
    case ISD::VECREDUCE_FMAX:
      return 0;

    case ISD::VECREDUCE_SEQ_FADD:
    case ISD::VECREDUCE_SEQ_FMUL:
      return 1;
  }
  return None;
}

PosOpt getVVPReductionVectorParamPos(unsigned VPISD) {
  PosOpt VecPosOpt = getVVPReductionStartParamPos(VPISD);
  if (!VecPosOpt)
    return None;
  return getVVPReductionStartParamPos(VPISD).getValue() == 0 ? 1 : 0;
}

PosOpt getReductionVectorParamPos(unsigned ISD) {
  // VP reduction param pos
  PosOpt VecPos = getVPReductionVectorParamPos(ISD);
  if (VecPos) return VecPos;

  // VVP reduction
  VecPos = getVVPReductionVectorParamPos(ISD);
  if (VecPos) return VecPos;

  // Regular reduction
  VecPos = getIntrinReductionVectorParamPos(ISD);
  return VecPos;
}

/// } Node Properties

Optional<EVT> getIdiomaticType(SDNode *Op) {
  // For memory ops -> the transfered data type
  auto MemN = dyn_cast<MemSDNode>(Op);
  if (MemN) {
    return MemN->getMemoryVT();
  }

  // For reductions -> the reduced vector type
  PosOpt RedVecPos = getReductionVectorParamPos(Op->getOpcode());
  if (RedVecPos)
    return Op->getOperand(RedVecPos.getValue())->getValueType(0);

  // Otw, translate everyhing to VVP (expect the VP and non-VP characteristic
  // parameter to be at the same position)
  unsigned OC = Op->getOpcode();
  switch (OC) {
  default:
    break;
#define HANDLE_VP_TO_VVP(VP_ID, VVP_ID)                                        \
  case ISD::VP_ID:                                                             \
    OC = VEISD::VVP_ID;                                                        \
    break;
#include "VVPNodes.def"
  }

  // Expect VEISD:: VVP or ISD::non-VP Opcodes here
  switch (OC) {
  default:
    return None;

  case ISD::SELECT: // not aliased with VVP_SELECT
  case ISD::CONCAT_VECTORS:
  case ISD::EXTRACT_SUBVECTOR:
  case ISD::VECTOR_SHUFFLE:
  case ISD::BUILD_VECTOR:
  case ISD::SCALAR_TO_VECTOR:
    return Op->getValueType(0);

    // Known VP ops
    // all standard un/bin/tern-ary operators
#define ADD_UNARY_VVP_OP(VVP_NAME, NATIVE_ISD)                            \
  case VEISD::VVP_NAME:                                                        \
  case ISD::NATIVE_ISD:
#define ADD_BINARY_VVP_OP(VVP_NAME, NATIVE_ISD)                           \
  case VEISD::VVP_NAME:                                                        \
  case ISD::NATIVE_ISD:
#define ADD_TERNARY_VVP_OP(VVP_NAME, NATIVE_ISD)                          \
  case VEISD::VVP_NAME:                                                        \
  case ISD::NATIVE_ISD:
#include "VVPNodes.def"
    return Op->getValueType(0);

#define ADD_FPCONV_VVP_OP(VVP_NAME, NATIVE_ISD)                           \
  case VEISD::VVP_NAME:                                                        \
  case ISD::NATIVE_ISD:
#define ADD_ICONV_VVP_OP(VVP_NAME, NATIVE_ISD)                            \
  case VEISD::VVP_NAME:                                                        \
  case ISD::NATIVE_ISD:
#include "VVPNodes.def"
    return getLargestConvType(Op);

  case VEISD::VEC_TOMASK:
  case VEISD::VEC_NARROW:
  case VEISD::VEC_SEQ:
  case VEISD::VEC_BROADCAST:
    return Op->getValueType(0);
  case VEISD::VVP_GATHER:
    return Op->getValueType(0);
  case VEISD::VVP_SCATTER:
    return Op->getOperand(0)->getValueType(0); // FIXME use memory VT instead
  }
}

VecLenOpt MinVectorLength(VecLenOpt A, VecLenOpt B) {
  if (!A)
    return B;
  if (!B)
    return A;
  return std::min<unsigned>(A.getValue(), B.getValue());
}

// Whether direct codegen for this type will result in a packed operation
// (requiring a packed VL param..)

bool IsPackedType(EVT SomeVT) {
  if (!SomeVT.isVector())
    return false;
  return SomeVT.getVectorNumElements() > StandardVectorWidth;
}

// legalize packed-mode broadcasts into lane replication + broadcast
SDValue LegalizeBroadcast(SDValue Op, SelectionDAG &DAG) {
  if (Op.getOpcode() != VEISD::VEC_BROADCAST)
    return Op;

  EVT VT = Op.getValueType();
  SDLoc DL(Op);

  auto ScaOp = Op.getOperand(0);
  auto ScaTy = ScaOp->getValueType(0);
  auto VLOp = Op.getOperand(1);

  // v256x broadcast (element has to be i64/f64 always)
  if (!IsPackedType(VT)) {
    return Op;
  }

  LLVM_DEBUG(dbgs() << "Legalize packed broadcast\n");

  // v512x broadcast
  // This is a packed broadcast.
  // replicate the scalar sub reg (f32 or i32) onto the opposing half of the
  // scalar reg and feed it into a I64 -> v256i64 broadcast.
  unsigned ReplOC;
  if (ScaTy == MVT::f32) {
    ReplOC = VEISD::REPL_F32;
  } else if (ScaTy == MVT::i32) {
    ReplOC = VEISD::REPL_I32;
  } else {
    assert(ScaTy == MVT::i64);
    LLVM_DEBUG(dbgs() << "already using I64 -> unchanged!\n");
    return Op;
  }

  auto ReplOp = DAG.getNode(ReplOC, DL, MVT::i64, ScaOp);
  // auto LegalVecTy = MVT::getVectorVT(MVT::i64, Ty.getVectorNumElements());
  return DAG.getNode(VEISD::VEC_BROADCAST, DL, VT, {ReplOp, VLOp});
}

SDValue LegalizeVecOperand(SDValue Op, SelectionDAG &DAG) {
  if (!Op.getValueType().isVector())
    return Op;

  // TODO add operand legalization
  return LegalizeBroadcast(Op, DAG);
}

// whether this VVP operation has no mask argument
bool HasDeadMask(unsigned VVPOC) {
  switch (VVPOC) {
  default:
    return false;

  case VEISD::VVP_LOAD:
    return true;
  }
}

#if 0
#endif

Optional<unsigned> PeekForNarrow(SDValue Op) {
  if (!Op.getValueType().isVector())
    return None;
  if (Op->use_size() != 1)
    return None;
  auto OnlyN = *Op->use_begin();
  if (OnlyN->getOpcode() != VEISD::VEC_NARROW)
    return None;
  return cast<ConstantSDNode>(OnlyN->getOperand(1))->getZExtValue();
}

Optional<SDValue> EVLToVal(VecLenOpt Opt, SDLoc &DL, SelectionDAG &DAG) {
  if (!Opt)
    return None;
  return DAG.getConstant(Opt.getValue(), DL, MVT::i32);
}

bool IsMaskType(EVT VT) {
  if (!VT.isVector())
    return false;

  // an actual bit mask type
  if (VT.getVectorElementType() == MVT::i1)
    return true;

  // not a mask
  return false;
}

unsigned GetMaskBits(EVT VT) {
  if (!VT.isVector())
    return 0;

  EVT ElemVT = VT.getVectorElementType();
  if (!ElemVT.isInteger())
    return 0;

  return ElemVT.getScalarSizeInBits() * VT.getVectorNumElements();
}

// select an appropriate %evl argument for this element count.
// This will return the correct result for packed mode oeprations (half).
unsigned SelectBoundedVectorLength(unsigned StaticNumElems) {
  if (StaticNumElems > StandardVectorWidth) {
    return (StaticNumElems + 1) / 2;
  }
  return StaticNumElems;
}

/// class CustomDAG {

/// Helper class for short hand custom node creation ///
SDValue CustomDAG::CreateSeq(EVT ResTy,
                             Optional<SDValue> OpVectorLength) const {
  // Pick VL
  SDValue VectorLen;
  if (OpVectorLength.hasValue()) {
    VectorLen = OpVectorLength.getValue();
  } else {
    VectorLen = DAG.getConstant(
        SelectBoundedVectorLength(ResTy.getVectorNumElements()), DL, MVT::i32);
  }

  return DAG.getNode(VEISD::VEC_SEQ, DL, ResTy, VectorLen);
}

SDValue CustomDAG::getTargetExtractSubreg(MVT SubRegVT, int SubRegIdx,
                                          SDValue RegV) const {
  return DAG.getTargetExtractSubreg(SubRegIdx, DL, SubRegVT, RegV);
}

// create a vector element or scalar bitshift depending on the element type
// dst[i] = src[i + Offset]
SDValue CustomDAG::createScalarShift(EVT ResVT, SDValue Src, int Offset) const {
  if (Offset == 0)
    return Src;
  unsigned OC = Offset > 0 ? ISD::SHL : ISD::SRL; // VE::SLLri : VE::SRLri;
  SDValue ShiftV = getConstant(std::abs(Offset),
                               MVT::i32); // This is the ShiftAmount constant
  return DAG.getNode(OC, DL, ResVT, Src, ShiftV);
}

// create a vector element or scalar bitshift depending on the element type
// dst[i] = src[i + Offset]
SDValue CustomDAG::createElementShift(EVT ResVT, SDValue Src, int Offset,
                                      SDValue AVL) const {
  assert(ResVT.getVectorNumElements() <= 256 && "TODO implement packed mode");
  if (Offset == 0)
    return Src;

  // scalar bit shift
  if (!Src.getValueType().isVector()) {
    return createScalarShift(ResVT, Src, Offset);
  }

  // vector shift
  EVT VecVT = Src.getValueType();
  assert(!IsPackedType(VecVT) && "TODO implement");
  assert(!IsMaskType(VecVT));
  return createVMV(ResVT, Src, getConstant(Offset, MVT::i32),
                   createUniformConstMask(Packing::Normal,
                                          VecVT.getVectorNumElements(), true),
                   AVL);
}

SDValue CustomDAG::createPassthruVMV(EVT ResVT, SDValue SrcV, SDValue OffsetV,
                                     SDValue Mask, SDValue PassthruV,
                                     SDValue Avl) const {
  abort(); // TODO return DAG.getNode(VEISD::VEC_VMV, DL, ResVT, {SrcV, OffsetV,
           // Mask, Avl});
}

SDValue CustomDAG::createVMV(EVT ResVT, SDValue SrcV, SDValue OffsetV,
                             SDValue Mask, SDValue Avl) const {
  return DAG.getNode(VEISD::VEC_VMV, DL, ResVT, {SrcV, OffsetV, Mask, Avl});
}

SDValue CustomDAG::CreateExtractMask(SDValue MaskV, SDValue IndexV) const {
  return DAG.getNode(VEISD::VM_EXTRACT, DL, MVT::i64, MaskV, IndexV);
}

SDValue CustomDAG::CreateInsertMask(SDValue MaskV, SDValue ElemV,
                                    SDValue IndexV) const {
  return DAG.getNode(VEISD::VM_INSERT, DL, MaskV.getValueType(), MaskV, ElemV,
                     IndexV);
}

SDValue CustomDAG::CreateUnpack(EVT DestVT, SDValue Vec, PackElem E,
                                SDValue AVL) const {
  unsigned OC =
      (E == PackElem::Lo) ? VEISD::VEC_UNPACK_LO : VEISD::VEC_UNPACK_HI;
  return DAG.getNode(OC, DL, DestVT, Vec, AVL);
}

SDValue CustomDAG::CreatePack(EVT DestVT, SDValue LowV, SDValue HighV,
                              SDValue AVL) const {
  return DAG.getNode(VEISD::VEC_PACK, DL, DestVT, LowV, HighV, AVL);
}

SDValue CustomDAG::CreateSwap(EVT DestVT, SDValue V, SDValue AVL) const {
  return DAG.getNode(VEISD::VEC_SWAP, DL, DestVT, V, AVL);
}

SDValue CustomDAG::CreateBroadcast(EVT ResTy, SDValue S,
                                   Optional<SDValue> OpVectorLength) const {

  // Pick VL
  SDValue VectorLen;
  if (OpVectorLength.hasValue()) {
    VectorLen = OpVectorLength.getValue();
  } else {
    VectorLen = DAG.getConstant(
        SelectBoundedVectorLength(ResTy.getVectorNumElements()), DL, MVT::i32);
  }

  // FIXME legalize vlen for packed mode!

  // Non-mask case
  if (ResTy.getVectorElementType() != MVT::i1) {
    return LegalizeBroadcast(
        DAG.getNode(VEISD::VEC_BROADCAST, DL, ResTy, {S, VectorLen}), DAG);
  }

  // Mask bit broadcast
  auto BcConst = dyn_cast<ConstantSDNode>(S);

  // Constant mask splat
  if (BcConst) {
    return createUniformConstMask(getPackingForVT(ResTy),
                                  ResTy.getVectorNumElements(),
                                  BcConst->getSExtValue() != 0);
  }

  // Generic mask code path
  auto BoolTy = S.getSimpleValueType();
  assert(BoolTy == MVT::i32);

  // cast to i32 ty
  SDValue CmpElem = DAG.getSExtOrTrunc(S, DL, MVT::i32);

  unsigned ElemCount = ResTy.getVectorNumElements();
  MVT CmpVecTy = MVT::getVectorVT(BoolTy, ElemCount);

  // broadcast to vector
  SDValue BCVec =
      DAG.getNode(VEISD::VEC_BROADCAST, DL, CmpVecTy, {CmpElem, VectorLen});
  SDValue ZeroVec =
      CreateBroadcast(CmpVecTy, {DAG.getConstant(0, DL, BoolTy)}, VectorLen);

  MVT BoolVecTy = MVT::getVectorVT(MVT::i1, ElemCount);

  // broadcast(Data) != broadcast(0)
  return DAG.getSetCC(DL, BoolVecTy, BCVec, ZeroVec, ISD::CondCode::SETNE);
}

// Extract an SX register from a mask
SDValue CustomDAG::createMaskExtract(SDValue MaskV, SDValue Idx) const {
  return DAG.getNode(VEISD::VM_EXTRACT, DL, MVT::i64, {MaskV, Idx});
}

// Extract an SX register from a mask
SDValue CustomDAG::createMaskInsert(SDValue MaskV, SDValue Idx,
                                    SDValue ElemV) const {
  return DAG.getNode(VEISD::VM_INSERT, DL, MaskV.getValueType(),
                     {MaskV, Idx, ElemV});
}

template <typename MaskBits>
SDValue CustomDAG::createConstMask(unsigned NumElems,
                                   const MaskBits &TrueBits) const {
  Packing Packing = getPackingForMaskBits<>(TrueBits);

  // Scan for trivial cases
  bool TrivialMask = true;
  for (unsigned i = 1; i < NumElems; ++i) {
    if (TrueBits[i] != TrueBits[0]) {
      TrivialMask = false;
      break;
    }
  }
  if (TrivialMask) {
    return createUniformConstMask(Packing, TrueBits.size(), TrueBits[0]);
  }

  SDValue MaskV = createUniformConstMask(Packing, TrueBits.size(), false);
  unsigned RegPartIdx = 0;
  for (unsigned StartIdx = 0; StartIdx < NumElems;
       StartIdx += SXRegSize, ++RegPartIdx) {
    uint64_t ConstReg = 0;
    for (uint i = 0; i < SXRegSize; ++i) {
      uint64_t LaneMask = ((uint64_t) 1) << i;
      ConstReg |= TrueBits[StartIdx + i] ? LaneMask : 0;
    }
    // initial mask is all-zero already
    if (!ConstReg)
      continue;

    MaskV = createMaskInsert(MaskV, getConstant(RegPartIdx, MVT::i32),
                             getConstant(ConstReg, MVT::i64));
  }
  return MaskV;
}

template SDValue CustomDAG::createConstMask<LaneBits>(unsigned, const LaneBits&) const;
template SDValue CustomDAG::createConstMask<PackedLaneBits>(unsigned, const PackedLaneBits&) const;

SDValue CustomDAG::createSelect(EVT ResVT, SDValue OnTrueV, SDValue OnFalseV,
                                SDValue MaskV, SDValue PivotV) const {
  if (OnTrueV.isUndef())
    return OnFalseV;
  if (OnFalseV.isUndef())
    return OnTrueV;

  return DAG.getNode(VEISD::VVP_SELECT, DL, ResVT,
                     {OnTrueV, OnFalseV, MaskV, PivotV});
}

SDValue CustomDAG::createUniformConstMask(Packing Packing, unsigned NumElements,
                                          bool IsTrue) const {
  auto MaskVT = getMaskVT(Packing);

  // VEISelDAGtoDAG will replace this with the constant-true VM
  auto TrueVal = DAG.getConstant(-1, DL, MVT::i32);

  unsigned AVL = NumElements;
  if (Packing == Packing::Dense) {
    AVL = (NumElements + 1) / 2;
  }

  auto Res = getNode(VEISD::VEC_BROADCAST, MaskVT, {TrueVal, getConstEVL(AVL)});
  if (IsTrue)
    return Res;

  // TODO respect NumElements
  return DAG.getNOT(DL, Res, Res.getValueType());
}

SDValue CustomDAG::getConstant(uint64_t Val, EVT VT, bool IsTarget,
                               bool IsOpaque) const {
  return DAG.getConstant(Val, DL, VT, IsTarget, IsOpaque);
}

void CustomDAG::dumpValue(SDValue V) const { V->print(dbgs(), &DAG); }

SDValue CustomDAG::getVectorExtract(SDValue VecV, SDValue IdxV) const {
  assert(VecV.getValueType().isVector());
  auto ElemVT = VecV.getValueType().getVectorElementType();
  return getNode(ISD::EXTRACT_VECTOR_ELT, ElemVT, {VecV, IdxV});
}

SDValue CustomDAG::getVectorInsert(SDValue DestVecV, SDValue ElemV,
                                   SDValue IdxV) const {
  assert(DestVecV.getValueType().isVector());
  return getNode(ISD::INSERT_VECTOR_ELT, DestVecV.getValueType(),
                 {DestVecV, ElemV, IdxV});
}

SDValue CustomDAG::createMaskCast(SDValue VectorV, SDValue AVL) const {
  if (IsMaskType(VectorV.getValueType()))
    return VectorV;

  if (IsPackedType(VectorV.getValueType())) {
    auto ValVT = VectorV.getValueType();
    auto LoPart = CreateUnpack(getSplitVT(ValVT), VectorV, PackElem::Lo, AVL);
    auto HiPart = CreateUnpack(getSplitVT(ValVT), VectorV, PackElem::Hi, AVL);
    auto LoMask = createMaskCast(LoPart, AVL);
    auto HiMask = createMaskCast(HiPart, AVL);
    const auto PackedMaskVT = MVT::v512i1;
    return CreatePack(PackedMaskVT, LoMask, HiMask, AVL);
  }

  return DAG.getNode(VEISD::VEC_TOMASK, DL, getMaskVTFor(VectorV),
                     {VectorV, AVL});
}

EVT CustomDAG::legalizeVectorType(SDValue Op, VVPExpansionMode Mode) const {
  return VLI.LegalizeVectorType(Op->getValueType(0), Op, DAG, Mode);
}

SDValue CustomDAG::getTokenFactor(ArrayRef<SDValue> Tokens) const {
  return DAG.getNode(ISD::TokenFactor, DL, MVT::Other, Tokens);
}

SDValue CustomDAG::getVVPLoad(EVT LegalResVT, SDValue Chain, SDValue PtrV, SDValue StrideV,
                              SDValue MaskV, SDValue AVL) const {
  return DAG.getNode(VEISD::VVP_LOAD, DL, {LegalResVT, MVT::Other},
                     {Chain, PtrV, StrideV, MaskV, AVL});
}

SDValue CustomDAG::getVVPStore(SDValue Chain, SDValue DataV, SDValue PtrV,
                               SDValue StrideV, SDValue MaskV,
                               SDValue AVL) const {
  return DAG.getNode(VEISD::VVP_LOAD, DL, MVT::Other,
                     {Chain, DataV, PtrV, StrideV, MaskV, AVL});
}

SDValue CustomDAG::getVVPGather(EVT LegalResVT, SDValue ChainV, SDValue PtrV,
                                SDValue MaskV, SDValue AVL) const {
  return DAG.getNode(VEISD::VVP_GATHER, DL, {LegalResVT, MVT::Other},
                     {ChainV, PtrV, MaskV, AVL});
}

SDValue CustomDAG::extractPackElem(SDValue Op, PackElem Part,
                              SDValue AVL) {
  EVT OldValVT = Op.getValue(0).getValueType();
  if (!OldValVT.isVector())
    return Op;

  // TODO peek through pack operations
  return CreateUnpack(getSplitVT(OldValVT), Op, Part, AVL);
}

SDValue
CustomDAG::createConstantTargetMask(VVPWideningInfo WidenInfo) const {
  /// Use the eventual native vector width for all newly generated operands
  // we do not want to go through ::ReplaceNodeResults again only to have them
  // widened
  unsigned NativeVectorWidth =
      WidenInfo.PackedMode ? PackedWidth : StandardVectorWidth;

  // Generate a remainder mask for packed operations
  Packing PackFlag = WidenInfo.PackedMode ? Packing::Dense : Packing::Normal;
  if (!WidenInfo.NeedsPackedMasking) {
    return createUniformConstMask(PackFlag, NativeVectorWidth, true);

  } else {
    // TODO only really generate a mask if there is a change the operation will
    // benefit from it (eg, for vfdiv)
    PackedLaneBits MaskBits;
    MaskBits.reset();
    MaskBits.flip();
    size_t OddRemainderBitPos = WidenInfo.ActiveVectorLength;
    MaskBits[OddRemainderBitPos] = false;
    return createConstMask<>(PackedWidth, MaskBits);
  }
}

SDValue
CustomDAG::createTargetAVL(VVPWideningInfo WidenInfo) const {
  // Legalize the AVL
  if (WidenInfo.PackedMode) {
    return getConstEVL((WidenInfo.ActiveVectorLength + 1) / 2);
  } else {
    return getConstEVL(WidenInfo.ActiveVectorLength);
  }
}

CustomDAG::TargetMasks
CustomDAG::createTargetSplitMask(VVPWideningInfo WidenInfo, SDValue RawMask, SDValue RawAVL, PackElem Part) {
  // No masking caused, we simply adjust the AVL for the parts
  SDValue NewAVL;
  if (!RawAVL) {
    unsigned PartAVL = WidenInfo.ActiveVectorLength / 2;
    if (WidenInfo.NeedsPackedMasking) {
      PartAVL += (int) (Part == PackElem::Lo);
    }
    NewAVL = getConstEVL(PartAVL);
  } else if (WidenInfo.NeedsPackedMasking) {
    if (Part == PackElem::Lo) {
      auto PlusOne = getNode(ISD::ADD, MVT::i32, {RawAVL, getConstEVL(1)});
      NewAVL = getNode(ISD::SRL, MVT::i32, {PlusOne, getConstEVL(1)});
    } else {
      NewAVL = getNode(ISD::SRL, MVT::i32, {RawAVL, getConstEVL(1)});
    }
  } else {
      NewAVL = getNode(ISD::SRL, MVT::i32, {RawAVL, getConstEVL(1)});
  }

  // Legalize Mask (unpack or all-true)
  SDValue NewMask;
  if (!RawMask) {
    NewMask = createUniformConstMask(Packing::Normal, true);
  } else {
    NewMask = extractPackElem(RawMask, Part, NewAVL);
  }

  return CustomDAG::TargetMasks(NewMask, NewAVL);
}

CustomDAG::TargetMasks
CustomDAG::createTargetMask(VVPWideningInfo WidenInfo, SDValue RawMask, SDValue RawAVL) {
  bool IsDynamicAVL = RawAVL && !isa<ConstantSDNode>(RawAVL);

  // Legalize AVL
  SDValue NewAVL;
  if (!RawAVL) {
    NewAVL = createTargetAVL(WidenInfo);
  } else if (auto ConstAVL = dyn_cast<ConstantSDNode>(RawAVL)) {
    WidenInfo.ActiveVectorLength = std::min<unsigned>(ConstAVL->getZExtValue(), WidenInfo.ActiveVectorLength);
    NewAVL = createTargetAVL(WidenInfo);
  } else if (RawAVL && !WidenInfo.PackedMode) {
    NewAVL = RawAVL;
  } else {
    assert(WidenInfo.PackedMode);
    assert(IsDynamicAVL);
    
    auto PlusOne = getNode(ISD::ADD, MVT::i32, {RawAVL, getConstEVL(1)});
    NewAVL = getNode(ISD::SRL, MVT::i32, {PlusOne, getConstEVL(1)});
  }

  // Legalize Mask (nothing to do here)
  SDValue NewMask;
  if (!RawMask) {
    NewMask = createConstantTargetMask(WidenInfo);
  } else {
    NewMask = RawMask;
  }

  return CustomDAG::TargetMasks(NewMask, NewAVL);
}

SDValue
CustomDAG::getTargetInsertSubreg(int SRIdx, EVT VT, SDValue Operand, SDValue SubReg) const {
  return DAG.getTargetInsertSubreg(SRIdx, DL, VT, Operand, SubReg);
}

/// } class CustomDAG
} // namespace llvm
