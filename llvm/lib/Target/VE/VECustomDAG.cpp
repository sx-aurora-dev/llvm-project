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

#include "VECustomDAG.h"
#include "MaskView.h"
#include "VE.h"
#include "VEISelLowering.h"
#include "VVPCombine.h"
#include "llvm/CodeGen/SelectionDAG.h"
#include "llvm/CodeGen/TargetLowering.h"

#ifndef DEBUG_TYPE
#define DEBUG_TYPE "vecustomdag"
#endif

namespace llvm {

/// Packing {

bool isPackedMaskType(EVT SomeVT) {
  return isPackedVectorType(SomeVT) && isMaskType(SomeVT);
}
template <> Packing getPackingForMaskBits(const LaneBits MB) {
  return Packing::Normal;
}
template <> Packing getPackingForMaskBits(const PackedLaneBits MB) {
  return Packing::Dense;
}

PackElem getPartForLane(unsigned ElemIdx) {
  return (ElemIdx % 2 == 0) ? PackElem::Hi : PackElem::Lo;
}

PackElem getOtherPart(PackElem Part) {
  return Part == PackElem::Lo ? PackElem::Hi : PackElem::Lo;
}

unsigned getOverPackedSubRegIdx(PackElem Part) {
  return Part == PackElem::Lo ? VE::sub_pack_lo : VE::sub_pack_hi;
}

unsigned getPackedMaskSubRegIdx(PackElem Part) {
  return Part == PackElem::Lo ? VE::sub_vm_odd : VE::sub_vm_even;
}

MVT getMaskVT(Packing P) {
  return P == Packing::Normal ? MVT::v256i1 : MVT::v512i1;
}

PackElem getPackElemForVT(EVT VT) {
  if (VT.isFloatingPoint())
    return PackElem::Hi;
  if (VT.isVector())
    return getPackElemForVT(VT.getVectorElementType());
  return PackElem::Lo;
}

// The subregister VT an unpack of part \p Elem from \p VT would source its
// result from.
MVT getUnpackSourceType(EVT VT, PackElem Elem) {
  if (!VT.isVector())
    return Elem == PackElem::Hi ? MVT::f32 : MVT::i32;

  EVT ElemVT = VT.getVectorElementType();
  if (isMaskType(VT))
    return MVT::v256i1;
  if (isOverPackedType(VT))
    return ElemVT.isFloatingPoint() ? MVT::v256f64 : MVT::v256i64;
  return ElemVT.isFloatingPoint() ? MVT::v256f32 : MVT::v256i32;
}

Packing getPackingForVT(EVT VT) {
  assert(VT.isVector());
  return isPackedVectorType(VT) ? Packing::Dense : Packing::Normal;
}

bool isUnpackOp(unsigned OPC) {
  return (OPC == VEISD::VEC_UNPACK_LO) || (OPC == VEISD::VEC_UNPACK_HI);
}

PackElem getPartForUnpackOpcode(unsigned OPC) {
  if (OPC == VEISD::VEC_UNPACK_LO)
    return PackElem::Lo;
  if (OPC == VEISD::VEC_UNPACK_HI)
    return PackElem::Hi;
  llvm_unreachable("Not an unpack opcode!");
}

unsigned getUnpackOpcodeForPart(PackElem Part) {
  return (Part == PackElem::Lo) ? VEISD::VEC_UNPACK_LO : VEISD::VEC_UNPACK_HI;
}

SDValue getUnpackPackOperand(SDValue N) { return N->getOperand(0); }

SDValue getUnpackAVL(SDValue N) { return N->getOperand(1); }

/// } Packing

/// Node Properties {

std::optional<unsigned> inferAVLFromMask(SDValue Mask) {
  if (!Mask)
    return std::nullopt;

  std::unique_ptr<MaskView> MV(requestMaskView(Mask.getNode()));
  if (!MV)
    return std::nullopt;

  unsigned FirstDef, LastDef, NumElems;
  BVMaskKind BVK = AnalyzeBitMaskView(*MV.get(), FirstDef, LastDef, NumElems);
  if (BVK == BVMaskKind::Interval) {
    // FIXME \p FirstDef must be == 0
    return LastDef + 1;
  }

  //
  return Mask.getValueType().getVectorNumElements();
}

std::optional<unsigned> getVVPOpcode(unsigned OpCode) {
  if (isVVPOrVEC(OpCode))
    return OpCode;

#define ADD_VVP_OP(VVP_NAME, NATIVE_ISD)                                       \
  if ((ISD::NATIVE_ISD != ISD::DELETED_NODE) && (OpCode == ISD::NATIVE_ISD))   \
    return VEISD::VVP_NAME;
#include "VVPNodes.def"

  switch (OpCode) {
  default:
    return std::nullopt;

  case ISD::SCALAR_TO_VECTOR:
    return VEISD::VEC_BROADCAST;

  case ISD::SELECT: // additional alias next to VSELECT
    return VEISD::VVP_SELECT;

  case ISD::MLOAD:
    return VEISD::VVP_LOAD;
  case ISD::MSTORE:
    return VEISD::VVP_STORE;
  // TODO: Map those in VVPNodes.def too
  case ISD::EXPERIMENTAL_VP_STRIDED_LOAD:
    return VEISD::VVP_LOAD;
  case ISD::EXPERIMENTAL_VP_STRIDED_STORE:
    return VEISD::VVP_STORE;

#define HANDLE_VP_TO_VVP(VP_ID, VVP_NAME)                                      \
  case ISD::VP_ID:                                                             \
    return VEISD::VVP_NAME;
#include "VVPNodes.def"
  }
}

bool isVVPUnaryOp(unsigned Opcode) {
  switch (Opcode) {
#define ADD_UNARY_VVP_OP(VVP_NAME, ...) case VEISD::VVP_NAME:
#include "VVPNodes.def"
    return true;
  }
  return false;
}

bool isVVPBinaryOp(unsigned Opcode) {
  switch (Opcode) {
#define ADD_BINARY_VVP_OP(VVP_NAME, ...) case VEISD::VVP_NAME:
#include "VVPNodes.def"
    return true;
  }
  return false;
}

bool isVVPTernaryOp(unsigned Opcode) {
  switch (Opcode) {
#define ADD_TERNARY_VVP_OP(VVP_NAME, ...) case VEISD::VVP_NAME:
#include "VVPNodes.def"
    return true;
  }
  return false;
}

bool isVVPConversionOp(unsigned Opcode) {
  switch (Opcode) {
#define ADD_ICONV_VVP_OP(VVP_NAME, ...) case VEISD::VVP_NAME:
#define ADD_FPCONV_VVP_OP(VVP_NAME, ...) case VEISD::VVP_NAME:
#include "VVPNodes.def"
    return true;
  }
  return false;
}

bool isVVPReductionOp(unsigned Opcode) {
  switch (Opcode) {
#define ADD_REDUCE_VVP_OP(VVP_NAME, ...) case VEISD::VVP_NAME:
#include "VVPNodes.def"
    return true;
  }
  return false;
}

bool hasVVPReductionStartParam(unsigned VVPROPC) {
  switch (VVPROPC) {
  case VEISD::VVP_REDUCE_FADD:
    // VFSUM
  case VEISD::VVP_REDUCE_FMIN:
    // VFMIN
  case VEISD::VVP_REDUCE_FMAX:
    // VFMAX
  default:
    return false;

  case VEISD::VVP_REDUCE_SEQ_FADD:
    // VFIA
  case VEISD::VVP_REDUCE_FMUL:
  case VEISD::VVP_REDUCE_SEQ_FMUL:
    // VFIM
    return true;
  }
}

unsigned getScalarReductionOpcode(unsigned VVPOC, bool IsMask) {
  if (IsMask) {
    switch (VVPOC) {
    case VEISD::VVP_REDUCE_UMIN:
    case VEISD::VVP_REDUCE_SMAX:
    case VEISD::VVP_REDUCE_MUL:
    case VEISD::VVP_REDUCE_AND:
      return ISD::AND;
    case VEISD::VVP_REDUCE_SMIN:
    case VEISD::VVP_REDUCE_UMAX:
    case VEISD::VVP_REDUCE_OR:
      return ISD::OR;
    case VEISD::VVP_REDUCE_ADD:
    case VEISD::VVP_REDUCE_XOR:
      return ISD::XOR;
    default:
      abort();
    }
  }

  // Non i1 reduction Opcode.
  switch (VVPOC) {
#define HANDLE_VVP_REDUCE_TO_SCALAR(VVP_RED_ISD, REDUCE_ISD)                   \
  case VEISD::VVP_RED_ISD:                                                     \
    return ISD::REDUCE_ISD;
#include "VVPNodes.def"
  default:
    break;
  }
  llvm_unreachable("Cannot not scalarize this reduction Opcode!");
}

bool supportsPackedMode(unsigned Opcode, EVT IdiomVT) {
  bool IsPackedOp = isPackedVectorType(IdiomVT);
  bool IsMaskOp = IdiomVT.getVectorElementType() == MVT::i1;

#if 0
  if (IsMaskOp && IsPackedOp) {
    return false;
  }
#endif

  switch (Opcode) {
  default:
    return false;

  case VEISD::VM_POPCOUNT:
    return false;
  case VEISD::VEC_SEQ:
  case VEISD::VEC_BROADCAST:
    return true;
#define REGISTER_PACKED(VVP_NAME) case VEISD::VVP_NAME:
#include "VVPNodes.def"
    return IsPackedOp && !IsMaskOp;
  }
}

#define IF_IN_VEISD_RANGE(STARTOC, ENDOC)                                      \
  if ((VEISD::STARTOC <= OC) && (OC <= VEISD::ENDOC))

bool isVVPOrVEC(unsigned OC) {
  IF_IN_VEISD_RANGE(VEC_FIRST, VEC_LAST) { return true; }
  IF_IN_VEISD_RANGE(VM_FIRST, VM_LAST) { return true; }

  return isVVP(OC);
}
#undef IF_IN_VEISD_RANGE

bool isVVP(unsigned Opcode) {
  switch (Opcode) {
  default:
    return false;
#define ADD_VVP_OP(VVP_NAME, ...)                                              \
  case VEISD::VVP_NAME:                                                        \
    return true;
#include "VVPNodes.def"
  }
}

// Return the AVL operand position for this VVP Op.
std::optional<int> getAVLPos(unsigned Opc) {
  // This is only available for VP SDNodes
  auto PosOpt = ISD::getVPExplicitVectorLengthIdx(Opc);
  if (PosOpt)
    return *PosOpt;

  // VEC Opcodes and special cases.
  switch (Opc) {
  case VEISD::VEC_TOMASK:
    return 1;
  case VEISD::VEC_SEQ:
    return 0;
  case VEISD::VEC_BROADCAST:
    return 1;
  case VEISD::VEC_UNPACK_HI:
  case VEISD::VEC_UNPACK_LO:
    return 1;
  case VEISD::VEC_SWAP:
    return 1;
  case VEISD::VEC_PACK:
    return 2;
  case VEISD::VEC_VMV:
    return 3;
  }

  // VM Opcodes.
  switch (Opc) {
  case VEISD::VM_POPCOUNT:
    return 1;
  }

  // VVP Opcodes.
  if (isVVP(Opc)) {
    auto MaskOpt = getMaskPos(Opc);
    if (!MaskOpt)
      return std::nullopt;
    return *MaskOpt + 1;
  }
  return std::nullopt;
}

// Return the mask operand position for this VVP or VEC op.
std::optional<int> getMaskPos(unsigned Opc) {

  // These VP Opcodes do not have a mask in the VP sense and so ISD::getVPMaskIdx
  // would not report it.
  switch (Opc) {
    case ISD::VP_SELECT:
    case ISD::VP_MERGE:
      return 0;
  }

  // VP opcode.
  auto PosOpt = ISD::getVPMaskIdx(Opc);
  if (PosOpt)
    return *PosOpt;

  // Standard opcodes.
  switch (Opc) {
  case ISD::VSELECT:
  case ISD::SELECT:
    return 0;
  case ISD::MSCATTER:
  case ISD::MGATHER:
    return 2;
  case ISD::MSTORE:
    return 4;
  case ISD::MLOAD:
    return 3;
  }

  // VM_* opcodes.
  switch (Opc) {
  case VEISD::VM_POPCOUNT:
    return 0;
  case VEISD::VM_INSERT:
  case VEISD::VM_EXTRACT:
    return 0;
  }

  // VEC_* opcodes.
  switch (Opc) {
  case VEISD::VEC_BROADCAST:
  case VEISD::VEC_SWAP:
  case VEISD::VEC_UNPACK_HI:
  case VEISD::VEC_UNPACK_LO:
  case VEISD::VEC_PACK:
  case VEISD::VEC_TOMASK:
  case VEISD::VEC_SEQ:
    return std::nullopt;
  case VEISD::VEC_VMV:
    return 2;
  }

  // VVP special cases..
  switch (Opc) {
  case VEISD::VVP_SELECT:
    return 2;
  case VEISD::VVP_LOAD:
    return 3;
  case VEISD::VVP_STORE:
    return 4;
  case VEISD::VVP_GATHER:
    return 2;
  case VEISD::VVP_SCATTER:
    return 3;
  case VEISD::VVP_SETCC:
    return 3;
  }

  if (isVVPUnaryOp(Opc) || isVVPConversionOp(Opc))
    return 1;
  if (isVVPBinaryOp(Opc))
    return 2;
  if (isVVPTernaryOp(Opc))
    return 3;
  if (isVVPReductionOp(Opc))
    return *getReductionVectorParamPos(Opc) + 1;
  return std::nullopt;
}

SDValue getNodeAVL(SDValue Op) {
  auto PosOpt = getAVLPos(Op->getOpcode());
  return PosOpt ? Op->getOperand(*PosOpt) : SDValue();
}

SDValue getNodeMask(SDValue Op) {
  auto PosOpt = getMaskPos(Op->getOpcode());
  return PosOpt ? Op->getOperand(*PosOpt) : SDValue();
}

// Choses the widest element type
EVT getLargestConvType(SDNode *Op) {
  EVT ResVT = Op->getValueType(0);
  EVT OpVT = Op->getOperand(0).getValueType();
  return ResVT.getStoreSizeInBits() > OpVT.getStoreSizeInBits() ? ResVT : OpVT;
}

PosOpt getVVPReductionStartParamPos(unsigned VVPOC) {
  switch (VVPOC) {
  case VEISD::VVP_REDUCE_SEQ_FADD:
  case VEISD::VVP_REDUCE_SEQ_FMUL:
    return 0;
  default:
    return std::nullopt;
  }
}

PosOpt getVPReductionStartParamPos(unsigned VPISD) {
  PosOpt StartPos;
  switch (VPISD) {
  default:
    break;
#define BEGIN_REGISTER_VP_SDNODE(VPISD, ...) case ISD::VPISD:
#define VP_PROPERTY_REDUCTION(STARTPOS, VECTORPOS) StartPos = STARTPOS;
#define END_REGISTER_VP_SDNODE(VPISD) break;
#include "llvm/IR/VPIntrinsics.def"
  }
  return StartPos;
}

PosOpt getReductionStartParamPos(unsigned OPC) {
  if (ISD::isVPOpcode(OPC))
    return getVPReductionStartParamPos(OPC);

  switch (OPC) {
  case VEISD::VVP_REDUCE_SEQ_FADD:
  case VEISD::VVP_REDUCE_SEQ_FMUL:
    return 0;
  default:
    return std::nullopt;
  }
}

PosOpt getVPReductionVectorParamPos(unsigned VPISD) {
  PosOpt VecPos;
  switch (VPISD) {
  default:
    break;
#define BEGIN_REGISTER_VP_SDNODE(VPISD, ...) case ISD::VPISD:
#define VP_PROPERTY_REDUCTION(STARTPOS, VECTORPOS) VecPos = VECTORPOS;
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
  return std::nullopt;
}

PosOpt getVVPReductionVectorParamPos(unsigned VVPOpcode) {
  if (!isVVPReductionOp(VVPOpcode))
    return std::nullopt;

  PosOpt StartPosOpt = getVVPReductionStartParamPos(VVPOpcode);
  if (!StartPosOpt)
    return 0;
  return *StartPosOpt + 1;
}

PosOpt getReductionVectorParamPos(unsigned ISD) {
  // VP reduction param pos
  PosOpt VecPos = getVPReductionVectorParamPos(ISD);
  if (VecPos)
    return VecPos;

  // VVP reduction
  VecPos = getVVPReductionVectorParamPos(ISD);
  if (VecPos)
    return VecPos;

  // Regular reduction
  VecPos = getIntrinReductionVectorParamPos(ISD);
  return VecPos;
}

/// } Node Properties

std::optional<unsigned> getVVPForVP(unsigned VPOC) {
  switch (VPOC) {
#define HANDLE_VP_TO_VVP(VP_ISD, VVP_VEISD)                                    \
  case ISD::VP_ISD:                                                            \
    return VEISD::VVP_VEISD;
#include "VVPNodes.def"

  default:
    return std::nullopt;
  }
}

std::optional<EVT> getIdiomaticType(SDNode *Op) {
  // For reductions -> the reduced vector type
  PosOpt RedVecPos = getReductionVectorParamPos(Op->getOpcode());
  if (RedVecPos)
    return Op->getOperand(RedVecPos.value())->getValueType(0);

  unsigned OC = Op->getOpcode();

  // Translate to VVP where possible.
  auto VVPOpc = getVVPOpcode(OC);
  if (VVPOpc)
    OC = *VVPOpc;

  // NOTE: Be aware that opcodes are translated to VVP first. If the idiomatic
  // vector type position changes its time for another switch above the
  // translation code.
  switch (OC) {
  default:
    // For memory ops -> the transfered data type
    if (auto MemN = dyn_cast<MemSDNode>(Op))
      return MemN->getMemoryVT();
    return std::nullopt;

  // Standard ISD.
  case ISD::VSELECT: // not aliased with VVP_SELECT
  case ISD::SELECT:  // not aliased with VVP_SELECT
  case ISD::CONCAT_VECTORS:
  case ISD::EXTRACT_SUBVECTOR:
  case ISD::VECTOR_SHUFFLE:
  case ISD::BUILD_VECTOR:
  case ISD::SCALAR_TO_VECTOR:
    return Op->getValueType(0);

    // VVP
  case VEISD::VVP_SELECT:
#define ADD_UNARY_VVP_OP(VVP_NAME, ...) case VEISD::VVP_NAME:
#define ADD_BINARY_VVP_OP(VVP_NAME, ...) case VEISD::VVP_NAME:
#define ADD_TERNARY_VVP_OP(VVP_NAME, ...) case VEISD::VVP_NAME:
#include "VVPNodes.def"
    return Op->getValueType(0);

#define ADD_FPCONV_VVP_OP(VVP_NAME, ...) case VEISD::VVP_NAME:
#define ADD_ICONV_VVP_OP(VVP_NAME, ...) case VEISD::VVP_NAME:
#include "VVPNodes.def"
    return getLargestConvType(Op);
  case VEISD::VVP_LOAD:
  case VEISD::VVP_GATHER:
    return Op->getValueType(0);

  case VEISD::VVP_SETCC:
    return Op->getOperand(0).getValueType();

  case VEISD::VVP_STORE:
  case VEISD::VVP_SCATTER:
    return Op->getOperand(1)->getValueType(0);

  // VEC
  case VEISD::VEC_VMV:
  case VEISD::VEC_TOMASK:
  case VEISD::VEC_NARROW:
  case VEISD::VEC_SEQ:
  case VEISD::VEC_BROADCAST:
    return Op->getValueType(0);

  // VM
  case VEISD::VM_POPCOUNT:
    return Op->getOperand(0).getValueType();
  }
}

VecLenOpt minVectorLength(VecLenOpt A, VecLenOpt B) {
  if (!A)
    return B;
  if (!B)
    return A;
  return std::min<unsigned>(A.value(), B.value());
}

// Whether direct codegen for this type will result in a packed operation
// (requiring a packed VL param..)

bool isPackedVectorType(EVT SomeVT) {
  if (!SomeVT.isVector())
    return false;
  return SomeVT.getVectorNumElements() > StandardVectorWidth;
}

// legalize packed-mode broadcasts into lane replication + broadcast
static SDValue supplementPackedReplication(SDValue Op, SelectionDAG &DAG) {
  if (Op.getOpcode() != VEISD::VEC_BROADCAST)
    return Op;

  EVT VT = Op.getValueType();
  SDLoc DL(Op);

  auto ScaOp = Op.getOperand(0);
  auto ScaTy = ScaOp->getValueType(0);
  auto VLOp = Op.getOperand(1);

  // v256x broadcast (element has to be i64/f64 always)
  if (!isPackedVectorType(VT))
    return Op;

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
    // This could either be an over-packed broadcast (i64 or f64) or a proper
    // packed broadcast with element replication.
    assert((ScaTy == MVT::i64) || (ScaTy == MVT::f64));
    LLVM_DEBUG(dbgs() << "already using I64 -> unchanged!\n");
    return Op;
  }

  auto ReplOp = DAG.getNode(ReplOC, DL, MVT::i64, ScaOp);
  // auto LegalVecTy = MVT::getVectorVT(MVT::i64, Ty.getVectorNumElements());
  return DAG.getNode(VEISD::VEC_BROADCAST, DL, VT, {ReplOp, VLOp});
}

MVT splitVectorType(MVT VT) {
  if (!VT.isVector())
    return VT;
  return MVT::getVectorVT(VT.getVectorElementType(), StandardVectorWidth);
}

EVT splitType(LLVMContext &Ctx, EVT PackedVT, PackElem P) {
  assert(isPackedVectorType(PackedVT));
  unsigned PackedNumEls = PackedVT.getVectorNumElements();

  unsigned OneExtra = P == PackElem::Hi ? PackedNumEls % 2 : 0;
  return EVT::getVectorVT(Ctx, PackedVT.getVectorElementType(),
                          (PackedNumEls / 2) + OneExtra);
}

MVT getLegalVectorType(Packing P, MVT ElemVT) {
  return MVT::getVectorVT(ElemVT, P == Packing::Normal ? StandardVectorWidth
                                                       : PackedVectorWidth);
}

Packing getTypePacking(EVT VT) {
  assert(VT.isVector());
  return isPackedVectorType(VT) ? Packing::Dense : Packing::Normal;
}

bool isMaskType(EVT SomeVT) {
  if (!SomeVT.isVector())
    return false;
  return SomeVT.getVectorElementType() == MVT::i1;
}

bool maySafelyIgnoreMask(unsigned VVPOpcode) {
  switch (VVPOpcode) {
  case VEISD::VVP_FNEG:
    return true;
  case VEISD::VVP_UREM:
  case VEISD::VVP_SREM:
  case VEISD::VVP_UDIV:
  case VEISD::VVP_SDIV:
  case VEISD::VVP_FDIV:
    return false;
  case VEISD::VVP_SELECT:
    return false;
  }

  // Most arithmetic is safe without mask.
  if (isVVPTernaryOp(VVPOpcode))
    return true;
  if (isVVPBinaryOp(VVPOpcode))
    return true;
  return false;
}

bool isMaskArithmetic(SDValue Op) {
  switch (Op.getOpcode()) {
  default:
    return false;
  case ISD::AND:
  case ISD::XOR:
  case ISD::OR:
    return isMaskType(Op.getValueType());
  }
}

bool isAllTrueMask(SDValue Op) {
  if (!isMaskType(Op.getValueType()))
    return false;
  auto SplatV = getSplatValue(Op.getNode());
  if (!SplatV) {
    // FIXME: Could already be a broadcast.
    return false;
  }
  if (auto ConstSD = dyn_cast<ConstantSDNode>(SplatV)) {
    return ConstSD->getSExtValue() != 0;
  }
  return false;
}

// whether this VVP operation has no mask argument
bool hasDeadMask(unsigned VVPOC) {
  switch (VVPOC) {
  default:
    return false;

  case VEISD::VVP_LOAD:
    return true;
  }
}

std::optional<unsigned> peekForNarrow(SDValue Op) {
  if (!Op.getValueType().isVector())
    return std::nullopt;
  if (Op->use_size() != 1)
    return std::nullopt;
  auto OnlyN = *Op->use_begin();
  if (OnlyN->getOpcode() != VEISD::VEC_NARROW)
    return std::nullopt;
  return cast<ConstantSDNode>(OnlyN->getOperand(1))->getZExtValue();
}

bool isOverPackedType(EVT VT) {
  if (!VT.isVector())
    return false;
  if (VT.getVectorElementType() != MVT::i64 &&
      VT.getVectorElementType() != MVT::f64)
    return false;
  return VT.getVectorNumElements() > StandardVectorWidth;
}

bool isPackingSupportOpcode(unsigned Opc) {
  switch (Opc) {
  case VEISD::VEC_PACK:
  case VEISD::VEC_UNPACK_LO:
  case VEISD::VEC_UNPACK_HI:
  case VEISD::VEC_SWAP:
    return true;
  }
  return false;
}

unsigned getMaskBits(EVT VT) {
  if (!VT.isVector())
    return 0;

  EVT ElemVT = VT.getVectorElementType();
  if (!ElemVT.isInteger())
    return 0;

  return ElemVT.getScalarSizeInBits() * VT.getVectorNumElements();
}

// select an appropriate %evl argument for this element count.
// This will return the correct result for packed mode oeprations (half).
unsigned selectBoundedVectorLength(unsigned StaticNumElems) {
  if (StaticNumElems > StandardVectorWidth) {
    return (StaticNumElems + 1) / 2;
  }
  return StaticNumElems;
}

/// class VECustomDAG {

SDValue VECustomDAG::inferAVL(SDValue AVL, SDValue Mask, EVT IdiomVT) const {
  if (AVL)
    return AVL;
  auto ConstMaskAVL = inferAVLFromMask(Mask);
  auto ConstTypeAVL = IdiomVT.getVectorNumElements();
  if (!ConstMaskAVL)
    return getConstEVL(ConstTypeAVL);
  return getConstEVL(std::min<unsigned>(ConstTypeAVL, *ConstMaskAVL));
}

/// Helper class for short hand custom node creation ///
SDValue VECustomDAG::getSeq(EVT ResTy, std::optional<SDValue> OpVectorLength) const {
  // Pick VL
  SDValue VectorLen;
  if (OpVectorLength.has_value()) {
    VectorLen = OpVectorLength.value();
  } else {
    VectorLen = DAG.getConstant(
        selectBoundedVectorLength(ResTy.getVectorNumElements()), DL, MVT::i32);
  }

  return DAG.getNode(VEISD::VEC_SEQ, DL, ResTy, VectorLen);
}

SDValue VECustomDAG::getTargetExtractSubreg(MVT SubRegVT, int SubRegIdx,
                                            SDValue RegV) const {
  return DAG.getTargetExtractSubreg(SubRegIdx, DL, SubRegVT, RegV);
}

// create a vector element or scalar bitshift depending on the element type
// dst[i] = src[i + Offset]
SDValue VECustomDAG::getScalarShift(EVT ResVT, SDValue Src, int Offset) const {
  if (Offset == 0)
    return Src;
  unsigned OC = Offset > 0 ? ISD::SHL : ISD::SRL; // VE::SLLri : VE::SRLri;
  SDValue ShiftV = getConstant(std::abs(Offset),
                               MVT::i32); // This is the ShiftAmount constant
  return DAG.getNode(OC, DL, ResVT, Src, ShiftV);
}

// create a vector element or scalar bitshift depending on the element type
// dst[i] = src[i + Offset]
SDValue VECustomDAG::getElementShift(EVT ResVT, SDValue Src, int Offset,
                                     SDValue AVL) const {
  if (Offset == 0)
    return Src;

  // scalar bit shift
  if (!Src.getValueType().isVector()) {
    return getScalarShift(ResVT, Src, Offset);
  }

  assert(ResVT.getVectorNumElements() <= 256 && "TODO implement packed mode");

  // vector shift
  EVT VecVT = Src.getValueType();
  assert(!isPackedVectorType(VecVT) && "TODO implement");
  assert(!isMaskType(VecVT));
  return getVMV(
      ResVT, Src, getConstant(Offset, MVT::i32),
      getUniformConstMask(Packing::Normal, VecVT.getVectorNumElements(), true),
      AVL);
}

SDValue VECustomDAG::getPassthruVMV(EVT ResVT, SDValue SrcV, SDValue OffsetV,
                                    SDValue Mask, SDValue PassthruV,
                                    SDValue Avl) const {
  abort(); // TODO return DAG.getNode(VEISD::VEC_VMV, DL, ResVT, {SrcV, OffsetV,
           // Mask, Avl});
}

SDValue VECustomDAG::getVMV(EVT ResVT, SDValue SrcV, SDValue OffsetV,
                            SDValue Mask, SDValue Avl) const {
  return DAG.getNode(VEISD::VEC_VMV, DL, ResVT, {SrcV, OffsetV, Mask, Avl});
}

SDValue VECustomDAG::getExtractMask(SDValue MaskV, SDValue IndexV) const {
  return DAG.getNode(VEISD::VM_EXTRACT, DL, MVT::i64, MaskV, IndexV);
}

SDValue VECustomDAG::getInsertMask(SDValue MaskV, SDValue ElemV,
                                   SDValue IndexV) const {
  return DAG.getNode(VEISD::VM_INSERT, DL, MaskV.getValueType(), MaskV, ElemV,
                     IndexV);
}

SDValue VECustomDAG::getMaskPopcount(SDValue MaskV, SDValue AVL) const {
  return DAG.getNode(VEISD::VM_POPCOUNT, DL, MVT::i64, MaskV, AVL);
}

static SDValue foldUnpackFromPack(SDValue PackOp, PackElem Part, EVT DestVT) {
  if (PackOp->getOpcode() != VEISD::VEC_PACK)
    return SDValue();

  // Check for implicit swapping.
  // The following unpack of pack are foldable (they are noop):
  //   Any mask unpack.
  // Or:
  //   Any over-packed unpack.
  // Or:
  // v256i32 vec_unpack_lo SrcV
  // v256f32 vec_unpack_hi SrcV
  EVT SrcVT = PackOp.getValueType();
  PackElem DestPart = getPackElemForVT(DestVT);
  if (!isMaskType(SrcVT) && !isOverPackedType(SrcVT) && (DestPart != Part))
    return SDValue();

  if (Part == PackElem::Lo)
    return PackOp->getOperand(0);
  else
    return PackOp->getOperand(1);
}

static SDValue foldUnpackFromBroadcast(SDValue Vec, PackElem Part, EVT DestVT,
                                       SDValue AVL, const VECustomDAG &CDAG) {
  SDValue Scalar = getSplatValue(Vec.getNode());
  if (!Scalar)
    return SDValue();

  // Fold unpack from an overpacked or mask broadcast.
  if (isOverPackedType(Vec.getValueType()) || isMaskType(Vec.getValueType()))
    return CDAG.getBroadcast(DestVT, Scalar, AVL);

  // Fold unpack from broadcast from replication.
  if (SDValue Simplified = combineUnpackLoHi(Vec, Part, DestVT, AVL, CDAG))
    return Simplified;

  return SDValue();
}

SDValue VECustomDAG::getSwap(EVT DestVT, SDValue V, SDValue AVL) const {
  return DAG.getNode(VEISD::VEC_SWAP, DL, DestVT, V, AVL);
}

SDValue VECustomDAG::getBroadcast(EVT ResTy, SDValue S, SDValue AVL) const {

  // Pick VL
  if (!AVL) {
    AVL = DAG.getConstant(
        selectBoundedVectorLength(ResTy.getVectorNumElements()), DL, MVT::i32);
  }

  // Over-packed case: immediately split this into double packing.
  if (isOverPackedType(ResTy)) {
    MVT LegalPartVT = getUnpackSourceType(ResTy, PackElem::Lo);
    auto PartV = supplementPackedReplication(
        DAG.getNode(VEISD::VEC_BROADCAST, DL, LegalPartVT, {S, AVL}), DAG);
    return getPack(ResTy, PartV, PartV, AVL);
  }

  // Non-mask case
  if (ResTy.getVectorElementType() != MVT::i1) {
    return supplementPackedReplication(
        DAG.getNode(VEISD::VEC_BROADCAST, DL, ResTy, {S, AVL}), DAG);
  }

  // Mask bit broadcast
  auto BcConst = dyn_cast<ConstantSDNode>(S);

  // Constant mask splat
  if (BcConst) {
    return getUniformConstMask(getPackingForVT(ResTy),
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
      DAG.getNode(VEISD::VEC_BROADCAST, DL, CmpVecTy, {CmpElem, AVL});
  SDValue ZeroVec =
      getBroadcast(CmpVecTy, {DAG.getConstant(0, DL, BoolTy)}, AVL);

  MVT BoolVecTy = MVT::getVectorVT(MVT::i1, ElemCount);

  // broadcast(Data) != broadcast(0)
  return DAG.getSetCC(DL, BoolVecTy, BCVec, ZeroVec, ISD::CondCode::SETNE);
}

// Extract an SX register from a mask
SDValue VECustomDAG::getMaskExtract(SDValue MaskV, SDValue Idx) const {
  return DAG.getNode(VEISD::VM_EXTRACT, DL, MVT::i64, {MaskV, Idx});
}

// Extract an SX register from a mask
SDValue VECustomDAG::getMaskInsert(SDValue MaskV, SDValue Idx,
                                   SDValue ElemV) const {
  return DAG.getNode(VEISD::VM_INSERT, DL, MaskV.getValueType(),
                     {MaskV, Idx, ElemV});
}

template <typename MaskBits>
SDValue VECustomDAG::getConstMask(unsigned NumElems,
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
    return getUniformConstMask(Packing, TrueBits.size(), TrueBits[0]);
  }

  SDValue MaskV = getUniformConstMask(Packing, TrueBits.size(), false);
  unsigned RegPartIdx = 0;
  for (unsigned StartIdx = 0; StartIdx < NumElems;
       StartIdx += SXRegSize, ++RegPartIdx) {
    uint64_t ConstReg = 0;
    for (uint i = 0; i < SXRegSize; ++i) {
      uint64_t LaneMask = ((uint64_t)1) << i;
      ConstReg |= TrueBits[StartIdx + i] ? LaneMask : 0;
    }
    // initial mask is all-zero already
    if (!ConstReg)
      continue;

    MaskV = getMaskInsert(MaskV, getConstant(RegPartIdx, MVT::i32),
                          getConstant(ConstReg, MVT::i64));
  }
  return MaskV;
}

template SDValue VECustomDAG::getConstMask<LaneBits>(unsigned,
                                                     const LaneBits &) const;
template SDValue
VECustomDAG::getConstMask<PackedLaneBits>(unsigned,
                                          const PackedLaneBits &) const;

SDValue VECustomDAG::getSelect(EVT ResVT, SDValue OnTrueV, SDValue OnFalseV,
                               SDValue MaskV, SDValue PivotV) const {
  if (OnTrueV.isUndef())
    return OnFalseV;
  if (OnFalseV.isUndef())
    return OnTrueV;

  return DAG.getNode(VEISD::VVP_SELECT, DL, ResVT,
                     {OnTrueV, OnFalseV, MaskV, PivotV});
}

SDValue VECustomDAG::getUniformConstMask(Packing Packing, unsigned NumElements,
                                         bool IsTrue) const {
  auto MaskVT = getMaskVT(Packing);

  // VEISelDAGtoDAG will replace this with the constant-true VM
  auto TrueVal = DAG.getConstant(-1, DL, MVT::i32);

  auto Res = getNode(VEISD::VEC_BROADCAST, MaskVT,
                     {TrueVal, getConstEVL(NumElements)});
  if (IsTrue)
    return Res;

  return DAG.getNOT(DL, Res, Res.getValueType());
}

bool isLegalAVL(SDValue AVL) { return AVL->getOpcode() == VEISD::LEGALAVL; }

/// Node Properties {

SDValue getNodeChain(SDValue Op) {
  if (MemSDNode *MemN = dyn_cast<MemSDNode>(Op.getNode()))
    return MemN->getChain();

  switch (Op->getOpcode()) {
  case VEISD::VVP_LOAD:
  case VEISD::VVP_STORE:
  case VEISD::VVP_GATHER:
  case VEISD::VVP_SCATTER:
    return Op->getOperand(0);
  }
  return SDValue();
}

SDValue getMemoryPtr(SDValue Op) {
  if (auto *MemN = dyn_cast<MemSDNode>(Op.getNode()))
    return MemN->getBasePtr();

  switch (Op->getOpcode()) {
  case VEISD::VVP_GATHER:
  case VEISD::VVP_LOAD:
    return Op->getOperand(1);
  case VEISD::VVP_SCATTER:
  case VEISD::VVP_STORE:
    return Op->getOperand(2);
  }
  return SDValue();
}

std::optional<EVT> getIdiomaticVectorType(SDNode *Op) {
  unsigned OC = Op->getOpcode();

  // For memory ops -> the transfered data type
  if (auto MemN = dyn_cast<MemSDNode>(Op))
    return MemN->getMemoryVT();

  switch (OC) {
  // Standard ISD.
  case ISD::SELECT: // not aliased with VVP_SELECT
  case ISD::CONCAT_VECTORS:
  case ISD::EXTRACT_SUBVECTOR:
  case ISD::VECTOR_SHUFFLE:
  case ISD::BUILD_VECTOR:
  case ISD::SCALAR_TO_VECTOR:
    return Op->getValueType(0);
  }

  // Translate to VVP where possible.
  unsigned OriginalOC = OC;
  if (auto VVPOpc = getVVPOpcode(OC))
    OC = *VVPOpc;

  if (isVVPReductionOp(OC))
    return Op->getOperand(hasReductionStartParam(OriginalOC) ? 1 : 0)
        .getValueType();

  switch (OC) {
  default:
  case VEISD::VVP_SETCC:
    return Op->getOperand(0).getValueType();

  case VEISD::VVP_SELECT:
#define ADD_BINARY_VVP_OP(VVP_NAME, ...) case VEISD::VVP_NAME:
#include "VVPNodes.def"
    return Op->getValueType(0);

  case VEISD::VVP_LOAD:
    return Op->getValueType(0);

  case VEISD::VVP_STORE:
    return Op->getOperand(1)->getValueType(0);

  // VEC
  case VEISD::VEC_BROADCAST:
    return Op->getValueType(0);
  }
}

SDValue getLoadStoreStride(SDValue Op, VECustomDAG &CDAG) {
  switch (Op->getOpcode()) {
  case VEISD::VVP_STORE:
    return Op->getOperand(3);
  case VEISD::VVP_LOAD:
    return Op->getOperand(2);
  }

  if (auto *StoreN = dyn_cast<VPStridedStoreSDNode>(Op.getNode()))
    return StoreN->getStride();
  if (auto *StoreN = dyn_cast<VPStridedLoadSDNode>(Op.getNode()))
    return StoreN->getStride();

  if (isa<MemSDNode>(Op.getNode())) {
    // Regular MLOAD/MSTORE/LOAD/STORE
    // No stride argument -> use the contiguous element size as stride.
    uint64_t ElemStride = getIdiomaticVectorType(Op.getNode())
                              ->getVectorElementType()
                              .getStoreSize();
    return CDAG.getConstant(ElemStride, MVT::i64);
  }
  return SDValue();
}

SDValue getGatherScatterIndex(SDValue Op) {
  if (auto *N = dyn_cast<MaskedGatherScatterSDNode>(Op.getNode()))
    return N->getIndex();
  if (auto *N = dyn_cast<VPGatherScatterSDNode>(Op.getNode()))
    return N->getIndex();
  return SDValue();
}

SDValue getGatherScatterScale(SDValue Op) {
  if (auto *N = dyn_cast<MaskedGatherScatterSDNode>(Op.getNode()))
    return N->getScale();
  if (auto *N = dyn_cast<VPGatherScatterSDNode>(Op.getNode()))
    return N->getScale();
  return SDValue();
}

SDValue getStoredValue(SDValue Op) {
  switch (Op->getOpcode()) {
  case VEISD::VVP_SCATTER:
  case VEISD::VVP_STORE:
    return Op->getOperand(1);
  }
  if (auto *StoreN = dyn_cast<StoreSDNode>(Op.getNode()))
    return StoreN->getValue();
  if (auto *StoreN = dyn_cast<MaskedStoreSDNode>(Op.getNode()))
    return StoreN->getValue();
  if (auto *StoreN = dyn_cast<VPStridedStoreSDNode>(Op.getNode()))
    return StoreN->getValue();
  if (auto *StoreN = dyn_cast<VPStoreSDNode>(Op.getNode()))
    return StoreN->getValue();
  if (auto *StoreN = dyn_cast<MaskedScatterSDNode>(Op.getNode()))
    return StoreN->getValue();
  if (auto *StoreN = dyn_cast<VPScatterSDNode>(Op.getNode()))
    return StoreN->getValue();
  return SDValue();
}

SDValue getNodePassthru(SDValue Op) {
  if (auto *N = dyn_cast<MaskedLoadSDNode>(Op.getNode()))
    return N->getPassThru();
  if (auto *N = dyn_cast<MaskedGatherSDNode>(Op.getNode()))
    return N->getPassThru();

  return SDValue();
}

bool hasReductionStartParam(unsigned OPC) {
  // TODO: Ordered reduction opcodes.
  if (ISD::isVPReduction(OPC))
    return true;
  return false;
}

/// } Node Properties

std::pair<SDValue, bool> getAnnotatedNodeAVL(SDValue Op) {
  SDValue AVL = getNodeAVL(Op);
  if (!AVL)
    return {SDValue(), true};
  if (isLegalAVL(AVL))
    return {AVL->getOperand(0), true};
  return {AVL, false};
}

SDValue VECustomDAG::getConstant(uint64_t Val, EVT VT, bool IsTarget,
                                 bool IsOpaque) const {
  return DAG.getConstant(Val, DL, VT, IsTarget, IsOpaque);
}

void VECustomDAG::dumpValue(SDValue V) const { V->print(dbgs(), &DAG); }

SDValue VECustomDAG::getConstantMask(Packing Packing, bool AllTrue) const {
  auto MaskVT = getLegalVectorType(Packing, MVT::i1);

  // VEISelDAGtoDAG will replace this pattern with the constant-true VM.
  auto TrueVal = DAG.getConstant(-1, DL, MVT::i32);
  auto AVL = getConstant(MaskVT.getVectorNumElements(), MVT::i32);
  auto Res = getNode(VEISD::VEC_BROADCAST, MaskVT, {TrueVal, AVL});
  if (AllTrue)
    return Res;

  return DAG.getNOT(DL, Res, Res.getValueType());
}

SDValue VECustomDAG::getMaskBroadcast(EVT ResultVT, SDValue Scalar,
                                      SDValue AVL) const {
  // Constant mask splat.
  if (auto BcConst = dyn_cast<ConstantSDNode>(Scalar))
    return getConstantMask(getTypePacking(ResultVT),
                           BcConst->getSExtValue() != 0);

  // Expand the broadcast to a vector comparison.
  auto ScalarBoolVT = Scalar.getSimpleValueType();
  assert(ScalarBoolVT == MVT::i32);

  // Cast to i32 ty.
  SDValue CmpElem = DAG.getSExtOrTrunc(Scalar, DL, MVT::i32);
  unsigned ElemCount = ResultVT.getVectorNumElements();
  MVT CmpVecTy = MVT::getVectorVT(ScalarBoolVT, ElemCount);

  // Broadcast to vector.
  SDValue BCVec =
      DAG.getNode(VEISD::VEC_BROADCAST, DL, CmpVecTy, {CmpElem, AVL});
  SDValue ZeroVec =
      getBroadcast(CmpVecTy, {DAG.getConstant(0, DL, ScalarBoolVT)}, AVL);

  MVT BoolVecTy = MVT::getVectorVT(MVT::i1, ElemCount);

  // Broadcast(Data) != Broadcast(0)
  // TODO: Use a VVP operation for this.
  return DAG.getSetCC(DL, BoolVecTy, BCVec, ZeroVec, ISD::CondCode::SETNE);
}

SDValue VECustomDAG::getVectorExtract(SDValue VecV, SDValue IdxV) const {
  assert(VecV.getValueType().isVector());
  auto ElemVT = VecV.getValueType().getVectorElementType();
  return getNode(ISD::EXTRACT_VECTOR_ELT, ElemVT, {VecV, IdxV});
}

SDValue VECustomDAG::getVectorInsert(SDValue DestVecV, SDValue ElemV,
                                     SDValue IdxV) const {
  assert(DestVecV.getValueType().isVector());
  return getNode(ISD::INSERT_VECTOR_ELT, DestVecV.getValueType(),
                 {DestVecV, ElemV, IdxV});
}

SDValue VECustomDAG::getMaskCast(SDValue VectorV, SDValue AVL) const {
  if (isMaskType(VectorV.getValueType()))
    return VectorV;

  if (isPackedVectorType(VectorV.getValueType())) {
    auto ValVT = VectorV.getValueType();
    auto LoPart = getUnpack(splitVectorType(ValVT), VectorV, PackElem::Lo, AVL);
    auto HiPart = getUnpack(splitVectorType(ValVT), VectorV, PackElem::Hi, AVL);
    auto LoMask = getMaskCast(LoPart, AVL);
    auto HiMask = getMaskCast(HiPart, AVL);
    const auto PackedMaskVT = MVT::v512i1;
    return getPack(PackedMaskVT, LoMask, HiMask, AVL);
  }

  return DAG.getNode(VEISD::VEC_TOMASK, DL, getMaskVTFor(VectorV),
                     {VectorV, AVL});
}

EVT VECustomDAG::legalizeVectorType(SDValue Op, VVPExpansionMode Mode) const {
  return VLI.LegalizeVectorType(Op->getValueType(0), Op, DAG, Mode);
}

SDValue VECustomDAG::getTokenFactor(ArrayRef<SDValue> Tokens) const {
  return DAG.getNode(ISD::TokenFactor, DL, MVT::Other, Tokens);
}

SDValue VECustomDAG::getVVPLoad(EVT LegalResVT, SDValue Chain, SDValue PtrV,
                                SDValue StrideV, SDValue MaskV,
                                SDValue AVL) const {
  return DAG.getNode(VEISD::VVP_LOAD, DL, {LegalResVT, MVT::Other},
                     {Chain, PtrV, StrideV, MaskV, AVL});
}

SDValue VECustomDAG::getVVPStore(SDValue Chain, SDValue DataV, SDValue PtrV,
                                 SDValue StrideV, SDValue MaskV,
                                 SDValue AVL) const {
  return DAG.getNode(VEISD::VVP_STORE, DL, MVT::Other,
                     {Chain, DataV, PtrV, StrideV, MaskV, AVL});
}

SDValue VECustomDAG::getVVPGather(EVT LegalResVT, SDValue ChainV, SDValue PtrV,
                                  SDValue MaskV, SDValue AVL) const {
  return DAG.getNode(VEISD::VVP_GATHER, DL, {LegalResVT, MVT::Other},
                     {ChainV, PtrV, MaskV, AVL});
}

SDValue VECustomDAG::getVVPScatter(SDValue ChainV, SDValue DataV, SDValue PtrV,
                                   SDValue MaskV, SDValue AVL) const {
  return DAG.getNode(VEISD::VVP_SCATTER, DL, MVT::Other,
                     {ChainV, DataV, PtrV, MaskV, AVL});
}

SDValue VECustomDAG::extractPackElem(SDValue Op, PackElem Part,
                                     SDValue AVL) const {
  EVT OldValVT = Op.getValue(0).getValueType();
  if (!OldValVT.isVector())
    return Op;

  // TODO peek through pack operations
  return getUnpack(splitVectorType(OldValVT), Op, Part, AVL);
}

SDValue VECustomDAG::getConstantTargetMask(VVPWideningInfo WidenInfo) const {
  /// Use the eventual native vector width for all newly generated operands
  // we do not want to go through ::ReplaceNodeResults again only to have them
  // widened
  unsigned NativeVectorWidth =
      WidenInfo.PackedMode ? PackedVectorWidth : StandardVectorWidth;

  // Generate a remainder mask for packed operations
  Packing PackFlag = WidenInfo.PackedMode ? Packing::Dense : Packing::Normal;
  if (!WidenInfo.NeedsPackedMasking) {
    return getUniformConstMask(PackFlag, NativeVectorWidth, true);

  } else {
    // TODO only really generate a mask if there is a change the operation will
    // benefit from it (eg, for vfdiv)
    PackedLaneBits MaskBits;
    MaskBits.reset();
    MaskBits.flip();
    size_t OddRemainderBitPos = WidenInfo.ActiveVectorLength;
    MaskBits[OddRemainderBitPos] = false;
    return getConstMask<>(PackedVectorWidth, MaskBits);
  }
}

SDValue VECustomDAG::getTargetAVL(VVPWideningInfo WidenInfo) const {
  // Legalize the AVL
  if (WidenInfo.PackedMode) {
    return getConstEVL((WidenInfo.ActiveVectorLength + 1) / 2);
  } else {
    return getConstEVL(WidenInfo.ActiveVectorLength);
  }
}

VETargetMasks VECustomDAG::getTargetSplitMask(VVPWideningInfo WidenInfo,
                                              SDValue RawMask, SDValue RawAVL,
                                              PackElem Part) const {
  // No masking caused, we simply adjust the AVL for the parts
  SDValue NewAVL;
  if (!RawAVL) {
    unsigned PartAVL = WidenInfo.ActiveVectorLength / 2;
    if (WidenInfo.NeedsPackedMasking) {
      PartAVL += (int)(Part == PackElem::Lo);
    }
    NewAVL = getConstEVL(PartAVL);
  } else if (WidenInfo.NeedsPackedMasking) {
    if (Part == PackElem::Hi) {
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
    NewMask = getUniformConstMask(Packing::Normal, true);
  } else {
    NewMask = extractPackElem(RawMask, Part, NewAVL);
  }

  return VETargetMasks(NewMask, NewAVL);
}

VETargetMasks VECustomDAG::getTargetMask(VVPWideningInfo WidenInfo,
                                         SDValue RawMask,
                                         SDValue RawAVL) const {
  bool IsDynamicAVL = RawAVL && !isa<ConstantSDNode>(RawAVL);

  // Legalize AVL
  SDValue NewAVL;
  if (!RawAVL) {
    NewAVL = getTargetAVL(WidenInfo);
  } else if (auto ConstAVL = dyn_cast<ConstantSDNode>(RawAVL)) {
    WidenInfo.ActiveVectorLength = std::min<unsigned>(
        ConstAVL->getZExtValue(), WidenInfo.ActiveVectorLength);
    NewAVL = getTargetAVL(WidenInfo);
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
    NewMask = getConstantTargetMask(WidenInfo);
  } else {
    NewMask = RawMask;
  }

  return VETargetMasks(NewMask, NewAVL);
}

SDValue VECustomDAG::getTargetInsertSubreg(int SRIdx, EVT VT, SDValue Operand,
                                           SDValue SubReg) const {
  return DAG.getTargetInsertSubreg(SRIdx, DL, VT, Operand, SubReg);
}

SDValue VECustomDAG::getIDIV(bool IsSigned, EVT ResVT, SDValue Dividend,
                             SDValue Divisor, SDValue Mask, SDValue AVL) const {
  return getNode(IsSigned ? VEISD::VVP_SDIV : VEISD::VVP_UDIV, ResVT,
                 {Dividend, Divisor, Mask, AVL});
}

SDValue VECustomDAG::getIREM(bool IsSigned, EVT ResVT, SDValue Dividend,
                             SDValue Divisor, SDValue Mask, SDValue AVL) const {
  // Based on lib/CodeGen/SelectionDAG/TargetLowering.cpp ::expandREM code.
  // X % Y -> X-X/Y*Y
  SDValue Divide = getIDIV(IsSigned, ResVT, Dividend, Divisor, Mask, AVL);
  SDValue Mul = getNode(VEISD::VVP_MUL, ResVT, {Divisor, Divide, Mask, AVL});
  return getNode(VEISD::VVP_SUB, ResVT, {Dividend, Mul, Mask, AVL});
}

static std::optional<unsigned> getNonVVPMaskOp(unsigned VVPOC, EVT ResVT) {
  if (!isMaskType(ResVT))
    return std::nullopt;
  switch (VVPOC) {
  default:
    return std::nullopt;

  case VEISD::VVP_AND:
    return ISD::AND;
  case VEISD::VVP_OR:
    return ISD::OR;
  case VEISD::VVP_XOR:
    return ISD::XOR;
  }
}

SDValue VECustomDAG::getLegalConvOpVVP(unsigned VVPOpcode, EVT ResVT,
                                       SDValue VectorV, SDValue Mask,
                                       SDValue AVL, SDNodeFlags Flags) const {
  if (VectorV.getValueType() == ResVT)
    return VectorV;
  return getNode(VVPOpcode, ResVT, {VectorV, Mask, AVL}, Flags);
}

SDValue VECustomDAG::getLegalBinaryOpVVP(unsigned VVPOpcode, EVT ResVT,
                                         SDValue A, SDValue B, SDValue Mask,
                                         SDValue AVL, SDNodeFlags Flags) const {
  // Ignore AVL, Mask in mask arithmetic and expand to a standard ISD.
  if (std::optional<unsigned> PlainOpc = getNonVVPMaskOp(VVPOpcode, ResVT))
    return getNode(*PlainOpc, ResVT, {A, B});

  // Expand S/UREM.
  if (VVPOpcode == VEISD::VVP_UREM)
    return getIREM(false, ResVT, A, B, Mask, AVL);
  if (VVPOpcode == VEISD::VVP_SREM)
    return getIREM(true, ResVT, A, B, Mask, AVL);

  // Lower to the VVP node by default.
  SDValue V = getNode(VVPOpcode, ResVT, {A, B, Mask, AVL});
  V->setFlags(Flags);
  return V;
}

SDValue VECustomDAG::foldAndUnpackMask(SDValue MaskVector, SDValue Mask,
                                       PackElem Part, SDValue AVL) const {
  auto PartV = getUnpack(MVT::v256i1, Mask, Part, AVL);
  if (isAllTrueMask(Mask))
    return PartV;

  auto PartMask = getUnpack(MVT::v256i1, Mask, Part, AVL);
  return getNode(ISD::AND, MVT::v256i1, {PartV, PartMask});
}

SDValue VECustomDAG::getLegalReductionOpVVP(unsigned VVPOpcode, EVT ResVT,
                                            SDValue StartV, SDValue VectorV,
                                            SDValue Mask, SDValue AVL,
                                            SDNodeFlags Flags) const {

  // Optionally attach the start param with a scalar op (where it is
  // unsupported).
  bool scalarizeStartParam = StartV && !hasVVPReductionStartParam(VVPOpcode);
  bool IsMaskReduction = isMaskType(VectorV.getValueType());
  auto AttachStartValue = [&](SDValue ReductionResV) {
    if (!scalarizeStartParam)
      return ReductionResV;
    auto ScalarOC = getScalarReductionOpcode(VVPOpcode, IsMaskReduction);
    return getNode(ScalarOC, ResVT, {StartV, ReductionResV});
  };

  if (!IsMaskReduction) {
    // Fixup: Always Use sequential 'fmul' reduction.
    if (VVPOpcode == VEISD::VVP_REDUCE_FMUL) {
      VVPOpcode = VEISD::VVP_REDUCE_SEQ_FMUL;
      return getNode(VVPOpcode, ResVT, {StartV, VectorV, Mask, AVL}, Flags);
    }

    if (!scalarizeStartParam && StartV) {
      assert(hasVVPReductionStartParam(VVPOpcode));
      return AttachStartValue(
          getNode(VVPOpcode, ResVT, {StartV, VectorV, Mask, AVL}, Flags));
    } else
      return AttachStartValue(
          getNode(VVPOpcode, ResVT, {VectorV, Mask, AVL}, Flags));
  }

  switch (VVPOpcode) {
  default:
    abort(); // TODO implement
  case VEISD::VVP_REDUCE_ADD:
  case VEISD::VVP_REDUCE_XOR: {
    // Mask legalization using vm_popcount
    if (!isAllTrueMask(Mask))
      VectorV = getNode(ISD::AND, Mask.getValueType(), {VectorV, Mask});

    auto Pop = getMaskPopcount(VectorV, AVL);
    auto LegalPop = DAG.getZExtOrTrunc(Pop, DL, MVT::i32);
    auto OneV = getConstant(1, MVT::i32);
    return AttachStartValue(getNode(ISD::AND, MVT::i32, {LegalPop, OneV}));
  }
  case VEISD::VVP_REDUCE_UMAX:
  case VEISD::VVP_REDUCE_SMIN:
  case VEISD::VVP_REDUCE_OR: {
    // Mask legalization using vm_popcount
    if (!isAllTrueMask(Mask))
      VectorV = getNode(ISD::AND, Mask.getValueType(), {VectorV, Mask});

    auto Pop = getMaskPopcount(VectorV, AVL);
    auto LegalPop = DAG.getZExtOrTrunc(Pop, DL, MVT::i32);

    // FIXME: Should be 'true' if \p Mask is all-false..
    auto ZeroV = getConstant(0, MVT::i32);
    return AttachStartValue(
        getNode(ISD::SETCC, MVT::i32,
                {LegalPop, ZeroV, DAG.getCondCode(ISD::CondCode::SETNE)}));
  }
  case VEISD::VVP_REDUCE_UMIN:
  case VEISD::VVP_REDUCE_SMAX:
  case VEISD::VVP_REDUCE_MUL:
  case VEISD::VVP_REDUCE_AND: {
    // TODO: Invert and OR the mask, then compare PCVM against AVL.

    // Mask legalization using vm_popcount
    if (!isAllTrueMask(Mask))
      VectorV = getNode(ISD::AND, Mask.getValueType(), {VectorV, Mask});

    auto Pop = getMaskPopcount(VectorV, AVL);
    auto LegalPop = DAG.getZExtOrTrunc(Pop, DL, MVT::i32);

    return AttachStartValue(
        getNode(ISD::SETCC, MVT::i32,
                {LegalPop, AVL, DAG.getCondCode(ISD::CondCode::SETEQ)}));
  }
  }
}

SDValue VECustomDAG::getZExtInReg(SDValue Op, EVT VT) const {
  return DAG.getZeroExtendInReg(Op, DL, VT);
}

SDValue VECustomDAG::getBitReverse(SDValue ScalarReg) const {
  assert(ScalarReg.getValueType() == MVT::i64);
  return getNode(ISD::BITREVERSE, MVT::i64, ScalarReg);
}

void VECustomDAG::dump(SDValue V) const { print(errs(), V); }

raw_ostream &VECustomDAG::print(raw_ostream &Out, SDValue V) const {
  V->print(Out, &DAG);
  return Out;
}

SDValue VECustomDAG::annotateLegalAVL(SDValue AVL) const {
  if (isLegalAVL(AVL))
    return AVL;
  return getNode(VEISD::LEGALAVL, AVL.getValueType(), AVL);
}

/// } class VECustomDAG

SDValue VECustomDAG::getUnpack(EVT DestVT, SDValue Vec, PackElem Part,
                               SDValue AVL) const {
  if (SDValue SimplifiedV =
          foldUnpackFromBroadcast(Vec, Part, DestVT, AVL, *this))
    return SimplifiedV;
  // Immediately fold unpack from pack.
  if (SDValue PackedV = foldUnpackFromPack(Vec, Part, DestVT))
    return PackedV;

  unsigned OC = getUnpackOpcodeForPart(Part);
  return DAG.getNode(OC, DL, DestVT, Vec, AVL);
}

SDValue VECustomDAG::getPack(EVT DestVT, SDValue LowV, SDValue HighV,
                             SDValue AVL) const {
  // TODO Peek through paired unpacks!
  return DAG.getNode(VEISD::VEC_PACK, DL, DestVT, LowV, HighV, AVL);
}

SDValue VECustomDAG::getSplitPtrOffset(SDValue Ptr, SDValue ByteStride,
                                       PackElem Part) const {
  // High starts at base ptr but has more significant bits in the 64bit vector
  // element.
  if (Part == PackElem::Hi)
    return Ptr;
  return getNode(ISD::ADD, MVT::i64, {Ptr, ByteStride});
}

SDValue VECustomDAG::getSplitPtrStride(SDValue PackStride) const {
  if (auto ConstBytes = dyn_cast<ConstantSDNode>(PackStride))
    return getConstant(2 * ConstBytes->getSExtValue(), MVT::i64);
  return getNode(ISD::SHL, MVT::i64, {PackStride, getConstant(1, MVT::i32)});
}

SDValue VECustomDAG::getGatherScatterAddress(SDValue BasePtr, SDValue Scale,
                                             SDValue Index, SDValue Mask,
                                             SDValue AVL) const {
  EVT IndexVT = Index.getValueType();

  // Apply scale.
  SDValue ScaledIndex;
  if (!Scale || isOneConstant(Scale))
    ScaledIndex = Index;
  else {
    SDValue ScaleBroadcast = getBroadcast(IndexVT, Scale, AVL);
    ScaledIndex =
        getNode(VEISD::VVP_MUL, IndexVT, {Index, ScaleBroadcast, Mask, AVL});
  }

  // Add basePtr.
  if (isNullConstant(BasePtr))
    return ScaledIndex;

  // re-constitute pointer vector (basePtr + index * scale)
  SDValue BaseBroadcast = getBroadcast(IndexVT, BasePtr, AVL);
  auto ResPtr =
      getNode(VEISD::VVP_ADD, IndexVT, {BaseBroadcast, ScaledIndex, Mask, AVL});
  return ResPtr;
}

} // namespace llvm
