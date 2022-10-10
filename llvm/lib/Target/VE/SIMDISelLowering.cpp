//===-- SIMDISelLowering.cpp - VE DAG Lowering Implementation -------------===//
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
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/KnownBits.h"
#include <cmath>

using namespace llvm;

#define DEBUG_TYPE "ve-isel"

/// Register experimental vector actions which are used under -mattr=+vec.
void VETargetLowering::initSIMDActions() {
  for (MVT VT : MVT::vector_valuetypes()) {
    if (VT.getVectorElementType() == MVT::i1 ||
        VT.getVectorElementType() == MVT::i8 ||
        VT.getVectorElementType() == MVT::i16) {
      // VE uses vXi1 types but has no generic operations.
      // VE doesn't support vXi8 and vXi16 value types.
      // So, we mark them all as expanded.

      // Expand all vector-i8/i16-vector truncstore and extload
      for (MVT OuterVT : MVT::vector_valuetypes()) {
        setTruncStoreAction(OuterVT, VT, Expand);
        setLoadExtAction(ISD::SEXTLOAD, OuterVT, VT, Expand);
        setLoadExtAction(ISD::ZEXTLOAD, OuterVT, VT, Expand);
        setLoadExtAction(ISD::EXTLOAD, OuterVT, VT, Expand);
      }
      // SExt i1 and ZExt i1 are legal.
      if (VT.getVectorElementType() == MVT::i1) {
        setOperationAction(ISD::SIGN_EXTEND, VT, Legal);
        setOperationAction(ISD::ZERO_EXTEND, VT, Legal);
        setOperationAction(ISD::INSERT_VECTOR_ELT, VT, Expand);
        setOperationAction(ISD::EXTRACT_VECTOR_ELT, VT, Custom);
      } else {
        setOperationAction(ISD::SIGN_EXTEND, VT, Expand);
        setOperationAction(ISD::ZERO_EXTEND, VT, Expand);
        setOperationAction(ISD::INSERT_VECTOR_ELT, VT, Expand);
        setOperationAction(ISD::EXTRACT_VECTOR_ELT, VT, Expand);
      }

      // STORE for vXi1 needs to be custom lowered to expand multiple
      // instructions.
      if (VT.getVectorElementType() == MVT::i1) {
        setOperationAction(ISD::STORE, VT, Custom);
        setOperationAction(ISD::LOAD, VT, Custom);
      }

      setOperationAction(ISD::SCALAR_TO_VECTOR, VT, Expand);
      if (VT.getVectorElementType() == MVT::i1) {
        setOperationAction(ISD::BUILD_VECTOR, VT, Custom);
      } else {
        setOperationAction(ISD::BUILD_VECTOR, VT, Expand);
      }
      setOperationAction(ISD::CONCAT_VECTORS, VT, Expand);
      setOperationAction(ISD::INSERT_SUBVECTOR, VT, Expand);
      setOperationAction(ISD::EXTRACT_SUBVECTOR, VT, Expand);
      setOperationAction(ISD::VECTOR_SHUFFLE, VT, Expand);

      setOperationAction(ISD::FP_EXTEND, VT, Expand);
      setOperationAction(ISD::FP_ROUND, VT, Expand);

      setOperationAction(ISD::FABS, VT, Expand);
      setOperationAction(ISD::FNEG, VT, Expand);
      setOperationAction(ISD::FADD, VT, Expand);
      setOperationAction(ISD::FSUB, VT, Expand);
      setOperationAction(ISD::FMUL, VT, Expand);
      setOperationAction(ISD::FDIV, VT, Expand);
      setOperationAction(ISD::ADD, VT, Expand);
      setOperationAction(ISD::SUB, VT, Expand);
      setOperationAction(ISD::MUL, VT, Expand);
      setOperationAction(ISD::SDIV, VT, Expand);
      setOperationAction(ISD::UDIV, VT, Expand);

      setOperationAction(ISD::SHL, VT, Expand);

      setOperationAction(ISD::MSCATTER, VT, Expand);
      setOperationAction(ISD::MGATHER, VT, Expand);
      setOperationAction(ISD::MLOAD, VT, Expand);

      // VE vector unit supports only setcc and vselect
      setOperationAction(ISD::SELECT_CC, VT, Expand);

      // VE doesn't have instructions for fp<->uint, so expand them by llvm
      setOperationAction(ISD::FP_TO_UINT, VT, Promote); // use i64
      setOperationAction(ISD::UINT_TO_FP, VT, Promote); // use i64
    } else {
      setOperationAction(ISD::SCALAR_TO_VECTOR, VT, Legal);
      setOperationAction(ISD::INSERT_VECTOR_ELT, VT, Custom);
      setOperationAction(ISD::EXTRACT_VECTOR_ELT, VT, Custom);
      setOperationAction(ISD::BUILD_VECTOR, VT, Custom);
      setOperationAction(ISD::CONCAT_VECTORS, VT, Expand);
      setOperationAction(ISD::INSERT_SUBVECTOR, VT, Expand);
      setOperationAction(ISD::EXTRACT_SUBVECTOR, VT, Expand);
      setOperationAction(ISD::VECTOR_SHUFFLE, VT, Custom);

      setOperationAction(ISD::FP_EXTEND, VT, Legal);
      setOperationAction(ISD::FP_ROUND, VT, Legal);

      // currently unsupported math functions
      setOperationAction(ISD::FABS, VT, Expand);

      // supported calculations
      setOperationAction(ISD::FNEG, VT, Legal);
      setOperationAction(ISD::FADD, VT, Legal);
      setOperationAction(ISD::FSUB, VT, Legal);
      setOperationAction(ISD::FMUL, VT, Legal);
      setOperationAction(ISD::FDIV, VT, Legal);
      setOperationAction(ISD::ADD, VT, Legal);
      setOperationAction(ISD::SUB, VT, Legal);
      setOperationAction(ISD::MUL, VT, Legal);
      setOperationAction(ISD::SDIV, VT, Legal);
      setOperationAction(ISD::UDIV, VT, Legal);

      setOperationAction(ISD::SHL, VT, Legal);

      setOperationAction(ISD::MSCATTER, VT, Custom);
      setOperationAction(ISD::MGATHER, VT, Custom);
      setOperationAction(ISD::MLOAD, VT, Custom);

      // VE vector unit supports only setcc and vselect
      setOperationAction(ISD::SELECT_CC, VT, Expand);

      // VE doesn't have instructions for fp<->uint, so expand them by llvm
      if (VT.getVectorElementType() == MVT::i32) {
        setOperationAction(ISD::FP_TO_UINT, VT, Promote); // use i64
        setOperationAction(ISD::UINT_TO_FP, VT, Promote); // use i64
      } else {
        setOperationAction(ISD::FP_TO_UINT, VT, Expand);
        setOperationAction(ISD::UINT_TO_FP, VT, Expand);
      }
    }
  }

  // VE has no packed MUL, SDIV, or UDIV operations.
  for (MVT VT : {MVT::v512i32, MVT::v512f32}) {
    setOperationAction(ISD::MUL, VT, Expand);
    setOperationAction(ISD::SDIV, VT, Expand);
    setOperationAction(ISD::UDIV, VT, Expand);
  }

  // VE has no REM or DIVREM operations.
  for (MVT VT : MVT::vector_valuetypes()) {
    setOperationAction(ISD::UREM, VT, Expand);
    setOperationAction(ISD::SREM, VT, Expand);
    setOperationAction(ISD::SDIVREM, VT, Expand);
    setOperationAction(ISD::UDIVREM, VT, Expand);
  }

  // vector fma // TESTING
  for (MVT VT : MVT::vector_valuetypes()) {
    setOperationAction(ISD::FMA, VT, Legal);
    // setOperationAction(ISD::FMAD, VT, Legal);
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
}

SDValue VETargetLowering::lowerSIMD_MGATHER_MSCATTER(SDValue Op,
                                                     SelectionDAG &DAG) const {
  LLVM_DEBUG(dbgs() << "Lowering gather or scatter\n");
  SDLoc dl(Op);
  // dbgs() << "\nNext Instr:\n";
  // Op.dumpr(&DAG);

  MaskedGatherScatterSDNode *N = cast<MaskedGatherScatterSDNode>(Op.getNode());

  SDValue Index = N->getIndex();
  SDValue BasePtr = N->getBasePtr();
  SDValue Mask = N->getMask();
  SDValue Chain = N->getChain();

  SDValue PassThru;
  SDValue Source;

  if (Op.getOpcode() == ISD::MGATHER) {
    MaskedGatherSDNode *N = cast<MaskedGatherSDNode>(Op.getNode());
    PassThru = N->getPassThru();
  } else if (Op.getOpcode() == ISD::MSCATTER) {
    MaskedScatterSDNode *N = cast<MaskedScatterSDNode>(Op.getNode());
    Source = N->getValue();
  } else {
    return SDValue();
  }

  MVT IndexVT = Index.getSimpleValueType();
  // MVT MaskVT = Mask.getSimpleValueType();
  // MVT BasePtrVT = BasePtr.getSimpleValueType();

  // vindex = vindex + baseptr;
  int Length = Mask.getNumOperands();
  auto VL = DAG.getConstant(Length, dl, MVT::i32);
  SDValue BaseBroadcast =
      DAG.getNode(VEISD::VEC_BROADCAST, dl, IndexVT, BasePtr, VL);
  SDValue ScaleBroadcast =
      DAG.getNode(VEISD::VEC_BROADCAST, dl, IndexVT, N->getScale(), VL);

  SDValue index_addr =
      DAG.getNode(ISD::MUL, dl, IndexVT, {Index, ScaleBroadcast});

  SDValue addresses =
      DAG.getNode(ISD::ADD, dl, IndexVT, {BaseBroadcast, index_addr});

  // TODO: vmx = svm (mask);
  // Mask.dumpr(&DAG);
  if (Mask.getOpcode() != ISD::BUILD_VECTOR || Mask.getNumOperands() != 256) {
    LLVM_DEBUG(dbgs() << "Cannot handle gathers with complex masks.\n");
    return SDValue();
  }
  for (unsigned i = 0; i < 256; i++) {
    const SDValue Operand = Mask.getOperand(i);
    if (Operand.getOpcode() != ISD::Constant) {
      LLVM_DEBUG(
          dbgs() << "Cannot handle gather masks with complex elements.\n");
      return SDValue();
    }
    if (Mask.getConstantOperandVal(i) != 1) {
      LLVM_DEBUG(dbgs() << "Cannot handle gather masks with elements != 1.\n");
      return SDValue();
    }
  }

  if (Op.getOpcode() == ISD::MGATHER) {
    // vt = vgt (vindex, vmx, cs=0, sx=0, sy=0, sw=0);
    SDValue load = DAG.getNode(VEISD::VEC_GATHER, dl, Op.getNode()->getVTList(),
                               {Chain, addresses});
    // load.dumpr(&DAG);

    // TODO: merge (vt, default, vmx);
    // PassThru.dumpr(&DAG);
    // We can safely ignore PassThru right now, the mask is guaranteed to be
    // constant 1s.

    return load;
  } else {
    SDValue store =
        DAG.getNode(VEISD::VEC_SCATTER, dl, Op.getNode()->getVTList(),
                    {Chain, Source, addresses});
    // store.dumpr(&DAG);
    return store;
  }
}

SDValue VETargetLowering::lowerSIMD_MLOAD(SDValue Op, SelectionDAG &DAG) const {
  LLVM_DEBUG(dbgs() << "Lowering MLOAD\n");
  LLVM_DEBUG(Op.dumpr(&DAG));
  SDLoc dl(Op);

  MaskedLoadSDNode *N = cast<MaskedLoadSDNode>(Op.getNode());

  SDValue BasePtr = N->getBasePtr();
  SDValue Mask = N->getMask();
  SDValue Chain = N->getChain();
  SDValue PassThru = N->getPassThru();

  MachinePointerInfo info = N->getPointerInfo();

  if (Mask.getOpcode() != ISD::BUILD_VECTOR || Mask.getNumOperands() != 256) {
    LLVM_DEBUG(dbgs() << "Cannot handle gathers with complex masks.\n");
    return SDValue();
  }

  int firstzero = 256;

  for (unsigned i = 0; i < 256; i++) {
    const SDValue Operand = Mask.getOperand(i);
    if (Operand.getOpcode() != ISD::Constant) {
      LLVM_DEBUG(dbgs() << "Cannot handle load masks with complex elements.\n");
      return SDValue();
    }
    if (Mask.getConstantOperandVal(i) != 1) {
      if (firstzero == 256)
        firstzero = i;
      if (!PassThru.isUndef() && !PassThru.getOperand(i).isUndef()) {
        LLVM_DEBUG(dbgs() << "Cannot handle passthru.\n");
        return SDValue();
      }
    } else {
      if (firstzero != 256) {
        LLVM_DEBUG(dbgs() << "Cannot handle mixed load masks.\n");
        return SDValue();
      }
    }
  }

  EVT i32 = EVT::getIntegerVT(*DAG.getContext(), 32);

  // FIXME: LVL instruction has output VL now, need to update VEC_LVL too.
  Chain = DAG.getNode(VEISD::VEC_LVL, dl, MVT::Other,
                      {Chain, DAG.getConstant(firstzero, dl, i32)});

  SDValue load = DAG.getLoad(Op.getSimpleValueType(), dl, Chain, BasePtr, info);

  // FIXME: LVL instruction has output VL now, need to update VEC_LVL too.
  Chain = DAG.getNode(VEISD::VEC_LVL, dl, MVT::Other,
                      {load.getValue(1), DAG.getConstant(256, dl, i32)});

  SDValue merge = DAG.getMergeValues({load, Chain}, dl);
  LLVM_DEBUG(dbgs() << "Becomes\n");
  LLVM_DEBUG(merge.dumpr(&DAG));
  return merge;
}

static bool isBroadCastOrS2V(BuildVectorSDNode *BVN, bool &AllUndef, bool &S2V,
                             unsigned &FirstDef) {
  // Check UNDEF or FirstDef
  AllUndef = true;
  S2V = false;
  FirstDef = 0;
  for (unsigned i = 0; i < BVN->getNumOperands(); ++i) {
    if (!BVN->getOperand(i).isUndef()) {
      AllUndef = false;
      FirstDef = i;
      break;
    }
  }
  if (AllUndef)
    return true;
  // Check scalar_to_vector (single def at first, and the rests are undef)
  if (FirstDef == 0) {
    S2V = true;
    for (unsigned i = FirstDef + 1; i < BVN->getNumOperands(); ++i) {
      if (!BVN->getOperand(i).isUndef()) {
        S2V = false;
        break;
      }
    }
    if (S2V)
      return true;
  }
  // Check boradcast
  for (unsigned i = FirstDef + 1; i < BVN->getNumOperands(); ++i) {
    if (BVN->getOperand(FirstDef) != BVN->getOperand(i) &&
        !BVN->getOperand(i).isUndef()) {
      return false;
    }
  }
  return true;
}

SDValue VETargetLowering::lowerSIMD_BUILD_VECTOR(SDValue Op,
                                                 SelectionDAG &DAG) const {
  LLVM_DEBUG(dbgs() << "Lowering BUILD_VECTOR\n");
  BuildVectorSDNode *BVN = cast<BuildVectorSDNode>(Op.getNode());

  SDLoc DL(Op);

  // match VEC_BROADCAST
  bool AllUndef;
  bool S2V;
  unsigned FirstDef;
  if (isBroadCastOrS2V(BVN, AllUndef, S2V, FirstDef)) {
    if (AllUndef) {
      LLVM_DEBUG(dbgs() << "AllUndef: VEC_BROADCAST ");
      LLVM_DEBUG(BVN->getOperand(0)->dump());
      int Length = BVN->getNumOperands();
      auto VL = DAG.getConstant(Length, DL, MVT::i32);
      return DAG.getNode(VEISD::VEC_BROADCAST, DL, Op.getSimpleValueType(),
                         BVN->getOperand(0), VL);
    } else if (S2V) {
      LLVM_DEBUG(dbgs() << "isS2V: scalar_to_vector ");
      LLVM_DEBUG(BVN->getOperand(FirstDef)->dump());
      return DAG.getNode(ISD::SCALAR_TO_VECTOR, DL, Op.getSimpleValueType(),
                         BVN->getOperand(FirstDef));
    } else {
      LLVM_DEBUG(dbgs() << "isBroadCast: VEC_BROADCAST ");
      LLVM_DEBUG(BVN->getOperand(FirstDef)->dump());
      int Length = BVN->getNumOperands();
      auto VL = DAG.getConstant(Length, DL, MVT::i32);
      return DAG.getNode(VEISD::VEC_BROADCAST, DL, Op.getSimpleValueType(),
                         BVN->getOperand(FirstDef), VL);
    }
  }

#if 0
  if (BVN->isConstant()) {
    // All values are either a constant value or undef, so optimize it...
  }
#endif

  // match VEC_SEQ(stride) patterns
  // identify a constant stride vector
  bool hasConstantStride = true;

  // whether the constant is a repetition of ascending indices, eg <0, 1, 2, 3,
  // 0, 1, 2, 3, ..>
  bool hasBlockStride = false;

  // whether the constant is an ascending sequence of repeated indices, eg <0,
  // 0, 1, 1, 2, 2, 3, 3 ..>
  bool hasBlockStride2 = false;

  bool firstStride = true;
  int64_t blockLength = 0;
  int64_t stride = 0;
  int64_t lastElemValue = 0;
  MVT elemTy;

  for (unsigned i = 0; i < BVN->getNumOperands(); ++i) {
    if (hasBlockStride) {
      if (i % blockLength == 0)
        stride = 1;
      else
        stride = 0;
    }

    if (BVN->getOperand(i).isUndef()) {
      if (hasBlockStride2 && i % blockLength == 0)
        lastElemValue = 0;
      else
        lastElemValue += stride;
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
    elemTy = constNumElem->getSimpleValueType(0);

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
      stride = (elemValue - lastElemValue) / (i - FirstDef);
      firstStride = false;
    } else if (i > FirstDef) {
      // later stride
      if (hasBlockStride2 && elemValue == 0 && i % blockLength == 0) {
        lastElemValue = 0;
        continue;
      }
      int64_t thisStride = elemValue - lastElemValue;
      if (thisStride != stride) {
        hasConstantStride = false;
        if (!hasBlockStride && thisStride == 1 && stride == 0 &&
            lastElemValue == 0) {
          hasBlockStride = true;
          blockLength = i;
        } else if (!hasBlockStride2 && elemValue == 0 &&
                   lastElemValue + 1 == i) {
          hasBlockStride2 = true;
          blockLength = i;
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

  // detected a proper stride pattern
  if (hasConstantStride) {
    SDValue seq = DAG.getNode(
        VEISD::VEC_SEQ, DL, Op.getSimpleValueType(),
        DAG.getConstant(256, DL, MVT::i32)); // TODO draw strideTy from elements
    if (stride == 1) {
      LLVM_DEBUG(dbgs() << "ConstantStride: VEC_SEQ\n");
      LLVM_DEBUG(seq.dump());
      return seq;
    }

    int Length = BVN->getNumOperands();
    auto VL = DAG.getConstant(Length, DL, MVT::i32);
    SDValue const_stride =
        DAG.getNode(VEISD::VEC_BROADCAST, DL, Op.getSimpleValueType(),
                    DAG.getConstant(stride, DL, elemTy), VL);
    SDValue ret =
        DAG.getNode(ISD::MUL, DL, Op.getSimpleValueType(), {seq, const_stride});
    LLVM_DEBUG(dbgs() << "ConstantStride: VEC_SEQ * VEC_BROADCAST\n");
    LLVM_DEBUG(const_stride.dump());
    LLVM_DEBUG(ret.dump());
    return ret;
  }

  // codegen for <0, 0, .., 0, 0, 1, 1, .., 1, 1, .....> constant patterns
  // constant == VSEQ >> log2(blockLength)
  if (hasBlockStride) {
    int64_t blockLengthLog = log2(blockLength);

    if (pow(2, blockLengthLog) == blockLength) {
      SDValue sequence =
          DAG.getNode(VEISD::VEC_SEQ, DL, Op.getSimpleValueType(),
                      DAG.getConstant(256, DL, MVT::i32));
      int Length = Op.getSimpleValueType().getVectorNumElements();
      auto VL = DAG.getConstant(Length, DL, MVT::i32);
      SDValue shiftbroadcast =
          DAG.getNode(VEISD::VEC_BROADCAST, DL, Op.getSimpleValueType(),
                      DAG.getConstant(blockLengthLog, DL, elemTy), VL);

      SDValue shift = DAG.getNode(ISD::SRL, DL, Op.getSimpleValueType(),
                                  {sequence, shiftbroadcast});
      LLVM_DEBUG(dbgs() << "BlockStride: VEC_SEQ >> VEC_BROADCAST\n");
      LLVM_DEBUG(sequence.dump());
      LLVM_DEBUG(shiftbroadcast.dump());
      LLVM_DEBUG(shift.dump());
      return shift;
    }
  }

  // codegen for <0, 1, .., 15, 0, 1, .., ..... > constant patterns
  // constant == VSEQ % blockLength
  if (hasBlockStride2) {
    int64_t blockLengthLog = log2(blockLength);

    if (pow(2, blockLengthLog) == blockLength) {
      SDValue sequence =
          DAG.getNode(VEISD::VEC_SEQ, DL, Op.getSimpleValueType(),
                      DAG.getConstant(256, DL, MVT::i32));
      int Length = Op.getSimpleValueType().getVectorNumElements();
      auto VL = DAG.getConstant(Length, DL, MVT::i32);
      SDValue modulobroadcast =
          DAG.getNode(VEISD::VEC_BROADCAST, DL, Op.getSimpleValueType(),
                      DAG.getConstant(blockLength - 1, DL, elemTy), VL);

      SDValue modulo = DAG.getNode(ISD::AND, DL, Op.getSimpleValueType(),
                                   {sequence, modulobroadcast});

      LLVM_DEBUG(dbgs() << "BlockStride2: VEC_SEQ & VEC_BROADCAST\n");
      LLVM_DEBUG(sequence.dump());
      LLVM_DEBUG(modulobroadcast.dump());
      LLVM_DEBUG(modulo.dump());
      return modulo;
    }
  }

  // Otherwise, generate element-wise insertions.
  SDValue newVector = SDValue(DAG.getMachineNode(TargetOpcode::IMPLICIT_DEF, DL,
                                                 Op.getSimpleValueType()),
                              0);

  for (unsigned i = 0; i < BVN->getNumOperands(); ++i) {
    newVector = DAG.getNode(
        ISD::INSERT_VECTOR_ELT, DL, Op.getSimpleValueType(), newVector,
        BVN->getOperand(i),
        DAG.getConstant(i, DL, EVT::getIntegerVT(*DAG.getContext(), 64)));
  }
  return newVector;
}

SDValue VETargetLowering::lowerSIMD_VECTOR_SHUFFLE(SDValue Op,
                                                   SelectionDAG &DAG) const {
  LLVM_DEBUG(dbgs() << "Lowering Shuffle\n");
  SDLoc dl(Op);
  ShuffleVectorSDNode *ShuffleInstr = cast<ShuffleVectorSDNode>(Op.getNode());

  SDValue firstVec = ShuffleInstr->getOperand(0);
  int firstVecLength = firstVec.getSimpleValueType().getVectorNumElements();
  SDValue secondVec = ShuffleInstr->getOperand(1);
  int secondVecLength = secondVec.getSimpleValueType().getVectorNumElements();

  MVT ElementType = Op.getSimpleValueType().getScalarType();
  int resultSize = Op.getSimpleValueType().getVectorNumElements();

  if (ShuffleInstr->isSplat()) {
    int index = ShuffleInstr->getSplatIndex();
    if (index >= firstVecLength) {
      index -= firstVecLength;
      SDValue elem = DAG.getNode(
          ISD::EXTRACT_VECTOR_ELT, dl, ElementType,
          {secondVec,
           DAG.getConstant(index, dl,
                           EVT::getIntegerVT(*DAG.getContext(), 64))});
      int Length = Op.getSimpleValueType().getVectorNumElements();
      auto VL = DAG.getConstant(Length, dl, MVT::i32);
      return DAG.getNode(VEISD::VEC_BROADCAST, dl, Op.getSimpleValueType(),
                         elem, VL);
    } else {
      SDValue elem = DAG.getNode(
          ISD::EXTRACT_VECTOR_ELT, dl, ElementType,
          {firstVec, DAG.getConstant(
                         index, dl, EVT::getIntegerVT(*DAG.getContext(), 64))});
      int Length = Op.getSimpleValueType().getVectorNumElements();
      auto VL = DAG.getConstant(Length, dl, MVT::i32);
      return DAG.getNode(VEISD::VEC_BROADCAST, dl, Op.getSimpleValueType(),
                         elem, VL);
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
      DAG.getMachineNode(VE::LEAzii, dl, MVT::i64,
                         DAG.getTargetConstant(0, dl, MVT::i32),
                         DAG.getTargetConstant(0, dl, MVT::i32),
                         DAG.getTargetConstant(resultSize, dl, MVT::i32)),
      0);
  SDValue SubLow32 = DAG.getTargetConstant(VE::sub_i32, dl, MVT::i32);
  VL = SDValue(
      DAG.getMachineNode(TargetOpcode::EXTRACT_SUBREG, dl, i32, VL, SubLow32),
      0);
  // SDValue VL = DAG.getTargetConstant(resultSize, dl, MVT::i32);
  SDValue firstrotated =
      firstrot % 256 != 0
          ? SDValue(
                DAG.getMachineNode(
                    VE::VMVivl, dl, firstVec.getSimpleValueType(),
                    {DAG.getConstant(firstrot % 256, dl, i32), firstVec, VL}),
                0)
          : firstVec;
  SDValue secondrotated =
      secondrot % 256 != 0
          ? SDValue(
                DAG.getMachineNode(
                    VE::VMVivl, dl, secondVec.getSimpleValueType(),
                    {DAG.getConstant(secondrot % 256, dl, i32), secondVec, VL}),
                0)
          : secondVec;

  int block = firstsecond / 64;
  int secondblock = firstsecond % 64;

  SDValue Mask = DAG.getUNDEF(v256i1);

  for (int i = 0; i < block; i++) {
    // set blocks to all 0s
    SDValue mask = inv_order ? DAG.getConstant(0xffffffffffffffff, dl, i64)
                             : DAG.getConstant(0, dl, i64);
    SDValue index = DAG.getTargetConstant(i, dl, i64);
    Mask = SDValue(
        DAG.getMachineNode(VE::LVMir_m, dl, v256i1, {index, mask, Mask}), 0);
  }

  SDValue mask = DAG.getConstant(0xffffffffffffffff, dl, i64);
  if (!inv_order)
    mask = DAG.getNode(ISD::SRL, dl, i64,
                       {mask, DAG.getConstant(secondblock, dl, i64)});
  else
    mask = DAG.getNode(ISD::SHL, dl, i64,
                       {mask, DAG.getConstant(64 - secondblock, dl, i64)});
  Mask = SDValue(
      DAG.getMachineNode(VE::LVMir_m, dl, v256i1,
                         {DAG.getTargetConstant(block, dl, i64), mask, Mask}),
      0);

  for (int i = block + 1; i < 4; i++) {
    // set blocks to all 1s
    SDValue mask = inv_order ? DAG.getConstant(0, dl, i64)
                             : DAG.getConstant(0xffffffffffffffff, dl, i64);
    SDValue index = DAG.getTargetConstant(i, dl, i64);
    Mask = SDValue(
        DAG.getMachineNode(VE::LVMir_m, dl, v256i1, {index, mask, Mask}), 0);
  }

  SDValue returnValue =
      SDValue(DAG.getMachineNode(VE::VMRGvvml, dl, Op.getSimpleValueType(),
                                 {firstrotated, secondrotated, Mask, VL}),
              0);
  return returnValue;
}

SDValue VETargetLowering::lowerSIMD_INSERT_VECTOR_ELT(SDValue Op,
                                                      SelectionDAG &DAG) const {
  assert(Op.getOpcode() == ISD::INSERT_VECTOR_ELT && "Unknown opcode!");
  EVT VT = Op.getOperand(0).getValueType();

  // Special treatements for packed V64 types.
  if (VT == MVT::v512i32 || VT == MVT::v512f32) {
    // The v512i32 and v512f32 starts from upper bits (0..31).  This "upper
    // bits" required `val << 32` from C implementation's point of view.
    //
    // Example of codes:
    //   %packed_elt = extractelt %vr, (%idx >> 1)
    //   %shift = ((%idx & 1) ^ 1) << 5
    //   %packed_elt &= 0xffffffff00000000 >> shift
    //   %packed_elt |= (zext %val) << shift
    //   %vr = insertelt %vr, %packed_elt, (%idx >> 1)

    SDLoc DL(Op);
    SDValue Vec = Op.getOperand(0);
    SDValue Val = Op.getOperand(1);
    SDValue Idx = Op.getOperand(2);
    if (Idx.getValueType() == MVT::i32)
      Idx = DAG.getNode(ISD::ZERO_EXTEND, DL, MVT::i64, Idx);
    if (Val.getValueType() == MVT::f32)
      Val = DAG.getBitcast(MVT::i32, Val);
    assert(Val.getValueType() == MVT::i32);
    Val = DAG.getNode(ISD::ZERO_EXTEND, DL, MVT::i64, Val);

    SDValue Result = Op;
    if (false /* Idx->isConstant()*/) {
      // FIXME: optimized implementation using constant values
    } else {
      SDValue Const1 = DAG.getConstant(1, DL, MVT::i64);
      SDValue HalfIdx = DAG.getNode(ISD::SRL, DL, MVT::i64, {Idx, Const1});
      SDValue PackedElt = SDValue(
          DAG.getMachineNode(VE::LVSvr, DL, MVT::i64, {Vec, HalfIdx}), 0);
      SDValue AndIdx = DAG.getNode(ISD::AND, DL, MVT::i64, {Idx, Const1});
      SDValue Shift = DAG.getNode(ISD::XOR, DL, MVT::i64, {AndIdx, Const1});
      SDValue Const5 = DAG.getConstant(5, DL, MVT::i64);
      Shift = DAG.getNode(ISD::SHL, DL, MVT::i64, {Shift, Const5});
      SDValue Mask = DAG.getConstant(0xFFFFFFFF00000000L, DL, MVT::i64);
      Mask = DAG.getNode(ISD::SRL, DL, MVT::i64, {Mask, Shift});
      PackedElt = DAG.getNode(ISD::AND, DL, MVT::i64, {PackedElt, Mask});
      Val = DAG.getNode(ISD::SHL, DL, MVT::i64, {Val, Shift});
      PackedElt = DAG.getNode(ISD::OR, DL, MVT::i64, {PackedElt, Val});
      Result =
          SDValue(DAG.getMachineNode(VE::LSVrr_v, DL, Vec.getSimpleValueType(),
                                     {HalfIdx, PackedElt, Vec}),
                  0);
    }
    return Result;
  }

  // Insertion is legal for other V64 types.
  return Op;
}

SDValue
VETargetLowering::lowerSIMD_EXTRACT_VECTOR_ELT(SDValue Op,
                                               SelectionDAG &DAG) const {
  assert(Op.getOpcode() == ISD::EXTRACT_VECTOR_ELT && "Unknown opcode!");
  EVT VT = Op.getOperand(0).getValueType();

  // Special treatements for packed V64 types.
  if (VT == MVT::v512i32 || VT == MVT::v512f32) {
    // The v512i32 and v512f32 starts from upper bits (0..31).  This "upper
    // bits" required `val << 32` from C implementation's point of view.
    //
    // Example of codes:
    //   %packed_elt = extractelt %vr, (%idx >> 1)
    //   %shift = ((%idx & 1) ^ 1) << 5
    //   %packed_elt >> = shift
    //   %res = %packed_elt & 0xffffffff

    SDLoc DL(Op);
    SDValue Vec = Op.getOperand(0);
    SDValue Idx = Op.getOperand(1);
    if (Idx.getValueType() == MVT::i32)
      Idx = DAG.getNode(ISD::ZERO_EXTEND, DL, MVT::i64, Idx);

    SDValue Result = Op;
    if (false /* Idx->isConstant() */) {
      // FIXME: optimized implementation using constant values
    } else {
      SDValue Const1 = DAG.getConstant(1, DL, MVT::i64);
      SDValue HalfIdx = DAG.getNode(ISD::SRL, DL, MVT::i64, {Idx, Const1});
      SDValue PackedElt = SDValue(
          DAG.getMachineNode(VE::LVSvr, DL, MVT::i64, {Vec, HalfIdx}), 0);
      SDValue AndIdx = DAG.getNode(ISD::AND, DL, MVT::i64, {Idx, Const1});
      SDValue Shift = DAG.getNode(ISD::XOR, DL, MVT::i64, {AndIdx, Const1});
      SDValue Const5 = DAG.getConstant(5, DL, MVT::i64);
      Shift = DAG.getNode(ISD::SHL, DL, MVT::i64, {Shift, Const5});
      PackedElt = DAG.getNode(ISD::SRL, DL, MVT::i64, {PackedElt, Shift});
      SDValue Mask = DAG.getConstant(0xFFFFFFFFL, DL, MVT::i64);
      PackedElt = DAG.getNode(ISD::AND, DL, MVT::i64, {PackedElt, Mask});
      SDValue SubI32 = DAG.getTargetConstant(VE::sub_i32, DL, MVT::i32);
      Result = SDValue(DAG.getMachineNode(TargetOpcode::EXTRACT_SUBREG, DL,
                                          MVT::i32, PackedElt, SubI32),
                       0);

      if (Op.getValueType() == MVT::f32) {
        Result = DAG.getBitcast(MVT::f32, Result);
      } else {
        assert(Op.getValueType() == MVT::i32);
      }
    }
    return Result;
  }

  // Extraction is legal for other V64 types.
  return Op;
}


SDValue VETargetLowering::LowerOperation_SIMD(SDValue Op, SelectionDAG &DAG) const {
  LLVM_DEBUG(dbgs() << "LowerOp_SIMD: "; Op.dump(&DAG); dbgs() << "\n";);

  switch (Op.getOpcode()) {
  default:
    llvm_unreachable("Should not custom lower this!");
  // vector composition
  case ISD::BUILD_VECTOR:
    return lowerSIMD_BUILD_VECTOR(Op, DAG);
  case ISD::VECTOR_SHUFFLE:
    return lowerSIMD_VECTOR_SHUFFLE(Op, DAG);
  case ISD::INSERT_VECTOR_ELT:
    return lowerSIMD_INSERT_VECTOR_ELT(Op, DAG);
  case ISD::EXTRACT_VECTOR_ELT:
    return lowerSIMD_EXTRACT_VECTOR_ELT(Op, DAG);
  case ISD::MSCATTER:
  case ISD::MGATHER:
    return lowerSIMD_MGATHER_MSCATTER(Op, DAG);
  case ISD::MLOAD:
    return lowerSIMD_MLOAD(Op, DAG);

  // Explicit fallthrough.
  case VEISD::VEC_BROADCAST:
  case VEISD::VEC_SEQ:
    return Op;
  }
}
