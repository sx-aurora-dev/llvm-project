//===-- VEISelLowering.cpp - VE DAG Lowering Implementation ---------------===//
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

#include "VEISelLowering.h"
#include "MCTargetDesc/VEMCExpr.h"
#include "VEInstrBuilder.h"
#include "VEMachineFunctionInfo.h"
#include "VERegisterInfo.h"
#include "VETargetMachine.h"
#include "llvm/ADT/StringSwitch.h"
#include "llvm/ADT/iterator_range.h"
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
#include "llvm/IR/IntrinsicsVE.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/KnownBits.h"

#define DEBUG_TYPE "ve-lower"

using namespace llvm;

//===----------------------------------------------------------------------===//
// Calling Convention Implementation
//===----------------------------------------------------------------------===//

#include "VEGenCallingConv.inc"

CCAssignFn *getReturnCC(CallingConv::ID CallConv) {
  switch (CallConv) {
  default:
    return RetCC_VE_Fast; // hpce/develop default
  case CallingConv::Fast:
    return RetCC_VE_Fast;
  }
}

CCAssignFn *getParamCC(CallingConv::ID CallConv, bool IsVarArg) {
  if (IsVarArg)
    return CC_VE2;
  switch (CallConv) {
  default:
    return CC_VE_Fast; // hpce/develop default
  case CallingConv::Fast:
    return CC_VE_Fast;
  }
}

bool VETargetLowering::CanLowerReturn(
    CallingConv::ID CallConv, MachineFunction &MF, bool IsVarArg,
    const SmallVectorImpl<ISD::OutputArg> &Outs, LLVMContext &Context) const {
  CCAssignFn *RetCC = getReturnCC(CallConv);
  SmallVector<CCValAssign, 16> RVLocs;
  CCState CCInfo(CallConv, IsVarArg, MF, RVLocs, Context);
  return CCInfo.CheckReturn(Outs, RetCC);
}


static const MVT AllVectorVTs[] = {MVT::v256i32, MVT::v512i32, MVT::v256i64,
                                   MVT::v256f32, MVT::v512f32, MVT::v256f64};

static const MVT WholeVectorVTs[] = {
    MVT::v512i32, MVT::v512f32, MVT::v256i32, MVT::v256f32, MVT::v256i64,
    MVT::v256f64, MVT::v128i32, MVT::v128f32, MVT::v128i64, MVT::v128f64,
    MVT::v64i32,  MVT::v64f32,  MVT::v64i64,  MVT::v64f64,  MVT::v32i32,
    MVT::v32f32,  MVT::v32i64,  MVT::v32f64,  MVT::v16i32,  MVT::v16f32,
    MVT::v16i64,  MVT::v16f64,  MVT::v8i32,   MVT::v8f32,   MVT::v8i64,
    MVT::v8f64,   MVT::v4i32,   MVT::v4f32,   MVT::v4i64,   MVT::v4f64,
    MVT::v2i32,   MVT::v2f32,   MVT::v2i64,   MVT::v2f64,
};

static const MVT All256MaskVTs[] = {
    MVT::v256i1, MVT::v128i1, MVT::v64i1, MVT::v32i1,
    MVT::v16i1,  MVT::v8i1,   MVT::v4i1,  MVT::v2i1,
};

void VETargetLowering::initRegisterClasses() {
  // Set up the register classes.
  addRegisterClass(MVT::i32, &VE::I32RegClass);
  addRegisterClass(MVT::i64, &VE::I64RegClass);
  addRegisterClass(MVT::f32, &VE::F32RegClass);
  addRegisterClass(MVT::f64, &VE::I64RegClass);
  addRegisterClass(MVT::f128, &VE::F128RegClass);

#if 0
  if (!Subtarget->enableVPU())
    return;

  for (MVT VecVT : AllVectorVTs)
    if (!IsPackedType(VecVT) || Subtarget->hasPackedMode())
      addRegisterClass(VecVT, &VE::V64RegClass);

  addRegisterClass(MVT::v256i1, &VE::VMRegClass);
  if (Subtarget->hasPackedMode())
    addRegisterClass(MVT::v512i1, &VE::VM512RegClass);
#else
  if (Subtarget->enableVPU()) {
    for (MVT VecVT : AllVectorVTs)
      addRegisterClass(VecVT, &VE::V64RegClass);
    addRegisterClass(MVT::v512i1, &VE::VM512RegClass);
    addRegisterClass(MVT::v256i1, &VE::VMRegClass);
    return;
  }
  
  if (Subtarget->vectorize()) {
    for (MVT VecVT : WholeVectorVTs)
      addRegisterClass(VecVT, &VE::V64RegClass);
    addRegisterClass(MVT::v512i1, &VE::VM512RegClass);
    for (MVT MaskVT : All256MaskVTs)
      addRegisterClass(MaskVT, &VE::VMRegClass);
    return;
  }
  assert(Subtarget->intrinsic());
  for (MVT VecVT : AllVectorVTs)
    addRegisterClass(VecVT, &VE::V64RegClass);
  addRegisterClass(MVT::v512i1, &VE::VM512RegClass);
  addRegisterClass(MVT::v256i1, &VE::VMRegClass);
#endif
}


SDValue
VETargetLowering::LowerReturn(SDValue Chain, CallingConv::ID CallConv,
                              bool IsVarArg,
                              const SmallVectorImpl<ISD::OutputArg> &Outs,
                              const SmallVectorImpl<SDValue> &OutVals,
                              const SDLoc &DL, SelectionDAG &DAG) const {
  // CCValAssign - represent the assignment of the return value to locations.
  SmallVector<CCValAssign, 16> RVLocs;

  // CCState - Info about the registers and stack slot.
  CCState CCInfo(CallConv, IsVarArg, DAG.getMachineFunction(), RVLocs,
                 *DAG.getContext());

  // Analyze return values.
  // CCValAssign - represent the assignment of the return value to locations.
  CCInfo.AnalyzeReturn(Outs, getReturnCC(CallConv));

  SDValue Flag;
  SmallVector<SDValue, 4> RetOps(1, Chain);

  // Copy the result values into the output registers.
  for (unsigned i = 0; i != RVLocs.size(); ++i) {
    CCValAssign &VA = RVLocs[i];
    assert(VA.isRegLoc() && "Can only return in registers!");
    SDValue OutVal = OutVals[i];

    // Integer return values must be sign or zero extended by the callee.
    switch (VA.getLocInfo()) {
    case CCValAssign::Full:
      break;
    case CCValAssign::SExt:
      OutVal = DAG.getNode(ISD::SIGN_EXTEND, DL, VA.getLocVT(), OutVal);
      break;
    case CCValAssign::ZExt:
      OutVal = DAG.getNode(ISD::ZERO_EXTEND, DL, VA.getLocVT(), OutVal);
      break;
    case CCValAssign::AExt:
      OutVal = DAG.getNode(ISD::ANY_EXTEND, DL, VA.getLocVT(), OutVal);
      break;
    case CCValAssign::BCvt: {
      // Convert a float return value to i64 with padding.
      //     63     31   0
      //    +------+------+
      //    | float|   0  |
      //    +------+------+
      assert(VA.getLocVT() == MVT::i64);
      assert(VA.getValVT() == MVT::f32);
      SDValue Undef = SDValue(
          DAG.getMachineNode(TargetOpcode::IMPLICIT_DEF, DL, MVT::i64), 0);
      SDValue Sub_f32 = DAG.getTargetConstant(VE::sub_f32, DL, MVT::i32);
      OutVal = SDValue(DAG.getMachineNode(TargetOpcode::INSERT_SUBREG, DL,
                                          MVT::i64, Undef, OutVal, Sub_f32),
                       0);
      break;
    }
    default:
      llvm_unreachable("Unknown loc info!");
    }

    assert(!VA.needsCustom() && "Unexpected custom lowering");

    Chain = DAG.getCopyToReg(Chain, DL, VA.getLocReg(), OutVal, Flag);

    // Guarantee that all emitted copies are stuck together with flags.
    Flag = Chain.getValue(1);
    RetOps.push_back(DAG.getRegister(VA.getLocReg(), VA.getLocVT()));
  }

  RetOps[0] = Chain; // Update chain.

  // Add the flag if we have it.
  if (Flag.getNode())
    RetOps.push_back(Flag);

  return DAG.getNode(VEISD::RET_FLAG, DL, MVT::Other, RetOps);
}

SDValue VETargetLowering::LowerFormalArguments(
    SDValue Chain, CallingConv::ID CallConv, bool IsVarArg,
    const SmallVectorImpl<ISD::InputArg> &Ins, const SDLoc &DL,
    SelectionDAG &DAG, SmallVectorImpl<SDValue> &InVals) const {
  MachineFunction &MF = DAG.getMachineFunction();

  // Get the base offset of the incoming arguments stack space.
  unsigned ArgsBaseOffset = Subtarget->getRsaSize();
  // Get the size of the preserved arguments area
  unsigned ArgsPreserved = 64;

  // Analyze arguments according to CC_VE.
  SmallVector<CCValAssign, 16> ArgLocs;
  CCState CCInfo(CallConv, IsVarArg, DAG.getMachineFunction(), ArgLocs,
                 *DAG.getContext());
  // Allocate the preserved area first.
  CCInfo.AllocateStack(ArgsPreserved, Align(8));
  // We already allocated the preserved area, so the stack offset computed
  // by CC_VE would be correct now.
  CCInfo.AnalyzeFormalArguments(Ins, getParamCC(CallConv, false));

  for (unsigned i = 0, e = ArgLocs.size(); i != e; ++i) {
    CCValAssign &VA = ArgLocs[i];
    if (VA.isRegLoc()) {
      // This argument is passed in a register.
      // All integer register arguments are promoted by the caller to i64.

      // Create a virtual register for the promoted live-in value.
      unsigned VReg =
          MF.addLiveIn(VA.getLocReg(), getRegClassFor(VA.getLocVT()));
      SDValue Arg = DAG.getCopyFromReg(Chain, DL, VReg, VA.getLocVT());

      assert(!VA.needsCustom() && "Unexpected custom lowering");

      // The caller promoted the argument, so insert an Assert?ext SDNode so we
      // won't promote the value again in this function.
      switch (VA.getLocInfo()) {
      case CCValAssign::SExt:
        Arg = DAG.getNode(ISD::AssertSext, DL, VA.getLocVT(), Arg,
                          DAG.getValueType(VA.getValVT()));
        break;
      case CCValAssign::ZExt:
        Arg = DAG.getNode(ISD::AssertZext, DL, VA.getLocVT(), Arg,
                          DAG.getValueType(VA.getValVT()));
        break;
      case CCValAssign::BCvt: {
        // Extract a float argument from i64 with padding.
        //     63     31   0
        //    +------+------+
        //    | float|   0  |
        //    +------+------+
        assert(VA.getLocVT() == MVT::i64);
        assert(VA.getValVT() == MVT::f32);
        SDValue Sub_f32 = DAG.getTargetConstant(VE::sub_f32, DL, MVT::i32);
        Arg = SDValue(DAG.getMachineNode(TargetOpcode::EXTRACT_SUBREG, DL,
                                         MVT::f32, Arg, Sub_f32),
                      0);
        break;
      }
      default:
        break;
      }

      // Truncate the register down to the argument type.
      if (VA.isExtInLoc())
        Arg = DAG.getNode(ISD::TRUNCATE, DL, VA.getValVT(), Arg);

      InVals.push_back(Arg);
      continue;
    }

    // The registers are exhausted. This argument was passed on the stack.
    assert(VA.isMemLoc());
    // The CC_VE_Full/Half functions compute stack offsets relative to the
    // beginning of the arguments area at %fp + the size of reserved area.
    unsigned Offset = VA.getLocMemOffset() + ArgsBaseOffset;
    unsigned ValSize = VA.getValVT().getSizeInBits() / 8;

    // Adjust offset for a float argument by adding 4 since the argument is
    // stored in 8 bytes buffer with offset like below.  LLVM generates
    // 4 bytes load instruction, so need to adjust offset here.  This
    // adjustment is required in only LowerFormalArguments.  In LowerCall,
    // a float argument is converted to i64 first, and stored as 8 bytes
    // data, which is required by ABI, so no need for adjustment.
    //    0      4
    //    +------+------+
    //    | empty| float|
    //    +------+------+
    if (VA.getValVT() == MVT::f32)
      Offset += 4;

    int FI = MF.getFrameInfo().CreateFixedObject(ValSize, Offset, true);
    InVals.push_back(
        DAG.getLoad(VA.getValVT(), DL, Chain,
                    DAG.getFrameIndex(FI, getPointerTy(MF.getDataLayout())),
                    MachinePointerInfo::getFixedStack(MF, FI)));
  }

  if (!IsVarArg)
    return Chain;

  // This function takes variable arguments, some of which may have been passed
  // in registers %s0-%s8.
  //
  // The va_start intrinsic needs to know the offset to the first variable
  // argument.
  // TODO: need to calculate offset correctly once we support f128.
  unsigned ArgOffset = ArgLocs.size() * 8;
  VEMachineFunctionInfo *FuncInfo = MF.getInfo<VEMachineFunctionInfo>();
  // Skip the reserved area at the top of stack.
  FuncInfo->setVarArgsFrameOffset(ArgOffset + ArgsBaseOffset);

  return Chain;
}

// FIXME? Maybe this could be a TableGen attribute on some registers and
// this table could be generated automatically from RegInfo.
Register VETargetLowering::getRegisterByName(const char *RegName, LLT VT,
                                             const MachineFunction &MF) const {
  Register Reg = StringSwitch<Register>(RegName)
                     .Case("sp", VE::SX11)    // Stack pointer
                     .Case("fp", VE::SX9)     // Frame pointer
                     .Case("sl", VE::SX8)     // Stack limit
                     .Case("lr", VE::SX10)    // Link register
                     .Case("tp", VE::SX14)    // Thread pointer
                     .Case("outer", VE::SX12) // Outer regiser
                     .Case("info", VE::SX17)  // Info area register
                     .Case("got", VE::SX15)   // Global offset table register
                     .Case("plt", VE::SX16) // Procedure linkage table register
                     .Case("usrcc", VE::USRCC) // User clock counter
                     .Default(0);

  if (Reg)
    return Reg;

  report_fatal_error("Invalid register name global variable");
}

//===----------------------------------------------------------------------===//
// TargetLowering Implementation
//===----------------------------------------------------------------------===//

SDValue VETargetLowering::LowerCall(TargetLowering::CallLoweringInfo &CLI,
                                    SmallVectorImpl<SDValue> &InVals) const {
  SelectionDAG &DAG = CLI.DAG;
  SDLoc DL = CLI.DL;
  SDValue Chain = CLI.Chain;
  auto PtrVT = getPointerTy(DAG.getDataLayout());

  // VE target does not yet support tail call optimization.
  CLI.IsTailCall = false;

  // Get the base offset of the outgoing arguments stack space.
  unsigned ArgsBaseOffset = Subtarget->getRsaSize();
  // Get the size of the preserved arguments area
  unsigned ArgsPreserved = 8 * 8u;

  // Analyze operands of the call, assigning locations to each operand.
  SmallVector<CCValAssign, 16> ArgLocs;
  CCState CCInfo(CLI.CallConv, CLI.IsVarArg, DAG.getMachineFunction(), ArgLocs,
                 *DAG.getContext());
  // Allocate the preserved area first.
  CCInfo.AllocateStack(ArgsPreserved, Align(8));
  // We already allocated the preserved area, so the stack offset computed
  // by CC_VE would be correct now.
  CCInfo.AnalyzeCallOperands(CLI.Outs, getParamCC(CLI.CallConv, false));

  // VE requires to use both register and stack for varargs or no-prototyped
  // functions.
  bool UseBoth = CLI.IsVarArg;

  // Analyze operands again if it is required to store BOTH.
  SmallVector<CCValAssign, 16> ArgLocs2;
  CCState CCInfo2(CLI.CallConv, CLI.IsVarArg, DAG.getMachineFunction(),
                  ArgLocs2, *DAG.getContext());
  if (UseBoth)
    CCInfo2.AnalyzeCallOperands(CLI.Outs, getParamCC(CLI.CallConv, true));

  // Get the size of the outgoing arguments stack space requirement.
  unsigned ArgsSize = CCInfo.getNextStackOffset();

  // Keep stack frames 16-byte aligned.
  ArgsSize = alignTo(ArgsSize, 16);

  // Adjust the stack pointer to make room for the arguments.
  // FIXME: Use hasReservedCallFrame to avoid %sp adjustments around all calls
  // with more than 6 arguments.
  Chain = DAG.getCALLSEQ_START(Chain, ArgsSize, 0, DL);

  // Collect the set of registers to pass to the function and their values.
  // This will be emitted as a sequence of CopyToReg nodes glued to the call
  // instruction.
  SmallVector<std::pair<unsigned, SDValue>, 8> RegsToPass;

  // Collect chains from all the memory opeations that copy arguments to the
  // stack. They must follow the stack pointer adjustment above and precede the
  // call instruction itself.
  SmallVector<SDValue, 8> MemOpChains;

  // VE needs to get address of callee function in a register
  // So, prepare to copy it to SX12 here.

  // If the callee is a GlobalAddress node (quite common, every direct call is)
  // turn it into a TargetGlobalAddress node so that legalize doesn't hack it.
  // Likewise ExternalSymbol -> TargetExternalSymbol.
  SDValue Callee = CLI.Callee;

  bool IsPICCall = isPositionIndependent();

  // PC-relative references to external symbols should go through $stub.
  // If so, we need to prepare GlobalBaseReg first.
  const TargetMachine &TM = DAG.getTarget();
  const Module *Mod = DAG.getMachineFunction().getFunction().getParent();
  const GlobalValue *GV = nullptr;
  if (auto *G = dyn_cast<GlobalAddressSDNode>(Callee))
    GV = G->getGlobal();
  bool Local = TM.shouldAssumeDSOLocal(*Mod, GV);
  bool UsePlt = !Local;
  MachineFunction &MF = DAG.getMachineFunction();

  // Turn GlobalAddress/ExternalSymbol node into a value node
  // containing the address of them here.
  if (GlobalAddressSDNode *G = dyn_cast<GlobalAddressSDNode>(Callee)) {
    if (IsPICCall) {
      if (UsePlt)
        Subtarget->getInstrInfo()->getGlobalBaseReg(&MF);
      Callee = DAG.getTargetGlobalAddress(G->getGlobal(), DL, PtrVT, 0, 0);
      Callee = DAG.getNode(VEISD::GETFUNPLT, DL, PtrVT, Callee);
    } else {
      Callee =
          makeHiLoPair(Callee, VEMCExpr::VK_VE_HI32, VEMCExpr::VK_VE_LO32, DAG);
    }
  } else if (ExternalSymbolSDNode *E = dyn_cast<ExternalSymbolSDNode>(Callee)) {
    if (IsPICCall) {
      if (UsePlt)
        Subtarget->getInstrInfo()->getGlobalBaseReg(&MF);
      Callee = DAG.getTargetExternalSymbol(E->getSymbol(), PtrVT, 0);
      Callee = DAG.getNode(VEISD::GETFUNPLT, DL, PtrVT, Callee);
    } else {
      Callee =
          makeHiLoPair(Callee, VEMCExpr::VK_VE_HI32, VEMCExpr::VK_VE_LO32, DAG);
    }
  }

  RegsToPass.push_back(std::make_pair(VE::SX12, Callee));

  for (unsigned i = 0, e = ArgLocs.size(); i != e; ++i) {
    CCValAssign &VA = ArgLocs[i];
    SDValue Arg = CLI.OutVals[i];

    // Promote the value if needed.
    switch (VA.getLocInfo()) {
    default:
      llvm_unreachable("Unknown location info!");
    case CCValAssign::Full:
      break;
    case CCValAssign::SExt:
      Arg = DAG.getNode(ISD::SIGN_EXTEND, DL, VA.getLocVT(), Arg);
      break;
    case CCValAssign::ZExt:
      Arg = DAG.getNode(ISD::ZERO_EXTEND, DL, VA.getLocVT(), Arg);
      break;
    case CCValAssign::AExt:
      Arg = DAG.getNode(ISD::ANY_EXTEND, DL, VA.getLocVT(), Arg);
      break;
    case CCValAssign::BCvt: {
      // Convert a float argument to i64 with padding.
      //     63     31   0
      //    +------+------+
      //    | float|   0  |
      //    +------+------+
      assert(VA.getLocVT() == MVT::i64);
      assert(VA.getValVT() == MVT::f32);
      SDValue Undef = SDValue(
          DAG.getMachineNode(TargetOpcode::IMPLICIT_DEF, DL, MVT::i64), 0);
      SDValue Sub_f32 = DAG.getTargetConstant(VE::sub_f32, DL, MVT::i32);
      Arg = SDValue(DAG.getMachineNode(TargetOpcode::INSERT_SUBREG, DL,
                                       MVT::i64, Undef, Arg, Sub_f32),
                    0);
      break;
    }
    }

    if (VA.isRegLoc()) {
      assert(!VA.needsCustom() && "Unexpected custom lowering");
      RegsToPass.push_back(std::make_pair(VA.getLocReg(), Arg));
      if (!UseBoth)
        continue;
      VA = ArgLocs2[i];
    }

    assert(VA.isMemLoc());

    // Create a store off the stack pointer for this argument.
    SDValue StackPtr = DAG.getRegister(VE::SX11, PtrVT);
    // The argument area starts at %fp/%sp + the size of reserved area.
    SDValue PtrOff =
        DAG.getIntPtrConstant(VA.getLocMemOffset() + ArgsBaseOffset, DL);
    PtrOff = DAG.getNode(ISD::ADD, DL, PtrVT, StackPtr, PtrOff);
    MemOpChains.push_back(
        DAG.getStore(Chain, DL, Arg, PtrOff, MachinePointerInfo()));
  }

  // Emit all stores, make sure they occur before the call.
  if (!MemOpChains.empty())
    Chain = DAG.getNode(ISD::TokenFactor, DL, MVT::Other, MemOpChains);

  // Build a sequence of CopyToReg nodes glued together with token chain and
  // glue operands which copy the outgoing args into registers. The InGlue is
  // necessary since all emitted instructions must be stuck together in order
  // to pass the live physical registers.
  SDValue InGlue;
  for (unsigned i = 0, e = RegsToPass.size(); i != e; ++i) {
    Chain = DAG.getCopyToReg(Chain, DL, RegsToPass[i].first,
                             RegsToPass[i].second, InGlue);
    InGlue = Chain.getValue(1);
  }

  // Build the operands for the call instruction itself.
  SmallVector<SDValue, 8> Ops;
  Ops.push_back(Chain);
  for (unsigned i = 0, e = RegsToPass.size(); i != e; ++i)
    Ops.push_back(DAG.getRegister(RegsToPass[i].first,
                                  RegsToPass[i].second.getValueType()));

  // Add a register mask operand representing the call-preserved registers.
  const VERegisterInfo *TRI = Subtarget->getRegisterInfo();
  const uint32_t *Mask =
      TRI->getCallPreservedMask(DAG.getMachineFunction(), CLI.CallConv);
  assert(Mask && "Missing call preserved mask for calling convention");
  Ops.push_back(DAG.getRegisterMask(Mask));

  // Make sure the CopyToReg nodes are glued to the call instruction which
  // consumes the registers.
  if (InGlue.getNode())
    Ops.push_back(InGlue);

  // Now the call itself.
  SDVTList NodeTys = DAG.getVTList(MVT::Other, MVT::Glue);
  Chain = DAG.getNode(VEISD::CALL, DL, NodeTys, Ops);
  InGlue = Chain.getValue(1);

  // Revert the stack pointer immediately after the call.
  Chain = DAG.getCALLSEQ_END(Chain, DAG.getIntPtrConstant(ArgsSize, DL, true),
                             DAG.getIntPtrConstant(0, DL, true), InGlue, DL);
  InGlue = Chain.getValue(1);

  // Now extract the return values. This is more or less the same as
  // LowerFormalArguments.

  // Assign locations to each value returned by this call.
  SmallVector<CCValAssign, 16> RVLocs;
  CCState RVInfo(CLI.CallConv, CLI.IsVarArg, DAG.getMachineFunction(), RVLocs,
                 *DAG.getContext());

  // Set inreg flag manually for codegen generated library calls that
  // return float.
  if (CLI.Ins.size() == 1 && CLI.Ins[0].VT == MVT::f32 && !CLI.CB)
    CLI.Ins[0].Flags.setInReg();

  RVInfo.AnalyzeCallResult(CLI.Ins, getReturnCC(CLI.CallConv));

  // Copy all of the result registers out of their specified physreg.
  for (unsigned i = 0; i != RVLocs.size(); ++i) {
    CCValAssign &VA = RVLocs[i];
    unsigned Reg = VA.getLocReg();

    // When returning 'inreg {i32, i32 }', two consecutive i32 arguments can
    // reside in the same register in the high and low bits. Reuse the
    // CopyFromReg previous node to avoid duplicate copies.
    SDValue RV;
    if (RegisterSDNode *SrcReg = dyn_cast<RegisterSDNode>(Chain.getOperand(1)))
      if (SrcReg->getReg() == Reg && Chain->getOpcode() == ISD::CopyFromReg)
        RV = Chain.getValue(0);

    // But usually we'll create a new CopyFromReg for a different register.
    if (!RV.getNode()) {
      RV = DAG.getCopyFromReg(Chain, DL, Reg, RVLocs[i].getLocVT(), InGlue);
      Chain = RV.getValue(1);
      InGlue = Chain.getValue(2);
    }

    // Get the high bits for i32 struct elements.
    if (VA.getValVT() == MVT::i32 && VA.needsCustom())
      RV = DAG.getNode(ISD::SRL, DL, VA.getLocVT(), RV,
                       DAG.getConstant(32, DL, MVT::i32));

    // The callee promoted the return value, so insert an Assert?ext SDNode so
    // we won't promote the value again in this function.
    switch (VA.getLocInfo()) {
    case CCValAssign::SExt:
      RV = DAG.getNode(ISD::AssertSext, DL, VA.getLocVT(), RV,
                       DAG.getValueType(VA.getValVT()));
      break;
    case CCValAssign::ZExt:
      RV = DAG.getNode(ISD::AssertZext, DL, VA.getLocVT(), RV,
                       DAG.getValueType(VA.getValVT()));
      break;
    case CCValAssign::BCvt: {
      // Extract a float return value from i64 with padding.
      //     63     31   0
      //    +------+------+
      //    | float|   0  |
      //    +------+------+
      assert(VA.getLocVT() == MVT::i64);
      assert(VA.getValVT() == MVT::f32);
      SDValue Sub_f32 = DAG.getTargetConstant(VE::sub_f32, DL, MVT::i32);
      RV = SDValue(DAG.getMachineNode(TargetOpcode::EXTRACT_SUBREG, DL,
                                      MVT::f32, RV, Sub_f32),
                   0);
      break;
    }
    default:
      break;
    }

    // Truncate the register down to the return value type.
    if (VA.isExtInLoc())
      RV = DAG.getNode(ISD::TRUNCATE, DL, VA.getValVT(), RV);

    InVals.push_back(RV);
  }

  return Chain;
}

