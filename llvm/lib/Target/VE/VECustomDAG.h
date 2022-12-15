//===------------ VECustomDAG.h - VE Custom DAG Nodes -----------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file defines the helper functions that VE uses to lower LLVM code into a
// selection DAG.  For example, hiding SDLoc, and easy to use SDNodeFlags.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_VE_VECUSTOMDAG_H
#define LLVM_LIB_TARGET_VE_VECUSTOMDAG_H

#include "VE.h"
#include "VEISelLowering.h"
#include "llvm/CodeGen/SelectionDAG.h"
#include "llvm/CodeGen/TargetLowering.h"
#include <bitset>
#include <optional>

namespace llvm {

// The predication/masking in a VVP/VEC SDNode consists in a bit mask (mask) and
// an active vector length (AVL). The AVL parameter only applies at 64bit
// element granularity. In packed mode that means groups of 2 x 32bit elements.
// These methods legalize AVL to refer to packs instead at the cost of
// additional masking code.
/// AVL Legalization {
struct VETargetMasks {
  SDValue Mask;
  SDValue AVL;
  VETargetMasks(SDValue Mask = SDValue(), SDValue AVL = SDValue())
      : Mask(Mask), AVL(AVL) {}
};

const unsigned SXRegSize = 64;

/// Helpers {
template <typename ElemT> ElemT &ref_to(std::unique_ptr<ElemT> &UP) {
  return *(UP.get());
}
/// } Helpers

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

using PosOpt = std::optional<unsigned>;

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
bool isVVPConversionOp(unsigned Opcode);
bool isVVPReductionOp(unsigned Opcode);

MVT splitVectorType(MVT VT);
EVT splitType(LLVMContext &Ctx, EVT PackedVT, PackElem P);

// Whether the VVP reduction opcode has a start param.
bool hasVVPReductionStartParam(unsigned VVPROPC);

// Return the representative vector type of this operation.
std::optional<EVT> getIdiomaticType(SDNode *Op);

std::optional<unsigned> getVVPForVP(unsigned VPOC);

// Return the mask operand position for this VVP/VEC or standard SDNode.
// Note that this will return the v.i1 operand also for vp_select and vp_merge,
// which do not report their selection mask as mask operands in the vp sense.
std::optional<int> getMaskPos(unsigned Opc);
SDValue getNodeMask(SDValue Op);

// Return the AVL operand position for this VVP or VEC op.
std::optional<int> getAVLPos(unsigned Opc);
SDValue getNodeAVL(SDValue Op);

VecLenOpt minVectorLength(VecLenOpt A, VecLenOpt B);

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

std::optional<unsigned> getReductionStartParamPos(unsigned ISD);

std::optional<unsigned> getReductionVectorParamPos(unsigned ISD);

std::optional<unsigned> peekForNarrow(SDValue Op);

unsigned getMaskBits(EVT Ty);

// select an appropriate %evl argument for this element count.
// This will return the correct result for packed mode oeprations (half).
unsigned selectBoundedVectorLength(unsigned StaticNumElems);

bool isMaskType(EVT SomeVT);

bool isMaskArithmetic(SDValue Op);

bool isVVPOrVEC(unsigned);

bool supportsPackedMode(unsigned Opcode, EVT IdiomVT);

bool isPackingSupportOpcode(unsigned Opc);

bool maySafelyIgnoreMask(unsigned Opc);

/// The VE backend uses a two-staged process to lower and legalize vector
/// instructions:
//
/// 1. VP and standard vector SDNodes are lowered to SDNodes of the VVP_* layer.
//
//     All VVP nodes have a mask and an Active Vector Length (AVL) parameter.
//     The AVL parameters refers to the element position in the vector the VVP
//     node operates on.
//
//
//  2. The VVP SDNodes are legalized. The AVL in a legal VVP node refers to
//     chunks of 64bit. We track this by wrapping the AVL in a LEGALAVL node.
//
//     The AVL mechanism in the VE architecture always refers to chunks of
//     64bit, regardless of the actual element type vector instructions are
//     operating on. For vector types v256.32 or v256.64 nothing needs to be
//     legalized since each element occupies a 64bit chunk - there is no
//     difference between counting 64bit chunks or element positions. However,
//     all vector types with > 256 elements store more than one logical element
//     per 64bit chunk and need to be transformed.
//     However legalization is performed, the resulting legal VVP SDNodes will
//     have a LEGALAVL node as their AVL operand. The LEGALAVL nodes wraps
//     around an AVL that refers to 64 bit chunks just as the architecture
//     demands - that is, the wrapped AVL is the correct setting for the VL
//     register for this VVP operation to get the desired behavior.
//
/// AVL Functions {
// The AVL operand position of this node.
std::optional<int> getAVLPos(unsigned);

// Whether this is a LEGALAVL node.
bool isLegalAVL(SDValue AVL);

// The AVL operand of this node.
SDValue getNodeAVL(SDValue);

// Mask position of this node.
std::optional<int> getMaskPos(unsigned);

SDValue getNodeMask(SDValue);

// Return the AVL operand of this node. If it is a LEGALAVL node, unwrap it.
// Return with the boolean whether unwrapping happened.
std::pair<SDValue, bool> getAnnotatedNodeAVL(SDValue);

/// } AVL Functions

/// Node Properties {

std::optional<EVT> getIdiomaticVectorType(SDNode *Op);

SDValue getLoadStoreStride(SDValue Op, VECustomDAG &CDAG);

SDValue getMemoryPtr(SDValue Op);

SDValue getNodeChain(SDValue Op);

SDValue getStoredValue(SDValue Op);

SDValue getNodePassthru(SDValue Op);

SDValue getGatherScatterIndex(SDValue Op);

SDValue getGatherScatterScale(SDValue Op);

unsigned getScalarReductionOpcode(unsigned VVPOC, bool IsMask);

// Whether this VP_REDUCE_*/ VECREDUCE_*/VVP_REDUCE_* SDNode has a start
// parameter.
bool hasReductionStartParam(unsigned VVPOC);

/// } Node Properties

// Get the vector or mask register type for this packing and element type.
MVT getLegalVectorType(Packing P, MVT ElemVT);

// Whether this type belongs to a packed mask or vector register.
Packing getTypePacking(EVT);

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

