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

BVMaskKind AnalyzeBuildVectorMask(BuildVectorSDNode *BVN, unsigned &FirstOne,
                                  unsigned &FirstZero, unsigned &NumElements) {
  bool HasFirstOne = false, HasFirstZero = false;
  FirstOne = 0;
  FirstZero = 0;
  NumElements = 0;

  // this matches a 0*1*0* pattern (BVMaskKind::Interval)
  for (unsigned i = 0; i < BVN->getNumOperands(); ++i) {
    auto Elem = BVN->getOperand(i);
    if (Elem->isUndef())
      continue;
    ++NumElements;
    auto CE = dyn_cast<ConstantSDNode>(Elem);
    if (!CE)
      return BVMaskKind::Unknown;
    bool TrueBit = CE->getZExtValue() != 0;

    if (TrueBit && !HasFirstOne) {
      FirstOne = i;
      HasFirstOne = true;
    } else if (!TrueBit && !HasFirstZero) {
      FirstZero = i;
      HasFirstZero = true;
    } else if (TrueBit) {
      // flipping bits on again ->abort
      return BVMaskKind::Unknown;
    }
  }

  return BVMaskKind::Interval;
}

BVKind AnalyzeBuildVector(BuildVectorSDNode *BVN, unsigned &FirstDef,
                          unsigned &LastDef, int64_t &Stride,
                          unsigned &BlockLength, unsigned &NumElements) {
  // Check UNDEF or FirstDef
  NumElements = 0;
  bool AllUndef = true;
  FirstDef = 0;
  LastDef = 0;
  for (unsigned i = 0; i < BVN->getNumOperands(); ++i) {
    if (BVN->getOperand(i).isUndef())
      continue;
    ++NumElements;

    // mark first non-undef position
    if (AllUndef) {
      FirstDef = i;
      AllUndef = false;
    }
    LastDef = i;
  }
  if (AllUndef) {
    return BVKind::Unknown;
  }

  // Check broadcast
  bool IsBroadcast = true;
  for (unsigned i = FirstDef + 1; i < BVN->getNumOperands(); ++i) {
    bool SameAsFirst = BVN->getOperand(FirstDef) == BVN->getOperand(i);
    if (!SameAsFirst && !BVN->getOperand(i).isUndef()) {
      IsBroadcast = false;
    }
  }
  if (IsBroadcast)
    return BVKind::Broadcast;

  ///// Stride pattern detection /////
  // FIXME clean up

  bool hasConstantStride = true;
  bool hasBlockStride = false;
  bool hasBlockStride2 = false;
  bool firstStride = true;
  int64_t lastElemValue;
  BlockLength = 16;

  // Optional<int64_t> InnerStrideOpt;
  // Optional<int64_t> OuterStrideOpt
  // Optional<unsigned> BlockSizeOpt;

  for (unsigned i = 0; i < BVN->getNumOperands(); ++i) {
    if (hasBlockStride) {
      if (i % BlockLength == 0)
        Stride = 1;
      else
        Stride = 0;
    }

    if (BVN->getOperand(i).isUndef()) {
      if (hasBlockStride2 && i % BlockLength == 0)
        lastElemValue = 0;
      else
        lastElemValue += Stride;
      continue;
    }

    // is this an immediate constant value?
    auto *constNumElem = dyn_cast<ConstantSDNode>(BVN->getOperand(i));
    if (!constNumElem) {
      hasConstantStride = false;
      hasBlockStride = false;
      hasBlockStride2 = false;
      break;
    }

    // read value
    int64_t elemValue = constNumElem->getSExtValue();

    if (i == FirstDef) {
      // FIXME: Currently, this code requies that first value of vseq
      // is zero.  This is possible to enhance like thses instructions:
      //        VSEQ $v0
      //        VBRD $v1, 2
      //        VADD $v0, $v0, $v1
      if (elemValue != 0) {
        hasConstantStride = false;
        hasBlockStride = false;
        hasBlockStride2 = false;
        break;
      }
    } else if (i > FirstDef && firstStride) {
      // first stride
      Stride = (elemValue - lastElemValue) / (i - FirstDef);
      firstStride = false;
    } else if (i > FirstDef) {
      // later stride
      if (hasBlockStride2 && elemValue == 0 && i % BlockLength == 0) {
        lastElemValue = 0;
        continue;
      }
      int64_t thisStride = elemValue - lastElemValue;
      if (thisStride != Stride) {
        hasConstantStride = false;
        if (!hasBlockStride && thisStride == 1 && Stride == 0 &&
            lastElemValue == 0) {
          hasBlockStride = true;
          BlockLength = i;
        } else if (!hasBlockStride2 && elemValue == 0 &&
                   lastElemValue + 1 == i) {
          hasBlockStride2 = true;
          BlockLength = i;
        } else {
          // not blockStride anymore.  e.g. { 0, 1, 2, 3, 0, 0, 0, 0 }
          hasBlockStride = false;
          hasBlockStride2 = false;
          break;
        }
      }
    }

    // track last elem value
    lastElemValue = elemValue;
  }

  if (hasConstantStride)
    return BVKind::Seq;
  if (hasBlockStride)
    return BVKind::BlockSeq;
  if (hasBlockStride2)
    return BVKind::SeqBlock;
  return BVKind::Unknown;
}

