//===-- VECustomDAG.h - VE Custom DAG Nodes ------------*- C++ -*-===//
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

#ifndef LLVM_LIB_TARGET_VE_VECUSTOMDAG_H
#define LLVM_LIB_TARGET_VE_VECUSTOMDAG_H

#include "VE.h"
#include "VEISelLowering.h"
#include "llvm/CodeGen/SelectionDAG.h"
#include "llvm/CodeGen/TargetLowering.h"
#include <bitset>

namespace llvm {

// The predication/masking in a VVP/VEC SDNode consists in a bit mask (mask) and
// an active vector length (AVL). The AVL parameter only applies at 64bit
// element granularity. In packed mode that means groups of 2 x 32bit elements.
// These methods legalize AVL to refer to packs instead at the cost of
// additional masking code.
/// AVL Legalization {
struct TargetMasks {
  SDValue Mask;
  SDValue AVL;
  TargetMasks(SDValue Mask = SDValue(), SDValue AVL = SDValue())
      : Mask(Mask), AVL(AVL) {}
};

const unsigned SXRegSize = 64;

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
PosOpt getVVPOpcode(unsigned OpCode);

// TODO:
// 1. Perform splitting late to have a chance to preserve packable patterns
//    (PVRCP contraction).
// 2. Perform AVL,Mask legalization late to avoid clutter (partially legalized
//    AVL that will turn out not to be needed).
bool supportsPackedMode(unsigned Opcode, EVT IdiomVT);

bool isVVPOrVEC(unsigned Opcode);
bool isVVP(unsigned Opcode);

bool isVVPTernaryOp(unsigned Opcode);
bool isVVPBinaryOp(unsigned Opcode);
bool isVVPUnaryOp(unsigned Opcode);
bool isVVPConversionOp(unsigned VVPOC);
bool isVVPReductionOp(unsigned VVPOC);

// Whether the VVP reduction opcode has a start param.
bool hasVVPReductionStartParam(unsigned VVPROPC);

// Return the representative vector type of this operation.
Optional<EVT> getIdiomaticType(SDNode *Op);

Optional<unsigned> getVVPForVP(unsigned VPOC);

// Return the mask operand position for this VVP or VEC op.
Optional<int> getMaskPos(unsigned Opc);
SDValue getNodeMask(SDValue Op);

// Return the AVL operand position for this VVP or VEC op.
Optional<int> getAVLPos(unsigned Opc);
SDValue getNodeAVL(SDValue Op);

VecLenOpt minVectorLength(VecLenOpt A, VecLenOpt B);

// Split this packed type
EVT splitType(EVT);

// Whether direct codegen for this type will result in a packed operation
// (requiring a packed VL param..)
bool isPackedVectorType(EVT SomeVT);
bool isMaskType(EVT VT);
bool isPackedMaskType(EVT SomeVT);
bool isOverPackedType(EVT VT);

// whether this VVP operation has no mask argument
bool hasDeadMask(unsigned VVPOC);

bool isAllTrueMask(SDValue Op);
//// } VVP Machinery

unsigned getScalarReductionOpcode(unsigned VVPOC, bool IsMask);

PosOpt getVVPReductionStartParamPos(unsigned ISD);

Optional<unsigned> getReductionStartParamPos(unsigned ISD);

Optional<unsigned> getReductionVectorParamPos(unsigned ISD);

Optional<unsigned> peekForNarrow(SDValue Op);

unsigned getMaskBits(EVT Ty);

// select an appropriate %evl argument for this element count.
// This will return the correct result for packed mode oeprations (half).
unsigned selectBoundedVectorLength(unsigned StaticNumElems);

/// Packing {
using LaneBits = std::bitset<256>;

struct PackedLaneBits {
  LaneBits Bits[2];

  PackedLaneBits() {}

  PackedLaneBits(LaneBits &Lo, LaneBits &Hi) {
    Bits[0] = Lo;
    Bits[1] = Hi;
  }

  void reset() {
    Bits[0].reset();
    Bits[1].reset();
  }

  void flip() {
    Bits[0].flip();
    Bits[1].flip();
  }
  LaneBits &low() { return Bits[0]; }
  LaneBits &high() { return Bits[1]; }

