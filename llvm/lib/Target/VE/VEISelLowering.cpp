//===-- VEISelLowering.cpp - VE DAG Lowering Implementation ---------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file implements the interfaces that VE uses to lower LLVM code into a
// selection DAG.
//
//===----------------------------------------------------------------------===//

#include "VEISelLowering.h"
#include "VEIntrinsicsInfo.h"
#include "VEInstrBuilder.h"
#include "MCTargetDesc/VEMCExpr.h"
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
#include "llvm/IR/Module.h"
#include "llvm/IR/Intrinsics.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/KnownBits.h"
using namespace llvm;

#define DEBUG_TYPE "ve-lower"

//===----------------------------------------------------------------------===//
// Calling Convention Implementation
//===----------------------------------------------------------------------===//

#include "VEGenCallingConv.inc"

bool
VETargetLowering::CanLowerReturn(CallingConv::ID CallConv, MachineFunction &MF,
                                 bool isVarArg,
                                 const SmallVectorImpl<ISD::OutputArg> &Outs,
                                 LLVMContext &Context) const {
  CCAssignFn *RetCC = RetCC_VE;
  SmallVector<CCValAssign, 16> RVLocs;
  CCState CCInfo(CallConv, isVarArg, MF, RVLocs, Context);
  return CCInfo.CheckReturn(Outs, RetCC);
}

SDValue
VETargetLowering::LowerBitcast(SDValue Op, SelectionDAG &DAG) const {
  if (Op.getSimpleValueType() == MVT::v256i64 && Op.getOperand(0).getSimpleValueType() == MVT::v256f64) {
    LLVM_DEBUG(dbgs() << "Lowering bitcast of similar types.\n");
    return Op.getOperand(0);
  } else {
    return Op;
  }
}

SDValue
VETargetLowering::LowerMGATHER_MSCATTER(SDValue Op, SelectionDAG &DAG) const {
  LLVM_DEBUG(dbgs() << "Lowering gather or scatter\n");
  SDLoc dl(Op);
  //dbgs() << "\nNext Instr:\n";
  //Op.dumpr(&DAG);

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
  //MVT MaskVT = Mask.getSimpleValueType();
  //MVT BasePtrVT = BasePtr.getSimpleValueType();

  // vindex = vindex + baseptr;
  SDValue BaseBroadcast = DAG.getNode(VEISD::VEC_BROADCAST, dl, IndexVT, BasePtr);
  SDValue ScaleBroadcast = DAG.getNode(VEISD::VEC_BROADCAST, dl, IndexVT, N->getScale());

  SDValue index_addr = DAG.getNode(ISD::MUL, dl, IndexVT, {Index, ScaleBroadcast});

  SDValue addresses = DAG.getNode(ISD::ADD, dl, IndexVT, {BaseBroadcast, index_addr});

  // TODO: vmx = svm (mask);
  //Mask.dumpr(&DAG);
  if (Mask.getOpcode() != ISD::BUILD_VECTOR || Mask.getNumOperands() != 256) {
    LLVM_DEBUG(dbgs() << "Cannot handle gathers with complex masks.\n");
    return SDValue();
  }
  for (unsigned i = 0; i < 256; i++) {
    const SDValue Operand = Mask.getOperand(i);
    if (Operand.getOpcode() != ISD::Constant) {
      LLVM_DEBUG(dbgs() << "Cannot handle gather masks with complex elements.\n");
      return SDValue();
    }
    if (Mask.getConstantOperandVal(i) != 1) {
      LLVM_DEBUG(dbgs() << "Cannot handle gather masks with elements != 1.\n");
      return SDValue();
    }
  }

  if (Op.getOpcode() == ISD::MGATHER) {
    // vt = vgt (vindex, vmx, cs=0, sx=0, sy=0, sw=0);
    SDValue load = DAG.getNode(VEISD::VEC_GATHER, dl, Op.getNode()->getVTList(), {Chain, addresses});
    //load.dumpr(&DAG);

    // TODO: merge (vt, default, vmx);
    //PassThru.dumpr(&DAG);
    // We can safely ignore PassThru right now, the mask is guaranteed to be constant 1s.

    return load;
  } else {
    SDValue store = DAG.getNode(VEISD::VEC_SCATTER, dl, Op.getNode()->getVTList(), {Chain, Source, addresses});
    //store.dumpr(&DAG);
    return store;
  }
}

SDValue
VETargetLowering::LowerMLOAD(SDValue Op, SelectionDAG &DAG) const {
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

  Chain = DAG.getNode(VEISD::VEC_LVL, dl, MVT::Other, {Chain, DAG.getConstant(firstzero, dl, i32)});

  SDValue load = DAG.getLoad(Op.getSimpleValueType(), dl, Chain, BasePtr, info);

  Chain = DAG.getNode(VEISD::VEC_LVL, dl, MVT::Other, {load.getValue(1), DAG.getConstant(256, dl, i32)});

  SDValue merge = DAG.getMergeValues({load, Chain}, dl);
  LLVM_DEBUG(dbgs() << "Becomes\n");
  LLVM_DEBUG(merge.dumpr(&DAG));
  return merge;
}

SDValue
VETargetLowering::LowerBUILD_VECTOR(SDValue Chain, SelectionDAG &DAG) const {
  LLVM_DEBUG(dbgs() << "Lowering BUILD_VECTOR\n");
  auto & bvNode = *cast<BuildVectorSDNode>(Chain);

  SDLoc DL(Chain);

// match VEC_BROADCAST
  bool allUndef = true;
  unsigned first_def = -1;
  for (unsigned i = 0; i < bvNode.getNumOperands(); ++i) {
    if (!bvNode.getOperand(i).isUndef()) {
      allUndef = false;
      first_def = i;
      break;
    }
  }

  if (allUndef) {
    return DAG.getNode(VEISD::VEC_BROADCAST, DL, Chain.getSimpleValueType(),
                                  bvNode.getOperand(0));
  }

  bool isBroadcast = true;
  for (unsigned i = first_def + 1; i < bvNode.getNumOperands(); ++i) {
    if (bvNode.getOperand(first_def) != bvNode.getOperand(i) && !bvNode.getOperand(i).isUndef()) {
      isBroadcast = false;
      break;
    }
  }

  if (isBroadcast) {
    return DAG.getNode(VEISD::VEC_BROADCAST, DL, Chain.getSimpleValueType(),
                                  bvNode.getOperand(first_def));
  }


// match VEC_SEQ(stride) patterns
  // identify a constant stride vector
  bool hasConstantStride = true;

  // whether the constant is a repetition of ascending indices, eg <0, 1, 2, 3, 0, 1, 2, 3, ..>
  bool hasBlockStride = false;

  // whether the constant is an ascending sequence of repeated indices, eg <0, 0, 1, 1, 2, 2, 3, 3 ..>
  bool hasBlockStride2 = false;

  bool firstStride = true;
  int64_t blockLength = 0;
  int64_t stride = 0;
  int64_t lastElemValue = 0;
  MVT elemTy;

  for (unsigned i = 0; i < bvNode.getNumOperands(); ++i) {
    if (hasBlockStride) {
      if (i % blockLength == 0)
        stride = 1;
      else
        stride = 0;
    }

    if (bvNode.getOperand(i).isUndef()) {
      if (hasBlockStride2 && i % blockLength == 0)
        lastElemValue = 0;
      else
        lastElemValue += stride;
      continue;
    }

    // is this an immediate constant value?
    auto * constNumElem = dyn_cast<ConstantSDNode>(bvNode.getOperand(i));
    if (!constNumElem) {
      hasConstantStride = false;
      hasBlockStride = false;
      hasBlockStride2 = false;
      break;
    }

    // read value
    int64_t elemValue = constNumElem->getSExtValue();
    elemTy = constNumElem->getSimpleValueType(0);

    if (i > first_def && firstStride) {
      // first stride
      stride = (elemValue - lastElemValue) / (i - first_def);
      firstStride = false;
    } else if (i > first_def) {
      // later stride
      if (hasBlockStride2 && elemValue == 0 && i % blockLength == 0) {
        lastElemValue = 0;
        continue;
      }
      int64_t thisStride = elemValue - lastElemValue;
      if (thisStride != stride) {
        hasConstantStride = false;
        if (!hasBlockStride && thisStride == 1 && stride == 0 && lastElemValue == 0) {
          hasBlockStride = true;
          blockLength = i;
        } else if (!hasBlockStride2 && elemValue == 0 && lastElemValue + 1 == i) {
          hasBlockStride2 = true;
          blockLength = i;
        } else {
          break;
        }
      }
    }

    // track last elem value
    lastElemValue = elemValue;
  }

  // detected a proper stride pattern
  if (hasConstantStride) {
    SDValue seq = DAG.getNode(VEISD::VEC_SEQ, DL, Chain.getSimpleValueType(),
                                  DAG.getConstant(1, DL, elemTy)); // TODO draw strideTy from elements
    if (stride == 1)
      return seq;

    SDValue const_stride = DAG.getNode(VEISD::VEC_BROADCAST, DL, Chain.getSimpleValueType(), DAG.getConstant(stride, DL, elemTy));
    return DAG.getNode(ISD::MUL, DL, Chain.getSimpleValueType(), {seq, const_stride});
  }

  // codegen for <0, 0, .., 0, 0, 1, 1, .., 1, 1, .....> constant patterns
  // constant == VSEQ >> log2(blockLength)
  if (hasBlockStride) {
    int64_t blockLengthLog = log2(blockLength);

    if (pow(2, blockLengthLog) == blockLength) {
      SDValue sequence = DAG.getNode(VEISD::VEC_SEQ, DL, Chain.getSimpleValueType(), DAG.getConstant(1, DL, elemTy));
      SDValue shiftbroadcast = DAG.getNode(VEISD::VEC_BROADCAST, DL, EVT::getVectorVT(*DAG.getContext(), EVT::getIntegerVT(*DAG.getContext(), 64), 256), DAG.getConstant(blockLengthLog, DL, EVT::getIntegerVT(*DAG.getContext(), 64)));

      SDValue shift = DAG.getNode(ISD::SRL, DL, Chain.getSimpleValueType(), {sequence, shiftbroadcast});
      return shift;
    }
  }

  // codegen for <0, 1, .., 15, 0, 1, .., ..... > constant patterns
  // constant == VSEQ % blockLength
  if (hasBlockStride2) {
    int64_t blockLengthLog = log2(blockLength);

    if (pow(2, blockLengthLog) == blockLength) {
      SDValue sequence = DAG.getNode(VEISD::VEC_SEQ, DL, Chain.getSimpleValueType(), DAG.getConstant(1, DL, elemTy));
      SDValue modulobroadcast = DAG.getNode(VEISD::VEC_BROADCAST, DL, EVT::getVectorVT(*DAG.getContext(), EVT::getIntegerVT(*DAG.getContext(), 64), 256), DAG.getConstant(blockLength - 1, DL, EVT::getIntegerVT(*DAG.getContext(), 64)));

      SDValue modulo = DAG.getNode(ISD::AND, DL, Chain.getSimpleValueType(), {sequence, modulobroadcast});

      return modulo;
    }
  }

  // default to element-wise insertion
  SDValue newVector = DAG.getNode(VEISD::VEC_BROADCAST, DL, Chain.getSimpleValueType(),
                                  bvNode.getOperand(0));

  for (unsigned i = 0; i < bvNode.getNumOperands(); ++i) {
    newVector = DAG.getNode(ISD::INSERT_VECTOR_ELT, DL, Chain.getSimpleValueType(),
        newVector,
        bvNode.getOperand(i),
        DAG.getConstant(i, DL, EVT::getIntegerVT(*DAG.getContext(), 64))
    );
  }

  return newVector;
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
  CCInfo.AnalyzeReturn(Outs, RetCC_VE);

  SDValue Flag;
  SmallVector<SDValue, 4> RetOps(1, Chain);

  // Copy the result values into the output registers.
  for (unsigned i = 0; i != RVLocs.size(); ++i) {
    CCValAssign &VA = RVLocs[i];
    assert(VA.isRegLoc() && "Can only return in registers!");
    SDValue OutVal = OutVals[i];

    // Integer return values must be sign or zero extended by the callee.
    switch (VA.getLocInfo()) {
    case CCValAssign::Full: break;
    case CCValAssign::SExt:
      OutVal = DAG.getNode(ISD::SIGN_EXTEND, DL, VA.getLocVT(), OutVal);
      break;
    case CCValAssign::ZExt:
      OutVal = DAG.getNode(ISD::ZERO_EXTEND, DL, VA.getLocVT(), OutVal);
      break;
    case CCValAssign::AExt:
      OutVal = DAG.getNode(ISD::ANY_EXTEND, DL, VA.getLocVT(), OutVal);
      break;
    default:
      llvm_unreachable("Unknown loc info!");
    }

    // The custom bit on an i32 return value indicates that it should be passed
    // in the high bits of the register.
    if (VA.getValVT() == MVT::i32 && VA.needsCustom()) {
      OutVal = DAG.getNode(ISD::SHL, DL, MVT::i64, OutVal,
                           DAG.getConstant(32, DL, MVT::i32));

      // The next value may go in the low bits of the same register.
      // Handle both at once.
      if (i+1 < RVLocs.size() && RVLocs[i+1].getLocReg() == VA.getLocReg()) {
        SDValue NV = DAG.getNode(ISD::ZERO_EXTEND, DL, MVT::i64, OutVals[i+1]);
        OutVal = DAG.getNode(ISD::OR, DL, MVT::i64, OutVal, NV);
        // Skip the next value, it's already done.
        ++i;
      }
    }

    Chain = DAG.getCopyToReg(Chain, DL, VA.getLocReg(), OutVal, Flag);

    // Guarantee that all emitted copies are stuck together with flags.
    Flag = Chain.getValue(1);
    RetOps.push_back(DAG.getRegister(VA.getLocReg(), VA.getLocVT()));
  }

  RetOps[0] = Chain;  // Update chain.

  // Add the flag if we have it.
  if (Flag.getNode())
    RetOps.push_back(Flag);

  return DAG.getNode(VEISD::RET_FLAG, DL, MVT::Other, RetOps);
}