Optional<unsigned> GetVVPOpcode(unsigned OpCode) {
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
EVT getFPConvType(SDNode *Op) {
  EVT ResVT = Op->getValueType(0);
  EVT OpVT = Op->getOperand(0).getValueType();
  return ResVT.getStoreSizeInBits() > OpVT.getStoreSizeInBits() ? ResVT : OpVT;
}

Optional<EVT> getIdiomaticType(SDNode *Op) {
  auto MemN = dyn_cast<MemSDNode>(Op);
  if (MemN) {
    return MemN->getMemoryVT();
  }

  unsigned OC = Op->getOpcode();
  // Translate VP to VVP IDs on the fly
  switch (OC) {
    default: break;
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
#include "VVPNodes.inc"
    return getFPConvType(Op);

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

VecLenOpt InferLengthFromMask(SDValue MaskV) {
  auto BVN = dyn_cast<BuildVectorSDNode>(MaskV.getNode());
  if (BVN) {
    unsigned FirstDef, LastDef, NumElems;

    BVMaskKind BVK = AnalyzeBuildVectorMask(BVN, FirstDef, LastDef, NumElems);
    if (BVK == BVMaskKind::Interval) {
      // FIXME \p FirstDef must be == 0
      return LastDef + 1;
    }
  }

  return None;
}

SDValue ReduceVectorLength(SDValue Mask, SDValue DynamicVL, VecLenOpt VLHint,
                           SelectionDAG &DAG) {
  VecLenOpt MaskVL = InferLengthFromMask(Mask);

  // TODO analyze Mask
  auto ActualConstVL = dyn_cast<ConstantSDNode>(DynamicVL);
  if (!ActualConstVL)
    return DynamicVL;

  int64_t EVLVal = ActualConstVL->getSExtValue();
  SDLoc DL(DynamicVL);

  // no hint available -> dynamic VL
  if (!VLHint)
    return DynamicVL;

  // in-effective DynamicVL -> return the hint
  if (EVLVal < 0) {
    return DAG.getConstant(VLHint.getValue(), DL, MVT::i32);
  }

  // the minimum of dynamicVL and the VLHint
  VecLenOpt MinOfAllHints =
      MinVectorLength(MinVectorLength(MaskVL, VLHint), EVLVal);
  return DAG.getConstant(MinOfAllHints.getValue(), DL, MVT::i32);
}

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

SDValue
CustomDAG::getTargetExtractSubreg(MVT SubRegVT, int SubRegIdx, SDValue RegV) const {
  return DAG.getTargetExtractSubreg(SubRegIdx, DL, SubRegVT, RegV);
}

// create a vector element or scalar bitshift depending on the element type
// dst[i] = src[i + Offset]
SDValue CustomDAG::createScalarShift(EVT ResVT, SDValue Src, int Offset) const {
  if (Offset == 0)
    return Src;
  unsigned OC = Offset > 0 ? VE::SLLri : VE::SRLri; // ISD::SHL : ISD::SRL;
  SDValue ShiftV = getConstant(std::abs(Offset), ResVT);
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

SDValue CustomDAG::createVMV(EVT ResVT, SDValue SrcV, SDValue OffsetV,
                             SDValue Mask, SDValue Avl) const {
  return DAG.getNode(VEISD::VEC_VMV, DL, ResVT, {SrcV, OffsetV, Mask, Avl});
}

SDValue
CustomDAG::CreateExtractMask(SDValue MaskV, SDValue IndexV) const {
  return DAG.getNode(VEISD::VM_EXTRACT, DL, MVT::i64, MaskV, IndexV);
}

SDValue
CustomDAG::CreateInsertMask(SDValue MaskV, SDValue ElemV, SDValue IndexV) const {
  return DAG.getNode(VEISD::VM_INSERT, DL, MaskV.getValueType(), MaskV, ElemV, IndexV);
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

SDValue
CustomDAG::CreateBroadcast(EVT ResTy, SDValue S,
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
SDValue CustomDAG::createMaskExtract(SDValue MaskV, SDValue Idx) {
  return DAG.getNode(VEISD::VM_EXTRACT, DL, MVT::i64, {MaskV, Idx});
}

// Extract an SX register from a mask
SDValue CustomDAG::createMaskInsert(SDValue MaskV, SDValue Idx, SDValue ElemV) {
  return DAG.getNode(VEISD::VM_INSERT, DL, MaskV.getValueType(),
                     {MaskV, Idx, ElemV});
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

  // negate
  return DAG.getNOT(DL, Res, Res.getValueType());
}

SDValue CustomDAG::getConstant(uint64_t Val, EVT VT, bool IsTarget,
                               bool IsOpaque) const {
  return DAG.getConstant(Val, DL, VT, IsTarget, IsOpaque);
}

/// } class CustomDAG
} // namespace llvm
