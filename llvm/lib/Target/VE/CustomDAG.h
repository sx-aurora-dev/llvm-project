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
#include "VEISelLowering.h"
#include "llvm/CodeGen/SelectionDAG.h"
#include "llvm/CodeGen/TargetLowering.h"
#include <bitset>

namespace llvm {

const unsigned SXRegSize = 64;

using LaneBits = std::bitset<256>;

/// Helpers {
template <typename ElemT> ElemT &ref_to(std::unique_ptr<ElemT> &UP) {
  return *(UP.get());
}
/// } Helpers

class VESubtarget;

using PosOpt = Optional<unsigned>;

/// } Broadcast, Shuffle, Mask Analysis

//// VVP Machinery {
// VVP property queries
PosOpt GetVVPOpcode(unsigned OpCode);

bool SupportsPackedMode(unsigned Opcode);

bool IsVVPOrVEC(unsigned Opcode);
bool IsVVP(unsigned Opcode);

// Choses the widest element type
EVT getFPConvType(SDNode *Op);

Optional<EVT> getIdiomaticType(SDNode *Op);

VecLenOpt MinVectorLength(VecLenOpt A, VecLenOpt B);

// Whether direct codegen for this type will result in a packed operation
// (requiring a packed VL param..)
bool IsPackedType(EVT SomeVT);

// legalize packed-mode broadcasts into lane replication + broadcast
SDValue LegalizeBroadcast(SDValue Op, SelectionDAG &DAG);

SDValue LegalizeVecOperand(SDValue Op, SelectionDAG &DAG);

// whether this VVP operation has no mask argument
bool HasDeadMask(unsigned VVPOC);

//// } VVP Machinery

Optional<unsigned> getReductionStartParamPos(unsigned ISD);

Optional<unsigned> getReductionVectorParamPos(unsigned ISD);

Optional<unsigned> PeekForNarrow(SDValue Op);

Optional<SDValue> EVLToVal(VecLenOpt Opt, SDLoc &DL, SelectionDAG &DAG);

bool IsMaskType(EVT Ty);
unsigned GetMaskBits(EVT Ty);

// select an appropriate %evl argument for this element count.
// This will return the correct result for packed mode oeprations (half).
unsigned SelectBoundedVectorLength(unsigned StaticNumElems);

// Packed interpretation sub element
enum class SubElem : int8_t {
  Lo = 0, // integer (63, 32]
  Hi = 1  // float   (32,  0]
};

/// Helper class for short hand custom node creation ///
struct CustomDAG {
  SelectionDAG &DAG;
  SDLoc DL;

  CustomDAG(SelectionDAG &DAG, SDLoc DL) : DAG(DAG), DL(DL) {}

  CustomDAG(SelectionDAG &DAG, SDValue WhereOp) : DAG(DAG), DL(WhereOp) {}

  CustomDAG(SelectionDAG &DAG, SDNode *WhereN) : DAG(DAG), DL(WhereN) {}

  SDValue CreateSeq(EVT ResTy, Optional<SDValue> OpVectorLength) const;

  // create a vector element or scalar bitshift depending on the element type
  // \p ResVT will only be used in case any new node is created
  // dst[i] = src[i + Offset]
  SDValue createElementShift(EVT ResVT, SDValue Src, int Offset,
                             SDValue AVL) const;
  SDValue createScalarShift(EVT ResVT, SDValue Src, int Offset) const;

  SDValue createVMV(EVT ResVT, SDValue SrcV, SDValue OffsetV, SDValue Mask,
                    SDValue Avl) const;
  SDValue createPassthruVMV(EVT ResVT, SDValue SrcV, SDValue OffsetV,
                            SDValue Mask, SDValue PassthruV, SDValue Avl) const;

  SDValue getTargetExtractSubreg(MVT SubRegVT, int SubRegIdx,
                                 SDValue RegV) const;

  /// Packed Mode Support {
  SDValue CreateUnpack(EVT DestVT, SDValue Vec, SubElem E, SDValue AVL);

  SDValue CreatePack(EVT DestVT, SDValue LowV, SDValue HighV, SDValue AVL);

  SDValue CreateSwap(EVT DestVT, SDValue V, SDValue AVL);
  /// } Packed Mode Support

  /// Mask Insert/Extract {
  SDValue CreateExtractMask(SDValue MaskV, SDValue IndexV) const;
  SDValue CreateInsertMask(SDValue MaskV, SDValue ElemV, SDValue IndexV) const;
  /// } Mask Insert/Extract