SDValue
VETargetLowering::LowerFormalArguments(SDValue Chain, CallingConv::ID CallConv,
                                       bool IsVarArg,
                                       const SmallVectorImpl<ISD::InputArg>
                                       &Ins,
                                       const SDLoc &DL, SelectionDAG &DAG,
                                       SmallVectorImpl<SDValue> &InVals) const {
  MachineFunction &MF = DAG.getMachineFunction();

  // Get the base offset of the incoming arguments stack space.
  unsigned ArgsBaseOffset = 176;
  // Get the size of the preserved arguments area
  unsigned ArgsPreserved = 64;

  // Analyze arguments according to CC_VE.
  SmallVector<CCValAssign, 16> ArgLocs;
  CCState CCInfo(CallConv, IsVarArg, DAG.getMachineFunction(), ArgLocs,
                 *DAG.getContext());
  // Allocate the preserved area first.
  CCInfo.AllocateStack(ArgsPreserved, 8);
  // We already allocated the preserved area, so the stack offset computed
  // by CC_VE would be correct now.
  CCInfo.AnalyzeFormalArguments(Ins, CC_VE);

  for (unsigned i = 0, e = ArgLocs.size(); i != e; ++i) {
    CCValAssign &VA = ArgLocs[i];
    if (VA.isRegLoc()) {
      // This argument is passed in a register.
      // All integer register arguments are promoted by the caller to i64.

      // Create a virtual register for the promoted live-in value.
      unsigned VReg = MF.addLiveIn(VA.getLocReg(),
                                   getRegClassFor(VA.getLocVT()));
      SDValue Arg = DAG.getCopyFromReg(Chain, DL, VReg, VA.getLocVT());

      // Get the high bits for i32 struct elements.
      if (VA.getValVT() == MVT::i32 && VA.needsCustom())
        Arg = DAG.getNode(ISD::SRL, DL, VA.getLocVT(), Arg,
                          DAG.getConstant(32, DL, MVT::i32));

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
    // beginning of the arguments area at %fp+176.
    unsigned Offset = VA.getLocMemOffset() + ArgsBaseOffset;
    unsigned ValSize = VA.getValVT().getSizeInBits() / 8;
    // Adjust offset for extended arguments, SPARC is big-endian.
    // The caller will have written the full slot with extended bytes, but we
    // prefer our own extending loads.
    if (VA.isExtInLoc())
      Offset += 8 - ValSize;
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
  // Skip the 176 bytes of register save area.
  FuncInfo->setVarArgsFrameOffset(ArgOffset + ArgsBaseOffset);

#if 0
// VE ABI requires to store values in stack by caller side.
// So no need to store varargs here.
  // Save the variable arguments that were passed in registers.
  // The caller is required to reserve stack space for 8 arguments regardless
  // of how many arguments were actually passed.
  SmallVector<SDValue, 8> OutChains;
  for (; ArgOffset < 8*8; ArgOffset += 8) {
    unsigned VReg = MF.addLiveIn(VE::SX0 + ArgOffset/8, &VE::I64RegClass);
    SDValue VArg = DAG.getCopyFromReg(Chain, DL, VReg, MVT::i64);
    int FI = MF.getFrameInfo().CreateFixedObject(8, ArgOffset + ArgsBaseOffset, true);
    auto PtrVT = getPointerTy(MF.getDataLayout());
    OutChains.push_back(
        DAG.getStore(Chain, DL, VArg, DAG.getFrameIndex(FI, PtrVT),
                     MachinePointerInfo::getFixedStack(MF, FI)));
  }

  if (!OutChains.empty())
    Chain = DAG.getNode(ISD::TokenFactor, DL, MVT::Other, OutChains);
#endif

  return Chain;
}

// FIXME? Maybe this could be a TableGen attribute on some registers and
// this table could be generated automatically from RegInfo.
unsigned VETargetLowering::getRegisterByName(const char* RegName, EVT VT,
                                               SelectionDAG &DAG) const {
  unsigned Reg = StringSwitch<unsigned>(RegName)
    .Case("sp", VE::SX11)        // Stack pointer
    .Case("fp", VE::SX9)         // Frame pointer
    .Case("sl", VE::SX8)         // Stack limit
    .Case("lr", VE::SX10)        // Link regsiter
    .Case("tp", VE::SX14)        // Thread pointer
    .Case("outer", VE::SX12)     // Outer regiser
    .Case("info", VE::SX17)      // Info area register
    .Case("got", VE::SX15)       // Global offset table register
    .Case("plt", VE::SX16)       // Procedure linkage table register
    .Case("usrcc", VE::UCC)     // User clock counter
    .Default(0);

  if (Reg)
    return Reg;

  report_fatal_error("Invalid register name global variable");
}

// This functions returns true if CalleeName is a ABI function that returns
// a long double (fp128).
static bool isFP128ABICall(const char *CalleeName)
{
  static const char *const ABICalls[] =
    {  "_Q_add", "_Q_sub", "_Q_mul", "_Q_div",
       "_Q_sqrt", "_Q_neg",
       "_Q_itoq", "_Q_stoq", "_Q_dtoq", "_Q_utoq",
       "_Q_lltoq", "_Q_ulltoq",
       nullptr
    };
  for (const char * const *I = ABICalls; *I != nullptr; ++I)
    if (strcmp(CalleeName, *I) == 0)
      return true;
  return false;
}

unsigned
VETargetLowering::getSRetArgSize(SelectionDAG &DAG, SDValue Callee) const
{
  const Function *CalleeFn = nullptr;
  if (GlobalAddressSDNode *G = dyn_cast<GlobalAddressSDNode>(Callee)) {
    CalleeFn = dyn_cast<Function>(G->getGlobal());
  } else if (ExternalSymbolSDNode *E =
             dyn_cast<ExternalSymbolSDNode>(Callee)) {
    const Function &F = DAG.getMachineFunction().getFunction();
    const Module *M = F.getParent();
    const char *CalleeName = E->getSymbol();
    CalleeFn = M->getFunction(CalleeName);
    if (!CalleeFn && isFP128ABICall(CalleeName))
      return 16; // Return sizeof(fp128)
  }

  if (!CalleeFn)
    return 0;

  // It would be nice to check for the sret attribute on CalleeFn here,
  // but since it is not part of the function type, any check will misfire.

  PointerType *Ty = cast<PointerType>(CalleeFn->arg_begin()->getType());
  Type *ElementTy = Ty->getElementType();
  return DAG.getDataLayout().getTypeAllocSize(ElementTy);
}

SDValue
VETargetLowering::LowerCall(TargetLowering::CallLoweringInfo &CLI,
                            SmallVectorImpl<SDValue> &InVals) const {
  SelectionDAG &DAG = CLI.DAG;
  SDLoc DL = CLI.DL;
  SDValue Chain = CLI.Chain;
  auto PtrVT = getPointerTy(DAG.getDataLayout());

  // VE target does not yet support tail call optimization.
  CLI.IsTailCall = false;

  // Get the base offset of the outgoing arguments stack space.
  unsigned ArgsBaseOffset = 176;
  // Get the size of the preserved arguments area
  unsigned ArgsPreserved = 8*8u;

  // Analyze operands of the call, assigning locations to each operand.
  SmallVector<CCValAssign, 16> ArgLocs;
  CCState CCInfo(CLI.CallConv, CLI.IsVarArg, DAG.getMachineFunction(), ArgLocs,
                 *DAG.getContext());
  // Allocate the preserved area first.
  CCInfo.AllocateStack(ArgsPreserved, 8);
  // We already allocated the preserved area, so the stack offset computed
  // by CC_VE would be correct now.
  CCInfo.AnalyzeCallOperands(CLI.Outs, CC_VE);

  // VE requires to use both register and stack for varargs or no-prototyped
  // functions.  FIXME: How to check prototype here?
  bool UseBoth = CLI.IsVarArg /* || CLI.NoProtoType */;

  // Analyze operands again if it is required to store BOTH.
  SmallVector<CCValAssign, 16> ArgLocs2;
  CCState CCInfo2(CLI.CallConv, CLI.IsVarArg, DAG.getMachineFunction(),
                  ArgLocs2, *DAG.getContext());
  if (UseBoth)
    CCInfo2.AnalyzeCallOperands(CLI.Outs, CC_VE2);

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
      Callee =  makeHiLoPair(Callee, VEMCExpr::VK_VE_HI32,
                             VEMCExpr::VK_VE_LO32, DAG);
    }
  } else if (ExternalSymbolSDNode *E = dyn_cast<ExternalSymbolSDNode>(Callee)) {
    if (IsPICCall) {
      if (UsePlt)
        Subtarget->getInstrInfo()->getGlobalBaseReg(&MF);
      Callee = DAG.getTargetExternalSymbol(E->getSymbol(), PtrVT, 0);
      Callee = DAG.getNode(VEISD::GETFUNPLT, DL, PtrVT, Callee);
    } else {
      Callee =  makeHiLoPair(Callee, VEMCExpr::VK_VE_HI32,
                             VEMCExpr::VK_VE_LO32, DAG);
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
    }

    if (VA.isRegLoc()) {
      // The custom bit on an i32 return value indicates that it should be
      // passed in the high bits of the register.
      if (VA.getValVT() == MVT::i32 && VA.needsCustom()) {
#if 1 // ishizaka
      llvm_unreachable("what's this?\n");
#else
        Arg = DAG.getNode(ISD::SHL, DL, MVT::i64, Arg,
                          DAG.getConstant(32, DL, MVT::i32));

        // The next value may go in the low bits of the same register.
        // Handle both at once.
        if (i+1 < ArgLocs.size() && ArgLocs[i+1].isRegLoc() &&
            ArgLocs[i+1].getLocReg() == VA.getLocReg()) {
          SDValue NV = DAG.getNode(ISD::ZERO_EXTEND, DL, MVT::i64,
                                   CLI.OutVals[i+1]);
          Arg = DAG.getNode(ISD::OR, DL, MVT::i64, Arg, NV);
          // Skip the next value, it's already done.
          ++i;
        }
#endif
      }
      RegsToPass.push_back(std::make_pair(VA.getLocReg(), Arg));
      if (!UseBoth)
        continue;
      VA = ArgLocs2[i];
    }

    assert(VA.isMemLoc());

    // Create a store off the stack pointer for this argument.
    SDValue StackPtr = DAG.getRegister(VE::SX11, PtrVT);
    // The argument area starts at %fp+176 in the callee frame,
    // %sp+176 in ours.
    SDValue PtrOff = DAG.getIntPtrConstant(VA.getLocMemOffset() +
                                           ArgsBaseOffset, DL);
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
    Chain = DAG.getCopyToReg(Chain, DL,
                             RegsToPass[i].first, RegsToPass[i].second, InGlue);
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
  if (CLI.Ins.size() == 1 && CLI.Ins[0].VT == MVT::f32 && !CLI.CS)
    CLI.Ins[0].Flags.setInReg();

  RVInfo.AnalyzeCallResult(CLI.Ins, RetCC_VE);

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

//===----------------------------------------------------------------------===//
// TargetLowering Implementation
//===----------------------------------------------------------------------===//

TargetLowering::AtomicExpansionKind VETargetLowering::shouldExpandAtomicRMWInIR(AtomicRMWInst *AI) const {
  if (AI->getOperation() == AtomicRMWInst::Xchg)
    return AtomicExpansionKind::None; // Uses ts1am instruction

  return AtomicExpansionKind::CmpXChg;
}

VETargetLowering::VETargetLowering(const TargetMachine &TM,
                                   const VESubtarget &STI)
    : TargetLowering(TM), Subtarget(&STI) {
  MVT PtrVT = MVT::getIntegerVT(8 * TM.getPointerSize(0));

  // Instructions which use registers as conditionals examine all the
  // bits (as does the pseudo SELECT_CC expansion). I don't think it
  // matters much whether it's ZeroOrOneBooleanContent, or
  // ZeroOrNegativeOneBooleanContent, so, arbitrarily choose the
  // former.
  setBooleanContents(ZeroOrOneBooleanContent);
  setBooleanVectorContents(ZeroOrOneBooleanContent);

  // Set up the register classes.
  addRegisterClass(MVT::i32, &VE::I32RegClass);
  addRegisterClass(MVT::i64, &VE::I64RegClass);
  addRegisterClass(MVT::f32, &VE::F32RegClass);
  addRegisterClass(MVT::f64, &VE::I64RegClass);
  addRegisterClass(MVT::f128, &VE::F128RegClass);
  addRegisterClass(MVT::v256i32, &VE::V64RegClass);
  addRegisterClass(MVT::v256i64, &VE::V64RegClass);
  addRegisterClass(MVT::v512i32, &VE::V64RegClass);
  addRegisterClass(MVT::v256f32, &VE::V64RegClass);
  addRegisterClass(MVT::v256f64, &VE::V64RegClass);
  addRegisterClass(MVT::v512f32, &VE::V64RegClass);
  addRegisterClass(MVT::v256i1, &VE::VMRegClass);
  addRegisterClass(MVT::v512i1, &VE::VM512RegClass);

  // FIXME:
  // Need to add a register class for these types to make those types
  // leagal in something like following IR.  VE doesn't have v4i64 hardware
  // register, but C requires it.  Without this, llvm causes "Do not know
  // how to widen the result of this operator!" errors.
  //
  //   e.g. (i256i1 (bitcast (v4i64 (llvm.ve.vfmkw.mcv ...))))
  //                          ^^^^^ this requires adding register classes here.
  addRegisterClass(MVT::v4i64, &VE::V64RegClass);
  addRegisterClass(MVT::v8i64, &VE::V64RegClass);

  // Turn FP extload into load/fpextend
  for (MVT VT : MVT::fp_valuetypes()) {
    setLoadExtAction(ISD::EXTLOAD, VT, MVT::f32, Expand);
    setLoadExtAction(ISD::EXTLOAD, VT, MVT::f64, Expand);
  }

  // VE doesn't have i1 sign extending load
  for (MVT VT : MVT::integer_valuetypes()) {
    setLoadExtAction(ISD::SEXTLOAD, VT, MVT::i1, Promote);
    setLoadExtAction(ISD::ZEXTLOAD, VT, MVT::i1, Promote);
    setLoadExtAction(ISD::EXTLOAD,  VT, MVT::i1, Promote);
    setTruncStoreAction(MVT::i64, MVT::i1, Expand);
  }

  // Turn FP truncstore into trunc + store.
  setTruncStoreAction(MVT::f64, MVT::f32, Expand);
  setTruncStoreAction(MVT::f128, MVT::f32, Expand);
  setTruncStoreAction(MVT::f128, MVT::f64, Expand);

  // custom splat handling
  for (MVT VT : MVT::vector_valuetypes()) {
    setOperationAction(ISD::BUILD_VECTOR, VT, Custom);
  }

  // currently unsupported math functions
  for (MVT VT : MVT::vector_valuetypes()) {
    setOperationAction(ISD::FABS, VT, Expand);
  }

  // Custom legalize GlobalAddress nodes into LO/HI parts.
  setOperationAction(ISD::GlobalAddress, PtrVT, Custom);
  setOperationAction(ISD::GlobalTLSAddress, PtrVT, Custom);
  setOperationAction(ISD::ConstantPool, PtrVT, Custom);
  setOperationAction(ISD::BlockAddress, PtrVT, Custom);

  // VE has no REM or DIVREM operations.
  for (MVT VT : MVT::integer_valuetypes()) {
    setOperationAction(ISD::UREM, VT, Expand);
    setOperationAction(ISD::SREM, VT, Expand);
    setOperationAction(ISD::SDIVREM, VT, Expand);
    setOperationAction(ISD::UDIVREM, VT, Expand);
  }

  // VE has instructions for fp<->sint, so use them.

  // VE doesn't have instructions for fp<->uint, so expand them by llvm
  setOperationAction(ISD::FP_TO_UINT, MVT::i32, Promote); // use i64
  setOperationAction(ISD::UINT_TO_FP, MVT::i32, Promote); // use i64
  setOperationAction(ISD::FP_TO_UINT, MVT::i64, Expand);
  setOperationAction(ISD::UINT_TO_FP, MVT::i64, Expand);

  // VE doesn't have BRCOND
  setOperationAction(ISD::BRCOND, MVT::Other, Expand);

  // BRIND/BR_JT are not implemented yet.
  //   FIXME: BRIND instruction is implemented, but JumpTable is not yet.
  setOperationAction(ISD::BRIND,  MVT::Other, Expand);
  setOperationAction(ISD::BR_JT,  MVT::Other, Expand);

  setOperationAction(ISD::EH_SJLJ_SETJMP, MVT::i32, Custom);
  setOperationAction(ISD::EH_SJLJ_LONGJMP, MVT::Other, Custom);
  setOperationAction(ISD::EH_SJLJ_SETUP_DISPATCH, MVT::Other, Custom);
  if (TM.Options.ExceptionModel == ExceptionHandling::SjLj)
    setLibcallName(RTLIB::UNWIND_RESUME, "_Unwind_SjLj_Resume");

  setTargetDAGCombine(ISD::FADD);
  //setTargetDAGCombine(ISD::FMA);

  // ATOMICs.
  // Atomics are supported on VE.
  setMaxAtomicSizeInBitsSupported(64);
  setMinCmpXchgSizeInBits(32);

  // Use custom inserter, LowerATOMIC_FENCE, for ATOMIC_FENCE.
  setOperationAction(ISD::ATOMIC_FENCE, MVT::Other, Custom);

  for (MVT VT : MVT::integer_valuetypes()) {
    // Several atomic operations are converted to VE instructions well.
    // Additional memory fences are generated in emitLeadingfence and
    // emitTrailingFence functions.
    setOperationAction(ISD::ATOMIC_LOAD, VT, Legal);
    setOperationAction(ISD::ATOMIC_STORE, VT, Legal);
    setOperationAction(ISD::ATOMIC_CMP_SWAP, VT, Legal);
    setOperationAction(ISD::ATOMIC_SWAP, VT, Legal);

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

  // FIXME: VE's I128 stuff is not investivated yet
  if (!1) {
    // These libcalls are not available in 32-bit.
    setLibcallName(RTLIB::SHL_I128, nullptr);
    setLibcallName(RTLIB::SRL_I128, nullptr);
    setLibcallName(RTLIB::SRA_I128, nullptr);
  }

  for (MVT VT : MVT::fp_valuetypes()) {
    // VE has no sclar FMA instruction
    setOperationAction(ISD::FMA, VT, Expand);
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

  // FIXME: VE's FCOPYSIGN is not investivated yet
  setOperationAction(ISD::FCOPYSIGN, MVT::f128, Expand);
  setOperationAction(ISD::FCOPYSIGN, MVT::f64, Expand);
  setOperationAction(ISD::FCOPYSIGN, MVT::f32, Expand);

  // FIXME: VE's SHL_PARTS and others are not investigated yet.
  setOperationAction(ISD::SHL_PARTS, MVT::i32, Expand);
  setOperationAction(ISD::SRA_PARTS, MVT::i32, Expand);
  setOperationAction(ISD::SRL_PARTS, MVT::i32, Expand);
  if (1) {
    setOperationAction(ISD::SHL_PARTS, MVT::i64, Expand);
    setOperationAction(ISD::SRA_PARTS, MVT::i64, Expand);
    setOperationAction(ISD::SRL_PARTS, MVT::i64, Expand);
  }

  // Expands to [SU]MUL_LOHI.
  setOperationAction(ISD::MULHU,     MVT::i32, Expand);
  setOperationAction(ISD::MULHS,     MVT::i32, Expand);
  //setOperationAction(ISD::MUL,       MVT::i32, Expand);

  // FIXME: VE's i64 MUL stuff is not investigated yet.
#if 0
  if (Subtarget->useSoftMulDiv()) {
    // .umul works for both signed and unsigned
    setOperationAction(ISD::SMUL_LOHI, MVT::i32, Expand);
    setOperationAction(ISD::UMUL_LOHI, MVT::i32, Expand);
    setLibcallName(RTLIB::MUL_I32, ".umul");

    setOperationAction(ISD::SDIV, MVT::i32, Expand);
    setLibcallName(RTLIB::SDIV_I32, ".div");

    setOperationAction(ISD::UDIV, MVT::i32, Expand);
    setLibcallName(RTLIB::UDIV_I32, ".udiv");
  }
#endif

  if (1) {
    setOperationAction(ISD::UMUL_LOHI, MVT::i64, Expand);
    setOperationAction(ISD::SMUL_LOHI, MVT::i64, Expand);
    setOperationAction(ISD::MULHU,     MVT::i64, Expand);
    setOperationAction(ISD::MULHS,     MVT::i64, Expand);

    setOperationAction(ISD::UMULO,     MVT::i64, Custom);
    setOperationAction(ISD::SMULO,     MVT::i64, Custom);
  }

  // Bits operations
  setOperationAction(ISD::BITCAST, MVT::v256i64, Custom);

  setOperationAction(ISD::BITREVERSE, MVT::i32, Legal);
  setOperationAction(ISD::BITREVERSE, MVT::i64, Legal);
  setOperationAction(ISD::BSWAP, MVT::i32, Legal);
  setOperationAction(ISD::BSWAP, MVT::i64, Legal);
  setOperationAction(ISD::CTPOP, MVT::i32, Legal);
  setOperationAction(ISD::CTPOP, MVT::i64, Legal);
  setOperationAction(ISD::CTLZ , MVT::i32, Legal);
  setOperationAction(ISD::CTLZ , MVT::i64, Legal);
  setOperationAction(ISD::CTTZ , MVT::i32, Expand);
  setOperationAction(ISD::CTTZ , MVT::i64, Expand);
  setOperationAction(ISD::ROTL , MVT::i32, Expand);
  setOperationAction(ISD::ROTL , MVT::i64, Expand);
  setOperationAction(ISD::ROTR , MVT::i32, Expand);
  setOperationAction(ISD::ROTR , MVT::i64, Expand);

  // VASTART needs to be custom lowered to use the VarArgsFrameIndex.
  setOperationAction(ISD::VASTART           , MVT::Other, Custom);
  // VAARG needs to be lowered to access with 8 bytes alignment.
  setOperationAction(ISD::VAARG             , MVT::Other, Custom);

  // Use the default implementation.
  setOperationAction(ISD::VACOPY            , MVT::Other, Expand);
  setOperationAction(ISD::VAEND             , MVT::Other, Expand);
  setOperationAction(ISD::STACKSAVE         , MVT::Other, Expand);
  setOperationAction(ISD::STACKRESTORE      , MVT::Other, Expand);

  // Expand DYNAMIC_STACKALLOC
  setOperationAction(ISD::DYNAMIC_STACKALLOC, MVT::i32, Custom);
  setOperationAction(ISD::DYNAMIC_STACKALLOC, MVT::i64, Custom);

  // LOAD/STORE for f128 needs to be custom lowered to expand two loads/stores
  setOperationAction(ISD::LOAD, MVT::f128, Custom);
  setOperationAction(ISD::STORE, MVT::f128, Custom);

  for (MVT VT : MVT::vector_valuetypes()) {
    setOperationAction(ISD::SCALAR_TO_VECTOR,   VT, Legal);
    setOperationAction(ISD::INSERT_VECTOR_ELT,  VT, Custom);
    setOperationAction(ISD::EXTRACT_VECTOR_ELT, VT, Custom);
    setOperationAction(ISD::BUILD_VECTOR,       VT, Custom);
    setOperationAction(ISD::CONCAT_VECTORS,     VT, Expand);
    setOperationAction(ISD::INSERT_SUBVECTOR,   VT, Expand);
    setOperationAction(ISD::EXTRACT_SUBVECTOR,  VT, Expand);
    setOperationAction(ISD::VECTOR_SHUFFLE,     VT, Custom);

    setOperationAction(ISD::FADD,  VT, Legal);
    setOperationAction(ISD::FSUB,  VT, Legal);
    setOperationAction(ISD::FMUL,  VT, Legal);
    setOperationAction(ISD::FDIV,  VT, Legal);
    setOperationAction(ISD::ADD,   VT, Legal);
    setOperationAction(ISD::SUB,   VT, Legal);
    setOperationAction(ISD::MUL,   VT, Legal);
    setOperationAction(ISD::SDIV,  VT, Legal);
    setOperationAction(ISD::UDIV,  VT, Legal);

    setOperationAction(ISD::SHL,   VT, Legal);

    setOperationAction(ISD::MSCATTER,   VT, Custom);
    setOperationAction(ISD::MGATHER,   VT, Custom);

    setOperationAction(ISD::MLOAD, VT, Custom);
  }

  // VE has no packed MUL, SDIV, or UDIV operations.
  for (MVT VT : { MVT::v512i32, MVT::v512f32 }) {
    setOperationAction(ISD::MUL,   VT, Expand);
    setOperationAction(ISD::SDIV,  VT, Expand);
    setOperationAction(ISD::UDIV,  VT, Expand);
  }

  // VE has no REM or DIVREM operations.
  for (MVT VT : MVT::vector_valuetypes()) {
    setOperationAction(ISD::UREM, VT, Expand);
    setOperationAction(ISD::SREM, VT, Expand);
    setOperationAction(ISD::SDIVREM, VT, Expand);
    setOperationAction(ISD::UDIVREM, VT, Expand);
  }

  // Following code doesn't expand store-trunc as what we expected.
  // Need to correct this problem.
  //
  // Problem before: cannot select store-trunc for t23.
  //    t22: v4i64 = mul t102, t92
  //    t23: ch = store<(store 16 into %ir.V), trunc to v4i32> t22:1,
  //              t22, FrameIndex:i64<5>, undef:i64
  //
  // Problem after: cannot select store 32 for t73.
  //    t22: v4i64 = mul t102, t92
  //    t73: ch = store<(store 32 into %stack.21)> t0,
  //              t22, FrameIndex:i64<21>, undef:i64
#if 0
  // Expand all vector-vector truncstore and extload
  for (MVT VT : MVT::vector_valuetypes()) {
    for (MVT InnerVT : MVT::vector_valuetypes()) {
      setTruncStoreAction(VT, InnerVT, Expand);
      setLoadExtAction(ISD::SEXTLOAD, VT, InnerVT, Expand);
      setLoadExtAction(ISD::ZEXTLOAD, VT, InnerVT, Expand);
      setLoadExtAction(ISD::EXTLOAD, VT, InnerVT, Expand);
    }
  }
#endif

  // VE has FAQ, FSQ, FMQ, and FCQ
  setOperationAction(ISD::FADD,  MVT::f128, Legal);
  setOperationAction(ISD::FSUB,  MVT::f128, Legal);
  setOperationAction(ISD::FMUL,  MVT::f128, Legal);
  setOperationAction(ISD::FDIV,  MVT::f128, Expand);
  setOperationAction(ISD::FSQRT, MVT::f128, Expand);
  setOperationAction(ISD::FP_EXTEND, MVT::f128, Legal);
  setOperationAction(ISD::FP_ROUND,  MVT::f128, Legal);

  // Other configurations related to f128.
  setOperationAction(ISD::SELECT,    MVT::f128, Legal);
  setOperationAction(ISD::SELECT_CC, MVT::f128, Legal);
  setOperationAction(ISD::SETCC,     MVT::f128, Legal);
  setOperationAction(ISD::BR_CC,     MVT::f128, Legal);

  setOperationAction(ISD::INTRINSIC_VOID, MVT::Other, Custom);
  setOperationAction(ISD::INTRINSIC_W_CHAIN, MVT::Other, Custom);
  setOperationAction(ISD::INTRINSIC_WO_CHAIN, MVT::Other, Custom);

  // TRAP to expand (which turns it into abort).
  setOperationAction(ISD::TRAP, MVT::Other, Expand);

  // On most systems, DEBUGTRAP and TRAP have no difference. The "Expand"
  // here is to inform DAG Legalizer to replace DEBUGTRAP with TRAP.
  setOperationAction(ISD::DEBUGTRAP, MVT::Other, Expand);

// vector fma // TESTING
  for (MVT VT : MVT::vector_valuetypes()) {
    setOperationAction(ISD::FMA, VT, Legal);
    setOperationAction(ISD::FNEG, VT, Legal);
    //setOperationAction(ISD::FMAD, VT, Legal);
  }

  setStackPointerRegisterToSaveRestore(VE::SX11);

  // Set function alignment to 16 bytes (4 bits)
  setMinFunctionAlignment(4);

  // VE stores all argument by 8 bytes alignment
  setMinStackArgumentAlignment(8);

  computeRegisterProperties(Subtarget->getRegisterInfo());

  verifyIntrinsicTables();
}

const char *VETargetLowering::getTargetNodeName(unsigned Opcode) const {
  switch ((VEISD::NodeType)Opcode) {
  case VEISD::FIRST_NUMBER:    break;
  case VEISD::CMPICC:          return "VEISD::CMPICC";
  case VEISD::CMPFCC:          return "VEISD::CMPFCC";
  case VEISD::BRICC:           return "VEISD::BRICC";
  case VEISD::BRXCC:           return "VEISD::BRXCC";
  case VEISD::BRFCC:           return "VEISD::BRFCC";
  case VEISD::SELECT:          return "VEISD::SELECT";
  case VEISD::SELECT_ICC:      return "VEISD::SELECT_ICC";
  case VEISD::SELECT_XCC:      return "VEISD::SELECT_XCC";
  case VEISD::SELECT_FCC:      return "VEISD::SELECT_FCC";
  case VEISD::EH_SJLJ_SETJMP:  return "VEISD::EH_SJLJ_SETJMP";
  case VEISD::EH_SJLJ_LONGJMP: return "VEISD::EH_SJLJ_LONGJMP";
  case VEISD::EH_SJLJ_SETUP_DISPATCH:   return "VEISD::EH_SJLJ_SETUP_DISPATCH";
  case VEISD::Hi:              return "VEISD::Hi";
  case VEISD::Lo:              return "VEISD::Lo";
  case VEISD::FTOI:            return "VEISD::FTOI";
  case VEISD::ITOF:            return "VEISD::ITOF";
  case VEISD::FTOX:            return "VEISD::FTOX";
  case VEISD::XTOF:            return "VEISD::XTOF";
  case VEISD::MAX:             return "VEISD::MAX";
  case VEISD::MIN:             return "VEISD::MIN";
  case VEISD::FMAX:            return "VEISD::FMAX";
  case VEISD::FMIN:            return "VEISD::FMIN";
  case VEISD::GETFUNPLT:       return "VEISD::GETFUNPLT";
  case VEISD::GETSTACKTOP:     return "VEISD::GETSTACKTOP";
  case VEISD::GETTLSADDR:      return "VEISD::GETTLSADDR";
  case VEISD::MEMBARRIER:      return "VEISD::MEMBARRIER";
  case VEISD::CALL:            return "VEISD::CALL";
  case VEISD::RET_FLAG:        return "VEISD::RET_FLAG";
  case VEISD::GLOBAL_BASE_REG: return "VEISD::GLOBAL_BASE_REG";
  case VEISD::FLUSHW:          return "VEISD::FLUSHW";
  case VEISD::VEC_BROADCAST:   return "VEISD::VEC_BROADCAST";
  case VEISD::VEC_LVL:         return "VEISD::VEC_LVL";
  case VEISD::VEC_SEQ:         return "VEISD::VEC_SEQ";
  case VEISD::VEC_VMV:         return "VEISD::VEC_VMV";
  case VEISD::VEC_SCATTER:     return "VEISD::VEC_SCATTER";
  case VEISD::VEC_GATHER:      return "VEISD::VEC_GATHER";
  case VEISD::Wrapper:         return "VEISD::Wrapper";
  case VEISD::INT_LVM:         return "VEISD::INT_LVM";
  case VEISD::INT_SVM:         return "VEISD::INT_SVM";
  case VEISD::INT_ANDM:        return "VEISD::INT_ANDM";
  case VEISD::INT_ORM:         return "VEISD::INT_ORM";
  case VEISD::INT_XORM:        return "VEISD::INT_XORM";
  case VEISD::INT_EQVM:        return "VEISD::INT_EQVM";
  case VEISD::INT_NNDM:        return "VEISD::INT_NNDM";
  case VEISD::INT_NEGM:        return "VEISD::INT_NEGM";
  case VEISD::INT_PCVM:        return "VEISD::INT_PCVM";
  case VEISD::INT_LZVM:        return "VEISD::INT_LZVM";
  case VEISD::INT_TOVM:        return "VEISD::INT_TOVM";
  case VEISD::INT_VADDUL:      return "VEISD::INT_VADDUL";
  case VEISD::INT_VSUBUL:      return "VEISD::INT_VSUBUL";
  case VEISD::INT_VCMPUL:      return "VEISD::INT_VCMPUL";
  case VEISD::INT_VADDUW:      return "VEISD::INT_VADDUW";
  case VEISD::INT_VSUBUW:      return "VEISD::INT_VSUBUW";
  case VEISD::INT_VCMPUW:      return "VEISD::INT_VCMPUW";
  case VEISD::INT_VADDSWSX:    return "VEISD::INT_VADDSWSX";
  case VEISD::INT_VSUBSWSX:    return "VEISD::INT_VSUBSWSX";
  case VEISD::INT_VCMPSWSX:    return "VEISD::INT_VCMPSWSX";
  case VEISD::INT_VADDSWZX:    return "VEISD::INT_VADDSWZX";
  case VEISD::INT_VSUBSWZX:    return "VEISD::INT_VSUBSWZX";
  case VEISD::INT_VCMPSWZX:    return "VEISD::INT_VCMPSWZX";
  case VEISD::INT_VADDSL:      return "VEISD::INT_VADDSL";
  case VEISD::INT_VSUBSL:      return "VEISD::INT_VSUBSL";
  case VEISD::INT_VCMPSL:      return "VEISD::INT_VCMPSL";
  case VEISD::INT_PVADDU:      return "VEISD::INT_PVADDU";
  case VEISD::INT_PVSUBU:      return "VEISD::INT_PVSUBU";
  case VEISD::INT_PVCMPU:      return "VEISD::INT_PVCMPU";
  case VEISD::INT_PVADDS:      return "VEISD::INT_PVADDS";
  case VEISD::INT_PVSUBS:      return "VEISD::INT_PVSUBS";
  case VEISD::INT_PVCMPS:      return "VEISD::INT_PVCMPS";
  case VEISD::INT_VMAXSWSX:    return "VEISD::INT_VMAXSWSX";
  case VEISD::INT_VMAXSWZX:    return "VEISD::INT_VMAXSWZX";
  case VEISD::INT_VMINSWSX:    return "VEISD::INT_VMINSWSX";
  case VEISD::INT_VMINSWZX:    return "VEISD::INT_VMINSWZX";
  case VEISD::INT_PVMAXS:      return "VEISD::INT_PVMAXS";
  case VEISD::INT_PVMINS:      return "VEISD::INT_PVMINS";
  case VEISD::INT_VMULUL:      return "VEISD::INT_VMULUL";
  case VEISD::INT_VDIVUL:      return "VEISD::INT_VDIVUL";
  case VEISD::INT_VMULUW:      return "VEISD::INT_VMULUW";
  case VEISD::INT_VDIVUW:      return "VEISD::INT_VDIVUW";
  case VEISD::INT_VMULSWSX:    return "VEISD::INT_VMULSWSX";
  case VEISD::INT_VDIVSWSX:    return "VEISD::INT_VDIVSWSX";
  case VEISD::INT_VMULSWZX:    return "VEISD::INT_VMULSWZX";
  case VEISD::INT_VDIVSWZX:    return "VEISD::INT_VDIVSWZX";
  case VEISD::INT_VMULSL:      return "VEISD::INT_VMULSL";
  case VEISD::INT_VDIVSL:      return "VEISD::INT_VDIVSL";
  case VEISD::INT_VMAXSL:      return "VEISD::INT_VMAXSL";
  case VEISD::INT_VMINSL:      return "VEISD::INT_VMINSL";
  case VEISD::INT_VFADDD:      return "VEISD::INT_VFADDD";
  case VEISD::INT_VFADDS:      return "VEISD::INT_VFADDS";
  case VEISD::INT_VFSUBD:      return "VEISD::INT_VFSUBD";
  case VEISD::INT_VFSUBS:      return "VEISD::INT_VFSUBS";
  case VEISD::INT_VFMULD:      return "VEISD::INT_VFMULD";
  case VEISD::INT_VFMULS:      return "VEISD::INT_VFMULS";
  case VEISD::INT_VFDIVD:      return "VEISD::INT_VFDIVD";
  case VEISD::INT_VFDIVS:      return "VEISD::INT_VFDIVS";
  case VEISD::INT_VFCMPD:      return "VEISD::INT_VFCMPD";
  case VEISD::INT_VFCMPS:      return "VEISD::INT_VFCMPS";
  case VEISD::INT_VFMAXD:      return "VEISD::INT_VFMAXD";
  case VEISD::INT_VFMAXS:      return "VEISD::INT_VFMAXS";
  case VEISD::INT_VFMIND:      return "VEISD::INT_VFMIND";
  case VEISD::INT_VFMINS:      return "VEISD::INT_VFMINS";
  case VEISD::INT_PVFADD:      return "VEISD::INT_PVFADD";
  case VEISD::INT_PVFSUB:      return "VEISD::INT_PVFSUB";
  case VEISD::INT_PVFMUL:      return "VEISD::INT_PVFMUL";
  case VEISD::INT_PVFCMP:      return "VEISD::INT_PVFCMP";
  case VEISD::INT_PVFMAX:      return "VEISD::INT_PVFMAX";
  case VEISD::INT_PVFMIN:      return "VEISD::INT_PVFMIN";
  case VEISD::INT_VFMADD:      return "VEISD::INT_VFMADD";
  case VEISD::INT_VFMADS:      return "VEISD::INT_VFMADS";
  case VEISD::INT_VFMSBD:      return "VEISD::INT_VFMSBD";
  case VEISD::INT_VFMSBS:      return "VEISD::INT_VFMSBS";
  case VEISD::INT_VFNMADD:     return "VEISD::INT_VFNMADD";
  case VEISD::INT_VFNMADS:     return "VEISD::INT_VFNMADS";
  case VEISD::INT_VFNMSBD:     return "VEISD::INT_VFNMSBD";
  case VEISD::INT_VFNMSBS:     return "VEISD::INT_VFNMSBS";
  case VEISD::INT_PVFMAD:      return "VEISD::INT_PVFMAD";
  case VEISD::INT_PVFMSB:      return "VEISD::INT_PVFMSB";
  case VEISD::INT_PVFNMAD:     return "VEISD::INT_PVFNMAD";
  case VEISD::INT_PVFNMSB:     return "VEISD::INT_PVFNMSB";
  case VEISD::INT_VAND:        return "VEISD::INT_VAND";
  case VEISD::INT_VOR:         return "VEISD::INT_VOR";
  case VEISD::INT_VXOR:        return "VEISD::INT_VXOR";
  case VEISD::INT_VEQV:        return "VEISD::INT_VEQV";
  case VEISD::INT_PVAND:       return "VEISD::INT_PVAND";
  case VEISD::INT_PVOR:        return "VEISD::INT_PVOR";
  case VEISD::INT_PVXOR:       return "VEISD::INT_PVXOR";
  case VEISD::INT_PVEQV:       return "VEISD::INT_PVEQV";
  case VEISD::INT_VBRD:        return "VEISD::INT_VBRD";
  case VEISD::INT_VBRDU:       return "VEISD::INT_VBRDU";
  case VEISD::INT_VBRDL:       return "VEISD::INT_VBRDL";
  case VEISD::INT_PVBRD:       return "VEISD::INT_PVBRD";
  case VEISD::INT_VSLL:        return "VEISD::INT_VSLL";
  case VEISD::INT_VSRL:        return "VEISD::INT_VSRL";
  case VEISD::INT_VSLAW:       return "VEISD::INT_VSLAW";
  case VEISD::INT_VSLAL:       return "VEISD::INT_VSLAL";
  case VEISD::INT_VSRAW:       return "VEISD::INT_VSRAW";
  case VEISD::INT_VSRAL:       return "VEISD::INT_VSRAL";
  case VEISD::INT_PVSLL:       return "VEISD::INT_PVSLL";
  case VEISD::INT_PVSRL:       return "VEISD::INT_PVSRL";
  case VEISD::INT_PVSLA:       return "VEISD::INT_PVSLA";
  case VEISD::INT_PVSRA:       return "VEISD::INT_PVSRA";
  case VEISD::INT_VSFA:        return "VEISD::INT_VSFA";
  case VEISD::INT_VMRG:        return "VEISD::INT_VMRG";
  case VEISD::INT_VMRGW:       return "VEISD::INT_VMRGW";
  case VEISD::INT_VCP:         return "VEISD::INT_VCP";
  case VEISD::INT_VEX:         return "VEISD::INT_VEX";
  case VEISD::INT_VFMKL:       return "VEISD::INT_VFMKL";
  case VEISD::INT_VFMKL_M:     return "VEISD::INT_VFMKL_M";
  case VEISD::INT_VFMKW:       return "VEISD::INT_VFMKW";
  case VEISD::INT_VFMKW_M:     return "VEISD::INT_VFMKW_M";
  case VEISD::INT_VFMKD:       return "VEISD::INT_VFMKD";
  case VEISD::INT_VFMKD_M:     return "VEISD::INT_VFMKD_M";
  case VEISD::INT_VFMKS:       return "VEISD::INT_VFMKS";
  case VEISD::INT_VFMKS_M:     return "VEISD::INT_VFMKS_M";
  case VEISD::INT_VFMKAT:      return "VEISD::INT_VFMKAT";
  case VEISD::INT_VFMKAF:      return "VEISD::INT_VFMKAF";
  case VEISD::INT_PVFMKW:      return "VEISD::INT_PVFMKW";
  case VEISD::INT_PVFMKW_M:    return "VEISD::INT_PVFMKW_M";
  case VEISD::INT_PVFMKS:      return "VEISD::INT_PVFMKS";
  case VEISD::INT_PVFMKS_M:    return "VEISD::INT_PVFMKS_M";
  case VEISD::INT_PVFMKAT:     return "VEISD::INT_PVFMKAT";
  case VEISD::INT_PVFMKAF:     return "VEISD::INT_PVFMKAF";
  case VEISD::INT_VGT_M:       return "VEISD::INT_VGT_M";
  case VEISD::INT_VGTU_M:      return "VEISD::INT_VGTU_M";
  case VEISD::INT_VGTLSX_M:    return "VEISD::INT_VGTLSX_M";
  case VEISD::INT_VGTLZX_M:    return "VEISD::INT_VGTLZX_M";
  case VEISD::INT_VSC_M:       return "VEISD::INT_VSC_M";
  case VEISD::INT_VSCU_M:      return "VEISD::INT_VSCU_M";
  case VEISD::INT_VSCL_M:      return "VEISD::INT_VSCL_M";
  case VEISD::INT_EXTMU:       return "VEISD::INT_EXTMU";
  case VEISD::INT_EXTML:       return "VEISD::INT_EXTML";
  case VEISD::INT_INSMU:       return "VEISD::INT_INSMU";
  case VEISD::INT_INSML:       return "VEISD::INT_INSML";
  case VEISD::INT_VLD:         return "VEISD::INT_VLD";
  case VEISD::INT_VLDU:        return "VEISD::INT_VLDU";
  case VEISD::INT_VLDLSX:      return "VEISD::INT_VLDLSX";
  case VEISD::INT_VLDLZX:      return "VEISD::INT_VLDLZX";
  case VEISD::INT_VLD2D:       return "VEISD::INT_VLD2D";
  case VEISD::INT_VLDU2D:      return "VEISD::INT_VLDU2D";
  case VEISD::INT_VLDL2DSX:    return "VEISD::INT_VLDL2DSX";
  case VEISD::INT_VLDL2DZX:    return "VEISD::INT_VLDL2DZX";
  case VEISD::INT_VST:         return "VEISD::INT_VST";
  case VEISD::INT_VSTU:        return "VEISD::INT_VSTU";
  case VEISD::INT_VSTL:        return "VEISD::INT_VSTL";
  case VEISD::INT_VST2D:       return "VEISD::INT_VST2D";
  case VEISD::INT_VSTU2D:      return "VEISD::INT_VSTU2D";
  case VEISD::INT_VSTL2D:      return "VEISD::INT_VSTL2D";
  case VEISD::INT_LVL:         return "VEISD::INT_LVL";
  }
  return nullptr;
}

EVT VETargetLowering::getSetCCResultType(const DataLayout &, LLVMContext &,
                                            EVT VT) const {
  if (!VT.isVector())
    return MVT::i32;
  return VT.changeVectorElementTypeToInteger();
}

/// isMaskedValueZeroForTargetNode - Return true if 'Op & Mask' is known to
/// be zero. Op is expected to be a target specific node. Used by DAG
/// combiner.
void VETargetLowering::computeKnownBitsForTargetNode
                                (const SDValue Op,
                                 KnownBits &Known,
                                 const APInt &DemandedElts,
                                 const SelectionDAG &DAG,
                                 unsigned Depth) const {
  KnownBits Known2;
  Known.resetAll();

  switch (Op.getOpcode()) {
  default: break;
  case VEISD::SELECT_ICC:
  case VEISD::SELECT_XCC:
  case VEISD::SELECT_FCC:
    DAG.computeKnownBits(Op.getOperand(1), Known, Depth+1);
    DAG.computeKnownBits(Op.getOperand(0), Known2, Depth+1);

    // Only known if known in both the LHS and RHS.
    Known.One &= Known2.One;
    Known.Zero &= Known2.Zero;
    break;
  }
}

#if 0
// Look at LHS/RHS/CC and see if they are a lowered setcc instruction.  If so
// set LHS/RHS and VECC to the LHS/RHS of the setcc and VECC to the condition.
static void LookThroughSetCC(SDValue &LHS, SDValue &RHS,
                             ISD::CondCode CC, unsigned &VECC) {
  if (isNullConstant(RHS) &&
      CC == ISD::SETNE &&
      (((LHS.getOpcode() == VEISD::SELECT_ICC ||
         LHS.getOpcode() == VEISD::SELECT_XCC) &&
        LHS.getOperand(3).getOpcode() == VEISD::CMPICC) ||
       (LHS.getOpcode() == VEISD::SELECT_FCC &&
        LHS.getOperand(3).getOpcode() == VEISD::CMPFCC)) &&
      isOneConstant(LHS.getOperand(0)) &&
      isNullConstant(LHS.getOperand(1))) {
    SDValue CMPCC = LHS.getOperand(3);
    VECC = cast<ConstantSDNode>(LHS.getOperand(2))->getZExtValue();
    LHS = CMPCC.getOperand(0);
    RHS = CMPCC.getOperand(1);
  }
}
#endif

// Convert to a target node and set target flags.
SDValue VETargetLowering::withTargetFlags(SDValue Op, unsigned TF,
                                             SelectionDAG &DAG) const {
  if (const GlobalAddressSDNode *GA = dyn_cast<GlobalAddressSDNode>(Op))
    return DAG.getTargetGlobalAddress(GA->getGlobal(),
                                      SDLoc(GA),
                                      GA->getValueType(0),
                                      GA->getOffset(), TF);

  if (const ConstantPoolSDNode *CP = dyn_cast<ConstantPoolSDNode>(Op))
    return DAG.getTargetConstantPool(CP->getConstVal(),
                                     CP->getValueType(0),
                                     CP->getAlignment(),
                                     CP->getOffset(), TF);

  if (const BlockAddressSDNode *BA = dyn_cast<BlockAddressSDNode>(Op))
    return DAG.getTargetBlockAddress(BA->getBlockAddress(),
                                     Op.getValueType(),
                                     0,
                                     TF);

  if (const ExternalSymbolSDNode *ES = dyn_cast<ExternalSymbolSDNode>(Op))
    return DAG.getTargetExternalSymbol(ES->getSymbol(),
                                       ES->getValueType(0), TF);

  llvm_unreachable("Unhandled address SDNode");
}

// Split Op into high and low parts according to HiTF and LoTF.
// Return an ADD node combining the parts.
SDValue VETargetLowering::makeHiLoPair(SDValue Op,
                                          unsigned HiTF, unsigned LoTF,
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
  EVT VT = getPointerTy(DAG.getDataLayout());

  // Handle PIC mode first. SPARC needs a got load for every variable!
  if (isPositionIndependent()) {
    // GLOBAL_BASE_REG codegen'ed with call. Inform MFI that this
    // function has calls.
    MachineFrameInfo &MFI = DAG.getMachineFunction().getFrameInfo();
    MFI.setHasCalls(true);

    if (dyn_cast<ConstantPoolSDNode>(Op) != nullptr ||
        (dyn_cast<GlobalAddressSDNode>(Op) != nullptr &&
         dyn_cast<GlobalAddressSDNode>(Op)->getGlobal()->hasLocalLinkage())) {
      // Create following instructions for local linkage PIC code.
      //     lea %s35, %gotoff_lo(.LCPI0_0)
      //     and %s35, %s35, (32)0
      //     lea.sl %s35, %gotoff_hi(.LCPI0_0)(%s35)
      //     adds.l %s35, %s15, %s35                  ; %s15 is GOT
      // FIXME: use lea.sl %s35, %gotoff_hi(.LCPI0_0)(%s35, %s15)
      SDValue HiLo = makeHiLoPair(Op, VEMCExpr::VK_VE_GOTOFF_HI32,
                                  VEMCExpr::VK_VE_GOTOFF_LO32, DAG);
      SDValue GlobalBase = DAG.getNode(VEISD::GLOBAL_BASE_REG, DL, VT);
      return DAG.getNode(ISD::ADD, DL, VT, GlobalBase, HiLo);
    } else {
      // Create following instructions for not local linkage PIC code.
      //     lea %s35, %got_lo(.LCPI0_0)
      //     and %s35, %s35, (32)0
      //     lea.sl %s35, %got_hi(.LCPI0_0)(%s35)
      //     adds.l %s35, %s15, %s35                  ; %s15 is GOT
      //     ld     %s35, (,%s35)
      // FIXME: use lea.sl %s35, %gotoff_hi(.LCPI0_0)(%s35, %s15)
      SDValue HiLo = makeHiLoPair(Op, VEMCExpr::VK_VE_GOT_HI32,
                                  VEMCExpr::VK_VE_GOT_LO32, DAG);
      SDValue GlobalBase = DAG.getNode(VEISD::GLOBAL_BASE_REG, DL, VT);
      SDValue AbsAddr = DAG.getNode(ISD::ADD, DL, VT, GlobalBase, HiLo);
      return DAG.getLoad(VT, DL, DAG.getEntryNode(), AbsAddr,
                         MachinePointerInfo::getGOT(DAG.getMachineFunction()));
    }
  }

  // This is one of the absolute code models.
  switch(getTargetMachine().getCodeModel()) {
  default:
    llvm_unreachable("Unsupported absolute code model");
  case CodeModel::Small:
  case CodeModel::Medium:
  case CodeModel::Large:
    // abs64.
    return makeHiLoPair(Op, VEMCExpr::VK_VE_HI32,
                        VEMCExpr::VK_VE_LO32, DAG);
  }
}

SDValue VETargetLowering::LowerGlobalAddress(SDValue Op,
                                             SelectionDAG &DAG) const {
  return makeAddress(Op, DAG);
}

SDValue VETargetLowering::LowerConstantPool(SDValue Op,
                                            SelectionDAG &DAG) const {
  return makeAddress(Op, DAG);
}

SDValue VETargetLowering::LowerBlockAddress(SDValue Op,
                                            SelectionDAG &DAG) const {
  return makeAddress(Op, DAG);
}

SDValue VETargetLowering::LowerToTLSGeneralDynamicModel(
  SDValue Op, SelectionDAG &DAG) const {
  SDLoc dl(Op);

  // Generate following code:
  //   t1: ch,glue = callseq_start t0, 0, 0
  //   t2: i64,ch,glue = VEISD::GETTLSADDR t1, label, t1:1
  //   t3: ch,glue = callseq_end t2, 0, 0, t2:2
  //   t4: i64,ch,glue = CopyFromReg t3, Register:i64 $sx0, t3:1
  SDValue Label = withTargetFlags(Op, 0, DAG);
  EVT PtrVT = getPointerTy(DAG.getDataLayout());

  // Lowering the machine isd will make sure everything is in the right
  // location.
  SDValue Chain = DAG.getEntryNode();
  SDVTList NodeTys = DAG.getVTList(MVT::Other, MVT::Glue);
  const uint32_t *Mask = Subtarget->getRegisterInfo()->getCallPreservedMask(
      DAG.getMachineFunction(), CallingConv::C);
  Chain = DAG.getCALLSEQ_START(Chain, 64, 0, dl);
  SDValue Args[] = { Chain, Label, DAG.getRegisterMask(Mask), Chain.getValue(1) };
  Chain = DAG.getNode(VEISD::GETTLSADDR, dl, NodeTys, Args);
  Chain = DAG.getCALLSEQ_END(Chain, DAG.getIntPtrConstant(64, dl, true),
                             DAG.getIntPtrConstant(0, dl, true),
                             Chain.getValue(1), dl);
  Chain = DAG.getCopyFromReg(Chain, dl, VE::SX0, PtrVT, Chain.getValue(1));

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

SDValue VETargetLowering::LowerToTLSLocalExecModel(SDValue Op,
                                                   SelectionDAG &DAG) const {
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
  return DAG.getNode(ISD::ADD, dl, PtrVT,
                     DAG.getRegister(VE::SX14, PtrVT), HiLo);
}

SDValue VETargetLowering::LowerGlobalTLSAddress(SDValue Op,
                                                SelectionDAG &DAG) const {
#if 1
  // Current implementation of nld doesn't allow local exec model code
  // described in VE-tls_v1.1.pdf (*1) as its input.  The nld accept
  // only general dynamic model and optimize it whenever.  So, here
  // we need to generate only general dynamic model code sequence.
  //
  // *1: https://www.nec.com/en/global/prod/hpc/aurora/document/VE-tls_v1.1.pdf
  return LowerToTLSGeneralDynamicModel(Op, DAG);
#else
  // FIXME: Use either general dynamic model or local exec model when
  //        the nld accepts them.
  GlobalAddressSDNode *GA = cast<GlobalAddressSDNode>(Op);
  const GlobalValue *GV = GA->getGlobal();
  TLSModel::Model model = getTargetMachine().getTLSModel(GV);

  if (model == TLSModel::GeneralDynamic || model == TLSModel::LocalDynamic) {
    return LowerToTLSGeneralDynamicModel(Op, DAG);
  } else if (model == TLSModel::InitialExec || model == TLSModel::LocalExec) {
    return LowerToTLSLocalExecModel(Op, DAG);
  }
  llvm_unreachable("bogus TLS model");
#endif
}

SDValue
VETargetLowering::LowerEH_SJLJ_SETJMP(SDValue Op, SelectionDAG &DAG) const {
  SDLoc dl(Op);
  return DAG.getNode(VEISD::EH_SJLJ_SETJMP, dl,
                     DAG.getVTList(MVT::i32, MVT::Other), Op.getOperand(0),
                     Op.getOperand(1));
}

SDValue
VETargetLowering::LowerEH_SJLJ_LONGJMP(SDValue Op, SelectionDAG &DAG) const {
  SDLoc dl(Op);
  return DAG.getNode(VEISD::EH_SJLJ_LONGJMP, dl, MVT::Other, Op.getOperand(0),
                     Op.getOperand(1));
}

SDValue VETargetLowering::LowerEH_SJLJ_SETUP_DISPATCH(SDValue Op,
                                                      SelectionDAG &DAG) const {
  SDLoc dl(Op);
  return DAG.getNode(VEISD::EH_SJLJ_SETUP_DISPATCH, dl, MVT::Other,
                     Op.getOperand(0));
}

static SDValue LowerVASTART(SDValue Op, SelectionDAG &DAG,
                            const VETargetLowering &TLI) {
  MachineFunction &MF = DAG.getMachineFunction();
  VEMachineFunctionInfo *FuncInfo = MF.getInfo<VEMachineFunctionInfo>();
  auto PtrVT = TLI.getPointerTy(DAG.getDataLayout());

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

static SDValue LowerVAARG(SDValue Op, SelectionDAG &DAG) {
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

  if(VT == MVT::f128) {
    // Alignment
    int Align = 16;
    VAList = DAG.getNode(ISD::ADD, DL, PtrVT, VAList,
                         DAG.getConstant(Align - 1, DL, PtrVT));
    VAList = DAG.getNode(ISD::AND, DL, PtrVT, VAList,
                         DAG.getConstant(-Align, DL, PtrVT));
    // Increment the pointer, VAList, by 16 to the next vaarg.
    NextPtr = DAG.getNode(ISD::ADD, DL, PtrVT, VAList,
                          DAG.getIntPtrConstant(16, DL));
  } else {
    // Increment the pointer, VAList, by 8 to the next vaarg.
    NextPtr = DAG.getNode(ISD::ADD, DL, PtrVT, VAList,
                          DAG.getIntPtrConstant(8, DL));
  }

  // Store the incremented VAList to the legalized pointer.
  InChain = DAG.getStore(Chain, DL, NextPtr, VAListPtr,
                         MachinePointerInfo(SV));

  // Load the actual argument out of the pointer VAList.
  // We can't count on greater alignment than the word size.
  return DAG.getLoad(VT, DL, InChain, VAList, MachinePointerInfo(),
                     std::min(PtrVT.getSizeInBits(), VT.getSizeInBits()) / 8);
}

SDValue VETargetLowering::LowerDYNAMIC_STACKALLOC(
    SDValue Op, SelectionDAG &DAG) const {
  // Generate following code.
  //   (void)__llvm_grow_stack(size);
  //   ret = GETSTACKTOP;        // pseudo instruction
  SDLoc dl(Op);

  SDValue Size  = Op.getOperand(1);  // Legalize the size.
  EVT VT = Size->getValueType(0);

  // Prepare arguments
  TargetLowering::ArgListTy Args;
  TargetLowering::ArgListEntry Entry;
  Entry.Node = Size;
  Entry.Ty = Entry.Node.getValueType().getTypeForEVT(*DAG.getContext());
  Args.push_back(Entry);
  Type* RetTy = Type::getVoidTy(*DAG.getContext());

  EVT PtrVT = getPointerTy(DAG.getDataLayout());
  SDValue Callee = DAG.getTargetExternalSymbol("__llvm_grow_stack", PtrVT, 0);

  TargetLowering::CallLoweringInfo CLI(DAG);
  CLI.setDebugLoc(dl)
      .setChain(DAG.getEntryNode())
      .setCallee(CallingConv::VE_LLVM_GROW_STACK, RetTy,
                 Callee, std::move(Args))
      .setDiscardResult(true);
  std::pair<SDValue, SDValue> pair = LowerCallTo(CLI);
  SDValue Chain = pair.second;
  SDValue Value =  DAG.getNode(VEISD::GETSTACKTOP, dl, VT, Chain);
  SDValue Ops[2] = {Value, Chain};
  return DAG.getMergeValues(Ops, dl);
}

static SDValue LowerFRAMEADDR(SDValue Op, SelectionDAG &DAG,
                              const VETargetLowering &TLI,
                              const VESubtarget *Subtarget) {
  SDLoc dl(Op);
  unsigned Depth = cast<ConstantSDNode>(Op.getOperand(0))->getZExtValue();

  MachineFunction &MF = DAG.getMachineFunction();
  MachineFrameInfo &MFI = MF.getFrameInfo();
  MFI.setFrameAddressIsTaken(true);

  EVT PtrVT = TLI.getPointerTy(MF.getDataLayout());

  // Naked functions never have a frame pointer, and so we use r1. For all
  // other functions, this decision must be delayed until during PEI.
  const VERegisterInfo *RegInfo = Subtarget->getRegisterInfo();
  unsigned FrameReg = RegInfo->getFrameRegister(MF);

  SDValue FrameAddr = DAG.getCopyFromReg(DAG.getEntryNode(), dl, FrameReg,
                                         PtrVT);
  while (Depth--)
    FrameAddr = DAG.getLoad(Op.getValueType(), dl, DAG.getEntryNode(),
                            FrameAddr, MachinePointerInfo());
  return FrameAddr;
}

static SDValue LowerRETURNADDR(SDValue Op, SelectionDAG &DAG,
                               const VETargetLowering &TLI,
                               const VESubtarget *Subtarget) {
  MachineFunction &MF = DAG.getMachineFunction();
  MachineFrameInfo &MFI = MF.getFrameInfo();
  MFI.setReturnAddressIsTaken(true);

  if (TLI.verifyReturnAddressArgumentIsConstant(Op, DAG))
    return SDValue();

#if 0
  SDValue RetAddr;
  if (depth == 0) {
    auto PtrVT = TLI.getPointerTy(DAG.getDataLayout());
    unsigned RetReg = MF.addLiveIn(VE::SX10, TLI.getRegClassFor(PtrVT));
    RetAddr = DAG.getCopyFromReg(DAG.getEntryNode(), dl, RetReg, VT);
    return RetAddr;
  }

  // Need frame address to find return address of the caller.
  SDValue FrameAddr = getFRAMEADDR(depth - 1, Op, DAG, Subtarget);

  unsigned Offset = (Subtarget->is64Bit()) ? 120 : 60;
  SDValue Ptr = DAG.getNode(ISD::ADD,
                            dl, VT,
                            FrameAddr,
                            DAG.getIntPtrConstant(Offset, dl));
  RetAddr = DAG.getLoad(VT, dl, DAG.getEntryNode(), Ptr, MachinePointerInfo());

  return RetAddr;
#endif

  SDLoc dl(Op);
  unsigned Depth = cast<ConstantSDNode>(Op.getOperand(0))->getZExtValue();

  auto PtrVT = TLI.getPointerTy(MF.getDataLayout());

  if (Depth > 0) {
    SDValue FrameAddr = LowerFRAMEADDR(Op, DAG, TLI, Subtarget);
    SDValue Offset =
        DAG.getConstant(8, dl, MVT::i64);
    return DAG.getLoad(PtrVT, dl, DAG.getEntryNode(),
                       DAG.getNode(ISD::ADD, dl, PtrVT, FrameAddr, Offset),
                       MachinePointerInfo());
  }

  // Just load the return address off the stack.
  SDValue RetAddrFI = DAG.getFrameIndex(1, PtrVT);
  return DAG.getLoad(PtrVT, dl, DAG.getEntryNode(), RetAddrFI,
                     MachinePointerInfo());
}

// Lower a f128 load into two f64 loads.
static SDValue LowerF128Load(SDValue Op, SelectionDAG &DAG)
{
  SDLoc dl(Op);
  LoadSDNode *LdNode = dyn_cast<LoadSDNode>(Op.getNode());
  assert(LdNode && LdNode->getOffset().isUndef()
         && "Unexpected node type");

  SDValue BasePtr = LdNode->getBasePtr();
  if (dyn_cast<FrameIndexSDNode>(BasePtr.getNode())) {
    // For the case of frame index, expanding it here cause dependency
    // problem.  So, treat it as a legal and expand it in eliminateFrameIndex
    return Op;
  }

  unsigned alignment = LdNode->getAlignment();
  if (alignment > 8)
    alignment = 8;

  SDValue Lo64 =
      DAG.getLoad(MVT::f64, dl, LdNode->getChain(), LdNode->getBasePtr(),
                  LdNode->getPointerInfo(), alignment,
                  LdNode->isVolatile() ? MachineMemOperand::MOVolatile :
                                         MachineMemOperand::MONone);
  EVT addrVT = LdNode->getBasePtr().getValueType();
  SDValue HiPtr = DAG.getNode(ISD::ADD, dl, addrVT,
                              LdNode->getBasePtr(),
                              DAG.getConstant(8, dl, addrVT));
  SDValue Hi64 =
      DAG.getLoad(MVT::f64, dl, LdNode->getChain(), HiPtr,
                  LdNode->getPointerInfo(), alignment,
                  LdNode->isVolatile() ? MachineMemOperand::MOVolatile :
                                         MachineMemOperand::MONone);

  SDValue SubRegEven = DAG.getTargetConstant(VE::sub_even, dl, MVT::i32);
  SDValue SubRegOdd  = DAG.getTargetConstant(VE::sub_odd, dl, MVT::i32);

  // VE stores Hi64 to 8(addr) and Lo64 to 0(addr)
  SDNode *InFP128 = DAG.getMachineNode(TargetOpcode::IMPLICIT_DEF,
                                       dl, MVT::f128);
  InFP128 = DAG.getMachineNode(TargetOpcode::INSERT_SUBREG, dl,
                               MVT::f128,
                               SDValue(InFP128, 0),
                               Hi64,
                               SubRegEven);
  InFP128 = DAG.getMachineNode(TargetOpcode::INSERT_SUBREG, dl,
                               MVT::f128,
                               SDValue(InFP128, 0),
                               Lo64,
                               SubRegOdd);
  SDValue OutChains[2] = { SDValue(Lo64.getNode(), 1),
                           SDValue(Hi64.getNode(), 1) };
  SDValue OutChain = DAG.getNode(ISD::TokenFactor, dl, MVT::Other, OutChains);
  SDValue Ops[2] = {SDValue(InFP128,0), OutChain};
  return DAG.getMergeValues(Ops, dl);
}

static SDValue LowerLOAD(SDValue Op, SelectionDAG &DAG)
{
  LoadSDNode *LdNode = cast<LoadSDNode>(Op.getNode());

  EVT MemVT = LdNode->getMemoryVT();
  if (MemVT == MVT::f128)
    return LowerF128Load(Op, DAG);

  return Op;
}

// Lower a f128 store into two f64 stores.
static SDValue LowerF128Store(SDValue Op, SelectionDAG &DAG) {
  SDLoc dl(Op);
  StoreSDNode *StNode = dyn_cast<StoreSDNode>(Op.getNode());
  assert(StNode && StNode->getOffset().isUndef()
         && "Unexpected node type");

  SDValue BasePtr = StNode->getBasePtr();
  if (dyn_cast<FrameIndexSDNode>(BasePtr.getNode())) {
    // For the case of frame index, expanding it here cause dependency
    // problem.  So, treat it as a legal and expand it in eliminateFrameIndex
    return Op;
  }

  SDValue SubRegEven = DAG.getTargetConstant(VE::sub_even, dl, MVT::i32);
  SDValue SubRegOdd  = DAG.getTargetConstant(VE::sub_odd, dl, MVT::i32);

  SDNode *Hi64 = DAG.getMachineNode(TargetOpcode::EXTRACT_SUBREG,
                                    dl,
                                    MVT::i64,
                                    StNode->getValue(),
                                    SubRegEven);
  SDNode *Lo64 = DAG.getMachineNode(TargetOpcode::EXTRACT_SUBREG,
                                    dl,
                                    MVT::i64,
                                    StNode->getValue(),
                                    SubRegOdd);

  unsigned alignment = StNode->getAlignment();
  if (alignment > 8)
    alignment = 8;

  // VE stores Hi64 to 8(addr) and Lo64 to 0(addr)
  SDValue OutChains[2];
  OutChains[0] =
      DAG.getStore(StNode->getChain(), dl, SDValue(Lo64, 0),
                   StNode->getBasePtr(), MachinePointerInfo(), alignment,
                   StNode->isVolatile() ? MachineMemOperand::MOVolatile :
                                          MachineMemOperand::MONone);
  EVT addrVT = StNode->getBasePtr().getValueType();
  SDValue HiPtr = DAG.getNode(ISD::ADD, dl, addrVT,
                              StNode->getBasePtr(),
                              DAG.getConstant(8, dl, addrVT));
  OutChains[1] =
      DAG.getStore(StNode->getChain(), dl, SDValue(Hi64, 0), HiPtr,
                   MachinePointerInfo(), alignment,
                   StNode->isVolatile() ? MachineMemOperand::MOVolatile :
                                          MachineMemOperand::MONone);
  return DAG.getNode(ISD::TokenFactor, dl, MVT::Other, OutChains);
}

static SDValue LowerSTORE(SDValue Op, SelectionDAG &DAG)
{
  SDLoc dl(Op);
  StoreSDNode *St = cast<StoreSDNode>(Op.getNode());

  EVT MemVT = St->getMemoryVT();
  if (MemVT == MVT::f128)
    return LowerF128Store(Op, DAG);

  return SDValue();
}

// Custom lower UMULO/SMULO for VE. This code is similar to ExpandNode()
// in LegalizeDAG.cpp except the order of arguments to the library function.
static SDValue LowerUMULO_SMULO(SDValue Op, SelectionDAG &DAG,
                                const VETargetLowering &TLI)
{
  unsigned opcode = Op.getOpcode();
  assert((opcode == ISD::UMULO || opcode == ISD::SMULO) && "Invalid Opcode.");

  bool isSigned = (opcode == ISD::SMULO);
  EVT VT = MVT::i64;
  EVT WideVT = MVT::i128;
  SDLoc dl(Op);
  SDValue LHS = Op.getOperand(0);

  if (LHS.getValueType() != VT)
    return Op;

  SDValue ShiftAmt = DAG.getConstant(63, dl, VT);

  SDValue RHS = Op.getOperand(1);
  SDValue HiLHS = DAG.getNode(ISD::SRA, dl, VT, LHS, ShiftAmt);
  SDValue HiRHS = DAG.getNode(ISD::SRA, dl, MVT::i64, RHS, ShiftAmt);
  SDValue Args[] = { LHS, HiLHS, RHS, HiRHS };

  SDValue MulResult = TLI.makeLibCall(DAG,
                                      RTLIB::MUL_I128, WideVT,
                                      Args, isSigned, dl).first;
  SDValue BottomHalf = DAG.getNode(ISD::EXTRACT_ELEMENT, dl, VT,
                                   MulResult, DAG.getIntPtrConstant(0, dl));
  SDValue TopHalf = DAG.getNode(ISD::EXTRACT_ELEMENT, dl, VT,
                                MulResult, DAG.getIntPtrConstant(1, dl));
  if (isSigned) {
    SDValue Tmp1 = DAG.getNode(ISD::SRA, dl, VT, BottomHalf, ShiftAmt);
    TopHalf = DAG.getSetCC(dl, MVT::i32, TopHalf, Tmp1, ISD::SETNE);
  } else {
    TopHalf = DAG.getSetCC(dl, MVT::i32, TopHalf, DAG.getConstant(0, dl, VT),
                           ISD::SETNE);
  }
  // MulResult is a node with an illegal type. Because such things are not
  // generally permitted during this phase of legalization, ensure that
  // nothing is left using the node. The above EXTRACT_ELEMENT nodes should have
  // been folded.
  assert(MulResult->use_empty() && "Illegally typed node still in use!");

  SDValue Ops[2] = { BottomHalf, TopHalf } ;
  return DAG.getMergeValues(Ops, dl);
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
      return SDValue(DAG.getMachineNode(VE::FENCEload, DL, MVT::Other,
                                        Op.getOperand(0)), 0);
    case AtomicOrdering::Release:
      // Generate "fencem 1" as release fence.
      return SDValue(DAG.getMachineNode(VE::FENCEstore, DL, MVT::Other,
                                        Op.getOperand(0)), 0);
    case AtomicOrdering::AcquireRelease:
    case AtomicOrdering::SequentiallyConsistent:
      // Generate "fencem 3" as acq_rel and seq_cst fence.
      // FIXME: "fencem 3" doesn't wait for for PCIe deveices accesses,
      //        so  seq_cst may require more instruction for them.
      return SDValue(DAG.getMachineNode(VE::FENCEloadstore, DL, MVT::Other,
                                        Op.getOperand(0)), 0);
    }
  }

  // MEMBARRIER is a compiler barrier; it codegens to a no-op.
  return DAG.getNode(VEISD::MEMBARRIER, DL, MVT::Other, Op.getOperand(0));
}

static Instruction* callIntrinsic(IRBuilder<> &Builder, Intrinsic::ID Id) {
  Module *M = Builder.GetInsertBlock()->getParent()->getParent();
  Function *Func = Intrinsic::getDeclaration(M, Id);
  return Builder.CreateCall(Func, {});
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
    return callIntrinsic(Builder, Intrinsic::ve_fencem1);
  case AtomicOrdering::SequentiallyConsistent:
    if (!Inst->hasAtomicStore())
      return nullptr; // Nothing to do
    return callIntrinsic(Builder, Intrinsic::ve_fencem3);
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
    return callIntrinsic(Builder, Intrinsic::ve_fencem2);
  case AtomicOrdering::SequentiallyConsistent:
    return callIntrinsic(Builder, Intrinsic::ve_fencem3);
  }
  llvm_unreachable("Unknown fence ordering in emitTrailingFence");
}

static SDValue LowerIntrinsicWithMask(SDValue Intrin, SelectionDAG& DAG, uint64_t Opc)
{
    SDLoc dl(Intrin);
    SmallVector<SDValue, 8> Ops;

    // Op0 is intrinsic number and ignored
    for (unsigned i = 1; i < Intrin.getNumOperands(); ++i) {
        SDValue Op = Intrin.getOperand(i);
        if (Op.getValueType() == MVT::v4i64 || Op.getValueType() == MVT::v8i64) {
            MVT BitcastVT 
                = MVT::getVectorVT(MVT::i1, Op.getValueType().getSizeInBits());
            SDValue Bitcast = DAG.getBitcast(BitcastVT, Op);
            Ops.push_back(Bitcast);
        } else {
            Ops.push_back(Op);
        }
    }

    return SDValue(DAG.getMachineNode(Opc, dl, Intrin.getValueType(), Ops), 0);
}

SDValue VETargetLowering::LowerINTRINSIC_WO_CHAIN(SDValue Op,
                                                  SelectionDAG &DAG) const {
  SDLoc dl(Op);
  unsigned IntNo = cast<ConstantSDNode>(Op.getOperand(0))->getZExtValue();
  const IntrinsicData* IntrData = getIntrinsicWithoutChain(IntNo);
  if (IntrData) {
    switch (IntrData->Type) {
    default:
      llvm_unreachable("Unknown intrinsic data type");
      break;
    case OP_MMXX: {
      // Load mask intrinsics
      //   Input:
      //     (v4i64 (int_ve_lvm_mmss (v4i64 %vm), (i64 %index), (i64 %val)))
      //   Output:
      //     (v4i64 (bitcast (v256i1 (LVMr
      //         (v256i1 (bitcast %vm)), %index, %val))))
      SDValue Mask = Op.getOperand(1);
      MVT BitcastVT = MVT::getVectorVT(
        MVT::i1, Mask.getValueType().getSizeInBits());
      SDValue Bitcast = DAG.getBitcast(BitcastVT, Mask);
      SDValue Load = DAG.getNode(IntrData->Opc0, dl, BitcastVT, Bitcast,
                                 Op.getOperand(2), Op.getOperand(3));
      return DAG.getBitcast(Op.getValueType(), Load);
    }
    case OP_XMX: {
      // Store mask intrinsics
      //   Input:
      //     (i64 (int_ve_svm_sms (v4i64 %vm), (i64 %index)))
      //   Output:
      //     (i64 (SVMr
      //         (v256i1 (bitcast %vm)), %index))
      SDValue Mask = Op.getOperand(1);
      MVT BitcastVT = MVT::getVectorVT(
        MVT::i1, Mask.getValueType().getSizeInBits());
      SDValue Bitcast = DAG.getBitcast(BitcastVT, Mask);
      return DAG.getNode(IntrData->Opc0, dl, Op.getValueType(), Bitcast,
                         Op.getOperand(2));
    }
    case OP_M: {
      // 0-operand intrinsics
      //   Input:
      //     (v4i64 (int_ve_vfmkat_m))
      //   Output:
      //     (v4i64 (bitcast (v256i1 (VFMKAT))))
      MVT BitcastVT = MVT::getVectorVT(
        MVT::i1, Op.getValueType().getSizeInBits());
      SDValue Res =  DAG.getNode(IntrData->Opc0, dl, BitcastVT);
      return DAG.getBitcast(Op.getValueType(), Res);
    }
    case OP_MM: {
      // 1-operand mask intrinsics
      //   Input:
      //     (v4i64 (int_ve_negm_mmm (v4i64 %vm)))
      //   Output:
      //     (v4i64 (bitcast (v256i1 (NEGM
      //         (v256i1 (bitcast %vm1))))))
      SDValue Mask = Op.getOperand(1);
      MVT BitcastVT1 = MVT::getVectorVT(
        MVT::i1, Mask.getValueType().getSizeInBits());
      SDValue Bitcast = DAG.getBitcast(BitcastVT1, Mask);
      // Get bitmask for each operand since for the case.
      //   e.g. (v256i1 (extract_VM512u (v512i1 %vm)))
      MVT BitcastVT0 = MVT::getVectorVT(
        MVT::i1, Op.getValueType().getSizeInBits());
      SDValue Res =  DAG.getNode(IntrData->Opc0, dl, BitcastVT0, Bitcast);
      return DAG.getBitcast(Op.getValueType(), Res);
    }
    case OP_XM: {
      // 1-operand mask intrinsics
      //   Input:
      //     (i64 (int_ve_pcvm_mmm (v4i64 %vm)))
      //   Output:
      //     (i64 (PCVM (v256i1 (bitcast %vm1))))))
      SDValue Mask = Op.getOperand(1);
      MVT BitcastVT = MVT::getVectorVT(
        MVT::i1, Mask.getValueType().getSizeInBits());
      SDValue Bitcast = DAG.getBitcast(BitcastVT, Mask);
      return DAG.getNode(IntrData->Opc0, dl, Op.getValueType(), Bitcast);
    }
    case OP_MMM: {
      // 2-operand mask intrinsics
      //   Input:
      //     (v4i64 (int_ve_andm_mmm (v4i64 %vm1), (v4i64 %vm2)))
      //   Output:
      //     (v4i64 (bitcast (v256i1 (ANDM
      //         (v256i1 (bitcast %vm1)), (v256i1 (bitcast %vm2))))))
      SDValue Mask1 = Op.getOperand(1);
      MVT BitcastVT1 = MVT::getVectorVT(
        MVT::i1, Mask1.getValueType().getSizeInBits());
      SDValue Bitcast1 = DAG.getBitcast(BitcastVT1, Mask1);
      // Get bitmask for each operand since for the case.
      //   e.g. (v512i1 (insert_VM512u (v512i1 %vm1), (v256i1 %vm2)))
      SDValue Mask2 = Op.getOperand(2);
      MVT BitcastVT2 = MVT::getVectorVT(
        MVT::i1, Mask2.getValueType().getSizeInBits());
      SDValue Bitcast2 = DAG.getBitcast(BitcastVT2, Mask2);
      MVT BitcastVT0 = MVT::getVectorVT(
        MVT::i1, Op.getValueType().getSizeInBits());
      SDValue Res =  DAG.getNode(IntrData->Opc0, dl, BitcastVT0,
                                 Bitcast1, Bitcast2);
      return DAG.getBitcast(Op.getValueType(), Res);
    }
    case OP_XXMX: {
      // 1-operand with mask and base register intrinsics
      //   Input:
      //     (v256i64 (int_ve_vbrd_vsmv_i64 (i64 %sy), (v4i64 %vm),
      //                                    (v256i64 %base)))
      //   Output:
      //     (v256i64 (VBRD %sy, (v256i1 (bitcast %vm)), %base))
      SDValue Mask = Op.getOperand(2);
      MVT BitcastVT = MVT::getVectorVT(
        MVT::i1, Mask.getValueType().getSizeInBits());
      SDValue Bitcast = DAG.getBitcast(BitcastVT, Mask);
      return DAG.getNode(IntrData->Opc0, dl, Op.getValueType(),
                         Op.getOperand(1), Bitcast, Op.getOperand(3));
    }
    case OP_XXXM: {
      // 2-operand vector calculation with mask and base vector intrinsics
      //   Input:
      //     (v256f64 (int_ve_vaddul_vvvmv
      //                  (v256f64 %v1), (v256f64 %v2),
      //                  (v4i64 %vm)))
      //   Output:
      //     (v256f64 (VADDlvm %v1, %v2,
      //                  (v256i1 (bitcast %vm))))
      SDValue Mask = Op.getOperand(3);
      MVT BitcastVT = MVT::getVectorVT(
        MVT::i1, Mask.getValueType().getSizeInBits());
      SDValue Bitcast = DAG.getBitcast(BitcastVT, Mask);
      return DAG.getNode(IntrData->Opc0, dl, Op.getValueType(),
                         Op.getOperand(1), Op.getOperand(2),
                         Bitcast);
    }
    case OP_XXXMX: {
      // 2-operand vector calculation with mask and base vector intrinsics
      //   Input:
      //     (v256f64 (int_ve_vaddul_vvvmv
      //                  (v256f64 %v1), (v256f64 %v2),
      //                  (v4i64 %vm), (v256f64 %vd)))
      //   Output:
      //     (v256f64 (VADDlvm %v1, %v2,
      //                  (v256i1 (bitcast %vm)), %vd))
      SDValue Mask = Op.getOperand(3);
      MVT BitcastVT = MVT::getVectorVT(
        MVT::i1, Mask.getValueType().getSizeInBits());
      SDValue Bitcast = DAG.getBitcast(BitcastVT, Mask);
      return DAG.getNode(IntrData->Opc0, dl, Op.getValueType(),
                         Op.getOperand(1), Op.getOperand(2),
                         Bitcast, Op.getOperand(4));
    }
    case OP_MXX: {
      // 2-operand intrinsics
      //   Input:
      //     (v4i64 (int_ve_vfmkl_mcvm (i64 %cf), (v256i64 %vz)))
      //   Output:
      //     (v4i64 (bitcast (v256i1 (VFMKL %cf, %vz))))
      MVT BitcastVT = MVT::getVectorVT(
        MVT::i1, Op.getValueType().getSizeInBits());
      SDValue Res =  DAG.getNode(IntrData->Opc0, dl, BitcastVT,
                                 Op.getOperand(1), Op.getOperand(2));
      return DAG.getBitcast(Op.getValueType(), Res);
    }
    case OP_MXXM: {
      // 2-operand and base mask intrinsics
      //   Input:
      //     (v4i64 (int_ve_vfmkl_mcvm (i64 %cf), (v256i64 %vz), (v4i64 %vm)))
      //   Output:
      //     (v4i64 (bitcast (v256i1 (VFMKL
      //         %cf, %vz, (v256i1 (bitcast %vm1))))))
      SDValue Mask = Op.getOperand(3);
      MVT BitcastVT = MVT::getVectorVT(
        MVT::i1, Mask.getValueType().getSizeInBits());
      SDValue Bitcast = DAG.getBitcast(BitcastVT, Mask);
      SDValue Res =  DAG.getNode(IntrData->Opc0, dl, BitcastVT,
                                 Op.getOperand(1), Op.getOperand(2),
                                 Bitcast);
      return DAG.getBitcast(Op.getValueType(), Res);
    }
    case OP_XXXXMX: {
      // 3-operand vector calculation with mask and base vector intrinsics
      //   Input:
      //     (v256f64 (int_ve_vfmadd_vsvvmv
      //                  (v256f64 %v1), (v256f64 %v2), (v256f64 %v3),
      //                  (v4i64 %vm), (v256f64 %vd)))
      //   Output:
      //     (v256f64 (VFMADD %v1, %v2, %v3,
      //                  (v256i1 (bitcast %vm)), %vd))
      SDValue Mask = Op.getOperand(4);
      MVT BitcastVT = MVT::getVectorVT(
        MVT::i1, Mask.getValueType().getSizeInBits());
      SDValue Bitcast = DAG.getBitcast(BitcastVT, Mask);
      return DAG.getNode(IntrData->Opc0, dl, Op.getValueType(),
                         Op.getOperand(1), Op.getOperand(2), Op.getOperand(3),
                         Bitcast, Op.getOperand(5));
    }
    }
  }
  switch (IntNo) {
  default: return SDValue();    // Don't custom lower most intrinsics.
  case Intrinsic::thread_pointer: {
    report_fatal_error("Intrinsic::thread_point is not implemented yet");
#if 0
    EVT PtrVT = getPointerTy(DAG.getDataLayout());
    return DAG.getRegister(SP::G7, PtrVT);
#endif
  }
  case Intrinsic::eh_sjlj_lsda: {
    MachineFunction &MF = DAG.getMachineFunction();
    const TargetLowering &TLI = DAG.getTargetLoweringInfo();
    MVT PtrVT = TLI.getPointerTy(DAG.getDataLayout());
    const VETargetMachine *TM =
      static_cast<const VETargetMachine*>(&DAG.getTarget());

    // Creat GCC_except_tableXX string.  The real symbol for that will be
    // generated in EHStreamer::emitExceptionTable() later.  So, we just
    // borrow it's name here.
    TM->getStrList()->push_back(std::string(
      (Twine("GCC_except_table") + Twine(MF.getFunctionNumber())).str()));
    SDValue Addr = DAG.getTargetExternalSymbol(TM->getStrList()->back().c_str(),
                                               PtrVT, 0);
    if (isPositionIndependent()) {
      Addr = makeHiLoPair(Addr, VEMCExpr::VK_VE_GOTOFF_HI32,
                          VEMCExpr::VK_VE_GOTOFF_LO32, DAG);
      SDValue GlobalBase = DAG.getNode(VEISD::GLOBAL_BASE_REG, dl, PtrVT);
      return DAG.getNode(ISD::ADD, dl, PtrVT, GlobalBase, Addr);
    } else {
      return makeHiLoPair(Addr, VEMCExpr::VK_VE_HI32,
                          VEMCExpr::VK_VE_LO32, DAG);
    }
  }
  case Intrinsic::ve_vfdivsA_vvv: {
/*
    600000000b98:       00 00 01 05     vrcp.s          %v5,%v1,%vm1
    600000000ba0:       00 00 80 3f     lea.sl          %s0,0x3f800000(0,0)
    600000000ba8:       05 01 00 04     vfnmsb.s        %v4,%s0,%v1,%v5,%vm1
    600000000bb0:       04 05 05 03     vfmad.s         %v3,%v5,%v5,%v4,%vm1
    600000000bb8:       00 03 00 02     vfmul.s         %v2,%v0,%v3,%vm1
    600000000bc0:       01 02 00 04     vfnmsb.s        %v4,%v0,%v2,%v1,%vm1
    600000000bc8:       04 05 02 02     vfmad.s         %v2,%v2,%v5,%v4,%vm1
    600000000bd0:       01 02 00 00     vfnmsb.s        %v0,%v0,%v2,%v1,%vm1
    600000000bd8:       00 03 02 00     vfmad.s         %v0,%v2,%v3,%v0,%vm1
    600000000be0:       00 00 00 00     b.l.t           0x0(,%s10)
 */
    // Op0: function id, Op1: V64, Op1: V64
    SDLoc dl(Op);

    EVT VT = Op.getValueType();
    SDValue S0;
    SDValue V0, V1, V2, V3, V4, V5;
    SDValue SubRegF32 = DAG.getTargetConstant(VE::sub_f32, dl, MVT::i32);

    V0 = Op.getOperand(1);
    V1 = Op.getOperand(2);

    V5 = SDValue(DAG.getMachineNode(VE::VRCPsv, dl, VT, V1), 0);  // V5 = 1.0f / V1
    S0 = SDValue(DAG.getMachineNode(VE::LEASLzzi, dl, MVT::i64,
                                    DAG.getTargetConstant(0x3f800000, dl, MVT::i64)), 0); // S0 = 1.0f
    S0 = SDValue(DAG.getMachineNode(TargetOpcode::EXTRACT_SUBREG, dl, MVT::f32,
                                    S0, SubRegF32), 0);
    V4 = SDValue(DAG.getMachineNode(VE::VFNMSBsr, dl, VT, S0, V1, V5), 0); // V4 = -(V1*V5-S0)
    V3 = SDValue(DAG.getMachineNode(VE::VFMADsv,  dl, VT, V5, V5, V4), 0); // V3 = V5*V4+V5
    V2 = SDValue(DAG.getMachineNode(VE::VFMPsv,   dl, VT, V0, V3), 0);     // V1 = V0*V3
    V4 = SDValue(DAG.getMachineNode(VE::VFNMSBsv, dl, VT, V0, V2, V1), 0); // V4 = -(V2*V1-V0)
    V2 = SDValue(DAG.getMachineNode(VE::VFMADsv,  dl, VT, V2, V5, V4), 0); // V2 = V5*V4+V2
    V0 = SDValue(DAG.getMachineNode(VE::VFNMSBsv, dl, VT, V0, V2, V1), 0); // v3 = -(V2*V1-S0)
    V0 = SDValue(DAG.getMachineNode(VE::VFMADsv,  dl, VT, V2, V3, V0), 0); // V0 = V3*V0+V2
    return V0;
  }
#if 1
  case Intrinsic::ve_pvfdivA_vvv: {
    // Op0: function id, Op1: V64, Op1: V64
    SDLoc dl(Op);

    EVT VT = Op.getValueType();
    SDValue S0, S1;
    SDValue V0, V1, V2, V3, V4, V5;

    V0 = Op.getOperand(1);
    V1 = Op.getOperand(2);

    V5 = SDValue(DAG.getMachineNode(VE::VRCPpv, dl, VT, V1), 0);  // V5 = 1.0f / V1
    // S0 = 1.0f|1.0f
    S1 = SDValue(DAG.getMachineNode(VE::LEAzzi, dl, MVT::i64,
                                    DAG.getTargetConstant(0x3f800000, dl, MVT::i64)), 0);
    S0 = SDValue(DAG.getMachineNode(VE::LEASLrzi, dl, MVT::i64,
                                    S1,
                                    DAG.getTargetConstant(0x3f800000, dl, MVT::i64)), 0);
    V4 = SDValue(DAG.getMachineNode(VE::VFNMSBpr, dl, VT, S0, V1, V5), 0); // V4 = -(V1*V5-S0)
    V3 = SDValue(DAG.getMachineNode(VE::VFMADpv,  dl, VT, V5, V5, V4), 0); // V3 = V5*V4+V5
    V2 = SDValue(DAG.getMachineNode(VE::VFMPpv,   dl, VT, V0, V3), 0);     // V1 = V0*V3
    V4 = SDValue(DAG.getMachineNode(VE::VFNMSBpv, dl, VT, V0, V2, V1), 0); // V4 = -(V2*V1-V0)
    V2 = SDValue(DAG.getMachineNode(VE::VFMADpv,  dl, VT, V2, V5, V4), 0); // V2 = V5*V4+V2
    V0 = SDValue(DAG.getMachineNode(VE::VFNMSBpv, dl, VT, V0, V2, V1), 0); // v3 = -(V2*V1-S0)
    V0 = SDValue(DAG.getMachineNode(VE::VFMADpv,  dl, VT, V2, V3, V0), 0); // V0 = V3*V0+V2
    return V0;
  }
#endif
  case Intrinsic::ve_vfdivsA_vsv: {
/*
600000000c68:       00 00 00 04     vrcp.s  %v4,%v0,%vm1
600000000c70:       00 00 80 3f     lea.sl  %s1,0x3f800000(0,0)
600000000c78:       04 00 00 02     vfnmsb.s        %v2,%s1,%v0,%v4,%vm1
600000000c80:       02 04 04 02     vfmad.s %v2,%v4,%v4,%v2,%vm1
600000000c88:       00 02 00 01     vfmul.s %v1,%s0,%v2,%vm1
600000000c90:       00 01 00 03     vfnmsb.s        %v3,%s0,%v1,%v0,%vm1
600000000c98:       03 04 01 01     vfmad.s %v1,%v1,%v4,%v3,%vm1
600000000ca0:       00 01 00 03     vfnmsb.s        %v3,%s0,%v1,%v0,%vm1
600000000ca8:       03 02 01 00     vfmad.s %v0,%v1,%v2,%v3,%vm1
600000000cb0:       00 00 00 00     b.l.t   0x0(,%s10)
 */
    // Op0: function id, Op1: f32, Op1: V64  (f32/V64)
    SDLoc dl(Op);

    EVT VT = Op.getValueType();
    SDValue S0, S1;
    SDValue V0, V1, V2, V3, V4;
    SDValue SubRegF32 = DAG.getTargetConstant(VE::sub_f32, dl, MVT::i32);

    S0 = Op.getOperand(1);
    V0 = Op.getOperand(2);

    V4 = SDValue(DAG.getMachineNode(VE::VRCPsv, dl, VT, V0), 0);  // V4 = 1.0f / V0
    S1 = SDValue(DAG.getMachineNode(VE::LEASLzzi, dl, MVT::i64,
                                    DAG.getTargetConstant(0x3f800000, dl, MVT::i64)), 0); // S1 = 1.0f
    S1 = SDValue(DAG.getMachineNode(TargetOpcode::EXTRACT_SUBREG, dl, MVT::f32,
                                    S1, SubRegF32), 0);
    V2 = SDValue(DAG.getMachineNode(VE::VFNMSBsr, dl, VT, S1, V0, V4), 0); // V2 = -(V0*V4-S1)
    V2 = SDValue(DAG.getMachineNode(VE::VFMADsv,  dl, VT, V4, V4, V2), 0); // V2 = V4*V2+V4
    V1 = SDValue(DAG.getMachineNode(VE::VFMPsr,   dl, VT, S0, V2), 0);     // V1 = S0*V2
    V3 = SDValue(DAG.getMachineNode(VE::VFNMSBsr, dl, VT, S0, V1, V0), 0); // V3 = -(V1*V0-S0)
    V1 = SDValue(DAG.getMachineNode(VE::VFMADsv,  dl, VT, V1, V4, V3), 0); // V1 = V4*V3+V1
    V3 = SDValue(DAG.getMachineNode(VE::VFNMSBsr, dl, VT, S0, V1, V0), 0); // v3 = -(V1*V0-S0)
    V0 = SDValue(DAG.getMachineNode(VE::VFMADsv,  dl, VT, V1, V2, V3), 0); // V0 = V2*V3+V1
    return V0;
  }
  case Intrinsic::ve_vec_call: {
    // Op0: function id, Op1: input V64, Op2: address
    SDLoc dl(Op);
    SDValue Chain = DAG.getEntryNode();
    SDValue InGlue;

    // create copy from input to V0
    Chain = DAG.getCopyToReg(Chain, dl, VE::V0, Op.getOperand(1), InGlue);
    InGlue = Chain.getValue(1);

    // create CALL node
    SmallVector<SDValue, 8> Ops;
    Ops.push_back(Chain);
    Ops.push_back(Op.getOperand(2));
    Ops.push_back(DAG.getRegister(VE::V0, MVT::v256f64));

    // preserved registers
    const VERegisterInfo *TRI = Subtarget->getRegisterInfo();
    const uint32_t *Mask = TRI->getCallPreservedMask(DAG.getMachineFunction(),
        CallingConv::VE_VEC_EXPF);
    assert(Mask && "Missing call preserved mask for calling convention");
    Ops.push_back(DAG.getRegisterMask(Mask));

    if (InGlue.getNode())
        Ops.push_back(InGlue);
    SDVTList NodeTys = DAG.getVTList(MVT::Other, MVT::Glue);
    Chain = DAG.getNode(VEISD::CALL, dl, NodeTys, Ops);
    InGlue = Chain.getValue(1);

    // create copy from V0 to output
    SDValue RV = DAG.getCopyFromReg(Chain, dl, VE::V0, MVT::v256f64, InGlue);
    return RV;
  }
#include "VEISelLoweringIntrinsic.inc"
  }
}

SDValue VETargetLowering::LowerINTRINSIC_W_CHAIN(SDValue Op,
                                                 SelectionDAG &DAG) const {
  SDLoc dl(Op);
  unsigned IntNo = cast<ConstantSDNode>(Op.getOperand(1))->getZExtValue();
  const IntrinsicData* IntrData = getIntrinsicWithChain(IntNo);
  if (IntrData) {
    switch (IntrData->Type) {
    default:
      llvm_unreachable("Unknown intrinsic data type");
      break;
    case GATHER_M: {
      // Vector gather with mask intrinsics
      //   Input:
      //     (v256i64 (int_ve_vgt_vvm (v256i64 %vy), (v4i64 %vm)))
      //   Output:
      //     (v256i64 (VGT %vy, (v256i1 (bitcast %vm))))
      SDValue Chain = Op.getOperand(0);
      SDValue Mask = Op.getOperand(3);
      MVT BitcastVT = MVT::getVectorVT(
        MVT::i1, Mask.getValueType().getSizeInBits());
      SDValue Bitcast = DAG.getBitcast(BitcastVT, Mask);
      SDVTList VTs = DAG.getVTList(Op.getValueType(), MVT::Other);
      return DAG.getNode(IntrData->Opc0, dl, VTs,
                         Chain, Op.getOperand(2), Bitcast);
    }
    case VLD: {
      // Vector load with vector length register
      //   Input:
      //     (v256i64 (int_ve_vld_vss (i64 %sy), (i64 %sz)))
      //   Output:
      //     (v256i64 (VLD %sy, %sz, %vl))
      SDValue Chain = Op.getOperand(0);
      MachineFunction &MF = DAG.getMachineFunction();
      unsigned VLReg = Subtarget->getInstrInfo()->getVectorLengthReg(&MF);
      SDValue VL = DAG.getCopyFromReg(Chain, dl, VLReg, MVT::i32);
      Chain = VL.getValue(1);
      SDVTList VTs = DAG.getVTList(Op.getValueType(), MVT::Other);
      return DAG.getNode(IntrData->Opc0, dl, VTs,
                         Chain, Op.getOperand(2), Op.getOperand(3), VL);
    }
    }
  }
  switch (IntNo) {
  default: return SDValue();    // Don't custom lower most intrinsics.
  }
}

SDValue VETargetLowering::LowerINTRINSIC_VOID(SDValue Op,
                                              SelectionDAG &DAG) const {
  SDLoc dl(Op);
  unsigned IntNo = cast<ConstantSDNode>(Op.getOperand(1))->getZExtValue();
  const IntrinsicData* IntrData = getIntrinsicVoid(IntNo);
  if (IntrData) {
    switch (IntrData->Type) {
    default:
      llvm_unreachable("Unknown intrinsic data type");
      break;
    case LVL: {
      // 1-operand load VL.  Intrinsic is void, but we need to copy value
      // to Vector Length reigster.  So, we make a copy instruction here.
      // A copy instruction to VL is converted to LVL instruction later.
      //   Input:
      //     (int_ve_lvl (i32 val))
      //   Output:
      //     (i32 (copy %val))
      SDValue Chain = Op.getOperand(0);
      SDValue Inp = Op.getOperand(2);
      MachineFunction &MF = DAG.getMachineFunction();

      // We re-use single virtual register multiple times.
      unsigned VLReg = Subtarget->getInstrInfo()->getVectorLengthReg(&MF);
      Chain = DAG.getCopyToReg(Chain, dl, VLReg, Inp);
      return Chain;
    }
    case SCATTER_M: {
      // Vector scatter with mask intrinsics
      //   Input:
      //     (int_ve_vsc_vvm (v256i64 %vx), (v256i64 %vy), (v4i64 %vm))
      //   Output:
      //     (VSC %vx, %vy, (v256i1 (bitcast %vm)))
      SDValue Chain = Op.getOperand(0);
      SDValue Mask = Op.getOperand(4);
      MVT BitcastVT = MVT::getVectorVT(
        MVT::i1, Mask.getValueType().getSizeInBits());
      SDValue Bitcast = DAG.getBitcast(BitcastVT, Mask);
      return DAG.getNode(IntrData->Opc0, dl, MVT::Other,
                         Chain, Op.getOperand(2), Op.getOperand(3), Bitcast);
    }
    case VST: {
      // Vector store with vector length register
      //   Input:
      //     (int_ve_vst_vss (v256i64 %vx), (i64 %sy), (i64 %sz)))
      //   Output:
      //     (VST %vx, %sy, %sz, %vl))
      SDValue Chain = Op.getOperand(0);
      MachineFunction &MF = DAG.getMachineFunction();
      unsigned VLReg = Subtarget->getInstrInfo()->getVectorLengthReg(&MF);
      SDValue VL = DAG.getCopyFromReg(Chain, dl, VLReg, MVT::i32);
      Chain = VL.getValue(1);
      return DAG.getNode(IntrData->Opc0, dl, MVT::Other,
                         Chain, Op.getOperand(2), Op.getOperand(3),
                         Op.getOperand(4), VL);
    }
    }
  }
  switch (IntNo) {
  default: return SDValue();    // Don't custom lower most intrinsics.
  }
}

// Should we expand the build vector with shuffles?
bool VETargetLowering::shouldExpandBuildVectorWithShuffles(
  EVT VT, unsigned DefinedValues) const {
  // Not use VECTOR_SHUFFLE to expand BUILD_VECTOR since it cause
  // an expansion loop.
  return false;
}

SDValue VETargetLowering::LowerINSERT_VECTOR_ELT(SDValue Op,
                                                 SelectionDAG &DAG) const {
  assert(Op.getOpcode() == ISD::INSERT_VECTOR_ELT && "Unknown opcode!");
  EVT VT = Op.getOperand(0).getValueType();

  // Insertion/extraction are legal for unpacked V64 types.
  if (VT == MVT::v256i32 || VT == MVT::v256f32 ||
      VT == MVT::v256i64 || VT == MVT::v256f64)
    return Op;

  // Special treatements for packed V64 types.
  if (VT == MVT::v512i32 || VT == MVT::v512f32) {
    // FIXME: needs special treatements for packed V64 types,
    //        but those are not implemented yet.
    //
    // Example of codes:
    //   %packed_v = extractelt %vr, %idx / 2
    //   %packed_v &= 0xffffffff << ((%idx / 2 + 1) * 32)
    //   %packed_v |= %val << (%idx / 2 * 32)
    //   %vr = insertelt %vr, %packed_v, %idx
    //
    // For now, we ask llvm to expand to more generic slower code by default.
    return SDValue();
  }

  // May need to support v4i64 and v8i64, but just ask llvm to expand them.
  return SDValue();
}

SDValue VETargetLowering::LowerSHUFFLE_VECTOR(SDValue Op, SelectionDAG &DAG) const {
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
      SDValue elem = DAG.getNode(ISD::EXTRACT_VECTOR_ELT, dl, ElementType, {secondVec, DAG.getConstant(index, dl, EVT::getIntegerVT(*DAG.getContext(), 64))});
      return DAG.getNode(VEISD::VEC_BROADCAST, dl, Op.getSimpleValueType(), elem);
    } else {
      SDValue elem = DAG.getNode(ISD::EXTRACT_VECTOR_ELT, dl, ElementType, {firstVec, DAG.getConstant(index, dl, EVT::getIntegerVT(*DAG.getContext(), 64))});
      return DAG.getNode(VEISD::VEC_BROADCAST, dl, Op.getSimpleValueType(), elem);
    }
  }

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
    } else { //mask_value >= 256
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

  SDValue firstrotated = firstrot % 256 != 0 ? DAG.getNode(VEISD::VEC_VMV, dl, firstVec.getSimpleValueType(), {DAG.getConstant(firstrot % 256, dl, EVT::getIntegerVT(*DAG.getContext(), 32)), firstVec}) : firstVec;
  SDValue secondrotated = secondrot % 256 != 0 ? DAG.getNode(VEISD::VEC_VMV, dl, secondVec.getSimpleValueType(), {DAG.getConstant(secondrot % 256, dl, EVT::getIntegerVT(*DAG.getContext(), 32)), secondVec}) : secondVec;

  EVT i64 = EVT::getIntegerVT(*DAG.getContext(), 64);
  EVT v256i1 = EVT::getVectorVT(*DAG.getContext(), EVT::getIntegerVT(*DAG.getContext(), 1), 256);

  //TODO: use LVM and SVM instructions!
  int block = firstsecond / 64;
  int secondblock = firstsecond % 64;

  SDValue Mask = DAG.getUNDEF(v256i1);

  for (int i = 0; i < block; i++) {
    //set blocks to all 0s
    SDValue mask = inv_order ? DAG.getConstant(0xffffffffffffffff, dl, i64) : DAG.getConstant(0, dl, i64);
    SDValue index = DAG.getConstant(i, dl, i64);
    Mask = DAG.getNode(VEISD::INT_LVM, dl, v256i1, {Mask, index, mask});
  }

  SDValue mask = DAG.getConstant(0xffffffffffffffff, dl, i64);
  if (!inv_order)
    mask = DAG.getNode(ISD::SRL, dl, i64, {mask, DAG.getConstant(secondblock, dl, i64)});
  else
    mask = DAG.getNode(ISD::SHL, dl, i64, {mask, DAG.getConstant(64 - secondblock, dl, i64)});
  Mask = DAG.getNode(VEISD::INT_LVM, dl, v256i1, {Mask, DAG.getConstant(block, dl, i64), mask});

  for (int i = block + 1; i < 4; i++) {
    //set blocks to all 1s
    SDValue mask = inv_order ? DAG.getConstant(0, dl, i64) : DAG.getConstant(0xffffffffffffffff, dl, i64);
    SDValue index = DAG.getConstant(i, dl, i64);
    Mask = DAG.getNode(VEISD::INT_LVM, dl, v256i1, {Mask, index, mask});
  }

  SDValue returnValue = DAG.getNode(VEISD::INT_VMRG, dl, Op.getSimpleValueType(), {firstrotated, secondrotated, Mask});
  return returnValue;
}

SDValue VETargetLowering::LowerEXTRACT_VECTOR_ELT(SDValue Op,
                                                  SelectionDAG &DAG) const {
  assert(Op.getOpcode() == ISD::EXTRACT_VECTOR_ELT && "Unknown opcode!");
  EVT VT = Op.getOperand(0).getValueType();

  // Insertion/extraction are legal for unpacked V64 types.
  if (VT == MVT::v256i32 || VT == MVT::v256f32 ||
      VT == MVT::v256i64 || VT == MVT::v256f64)
    return Op;

  // Special treatements for packed V64 types.
  if (VT == MVT::v512i32 || VT == MVT::v512f32) {
    // FIXME: needs special treatements for packed V64 types,
    //        but those are not implemented yet.
    //
    // Example of codes:
    //   %packed_v = extractelt %vr, %idx / 2
    //   %res = %packed_v & 0xffffffff << (%idx / 2 * 32)
    //
    // For now, we ask llvm to expand to more generic slower code by default.
    return SDValue();
  }

  // May need to support v4i64 and v8i64, but just ask llvm to expand them.
  return SDValue();
}

SDValue VETargetLowering::
LowerOperation(SDValue Op, SelectionDAG &DAG) const {

#if 0
  bool hasHardQuad = Subtarget->hasHardQuad();
  bool isV9        = Subtarget->isV9();
#endif

  switch (Op.getOpcode()) {
  default: llvm_unreachable("Should not custom lower this!");

  case ISD::RETURNADDR:         return LowerRETURNADDR(Op, DAG, *this,
                                                       Subtarget);
  case ISD::FRAMEADDR:          return LowerFRAMEADDR(Op, DAG, *this,
                                                      Subtarget);
  case ISD::GlobalTLSAddress:   return LowerGlobalTLSAddress(Op, DAG);
  case ISD::GlobalAddress:      return LowerGlobalAddress(Op, DAG);
  case ISD::BlockAddress:       return LowerBlockAddress(Op, DAG);
  case ISD::ConstantPool:       return LowerConstantPool(Op, DAG);
  case ISD::EH_SJLJ_SETJMP:     return LowerEH_SJLJ_SETJMP(Op, DAG);
  case ISD::EH_SJLJ_LONGJMP:    return LowerEH_SJLJ_LONGJMP(Op, DAG);
  case ISD::EH_SJLJ_SETUP_DISPATCH: return LowerEH_SJLJ_SETUP_DISPATCH(Op, DAG);
  case ISD::VASTART:            return LowerVASTART(Op, DAG, *this);
  case ISD::VAARG:              return LowerVAARG(Op, DAG);
  case ISD::DYNAMIC_STACKALLOC: return LowerDYNAMIC_STACKALLOC(Op, DAG);

  case ISD::LOAD:               return LowerLOAD(Op, DAG);
  case ISD::STORE:              return LowerSTORE(Op, DAG);
  case ISD::UMULO:
  case ISD::SMULO:              return LowerUMULO_SMULO(Op, DAG, *this);
  case ISD::ATOMIC_FENCE:       return LowerATOMIC_FENCE(Op, DAG);
  case ISD::INTRINSIC_VOID:     return LowerINTRINSIC_VOID(Op, DAG);
  case ISD::INTRINSIC_W_CHAIN:  return LowerINTRINSIC_W_CHAIN(Op, DAG);
  case ISD::INTRINSIC_WO_CHAIN: return LowerINTRINSIC_WO_CHAIN(Op, DAG);
  case ISD::BUILD_VECTOR:       return LowerBUILD_VECTOR(Op, DAG);
  case ISD::INSERT_VECTOR_ELT:  return LowerINSERT_VECTOR_ELT(Op, DAG);
  case ISD::EXTRACT_VECTOR_ELT: return LowerEXTRACT_VECTOR_ELT(Op, DAG);

  case ISD::BITCAST:            return LowerBitcast(Op, DAG);

  case ISD::VECTOR_SHUFFLE:     return LowerSHUFFLE_VECTOR(Op, DAG);

  case ISD::MSCATTER:
  case ISD::MGATHER:            return LowerMGATHER_MSCATTER(Op, DAG);

  case ISD::MLOAD:              return LowerMLOAD(Op, DAG);
  }
}

/// Return the entry encoding for a jump table in the
/// current function.  The returned value is a member of the
/// MachineJumpTableInfo::JTEntryKind enum.
unsigned VETargetLowering::getJumpTableEncoding() const {
  // VE doesn't support GOT32 style of labels in the current version of nas.
  // So, we generates a following entry for each jump table.
  //    .4bytes  .LBB0_2-<function name>
  if (isPositionIndependent())
    return MachineJumpTableInfo::EK_Custom32;

  // Otherwise, use the normal jump table encoding heuristics.
  return TargetLowering::getJumpTableEncoding();
}

const MCExpr *
VETargetLowering::LowerCustomJumpTableEntry(const MachineJumpTableInfo *MJTI,
                                            const MachineBasicBlock *MBB,
                                            unsigned uid,MCContext &Ctx) const{
  assert(isPositionIndependent());
  // VE doesn't support GOT32 style of labels in the current version of nas.
  // So, we generates a following entry for each jump table.
  //    .4bytes  .LBB0_2-<function name>
  auto Value = MCSymbolRefExpr::create(MBB->getSymbol(), Ctx);
  MCSymbol *Sym = Ctx.getOrCreateSymbol(MBB->getParent()->getName().data());
  auto Base = MCSymbolRefExpr::create(Sym, Ctx);
  return MCBinaryExpr::createSub(Value, Base, Ctx);
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
  unsigned Tmp1 = MRI->createVirtualRegister(TRC);
  unsigned Tmp2 = MRI->createVirtualRegister(TRC);
  unsigned VR = MRI->createVirtualRegister(TRC);
  unsigned Op = VE::STSri;

  if (isPositionIndependent()) {
    // Create following instructions for local linkage PIC code.
    //     lea %Tmp1, DispatchBB@gotoff_lo
    //     and %Tmp2, %Tmp1, (32)0
    //     lea.sl %Tmp3, DispatchBB@gotoff_hi(%Tmp2)
    //     adds.l %VR, %s15, %Tmp3                  ; %s15 is GOT
    // FIXME: use lea.sl %BReg, .LJTI0_0@gotoff_hi(%Tmp2, %s15)
    unsigned Tmp3 = MRI->createVirtualRegister(&VE::I64RegClass);
    BuildMI(*MBB, MI, DL, TII->get(VE::LEAzzi), Tmp1)
        .addMBB(DispatchBB, VEMCExpr::VK_VE_GOTOFF_LO32);
    BuildMI(*MBB, MI, DL, TII->get(VE::ANDrm0), Tmp2)
        .addReg(Tmp1).addImm(32);
    BuildMI(*MBB, MI, DL, TII->get(VE::LEASLrzi), Tmp3)
        .addReg(Tmp2).addMBB(DispatchBB, VEMCExpr::VK_VE_GOTOFF_HI32);
    BuildMI(*MBB, MI, DL, TII->get(VE::ADXrr), VR)
        .addReg(VE::SX15).addReg(Tmp3);
  } else {
    // lea     %Tmp1, DispatchBB@lo
    // and     %Tmp2, %Tmp1, (32)0
    // lea.sl  %VR, DispatchBB@hi(%Tmp2)
    BuildMI(*MBB, MI, DL, TII->get(VE::LEAzzi), Tmp1)
        .addMBB(DispatchBB, VEMCExpr::VK_VE_LO32);
    BuildMI(*MBB, MI, DL, TII->get(VE::ANDrm0), Tmp2)
        .addReg(Tmp1).addImm(32);
    BuildMI(*MBB, MI, DL, TII->get(VE::LEASLrzi), VR)
        .addReg(Tmp2).addMBB(DispatchBB, VEMCExpr::VK_VE_HI32);
  }

  MachineInstrBuilder MIB = BuildMI(*MBB, MI, DL, TII->get(Op));
  addFrameReference(MIB, FI, 56 + 16);
  MIB.addReg(VR);
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
#if 0
  if (RI.hasBasePointer(*MF)) {
    const bool FPIs64Bit =
        Subtarget.isTarget64BitLP64() || Subtarget.isTargetNaCl64();
    X86MachineFunctionInfo *MFI = MF->getInfo<X86MachineFunctionInfo>();
    MFI->setRestoreBasePointer(MF);

    unsigned FP = RI.getFrameRegister(*MF);
    unsigned BP = RI.getBaseRegister();
    unsigned Op = FPIs64Bit ? X86::MOV64rm : X86::MOV32rm;
    addRegOffset(BuildMI(DispatchBB, DL, TII->get(Op), BP), FP, true,
                 MFI->getRestoreBasePointerOffset())
        .addRegMask(RI.getNoPreservedMask());
  } else {
    BuildMI(DispatchBB, DL, TII->get(X86::NOOP))
        .addRegMask(RI.getNoPreservedMask());
  }
#endif
  BuildMI(DispatchBB, DL, TII->get(VE::NOP))
      .addRegMask(RI.getNoPreservedMask());

  if (isPositionIndependent()) {
    // Force to generate GETGOT, since current implementation doesn't recover
    // GOT register correctly.
    BuildMI(DispatchBB, DL, TII->get(VE::GETGOT), VE::SX15);
  }

  // IReg is used as an index in a memory operand and therefore can't be SP
  unsigned IReg = MRI->createVirtualRegister(&VE::I64RegClass);
  addFrameReference(BuildMI(DispatchBB, DL, TII->get(VE::LDLUri), IReg), FI, 8);
  if (LPadList.size() < 63) {
    BuildMI(DispatchBB, DL, TII->get(VE::BCRLir)).addImm(VECC::CC_ILE)
        .addImm(LPadList.size()).addReg(IReg).addMBB(TrapBB);
  } else {
    assert(LPadList.size() <= 0x7FFFFFFF && "Too large Landing Pad!");
    unsigned TmpReg = MRI->createVirtualRegister(&VE::I64RegClass);
    BuildMI(DispatchBB, DL, TII->get(VE::LEAzzi), TmpReg)
        .addImm(LPadList.size());
    BuildMI(DispatchBB, DL, TII->get(VE::BCRLrr)).addImm(VECC::CC_ILE)
        .addReg(TmpReg).addReg(IReg).addMBB(TrapBB);
  }

  unsigned BReg = MRI->createVirtualRegister(&VE::I64RegClass);

  unsigned Tmp1 = MRI->createVirtualRegister(&VE::I64RegClass);
  unsigned Tmp2 = MRI->createVirtualRegister(&VE::I64RegClass);

  if (isPositionIndependent()) {
    // Create following instructions for local linkage PIC code.
    //     lea %Tmp1, .LJTI0_0@gotoff_lo
    //     and %Tmp2, %Tmp1, (32)0
    //     lea.sl %Tmp3, .LJTI0_0@gotoff_hi(%Tmp2)
    //     adds.l %BReg, %s15, %Tmp3                  ; %s15 is GOT
    // FIXME: use lea.sl %BReg, .LJTI0_0@gotoff_hi(%Tmp2, %s15)
    unsigned Tmp3 = MRI->createVirtualRegister(&VE::I64RegClass);
    BuildMI(DispContBB, DL, TII->get(VE::LEAzzi), Tmp1)
        .addJumpTableIndex(MJTI, VEMCExpr::VK_VE_GOTOFF_LO32);
    BuildMI(DispContBB, DL, TII->get(VE::ANDrm0), Tmp2)
        .addReg(Tmp1).addImm(32);
    BuildMI(DispContBB, DL, TII->get(VE::LEASLrzi), Tmp3)
        .addReg(Tmp2).addJumpTableIndex(MJTI, VEMCExpr::VK_VE_GOTOFF_HI32);
    BuildMI(DispContBB, DL, TII->get(VE::ADXrr), BReg)
        .addReg(VE::SX15).addReg(Tmp3);
  } else {
    // lea     %Tmp1, .LJTI0_0@lo
    // and     %Tmp2, %Tmp1, (32)0
    // lea.sl  %BReg, .LJTI0_0@hi(%Tmp2)
    BuildMI(DispContBB, DL, TII->get(VE::LEAzzi), Tmp1)
        .addJumpTableIndex(MJTI, VEMCExpr::VK_VE_LO32);
    BuildMI(DispContBB, DL, TII->get(VE::ANDrm0), Tmp2)
        .addReg(Tmp1).addImm(32);
    BuildMI(DispContBB, DL, TII->get(VE::LEASLrzi), BReg)
        .addReg(Tmp2).addJumpTableIndex(MJTI, VEMCExpr::VK_VE_HI32);
  }

  switch (JTE) {
  case MachineJumpTableInfo::EK_BlockAddress: {
    // Generate simple block address code for no-PIC model.

    unsigned TReg = MRI->createVirtualRegister(&VE::I64RegClass);
    unsigned Tmp1 = MRI->createVirtualRegister(&VE::I64RegClass);
    unsigned Tmp2 = MRI->createVirtualRegister(&VE::I64RegClass);

    // sll     Tmp1, IReg, 3
    BuildMI(DispContBB, DL, TII->get(VE::SLLri), Tmp1)
        .addReg(IReg)
        .addImm(3);
    // FIXME: combine these add and lds into "lds     TReg, *(BReg, Tmp1)"
    // adds.l  Tmp2, BReg, Tmp1
    BuildMI(DispContBB, DL, TII->get(VE::ADXrr), Tmp2)
        .addReg(Tmp1)
        .addReg(BReg);
    // lds     TReg, *(Tmp2)
    BuildMI(DispContBB, DL, TII->get(VE::LDSri), TReg)
        .addReg(Tmp2)
        .addImm(0);

    // jmpq *(TReg)
    BuildMI(DispContBB, DL, TII->get(VE::BAri))
        .addReg(TReg)
        .addImm(0);
    break;
  }
#if 0
  case MachineJumpTableInfo::EK_LabelDifference32: {
    // This code is what regular architecture does, but nas doesn't generate
    // LabelDifference32 correctly, so doesn't use this atm.

    // for the case of PIC, generates these codes
    unsigned OReg = MRI->createVirtualRegister(&VE::I64RegClass);
    unsigned TReg = MRI->createVirtualRegister(&VE::I64RegClass);

    unsigned Tmp1 = MRI->createVirtualRegister(&VE::I64RegClass);
    unsigned Tmp2 = MRI->createVirtualRegister(&VE::I64RegClass);

    // sll     Tmp1, IReg, 2
    BuildMI(DispContBB, DL, TII->get(VE::SLLri), Tmp1)
        .addReg(IReg)
        .addImm(2);
    // FIXME: combine these add and ldl into "ldl     OReg, *(BReg, Tmp1)"
    // add     Tmp2, BReg, Tmp1
    BuildMI(DispContBB, DL, TII->get(VE::ADXrr), Tmp2)
        .addReg(Tmp1)
        .addReg(BReg);
    // ldl.sx  OReg, *(Tmp2)
    BuildMI(DispContBB, DL, TII->get(VE::LDLri), OReg)
        .addReg(Tmp2)
        .addImm(0);
    // adds.l  TReg, BReg, OReg
    BuildMI(DispContBB, DL, TII->get(VE::ADXrr), TReg)
        .addReg(OReg)
        .addReg(BReg);
    // jmpq *(TReg)
    BuildMI(DispContBB, DL, TII->get(VE::BAri))
        .addReg(TReg)
        .addImm(0);
    break;
  }
#endif
  case MachineJumpTableInfo::EK_Custom32: {
    // for the case of PIC, generates these codes

    assert(isPositionIndependent());
    unsigned OReg = MRI->createVirtualRegister(&VE::I64RegClass);
    unsigned TReg = MRI->createVirtualRegister(&VE::I64RegClass);

    unsigned Tmp1 = MRI->createVirtualRegister(&VE::I64RegClass);
    unsigned Tmp2 = MRI->createVirtualRegister(&VE::I64RegClass);

    // sll     Tmp1, IReg, 2
    BuildMI(DispContBB, DL, TII->get(VE::SLLri), Tmp1)
        .addReg(IReg)
        .addImm(2);
    // FIXME: combine these add and ldl into "ldl.zx   OReg, *(BReg, Tmp1)"
    // add     Tmp2, BReg, Tmp1
    BuildMI(DispContBB, DL, TII->get(VE::ADXrr), Tmp2)
        .addReg(Tmp1)
        .addReg(BReg);
    // ldl.zx  OReg, *(Tmp2)
    BuildMI(DispContBB, DL, TII->get(VE::LDLUri), OReg)
        .addReg(Tmp2)
        .addImm(0);

    // Create following instructions for local linkage PIC code.
    //     lea %Tmp3, fun@gotoff_lo
    //     and %Tmp4, %Tmp3, (32)0
    //     lea.sl %Tmp5, fun@gotoff_hi(%Tmp4)
    //     adds.l %BReg2, %s15, %Tmp5                  ; %s15 is GOT
    // FIXME: use lea.sl %BReg2, fun@gotoff_hi(%Tmp4, %s15)
    unsigned Tmp3 = MRI->createVirtualRegister(&VE::I64RegClass);
    unsigned Tmp4 = MRI->createVirtualRegister(&VE::I64RegClass);
    unsigned Tmp5 = MRI->createVirtualRegister(&VE::I64RegClass);
    unsigned BReg2 = MRI->createVirtualRegister(&VE::I64RegClass);
    const char* FunName = DispContBB->getParent()->getName().data();
    BuildMI(DispContBB, DL, TII->get(VE::LEAzzi), Tmp3)
        .addExternalSymbol(FunName, VEMCExpr::VK_VE_GOTOFF_LO32);
    BuildMI(DispContBB, DL, TII->get(VE::ANDrm0), Tmp4)
        .addReg(Tmp3).addImm(32);
    BuildMI(DispContBB, DL, TII->get(VE::LEASLrzi), Tmp5)
        .addReg(Tmp4).addExternalSymbol(FunName, VEMCExpr::VK_VE_GOTOFF_HI32);
    BuildMI(DispContBB, DL, TII->get(VE::ADXrr), BReg2)
        .addReg(VE::SX15).addReg(Tmp5);

    // adds.l  TReg, BReg2, OReg
    BuildMI(DispContBB, DL, TII->get(VE::ADXrr), TReg)
        .addReg(OReg)
        .addReg(BReg2);
    // jmpq *(TReg)
    BuildMI(DispContBB, DL, TII->get(VE::BAri))
        .addReg(TReg)
        .addImm(0);
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

      DenseMap<unsigned, bool> DefRegs;
      for (auto &MOp : II.operands())
        if (MOp.isReg())
          DefRegs[MOp.getReg()] = true;

      MachineInstrBuilder MIB(*MF, &II);
      for (unsigned RI = 0; SavedRegs[RI]; ++RI) {
        unsigned Reg = SavedRegs[RI];
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
  default: llvm_unreachable("Unknown Custom Instruction!");
  case VE::EH_SjLj_Setup_Dispatch:
    return EmitSjLjDispatchBlock(MI, BB);
  }
}

#if 0
MachineBasicBlock *
VETargetLowering::emitEHSjLjLongJmp(MachineInstr &MI,
                                       MachineBasicBlock *MBB) const {
  DebugLoc DL = MI.getDebugLoc();
  const TargetInstrInfo *TII = Subtarget->getInstrInfo();

  MachineFunction *MF = MBB->getParent();
  MachineRegisterInfo &MRI = MF->getRegInfo();
  MachineInstrBuilder MIB;

  MVT PVT = getPointerTy(MF->getDataLayout());
  unsigned RegSize = PVT.getStoreSize();
  assert(PVT == MVT::i32 && "Invalid Pointer Size!");

  unsigned Buf = MI.getOperand(0).getReg();
  unsigned JmpLoc = MRI.createVirtualRegister(&SP::I64RegClass);

  // TO DO: If we do 64-bit handling, this perhaps should be FLUSHW, not TA 3
  MIB = BuildMI(*MBB, MI, DL, TII->get(SP::TRAPri), SP::G0).addImm(3).addImm(SPCC::ICC_A);

  // Instruction to restore FP
  const unsigned FP  = SP::I6;
  MIB = BuildMI(*MBB, MI, DL, TII->get(SP::LDri))
            .addReg(FP)
            .addReg(Buf)
            .addImm(0);

  // Instruction to load jmp location
  MIB = BuildMI(*MBB, MI, DL, TII->get(SP::LDri))
            .addReg(JmpLoc, RegState::Define)
            .addReg(Buf)
            .addImm(RegSize);

  // Instruction to restore SP
  const unsigned SP  = VE::SX11;
  MIB = BuildMI(*MBB, MI, DL, TII->get(SP::LDri))
            .addReg(SP)
            .addReg(Buf)
            .addImm(2 * RegSize);

  // Instruction to restore I7
  MIB = BuildMI(*MBB, MI, DL, TII->get(SP::LDri))
            .addReg(SP::I7)
            .addReg(Buf, RegState::Kill)
            .addImm(3 * RegSize);

  // Jump to JmpLoc
  BuildMI(*MBB, MI, DL, TII->get(SP::JMPLrr)).addReg(SP::G0).addReg(JmpLoc, RegState::Kill).addReg(SP::G0);

  MI.eraseFromParent();
  return MBB;
}

MachineBasicBlock *
VETargetLowering::emitEHSjLjSetJmp(MachineInstr &MI,
                                      MachineBasicBlock *MBB) const {
  DebugLoc DL = MI.getDebugLoc();
  const TargetInstrInfo *TII = Subtarget->getInstrInfo();
  const TargetRegisterInfo *TRI = Subtarget->getRegisterInfo();

  MachineFunction *MF = MBB->getParent();
  MachineRegisterInfo &MRI = MF->getRegInfo();
  MachineInstrBuilder MIB;

  MVT PVT = getPointerTy(MF->getDataLayout());
  unsigned RegSize = PVT.getStoreSize();
  assert(PVT == MVT::i32 && "Invalid Pointer Size!");

  unsigned DstReg = MI.getOperand(0).getReg();
  const TargetRegisterClass *RC = MRI.getRegClass(DstReg);
  assert(TRI->isTypeLegalForClass(*RC, MVT::i32) && "Invalid destination!");
  (void)TRI;
  unsigned mainDstReg = MRI.createVirtualRegister(RC);
  unsigned restoreDstReg = MRI.createVirtualRegister(RC);

  // For v = setjmp(buf), we generate
  //
  // thisMBB:
  //  buf[0] = FP
  //  buf[RegSize] = restoreMBB <-- takes address of restoreMBB
  //  buf[RegSize * 2] = O6
  //  buf[RegSize * 3] = I7
  //  Ensure restoreMBB remains in the relocations list (done using a bn instruction)
  //  b mainMBB
  //
  // mainMBB:
  //  v_main = 0
  //  b sinkMBB
  //
  // restoreMBB:
  //  v_restore = 1
  //  --fall through--
  //
  // sinkMBB:
  //  v = phi(main, restore)

  const BasicBlock *BB = MBB->getBasicBlock();
  MachineFunction::iterator It = ++MBB->getIterator();
  MachineBasicBlock *thisMBB = MBB;
  MachineBasicBlock *mainMBB = MF->CreateMachineBasicBlock(BB);
  MachineBasicBlock *restoreMBB = MF->CreateMachineBasicBlock(BB);
  MachineBasicBlock *sinkMBB = MF->CreateMachineBasicBlock(BB);

  MF->insert(It, mainMBB);
  MF->insert(It, restoreMBB);
  MF->insert(It, sinkMBB);
  restoreMBB->setHasAddressTaken();

  // Transfer the remainder of BB and its successor edges to sinkMBB.
  sinkMBB->splice(sinkMBB->begin(), MBB,
                  std::next(MachineBasicBlock::iterator(MI)),
                  MBB->end());
  sinkMBB->transferSuccessorsAndUpdatePHIs(MBB);

  unsigned LabelReg = MRI.createVirtualRegister(&SP::I64RegClass);
  unsigned LabelReg2 = MRI.createVirtualRegister(&SP::I64RegClass);
  unsigned BufReg = MI.getOperand(1).getReg();

  // Instruction to store FP
  const unsigned FP  = SP::I6;
  MIB = BuildMI(thisMBB, DL, TII->get(SP::STri))
            .addReg(BufReg)
            .addImm(0)
            .addReg(FP);

  // Instructions to store jmp location
  MIB = BuildMI(thisMBB, DL, TII->get(SP::SETHIi))
            .addReg(LabelReg, RegState::Define)
            .addMBB(restoreMBB, VEMCExpr::VK_VE_HI32);

  MIB = BuildMI(thisMBB, DL, TII->get(SP::ORri))
            .addReg(LabelReg2, RegState::Define)
            .addReg(LabelReg, RegState::Kill)
            .addMBB(restoreMBB, VEMCExpr::VK_VE_LO32);

  MIB = BuildMI(thisMBB, DL, TII->get(SP::STri))
            .addReg(BufReg)
            .addImm(RegSize)
            .addReg(LabelReg2, RegState::Kill);

  // Instruction to store SP
  const unsigned SP  = VE::SX11;
  MIB = BuildMI(thisMBB, DL, TII->get(SP::STri))
            .addReg(BufReg)
            .addImm(2 * RegSize)
            .addReg(SP);

  // Instruction to store I7
  MIB = BuildMI(thisMBB, DL, TII->get(SP::STri))
            .addReg(BufReg)
            .addImm(3 * RegSize)
            .addReg(SP::I7);


  // FIX ME: This next instruction ensures that the restoreMBB block address remains
  // valid through optimization passes and serves no other purpose. The ICC_N ensures
  // that the branch is never taken. This commented-out code here was an alternative
  // attempt to achieve this which brought myriad problems.
  //MIB = BuildMI(thisMBB, DL, TII->get(SP::EH_SjLj_Setup)).addMBB(restoreMBB, VEMCExpr::VK_VE_None);
  MIB = BuildMI(thisMBB, DL, TII->get(SP::BCOND))
              .addMBB(restoreMBB)
              .addImm(SPCC::ICC_N);

  MIB = BuildMI(thisMBB, DL, TII->get(SP::BCOND))
              .addMBB(mainMBB)
              .addImm(SPCC::ICC_A);

  thisMBB->addSuccessor(mainMBB);
  thisMBB->addSuccessor(restoreMBB);


  // mainMBB:
  MIB = BuildMI(mainMBB, DL, TII->get(SP::ORrr))
             .addReg(mainDstReg, RegState::Define)
             .addReg(SP::G0)
             .addReg(SP::G0);
  MIB = BuildMI(mainMBB, DL, TII->get(SP::BCOND)).addMBB(sinkMBB).addImm(SPCC::ICC_A);

  mainMBB->addSuccessor(sinkMBB);


  // restoreMBB:
  MIB = BuildMI(restoreMBB, DL, TII->get(SP::ORri))
              .addReg(restoreDstReg, RegState::Define)
              .addReg(SP::G0)
              .addImm(1);
  //MIB = BuildMI(restoreMBB, DL, TII->get(SP::BCOND)).addMBB(sinkMBB).addImm(SPCC::ICC_A);
  restoreMBB->addSuccessor(sinkMBB);

  // sinkMBB:
  MIB = BuildMI(*sinkMBB, sinkMBB->begin(), DL,
                TII->get(SP::PHI), DstReg)
             .addReg(mainDstReg).addMBB(mainMBB)
             .addReg(restoreDstReg).addMBB(restoreMBB);

  MI.eraseFromParent();
  return sinkMBB;
}
#endif

//===----------------------------------------------------------------------===//
//                         VE Inline Assembly Support
//===----------------------------------------------------------------------===//

/// getConstraintType - Given a constraint letter, return the type of
/// constraint it is for this target.
VETargetLowering::ConstraintType
VETargetLowering::getConstraintType(StringRef Constraint) const {
  if (Constraint.size() == 1) {
    switch (Constraint[0]) {
    default:  break;
    case 'r':
    case 'f':
    case 'e':
      return C_RegisterClass;
    case 'I': // SIMM13
      return C_Other;
    }
  }

  return TargetLowering::getConstraintType(Constraint);
}

TargetLowering::ConstraintWeight VETargetLowering::
getSingleConstraintMatchWeight(AsmOperandInfo &info,
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
void VETargetLowering::
LowerAsmOperandForConstraint(SDValue Op,
                             std::string &Constraint,
                             std::vector<SDValue> &Ops,
                             SelectionDAG &DAG) const {
  SDValue Result(nullptr, 0);

  // Only support length 1 constraints for now.
  if (Constraint.length() > 1)
    return;

  char ConstraintLetter = Constraint[0];
  switch (ConstraintLetter) {
  default: break;
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
  if (Constraint.size() == 1) {
    switch (Constraint[0]) {
    case 'r':
      return std::make_pair(0U, &VE::I64RegClass);
    case 'f':
      if (VT == MVT::f32 || VT == MVT::f64)
        return std::make_pair(0U, &VE::I64RegClass);
      else if (VT == MVT::f128)
        return std::make_pair(0U, &VE::F128RegClass);
      llvm_unreachable("Unknown ValueType for f-register-type!");
      break;
    case 'e':
      if (VT == MVT::f32 || VT == MVT::f64)
        return std::make_pair(0U, &VE::I64RegClass);
      else if (VT == MVT::f128)
        return std::make_pair(0U, &VE::F128RegClass);
      llvm_unreachable("Unknown ValueType for e-register-type!");
      break;
    }
  } else if (!Constraint.empty() && Constraint.size() <= 5
              && Constraint[0] == '{' && *(Constraint.end()-1) == '}') {
    // constraint = '{r<d>}'
    // Remove the braces from around the name.
    StringRef name(Constraint.data()+1, Constraint.size()-2);
    // Handle register aliases:
    //       r0-r7   -> g0-g7
    //       r8-r15  -> o0-o7
    //       r16-r23 -> l0-l7
    //       r24-r31 -> i0-i7
    uint64_t intVal = 0;
    if (name.substr(0, 1).equals("r")
        && !name.substr(1).getAsInteger(10, intVal) && intVal <= 31) {
      const char regTypes[] = { 'g', 'o', 'l', 'i' };
      char regType = regTypes[intVal/8];
      char regIdx = '0' + (intVal % 8);
      char tmp[] = { '{', regType, regIdx, '}', 0 };
      std::string newConstraint = std::string(tmp);
      return TargetLowering::getRegForInlineAsmConstraint(TRI, newConstraint,
                                                          VT);
    }
  }

  return TargetLowering::getRegForInlineAsmConstraint(TRI, Constraint, VT);
}

bool
VETargetLowering::isOffsetFoldingLegal(const GlobalAddressSDNode *GA) const {
  // The VE target isn't yet aware of offsets.
  return false;
}

void VETargetLowering::ReplaceNodeResults(SDNode *N,
                                             SmallVectorImpl<SDValue>& Results,
                                             SelectionDAG &DAG) const {

  SDLoc dl(N);

  switch (N->getOpcode()) {
  case ISD::BUILD_VECTOR:
  case ISD::INSERT_VECTOR_ELT:
  case ISD::EXTRACT_VECTOR_ELT:
  case ISD::VECTOR_SHUFFLE:
  case ISD::MSCATTER:
  case ISD::MGATHER:
  case ISD::MLOAD:
    // ask llvm to expand vector related instructions if those are not legal.
    return;
  default:
    LLVM_DEBUG(N->dumpr(&DAG));
    llvm_unreachable("Do not know how to custom type legalize this operation!");
  }
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
