//===-- VVPISelLowering.cpp - VE DAG Lowering Implementation --------------===//
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
using namespace llvm;

#define DEBUG_TYPE "ve-isel"

static SDValue getSplatValue(SDNode *N) {
  if (auto *BuildVec = dyn_cast<BuildVectorSDNode>(N)) {
    return BuildVec->getSplatValue();
  }
  return SDValue();
}

SDValue VETargetLowering::lowerVVP_BUILD_VECTOR(SDValue Op,
                                                SelectionDAG &DAG) const {
  SDLoc DL(Op);
  unsigned NumEls = Op.getValueType().getVectorNumElements();
  MVT ElemVT = Op.getSimpleValueType().getVectorElementType();

  if (SDValue ScalarV = getSplatValue(Op.getNode())) {
    // lower to VEC_BROADCAST
    MVT LegalResVT = MVT::getVectorVT(ElemVT, 256);

    auto AVL = DAG.getConstant(NumEls, DL, MVT::i32);
    return DAG.getNode(VEISD::VEC_BROADCAST, DL, LegalResVT, Op.getOperand(0),
                       AVL);
  }

  // Expand
  return SDValue();
}

/// \returns the VVP_* SDNode opcode corresponsing to \p OC.
static Optional<unsigned> getVVPOpcode(unsigned OC) {
  switch (OC) {
#define ADD_VVP_OP(VVPNAME, SDNAME)                                            \
  case VEISD::VVPNAME:                                                         \
  case ISD::SDNAME:                                                            \
    return VEISD::VVPNAME;
#include "VVPNodes.def"
  }
  return None;
}

SDValue VETargetLowering::lowerToVVP(SDValue Op, SelectionDAG &DAG) const {
  // Can we represent this as a VVP node.
  auto OCOpt = getVVPOpcode(Op->getOpcode());
  if (!OCOpt.hasValue())
    return SDValue();
  unsigned VVPOC = OCOpt.getValue();

  // The representative and legalized vector type of this operation.
  EVT OpVecVT = Op.getValueType();
  EVT LegalVecVT = getTypeToTransformTo(*DAG.getContext(), OpVecVT);

  // Materialize the VL parameter.
  SDLoc DL(Op);
  SDValue AVL = DAG.getConstant(OpVecVT.getVectorNumElements(), DL, MVT::i32);
  MVT MaskVT = MVT::v256i1;
  SDValue ConstTrue = DAG.getConstant(1, DL, MVT::i32);
  SDValue Mask = DAG.getNode(VEISD::VEC_BROADCAST, DL, MaskVT,
                             ConstTrue); // emit a VEISD::VEC_BROADCAST here.

  // Categories we are interested in.
  bool IsBinaryOp = false;

  switch (VVPOC) {
#define ADD_BINARY_VVP_OP(VVPNAME, ...)                                        \
  case VEISD::VVPNAME:                                                         \
    IsBinaryOp = true;                                                         \
    break;
#include "VVPNodes.def"
  }

  if (IsBinaryOp) {
    assert(LegalVecVT.isSimple());
    return DAG.getNode(VVPOC, DL, LegalVecVT, Op->getOperand(0),
                       Op->getOperand(1), Mask, AVL);
  }
  llvm_unreachable("lowerToVVP called for unexpected SDNode.");
}
