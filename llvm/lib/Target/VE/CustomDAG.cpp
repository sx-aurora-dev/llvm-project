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

PosOpt GetVVPOpcode(unsigned OpCode) {
  if (IsVVP(OpCode))
    return OpCode;

  switch (OpCode) {
  case ISD::SCALAR_TO_VECTOR:
    return VEISD::VEC_BROADCAST;

  default:
    return None;
#define REGISTER_VVP_OP(VVP_NAME, NATIVE_ISD)                                  \
  case ISD::NATIVE_ISD:                                                        \
    return VEISD::VVP_NAME;
#include "VVPNodes.inc"
  }
}

bool SupportsPackedMode(unsigned Opcode) {
  switch (Opcode) {
  default:
    return false;

#define REGISTER_PACKED(VVP_NAME)                                              \
  case VEISD::VVP_NAME:                                                        \
    return true;
#include "VVPNodes.inc"
  }
}

bool IsVVPOrVEC(unsigned OC) {
  if ((VEISD::VEC_FIRST <= OC) && (OC <= VEISD::VEC_LAST))
    return true;
  return IsVVP(OC);
}

bool IsVVP(unsigned Opcode) {
  switch (Opcode) {
  default:
    return false;
#define ADD_VVP_OP(VVP_NAME)                                                   \
  case VEISD::VVP_NAME:                                                        \
    return true;
#include "VVPNodes.inc"
  }
}

// Choses the widest element type
EVT getLargestConvType(SDNode *Op) {
  EVT ResVT = Op->getValueType(0);
  EVT OpVT = Op->getOperand(0).getValueType();
  return ResVT.getStoreSizeInBits() > OpVT.getStoreSizeInBits() ? ResVT : OpVT;
}

PosOpt getReductionStartParamPos(unsigned ISD) {
  PosOpt VVPOC = GetVVPOpcode(ISD);
  if (!VVPOC)
    return None;

  switch (VVPOC.getValue()) {
  case VEISD::VVP_REDUCE_STRICT_FADD:
  case VEISD::VVP_REDUCE_STRICT_FMUL:
    return 0;
  default:
    return None;
  }
}

PosOpt getReductionVectorParamPos(unsigned ISD) {
  PosOpt VVPOC = GetVVPOpcode(ISD);
  if (!VVPOC)
    return None;

  unsigned OC = VVPOC.getValue();
  if (getReductionStartParamPos(OC))
    return 1;
  return 0;
}

