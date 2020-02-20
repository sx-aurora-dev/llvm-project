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

#ifndef LLVM_LIB_TARGET_VE_CUSTOMDAG_H
#define LLVM_LIB_TARGET_VE_CUSTOMDAG_H

#include "VE.h"
#include "llvm/CodeGen/TargetLowering.h"
#include "VEISelLowering.h"
#include "llvm/CodeGen/SelectionDAG.h"

#ifndef DEBUG_TYPE
#define DEBUG_TYPE "customdag"
#endif

namespace llvm {
class VESubtarget;

enum class BVMaskKind : int8_t {
  Unknown,  // could not infer mask pattern
  Interval, //  interval of all-ones
};

static BVMaskKind AnalyzeBuildVectorMask(BuildVectorSDNode *BVN,
                                         unsigned &FirstOne, unsigned &FirstZero,
                                         unsigned &NumElements) {
  bool HasFirstOne = false, HasFirstZero = false;
  FirstOne = 0;
  FirstZero = 0;
  NumElements = 0;

  // this matches a 0*1*0* pattern (BVMaskKind::Interval)
  for (unsigned i = 0; i < BVN->getNumOperands(); ++i) {
    auto Elem = BVN->getOperand(i);
    if (Elem->isUndef()) continue;
    ++NumElements;
    auto CE = dyn_cast<ConstantSDNode>(Elem);
    if (!CE) return BVMaskKind::Unknown;
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

/// Broadcast, Shuffle, Mask Analysis {
enum class BVKind : int8_t {
  Unknown, // could not infer pattern
  AllUndef, // all lanes undef
  Broadcast, // broadcast 
  Seq,        // (0, .., 255) Sequence 
  SeqBlock,  // (0, .., 15) ^ 16
  BlockSeq,  // 0^16, 1^16, 2^16
};

static BVKind AnalyzeBuildVector(BuildVectorSDNode *BVN, unsigned &FirstDef,
                                 unsigned &LastDef, int64_t &Stride,
                                 unsigned &BlockLength, unsigned &NumElements) {
  // Check UNDEF or FirstDef
  NumElements = 0;
  bool AllUndef = true;
  FirstDef = 0;
  LastDef = 0;
  for (unsigned i = 0; i < BVN->getNumOperands(); ++i) {
    if (BVN->getOperand(i).isUndef()) continue;
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
  if (IsBroadcast) return BVKind::Broadcast;


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

  if (hasConstantStride) return BVKind::Seq;
  if (hasBlockStride) return BVKind::BlockSeq;
  if (hasBlockStride2) return BVKind::SeqBlock;
  return BVKind::Unknown;
}

/// } Broadcast, Shuffle, Mask Analysis

//// VVP Machinery {
// VVP property queries
static Optional<unsigned> GetVVPOpcode(unsigned OpCode) {
  switch (OpCode) {
  case ISD:: SCALAR_TO_VECTOR: return VEISD::VEC_BROADCAST;

  default:
    return None;
#define REGISTER_VVP_OP(VVP_NAME,NATIVE_ISD)                                    \
  case ISD:: NATIVE_ISD: return VEISD::VVP_NAME;
#include "VVPNodes.inc"
  }
}

static bool SupportsPackedMode(unsigned Opcode) {
  switch (Opcode) {
  default:
    return false;

#define REGISTER_PACKED(VVP_NAME) case VEISD:: VVP_NAME: return true;
#include "VVPNodes.inc"
  }
}

static bool IsVVP(unsigned Opcode) {
  switch (Opcode) {
  default:
    return false;
#define ADD_VVP_OP(VVP_NAME) case VEISD::VVP_NAME: return true;
#include "VVPNodes.inc"
  }
}

// Choses the widest element type
static EVT getFPConvType(SDNode *Op) {
  EVT ResVT = Op->getValueType(0);
  EVT OpVT = Op->getOperand(0).getValueType();
  return ResVT.getStoreSizeInBits() > OpVT.getStoreSizeInBits() ? ResVT : OpVT;
}

static Optional<EVT> getIdiomaticType(SDNode* Op) {
  auto MemN = dyn_cast<MemSDNode>(Op);
  if (MemN) {
    return MemN->getMemoryVT();
  }

  switch (Op->getOpcode()) {
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
#define REGISTER_UNNARY_VVP_OP(VVP_NAME, NATIVE_ISD)  case VEISD::VVP_NAME: case ISD::NATIVE_ISD:
#define REGISTER_BINARY_VVP_OP(VVP_NAME, NATIVE_ISD)  case VEISD::VVP_NAME: case ISD::NATIVE_ISD:
#define REGISTER_TERNARY_VVP_OP(VVP_NAME, NATIVE_ISD) case VEISD::VVP_NAME: case ISD::NATIVE_ISD:
#include "VVPNodes.inc"
    return Op->getValueType(0);

#define REGISTER_FPCONV_VVP_OP(VVP_NAME, NATIVE_ISD) case VEISD::VVP_NAME: case ISD::NATIVE_ISD:
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

static
VecLenOpt
MinVectorLength(VecLenOpt A, VecLenOpt B) {
  if (!A) return B;
  if (!B) return A;
  return std::min<unsigned>(A.getValue(), B.getValue());
}

// Whether direct codegen for this type will result in a packed operation
// (requiring a packed VL param..)
static
bool
IsPackedType(EVT SomeVT) {
  if (!SomeVT.isVector()) return false;
  return SomeVT.getVectorNumElements() > StandardVectorWidth;
}

// legalize packed-mode broadcasts into lane replication + broadcast
static SDValue
LegalizeBroadcast(SDValue Op, SelectionDAG & DAG) {
  if (Op.getOpcode() != VEISD::VEC_BROADCAST) return Op;

  EVT VT = Op.getValueType();
  if (!IsPackedType(VT)) {
    // i/f64 -> v256i64 broadcast (matched)
    return Op;
  }

  // This is a packed broadcast.
  // replicate the scalar sub reg (f32 or i32) onto the opposing half of the
  // scalar reg and feed it into a I64 -> v256i64 broadcast.
  SDLoc DL(Op);

  auto ScaOp = Op.getOperand(0);
  auto ScaTy = ScaOp->getValueType(0);
  unsigned ReplOC; 
  if (ScaTy == MVT::f32) {
    ReplOC = VEISD::REPL_F32;
  } else if (ScaTy == MVT::i32) {
    ReplOC = VEISD::REPL_I32;
  } else {
    assert(ScaTy == MVT::i64);
    return Op;
  }
  LLVM_DEBUG(dbgs() << "Broadcast legalization\n");


  auto ReplOp = DAG.getNode(ReplOC, DL, MVT::i64, ScaOp);
  // auto LegalVecTy = MVT::getVectorVT(MVT::i64, Ty.getVectorNumElements());
  return DAG.getNode(VEISD::VEC_BROADCAST, DL, VT, {ReplOp, Op.getOperand(1)});
}

static SDValue
LegalizeVecOperand(SDValue Op, SelectionDAG & DAG) {
  if (!Op.getValueType().isVector()) return Op;

  // TODO add operand legalization
  return LegalizeBroadcast(Op, DAG);
}

// whether this VVP operation has no mask argument
static bool
HasDeadMask(unsigned VVPOC) {
  switch (VVPOC) {
    default:
      return false;

    case VEISD::VVP_LOAD:
      return true;
  }
}

static VecLenOpt
InferLengthFromMask(SDValue MaskV) {
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

static SDValue ReduceVectorLength(SDValue Mask, SDValue DynamicVL, VecLenOpt VLHint,
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

//// } VVP Machinery

static Optional<unsigned> PeekForNarrow(SDValue Op) {
  if (!Op.getValueType().isVector()) return None;
  if (Op->use_size() != 1)
    return None;
  auto OnlyN = *Op->use_begin();
  if (OnlyN->getOpcode() != VEISD::VEC_NARROW)
    return None;
  return cast<ConstantSDNode>(OnlyN->getOperand(1))->getZExtValue();
}

static Optional<SDValue>
EVLToVal(VecLenOpt Opt, SDLoc &DL, SelectionDAG& DAG) {
  if (!Opt) return None;
  return DAG.getConstant(Opt.getValue(), DL, MVT::i32);
}

static bool IsMaskType(EVT Ty) {
  if (!Ty.isVector()) return false;
  return Ty.getVectorElementType() == MVT::i1;
}

// select an appropriate %evl argument for this element count.
// This will return the correct result for packed mode oeprations (half).
static unsigned
SelectBoundedVectorLength(unsigned StaticNumElems) {
    if (StaticNumElems > StandardVectorWidth) {
      return (StaticNumElems + 1) / 2;
    }
    return StaticNumElems;
}


// Packed interpretation sub element
enum class SubElem : int8_t {
  Lo = 0,
  Hi = 1
};

/// Helper class for short hand custom node creation ///
struct CustomDAG {
  SelectionDAG & DAG;
  SDLoc DL;

  CustomDAG(SelectionDAG & DAG, SDLoc DL)
  : DAG(DAG), DL(DL)
  {}

  CustomDAG(SelectionDAG & DAG, SDValue WhereOp)
  : DAG(DAG), DL(WhereOp)
  {}

  CustomDAG(SelectionDAG & DAG, SDNode* WhereN)
  : DAG(DAG), DL(WhereN)
  {}

  SDValue
  CreateSeq(EVT ResTy, Optional<SDValue> OpVectorLength) const {
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
  CreateUnpack(EVT DestVT, SDValue Vec, SubElem E) {
    abort(); // TODO implement
  }
  
  SDValue
  CreatePack(EVT DestVT, SDValue LowV, SDValue HighV) {
    abort(); // TODO implement
  }
  
  SDValue
  CreateSwap(EVT DestVT, SDValue V) {
    abort(); // TODO implement
  }

  SDValue CreateBroadcast(EVT ResTy, SDValue S,
                          Optional<SDValue> OpVectorLength = None) const {

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
      return LegalizeBroadcast(DAG.getNode(VEISD::VEC_BROADCAST, DL, ResTy, {S, VectorLen}), DAG);
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
    SDValue ZeroVec = CreateBroadcast(CmpVecTy,
                                      {DAG.getConstant(0, DL, BoolTy)}, VectorLen);
  
    MVT BoolVecTy = MVT::getVectorVT(MVT::i1, ElemCount);
  
    // broadcast(Data) != broadcast(0)
    return DAG.getSetCC(DL, BoolVecTy, BCVec, ZeroVec, ISD::CondCode::SETNE);
  }

  // Extract an SX register from a mask
  SDValue
  createMaskExtract(SDValue MaskV, SDValue Idx) {
    return DAG.getNode(VEISD::VM_EXTRACT, DL, MVT::i64, {MaskV, Idx});
  }

  // Extract an SX register from a mask
  SDValue
  createMaskInsert(SDValue MaskV, SDValue Idx, SDValue ElemV) {
    return DAG.getNode(VEISD::VM_INSERT, DL, MaskV.getValueType(), {MaskV, Idx, ElemV});
  }

  SDValue
  CreateConstMask(unsigned NumElements, bool IsTrue) const {
    auto MaskVT = MVT::getVectorVT(MVT::i1, NumElements);

    // VEISelDAGtoDAG will replace this with the constant-true VM
    auto TrueVal = DAG.getConstant(-1, DL, MVT::i32);
    auto ElemCountN = DAG.getConstant(NumElements, DL, MVT::i32);

    auto Res =
        DAG.getNode(VEISD::VEC_BROADCAST, DL, MaskVT, {TrueVal, ElemCountN});
    if (IsTrue) return Res;

    // negate
    return DAG.getNOT(DL, Res, Res.getValueType());
  }

  SDValue getConstant(uint64_t Val, EVT VT, bool IsTarget = false,
                         bool IsOpaque = false) const {
    return DAG.getConstant(Val, DL, VT, IsTarget, IsOpaque);
  }
};

}  // namespace llvm

#endif // LLVM_LIB_TARGET_VE_CUSTOMDAG_H