bool VETargetLowering::isOffsetFoldingLegal(
    const GlobalAddressSDNode *GA) const {
  // VE uses 64 bit addressing, so we need multiple instructions to generate
  // an address.  Folding address with offset increases the number of
  // instructions, so that we disable it here.  Offsets will be folded in
  // the DAG combine later if it worth to do so.
  return false;
}

/// isFPImmLegal - Returns true if the target can instruction select the
/// specified FP immediate natively. If false, the legalizer will
/// materialize the FP immediate as a load from a constant pool.
bool VETargetLowering::isFPImmLegal(const APFloat &Imm, EVT VT,
                                    bool ForCodeSize) const {
  return VT == MVT::f32 || VT == MVT::f64;
}

/// Determine if the target supports unaligned memory accesses.
///
/// This function returns true if the target allows unaligned memory accesses
/// of the specified type in the given address space. If true, it also returns
/// whether the unaligned memory access is "fast" in the last argument by
/// reference. This is used, for example, in situations where an array
/// copy/move/set is converted to a sequence of store operations. Its use
/// helps to ensure that such replacements don't generate code that causes an
/// alignment error (trap) on the target machine.
bool VETargetLowering::allowsMisalignedMemoryAccesses(EVT VT,
                                                      unsigned AddrSpace,
                                                      unsigned Align,
                                                      MachineMemOperand::Flags,
                                                      bool *Fast) const {
  if (Fast) {
    // It's fast anytime on VE
    *Fast = true;
  }
  return true;
}

bool VETargetLowering::canMergeStoresTo(unsigned AddressSpace, EVT MemVT,
                                        const SelectionDAG &DAG) const {
  // Do not merge to float value size (128 bytes) if no implicit
  // float attribute is set.
  bool NoFloat = DAG.getMachineFunction().getFunction().hasFnAttribute(
      Attribute::NoImplicitFloat);

  if (NoFloat) {
    unsigned MaxIntSize = 64;
    return (MemVT.getSizeInBits() <= MaxIntSize);
  }
  return true;
}

TargetLowering::AtomicExpansionKind
VETargetLowering::shouldExpandAtomicRMWInIR(AtomicRMWInst *AI) const {
  if (AI->getOperation() == AtomicRMWInst::Xchg) {
    const DataLayout &DL = AI->getModule()->getDataLayout();
    if (DL.getTypeStoreSize(AI->getValOperand()->getType()) == 2)
      return AtomicExpansionKind::CmpXChg; // Uses cas instruction for 2byte
                                           // atomic_swap
    return AtomicExpansionKind::None;      // Uses ts1am instruction
  }
  return AtomicExpansionKind::CmpXChg;
}

void VETargetLowering::initSPUActions() {
  const auto &TM = getTargetMachine();

  /// Load & Store {

  // VE doesn't have i1 sign extending load.
  for (MVT VT : MVT::integer_valuetypes()) {
    setLoadExtAction(ISD::SEXTLOAD, VT, MVT::i1, Promote);
    setLoadExtAction(ISD::ZEXTLOAD, VT, MVT::i1, Promote);
    setLoadExtAction(ISD::EXTLOAD, VT, MVT::i1, Promote);
    // FIXME: upstream has following line.  Need double check.
    // setTruncStoreAction(VT, MVT::i1, Expand);
  }

  // VE doesn't have floating point extload/truncstore, so expand them.
  for (MVT FPVT : MVT::fp_valuetypes()) {
    for (MVT OtherFPVT : MVT::fp_valuetypes()) {
      setLoadExtAction(ISD::EXTLOAD, FPVT, OtherFPVT, Expand);
      setTruncStoreAction(FPVT, OtherFPVT, Expand);
    }
  }

  // VE doesn't have fp128 load/store, so expand them in custom lower.
  setOperationAction(ISD::LOAD, MVT::f128, Custom);
  setOperationAction(ISD::STORE, MVT::f128, Custom);

  /// } Load & Store

  // Custom legalize address nodes into LO/HI parts.
  MVT PtrVT = MVT::getIntegerVT(TM.getPointerSizeInBits(0));
  setOperationAction(ISD::BlockAddress, PtrVT, Custom);
  setOperationAction(ISD::GlobalAddress, PtrVT, Custom);
  setOperationAction(ISD::GlobalTLSAddress, PtrVT, Custom);
  setOperationAction(ISD::ConstantPool, PtrVT, Custom);
  setOperationAction(ISD::JumpTable, PtrVT, Custom);

  /// VAARG handling {
  setOperationAction(ISD::VASTART, MVT::Other, Custom);
  // VAARG needs to be lowered to access with 8 bytes alignment.
  setOperationAction(ISD::VAARG, MVT::Other, Custom);
  // Use the default implementation.
  setOperationAction(ISD::VACOPY, MVT::Other, Expand);
  setOperationAction(ISD::VAEND, MVT::Other, Expand);
  /// } VAARG handling

  /// Stack {
  setOperationAction(ISD::DYNAMIC_STACKALLOC, MVT::i32, Custom);
  setOperationAction(ISD::DYNAMIC_STACKALLOC, MVT::i64, Custom);
  /// } Stack

  /// Branch {

  // VE doesn't have BRCOND
  setOperationAction(ISD::BRCOND, MVT::Other, Expand);

  // BR_JT is not implemented yet.
  setOperationAction(ISD::BR_JT, MVT::Other, Expand);

  /// } Branch

  /// Int Ops {
  for (MVT IntVT : {MVT::i32, MVT::i64}) {
    // VE has no REM or DIVREM operations.
    setOperationAction(ISD::UREM, IntVT, Expand);
    setOperationAction(ISD::SREM, IntVT, Expand);
    setOperationAction(ISD::SDIVREM, IntVT, Expand);
    setOperationAction(ISD::UDIVREM, IntVT, Expand);

    // VE has no SHL_PARTS/SRA_PARTS/SRL_PARTS operations.
    setOperationAction(ISD::SHL_PARTS, IntVT, Expand);
    setOperationAction(ISD::SRA_PARTS, IntVT, Expand);
    setOperationAction(ISD::SRL_PARTS, IntVT, Expand);

    // VE has no MULHU/MULHS/UMUL_LOHI/SMUL_LOHI operations.
    // TODO: Use MPD/MUL instructions to implement SMUL_LOHI/UMUL_LOHI for
    //       i32 type.
    setOperationAction(ISD::MULHU, IntVT, Expand);
    setOperationAction(ISD::MULHS, IntVT, Expand);
    setOperationAction(ISD::UMUL_LOHI, IntVT, Expand);
    setOperationAction(ISD::SMUL_LOHI, IntVT, Expand);

    // VE has no CTTZ, ROTL, ROTR operations.
    setOperationAction(ISD::CTTZ, IntVT, Expand);
    setOperationAction(ISD::ROTL, IntVT, Expand);
    setOperationAction(ISD::ROTR, IntVT, Expand);

    // VE has 64 bits instruction which works as i64 BSWAP operation.  This
    // instruction works fine as i32 BSWAP operation with an additional
    // parameter.  Use isel patterns to lower BSWAP.
    setOperationAction(ISD::BSWAP, IntVT, Legal);

    // VE has only 64 bits instructions which work as i64 BITREVERSE/CTLZ/CTPOP
    // operations.  Use isel patterns for i64, promote for i32.
    LegalizeAction Act = (IntVT == MVT::i32) ? Promote : Legal;
    setOperationAction(ISD::BITREVERSE, IntVT, Act);
    setOperationAction(ISD::CTLZ, IntVT, Act);
    setOperationAction(ISD::CTLZ_ZERO_UNDEF, IntVT, Act);
    setOperationAction(ISD::CTPOP, IntVT, Act);

    // VE has only 64 bits instructions which work as i64 AND/OR/XOR operations.
    // Use isel patterns for i64, promote for i32.
    setOperationAction(ISD::AND, IntVT, Act);
    setOperationAction(ISD::OR, IntVT, Act);
    setOperationAction(ISD::XOR, IntVT, Act);

    // Legal smax and smin
    setOperationAction(ISD::SMAX, IntVT, Legal);
    setOperationAction(ISD::SMIN, IntVT, Legal);
  }

  // Operations not supported by VE.
  setOperationAction(ISD::SIGN_EXTEND_INREG, MVT::i1, Expand);

  // Used by legalize types to correctly generate the setcc result.
  // Without this, every float setcc comes with a AND/OR with the result,
  // we don't want this, since the fpcmp result goes to a flag register,
  // which is used implicitly by brcond and select operations.
  AddPromotedToType(ISD::SETCC, MVT::i1, MVT::i32);

  /// } Int Ops

  /// Conversion {
  // VE doesn't have instructions for fp<->uint, so expand them by llvm
  setOperationAction(ISD::FP_TO_UINT, MVT::i32, Promote); // use i64
  setOperationAction(ISD::UINT_TO_FP, MVT::i32, Promote); // use i64
  setOperationAction(ISD::FP_TO_UINT, MVT::i64, Expand);
  setOperationAction(ISD::UINT_TO_FP, MVT::i64, Expand);

  // fp16 not supported
  for (MVT FPVT : MVT::fp_valuetypes()) {
    setOperationAction(ISD::FP16_TO_FP, FPVT, Expand);
    setOperationAction(ISD::FP_TO_FP16, FPVT, Expand);
  }
  /// } Conversion

  /// Floating-point Ops {
  /// Note: Floating-point operations are fneg, fadd, fsub, fmul, fdiv, frem,
  ///       and fcmp.

  // VE doesn't have following floating point operations.
  for (MVT VT : MVT::fp_valuetypes()) {
    setOperationAction(ISD::FNEG, VT, Expand);
    setOperationAction(ISD::FREM, VT, Expand);
  }

  // VE doesn't have fdiv of f128.
  setOperationAction(ISD::FDIV, MVT::f128, Expand);

  for (MVT FPVT : {MVT::f32, MVT::f64}) {
    // f32 and f64 uses ConstantFP.  f128 uses ConstantPool.
    setOperationAction(ISD::ConstantFP, FPVT, Legal);
  }
  /// } Floating-point Ops

  /// Floating-point math functions {

  // VE doesn't have following floating point math functions.
  for (MVT VT : MVT::fp_valuetypes()) {
    setOperationAction(ISD::FABS, VT, Expand);
    setOperationAction(ISD::FCOPYSIGN, VT, Expand);
    setOperationAction(ISD::FCOS, VT, Expand);
    setOperationAction(ISD::FSIN, VT, Expand);
    setOperationAction(ISD::FSQRT, VT, Expand);

    // VE has no sclar FMA instruction
    setOperationAction(ISD::FMA, VT, Expand);
    setOperationAction(ISD::FMAD, VT, Expand);
    setOperationAction(ISD::FABS, VT, Expand);
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
    if (VT == MVT::f128) {
      setOperationAction(ISD::FMINNUM, VT, Expand);
      setOperationAction(ISD::FMAXNUM, VT, Expand);
    } else {
      setOperationAction(ISD::FMINNUM, VT, Legal);
      setOperationAction(ISD::FMAXNUM, VT, Legal);
    }
    setOperationAction(ISD::FMINIMUM, VT, Expand);
    setOperationAction(ISD::FMAXIMUM, VT, Expand);
    setOperationAction(ISD::FSINCOS, VT, Expand);
  }

  /// } Floating-point math functions

  setOperationAction(ISD::EH_SJLJ_SETJMP, MVT::i32, Custom);
  setOperationAction(ISD::EH_SJLJ_LONGJMP, MVT::Other, Custom);
  setOperationAction(ISD::EH_SJLJ_SETUP_DISPATCH, MVT::Other, Custom);
  if (TM.Options.ExceptionModel == ExceptionHandling::SjLj)
    setLibcallName(RTLIB::UNWIND_RESUME, "_Unwind_SjLj_Resume");

  setTargetDAGCombine(ISD::FADD);
  // setTargetDAGCombine(ISD::FMA);

  /// Atomic instructions {

  setMaxAtomicSizeInBitsSupported(64);
  setMinCmpXchgSizeInBits(32);
  setSupportsUnalignedAtomics(false);

  // Use custom inserter for ATOMIC_FENCE.
  setOperationAction(ISD::ATOMIC_FENCE, MVT::Other, Custom);

  for (MVT VT : MVT::integer_valuetypes()) {
    // Several atomic operations are converted to VE instructions well.
    // Additional memory fences are generated in emitLeadingfence and
    // emitTrailingFence functions.
    setOperationAction(ISD::ATOMIC_LOAD, VT, Legal);
    setOperationAction(ISD::ATOMIC_STORE, VT, Legal);
    setOperationAction(ISD::ATOMIC_CMP_SWAP, VT, Legal);
    setOperationAction(ISD::ATOMIC_SWAP, VT, Custom);

    setOperationAction(ISD::ATOMIC_CMP_SWAP_WITH_SUCCESS, VT, Expand);

    // FIXME: not supported "atmam" isntructions yet
    setOperationAction(ISD::ATOMIC_LOAD_ADD, VT, Expand);
    setOperationAction(ISD::ATOMIC_LOAD_SUB, VT, Expand);
    setOperationAction(ISD::ATOMIC_LOAD_AND, VT, Expand);
    setOperationAction(ISD::ATOMIC_LOAD_OR, VT, Expand);

    // VE doesn't have follwing instructions
    setOperationAction(ISD::ATOMIC_LOAD_CLR, VT, Expand);
    setOperationAction(ISD::ATOMIC_LOAD_XOR, VT, Expand);
    setOperationAction(ISD::ATOMIC_LOAD_NAND, VT, Expand);
    setOperationAction(ISD::ATOMIC_LOAD_MIN, VT, Expand);
    setOperationAction(ISD::ATOMIC_LOAD_MAX, VT, Expand);
    setOperationAction(ISD::ATOMIC_LOAD_UMIN, VT, Expand);
    setOperationAction(ISD::ATOMIC_LOAD_UMAX, VT, Expand);
  }

  /// } Atomic isntructions

  /// Others.

  // FIXME: VE's I128 stuff is not investivated yet
  if (!1) {
    // These libcalls are not available in 32-bit.
    setLibcallName(RTLIB::SHL_I128, nullptr);
    setLibcallName(RTLIB::SRL_I128, nullptr);
    setLibcallName(RTLIB::SRA_I128, nullptr);
  }

  // Use the default implementation.
  setOperationAction(ISD::STACKSAVE, MVT::Other, Expand);
  setOperationAction(ISD::STACKRESTORE, MVT::Other, Expand);

  // Expand DYNAMIC_STACKALLOC
  setOperationAction(ISD::DYNAMIC_STACKALLOC, MVT::i32, Custom);
  setOperationAction(ISD::DYNAMIC_STACKALLOC, MVT::i64, Custom);

  // Other configurations related to f128.
  setOperationAction(ISD::BR_CC, MVT::f128, Legal);

  setOperationAction(ISD::INTRINSIC_VOID, MVT::Other, Custom);
  setOperationAction(ISD::INTRINSIC_W_CHAIN, MVT::Other, Custom);
  setOperationAction(ISD::INTRINSIC_WO_CHAIN, MVT::Other, Custom);

  // TRAP to expand (which turns it into abort).
  setOperationAction(ISD::TRAP, MVT::Other, Expand);

  // On most systems, DEBUGTRAP and TRAP have no difference. The "Expand"
  // here is to inform DAG Legalizer to replace DEBUGTRAP with TRAP.
  setOperationAction(ISD::DEBUGTRAP, MVT::Other, Expand);
}


VETargetLowering::VETargetLowering(const TargetMachine &TM,
                                   const VESubtarget &STI)
    : TargetLowering(TM), Subtarget(&STI) {
  // Instructions which use registers as conditionals examine all the
  // bits (as does the pseudo SELECT_CC expansion). I don't think it
  // matters much whether it's ZeroOrOneBooleanContent, or
  // ZeroOrNegativeOneBooleanContent, so, arbitrarily choose the
  // former.
  setBooleanContents(ZeroOrOneBooleanContent);
  setBooleanVectorContents(ZeroOrOneBooleanContent);

  LLVM_DEBUG(dbgs() << "VPU MODE:       " << Subtarget->enableVPU() << "\n";
             dbgs() << "PACKED MODE:    " << Subtarget->hasPackedMode() << "\n"
                    << "\n";);
  initRegisterClasses();
  initSPUActions();
  
  initIntrinsicActions();
  initVPUActions();
  initExperimentalVectorActions();

  setStackPointerRegisterToSaveRestore(VE::SX11);

  // We have target-specific dag combine patterns for the following nodes:
  setTargetDAGCombine(ISD::SIGN_EXTEND);
  setTargetDAGCombine(ISD::ZERO_EXTEND);
  setTargetDAGCombine(ISD::ANY_EXTEND);
  setTargetDAGCombine(ISD::TRUNCATE);

  setTargetDAGCombine(ISD::SETCC);
  setTargetDAGCombine(ISD::SELECT_CC);

  // Set function alignment to 16 bytes
  setMinFunctionAlignment(Align(16));

  // VE stores all argument by 8 bytes alignment
  setMinStackArgumentAlignment(Align(8));

  // VE uses generic registers as conditional registers.
  setHasMultipleConditionRegisters(true);

  computeRegisterProperties(Subtarget->getRegisterInfo());
}

TargetLowering::LegalizeAction
VETargetLowering::getActionForExtendedType(unsigned Op, EVT VT) const {
  switch (Op) {
#define ADD_VVP_OP(VVP_NAME, ISD_NAME)                                         \
  case ISD::ISD_NAME:                                                          \
  case VEISD::VVP_NAME:
#include "VVPNodes.def"
    return Custom;
  default:
    return Expand;
  }
}