  LaneBits::reference operator[](size_t pos) { return Bits[pos % 2][pos / 2]; }
  bool operator[](size_t pos) const { return Bits[pos % 2][pos / 2]; }
  size_t size() const { return 512; }
};

enum class Packing {
  Normal = 0, // 32/64bits per 64bit elements
  Dense = 1,  // packed mode
};

// Packed interpretation sub element
enum class PackElem : int8_t {
  Lo = 0, // integer (63, 32]
  Hi = 1  // float   (32,  0]
};

PackElem getPartForLane(unsigned ElemIdx);

PackElem getOtherPart(PackElem Part);

unsigned getOverPackedSubRegIdx(PackElem Part);

unsigned getPackedMaskSubRegIdx(PackElem Part);

MVT getMaskVT(Packing P);

PackElem getPackElemForVT(EVT VT);

// The subregister VT an unpack of part \p Elem from \p VT would source its
// result from.
MVT getUnpackSourceType(EVT VT, PackElem Elem);

Packing getPackingForVT(EVT VT);

template <typename MaskBits> Packing getPackingForMaskBits(const MaskBits MB);

// True, iff this is a VEC_UNPACK_LO/HI, VEC_SWAP or VEC_PACK.
bool isPackingSupportOpcode(unsigned Opcode);

bool isUnpackOp(unsigned OPC);

PackElem getPartForUnpackOpcode(unsigned OPC);

unsigned getUnpackOpcodeForPart(PackElem Part);

SDValue getUnpackPackOperand(SDValue N);

SDValue getUnpackAVL(SDValue N);

/// } Packing

/// Helper class for short hand custom node creation ///
struct VECustomDAG {
  const VELoweringInfo &VLI;
  SelectionDAG &DAG;
  SDLoc DL;

  SelectionDAG *getDAG() const { return &DAG; }

  VECustomDAG(const VELoweringInfo &VLI, SelectionDAG &DAG, SDLoc DL)
      : VLI(VLI), DAG(DAG), DL(DL) {}

  VECustomDAG(const VELoweringInfo &VLI, SelectionDAG &DAG, SDValue WhereOp)
      : VLI(VLI), DAG(DAG), DL(WhereOp) {}

  VECustomDAG(const VELoweringInfo &VLI, SelectionDAG &DAG, const SDNode *WhereN)
      : VLI(VLI), DAG(DAG), DL(WhereN) {}

  SDValue createSeq(EVT ResTy, Optional<SDValue> OpVectorLength) const;

  // create a vector element or scalar bitshift depending on the element type
  // \p ResVT will only be used in case any new node is created
  // dst[i] = src[i + Offset]
  SDValue createBitReverse(SDValue ScalarReg) const;
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
  SDValue createUnpack(EVT DestVT, SDValue Vec, PackElem E, SDValue AVL) const;

  SDValue createPack(EVT DestVT, SDValue LowV, SDValue HighV,
                     SDValue AVL) const;

  SDValue createSwap(EVT DestVT, SDValue V, SDValue AVL) const;
  /// } Packed Mode Support

  /// Mask Insert/Extract {
  SDValue createExtractMask(SDValue MaskV, SDValue IndexV) const;
  SDValue createInsertMask(SDValue MaskV, SDValue ElemV, SDValue IndexV) const;
  SDValue createMaskPopcount(SDValue MaskV, SDValue AVL) const;
  SDValue foldAndUnpackMask(SDValue MaskVector, SDValue Mask, PackElem Part,
                            SDValue AVL) const;
  /// } Mask Insert/Extract
  SDValue getBroadcast(EVT ResultVT, SDValue Scalar, SDValue AVL = SDValue()) const;

  // Extract an SX register from a mask
  SDValue createMaskExtract(SDValue MaskV, SDValue Idx) const;

  // Extract an SX register from a mask
  SDValue createMaskInsert(SDValue MaskV, SDValue Idx, SDValue ElemV) const;