  VECustomDAG(const VELoweringInfo &VLI, SelectionDAG &DAG,
              const SDNode *WhereN)
      : VLI(VLI), DAG(DAG), DL(WhereN) {}

  SDValue getSeq(EVT ResTy, std::optional<SDValue> OpVectorLength) const;

  // create a vector element or scalar bitshift depending on the element type
  // \p ResVT will only be used in case any new node is created
  // dst[i] = src[i + Offset]
  SDValue getBitReverse(SDValue ScalarReg) const;
  SDValue getElementShift(EVT ResVT, SDValue Src, int Offset,
                          SDValue AVL) const;
  SDValue getScalarShift(EVT ResVT, SDValue Src, int Offset) const;

  SDValue getVMV(EVT ResVT, SDValue SrcV, SDValue OffsetV, SDValue Mask,
                 SDValue Avl) const;
  SDValue getPassthruVMV(EVT ResVT, SDValue SrcV, SDValue OffsetV, SDValue Mask,
                         SDValue PassthruV, SDValue Avl) const;

  SDValue getTargetExtractSubreg(MVT SubRegVT, int SubRegIdx,
                                 SDValue RegV) const;

  /// Mask Insert/Extract {
  SDValue getExtractMask(SDValue MaskV, SDValue IndexV) const;
  SDValue getInsertMask(SDValue MaskV, SDValue ElemV, SDValue IndexV) const;
  SDValue getMaskPopcount(SDValue MaskV, SDValue AVL) const;
  SDValue foldAndUnpackMask(SDValue MaskVector, SDValue Mask, PackElem Part,
                            SDValue AVL) const;
  /// } Mask Insert/Extract

  // Extract an SX register from a mask
  SDValue getMaskExtract(SDValue MaskV, SDValue Idx) const;

  // Extract an SX register from a mask
  SDValue getMaskInsert(SDValue MaskV, SDValue Idx, SDValue ElemV) const;

  // all-true/false mask
  SDValue getUniformConstMask(Packing Packing, unsigned NumElements,
                              bool IsTrue) const;
  SDValue getUniformConstMask(Packing Packing, bool IsTrue) const {
    return getUniformConstMask(Packing, Packing == Packing::Dense ? 512 : 256,
                               IsTrue);
  }
  SDValue getUniformConstMask(EVT MaskVT, bool IsTrue) const {
    Packing Packing =
        MaskVT.getVectorNumElements() <= 256 ? Packing::Normal : Packing::Dense;
    return getUniformConstMask(Packing, MaskVT.getVectorNumElements(), IsTrue);
  }
  // materialize a constant mask vector given by \p TrueBits
  template <typename MaskBitsType>
  SDValue getConstMask(unsigned NumElems, const MaskBitsType &TrueBits) const;

  template <typename MaskBitsType>
  SDValue getConstMask(EVT MaskVT, const MaskBitsType &TrueBits) const {
    return getConstMask(MaskVT.getVectorNumElements(), TrueBits);
  }

  // OnTrueV[l] if l < PivotV && Mask[l] else OnFalseV[l]
  SDValue getSelect(EVT ResVT, SDValue OnTrueV, SDValue OnFalseV, SDValue MaskV,
                    SDValue PivotV) const;

  /// getNode {
  SDValue getNode(unsigned OC, SDVTList VTL, ArrayRef<SDValue> OpV,
                  std::optional<SDNodeFlags> Flags = std::nullopt) const {
    auto N = DAG.getNode(OC, DL, VTL, OpV);
    if (Flags)
      N->setFlags(*Flags);
    return N;
  }