TargetLowering::LegalizeAction
VETargetLowering::getCustomOperationAction(SDNode &Op) const {
  // Always custom-lower VEC_NARROW to eliminate it
  if (Op.getOpcode() == VEISD::VEC_NARROW)
    return Custom;
  // Otw, only custom lower to perform due widening
  if (IsVVPOrVEC(Op.getOpcode()) && OpNeedsWidening(Op))
    return Custom;
  return Legal;
}

const char *VETargetLowering::getTargetNodeName(unsigned Opcode) const {
#define TARGET_NODE_CASE(NAME)                                                 \
  case VEISD::NAME:                                                            \
    return "VEISD::" #NAME;
  switch ((VEISD::NodeType)Opcode) {
  case VEISD::FIRST_NUMBER:
    break;
    TARGET_NODE_CASE(Lo)
    TARGET_NODE_CASE(Hi)
    TARGET_NODE_CASE(GETFUNPLT)
    TARGET_NODE_CASE(GETSTACKTOP)
    TARGET_NODE_CASE(GETTLSADDR)
    TARGET_NODE_CASE(CALL)
    TARGET_NODE_CASE(RET_FLAG)
    TARGET_NODE_CASE(EQV)
    TARGET_NODE_CASE(XOR)
    TARGET_NODE_CASE(CMPI)
    TARGET_NODE_CASE(CMPU)
    TARGET_NODE_CASE(CMPF)
    TARGET_NODE_CASE(CMPQ)
    TARGET_NODE_CASE(CMOV)
    TARGET_NODE_CASE(EH_SJLJ_SETJMP)
    TARGET_NODE_CASE(EH_SJLJ_LONGJMP)
    TARGET_NODE_CASE(EH_SJLJ_SETUP_DISPATCH)
    TARGET_NODE_CASE(MEMBARRIER)
    TARGET_NODE_CASE(GLOBAL_BASE_REG)
    TARGET_NODE_CASE(FLUSHW)
    TARGET_NODE_CASE(Wrapper)
    TARGET_NODE_CASE(TS1AM)

    TARGET_NODE_CASE(VEC_BROADCAST)
    TARGET_NODE_CASE(VEC_NARROW)
    TARGET_NODE_CASE(VEC_SEQ)
    TARGET_NODE_CASE(VEC_VMV)
    TARGET_NODE_CASE(VEC_REDUCE_ANY)
    TARGET_NODE_CASE(VEC_POPCOUNT)
    TARGET_NODE_CASE(VEC_TOMASK)

    TARGET_NODE_CASE(VEC_UNPACK_LO)
    TARGET_NODE_CASE(VEC_UNPACK_HI)
    TARGET_NODE_CASE(VEC_PACK)
    TARGET_NODE_CASE(VEC_SWAP)

    TARGET_NODE_CASE(VM_INSERT)
    TARGET_NODE_CASE(VM_EXTRACT)

    TARGET_NODE_CASE(REPL_F32)
    TARGET_NODE_CASE(REPL_I32)
    // Register the VVP_* SDNodes.
#define ADD_VVP_OP(VVP_NAME, ...) TARGET_NODE_CASE(VVP_NAME)
#include "VVPNodes.def"
  }
  return nullptr;
}

EVT VETargetLowering::getSetCCResultType(const DataLayout &,
                                         LLVMContext &Context, EVT VT) const {
  if (!VT.isVector())
    return MVT::i32;
  return EVT::getVectorVT(Context, MVT::i1, VT.getVectorElementCount());
}

/// isMaskedValueZeroForTargetNode - Return true if 'Op & Mask' is known to
/// be zero. Op is expected to be a target specific node. Used by DAG
/// combiner.
void VETargetLowering::computeKnownBitsForTargetNode(const SDValue Op,
                                                     KnownBits &Known,
                                                     const APInt &DemandedElts,
                                                     const SelectionDAG &DAG,
                                                     unsigned Depth) const {
  KnownBits Known2;
  Known.resetAll();

  switch (Op.getOpcode()) {
  default:
    break;
  case VEISD::CMOV:
    // CMOV is a following instruction, so pick t and f and calculate KnownBits.
    //   res = CMOV comp, t, f, cond
    Known = DAG.computeKnownBits(Op.getOperand(2), Depth + 1);
    Known2 = DAG.computeKnownBits(Op.getOperand(1), Depth + 1);

    // Only known if known in both the LHS and RHS.
    Known.One &= Known2.One;
    Known.Zero &= Known2.Zero;
    break;
  }
}

// Convert to a target node and set target flags.
SDValue VETargetLowering::withTargetFlags(SDValue Op, unsigned TF,
                                          SelectionDAG &DAG) const {
  if (const GlobalAddressSDNode *GA = dyn_cast<GlobalAddressSDNode>(Op))
    return DAG.getTargetGlobalAddress(GA->getGlobal(), SDLoc(GA),
                                      GA->getValueType(0), GA->getOffset(), TF);

  if (const BlockAddressSDNode *BA = dyn_cast<BlockAddressSDNode>(Op))
    return DAG.getTargetBlockAddress(BA->getBlockAddress(), Op.getValueType(),
                                     0, TF);

  if (const ConstantPoolSDNode *CP = dyn_cast<ConstantPoolSDNode>(Op))
    return DAG.getTargetConstantPool(CP->getConstVal(), CP->getValueType(0),
                                     CP->getAlign(), CP->getOffset(), TF);

  if (const ExternalSymbolSDNode *ES = dyn_cast<ExternalSymbolSDNode>(Op))
    return DAG.getTargetExternalSymbol(ES->getSymbol(), ES->getValueType(0),
                                       TF);

  if (const JumpTableSDNode *JT = dyn_cast<JumpTableSDNode>(Op))
    return DAG.getTargetJumpTable(JT->getIndex(), JT->getValueType(0), TF);

  llvm_unreachable("Unhandled address SDNode");
}

// Split Op into high and low parts according to HiTF and LoTF.
// Return an ADD node combining the parts.
SDValue VETargetLowering::makeHiLoPair(SDValue Op, unsigned HiTF, unsigned LoTF,
                                       SelectionDAG &DAG) const {
  SDLoc DL(Op);
  EVT VT = Op.getValueType();
  SDValue Hi = DAG.getNode(VEISD::Hi, DL, VT, withTargetFlags(Op, HiTF, DAG));
  SDValue Lo = DAG.getNode(VEISD::Lo, DL, VT, withTargetFlags(Op, LoTF, DAG));
  return DAG.getNode(ISD::ADD, DL, VT, Hi, Lo);
}

// Build SDNodes for producing an address from a GlobalAddress, ConstantPool,
// or ExternalSymbol SDNode.
SDValue VETargetLowering::makeAddress(SDValue Op, SelectionDAG &DAG) const {
  SDLoc DL(Op);
  EVT PtrVT = Op.getValueType();

  // Handle PIC mode first. VE needs a got load for every variable!
  if (isPositionIndependent()) {
    auto GlobalN = dyn_cast<GlobalAddressSDNode>(Op);

    if (isa<ConstantPoolSDNode>(Op) || isa<JumpTableSDNode>(Op) ||
        (GlobalN && GlobalN->getGlobal()->hasLocalLinkage())) {
      // Create following instructions for local linkage PIC code.
      //     lea %reg, label@gotoff_lo
      //     and %reg, %reg, (32)0
      //     lea.sl %reg, label@gotoff_hi(%reg, %got)
      SDValue HiLo = makeHiLoPair(Op, VEMCExpr::VK_VE_GOTOFF_HI32,
                                  VEMCExpr::VK_VE_GOTOFF_LO32, DAG);
      SDValue GlobalBase = DAG.getNode(VEISD::GLOBAL_BASE_REG, DL, PtrVT);
      return DAG.getNode(ISD::ADD, DL, PtrVT, GlobalBase, HiLo);
    }
    // Create following instructions for not local linkage PIC code.
    //     lea %reg, label@got_lo
    //     and %reg, %reg, (32)0
    //     lea.sl %reg, label@got_hi(%reg)
    //     ld %reg, (%reg, %got)
    SDValue HiLo = makeHiLoPair(Op, VEMCExpr::VK_VE_GOT_HI32,
                                VEMCExpr::VK_VE_GOT_LO32, DAG);
    SDValue GlobalBase = DAG.getNode(VEISD::GLOBAL_BASE_REG, DL, PtrVT);
    SDValue AbsAddr = DAG.getNode(ISD::ADD, DL, PtrVT, GlobalBase, HiLo);
    return DAG.getLoad(PtrVT, DL, DAG.getEntryNode(), AbsAddr,
                       MachinePointerInfo::getGOT(DAG.getMachineFunction()));
  }

  // This is one of the absolute code models.
  switch (getTargetMachine().getCodeModel()) {
  default:
    llvm_unreachable("Unsupported absolute code model");
  case CodeModel::Small:
  case CodeModel::Medium:
  case CodeModel::Large:
    // abs64.
    return makeHiLoPair(Op, VEMCExpr::VK_VE_HI32, VEMCExpr::VK_VE_LO32, DAG);
  }
}

Instruction *VETargetLowering::emitLeadingFence(IRBuilder<> &Builder,
                                                Instruction *Inst,
                                                AtomicOrdering Ord) const {
  switch (Ord) {
  case AtomicOrdering::NotAtomic:
  case AtomicOrdering::Unordered:
    llvm_unreachable("Invalid fence: unordered/non-atomic");
  case AtomicOrdering::Monotonic:
  case AtomicOrdering::Acquire:
    return nullptr; // Nothing to do
  case AtomicOrdering::Release:
  case AtomicOrdering::AcquireRelease:
    return Builder.CreateFence(AtomicOrdering::Release);
  case AtomicOrdering::SequentiallyConsistent:
    if (!Inst->hasAtomicStore())
      return nullptr; // Nothing to do
    return Builder.CreateFence(AtomicOrdering::SequentiallyConsistent);
  }
  llvm_unreachable("Unknown fence ordering in emitLeadingFence");
}

Instruction *VETargetLowering::emitTrailingFence(IRBuilder<> &Builder,
                                                 Instruction *Inst,
                                                 AtomicOrdering Ord) const {
  switch (Ord) {
  case AtomicOrdering::NotAtomic:
  case AtomicOrdering::Unordered:
    llvm_unreachable("Invalid fence: unordered/not-atomic");
  case AtomicOrdering::Monotonic:
  case AtomicOrdering::Release:
    return nullptr; // Nothing to do
  case AtomicOrdering::Acquire:
  case AtomicOrdering::AcquireRelease:
    return Builder.CreateFence(AtomicOrdering::Acquire);
  case AtomicOrdering::SequentiallyConsistent:
    return Builder.CreateFence(AtomicOrdering::SequentiallyConsistent);
  }
  llvm_unreachable("Unknown fence ordering in emitTrailingFence");
}

SDValue VETargetLowering::lowerATOMIC_SWAP(SDValue Op, SelectionDAG & DAG)
    const {
  AtomicSDNode *N = cast<AtomicSDNode>(Op);

  // Custom Lowering 1 byte ATOMIC_SWAP.
  if (N->getMemoryVT() == MVT::i8) {
    SDLoc DL(Op);

    SDValue Src = N->getOperand(1);
    SDValue Value = N->getOperand(2);

    SDValue Const3 = DAG.getConstant(3, DL, MVT::i64);
    SDValue Const24 = DAG.getConstant(24, DL, MVT::i64);

    // Generate "ts1am" as 1 byte ATOMIC_SWAP.
    SDValue AlignedAddress =
        DAG.getNode(ISD::AND, DL, Src.getValueType(),
                    {Src, DAG.getConstant(-4, DL, MVT::i64)});
    SDValue Remainder =
        DAG.getNode(ISD::AND, DL, Src.getValueType(), {Src, Const3});
    SDValue ShiftedFlag = DAG.getNode(
        ISD::SHL, DL, MVT::i32, {DAG.getConstant(1, DL, MVT::i32), Remainder});
    SDValue ShiftBits = DAG.getNode(ISD::SHL, DL, Remainder.getValueType(),
                                    {Remainder, Const3});
    SDValue NewValue =
        DAG.getNode(ISD::SHL, DL, Value.getValueType(), {Value, ShiftBits});
    SDValue TS1AM =
        DAG.getAtomic(VEISD::TS1AM, DL, N->getMemoryVT(),
                      DAG.getVTList(Op.getNode()->getValueType(0),
                                    Op.getNode()->getValueType(1)),
                      {N->getChain(), AlignedAddress, ShiftedFlag, NewValue},
                      N->getMemOperand());

    // Extract 1 byte result.
    SDValue SUB =
        DAG.getNode(ISD::SUB, DL, Const24.getValueType(), {Const24, ShiftBits});
    SDValue ShiftLeftFor1Byte =
        DAG.getNode(ISD::SHL, DL, TS1AM.getValueType(), {TS1AM, SUB});
    SDValue ShiftRightFor1Byte =
        DAG.getNode(ISD::SRA, DL, ShiftLeftFor1Byte.getValueType(),
                    {ShiftLeftFor1Byte, Const24});

    SDValue Chain = TS1AM.getValue(1);
    return DAG.getMergeValues({ShiftRightFor1Byte, Chain}, DL);
  }
  // Otherwise, let llvm legalize it.
  return Op;
}

SDValue VETargetLowering::lowerGlobalAddress(SDValue Op,
                                             SelectionDAG &DAG) const {
  return makeAddress(Op, DAG);
}

SDValue VETargetLowering::lowerBlockAddress(SDValue Op,
                                            SelectionDAG &DAG) const {
  return makeAddress(Op, DAG);
}

SDValue VETargetLowering::lowerConstantPool(SDValue Op,
                                            SelectionDAG &DAG) const {
  return makeAddress(Op, DAG);
}

SDValue
VETargetLowering::lowerToTLSGeneralDynamicModel(SDValue Op,
                                                SelectionDAG &DAG) const {
  SDLoc DL(Op);

  // Generate following code:
  //   t1: ch,glue = callseq_start t0, 0, 0
  //   t2: i64,ch,glue = VEISD::GETTLSADDR t1, label, t1:1
  //   t3: ch,glue = callseq_end t2, 0, 0, t2:2
  //   t4: i64,ch,glue = CopyFromReg t3, Register:i64 $sx0, t3:1
  SDValue Label = withTargetFlags(Op, 0, DAG);
  EVT PtrVT = Op.getValueType();

  // Lowering the machine isd will make sure everything is in the right
  // location.
  SDValue Chain = DAG.getEntryNode();
  SDVTList NodeTys = DAG.getVTList(MVT::Other, MVT::Glue);
  const uint32_t *Mask = Subtarget->getRegisterInfo()->getCallPreservedMask(
      DAG.getMachineFunction(), CallingConv::C);
  Chain = DAG.getCALLSEQ_START(Chain, 64, 0, DL);
  SDValue Args[] = {Chain, Label, DAG.getRegisterMask(Mask), Chain.getValue(1)};
  Chain = DAG.getNode(VEISD::GETTLSADDR, DL, NodeTys, Args);
  Chain = DAG.getCALLSEQ_END(Chain, DAG.getIntPtrConstant(64, DL, true),
                             DAG.getIntPtrConstant(0, DL, true),
                             Chain.getValue(1), DL);
  Chain = DAG.getCopyFromReg(Chain, DL, VE::SX0, PtrVT, Chain.getValue(1));

  // GETTLSADDR will be codegen'ed as call. Inform MFI that function has calls.
  MachineFrameInfo &MFI = DAG.getMachineFunction().getFrameInfo();
  MFI.setHasCalls(true);

  // Also generate code to prepare a GOT register if it is PIC.
  if (isPositionIndependent()) {
    MachineFunction &MF = DAG.getMachineFunction();
    Subtarget->getInstrInfo()->getGlobalBaseReg(&MF);
  }

  return Chain;
}

SDValue VETargetLowering::lowerToTLSLocalExecModel(SDValue Op,
                                                   SelectionDAG & DAG) const {
  SDLoc dl(Op);
  EVT PtrVT = getPointerTy(DAG.getDataLayout());

  // Generate following code:
  //   lea %s0, Op@tpoff_lo
  //   and %s0, %s0, (32)0
  //   lea.sl %s0, Op@tpoff_hi(%s0)
  //   add %s0, %s0, %tp
  // FIXME: use lea.sl %s0, Op@tpoff_hi(%tp, %s0) for better performance
  SDValue HiLo = makeHiLoPair(Op, VEMCExpr::VK_VE_TPOFF_HI32,
                              VEMCExpr::VK_VE_TPOFF_LO32, DAG);
  return DAG.getNode(ISD::ADD, dl, PtrVT, DAG.getRegister(VE::SX14, PtrVT),
                     HiLo);
}

SDValue VETargetLowering::lowerGlobalTLSAddress(SDValue Op,
                                                SelectionDAG &DAG) const {
  // Current implementation of nld doesn't allow local exec model code
  // described in VE-tls_v1.1.pdf (*1) as its input.  The nld accept
  // only general dynamic model and optimize it whenever.  So, here
  // we need to generate only general dynamic model code sequence.
  //
  // *1: https://www.nec.com/en/global/prod/hpc/aurora/document/VE-tls_v1.1.pdf
  return lowerToTLSGeneralDynamicModel(Op, DAG);
}

SDValue VETargetLowering::lowerEH_SJLJ_SETJMP(SDValue Op, SelectionDAG & DAG)
    const {
  SDLoc dl(Op);
  return DAG.getNode(VEISD::EH_SJLJ_SETJMP, dl,
                     DAG.getVTList(MVT::i32, MVT::Other), Op.getOperand(0),
                     Op.getOperand(1));
}

      SDValue VETargetLowering::lowerEH_SJLJ_LONGJMP(SDValue Op,
                                                     SelectionDAG & DAG) const {
  SDLoc dl(Op);
  return DAG.getNode(VEISD::EH_SJLJ_LONGJMP, dl, MVT::Other, Op.getOperand(0),
                     Op.getOperand(1));
}

SDValue VETargetLowering::lowerEH_SJLJ_SETUP_DISPATCH(SDValue Op,
                                                      SelectionDAG &DAG) const {
  SDLoc dl(Op);
  return DAG.getNode(VEISD::EH_SJLJ_SETUP_DISPATCH, dl, MVT::Other,
                     Op.getOperand(0));
}

SDValue VETargetLowering::lowerJumpTable(SDValue Op, SelectionDAG &DAG) const {
  return makeAddress(Op, DAG);
}

// Lower a f128 load into two f64 loads.
static SDValue lowerLoadF128(SDValue Op, SelectionDAG &DAG) {
  SDLoc DL(Op);
  LoadSDNode *LdNode = dyn_cast<LoadSDNode>(Op.getNode());
  assert(LdNode && LdNode->getOffset().isUndef() && "Unexpected node type");
  unsigned Alignment = LdNode->getAlign().value();
  if (Alignment > 8)
    Alignment = 8;

  SDValue Lo64 =
      DAG.getLoad(MVT::f64, DL, LdNode->getChain(), LdNode->getBasePtr(),
                  LdNode->getPointerInfo(), Alignment,
                  LdNode->isVolatile() ? MachineMemOperand::MOVolatile
                                       : MachineMemOperand::MONone);
  EVT AddrVT = LdNode->getBasePtr().getValueType();
  SDValue HiPtr = DAG.getNode(ISD::ADD, DL, AddrVT, LdNode->getBasePtr(),
                              DAG.getConstant(8, DL, AddrVT));
  SDValue Hi64 =
      DAG.getLoad(MVT::f64, DL, LdNode->getChain(), HiPtr,
                  LdNode->getPointerInfo(), Alignment,
                  LdNode->isVolatile() ? MachineMemOperand::MOVolatile
                                       : MachineMemOperand::MONone);

  SDValue SubRegEven = DAG.getTargetConstant(VE::sub_even, DL, MVT::i32);
  SDValue SubRegOdd = DAG.getTargetConstant(VE::sub_odd, DL, MVT::i32);

  // VE stores Hi64 to 8(addr) and Lo64 to 0(addr)
  SDNode *InFP128 =
      DAG.getMachineNode(TargetOpcode::IMPLICIT_DEF, DL, MVT::f128);
  InFP128 = DAG.getMachineNode(TargetOpcode::INSERT_SUBREG, DL, MVT::f128,
                               SDValue(InFP128, 0), Hi64, SubRegEven);
  InFP128 = DAG.getMachineNode(TargetOpcode::INSERT_SUBREG, DL, MVT::f128,
                               SDValue(InFP128, 0), Lo64, SubRegOdd);
  SDValue OutChains[2] = {SDValue(Lo64.getNode(), 1),
                          SDValue(Hi64.getNode(), 1)};
  SDValue OutChain = DAG.getNode(ISD::TokenFactor, DL, MVT::Other, OutChains);
  SDValue Ops[2] = {SDValue(InFP128, 0), OutChain};
  return DAG.getMergeValues(Ops, DL);
}