  SDValue CreateBroadcast(EVT ResTy, SDValue S,
                          Optional<SDValue> OpVectorLength = None) const;

  // Extract an SX register from a mask
  SDValue createMaskExtract(SDValue MaskV, SDValue Idx) const;

  // Extract an SX register from a mask
  SDValue createMaskInsert(SDValue MaskV, SDValue Idx, SDValue ElemV) const;

  // all-true/false mask
  SDValue createUniformConstMask(unsigned NumElements, bool IsTrue) const;
  SDValue createUniformConstMask(EVT MaskVT, bool IsTrue) const {
    return createUniformConstMask(MaskVT.getVectorNumElements(), IsTrue);
  }
  // materialize a constant mask vector given by \p TrueBits
  SDValue createConstMask(unsigned NumElems, const LaneBits &TrueBits) const;

  SDValue createConstMask(EVT MaskVT, const LaneBits &TrueBits) const {
    return createConstMask(MaskVT.getVectorNumElements(), TrueBits);
  }

  // OnTrueV[l] if l < PivotV && Mask[l] else OnFalseV[l]
  SDValue createSelect(SDValue OnTrueV, SDValue OnFalseV, SDValue MaskV,
                       SDValue PivotV) const;

  /// getNode {
  SDValue getNode(unsigned OC, SDVTList VTL, ArrayRef<SDValue> OpV) const {
    return DAG.getNode(OC, DL, VTL, OpV);
  }

  SDValue getNode(unsigned OC, ArrayRef<EVT> ResVT,
                  ArrayRef<SDValue> OpV) const {
    return DAG.getNode(OC, DL, ResVT, OpV);
  }

  SDValue getNode(unsigned OC, EVT ResVT, ArrayRef<SDValue> OpV) const {
    return DAG.getNode(OC, DL, ResVT, OpV);
  }
  /// } getNode

  SDValue getVectorExtract(SDValue VecV, unsigned Idx) const {
    return getVectorExtract(VecV, getConstant(Idx, MVT::i32));
  }
  SDValue getVectorExtract(SDValue VecV, SDValue IdxV) const;
  SDValue getVectorInsert(SDValue DestVecV, SDValue ElemV, unsigned Idx) const {
    return getVectorInsert(DestVecV, ElemV, getConstant(Idx, MVT::i32));
  }
  SDValue getVectorInsert(SDValue DestVecV, SDValue ElemV, SDValue IdxV) const;

  SDValue widenOrNarrow(EVT DestVT, SDValue Op) {
    EVT OpVT = Op.getValueType();
    if (OpVT == DestVT)
      return Op;

    if (!OpVT.isVector())
      return Op;

    return createNarrow(DestVT, Op, OpVT.getVectorNumElements());
  }

  SDValue createNarrow(EVT ResTy, SDValue SrcV, uint64_t NarrowLen) {
    return DAG.getNode(VEISD::VEC_NARROW, DL, ResTy,
                       {SrcV, getConstant(NarrowLen, MVT::i32)});
  }

  EVT getVectorVT(EVT ElemVT, unsigned NumElems) const {
    return EVT::getVectorVT(*DAG.getContext(), ElemVT, NumElems);
  }
  inline SDValue getConstEVL(uint32_t EVL) const {
    return getConstant(EVL, MVT::i32);
  }

  SDValue getConstant(uint64_t Val, EVT VT, bool IsTarget = false,
                      bool IsOpaque = false) const;

  SDValue getUndef(EVT VT) const { return DAG.getUNDEF(VT); }

  SDValue getMergeValues(ArrayRef<SDValue> Values) const {
    return DAG.getMergeValues(Values, DL);
  }

  SDValue createNot(SDValue Op, EVT ResVT) const {
    return DAG.getNOT(DL, Op, ResVT);
  }

  EVT getMaskVTFor(SDValue VectorV) const {
    return getVectorVT(MVT::i1, VectorV.getValueType().getVectorNumElements());
  }

  SDValue createMaskCast(SDValue VectorV, SDValue AVL) const {
    return DAG.getNode(VEISD::VEC_TOMASK, DL, getMaskVTFor(VectorV),
                       {VectorV, AVL});
  }

  void dumpValue(SDValue V) const;
};

} // namespace llvm

#endif // LLVM_LIB_TARGET_VE_CUSTOMDAG_H