Optional<EVT> getIdiomaticType(SDNode *Op) {
  auto MemN = dyn_cast<MemSDNode>(Op);
  if (MemN) {
    return MemN->getMemoryVT();
  }

  unsigned OC = Op->getOpcode();
  // Translate VP to VVP IDs on the fly
  switch (OC) {
  default:
    break;
#define HANDLE_VP_TO_VVP(VP_ID, VVP_ID)                                        \
  case ISD::VP_ID:                                                             \
    OC = VEISD::VVP_ID;                                                        \
    break;
#include "VVPNodes.inc"
  }

  // Expect VEISD:: VVP or ISD::non-VP Opcodes here
  switch (OC) {
  default:
    return None;

  case ISD::CONCAT_VECTORS:
  case ISD::EXTRACT_SUBVECTOR:
  case ISD::VECTOR_SHUFFLE:
  case ISD::BUILD_VECTOR:
  case ISD::SCALAR_TO_VECTOR:
    return Op->getValueType(0);

    // Known VP ops
    // all standard un/bin/tern-ary operators
#define REGISTER_UNNARY_VVP_OP(VVP_NAME, NATIVE_ISD)                           \
  case VEISD::VVP_NAME:                                                        \
  case ISD::NATIVE_ISD:
#define REGISTER_BINARY_VVP_OP(VVP_NAME, NATIVE_ISD)                           \
  case VEISD::VVP_NAME:                                                        \
  case ISD::NATIVE_ISD:
#define REGISTER_TERNARY_VVP_OP(VVP_NAME, NATIVE_ISD)                          \
  case VEISD::VVP_NAME:                                                        \
  case ISD::NATIVE_ISD:
#include "VVPNodes.inc"
    return Op->getValueType(0);

#define REGISTER_FPCONV_VVP_OP(VVP_NAME, NATIVE_ISD)                           \
  case VEISD::VVP_NAME:                                                        \
  case ISD::NATIVE_ISD:
#define REGISTER_ICONV_VVP_OP(VVP_NAME, NATIVE_ISD)                            \
  case VEISD::VVP_NAME:                                                        \
  case ISD::NATIVE_ISD:
#include "VVPNodes.inc"
    return getLargestConvType(Op);

#define REGISTER_REDUCE_VVP_OP(VVP_NAME, NATIVE_ISD)                           \
  case VEISD::VVP_NAME:                                                        \
  case ISD::NATIVE_ISD:
#include "VVPNodes.inc"
    {
      Optional<unsigned> VecParamPos = getReductionVectorParamPos(OC);
      assert(VecParamPos.hasValue());
      return Op->getOperand(VecParamPos.getValue()).getValueType();
    }

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

  // v256x broadcast
  if (!IsPackedType(VT)) {
    return Op;
  }

  LLVM_DEBUG(dbgs() << "Legalize packed broadcast\n");

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

  // allow aliased mask types
  if (VT == MVT::v8i64 || VT == MVT::v4i64)
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
  if (Offset == 0)
    return Src;

  // scalar bit shift
  if (!Src.getValueType().isVector()) {
    return createScalarShift(ResVT, Src, Offset);
  }

  // vector shift
  EVT VecVT = Src.getValueType();
  assert(!IsMaskType(VecVT));
  return createVMV(ResVT, Src, getConstant(Offset, MVT::i32),
                   CreateConstMask(VecVT.getVectorNumElements(), true), AVL);
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

SDValue CustomDAG::CreateUnpack(EVT DestVT, SDValue Vec, SubElem E,
                                SDValue AVL) {
  unsigned OC =
      (E == SubElem::Lo) ? VEISD::VEC_UNPACK_LO : VEISD::VEC_UNPACK_HI;
  return DAG.getNode(OC, DL, DestVT, Vec, AVL);
}

SDValue CustomDAG::CreatePack(EVT DestVT, SDValue LowV, SDValue HighV,
                              SDValue AVL) {
  return DAG.getNode(VEISD::VEC_PACK, DL, DestVT, LowV, HighV, AVL);
}

SDValue CustomDAG::CreateSwap(EVT DestVT, SDValue V, SDValue AVL) {
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
    return CreateConstMask(ResTy.getVectorNumElements(),
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

SDValue CustomDAG::createConstMask(unsigned NumElems,
                                   const LaneBits &TrueBits) const {
  SDValue MaskV = CreateConstMask(TrueBits.size(), false);

  // Scan for trivial cases
  bool TrivialMask = true;
  for (unsigned i = 1; i < NumElems; ++i) {
    if (TrueBits[i] != TrueBits[0]) {
      TrivialMask = false;
      break;
    }
  }
  if (TrivialMask)
    return CreateConstMask(TrueBits.size(), TrueBits[0]);

  unsigned RegPartIdx = 0;
  for (unsigned StartIdx = 0; StartIdx < NumElems;
       StartIdx += SXRegSize, ++RegPartIdx) {
    uint64_t ConstReg = 0;
    for (uint i = 0; i < SXRegSize; ++i) {
      ConstReg |= TrueBits[StartIdx + i] ? (1 << i) : 0;
    }
    // initial mask is all-zero already
    if (!ConstReg)
      continue;

    MaskV = createMaskInsert(MaskV, getConstant(RegPartIdx, MVT::i32),
                             getConstant(ConstReg, MVT::i64));
  }
  return MaskV;
}

SDValue CustomDAG::createSelect(SDValue OnTrueV, SDValue OnFalseV,
                                SDValue MaskV, SDValue PivotV) const {
  if (OnTrueV.isUndef())
    return OnFalseV;
  if (OnFalseV.isUndef())
    return OnTrueV;

  return DAG.getNode(VEISD::VVP_SELECT, DL, OnTrueV.getValueType(),
                     {OnTrueV, OnFalseV, MaskV, PivotV});
}

SDValue CustomDAG::CreateConstMask(unsigned NumElements, bool IsTrue) const {
  auto MaskVT = MVT::getVectorVT(MVT::i1, NumElements);

  // VEISelDAGtoDAG will replace this with the constant-true VM
  auto TrueVal = DAG.getConstant(-1, DL, MVT::i32);
  auto ElemCountN = DAG.getConstant(NumElements, DL, MVT::i32);

  auto Res =
      DAG.getNode(VEISD::VEC_BROADCAST, DL, MaskVT, {TrueVal, ElemCountN});
  if (IsTrue)
    return Res;

  // negate // FIXME
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

/// } class CustomDAG
} // namespace llvm