// Lower a vXi1 load into following instructions
//   LDrii %1, (,%addr)
//   LVMxir  %vm, 0, %1
//   LDrii %2, 8(,%addr)
//   LVMxir  %vm, 0, %2
//   ...
static SDValue lowerLoadI1(SDValue Op, SelectionDAG &DAG) {
  SDLoc DL(Op);
  LoadSDNode *LdNode = dyn_cast<LoadSDNode>(Op.getNode());
  assert(LdNode && LdNode->getOffset().isUndef() && "Unexpected node type");

  SDValue BasePtr = LdNode->getBasePtr();
  unsigned Alignment = LdNode->getAlign().value();
  if (Alignment > 8)
    Alignment = 8;

  EVT AddrVT = BasePtr.getValueType();
  EVT MemVT = LdNode->getMemoryVT();
  if (MemVT == MVT::v256i1 || MemVT == MVT::v4i64) {
    SDValue OutChains[4];
    SDNode *VM = DAG.getMachineNode(TargetOpcode::IMPLICIT_DEF, DL, MemVT);
    for (int i = 0; i < 4; ++i) {
      // Generate load dag and prepare chains.
      SDValue Addr = DAG.getNode(ISD::ADD, DL, AddrVT, BasePtr,
                                 DAG.getConstant(8 * i, DL, AddrVT));
      SDValue Val =
          DAG.getLoad(MVT::i64, DL, LdNode->getChain(), Addr,
                      LdNode->getPointerInfo(), Alignment,
                      LdNode->isVolatile() ? MachineMemOperand::MOVolatile
                                           : MachineMemOperand::MONone);
      OutChains[i] = SDValue(Val.getNode(), 1);

      VM = DAG.getMachineNode(VE::LVMir_m, DL, MVT::i64,
                              DAG.getTargetConstant(i, DL, MVT::i64), Val,
                              SDValue(VM, 0));
    }
    SDValue OutChain = DAG.getNode(ISD::TokenFactor, DL, MVT::Other, OutChains);
    SDValue Ops[2] = {SDValue(VM, 0), OutChain};
    return DAG.getMergeValues(Ops, DL);
  } else if (MemVT == MVT::v512i1 || MemVT == MVT::v8i64) {
    SDValue OutChains[8];
    SDNode *VM = DAG.getMachineNode(TargetOpcode::IMPLICIT_DEF, DL, MemVT);
    for (int i = 0; i < 8; ++i) {
      // Generate load dag and prepare chains.
      SDValue Addr = DAG.getNode(ISD::ADD, DL, AddrVT, BasePtr,
                                 DAG.getConstant(8 * i, DL, AddrVT));
      SDValue Val =
          DAG.getLoad(MVT::i64, DL, LdNode->getChain(), Addr,
                      LdNode->getPointerInfo(), Alignment,
                      LdNode->isVolatile() ? MachineMemOperand::MOVolatile
                                           : MachineMemOperand::MONone);
      OutChains[i] = SDValue(Val.getNode(), 1);

      VM = DAG.getMachineNode(VE::LVMyir_y, DL, MVT::i64,
                              DAG.getTargetConstant(i, DL, MVT::i64), Val,
                              SDValue(VM, 0));
    }
    SDValue OutChain = DAG.getNode(ISD::TokenFactor, DL, MVT::Other, OutChains);
    SDValue Ops[2] = {SDValue(VM, 0), OutChain};
    return DAG.getMergeValues(Ops, DL);
  } else {
    // Otherwise, ask llvm to expand it.
    return SDValue();
  }
}

SDValue VETargetLowering::lowerLOAD(SDValue Op, SelectionDAG &DAG) const {
  LoadSDNode *LdNode = cast<LoadSDNode>(Op.getNode());

  SDValue BasePtr = LdNode->getBasePtr();
  if (isa<FrameIndexSDNode>(BasePtr.getNode())) {
    // Do not expand store instruction with frame index here because of
    // dependency problems.  We expand it later in eliminateFrameIndex().
    return Op;
  }

  EVT MemVT = LdNode->getMemoryVT();
  if (MemVT == MVT::f128)
    return lowerLoadF128(Op, DAG);
  if (isVectorMaskType(MemVT))
    return lowerLoadI1(Op, DAG);

  return Op;
}

// Lower a f128 store into two f64 stores.
static SDValue lowerStoreF128(SDValue Op, SelectionDAG &DAG) {
  SDLoc DL(Op);
  StoreSDNode *StNode = dyn_cast<StoreSDNode>(Op.getNode());
  assert(StNode && StNode->getOffset().isUndef() && "Unexpected node type");

  SDValue SubRegEven = DAG.getTargetConstant(VE::sub_even, DL, MVT::i32);
  SDValue SubRegOdd = DAG.getTargetConstant(VE::sub_odd, DL, MVT::i32);

  SDNode *Hi64 = DAG.getMachineNode(TargetOpcode::EXTRACT_SUBREG, DL, MVT::i64,
                                    StNode->getValue(), SubRegEven);
  SDNode *Lo64 = DAG.getMachineNode(TargetOpcode::EXTRACT_SUBREG, DL, MVT::i64,
                                    StNode->getValue(), SubRegOdd);

  unsigned Alignment = StNode->getAlign().value();
  if (Alignment > 8)
    Alignment = 8;

  // VE stores Hi64 to 8(addr) and Lo64 to 0(addr)
  SDValue OutChains[2];
  OutChains[0] =
      DAG.getStore(StNode->getChain(), DL, SDValue(Lo64, 0),
                   StNode->getBasePtr(), MachinePointerInfo(), Alignment,
                   StNode->isVolatile() ? MachineMemOperand::MOVolatile
                                        : MachineMemOperand::MONone);
  EVT AddrVT = StNode->getBasePtr().getValueType();
  SDValue HiPtr = DAG.getNode(ISD::ADD, DL, AddrVT, StNode->getBasePtr(),
                              DAG.getConstant(8, DL, AddrVT));
  OutChains[1] =
      DAG.getStore(StNode->getChain(), DL, SDValue(Hi64, 0), HiPtr,
                   MachinePointerInfo(), Alignment,
                   StNode->isVolatile() ? MachineMemOperand::MOVolatile
                                        : MachineMemOperand::MONone);
  return DAG.getNode(ISD::TokenFactor, DL, MVT::Other, OutChains);
}

// Lower a vXi1 store into following instructions
//   SVMi  %1, %vm, 0
//   STrii %1, (,%addr)
//   SVMi  %2, %vm, 1
//   STrii %2, 8(,%addr)
//   ...
static SDValue lowerStoreI1(SDValue Op, SelectionDAG &DAG) {
  SDLoc DL(Op);
  StoreSDNode *StNode = dyn_cast<StoreSDNode>(Op.getNode());
  assert(StNode && StNode->getOffset().isUndef() && "Unexpected node type");

  SDValue BasePtr = StNode->getBasePtr();
  unsigned Alignment = StNode->getAlign().value();
  if (Alignment > 8)
    Alignment = 8;
  EVT AddrVT = BasePtr.getValueType();
  EVT MemVT = StNode->getMemoryVT();
  if (MemVT == MVT::v256i1 || MemVT == MVT::v4i64) {
    SDValue OutChains[4];
    for (int i = 0; i < 4; ++i) {
      SDNode *V =
          DAG.getMachineNode(VE::SVMmi, DL, MVT::i64, StNode->getValue(),
                             DAG.getTargetConstant(i, DL, MVT::i64));
      SDValue Addr = DAG.getNode(ISD::ADD, DL, AddrVT, BasePtr,
                                 DAG.getConstant(8 * i, DL, AddrVT));
      OutChains[i] =
          DAG.getStore(StNode->getChain(), DL, SDValue(V, 0), Addr,
                       MachinePointerInfo(), Alignment,
                       StNode->isVolatile() ? MachineMemOperand::MOVolatile
                                            : MachineMemOperand::MONone);
    }
    return DAG.getNode(ISD::TokenFactor, DL, MVT::Other, OutChains);
  } else if (MemVT == MVT::v512i1 || MemVT == MVT::v8i64) {
    SDValue OutChains[8];
    for (int i = 0; i < 8; ++i) {
      SDNode *V =
          DAG.getMachineNode(VE::SVMyi, DL, MVT::i64, StNode->getValue(),
                             DAG.getTargetConstant(i, DL, MVT::i64));
      SDValue Addr = DAG.getNode(ISD::ADD, DL, AddrVT, BasePtr,
                                 DAG.getConstant(8 * i, DL, AddrVT));
      OutChains[i] =
          DAG.getStore(StNode->getChain(), DL, SDValue(V, 0), Addr,
                       MachinePointerInfo(), Alignment,
                       StNode->isVolatile() ? MachineMemOperand::MOVolatile
                                            : MachineMemOperand::MONone);
    }
    return DAG.getNode(ISD::TokenFactor, DL, MVT::Other, OutChains);
  } else {
    // Otherwise, ask llvm to expand it.
    return SDValue();
  }
}

SDValue VETargetLowering::lowerSTORE(SDValue Op, SelectionDAG &DAG) const {
  StoreSDNode *StNode = cast<StoreSDNode>(Op.getNode());
  assert(StNode && StNode->getOffset().isUndef() && "Unexpected node type");

  SDValue BasePtr = StNode->getBasePtr();
  if (isa<FrameIndexSDNode>(BasePtr.getNode())) {
    // Do not expand store instruction with frame index here because of
    // dependency problems.  We expand it later in eliminateFrameIndex().
    return Op;
  }

  EVT MemVT = StNode->getMemoryVT();
  if (MemVT == MVT::f128)
    return lowerStoreF128(Op, DAG);
  if (isVectorMaskType(MemVT))
    return lowerStoreI1(Op, DAG);

  // Otherwise, ask llvm to expand it.
  return SDValue();
}

SDValue VETargetLowering::lowerVASTART(SDValue Op, SelectionDAG &DAG) const {
  MachineFunction &MF = DAG.getMachineFunction();
  VEMachineFunctionInfo *FuncInfo = MF.getInfo<VEMachineFunctionInfo>();
  auto PtrVT = getPointerTy(DAG.getDataLayout());

  // Need frame address to find the address of VarArgsFrameIndex.
  MF.getFrameInfo().setFrameAddressIsTaken(true);

  // vastart just stores the address of the VarArgsFrameIndex slot into the
  // memory location argument.
  SDLoc DL(Op);
  SDValue Offset =
      DAG.getNode(ISD::ADD, DL, PtrVT, DAG.getRegister(VE::SX9, PtrVT),
                  DAG.getIntPtrConstant(FuncInfo->getVarArgsFrameOffset(), DL));
  const Value *SV = cast<SrcValueSDNode>(Op.getOperand(2))->getValue();
  return DAG.getStore(Op.getOperand(0), DL, Offset, Op.getOperand(1),
                      MachinePointerInfo(SV));
}

SDValue VETargetLowering::lowerVAARG(SDValue Op, SelectionDAG &DAG) const {
  SDNode *Node = Op.getNode();
  EVT VT = Node->getValueType(0);
  SDValue InChain = Node->getOperand(0);
  SDValue VAListPtr = Node->getOperand(1);
  EVT PtrVT = VAListPtr.getValueType();
  const Value *SV = cast<SrcValueSDNode>(Node->getOperand(2))->getValue();
  SDLoc DL(Node);
  SDValue VAList =
      DAG.getLoad(PtrVT, DL, InChain, VAListPtr, MachinePointerInfo(SV));
  SDValue Chain = VAList.getValue(1);
  SDValue NextPtr;

  if (VT == MVT::f128) {
    // VE f128 values must be stored with 16 bytes alignment.  We don't
    // know the actual alignment of VAList, so we take alignment of it
    // dynamically.
    int Align = 16;
    VAList = DAG.getNode(ISD::ADD, DL, PtrVT, VAList,
                         DAG.getConstant(Align - 1, DL, PtrVT));
    VAList = DAG.getNode(ISD::AND, DL, PtrVT, VAList,
                         DAG.getConstant(-Align, DL, PtrVT));
    // Increment the pointer, VAList, by 16 to the next vaarg.
    NextPtr =
        DAG.getNode(ISD::ADD, DL, PtrVT, VAList, DAG.getIntPtrConstant(16, DL));
  } else if (VT == MVT::f32) {
    // float --> need special handling like below.
    //    0      4
    //    +------+------+
    //    | empty| float|
    //    +------+------+
    // Increment the pointer, VAList, by 8 to the next vaarg.
    NextPtr =
        DAG.getNode(ISD::ADD, DL, PtrVT, VAList, DAG.getIntPtrConstant(8, DL));
    // Then, adjust VAList.
    unsigned InternalOffset = 4;
    VAList = DAG.getNode(ISD::ADD, DL, PtrVT, VAList,
                         DAG.getConstant(InternalOffset, DL, PtrVT));
  } else {
    // Increment the pointer, VAList, by 8 to the next vaarg.
    NextPtr =
        DAG.getNode(ISD::ADD, DL, PtrVT, VAList, DAG.getIntPtrConstant(8, DL));
  }

  // Store the incremented VAList to the legalized pointer.
  InChain = DAG.getStore(Chain, DL, NextPtr, VAListPtr, MachinePointerInfo(SV));

  // Load the actual argument out of the pointer VAList.
  // We can't count on greater alignment than the word size.
  return DAG.getLoad(VT, DL, InChain, VAList, MachinePointerInfo(),
                     std::min(PtrVT.getSizeInBits(), VT.getSizeInBits()) / 8);
}

SDValue VETargetLowering::lowerDYNAMIC_STACKALLOC(SDValue Op,
                                                  SelectionDAG &DAG) const {
  // Generate following code.
  //   (void)__llvm_grow_stack(size);
  //   ret = GETSTACKTOP;        // pseudo instruction
  SDLoc DL(Op);

  // Get the inputs.
  SDNode *Node = Op.getNode();
  SDValue Chain = Op.getOperand(0);
  SDValue Size = Op.getOperand(1);
  MaybeAlign Alignment(Op.getConstantOperandVal(2));
  EVT VT = Node->getValueType(0);

  // Chain the dynamic stack allocation so that it doesn't modify the stack
  // pointer when other instructions are using the stack.
  Chain = DAG.getCALLSEQ_START(Chain, 0, 0, DL);

  const TargetFrameLowering &TFI = *Subtarget->getFrameLowering();
  Align StackAlign = TFI.getStackAlign();
  bool NeedsAlign = Alignment.valueOrOne() > StackAlign;

  // Prepare arguments
  TargetLowering::ArgListTy Args;
  TargetLowering::ArgListEntry Entry;
  Entry.Node = Size;
  Entry.Ty = Entry.Node.getValueType().getTypeForEVT(*DAG.getContext());
  Args.push_back(Entry);
  if (NeedsAlign) {
    Entry.Node = DAG.getConstant(~(Alignment->value() - 1ULL), DL, VT);
    Entry.Ty = Entry.Node.getValueType().getTypeForEVT(*DAG.getContext());
    Args.push_back(Entry);
  }
  Type *RetTy = Type::getVoidTy(*DAG.getContext());

  EVT PtrVT = Op.getValueType();
  SDValue Callee;
  if (NeedsAlign) {
    Callee = DAG.getTargetExternalSymbol("__ve_grow_stack_align", PtrVT, 0);
  } else {
    Callee = DAG.getTargetExternalSymbol("__ve_grow_stack", PtrVT, 0);
  }

  TargetLowering::CallLoweringInfo CLI(DAG);
  CLI.setDebugLoc(DL)
      .setChain(Chain)
      .setCallee(CallingConv::PreserveAll, RetTy, Callee, std::move(Args))
      .setDiscardResult(true);
  std::pair<SDValue, SDValue> pair = LowerCallTo(CLI);
  Chain = pair.second;
  SDValue Result = DAG.getNode(VEISD::GETSTACKTOP, DL, VT, Chain);
  if (NeedsAlign) {
    Result = DAG.getNode(ISD::ADD, DL, VT, Result,
                         DAG.getConstant((Alignment->value() - 1ULL), DL, VT));
    Result = DAG.getNode(ISD::AND, DL, VT, Result,
                         DAG.getConstant(~(Alignment->value() - 1ULL), DL, VT));
  }
  //  Chain = Result.getValue(1);
  Chain = DAG.getCALLSEQ_END(Chain, DAG.getIntPtrConstant(0, DL, true),
                             DAG.getIntPtrConstant(0, DL, true), SDValue(), DL);

  SDValue Ops[2] = {Result, Chain};
  return DAG.getMergeValues(Ops, DL);
}

static SDValue lowerFRAMEADDR(SDValue Op, SelectionDAG &DAG,
                              const VETargetLowering &TLI,
                              const VESubtarget *Subtarget) {
  SDLoc dl(Op);
  unsigned Depth = cast<ConstantSDNode>(Op.getOperand(0))->getZExtValue();

  MachineFunction &MF = DAG.getMachineFunction();
  MachineFrameInfo &MFI = MF.getFrameInfo();
  MFI.setFrameAddressIsTaken(true);

  EVT PtrVT = Op.getValueType();

  const VERegisterInfo *RegInfo = Subtarget->getRegisterInfo();
  Register FrameReg = RegInfo->getFrameRegister(MF);

  SDValue FrameAddr =
      DAG.getCopyFromReg(DAG.getEntryNode(), dl, FrameReg, PtrVT);
  while (Depth--)
    FrameAddr = DAG.getLoad(PtrVT, dl, DAG.getEntryNode(), FrameAddr,
                            MachinePointerInfo());
  return FrameAddr;
}

static SDValue lowerRETURNADDR(SDValue Op, SelectionDAG &DAG,
                               const VETargetLowering &TLI,
                               const VESubtarget *Subtarget) {
  MachineFunction &MF = DAG.getMachineFunction();
  MachineFrameInfo &MFI = MF.getFrameInfo();
  MFI.setReturnAddressIsTaken(true);

  if (TLI.verifyReturnAddressArgumentIsConstant(Op, DAG))
    return SDValue();

  SDLoc dl(Op);
  unsigned Depth = cast<ConstantSDNode>(Op.getOperand(0))->getZExtValue();

  auto PtrVT = TLI.getPointerTy(MF.getDataLayout());

  if (Depth > 0) {
    SDValue FrameAddr = lowerFRAMEADDR(Op, DAG, TLI, Subtarget);
    SDValue Offset = DAG.getConstant(8, dl, MVT::i64);
    return DAG.getLoad(PtrVT, dl, DAG.getEntryNode(),
                       DAG.getNode(ISD::ADD, dl, PtrVT, FrameAddr, Offset),
                       MachinePointerInfo());
  }

#if 0
  // FIXME: This implementation doesn't work on VE since we doesn't pre-allocate
  //        stack (guess).  Need modifications on stack allocation to follow
  //        other architectures in future.
  // Just load the return address off the stack.
  SDValue RetAddrFI = DAG.getFrameIndex(1, PtrVT);
  return DAG.getLoad(PtrVT, dl, DAG.getEntryNode(), RetAddrFI,
                     MachinePointerInfo());
#else
        SDValue FrameAddr = lowerFRAMEADDR(Op, DAG, TLI, Subtarget);
        SDValue Offset = DAG.getConstant(8, dl, MVT::i64);
        return DAG.getLoad(PtrVT, dl, DAG.getEntryNode(),
                           DAG.getNode(ISD::ADD, dl, PtrVT, FrameAddr, Offset),
                           MachinePointerInfo());
#endif
}

// Lower a f128 load into two f64 loads.
static SDValue LowerF128Load(SDValue Op, SelectionDAG &DAG) {
  SDLoc dl(Op);
  LoadSDNode *LdNode = dyn_cast<LoadSDNode>(Op.getNode());
  assert(LdNode && LdNode->getOffset().isUndef() && "Unexpected node type");

  unsigned alignment = LdNode->getAlign().value();
  if (alignment > 8)
    alignment = 8;

  SDValue Lo64 =
      DAG.getLoad(MVT::f64, dl, LdNode->getChain(), LdNode->getBasePtr(),
                  LdNode->getPointerInfo(), alignment,
                  LdNode->isVolatile() ? MachineMemOperand::MOVolatile
                                       : MachineMemOperand::MONone);
  EVT addrVT = LdNode->getBasePtr().getValueType();
  SDValue HiPtr = DAG.getNode(ISD::ADD, dl, addrVT, LdNode->getBasePtr(),
                              DAG.getConstant(8, dl, addrVT));
  SDValue Hi64 =
      DAG.getLoad(MVT::f64, dl, LdNode->getChain(), HiPtr,
                  LdNode->getPointerInfo(), alignment,
                  LdNode->isVolatile() ? MachineMemOperand::MOVolatile
                                       : MachineMemOperand::MONone);

  SDValue SubRegEven = DAG.getTargetConstant(VE::sub_even, dl, MVT::i32);
  SDValue SubRegOdd = DAG.getTargetConstant(VE::sub_odd, dl, MVT::i32);

  // VE stores Hi64 to 8(addr) and Lo64 to 0(addr)
  SDNode *InFP128 =
      DAG.getMachineNode(TargetOpcode::IMPLICIT_DEF, dl, MVT::f128);
  InFP128 = DAG.getMachineNode(TargetOpcode::INSERT_SUBREG, dl, MVT::f128,
                               SDValue(InFP128, 0), Hi64, SubRegEven);
  InFP128 = DAG.getMachineNode(TargetOpcode::INSERT_SUBREG, dl, MVT::f128,
                               SDValue(InFP128, 0), Lo64, SubRegOdd);
  SDValue OutChains[2] = {SDValue(Lo64.getNode(), 1),
                          SDValue(Hi64.getNode(), 1)};
  SDValue OutChain = DAG.getNode(ISD::TokenFactor, dl, MVT::Other, OutChains);
  SDValue Ops[2] = {SDValue(InFP128, 0), OutChain};
  return DAG.getMergeValues(Ops, dl);
}

// Lower a vXi1 load into following instructions
//   LDrii %1, (,%addr)
//   LVMxir  %vm, 0, %1
//   LDrii %2, 8(,%addr)
//   LVMxir  %vm, 0, %2
//   ...
static SDValue LowerI1Load(SDValue Op, SelectionDAG &DAG) {
  LLVM_DEBUG(dbgs() << "LowerI1LOAD ("; Op->print(dbgs()); dbgs() << ")\n");
  SDLoc DL(Op);
  LoadSDNode *LdNode = dyn_cast<LoadSDNode>(Op.getNode());
  assert(LdNode && LdNode->getOffset().isUndef() && "Unexpected node type");

  SDValue BasePtr = LdNode->getBasePtr();
  unsigned alignment = LdNode->getAlign().value();
  if (alignment > 8)
    alignment = 8;

  EVT addrVT = BasePtr.getValueType();
  EVT MemVT = LdNode->getMemoryVT();
  if (MemVT == MVT::v256i1 || MemVT == MVT::v4i64) {
    SDValue OutChains[4];
    SDNode *VM = DAG.getMachineNode(TargetOpcode::IMPLICIT_DEF, DL, MemVT);
    for (int i = 0; i < 4; ++i) {
      // Generate load dag and prepare chains.
      SDValue Addr = DAG.getNode(ISD::ADD, DL, addrVT, BasePtr,
                                 DAG.getConstant(8 * i, DL, addrVT));
      SDValue Val =
          DAG.getLoad(MVT::i64, DL, LdNode->getChain(), Addr,
                      LdNode->getPointerInfo(), alignment,
                      LdNode->isVolatile() ? MachineMemOperand::MOVolatile
                                           : MachineMemOperand::MONone);
      OutChains[i] = SDValue(Val.getNode(), 1);

      VM = DAG.getMachineNode(VE::LVMir_m, DL, MVT::i64,
                              DAG.getTargetConstant(i, DL, MVT::i64), Val,
                              SDValue(VM, 0));
    }
    SDValue OutChain = DAG.getNode(ISD::TokenFactor, DL, MVT::Other, OutChains);
    SDValue Ops[2] = {SDValue(VM, 0), OutChain};
    return DAG.getMergeValues(Ops, DL);
  } else if (MemVT == MVT::v512i1 || MemVT == MVT::v8i64) {
    SDValue OutChains[8];
    SDNode *VM = DAG.getMachineNode(TargetOpcode::IMPLICIT_DEF, DL, MemVT);
    for (int i = 0; i < 8; ++i) {
      // Generate load dag and prepare chains.
      SDValue Addr = DAG.getNode(ISD::ADD, DL, addrVT, BasePtr,
                                 DAG.getConstant(8 * i, DL, addrVT));
      SDValue Val =
          DAG.getLoad(MVT::i64, DL, LdNode->getChain(), Addr,
                      LdNode->getPointerInfo(), alignment,
                      LdNode->isVolatile() ? MachineMemOperand::MOVolatile
                                           : MachineMemOperand::MONone);
      OutChains[i] = SDValue(Val.getNode(), 1);

      VM = DAG.getMachineNode(VE::LVMyir_y, DL, MVT::i64,
                              DAG.getTargetConstant(i, DL, MVT::i64), Val,
                              SDValue(VM, 0));
    }
    SDValue OutChain = DAG.getNode(ISD::TokenFactor, DL, MVT::Other, OutChains);
    SDValue Ops[2] = {SDValue(VM, 0), OutChain};
    return DAG.getMergeValues(Ops, DL);
  } else {
    // Otherwise, ask llvm to expand it.
    return SDValue();
  }
}