  // all-true/false mask
  SDValue createUniformConstMask(Packing Packing, unsigned NumElements,
                                 bool IsTrue) const;
  SDValue createUniformConstMask(Packing Packing, bool IsTrue) const {
    return createUniformConstMask(
        Packing, Packing == Packing::Dense ? 512 : 256, IsTrue);
  }
  SDValue createUniformConstMask(EVT MaskVT, bool IsTrue) const {
    Packing Packing =
        MaskVT.getVectorNumElements() <= 256 ? Packing::Normal : Packing::Dense;
    return createUniformConstMask(Packing, MaskVT.getVectorNumElements(),
                                  IsTrue);
  }
  // materialize a constant mask vector given by \p TrueBits
  template <typename MaskBitsType>
  SDValue createConstMask(unsigned NumElems,
                          const MaskBitsType &TrueBits) const;

  template <typename MaskBitsType>
  SDValue createConstMask(EVT MaskVT, const MaskBitsType &TrueBits) const {
    return createConstMask(MaskVT.getVectorNumElements(), TrueBits);
  }

  // OnTrueV[l] if l < PivotV && Mask[l] else OnFalseV[l]
  SDValue createSelect(EVT ResVT, SDValue OnTrueV, SDValue OnFalseV,
                       SDValue MaskV, SDValue PivotV) const;

  /// getNode {
  SDValue getNode(unsigned OC, SDVTList VTL, ArrayRef<SDValue> OpV,
                  Optional<SDNodeFlags> Flags = None) const {
    auto N = DAG.getNode(OC, DL, VTL, OpV);
    if (Flags)
      N->setFlags(*Flags);
    return N;
  }

  SDValue getNode(unsigned OC, ArrayRef<EVT> ResVT, ArrayRef<SDValue> OpV,
                  Optional<SDNodeFlags> Flags = None) const {
    auto N = DAG.getNode(OC, DL, ResVT, OpV);
    if (Flags)
      N->setFlags(*Flags);
    return N;
  }