  SDValue getNode(unsigned OC, ArrayRef<EVT> ResVT, ArrayRef<SDValue> OpV,
                  std::optional<SDNodeFlags> Flags = std::nullopt) const {
    auto N = DAG.getNode(OC, DL, ResVT, OpV);
    if (Flags)
      N->setFlags(*Flags);
    return N;
  }

  SDValue getNode(unsigned OC, EVT ResVT, ArrayRef<SDValue> OpV,
                  std::optional<SDNodeFlags> Flags = std::nullopt) const {
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

    return getNarrow(DestVT, Op, OpVT.getVectorNumElements());
  }

  SDValue getNarrow(EVT ResTy, SDValue SrcV, uint64_t NarrowLen) {
    return DAG.getNode(VEISD::VEC_NARROW, DL, ResTy,
                       {SrcV, getConstant(NarrowLen, MVT::i32)});
  }

  inline SDValue getConstEVL(uint32_t EVL) const {
    return getConstant(EVL, MVT::i32);
  }

  // return a valid AVL for this packing and element count
  inline SDValue getConstEVL(Packing P, uint32_t EVL) const {
    return getConstant(P == Packing::Normal ? EVL : (EVL + 1) / 2, MVT::i32);
  }

  /// Legalizing getNode {
  // Note: StartV can be SDValue()
  SDValue getLegalReductionOpVVP(unsigned VVPOpcode, EVT ResVT, SDValue StartV,
                                 SDValue VectorV, SDValue Mask, SDValue AVL,
                                 SDNodeFlags Flags) const;
  // Create this binary operator, expanding it on the fly.
  SDValue getLegalBinaryOpVVP(unsigned VVPOpcode, EVT ResVT, SDValue A,
                              SDValue B, SDValue Mask, SDValue AVL,
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
  /// } Legalizing getNode

  /// Packing {
  SDValue getUnpack(EVT DestVT, SDValue Vec, PackElem Part, SDValue AVL) const;
  SDValue getPack(EVT DestVT, SDValue LoVec, SDValue HiVec, SDValue AVL) const;
  SDValue getSwap(EVT DestVT, SDValue V, SDValue AVL) const;
  /// } Packing

  SDValue getMergeValues(ArrayRef<SDValue> Values) const {
    return DAG.getMergeValues(Values, DL);
  }

  SDValue getConstant(uint64_t Val, EVT VT, bool IsTarget = false,
                      bool IsOpaque = false) const;

  SDValue getUndef(EVT VT) const { return DAG.getUNDEF(VT); }

  SDValue getNot(SDValue Op, EVT ResVT) const {
    return DAG.getNOT(DL, Op, ResVT);
  }

  EVT getMaskVTFor(SDValue VectorV) const {
    return getVectorVT(MVT::i1, VectorV.getValueType().getVectorNumElements());
  }

  // create a VEC_TOMASK node if VectorV is not a mask already
  SDValue getMaskCast(SDValue VectorV, SDValue AVL) const;

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

  SDValue getIDIV(bool IsSigned, EVT ResVT, SDValue Dividend, SDValue Divisor,
                  SDValue Mask, SDValue AVL) const;
  SDValue getIREM(bool IsSigned, EVT ResVT, SDValue Dividend, SDValue Divisor,
                  SDValue Mask, SDValue AVL) const;

  // Infer mask & AVL for this VVP op.
  VETargetMasks getTargetMask(VVPWideningInfo, SDValue RawMask,
                              SDValue RawAVL) const;
  // Infer mask & AVL for this split VVP op
  VETargetMasks getTargetSplitMask(VVPWideningInfo WidenInfo, SDValue RawMask,
                                   SDValue RawAVL, PackElem Part) const;
  SDValue getConstantTargetMask(VVPWideningInfo WidenInfo) const;

  // Create a legalize AVL value for \p WidenInfo.
  SDValue getTargetAVL(VVPWideningInfo WidenInfo) const;
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
  SDValue getConstantMask(Packing Packing, bool AllTrue) const;
  SDValue getMaskBroadcast(EVT ResultVT, SDValue Scalar, SDValue AVL) const;
  SDValue getBroadcast(EVT ResultVT, SDValue Scalar, SDValue AVL) const;

  // Wrap AVL in a LEGALAVL node (unless it is one already).
  SDValue annotateLegalAVL(SDValue AVL) const;

  // Splitting support
  SDValue getSplitPtrOffset(SDValue Ptr, SDValue ByteStride,
                            PackElem Part) const;
  SDValue getSplitPtrStride(SDValue PackStride) const;
  SDValue getGatherScatterAddress(SDValue BasePtr, SDValue Scale, SDValue Index,
                                  SDValue Mask, SDValue AVL) const;
  EVT getVectorVT(EVT ElemVT, unsigned NumElems) const {
    return EVT::getVectorVT(*DAG.getContext(), ElemVT, NumElems);
  }
};

} // namespace llvm

#endif // LLVM_LIB_TARGET_VE_VECUSTOMDAG_H