SDValue VETargetLowering::LowerLOAD(SDValue Op, SelectionDAG &DAG) const {
  LLVM_DEBUG(dbgs() << "LowerLOAD ("; Op->print(dbgs()); dbgs() << ")\n");
  LoadSDNode *LdNode = cast<LoadSDNode>(Op.getNode());
  auto MemVT = LdNode->getMemoryVT();

  // always expand non-mask vector loads to VVP
  if (MemVT.isVector() && !isVectorMaskType(MemVT))
    return lowerToVVP(Op, DAG, VVPExpansionMode::ToNativeWidth);

  SDValue BasePtr = LdNode->getBasePtr();
  if (isa<FrameIndexSDNode>(BasePtr.getNode())) {
    LLVM_DEBUG(dbgs() << "is LOAD from frameidx. Skpping!\n");
    // Do not expand store instruction with frame index here because of
    // dependency problems.  We expand it later in eliminateFrameIndex().
    return Op;
  }

  if (MemVT == MVT::f128)
    return LowerF128Load(Op, DAG);
  if (isVectorMaskType(MemVT))
    return LowerI1Load(Op, DAG);

  return Op;
}

// Lower a f128 store into two f64 stores.
// Lower a f128 store into two f64 stores.
static SDValue LowerF128Store(SDValue Op, SelectionDAG &DAG) {
  SDLoc dl(Op);
  StoreSDNode *StNode = dyn_cast<StoreSDNode>(Op.getNode());
  assert(StNode && StNode->getOffset().isUndef() && "Unexpected node type");

  SDValue SubRegEven = DAG.getTargetConstant(VE::sub_even, dl, MVT::i32);
  SDValue SubRegOdd = DAG.getTargetConstant(VE::sub_odd, dl, MVT::i32);

  SDNode *Hi64 = DAG.getMachineNode(TargetOpcode::EXTRACT_SUBREG, dl, MVT::i64,
                                    StNode->getValue(), SubRegEven);
  SDNode *Lo64 = DAG.getMachineNode(TargetOpcode::EXTRACT_SUBREG, dl, MVT::i64,
                                    StNode->getValue(), SubRegOdd);

  unsigned alignment = StNode->getAlign().value();
  if (alignment > 8)
    alignment = 8;

  // VE stores Hi64 to 8(addr) and Lo64 to 0(addr)
  SDValue OutChains[2];
  OutChains[0] =
      DAG.getStore(StNode->getChain(), dl, SDValue(Lo64, 0),
                   StNode->getBasePtr(), MachinePointerInfo(), alignment,
                   StNode->isVolatile() ? MachineMemOperand::MOVolatile
                                        : MachineMemOperand::MONone);
  EVT addrVT = StNode->getBasePtr().getValueType();
  SDValue HiPtr = DAG.getNode(ISD::ADD, dl, addrVT, StNode->getBasePtr(),
                              DAG.getConstant(8, dl, addrVT));
  OutChains[1] =
      DAG.getStore(StNode->getChain(), dl, SDValue(Hi64, 0), HiPtr,
                   MachinePointerInfo(), alignment,
                   StNode->isVolatile() ? MachineMemOperand::MOVolatile
                                        : MachineMemOperand::MONone);
  return DAG.getNode(ISD::TokenFactor, dl, MVT::Other, OutChains);
}

// Lower a vXi1 store into following instructions
//   SVMi  %1, %vm, 0
//   STrii %1, (,%addr)
//   SVMi  %2, %vm, 1
//   STrii %2, 8(,%addr)
//   ...
static SDValue LowerI1Store(SDValue Op, SelectionDAG &DAG) {
  SDLoc DL(Op);
  StoreSDNode *StNode = dyn_cast<StoreSDNode>(Op.getNode());
  assert(StNode && StNode->getOffset().isUndef() && "Unexpected node type");

  SDValue BasePtr = StNode->getBasePtr();
  unsigned alignment = StNode->getAlign().value();
  if (alignment > 8)
    alignment = 8;
  EVT addrVT = BasePtr.getValueType();
  EVT MemVT = StNode->getMemoryVT();
  if (MemVT == MVT::v256i1 || MemVT == MVT::v4i64) {
    SDValue OutChains[4];
    for (int i = 0; i < 4; ++i) {
      SDNode *V =
          DAG.getMachineNode(VE::SVMmi, DL, MVT::i64, StNode->getValue(),
                             DAG.getTargetConstant(i, DL, MVT::i64));
      SDValue Addr = DAG.getNode(ISD::ADD, DL, addrVT, BasePtr,
                                 DAG.getConstant(8 * i, DL, addrVT));
      OutChains[i] =
          DAG.getStore(StNode->getChain(), DL, SDValue(V, 0), Addr,
                       MachinePointerInfo(), alignment,
                       StNode->isVolatile() ? MachineMemOperand::MOVolatile
                                            : MachineMemOperand::MONone);
    }
    return DAG.getNode(ISD::TokenFactor, DL, MVT::Other, OutChains);
  } else if (MemVT == MVT::v512i1 || MemVT == MVT::v8i64) {
    SDValue OutChains[8];
    for (int i = 0; i < 8; ++i) {
      SDNode *V =
          DAG.getMachineNode(VE::SVMyi, DL, MVT::i64, StNode->getValue(),
                             DAG.getTargetConstant(i, DL, MVT::i64));
      SDValue Addr = DAG.getNode(ISD::ADD, DL, addrVT, BasePtr,
                                 DAG.getConstant(8 * i, DL, addrVT));
      OutChains[i] =
          DAG.getStore(StNode->getChain(), DL, SDValue(V, 0), Addr,
                       MachinePointerInfo(), alignment,
                       StNode->isVolatile() ? MachineMemOperand::MOVolatile
                                            : MachineMemOperand::MONone);
    }
    return DAG.getNode(ISD::TokenFactor, DL, MVT::Other, OutChains);
  } else {
    // Otherwise, ask llvm to expand it.
    return SDValue();
  }
}

SDValue VETargetLowering::LowerSTORE(SDValue Op, SelectionDAG &DAG) const {
  SDLoc dl(Op);
  StoreSDNode *StNode = cast<StoreSDNode>(Op.getNode());
  assert(StNode && StNode->getOffset().isUndef() && "Unexpected node type");

  EVT MemVT = StNode->getMemoryVT();

  // Use expansion for all non-mask vector stores
  if (MemVT.isVector() && !isVectorMaskType(MemVT))
    return lowerToVVP(Op, DAG, VVPExpansionMode::ToNativeWidth);

  // Otw, use deferred lowering for frame pointer stores
  SDValue BasePtr = StNode->getBasePtr();
  if (isa<FrameIndexSDNode>(BasePtr.getNode())) {
    // Do not expand store instruction with frame index here because of
    // dependency problems.  We expand it later in eliminateFrameIndex().
    return Op;
  }

  // Non-frame pointer stores for other types
  if (isVectorMaskType(MemVT))
    return LowerI1Store(Op, DAG);

  if (MemVT == MVT::f128)
    return LowerF128Store(Op, DAG);

  // Otherwise, this store is legal
  return Op;
}

SDValue VETargetLowering::LowerATOMIC_FENCE(SDValue Op,
                                            SelectionDAG &DAG) const {
  SDLoc DL(Op);
  AtomicOrdering FenceOrdering = static_cast<AtomicOrdering>(
      cast<ConstantSDNode>(Op.getOperand(1))->getZExtValue());
  SyncScope::ID FenceSSID = static_cast<SyncScope::ID>(
      cast<ConstantSDNode>(Op.getOperand(2))->getZExtValue());

  // VE uses Release consistency, so need a fence instruction if it is a
  // cross-thread fence.
  if (FenceSSID == SyncScope::System) {
    switch (FenceOrdering) {
    case AtomicOrdering::NotAtomic:
    case AtomicOrdering::Unordered:
    case AtomicOrdering::Monotonic:
      // No need to generate fencem instruction here.
      break;
    case AtomicOrdering::Acquire:
      // Generate "fencem 2" as acquire fence.
      return SDValue(DAG.getMachineNode(VE::FENCEM, DL, MVT::Other,
                                        DAG.getTargetConstant(2, DL, MVT::i32),
                                        Op.getOperand(0)),
                     0);
    case AtomicOrdering::Release:
      // Generate "fencem 1" as release fence.
      return SDValue(DAG.getMachineNode(VE::FENCEM, DL, MVT::Other,
                                        DAG.getTargetConstant(1, DL, MVT::i32),
                                        Op.getOperand(0)),
                     0);
    case AtomicOrdering::AcquireRelease:
    case AtomicOrdering::SequentiallyConsistent:
      // Generate "fencem 3" as acq_rel and seq_cst fence.
      // FIXME: "fencem 3" doesn't wait for for PCIe deveices accesses,
      //        so  seq_cst may require more instruction for them.
      return SDValue(DAG.getMachineNode(VE::FENCEM, DL, MVT::Other,
                                        DAG.getTargetConstant(3, DL, MVT::i32),
                                        Op.getOperand(0)),
                     0);
    }
  }

  // MEMBARRIER is a compiler barrier; it codegens to a no-op.
  return DAG.getNode(VEISD::MEMBARRIER, DL, MVT::Other, Op.getOperand(0));
}

SDValue VETargetLowering::LowerATOMIC_SWAP(SDValue Op,
                                           SelectionDAG &DAG) const {
  AtomicSDNode *N = cast<AtomicSDNode>(Op);

  // Custom Lowering 1 byte ATOMIC_SWAP.
  if (N->getMemoryVT() == MVT::i8) {
    SDLoc DL(Op);

    SDValue Src = N->getOperand(1);
    SDValue Value = N->getOperand(2);

    SDValue Const3 = DAG.getConstant(3, DL, MVT::i64);
    SDValue Const24 = DAG.getConstant(24, DL, MVT::i64);

    // Generate "ts1am" as 1 byte ATOMIC_SWAP.
    SDValue AlignedAddress =
        DAG.getNode(ISD::AND, DL, Src.getValueType(),
                    {Src, DAG.getConstant(-4, DL, MVT::i64)});
    SDValue Remainder =
        DAG.getNode(ISD::AND, DL, Src.getValueType(), {Src, Const3});
    SDValue ShiftedFlag = DAG.getNode(
        ISD::SHL, DL, MVT::i32, {DAG.getConstant(1, DL, MVT::i32), Remainder});
    SDValue ShiftBits = DAG.getNode(ISD::SHL, DL, Remainder.getValueType(),
                                    {Remainder, Const3});
    SDValue NewValue =
        DAG.getNode(ISD::SHL, DL, Value.getValueType(), {Value, ShiftBits});
    SDValue TS1AM =
        DAG.getAtomic(VEISD::TS1AM, DL, N->getMemoryVT(),
                      DAG.getVTList(Op.getNode()->getValueType(0),
                                    Op.getNode()->getValueType(1)),
                      {N->getChain(), AlignedAddress, ShiftedFlag, NewValue},
                      N->getMemOperand());

    // Extract 1 byte result.
    SDValue SUB =
        DAG.getNode(ISD::SUB, DL, Const24.getValueType(), {Const24, ShiftBits});
    SDValue ShiftLeftFor1Byte =
        DAG.getNode(ISD::SHL, DL, TS1AM.getValueType(), {TS1AM, SUB});
    SDValue ShiftRightFor1Byte =
        DAG.getNode(ISD::SRA, DL, ShiftLeftFor1Byte.getValueType(),
                    {ShiftLeftFor1Byte, Const24});

    SDValue Chain = TS1AM.getValue(1);
    return DAG.getMergeValues({ShiftRightFor1Byte, Chain}, DL);
  }
  // Otherwise, let llvm legalize it.
  return Op;
}

SDValue VETargetLowering::lowerINTRINSIC_WO_CHAIN(SDValue Op,
                                                  SelectionDAG & DAG) const {
  SDLoc dl(Op);
  unsigned IntNo = cast<ConstantSDNode>(Op.getOperand(0))->getZExtValue();
  switch (IntNo) {
  default:
    return SDValue(); // Don't custom lower most intrinsics.
  case Intrinsic::thread_pointer: {
    report_fatal_error("Intrinsic::thread_point is not implemented yet");
  }
  case Intrinsic::eh_sjlj_lsda: {
    MachineFunction &MF = DAG.getMachineFunction();
    const TargetLowering &TLI = DAG.getTargetLoweringInfo();
    MVT PtrVT = TLI.getPointerTy(DAG.getDataLayout());
    const VETargetMachine *TM =
        static_cast<const VETargetMachine *>(&DAG.getTarget());

    // Creat GCC_except_tableXX string.  The real symbol for that will be
    // generated in EHStreamer::emitExceptionTable() later.  So, we just
    // borrow it's name here.
    TM->getStrList()->push_back(std::string(
        (Twine("GCC_except_table") + Twine(MF.getFunctionNumber())).str()));
    SDValue Addr =
        DAG.getTargetExternalSymbol(TM->getStrList()->back().c_str(), PtrVT, 0);
    if (isPositionIndependent()) {
      Addr = makeHiLoPair(Addr, VEMCExpr::VK_VE_GOTOFF_HI32,
                          VEMCExpr::VK_VE_GOTOFF_LO32, DAG);
      SDValue GlobalBase = DAG.getNode(VEISD::GLOBAL_BASE_REG, dl, PtrVT);
      return DAG.getNode(ISD::ADD, dl, PtrVT, GlobalBase, Addr);
    } else {
      return makeHiLoPair(Addr, VEMCExpr::VK_VE_HI32, VEMCExpr::VK_VE_LO32,
                          DAG);
    }
  }
  }
}

SDValue VETargetLowering::lowerINTRINSIC_W_CHAIN(SDValue Op,
                                                 SelectionDAG &DAG) const {
  SDLoc dl(Op);
  unsigned IntNo = cast<ConstantSDNode>(Op.getOperand(1))->getZExtValue();
  switch (IntNo) {
  default:
    return SDValue(); // Don't custom lower most intrinsics.
  }
}

SDValue VETargetLowering::lowerINTRINSIC_VOID(SDValue Op,
                                              SelectionDAG &DAG) const {
  SDLoc dl(Op);
  unsigned IntNo = cast<ConstantSDNode>(Op.getOperand(1))->getZExtValue();
  switch (IntNo) {
  default:
    return SDValue(); // Don't custom lower most intrinsics.
  }
}

// Should we expand the build vector with shuffles?
bool VETargetLowering::shouldExpandBuildVectorWithShuffles(
    EVT VT, unsigned DefinedValues) const {
#if 1
  // FIXME: Change this to true or expression once we implement custom
  // expansion of VECTOR_SHUFFLE completely.

  // Not use VECTOR_SHUFFLE to expand BUILD_VECTOR atm.  Because, it causes
  // infinity expand loop between both instructions since VECTOR_SHUFFLE
  // is not implemented completely yet.
  return false;
#else
        return DefinedValues < 3;
#endif
}

SDValue VETargetLowering::lowerBUILD_VECTOR(SDValue Op,
                                            SelectionDAG & DAG) const {
  if (Subtarget->enableVPU())
    return lowerVVP_BUILD_VECTOR(Op, DAG);
  if (Subtarget->intrinsic())
    return lowerSIMD_BUILD_VECTOR(Op, DAG);
  if (Subtarget->vectorize())
    return lowerSIMD_BUILD_VECTOR(Op, DAG);
  return SDValue();
}

SDValue VETargetLowering::lowerVECTOR_SHUFFLE(SDValue Op,
                                              SelectionDAG & DAG) const {
  if (Subtarget->intrinsic())
    return lowerSIMD_VECTOR_SHUFFLE(Op, DAG);
  if (Subtarget->vectorize())
    return lowerSIMD_VECTOR_SHUFFLE(Op, DAG);
  return SDValue();
}

SDValue VETargetLowering::lowerINSERT_VECTOR_ELT(
    SDValue Op, SelectionDAG & DAG) const {
  if (Subtarget->intrinsic())
    return lowerSIMD_INSERT_VECTOR_ELT(Op, DAG);
  if (Subtarget->vectorize())
    return lowerSIMD_INSERT_VECTOR_ELT(Op, DAG);
  return SDValue();
}


SDValue VETargetLowering::lowerEXTRACT_VECTOR_ELT(SDValue Op, SelectionDAG & DAG) {
  if (Subtarget->intrinsic())
    return lowerSIMD_EXTRACT_VECTOR_ELT(Op, DAG);
  if (Subtarget->vectorize())
    return lowerSIMD_EXTRACT_VECTOR_ELT(Op, DAG);
  return SDValue();
}

SDValue VETargetLowering::lowerMGATHER(SDValue Op, SelectionDAG & DAG)
    const {
  if (Subtarget->vectorize())
    return lowerSIMD_MGATHER_MSCATTER(Op, DAG);
  return SDValue();
}

SDValue VETargetLowering::lowerMSCATTER(SDValue Op, SelectionDAG & DAG)
    const {
  if (Subtarget->vectorize())
    return lowerSIMD_MGATHER_MSCATTER(Op, DAG);
  return SDValue();
}

SDValue VETargetLowering::lowerMLOAD(SDValue Op, SelectionDAG &DAG) const {
  if (Subtarget->vectorize())
    return lowerSIMD_MLOAD(Op, DAG);
  return SDValue();
}

/// } Custom Lower

/// JumpTable for VE.
///
///   VE cannot generate relocatable symbol in jump table.  VE cannot
///   generate expressions using symbols in both text segment and data
///   segment like below.
///             .4byte  .LBB0_2-.LJTI0_0
///   So, we generate offset from the top of function like below as
///   a custom label.
///             .4byte  .LBB0_2-<function name>

unsigned VETargetLowering::getJumpTableEncoding() const {
  // Use custom label for PIC.
  if (isPositionIndependent())
    return MachineJumpTableInfo::EK_Custom32;

  // Otherwise, use the normal jump table encoding heuristics.
  return TargetLowering::getJumpTableEncoding();
}

const MCExpr *VETargetLowering::LowerCustomJumpTableEntry(
    const MachineJumpTableInfo *MJTI, const MachineBasicBlock *MBB,
    unsigned Uid, MCContext &Ctx) const {
  assert(isPositionIndependent());

  // Generate custom label for PIC like below.
  //    .4bytes  .LBB0_2-<function name>
  const auto *Value = MCSymbolRefExpr::create(MBB->getSymbol(), Ctx);
  MCSymbol *Sym = Ctx.getOrCreateSymbol(MBB->getParent()->getName().data());
  const auto *Base = MCSymbolRefExpr::create(Sym, Ctx);
  return MCBinaryExpr::createSub(Value, Base, Ctx);
}

SDValue VETargetLowering::getPICJumpTableRelocBase(SDValue Table,
                                                   SelectionDAG &DAG) const {
  assert(isPositionIndependent());
  SDLoc DL(Table);
  Function *Function = &DAG.getMachineFunction().getFunction();
  assert(Function != nullptr);
  auto PtrTy = getPointerTy(DAG.getDataLayout(), Function->getAddressSpace());

  // In the jump table, we have following values in PIC mode.
  //    .4bytes  .LBB0_2-<function name>
  // We need to add this value and the address of this function to generate
  // .LBB0_2 label correctly under PIC mode.  So, we want to generate following
  // instructions:
  //     lea %reg, fun@gotoff_lo
  //     and %reg, %reg, (32)0
  //     lea.sl %reg, fun@gotoff_hi(%reg, %got)
  // In order to do so, we need to genarate correctly marked DAG node using
  // makeHiLoPair.
  SDValue Op = DAG.getGlobalAddress(Function, DL, PtrTy);
  SDValue HiLo = makeHiLoPair(Op, VEMCExpr::VK_VE_GOTOFF_HI32,
                              VEMCExpr::VK_VE_GOTOFF_LO32, DAG);
  SDValue GlobalBase = DAG.getNode(VEISD::GLOBAL_BASE_REG, DL, PtrTy);
  return DAG.getNode(ISD::ADD, DL, PtrTy, GlobalBase, HiLo);
}