  SDValue getNode(unsigned OC, EVT ResVT, ArrayRef<SDValue> OpV,
                  Optional<SDNodeFlags> Flags = None) const {
    auto N = DAG.getNode(OC, DL, ResVT, OpV);
    if (Flags)
      N->setFlags(*Flags);
    return N;
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

  // return a valid AVL for this packing and element count
  inline SDValue getConstEVL(Packing P, uint32_t EVL) const {
    return getConstant(P == Packing::Normal ? EVL : (EVL + 1) / 2, MVT::i32);
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

  // create a VEC_TOMASK node if VectorV is not a mask already
  SDValue createMaskCast(SDValue VectorV, SDValue AVL) const;

  SDValue getSetCC(SDValue LHS, EVT VT, SDValue RHS, ISD::CondCode CC) const {
    return DAG.getSetCC(DL, VT, LHS, RHS, CC);
  }

  void dumpValue(SDValue V) const;

  SDValue getRootOrEntryChain() const {
    SDValue RootChain = DAG.getRoot();
    if (!RootChain)
      return DAG.getEntryNode();
    return RootChain;
  }

  // weave in a chain into the current root
  void weaveIntoRootChain(std::function<SDValue()> Func) const {
    SDValue OutChain = Func();
    assert(OutChain.getValueType() == MVT::Other); // not a chain!
    DAG.setRoot(getTokenFactor({getRootOrEntryChain(), OutChain}));
  }

  SDValue getTokenFactor(ArrayRef<SDValue> Tokens) const;

  const DataLayout &getDataLayout() const { return DAG.getDataLayout(); }

  // Return a legal vector type for \p Op
  EVT legalizeVectorType(SDValue Op, VVPExpansionMode) const;

  /// VVP {
  SDValue getVVPLoad(EVT LegalResVT, SDValue Chain, SDValue PtrV,
                     SDValue StrideV, SDValue MaskV, SDValue AVL) const;

  SDValue getVVPStore(SDValue Chain, SDValue DataV, SDValue PtrV,
                      SDValue StrideV, SDValue MaskV, SDValue AVL) const;

  SDValue getVVPGather(EVT LegalResVT, SDValue Chain, SDValue PtrVecV,
                       SDValue MaskV, SDValue AVL) const;
  SDValue getVVPScatter(SDValue Chain, SDValue DataV, SDValue PtrVecV,
                       SDValue MaskV, SDValue AVL) const;
  /// } VVP

  EVT splitVectorType(EVT OldValVT) const {
    if (!OldValVT.isVector())
      return OldValVT;
    return getVectorVT(OldValVT.getVectorElementType(), StandardVectorWidth);
  }

  SDValue extractPackElem(SDValue Op, PackElem Part, SDValue AVL) const;

  SDValue createIDIV(bool IsSigned, EVT ResVT, SDValue Dividend,
                     SDValue Divisor, SDValue Mask, SDValue AVL) const;
  SDValue createIREM(bool IsSigned, EVT ResVT, SDValue Dividend,
                     SDValue Divisor, SDValue Mask, SDValue AVL) const;

  // Create this binary operator, expanding it on the fly.
  SDValue getLegalBinaryOpVVP(unsigned VVPOpcode, EVT ResVT, SDValue A,
                              SDValue B, SDValue Mask, SDValue AVL,
                              SDNodeFlags Flags = SDNodeFlags()) const;
  // Note: StartV can be SDValue()
  SDValue getLegalReductionOpVVP(unsigned VVPOpcode, EVT ResVT, SDValue StartV, SDValue VectorV,
                                 SDValue Mask, SDValue AVL,
                                 SDNodeFlags Flags = SDNodeFlags()) const;
  SDValue getLegalConvOpVVP(unsigned VVPOpcode, EVT ResVT, SDValue VectorV,
                            SDValue Mask, SDValue AVL,
                            SDNodeFlags Flags = SDNodeFlags()) const;

  SDValue getLegalOpVVP(unsigned VVPOpcode, EVT ResVT, ArrayRef<SDValue> Ops,
                        SDNodeFlags Flags = SDNodeFlags()) const {
    if (isVVPConversionOp(VVPOpcode))
      return getLegalConvOpVVP(VVPOpcode, ResVT, Ops[0], Ops[1], Ops[2], Flags);
    if (isVVPReductionOp(VVPOpcode)) {
      // FIXME: Uses implicit structure knowlegdge of reductions with start
      // being (Start, Vector, Mask, AVL) == 4 operands.
      bool HasStartV = (Ops.size() == 4);
      if (HasStartV)
        return getLegalReductionOpVVP(VVPOpcode, ResVT, Ops[0], Ops[1], Ops[2],
                                      Ops[3], Flags);
      else
        return getLegalReductionOpVVP(VVPOpcode, ResVT, SDValue(), Ops[0],
                                      Ops[1], Ops[2], Flags);
    }
    if (isVVPBinaryOp(VVPOpcode))
      return getLegalBinaryOpVVP(VVPOpcode, ResVT, Ops[0], Ops[1], Ops[2],
                                 Ops[3], Flags);
    return getNode(VVPOpcode, ResVT, Ops, Flags);
  }

  // Infer mask & AVL for this VVP op.
  TargetMasks createTargetMask(VVPWideningInfo, SDValue RawMask,
                               SDValue RawAVL) const;
  // Infer mask & AVL for this split VVP op
  TargetMasks createTargetSplitMask(VVPWideningInfo WidenInfo, SDValue RawMask,
                                    SDValue RawAVL, PackElem Part) const;

  SDValue createConstantTargetMask(VVPWideningInfo WidenInfo) const;

  // Create a legalize AVL value for \p WidenInfo.
  SDValue createTargetAVL(VVPWideningInfo WidenInfo) const;
  /// } AVL Legalization

  // Infer the shortest possible AVL from the provided information.
  SDValue inferAVL(SDValue AVL, SDValue Mask, EVT IdiomVT) const;

  LLVMContext &getContext() { return *DAG.getContext(); }

  SDValue getImplicitDef(EVT VT) const {
    return SDValue(DAG.getMachineNode(TargetOpcode::IMPLICIT_DEF, DL, VT), 0);
  }

  SDValue getTargetInsertSubreg(int SRIdx, EVT VT, SDValue Operand,
                                SDValue SubReg) const;

  SDValue getZExtInReg(SDValue Op, EVT) const;

  raw_ostream &print(raw_ostream &, SDValue) const;
  void dump(SDValue) const;
};

} // namespace llvm

#endif // LLVM_LIB_TARGET_VE_VECUSTOMDAG_H