void VETargetLowering::SetupEntryBlockForSjLj(MachineInstr &MI,
                                              MachineBasicBlock *MBB,
                                              MachineBasicBlock *DispatchBB,
                                              int FI) const {
  DebugLoc DL = MI.getDebugLoc();
  MachineFunction *MF = MBB->getParent();
  MachineRegisterInfo *MRI = &MF->getRegInfo();
  const VEInstrInfo *TII = Subtarget->getInstrInfo();

  const TargetRegisterClass *TRC = &VE::I64RegClass;
  Register Tmp1 = MRI->createVirtualRegister(TRC);
  Register Tmp2 = MRI->createVirtualRegister(TRC);
  Register VR = MRI->createVirtualRegister(TRC);
  unsigned Op = VE::STrii;

  if (isPositionIndependent()) {
    // Create following instructions for local linkage PIC code.
    //     lea %Tmp1, DispatchBB@gotoff_lo
    //     and %Tmp2, %Tmp1, (32)0
    //     lea.sl %Tmp3, DispatchBB@gotoff_hi(%Tmp2)
    //     adds.l %VR, %s15, %Tmp3                  ; %s15 is GOT
    // FIXME: use lea.sl %BReg, .LJTI0_0@gotoff_hi(%Tmp2, %s15)
    unsigned Tmp3 = MRI->createVirtualRegister(&VE::I64RegClass);
    BuildMI(*MBB, MI, DL, TII->get(VE::LEAzii), Tmp1)
        .addImm(0)
        .addImm(0)
        .addMBB(DispatchBB, VEMCExpr::VK_VE_GOTOFF_LO32);
    BuildMI(*MBB, MI, DL, TII->get(VE::ANDrm), Tmp2)
        .addReg(Tmp1)
        .addImm(M0(32));
    BuildMI(*MBB, MI, DL, TII->get(VE::LEASLrii), Tmp3)
        .addReg(Tmp2)
        .addImm(0)
        .addMBB(DispatchBB, VEMCExpr::VK_VE_GOTOFF_HI32);
    BuildMI(*MBB, MI, DL, TII->get(VE::ADDSLrr), VR)
        .addReg(VE::SX15)
        .addReg(Tmp3);
  } else {
    // lea     %Tmp1, DispatchBB@lo
    // and     %Tmp2, %Tmp1, (32)0
    // lea.sl  %VR, DispatchBB@hi(%Tmp2)
    BuildMI(*MBB, MI, DL, TII->get(VE::LEAzii), Tmp1)
        .addImm(0)
        .addImm(0)
        .addMBB(DispatchBB, VEMCExpr::VK_VE_LO32);
    BuildMI(*MBB, MI, DL, TII->get(VE::ANDrm), Tmp2)
        .addReg(Tmp1)
        .addImm(M0(32));
    BuildMI(*MBB, MI, DL, TII->get(VE::LEASLrii), VR)
        .addReg(Tmp2)
        .addImm(0)
        .addMBB(DispatchBB, VEMCExpr::VK_VE_HI32);
  }

  MachineInstrBuilder MIB = BuildMI(*MBB, MI, DL, TII->get(Op));
  addFrameReference(MIB, FI, 56 + 16);
  MIB.addReg(VR);
}

MachineBasicBlock *
VETargetLowering::emitEHSjLjSetJmp(MachineInstr &MI,
                                   MachineBasicBlock *MBB) const {
  DebugLoc DL = MI.getDebugLoc();
  MachineFunction *MF = MBB->getParent();
  const TargetInstrInfo *TII = Subtarget->getInstrInfo();
  const TargetRegisterInfo *TRI = Subtarget->getRegisterInfo();
  MachineRegisterInfo &MRI = MF->getRegInfo();

  const BasicBlock *BB = MBB->getBasicBlock();
  MachineFunction::iterator I = ++MBB->getIterator();

  // Memory Reference
  SmallVector<MachineMemOperand *, 2> MMOs(MI.memoperands_begin(),
                                           MI.memoperands_end());
  Register BufReg = MI.getOperand(1).getReg();

  Register DstReg;

  DstReg = MI.getOperand(0).getReg();
  const TargetRegisterClass *RC = MRI.getRegClass(DstReg);
  assert(TRI->isTypeLegalForClass(*RC, MVT::i32) && "Invalid destination!");
  (void)TRI;
  Register mainDstReg = MRI.createVirtualRegister(RC);
  Register restoreDstReg = MRI.createVirtualRegister(RC);

  // For v = setjmp(buf), we generate
  //
  // thisMBB:
  //  buf[3] = %s17 iff %s17 is used as BP
  //  buf[1] = restoreMBB
  //  SjLjSetup restoreMBB
  //
  // mainMBB:
  //  v_main = 0
  //
  // sinkMBB:
  //  v = phi(main, restore)
  //
  // restoreMBB:
  //  %s17 = buf[3] = iff %s17 is used as BP
  //  v_restore = 1

  MachineBasicBlock *thisMBB = MBB;
  MachineBasicBlock *mainMBB = MF->CreateMachineBasicBlock(BB);
  MachineBasicBlock *sinkMBB = MF->CreateMachineBasicBlock(BB);
  MachineBasicBlock *restoreMBB = MF->CreateMachineBasicBlock(BB);
  MF->insert(I, mainMBB);
  MF->insert(I, sinkMBB);
  MF->push_back(restoreMBB);
  restoreMBB->setHasAddressTaken();

  // Transfer the remainder of BB and its successor edges to sinkMBB.
  sinkMBB->splice(sinkMBB->begin(), MBB,
                  std::next(MachineBasicBlock::iterator(MI)), MBB->end());
  sinkMBB->transferSuccessorsAndUpdatePHIs(MBB);

  // thisMBB:
  Register LabelReg = MRI.createVirtualRegister(&VE::I64RegClass);
  Register Tmp1 = MRI.createVirtualRegister(&VE::I64RegClass);
  Register Tmp2 = MRI.createVirtualRegister(&VE::I64RegClass);

  if (isPositionIndependent()) {
    // Create following instructions for local linkage PIC code.
    //     lea %Tmp1, restoreMBB@gotoff_lo
    //     and %Tmp2, %Tmp1, (32)0
    //     lea.sl %Tmp3, restoreMBB@gotoff_hi(%Tmp2)
    //     adds.l %LabelReg, %s15, %Tmp3                  ; %s15 is GOT
    // FIXME: use lea.sl %BReg, .LJTI0_0@gotoff_hi(%Tmp2, %s15)
    Register Tmp3 = MRI.createVirtualRegister(&VE::I64RegClass);
    BuildMI(*MBB, MI, DL, TII->get(VE::LEAzii), Tmp1)
        .addImm(0)
        .addImm(0)
        .addMBB(restoreMBB, VEMCExpr::VK_VE_GOTOFF_LO32);
    BuildMI(*MBB, MI, DL, TII->get(VE::ANDrm), Tmp2)
        .addReg(Tmp1)
        .addImm(M0(32));
    BuildMI(*MBB, MI, DL, TII->get(VE::LEASLrii), Tmp3)
        .addReg(Tmp2)
        .addImm(0)
        .addMBB(restoreMBB, VEMCExpr::VK_VE_GOTOFF_HI32);
    BuildMI(*MBB, MI, DL, TII->get(VE::ADDSLrr), LabelReg)
        .addReg(VE::SX15)
        .addReg(Tmp3);
  } else {
    // lea     %Tmp1, restoreMBB@lo
    // and     %Tmp2, %Tmp1, (32)0
    // lea.sl  %LabelReg, restoreMBB@hi(%Tmp2)
    BuildMI(*MBB, MI, DL, TII->get(VE::LEAzii), Tmp1)
        .addImm(0)
        .addImm(0)
        .addMBB(restoreMBB, VEMCExpr::VK_VE_LO32);
    BuildMI(*MBB, MI, DL, TII->get(VE::ANDrm), Tmp2)
        .addReg(Tmp1)
        .addImm(M0(32));
    BuildMI(*MBB, MI, DL, TII->get(VE::LEASLrii), LabelReg)
        .addReg(Tmp2)
        .addImm(0)
        .addMBB(restoreMBB, VEMCExpr::VK_VE_HI32);
  }

  // Store BP
  const VEFrameLowering *TFI = Subtarget->getFrameLowering();
  if (TFI->hasBP(*MF)) {
    // store BP in buf[3]
    MachineInstrBuilder MIB = BuildMI(*MBB, MI, DL, TII->get(VE::STrii));
    MIB.addReg(BufReg);
    MIB.addImm(0);
    MIB.addImm(24);
    MIB.addReg(VE::SX17);
    MIB.setMemRefs(MMOs);
  }

  // Store IP
  MachineInstrBuilder MIB = BuildMI(*MBB, MI, DL, TII->get(VE::STrii));
  MIB.add(MI.getOperand(1));
  MIB.addImm(0);
  MIB.addImm(8);
  MIB.addReg(LabelReg);
  MIB.setMemRefs(MMOs);

  // SP/FP are already stored in jmpbuf before `llvm.eh.sjlj.setjmp`.

  // Setup
  MIB =
      BuildMI(*thisMBB, MI, DL, TII->get(VE::EH_SjLj_Setup)).addMBB(restoreMBB);

  const VERegisterInfo *RegInfo = Subtarget->getRegisterInfo();
  MIB.addRegMask(RegInfo->getNoPreservedMask());
  thisMBB->addSuccessor(mainMBB);
  thisMBB->addSuccessor(restoreMBB);

  // mainMBB:
  BuildMI(mainMBB, DL, TII->get(VE::LEAzii), mainDstReg)
      .addImm(0)
      .addImm(0)
      .addImm(0);
  mainMBB->addSuccessor(sinkMBB);

  // sinkMBB:
  BuildMI(*sinkMBB, sinkMBB->begin(), DL, TII->get(VE::PHI), DstReg)
      .addReg(mainDstReg)
      .addMBB(mainMBB)
      .addReg(restoreDstReg)
      .addMBB(restoreMBB);

  // restoreMBB:
  if (TFI->hasBP(*MF)) {
    // Restore BP from buf[3].  The address of buf is in SX10.
    // FIXME: Better to not use SX10 here
    MachineInstrBuilder MIB =
        BuildMI(restoreMBB, DL, TII->get(VE::LDrii), VE::SX17);
    MIB.addReg(VE::SX10);
    MIB.addImm(0);
    MIB.addImm(24);
    MIB.setMemRefs(MMOs);
  }
  BuildMI(restoreMBB, DL, TII->get(VE::LEAzii), restoreDstReg)
      .addImm(0)
      .addImm(0)
      .addImm(1);
  BuildMI(restoreMBB, DL, TII->get(VE::BRCFLa_t)).addMBB(sinkMBB);
  restoreMBB->addSuccessor(sinkMBB);

  MI.eraseFromParent();
  return sinkMBB;
}

MachineBasicBlock *
VETargetLowering::emitEHSjLjLongJmp(MachineInstr &MI,
                                    MachineBasicBlock *MBB) const {
  DebugLoc DL = MI.getDebugLoc();
  MachineFunction *MF = MBB->getParent();
  const TargetInstrInfo *TII = Subtarget->getInstrInfo();
  MachineRegisterInfo &MRI = MF->getRegInfo();

  // Memory Reference
  SmallVector<MachineMemOperand *, 2> MMOs(MI.memoperands_begin(),
                                           MI.memoperands_end());
  Register BufReg = MI.getOperand(0).getReg();

  Register Tmp = MRI.createVirtualRegister(&VE::I64RegClass);
  // Since FP is only updated here but NOT referenced, it's treated as GPR.
  const Register FP = VE::SX9;
  const Register SP = VE::SX11;

  MachineInstrBuilder MIB;

  MachineBasicBlock *thisMBB = MBB;

  // Reload FP
  MIB = BuildMI(*thisMBB, MI, DL, TII->get(VE::LDrii), FP);
  MIB.addReg(BufReg);
  MIB.addImm(0);
  MIB.addImm(0);
  MIB.setMemRefs(MMOs);

  // Reload IP
  MIB = BuildMI(*thisMBB, MI, DL, TII->get(VE::LDrii), Tmp);
  MIB.addReg(BufReg);
  MIB.addImm(0);
  MIB.addImm(8);
  MIB.setMemRefs(MMOs);

  // Copy BufReg to SX10 for later use in setjmp
  // FIXME: Better to not use SX10 here
  BuildMI(*thisMBB, MI, DL, TII->get(VE::ORri), VE::SX10)
      .addReg(BufReg)
      .addImm(0);

  // Reload SP
  MIB = BuildMI(*thisMBB, MI, DL, TII->get(VE::LDrii), SP);
  MIB.add(MI.getOperand(0)); // we can preserve the kill flags here.
  MIB.addImm(0);
  MIB.addImm(16);
  MIB.setMemRefs(MMOs);

  // Jump
  BuildMI(*thisMBB, MI, DL, TII->get(VE::BCFLari_t)).addReg(Tmp).addImm(0);

  MI.eraseFromParent();
  return thisMBB;
}

MachineBasicBlock *
VETargetLowering::EmitSjLjDispatchBlock(MachineInstr &MI,
                                        MachineBasicBlock *BB) const {
  DebugLoc DL = MI.getDebugLoc();
  MachineFunction *MF = BB->getParent();
  MachineFrameInfo &MFI = MF->getFrameInfo();
  MachineRegisterInfo *MRI = &MF->getRegInfo();
  const VEInstrInfo *TII = Subtarget->getInstrInfo();
  int FI = MFI.getFunctionContextIndex();

  // Get a mapping of the call site numbers to all of the landing pads they're
  // associated with.
  DenseMap<unsigned, SmallVector<MachineBasicBlock *, 2>> CallSiteNumToLPad;
  unsigned MaxCSNum = 0;
  for (auto &MBB : *MF) {
    if (!MBB.isEHPad())
      continue;

    MCSymbol *Sym = nullptr;
    for (const auto &MI : MBB) {
      if (MI.isDebugInstr())
        continue;

      assert(MI.isEHLabel() && "expected EH_LABEL");
      Sym = MI.getOperand(0).getMCSymbol();
      break;
    }

    if (!MF->hasCallSiteLandingPad(Sym))
      continue;

    for (unsigned CSI : MF->getCallSiteLandingPad(Sym)) {
      CallSiteNumToLPad[CSI].push_back(&MBB);
      MaxCSNum = std::max(MaxCSNum, CSI);
    }
  }

  // Get an ordered list of the machine basic blocks for the jump table.
  std::vector<MachineBasicBlock *> LPadList;
  SmallPtrSet<MachineBasicBlock *, 32> InvokeBBs;
  LPadList.reserve(CallSiteNumToLPad.size());

  for (unsigned CSI = 1; CSI <= MaxCSNum; ++CSI) {
    for (auto &LP : CallSiteNumToLPad[CSI]) {
      LPadList.push_back(LP);
      InvokeBBs.insert(LP->pred_begin(), LP->pred_end());
    }
  }

  assert(!LPadList.empty() &&
         "No landing pad destinations for the dispatch jump table!");

  // Create the MBBs for the dispatch code.

  // Shove the dispatch's address into the return slot in the function context.
  MachineBasicBlock *DispatchBB = MF->CreateMachineBasicBlock();
  DispatchBB->setIsEHPad(true);

  MachineBasicBlock *TrapBB = MF->CreateMachineBasicBlock();
  BuildMI(TrapBB, DL, TII->get(VE::TRAP));
  BuildMI(TrapBB, DL, TII->get(VE::NOP));
  DispatchBB->addSuccessor(TrapBB);

  MachineBasicBlock *DispContBB = MF->CreateMachineBasicBlock();
  DispatchBB->addSuccessor(DispContBB);

  // Insert MBBs.
  MF->push_back(DispatchBB);
  MF->push_back(DispContBB);
  MF->push_back(TrapBB);

  // Insert code into the entry block that creates and registers the function
  // context.
  SetupEntryBlockForSjLj(MI, BB, DispatchBB, FI);

  // Create the jump table and associated information
  unsigned JTE = getJumpTableEncoding();
  MachineJumpTableInfo *JTI = MF->getOrCreateJumpTableInfo(JTE);
  unsigned MJTI = JTI->createJumpTableIndex(LPadList);

  const VERegisterInfo &RI = TII->getRegisterInfo();
  // Add a register mask with no preserved registers.  This results in all
  // registers being marked as clobbered.
  BuildMI(DispatchBB, DL, TII->get(VE::NOP))
      .addRegMask(RI.getNoPreservedMask());

  if (isPositionIndependent()) {
    // Force to generate GETGOT, since current implementation doesn't recover
    // GOT register correctly.
    BuildMI(DispatchBB, DL, TII->get(VE::GETGOT), VE::SX15);
  }

  // IReg is used as an index in a memory operand and therefore can't be SP
  unsigned IReg = MRI->createVirtualRegister(&VE::I64RegClass);
  addFrameReference(BuildMI(DispatchBB, DL, TII->get(VE::LDLZXrii), IReg), FI,
                    8);
  if (LPadList.size() < 64) {
    BuildMI(DispatchBB, DL, TII->get(VE::BRCFLir))
        .addImm(VECC::CC_ILE)
        .addImm(LPadList.size())
        .addReg(IReg)
        .addMBB(TrapBB);
  } else {
    assert(LPadList.size() <= 0x7FFFFFFF && "Too large Landing Pad!");
    Register TmpReg = MRI->createVirtualRegister(&VE::I64RegClass);
    BuildMI(DispatchBB, DL, TII->get(VE::LEAzii), TmpReg)
        .addImm(0)
        .addImm(0)
        .addImm(LPadList.size());
    BuildMI(DispatchBB, DL, TII->get(VE::BRCFLrr))
        .addImm(VECC::CC_ILE)
        .addReg(TmpReg)
        .addReg(IReg)
        .addMBB(TrapBB);
  }

  Register BReg = MRI->createVirtualRegister(&VE::I64RegClass);

  Register Tmp1 = MRI->createVirtualRegister(&VE::I64RegClass);
  Register Tmp2 = MRI->createVirtualRegister(&VE::I64RegClass);

  if (isPositionIndependent()) {
    // Create following instructions for local linkage PIC code.
    //     lea %Tmp1, .LJTI0_0@gotoff_lo
    //     and %Tmp2, %Tmp1, (32)0
    //     lea.sl %Tmp3, .LJTI0_0@gotoff_hi(%Tmp2)
    //     adds.l %BReg, %s15, %Tmp3                  ; %s15 is GOT
    // FIXME: use lea.sl %BReg, .LJTI0_0@gotoff_hi(%Tmp2, %s15)
    Register Tmp3 = MRI->createVirtualRegister(&VE::I64RegClass);
    BuildMI(DispContBB, DL, TII->get(VE::LEAzii), Tmp1)
        .addImm(0)
        .addImm(0)
        .addJumpTableIndex(MJTI, VEMCExpr::VK_VE_GOTOFF_LO32);
    BuildMI(DispContBB, DL, TII->get(VE::ANDrm), Tmp2)
        .addReg(Tmp1)
        .addImm(M0(32));
    BuildMI(DispContBB, DL, TII->get(VE::LEASLrii), Tmp3)
        .addReg(Tmp2)
        .addImm(0)
        .addJumpTableIndex(MJTI, VEMCExpr::VK_VE_GOTOFF_HI32);
    BuildMI(DispContBB, DL, TII->get(VE::ADDSLrr), BReg)
        .addReg(VE::SX15)
        .addReg(Tmp3);
  } else {
    // lea     %Tmp1, .LJTI0_0@lo
    // and     %Tmp2, %Tmp1, (32)0
    // lea.sl  %BReg, .LJTI0_0@hi(%Tmp2)
    BuildMI(DispContBB, DL, TII->get(VE::LEAzii), Tmp1)
        .addImm(0)
        .addImm(0)
        .addJumpTableIndex(MJTI, VEMCExpr::VK_VE_LO32);
    BuildMI(DispContBB, DL, TII->get(VE::ANDrm), Tmp2)
        .addReg(Tmp1)
        .addImm(M0(32));
    BuildMI(DispContBB, DL, TII->get(VE::LEASLrii), BReg)
        .addReg(Tmp2)
        .addImm(0)
        .addJumpTableIndex(MJTI, VEMCExpr::VK_VE_HI32);
  }

  switch (JTE) {
  case MachineJumpTableInfo::EK_BlockAddress: {
    // Generate simple block address code for no-PIC model.

    Register TReg = MRI->createVirtualRegister(&VE::I64RegClass);
    Register Tmp1 = MRI->createVirtualRegister(&VE::I64RegClass);
    Register Tmp2 = MRI->createVirtualRegister(&VE::I64RegClass);

    // sll     Tmp1, IReg, 3
    BuildMI(DispContBB, DL, TII->get(VE::SLLri), Tmp1).addReg(IReg).addImm(3);
    // FIXME: combine these add and lds into "lds     TReg, *(BReg, Tmp1)"
    // adds.l  Tmp2, BReg, Tmp1
    BuildMI(DispContBB, DL, TII->get(VE::ADDSLrr), Tmp2)
        .addReg(Tmp1)
        .addReg(BReg);
    // lds     TReg, *(Tmp2)
    BuildMI(DispContBB, DL, TII->get(VE::LDrii), TReg)
        .addReg(Tmp2)
        .addImm(0)
        .addImm(0);

    // jmpq *(TReg)
    BuildMI(DispContBB, DL, TII->get(VE::BCFLari_t)).addReg(TReg).addImm(0);
    break;
  }

  case MachineJumpTableInfo::EK_Custom32: {
    // for the case of PIC, generates these codes

    assert(isPositionIndependent());
    Register OReg = MRI->createVirtualRegister(&VE::I64RegClass);
    Register TReg = MRI->createVirtualRegister(&VE::I64RegClass);

    Register Tmp1 = MRI->createVirtualRegister(&VE::I64RegClass);
    Register Tmp2 = MRI->createVirtualRegister(&VE::I64RegClass);

    // sll     Tmp1, IReg, 2
    BuildMI(DispContBB, DL, TII->get(VE::SLLri), Tmp1).addReg(IReg).addImm(2);
    // FIXME: combine these add and ldl into "ldl.zx   OReg, *(BReg, Tmp1)"
    // add     Tmp2, BReg, Tmp1
    BuildMI(DispContBB, DL, TII->get(VE::ADDSLrr), Tmp2)
        .addReg(Tmp1)
        .addReg(BReg);
    // ldl.zx  OReg, *(Tmp2)
    BuildMI(DispContBB, DL, TII->get(VE::LDLZXrii), OReg)
        .addReg(Tmp2)
        .addImm(0)
        .addImm(0);

    // Create following instructions for local linkage PIC code.
    //     lea %Tmp3, fun@gotoff_lo
    //     and %Tmp4, %Tmp3, (32)0
    //     lea.sl %Tmp5, fun@gotoff_hi(%Tmp4)
    //     adds.l %BReg2, %s15, %Tmp5                  ; %s15 is GOT
    // FIXME: use lea.sl %BReg2, fun@gotoff_hi(%Tmp4, %s15)
    Register Tmp3 = MRI->createVirtualRegister(&VE::I64RegClass);
    Register Tmp4 = MRI->createVirtualRegister(&VE::I64RegClass);
    Register Tmp5 = MRI->createVirtualRegister(&VE::I64RegClass);
    Register BReg2 = MRI->createVirtualRegister(&VE::I64RegClass);
    const char *FunName = DispContBB->getParent()->getName().data();
    BuildMI(DispContBB, DL, TII->get(VE::LEAzii), Tmp3)
        .addImm(0)
        .addImm(0)
        .addExternalSymbol(FunName, VEMCExpr::VK_VE_GOTOFF_LO32);
    BuildMI(DispContBB, DL, TII->get(VE::ANDrm), Tmp4)
        .addReg(Tmp3)
        .addImm(M0(32));
    BuildMI(DispContBB, DL, TII->get(VE::LEASLrii), Tmp5)
        .addReg(Tmp4)
        .addImm(0)
        .addExternalSymbol(FunName, VEMCExpr::VK_VE_GOTOFF_HI32);
    BuildMI(DispContBB, DL, TII->get(VE::ADDSLrr), BReg2)
        .addReg(VE::SX15)
        .addReg(Tmp5);

    // adds.l  TReg, BReg2, OReg
    BuildMI(DispContBB, DL, TII->get(VE::ADDSLrr), TReg)
        .addReg(OReg)
        .addReg(BReg2);
    // jmpq *(TReg)
    BuildMI(DispContBB, DL, TII->get(VE::BCFLari_t)).addReg(TReg).addImm(0);
    break;
  }
  default:
    llvm_unreachable("Unexpected jump table encoding");
  }

  // Add the jump table entries as successors to the MBB.
  SmallPtrSet<MachineBasicBlock *, 8> SeenMBBs;
  for (auto &LP : LPadList)
    if (SeenMBBs.insert(LP).second)
      DispContBB->addSuccessor(LP);

  // N.B. the order the invoke BBs are processed in doesn't matter here.
  SmallVector<MachineBasicBlock *, 64> MBBLPads;
  const MCPhysReg *SavedRegs = MF->getRegInfo().getCalleeSavedRegs();
  for (MachineBasicBlock *MBB : InvokeBBs) {
    // Remove the landing pad successor from the invoke block and replace it
    // with the new dispatch block.
    // Keep a copy of Successors since it's modified inside the loop.
    SmallVector<MachineBasicBlock *, 8> Successors(MBB->succ_rbegin(),
                                                   MBB->succ_rend());
    // FIXME: Avoid quadratic complexity.
    for (auto MBBS : Successors) {
      if (MBBS->isEHPad()) {
        MBB->removeSuccessor(MBBS);
        MBBLPads.push_back(MBBS);
      }
    }

    MBB->addSuccessor(DispatchBB);

    // Find the invoke call and mark all of the callee-saved registers as
    // 'implicit defined' so that they're spilled.  This prevents code from
    // moving instructions to before the EH block, where they will never be
    // executed.
    for (auto &II : reverse(*MBB)) {
      if (!II.isCall())
        continue;

      DenseMap<Register, bool> DefRegs;
      for (auto &MOp : II.operands())
        if (MOp.isReg())
          DefRegs[MOp.getReg()] = true;

      MachineInstrBuilder MIB(*MF, &II);
      for (unsigned RI = 0; SavedRegs[RI]; ++RI) {
        Register Reg = SavedRegs[RI];
        if (!DefRegs[Reg])
          MIB.addReg(Reg, RegState::ImplicitDefine | RegState::Dead);
      }

      break;
    }
  }

  // Mark all former landing pads as non-landing pads.  The dispatch is the only
  // landing pad now.
  for (auto &LP : MBBLPads)
    LP->setIsEHPad(false);

  // The instruction is gone now.
  MI.eraseFromParent();
  return BB;
}

MachineBasicBlock *
VETargetLowering::EmitInstrWithCustomInserter(MachineInstr &MI,
                                              MachineBasicBlock *BB) const {
  switch (MI.getOpcode()) {
  default:
    llvm_unreachable("Unknown Custom Instruction!");
  case VE::EH_SjLj_Setup_Dispatch:
    return EmitSjLjDispatchBlock(MI, BB);
  case VE::EH_SjLj_LongJmp:
    return emitEHSjLjLongJmp(MI, BB);
  case VE::EH_SjLj_SetJmp:
    return emitEHSjLjSetJmp(MI, BB);
  }
}

static bool isSimm7(SDValue V) {
  EVT VT = V.getValueType();
  if (VT.isVector())
    return false;

  if (VT.isInteger()) {
    if (ConstantSDNode *C = dyn_cast<ConstantSDNode>(V))
      return isInt<7>(C->getSExtValue());
  } else if (VT.isFloatingPoint()) {
    if (ConstantFPSDNode *C = dyn_cast<ConstantFPSDNode>(V)) {
      const APInt &Imm = C->getValueAPF().bitcastToAPInt();
      uint64_t Val = Imm.getSExtValue();
      if (Imm.getBitWidth() == 32)
        Val <<= 32; // Immediate value of float place at higher bits on VE.
      return isInt<7>(Val);
    }
  }
  return false;
}

/// getImmVal - get immediate representation of integer value
inline static uint64_t getImmVal(const ConstantSDNode *N) {
  return N->getSExtValue();
}

/// getFpImmVal - get immediate representation of floating point value
inline static uint64_t getFpImmVal(const ConstantFPSDNode *N) {
  const APInt &Imm = N->getValueAPF().bitcastToAPInt();
  uint64_t Val = Imm.getZExtValue();
  if (Imm.getBitWidth() == 32) {
    // Immediate value of float place places at higher bits on VE.
    Val <<= 32;
  }
  return Val;
}

static bool isMImm(SDValue V) {
  EVT VT = V.getValueType();
  if (VT.isVector())
    return false;

  if (VT.isInteger()) {
    if (ConstantSDNode *C = dyn_cast<ConstantSDNode>(V))
      return isMImmVal(getImmVal(C));
  } else if (VT.isFloatingPoint()) {
    if (ConstantFPSDNode *C = dyn_cast<ConstantFPSDNode>(V)) {
      if (VT == MVT::f32) {
        // Float value places at higher bits, so ignore lower 32 bits.
        return isMImm32Val(getFpImmVal(C) >> 32);
      }
      return isMImmVal(getFpImmVal(C));
    }
  }
  return false;
}

static unsigned decideComp(EVT SrcVT, bool Signed) {
  if (SrcVT.isFloatingPoint()) {
    if (SrcVT == MVT::f128)
      return VEISD::CMPQ;
    return VEISD::CMPF;
  }
  return Signed ? VEISD::CMPI : VEISD::CMPU;
}

static EVT decideCompType(EVT SrcVT) {
  if (SrcVT == MVT::f128)
    return MVT::f64;
  return SrcVT;
}

static bool safeWithoutComp(EVT SrcVT, bool Signed) {
  if (SrcVT.isFloatingPoint()) {
    // For the case of floating point setcc, only unordered comparison
    // or general comparison with -enable-no-nans-fp-math option reach
    // here, so it is safe even if values are NaN.  Only f128 doesn't
    // safe since VE uses f64 result of f128 comparison.
    return SrcVT != MVT::f128;
  }
  // For the case of integer setcc, only signed 64 bits comparison is safe.
  // For unsigned, "CMPU 0x80000000, 0" has to be greater than 0, but it becomes
  // less than 0 witout CMPU.  For 32 bits, other half of 32 bits are
  // uncoditional, so it is not safe too without CMPI..
  return (Signed && SrcVT == MVT::i64) ? true : false;
}

static SDValue generateComparison(EVT VT, SDValue LHS, SDValue RHS,
                                  bool Commutable, bool Signed, const SDLoc &DL,
                                  SelectionDAG &DAG) {
  if (Commutable) {
    // VE comparison can holds simm7 at lhs and mimm at rhs.  Swap operands
    // if it matches.
    if (!isSimm7(LHS) && !isMImm(RHS) && (isSimm7(RHS) || isMImm(LHS)))
      std::swap(LHS, RHS);
    assert(!(isNullConstant(LHS) || isNullFPConstant(LHS)) && "lhs is 0!");
  }

  // Compare values.  If RHS is 0 and it is safe to calculate without
  // comparison, we don't generate an instruction for comparison.
  EVT CompVT = decideCompType(VT);
  if (CompVT == VT && safeWithoutComp(VT, Signed) &&
      (isNullConstant(RHS) || isNullFPConstant(RHS))) {
    return LHS;
  }
  return DAG.getNode(decideComp(VT, Signed), DL, CompVT, LHS, RHS);
}

/// This function is called when we have proved that a SETCC node can be
/// replaced by subtraction (and other supporting instructions).
SDValue VETargetLowering::generateEquivalentSub(SDNode *N, bool Signed,
                                                bool Complement, bool Swap,
                                                SelectionDAG &DAG) const {
  assert(N->getOpcode() == ISD::SETCC && "ISD::SETCC Expected.");

  SDLoc DL(N);
  auto Op0 = N->getOperand(0);
  auto Op1 = N->getOperand(1);
  unsigned Size = Op0.getValueSizeInBits();
  EVT SrcVT = Op0.getValueType();
  EVT VT = N->getValueType(0);
  assert(VT == MVT::i32 && "i32 is expected as a result of ISD::SETCC.");

  // Swap if needed. Depends on the condition code.
  if (Swap)
    std::swap(Op0, Op1);

  // Compare values.  If Op1 is 0 and it is safe to calculate without
  // comparison, we don't generate compare instruction.
  EVT CompVT = decideCompType(SrcVT);
  SDValue CompNode =
      generateComparison(SrcVT, Op0, Op1, false, Signed, DL, DAG);
  if (CompVT != MVT::i64) {
    SDValue Undef = SDValue(
        DAG.getMachineNode(TargetOpcode::IMPLICIT_DEF, DL, MVT::i64), 0);
    if (SrcVT == MVT::i32) {
      SDValue Sub_i32 = DAG.getTargetConstant(VE::sub_i32, DL, MVT::i32);
      CompNode = SDValue(DAG.getMachineNode(TargetOpcode::INSERT_SUBREG, DL,
                                            MVT::i64, Undef, CompNode, Sub_i32),
                         0);
    } else if (SrcVT == MVT::f32) {
      SDValue Sub_f32 = DAG.getTargetConstant(VE::sub_f32, DL, MVT::i32);
      CompNode = SDValue(DAG.getMachineNode(TargetOpcode::INSERT_SUBREG, DL,
                                            MVT::i64, Undef, CompNode, Sub_f32),
                         0);
      Size = 64; // VE places f32 at higher bits in 64 bit representation.
    } else if (SrcVT == MVT::f64) {
      const TargetRegisterClass *RC = getRegClassFor(MVT::i64);
      CompNode =
          SDValue(DAG.getMachineNode(
                      TargetOpcode::COPY_TO_REGCLASS, DL, MVT::i64, CompNode,
                      DAG.getTargetConstant(RC->getID(), DL, MVT::i32)),
                  0);
    } else
      llvm_unreachable("Unknown ValueType!");
  }

  // Move the sign bit to the least significant position and zero out the rest.
  // Now the least significant bit carries the result of original comparison.
  auto Shifted = DAG.getNode(ISD::SRL, DL, MVT::i64, CompNode,
                             DAG.getConstant(Size - 1, DL, MVT::i32));
  auto Final = Shifted;

  // Complement the result if needed. Based on the condition code.
  if (Complement)
    Final = DAG.getNode(ISD::XOR, DL, MVT::i64, Shifted,
                        DAG.getConstant(1, DL, MVT::i64));

  // Final is either 0 or 1, so it is safe for EXTRACT_SUBREG
  SDValue Sub_i32 = DAG.getTargetConstant(VE::sub_i32, DL, MVT::i32);
  Final = SDValue(
      DAG.getMachineNode(TargetOpcode::EXTRACT_SUBREG, DL, VT, Final, Sub_i32),
      0);

  return Final;
}

/// This function is called when we have proved that a SETCC node can be
/// replaced by EQV/XOR+CMOV instead of CMP+LEA+CMOV
static SDValue generateEquivalentBitOp(SDNode *N, unsigned Cmp,
                                       SelectionDAG &DAG) {
  assert(N->getOpcode() == ISD::SETCC && "ISD::SETCC Expected.");

  SDLoc DL(N);
  auto Op0 = N->getOperand(0);
  auto Op1 = N->getOperand(1);
  EVT SrcVT = Op0.getValueType();
  EVT VT = N->getValueType(0);
  assert(SrcVT.isScalarInteger() &&
         "Scalar integer is expected as inputs of ISD::SETCC.");
  assert(VT == MVT::i32 && "i32 is expected as a result of ISD::SETCC.");

  // Compare or equiv integers.
  auto CmpNode = DAG.getNode(Cmp, DL, SrcVT, Op0, Op1);

  // Adjust register size for CMOV's base register.
  //   CMOV cmp, 1, base (=cmp)
  auto Base = CmpNode;
  if (VT != SrcVT) {
    // Cmp is equal to 0 iff it is used as base register, so safe to use
    // INSERT_SUBREG/EXTRACT_SUBRAG.
    SDValue Sub_i32 = DAG.getTargetConstant(VE::sub_i32, DL, MVT::i32);
    Base = SDValue(
        DAG.getMachineNode(TargetOpcode::EXTRACT_SUBREG, DL, VT, Base, Sub_i32),
        0);
  }
  // Set 1 iff comparison result is not equal to 0.
  auto Cmoved =
      DAG.getNode(VEISD::CMOV, DL, VT, CmpNode, DAG.getConstant(1, DL, VT),
                  Base, DAG.getConstant(VECC::CC_INE, DL, MVT::i32));

  return Cmoved;
}

/// This function is called when we have proved that a SETCC node can be
/// replaced by CMP+CMOV or CMP+LEA+CMOV.
SDValue VETargetLowering::generateEquivalentCmp(SDNode *N, bool UseCompAsBase,
                                                SelectionDAG &DAG) const {
  assert(N->getOpcode() == ISD::SETCC && "ISD::SETCC Expected.");

  SDLoc DL(N);
  auto Op0 = N->getOperand(0);
  auto Op1 = N->getOperand(1);
  EVT SrcVT = Op0.getValueType();
  EVT VT = N->getValueType(0);
  assert(VT == MVT::i32 && "i32 is expected as a result of ISD::SETCC.");

  // VE instruction can holds simm7 at lhs and mimm at rhs.  Swap operands
  // if it improve instructions.  Both CMP operation is safe to sawp
  // for SETEQ/SETNE.
  if (!isSimm7(Op0) && !isMImm(Op1) && (isSimm7(Op1) || isMImm(Op0)))
    std::swap(Op0, Op1);

  // Compare or equiv integers.
  unsigned Comp = decideComp(SrcVT, true);
  EVT CompVT = decideCompType(SrcVT);
  auto CompNode = DAG.getNode(Comp, DL, CompVT, Op0, Op1);

  // Adjust register size for CMOV's base register.
  //   CMOV cmp, 1, base (=cmp)
  auto Base = CompNode;
  if (UseCompAsBase) {
    // Cmp is equal to 1 iff it is used as base register, so safe to use
    // INSERT_SUBREG/EXTRACT_SUBRAG.
    SDValue Sub_i32 = DAG.getTargetConstant(VE::sub_f32, DL, MVT::i32);
    if (CompVT != MVT::i32) {
      if (CompVT == MVT::i64) {
        Base = SDValue(DAG.getMachineNode(TargetOpcode::EXTRACT_SUBREG, DL, VT,
                                          Base, Sub_i32),
                       0);
      } else if (CompVT == MVT::f32) {
        SDValue Sub_f32 = DAG.getTargetConstant(VE::sub_f32, DL, MVT::i32);
        SDValue Undef = SDValue(
            DAG.getMachineNode(TargetOpcode::IMPLICIT_DEF, DL, MVT::i64), 0);
        Base = SDValue(DAG.getMachineNode(TargetOpcode::INSERT_SUBREG, DL,
                                          MVT::i64, Undef, Base, Sub_f32),
                       0);
        Base = SDValue(DAG.getMachineNode(TargetOpcode::EXTRACT_SUBREG, DL, VT,
                                          Base, Sub_i32),
                       0);
      } else if (CompVT == MVT::f64) {
        const TargetRegisterClass *RC = getRegClassFor(MVT::i64);
        Base = SDValue(DAG.getMachineNode(
                           TargetOpcode::COPY_TO_REGCLASS, DL, MVT::i64, Base,
                           DAG.getTargetConstant(RC->getID(), DL, MVT::i32)),
                       0);
        Base = SDValue(DAG.getMachineNode(TargetOpcode::EXTRACT_SUBREG, DL, VT,
                                          Base, Sub_i32),
                       0);
      } else
        llvm_unreachable("Unknown ValueType!");
    }
  } else {
    Base = DAG.getConstant(0, DL, CompVT);
  }
  // Set 1 iff comparison result is not equal to 0.
  auto Cmoved =
      DAG.getNode(VEISD::CMOV, DL, VT, CompNode, DAG.getConstant(1, DL, VT),
                  Base, DAG.getConstant(VECC::CC_INE, DL, MVT::i32));

  return Cmoved;
}

/// This function is called when we have proved that a SETCC node can be
/// replaced by leading-zero (and other supporting instructions).
SDValue VETargetLowering::generateEquivalentLdz(SDNode *N, bool Complement,
                                                SelectionDAG &DAG) const {
  assert(N->getOpcode() == ISD::SETCC && "ISD::SETCC Expected.");

  SDLoc DL(N);
  auto Op0 = N->getOperand(0);
  auto Op1 = N->getOperand(1);
  EVT SrcVT = Op0.getValueType();
  EVT VT = N->getValueType(0);
  assert(VT == MVT::i32 && "i32 is expected as a result of ISD::SETCC.");

  // Compare values.  If Op1 is 0 and it is safe to calculate without
  // comparison, we don't generate compare instruction.
  EVT CompVT = decideCompType(SrcVT);
  SDValue CompNode = generateComparison(SrcVT, Op0, Op1, true, true, DL, DAG);
  if (CompVT != MVT::i64) {
    SDValue Undef = SDValue(
        DAG.getMachineNode(TargetOpcode::IMPLICIT_DEF, DL, MVT::i64), 0);
    if (SrcVT == MVT::i32) {
      SDValue Sub_i32 = DAG.getTargetConstant(VE::sub_i32, DL, MVT::i32);
      CompNode = SDValue(DAG.getMachineNode(TargetOpcode::INSERT_SUBREG, DL,
                                            MVT::i64, Undef, CompNode, Sub_i32),
                         0);
    } else if (SrcVT == MVT::f32) {
      SDValue Sub_f32 = DAG.getTargetConstant(VE::sub_f32, DL, MVT::i32);
      CompNode = SDValue(DAG.getMachineNode(TargetOpcode::INSERT_SUBREG, DL,
                                            MVT::i64, Undef, CompNode, Sub_f32),
                         0);
    } else if (SrcVT == MVT::f64) {
      const TargetRegisterClass *RC = getRegClassFor(MVT::i64);
      CompNode =
          SDValue(DAG.getMachineNode(
                      TargetOpcode::COPY_TO_REGCLASS, DL, MVT::i64, CompNode,
                      DAG.getTargetConstant(RC->getID(), DL, MVT::i32)),
                  0);
    } else
      llvm_unreachable("Unknown ValueType!");
  }

  // Count leading 0 in 64 bit register.
  auto LdzNode = DAG.getNode(ISD::CTLZ, DL, MVT::i64, CompNode);

  // If both are equal, ldz returns 64.  Otherwise, less than 64.
  // Move the 6th bit to the least significant position and zero out the rest.
  // Now the least significant bit carries the result of original comparison.
  unsigned Size = CompNode.getValueSizeInBits();
  auto Shifted = DAG.getNode(ISD::SRL, DL, MVT::i64, LdzNode,
                             DAG.getConstant(Log2_32(Size), DL, MVT::i32));
  auto Final = Shifted;

  // Complement the result if needed. Based on the condition code.
  if (Complement)
    Final = DAG.getNode(ISD::XOR, DL, MVT::i64, Shifted,
                        DAG.getConstant(1, DL, MVT::i64));

  // Final is either 0 or 1, so it is safe for EXTRACT_SUBREG
  SDValue Sub_i32 = DAG.getTargetConstant(VE::sub_i32, DL, MVT::i32);
  Final = SDValue(
      DAG.getMachineNode(TargetOpcode::EXTRACT_SUBREG, DL, VT, Final, Sub_i32),
      0);

  return Final;
}

// Perform optiization on SetCC similar to PowerPC.
SDValue VETargetLowering::optimizeSetCC(SDNode *N, DAGCombinerInfo &DCI) const {
  assert(N->getOpcode() == ISD::SETCC && "ISD::SETCC Expected.");
  EVT SrcVT = N->getOperand(0).getValueType();

  // FIXME: optimize floating point SetCC.
  if (SrcVT.isFloatingPoint())
    return SDValue();

  // We prefer to do this when all types are legal.
  if (!DCI.isAfterLegalizeDAG())
    return SDValue();

  // For setcc, we generally create following instructions.
  //   CMP       %cmp, %a, %b
  //   LEA       %res, 0
  //   CMOV.cond %res, 1, %cmp
  //
  // However, CMOV is slower than ALU instructions and a LEA result may hold a
  // register for a while if LEA instruction moved around.  It happens often
  // more than what I expected.  So, we are going to optimize these instructions
  // using bit calculations like below.
  //
  // For SETEQ/SETNE, we use LDZ to count the number of bits holding 0.
  //   SETEQ
  //   CMP %t1, %a, %b
  //   LDZ %t2, %t1     ; 64 iff %t1 is equal to 0
  //   SRL %res, %t2, 6 ; 64 becomes 1 now
  //
  //   SETNE
  //   CMP %t1, %a, %b
  //   CMPU %t2, 0, %t1
  //   SRL %res, %t2, 63/31
  //
  // For other comparison, we use sign bit to generate result value.
  //   SETLT                   SETLE
  //   CMP %t1, %a, %b         CMP %t1, %b, %a
  //   SRL %res, %t1, 63/31    SRL %t2, %t1, 63/31
  //                           XOR %res, %t2, 1
  //
  // We can use similar instructions for floating point also iff comparison
  // is unordered.  VE's comparison may return qNaN which MSB is on.
  // FIXME: support floating point.

  ISD::CondCode CC = cast<CondCodeSDNode>(N->getOperand(2))->get();
  SelectionDAG &DAG = DCI.DAG;
  switch (CC) {
  default:
    break;
  case ISD::SETEQ:
#if 1
    // a == b -> (LDZ (CMP a, b)) >> 6
    //   3 insns are equal to CMP+LEA+CMOV but faster.
    return generateEquivalentLdz(N, false, DAG);
#else
              // a == b -> cmov (a EQV b), 1, (a EQV b), SETNE iff a/b are i64
              //           cmov (a CMP b), 1, 0, SETEQ otherwise
              //   2 insns which is less than CMP+LEA+CMOV
              if (SrcVT == MVT::i64)
                return generateEquivalentBitOp(N, VEISD::EQV, DAG);
                // FIXME: generate CMP+LEA+CMOV here.
                // return generateEquivalentCmp(N, false, DAG);
#endif
    break;
  case ISD::SETNE:
    // Generate code for "setugt a, 0" instead of "setne a, 0" since it is
    // faster on VE.
    if (isNullConstant(N->getOperand(1)))
      return generateEquivalentSub(N, false, false, true, DAG);
    LLVM_FALLTHROUGH;
  case ISD::SETUNE: {
#if 1
    // Generate code for "setugt (cmp a, b), 0" instead of "setne a, b"
    // since it is faster on VE.
    SDLoc DL(N);
    EVT CompVT = decideCompType(SrcVT);
    SDValue CompNode = generateComparison(
        SrcVT, N->getOperand(0), N->getOperand(1), true, true, DL, DAG);
#if 0
    return DAG.getNode(ISD::SETCC, DL, MVT::i32, CompNode,
                       DAG.getConstant(0, DL, CompVT),
                       DAG.getCondCode(ISD::SETUGT));
#else
#if 1
    SDValue SetCC = DAG.getNode(ISD::SETCC, DL, MVT::i32, CompNode,
                                DAG.getConstant(0, DL, CompVT),
                                DAG.getCondCode(ISD::SETUGT));
    return generateEquivalentSub(SetCC.getNode(), false, false, true, DAG);
#if 0
    CompNode = generateComparison(CompVT, DAG.getConstant(0, DL, CompVT),
                                  CompNode, false, false, DL, DAG);
    return generateEquivalentSub(CompNode.getNode(), false, false, true, DAG);
#endif
#endif
#endif
#else
#if 1
              // a != b -> (XOR (LDZ (CMP a, b)) >> 6, 1)
              //   4 insns are more than CMP+LEA+CMOV but faster.
              return generateEquivalentLdz(N, true, DAG);
#else
              // a != b -> cmov (a XOR b), 1, (a XOR b), SETNE iff a/b are i64
              //           cmov (a CMP b), 1, (a CMP b), SETNE otherwise
              //   2 insns which is less than CMP+LEA+CMOV
              if (SrcVT == MVT::i64)
                return generateEquivalentBitOp(N, VEISD::XOR, DAG);
              return generateEquivalentCmp(N, true, DAG);
#endif
#endif
  }
  case ISD::SETLT:
    // a < b -> (CMP a, b) >> size(a)-1
    //   2 insns are less than CMP+LEA+CMOV
    return generateEquivalentSub(N, true, false, false, DAG);
  case ISD::SETGT:
    // a > b -> (CMP b, a) >> size(a)-1
    //   2 insns are less than CMP+LEA+CMOV
    return generateEquivalentSub(N, true, false, true, DAG);
  case ISD::SETLE:
    // a <= b -> (XOR (CMP b, a) >> size(a)-1, 1)
    //   3 insns are equal to CMP+LEA+CMOV but faster.
    return generateEquivalentSub(N, true, true, true, DAG);
  case ISD::SETGE:
    // a >= b -> (XOR (CMP a, b) >> size(a)-1, 1)
    //   3 insns are equal to CMP+LEA+CMOV but faster.
    return generateEquivalentSub(N, true, true, false, DAG);
  case ISD::SETULT:
    // a < b -> (CMP a, b) >> size(a)-1
    return generateEquivalentSub(N, false, false, false, DAG);
  case ISD::SETULE:
    // a <= b -> (XOR (CMP b, a) >> size(a)-1, 1)
    return generateEquivalentSub(N, false, true, true, DAG);
  case ISD::SETUGT:
    // a > b -> (CMP b, a) >> size(a)-1
    return generateEquivalentSub(N, false, false, true, DAG);
  case ISD::SETUGE:
    // a >= b -> (XOR (CMP a, b) >> size(a)-1, 1)
    return generateEquivalentSub(N, false, true, false, DAG);
  }
  return SDValue();
}

SDValue VETargetLowering::combineExtBoolTrunc(SDNode *N,
                                              DAGCombinerInfo &DCI) const {
  SelectionDAG &DAG = DCI.DAG;
  SDLoc DL(N);
  EVT VT = N->getValueType(0);
  EVT SrcVT = N->getOperand(0).getValueType();

  // We prefer to do this when all types are legal.
  if (!DCI.isAfterLegalizeDAG())
    return SDValue();

  if (N->getOperand(0).getOpcode() == ISD::SETCC && SrcVT == MVT::i32 &&
      VT == MVT::i64) {
    // SETCC returns 0 or 1, so all ext is safe to replae to INSERT_SUBREG.
    // But peform this modification after setcc is leagalized to i32.
    SDValue Undef =
        SDValue(DAG.getMachineNode(TargetOpcode::IMPLICIT_DEF, DL, VT), 0);
    SDValue Sub_i32 = DAG.getTargetConstant(VE::sub_i32, DL, MVT::i32);
    return SDValue(DAG.getMachineNode(TargetOpcode::INSERT_SUBREG, DL, MVT::i64,
                                      Undef, N->getOperand(0), Sub_i32),
                   0);
  }
  return SDValue();
}

static bool isI32Insn(const SDNode *User, const SDNode *N) {
  switch (User->getOpcode()) {
  default:
    return false;
  case ISD::ADD:
  case ISD::SUB:
  case ISD::MUL:
  case ISD::SDIV:
  case ISD::UDIV:
  case ISD::SETCC:
  case ISD::SMIN:
  case ISD::SMAX:
  case ISD::SHL:
  case ISD::SRA:
  case ISD::BSWAP:
  case ISD::SINT_TO_FP:
  case ISD::UINT_TO_FP:
  case ISD::BR_CC:
  case ISD::BITCAST:
  case ISD::ATOMIC_CMP_SWAP:
  case ISD::ATOMIC_SWAP:
  case VEISD::CMPU:
  case VEISD::CMPI:
  case VEISD::VEC_BROADCAST:
    return true;
  case ISD::SRL:
    if (N->getOperand(0).getOpcode() != ISD::SRL)
      return true;
    // (srl (trunc (srl ...))) may be optimized by combining srl, so
    // doesn't optimize trunc now.
    return false;
  case ISD::SELECT_CC:
    if (User->getOperand(2).getNode() != N &&
        User->getOperand(3).getNode() != N)
      return true;
    LLVM_FALLTHROUGH;
  case ISD::AND:
  case ISD::OR:
  case ISD::XOR:
  case ISD::SELECT:
  case ISD::CopyToReg:
    // Check all use of selections, bit operations, and copies.  If all of them
    // are safe, optimize truncate to extract_subreg.
    for (SDNode::use_iterator UI = User->use_begin(), UE = User->use_end();
         UI != UE; ++UI) {
      switch ((*UI)->getOpcode()) {
      default:
        // If the use is an instruction which treats the source operand as i32,
        // it is safe to avoid truncate here.
        if (isI32Insn(*UI, N))
          continue;
        break;
      case ISD::ANY_EXTEND:
      case ISD::SIGN_EXTEND:
      case ISD::ZERO_EXTEND: {
        // Special optimizations to the combination of ext and trunc.
        // (ext ... (select ... (trunc ...))) is safe to avoid truncate here
        // since this truncate instruction clears higher 32 bits which is filled
        // by one of ext instructions later.
        assert(N->getValueType(0) == MVT::i32 &&
               "find truncate to not i32 integer");
        if (User->getOpcode() == ISD::SELECT_CC ||
            User->getOpcode() == ISD::SELECT)
          continue;
        break;
      }
      }
      return false;
    }
    return true;
  }
}

// Optimize TRUNCATE in DAG combining.  Optimizing it in CUSTOM lower is
// sometime too early.  Optimizing it in DAG pattern matching in VEInstrInfo.td
// is sometime too late.  So, doing it at here.
SDValue VETargetLowering::combineTRUNCATE(SDNode *N,
                                          DAGCombinerInfo &DCI) const {
  assert(N->getOpcode() == ISD::TRUNCATE &&
         "Should be called with a TRUNCATE node");

  SelectionDAG &DAG = DCI.DAG;
  SDLoc DL(N);
  EVT VT = N->getValueType(0);

  // We prefer to do this when all types are legal.
  if (!DCI.isAfterLegalizeDAG())
    return SDValue();

  // Skip combine TRUNCATE atm if the operand of TRUNCATE might be a constant.
  if (N->getOperand(0)->getOpcode() == ISD::SELECT_CC &&
      isa<ConstantSDNode>(N->getOperand(0)->getOperand(0)) &&
      isa<ConstantSDNode>(N->getOperand(0)->getOperand(1)))
    return SDValue();

  // Check all use of this TRUNCATE.
  for (SDNode::use_iterator UI = N->use_begin(), UE = N->use_end(); UI != UE;
       ++UI) {
    SDNode *User = *UI;

    // Make sure that we're not going to replace TRUNCATE for non i32
    // instructions.
    //
    // FIXME: Although we could sometimes handle this, and it does occur in
    // practice that one of the condition inputs to the select is also one of
    // the outputs, we currently can't deal with this.
    if (isI32Insn(User, N))
      continue;

    return SDValue();
  }

  SDValue SubI32 = DAG.getTargetConstant(VE::sub_i32, DL, MVT::i32);
  return SDValue(DAG.getMachineNode(TargetOpcode::EXTRACT_SUBREG, DL, VT,
                                    N->getOperand(0), SubI32),
                 0);
}

SDValue VETargetLowering::combineSetCC(SDNode *N, DAGCombinerInfo &DCI) const {
  assert(N->getOpcode() == ISD::SETCC && "Should be called with a SETCC node");

#if 0
  ISD::CondCode CC = cast<CondCodeSDNode>(N->getOperand(2))->get();
  if (CC == ISD::SETNE || CC == ISD::SETEQ) {
    SDValue LHS = N->getOperand(0);
    SDValue RHS = N->getOperand(1);

    // If there is a '0 - y' pattern, canonicalize the pattern to the RHS.
    if (LHS.getOpcode() == ISD::SUB && isNullConstant(LHS.getOperand(0)) &&
        LHS.hasOneUse())
      std::swap(LHS, RHS);

    // x == 0-y --> x+y == 0
    // x != 0-y --> x+y != 0
    if (RHS.getOpcode() == ISD::SUB && isNullConstant(RHS.getOperand(0)) &&
        RHS.hasOneUse()) {
      SDLoc DL(N);
      SelectionDAG &DAG = DCI.DAG;
      EVT VT = N->getValueType(0);
      EVT OpVT = LHS.getValueType();
      SDValue Add = DAG.getNode(ISD::ADD, DL, OpVT, LHS, RHS.getOperand(1));
      return DAG.getSetCC(DL, VT, Add, DAG.getConstant(0, DL, OpVT), CC);
    }
  }
#endif

  EVT VT = N->getValueType(0);
  if (VT != MVT::i32)
    return SDValue();

  // Check all use of this SETCC.
  for (SDNode::use_iterator UI = N->use_begin(), UE = N->use_end(); UI != UE;
       ++UI) {
    SDNode *User = *UI;

    // Make sure that we're not going to promote SETCC for SELECT or BRCOND
    // or BR_CC.
    // FIXME: Although we could sometimes handle this, and it does occur in
    // practice that one of the condition inputs to the select is also one of
    // the outputs, we currently can't deal with this.
    if (User->getOpcode() == ISD::SELECT || User->getOpcode() == ISD::BRCOND) {
      if (User->getOperand(0).getNode() == N)
        return SDValue();
    } else if (User->getOpcode() == ISD::BR_CC) {
      if (User->getOperand(1).getNode() == N ||
          User->getOperand(2).getNode() == N)
        return SDValue();
    } else if (User->getOpcode() == ISD::AND) {
      // Atomic expansion may construct instructions like below.
      //   %cond = SETCC
      //   %and = AND %cond, 1
      //   BR_CC %and
      //
      // This patterns will be combined into a single BR_CC later.
      // So, we defer optimization on SETCC for a while.
      // FIXME: create combine for (AND (SETCC ), 1).
      if (User->getOperand(0).getNode() == N &&
          User->getOperand(1).getValueType().isScalarInteger() &&
          isOneConstant(User->getOperand(1)))
        return SDValue();
    }
  }

  return optimizeSetCC(N, DCI);
}

SDValue VETargetLowering::combineSelectCC(SDNode *N,
                                          DAGCombinerInfo &DCI) const {
  assert(N->getOpcode() == ISD::SELECT_CC &&
         "Should be called with a SELECT_CC node");
  ISD::CondCode CC = cast<CondCodeSDNode>(N->getOperand(4))->get();
  SDValue LHS = N->getOperand(0);
  SDValue RHS = N->getOperand(1);
  SDValue True = N->getOperand(2);
  SDValue False = N->getOperand(3);
  bool Modify = false;

  EVT VT = N->getValueType(0);
  if (VT.isVector())
    return SDValue();

  if (isMImm(True)) {
    // Doesn't swap True and False values.
  } else if (isMImm(False)) {
    // Swap True and False values.  Inverse CC also.
    std::swap(True, False);
    CC = getSetCCInverse(CC, LHS.getValueType());
    Modify = true;
  }

  if (Modify) {
    SDLoc DL(N);
    SelectionDAG &DAG = DCI.DAG;
    return DAG.getSelectCC(SDLoc(N), LHS, RHS, True, False, CC);
  }

  return SDValue();
}

SDValue VETargetLowering::PerformDAGCombine(SDNode *N,
                                            DAGCombinerInfo &DCI) const {
  SDLoc dl(N);
  switch (N->getOpcode()) {
  default:
    break;
  case ISD::ANY_EXTEND:
  case ISD::SIGN_EXTEND:
  case ISD::ZERO_EXTEND:
    return combineExtBoolTrunc(N, DCI);
  case ISD::SETCC:
    return combineSetCC(N, DCI);
  case ISD::SELECT_CC:
    return combineSelectCC(N, DCI);
  case ISD::TRUNCATE:
    return combineTRUNCATE(N, DCI);
  }

  return SDValue();
}

bool VETargetLowering::isTypeDesirableForOp(unsigned Opc, EVT VT) const {
  if (!isTypeLegal(VT))
    return false;

  // There are no i32 bitreverse/ctpop/and/or/xor instructions.
  if (VT == MVT::i32) {
    switch (Opc) {
    default:
      break;
    case ISD::BITREVERSE:
    case ISD::CTPOP:
    case ISD::AND:
    case ISD::OR:
    case ISD::XOR:
      return false;
    }
  }

  // There are no i8/i16 instructions.
  if (VT == MVT::i8 || VT == MVT::i16)
    return false;

  // Any legal type not explicitly accounted for above here is desirable.
  return true;
}

//===----------------------------------------------------------------------===//
// VE Inline Assembly Support
//===----------------------------------------------------------------------===//

VETargetLowering::ConstraintType
VETargetLowering::getConstraintType(StringRef Constraint) const {
  if (Constraint.size() == 1) {
    switch (Constraint[0]) {
    default:
      break;
    case 'v': // vector registers
    case 'f':
    case 'e':
      return C_RegisterClass;
    case 'I': // SIMM13
      return C_Other;
    }
  }

  return TargetLowering::getConstraintType(Constraint);
}

TargetLowering::ConstraintWeight
VETargetLowering::getSingleConstraintMatchWeight(AsmOperandInfo &info,
                                                 const char *constraint) const {
  ConstraintWeight weight = CW_Invalid;
  Value *CallOperandVal = info.CallOperandVal;
  // If we don't have a value, we can't do a match,
  // but allow it at the lowest weight.
  if (!CallOperandVal)
    return CW_Default;

  // Look at the constraint type.
  switch (*constraint) {
  default:
    weight = TargetLowering::getSingleConstraintMatchWeight(info, constraint);
    break;
  case 'I': // SIMM13
    if (ConstantInt *C = dyn_cast<ConstantInt>(info.CallOperandVal)) {
      if (isInt<13>(C->getSExtValue()))
        weight = CW_Constant;
    }
    break;
  }
  return weight;
}

/// LowerAsmOperandForConstraint - Lower the specified operand into the Ops
/// vector.  If it is invalid, don't add anything to Ops.
void VETargetLowering::LowerAsmOperandForConstraint(SDValue Op,
                                                    std::string &Constraint,
                                                    std::vector<SDValue> &Ops,
                                                    SelectionDAG &DAG) const {
  SDValue Result(nullptr, 0);

  // Only support length 1 constraints for now.
  if (Constraint.length() > 1)
    return;

  char ConstraintLetter = Constraint[0];
  switch (ConstraintLetter) {
  default:
    break;
  case 'I':
    if (ConstantSDNode *C = dyn_cast<ConstantSDNode>(Op)) {
      if (isInt<13>(C->getSExtValue())) {
        Result = DAG.getTargetConstant(C->getSExtValue(), SDLoc(Op),
                                       Op.getValueType());
        break;
      }
      return;
    }
  }

  if (Result.getNode()) {
    Ops.push_back(Result);
    return;
  }
  TargetLowering::LowerAsmOperandForConstraint(Op, Constraint, Ops, DAG);
}

std::pair<unsigned, const TargetRegisterClass *>
VETargetLowering::getRegForInlineAsmConstraint(const TargetRegisterInfo *TRI,
                                               StringRef Constraint,
                                               MVT VT) const {
  const TargetRegisterClass *RC = nullptr;
  if (Constraint.size() == 1) {
    switch (Constraint[0]) {
    default:
      return TargetLowering::getRegForInlineAsmConstraint(TRI, Constraint, VT);
    case 'r':
      RC = &VE::I64RegClass;
      break;
    case 'v':
      RC = &VE::V64RegClass;
      break;
    case 'f':
      if (VT == MVT::f32 || VT == MVT::f64)
        RC = &VE::I64RegClass;
      else if (VT == MVT::f128)
        RC = &VE::F128RegClass;
      else
        llvm_unreachable("Unknown ValueType for f-register-type!");
      break;
    case 'e':
      if (VT == MVT::f32 || VT == MVT::f64)
        RC = &VE::I64RegClass;
      else if (VT == MVT::f128)
        RC = &VE::F128RegClass;
      else
        llvm_unreachable("Unknown ValueType for e-register-type!");
      break;
    }
    return std::make_pair(0U, RC);
  } else if (!Constraint.empty() && Constraint.size() <= 5 &&
             Constraint[0] == '{' && *(Constraint.end() - 1) == '}') {
    // constraint = '{r<d>}'
    // Remove the braces from around the name.
    StringRef name(Constraint.data() + 1, Constraint.size() - 2);
    // Handle register aliases:
    //       r0-r7   -> g0-g7
    //       r8-r15  -> o0-o7
    //       r16-r23 -> l0-l7
    //       r24-r31 -> i0-i7
    uint64_t intVal = 0;
    if (name.substr(0, 1).equals("r") &&
        !name.substr(1).getAsInteger(10, intVal) && intVal <= 31) {
      const char regTypes[] = {'g', 'o', 'l', 'i'};
      char regType = regTypes[intVal / 8];
      char regIdx = '0' + (intVal % 8);
      char tmp[] = {'{', regType, regIdx, '}', 0};
      std::string newConstraint = std::string(tmp);
      return TargetLowering::getRegForInlineAsmConstraint(TRI, newConstraint,
                                                          VT);
    }
  }

  return TargetLowering::getRegForInlineAsmConstraint(TRI, Constraint, VT);
}

static SDValue fixUpOperation(SDValue Val, EVT LegalVT, CustomDAG &CDAG) {
  if (Val.getValueType() == LegalVT)
    return Val;

  // SelectionDAGBuilder does not respect TLI::getCCResultVT (do a fixup here)
  if (Val.getOpcode() == ISD::SETCC && Val.getValueType() == MVT::i1) {
    SDNode *N = Val.getNode();
    return CDAG.getNode(ISD::SETCC, LegalVT,
                        {N->getOperand(0), N->getOperand(1), N->getOperand(2)});
  }

  return SDValue();
}


// Override to enable LOAD_STACK_GUARD lowering on Linux.
bool VETargetLowering::useLoadStackGuardNode() const {
  if (!Subtarget->isTargetLinux())
    return TargetLowering::useLoadStackGuardNode();
  return true;
}

// Override to disable global variable loading on Linux.
void VETargetLowering::insertSSPDeclarations(Module &M) const {
  if (!Subtarget->isTargetLinux())
    return TargetLowering::insertSSPDeclarations(M);
}

void VETargetLowering::finalizeLowering(MachineFunction &MF) const {
  for (auto &MBB : MF)
    MBB.addLiveIn(VE::VL);
  TargetLoweringBase::finalizeLowering(MF);
}

bool VETargetLowering::isVectorMaskType(EVT VT) const {
  return (VT == MVT::v256i1 || VT == MVT::v512i1);
}

//===----------------------------------------------------------------------===//
// VE Target Optimization Support
//===----------------------------------------------------------------------===//

unsigned VETargetLowering::getMinimumJumpTableEntries() const {
  // Specify 8 for PIC model to relieve the impact of PIC load instructions.
  if (isJumpTableRelative())
    return 8;

  return TargetLowering::getMinimumJumpTableEntries();
}

bool VETargetLowering::hasAndNot(SDValue Y) const {
  EVT VT = Y.getValueType();

  // VE doesn't have vector and not instruction.
  if (VT.isVector())
    return false;

  // VE allows different immediate values for X and Y where ~X & Y.
  // Only simm7 works for X, and only mimm works for Y on VE.  However, this
  // function is used to check whether an immediate value is OK for and-not
  // instruction as both X and Y.  Generating additional instruction to
  // retrieve an immediate value is no good since the purpose of this
  // function is to convert a series of 3 instructions to another series of
  // 3 instructions with better parallelism.  Therefore, we return false
  // for all immediate values now.
  // FIXME: Change hasAndNot function to have two operands to make it work
  //        correctly with Aurora VE.
  if (isa<ConstantSDNode>(Y))
    return false;

  // It's ok for generic registers.
  return true;
}
