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
#include "VECustomDAG.h"
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
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/IntrinsicsVE.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/KnownBits.h"

#define DEBUG_TYPE "ve-lower"

using namespace llvm;

// VE has no masked VLD. Ignore the mask, keep the AVL.
static cl::opt<bool> SplitCallRegs(
    "ve-split-call-regs", cl::init(true),
    cl::desc("Split overpacked registers and packed mask regs in calls and "
             "call arguments to assist pack/unpack folding."),
    cl::Hidden);

//===----------------------------------------------------------------------===//
// Calling Convention Implementation
//===----------------------------------------------------------------------===//

#include "VEGenCallingConv.inc"

CCAssignFn *getReturnCC(CallingConv::ID CallConv) {
  switch (CallConv) {
  default:
    return RetCC_VE_C;
  case CallingConv::Fast:
    return RetCC_VE_Fast;
  }
}

CCAssignFn *getParamCC(CallingConv::ID CallConv, bool IsVarArg) {
  if (IsVarArg)
    return CC_VE2;
  switch (CallConv) {
  default:
    return CC_VE_C;
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
                                   MVT::v256f32, MVT::v512f32, MVT::v256f64,
                                   MVT::v512f64, MVT::v512i64};

static const MVT AllMaskVTs[] = {MVT::v256i1, MVT::v512i1};

static const MVT PackedVectorVTs[] = {MVT::v512i32, MVT::v512f32, MVT::v512f64,
                                      MVT::v512i64};

void VETargetLowering::initRegisterClasses() {
  // Set up the register classes.
  addRegisterClass(MVT::i32, &VE::I32RegClass);
  addRegisterClass(MVT::i64, &VE::I64RegClass);
  addRegisterClass(MVT::f32, &VE::F32RegClass);
  addRegisterClass(MVT::f64, &VE::I64RegClass);
  addRegisterClass(MVT::f128, &VE::F128RegClass);

  if (Subtarget->enableVPU()) {
    for (MVT VecVT : AllVectorVTs)
      addRegisterClass(VecVT, &VE::V64RegClass);
    addRegisterClass(MVT::v256i1, &VE::VMRegClass);
    addRegisterClass(MVT::v512i1, &VE::VM512RegClass);
    addRegisterClass(MVT::v512f64, &VE::VPRegClass);
    addRegisterClass(MVT::v512i64, &VE::VPRegClass);
  }
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

  // Use the default implementation.
  setOperationAction(ISD::STACKSAVE, MVT::Other, Expand);
  setOperationAction(ISD::STACKRESTORE, MVT::Other, Expand);
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
    setOperationAction(ISD::FMA, VT, Expand);
    setOperationAction(ISD::FPOW, VT, Expand);
    setOperationAction(ISD::FSIN, VT, Expand);
    setOperationAction(ISD::FSQRT, VT, Expand);
  }

  // VE has single and double FMINNUM and FMAXNUM
  for (MVT VT : {MVT::f32, MVT::f64}) {
    setOperationAction({ISD::FMAXNUM, ISD::FMINNUM}, VT, Legal);
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

  // Other atomic instructions.
  for (MVT VT : MVT::integer_valuetypes()) {
    // Support i8/i16 atomic swap.
    setOperationAction(ISD::ATOMIC_SWAP, VT, Custom);

    // FIXME: Support "atmam" instructions.
    setOperationAction(ISD::ATOMIC_LOAD_ADD, VT, Expand);
    setOperationAction(ISD::ATOMIC_LOAD_SUB, VT, Expand);
    setOperationAction(ISD::ATOMIC_LOAD_AND, VT, Expand);
    setOperationAction(ISD::ATOMIC_LOAD_OR, VT, Expand);

    // VE doesn't have follwing instructions.
    setOperationAction(ISD::ATOMIC_CMP_SWAP_WITH_SUCCESS, VT, Expand);
    setOperationAction(ISD::ATOMIC_LOAD_CLR, VT, Expand);
    setOperationAction(ISD::ATOMIC_LOAD_XOR, VT, Expand);
    setOperationAction(ISD::ATOMIC_LOAD_NAND, VT, Expand);
    setOperationAction(ISD::ATOMIC_LOAD_MIN, VT, Expand);
    setOperationAction(ISD::ATOMIC_LOAD_MAX, VT, Expand);
    setOperationAction(ISD::ATOMIC_LOAD_UMIN, VT, Expand);
    setOperationAction(ISD::ATOMIC_LOAD_UMAX, VT, Expand);
  }

  /// } Atomic instructions

  /// SJLJ instructions {
  setOperationAction(ISD::EH_SJLJ_LONGJMP, MVT::Other, Custom);
  setOperationAction(ISD::EH_SJLJ_SETJMP, MVT::i32, Custom);
  setOperationAction(ISD::EH_SJLJ_SETUP_DISPATCH, MVT::Other, Custom);
  if (TM.Options.ExceptionModel == ExceptionHandling::SjLj)
    setLibcallName(RTLIB::UNWIND_RESUME, "_Unwind_SjLj_Resume");
  /// } SJLJ instructions

  // Intrinsic instructions
  setOperationAction(ISD::INTRINSIC_VOID, MVT::Other, Custom);
  setOperationAction(ISD::INTRINSIC_W_CHAIN, MVT::Other, Custom);
  setOperationAction(ISD::INTRINSIC_WO_CHAIN, MVT::Other, Custom);

  // Other configurations related to f128.
  setOperationAction(ISD::BR_CC, MVT::f128, Legal);

  // TRAP to expand (which turns it into abort).
  setOperationAction(ISD::TRAP, MVT::Other, Expand);

  // On most systems, DEBUGTRAP and TRAP have no difference. The "Expand"
  // here is to inform DAG Legalizer to replace DEBUGTRAP with TRAP.
  setOperationAction(ISD::DEBUGTRAP, MVT::Other, Expand);
}

static bool isLegalVectorVT(EVT VT) {
  if (!VT.isVector())
    return false;
  auto ElemVT = VT.getVectorElementType();
  return (ElemVT == MVT::i1 || ElemVT == MVT::i32 || ElemVT == MVT::f32 ||
          ElemVT == MVT::i64 || ElemVT == MVT::f64);
}

void VETargetLowering::initVPUActions() {
  if (!Subtarget->enableVPU())
    return;

  // The entry token is the first node to be legalized in the SelectionDAG.
  // Use this to reset the visited internal vector instruction set.
  // setOperationAction(ISD::EntryToken, MVT::Other, Custom);
  setTargetDAGCombine(ISD::EntryToken);

  // Expand CopyToReg(vec_pack (lo, hi)) for over-packed register.
  // This makes register allocation more efficient (less vreg moves).
  setTargetDAGCombine(ISD::CopyToReg);
  // Over-packed live-ins are expanded in ::LowerFormalArguments.
  // setTargetDAGCombine(ISD::CopyFromReg);

  // Vector length legalization
  auto LegalizeVectorLength = [&](unsigned VL) -> unsigned {
    return VL > StandardVectorWidth ? PackedVectorWidth : StandardVectorWidth;
  };

  // all builtin opcodes
  // auto AllOCs = llvm::make_range<unsigned>(1, ISD::BUILTIN_OP_END); // TODO
  // use this

  const ISD::NodeType END_OF_OCLIST = ISD::DELETED_NODE;

  // Unsupported vector ops (expand for all vector types)
  // This is most
  const ISD::NodeType AllExpandOCs[] = {
      // won't implement
      ISD::CONCAT_VECTORS, ISD::MERGE_VALUES,

      // not directly supported
      ISD::FNEG, ISD::FABS, ISD::FCBRT, ISD::FSIN, ISD::FCOS, ISD::FPOWI,
      ISD::FPOW, ISD::FLOG, ISD::FLOG2, ISD::FLOG10, ISD::FEXP, ISD::FEXP2,
      ISD::FCEIL, ISD::FRINT, ISD::FNEARBYINT, ISD::FTRUNC, ISD::FFLOOR,
      ISD::LROUND, ISD::LLROUND, ISD::FROUND, ISD::LRINT, ISD::LLRINT,

      // break down into SETCC + (V)SELECT
      ISD::SELECT_CC,
      ISD::ANY_EXTEND, // TODO sub-register insertion
      ISD::ANY_EXTEND_VECTOR_INREG,

      // TODO
      ISD::ROTL, ISD::ROTR, ISD::BSWAP, ISD::BITREVERSE, ISD::CTLZ,
      ISD::CTLZ_ZERO_UNDEF, ISD::CTTZ, ISD::CTTZ_ZERO_UNDEF, ISD::ADDC,
      ISD::ADDCARRY, ISD::MULHS, ISD::MULHU, ISD::SMUL_LOHI, ISD::UMUL_LOHI,

      // genuinely  unsupported
      ISD::FP_TO_UINT, ISD::UINT_TO_FP, ISD::UREM, ISD::SREM, ISD::SDIVREM,
      ISD::UDIVREM, ISD::FP16_TO_FP, ISD::FP_TO_FP16, END_OF_OCLIST};

  // FIXME should differentiate this..
  const ISD::NodeType AllLegalOCs[] = {ISD::BITCAST, END_OF_OCLIST};

  const ISD::NodeType AllCustomOCs[] = {ISD::SELECT, END_OF_OCLIST};

  // Memory vector ops
  const ISD::NodeType MemoryOCs[] = {// memory
                                     ISD::LOAD,     ISD::STORE, ISD::MGATHER,
                                     ISD::MSCATTER, ISD::MLOAD, ISD::MSTORE,
                                     END_OF_OCLIST};

  // vector construction operations
  const ISD::NodeType VectorTransformOCs[]{
      ISD::BUILD_VECTOR,
      // ISD::CONCAT_VECTORS, // always expanded
      ISD::EXTRACT_SUBVECTOR, ISD::INSERT_SUBVECTOR, ISD::SCALAR_TO_VECTOR,
      ISD::VECTOR_SHUFFLE, END_OF_OCLIST};

  // (Otw legal) Operations to promote to a larger vector element type (i8 and
  // i16 elems)
  const ISD::NodeType IntArithOCs[] = {
      // arithmetic
      ISD::ADD,  ISD::SUB,  ISD::MUL, ISD::SDIV, ISD::UDIV,
      ISD::SREM, ISD::UREM, ISD::AND, ISD::OR,   ISD::XOR,
      ISD::SDIV, ISD::SHL,  ISD::SRA, ISD::SRL,  END_OF_OCLIST};

  const ISD::NodeType FPArithOCs[] = {
      ISD::FMA,  ISD::FABS,      ISD::FSUB,     ISD::FDIV,    ISD::FMUL,
      ISD::FNEG, ISD::FP_EXTEND, ISD::FP_ROUND, END_OF_OCLIST};

  const ISD::NodeType ToIntCastOCs[] = {
      // casts
      ISD::TRUNCATE, ISD::SIGN_EXTEND_VECTOR_INREG,
      ISD::ZERO_EXTEND_VECTOR_INREG, ISD::FP_TO_SINT, END_OF_OCLIST};

  const ISD::NodeType ToFPCastOCs[] = {// casts
                                       ISD::FP_EXTEND, ISD::SINT_TO_FP,
                                       END_OF_OCLIST};

  //
  // reductions
  const ISD::NodeType IntReductionOCs[] = {
      ISD::VECREDUCE_ADD,  ISD::VECREDUCE_MUL,  ISD::VECREDUCE_AND,
      ISD::VECREDUCE_OR,   ISD::VECREDUCE_XOR,  ISD::VECREDUCE_SMIN,
      ISD::VECREDUCE_SMAX, ISD::VECREDUCE_UMIN, ISD::VECREDUCE_UMAX,
      END_OF_OCLIST};

  // reductions
  const ISD::NodeType FPReductionOCs[] = {
      ISD::VECREDUCE_FADD, ISD::VECREDUCE_FMUL, ISD::VECREDUCE_FMIN,
      ISD::VECREDUCE_FMAX, END_OF_OCLIST};

  // reductions
  const ISD::NodeType FPOrderedReductionOCs[] = {
      ISD::VECREDUCE_SEQ_FADD, ISD::VECREDUCE_SEQ_FMUL, END_OF_OCLIST};

  // Convenience Opcode loops
  auto ForAll_Opcodes = [](const ISD::NodeType *OCs,
                           std::function<void(unsigned)> Functor) {
    while (*OCs != END_OF_OCLIST) {
      Functor(*OCs);
      ++OCs;
    }
  };

  auto ForAll_setOperationAction = [&](const ISD::NodeType *OCs, MVT VT,
                                       LegalizeAction Act) {
    ForAll_Opcodes(OCs, [this, VT, Act](unsigned OC) {
      this->setOperationAction(OC, VT, Act);
    });
  };

  // Helpers for specifying trunc+store & load+ext legalization
  // expand all trunc/extend memory ops with this VALUE type
  auto ExpandMemory_TruncExtend_ToValue = [&](MVT ValVT) {
    for (MVT MemVT : MVT::vector_valuetypes()) {
      setTruncStoreAction(ValVT, MemVT, Expand);
      setLoadExtAction(ISD::SEXTLOAD, ValVT, MemVT, Expand);
      setLoadExtAction(ISD::ZEXTLOAD, ValVT, MemVT, Expand);
      setLoadExtAction(ISD::EXTLOAD, ValVT, MemVT, Expand);
    }
  };

  // expand all trunc/extend memory ops with this MEMORY type
  auto ExpandMemory_TruncExtend_ToMemory = [&](MVT MemVT) {
    for (MVT ValVT : MVT::vector_valuetypes()) {
      setTruncStoreAction(ValVT, MemVT, Expand);
      setLoadExtAction(ISD::SEXTLOAD, ValVT, MemVT, Expand);
      setLoadExtAction(ISD::ZEXTLOAD, ValVT, MemVT, Expand);
      setLoadExtAction(ISD::EXTLOAD, ValVT, MemVT, Expand);
    }
  };

  // The simple cases (always expand, custom or legal)
  for (MVT VT : MVT::vector_valuetypes()) {
    // expand all trunc+store, load+ext nodes
    ExpandMemory_TruncExtend_ToValue(VT);
    ExpandMemory_TruncExtend_ToMemory(VT);

    // Expand all operation on vector types on the list
    ForAll_setOperationAction(AllLegalOCs, VT, Legal);
    ForAll_setOperationAction(AllExpandOCs, VT, Expand);
    ForAll_setOperationAction(AllCustomOCs, VT, Custom);
  }

  // Short vector elements (EXCLUDING masks)
  for (MVT VT : MVT::vector_valuetypes()) {
    MVT ElemVT = VT.getVectorElementType();
    unsigned W = VT.getVectorMinNumElements();

    // Use default splitting for vlens > 512
    if (W > PackedVectorWidth)
      continue;

    // Promotion rule, accept native element bit sizes
    unsigned ElemBits = ElemVT.getScalarSizeInBits();

    if ((ElemBits == 1) || (ElemBits >= 64))
      continue;

    ///// [32, 64) lane bits /////
    if (ElemBits >= 32) {
      // Directly select the legal promotion target
      MVT PromotedElemVT = ElemVT.isInteger() ? MVT::i64 : MVT::f64;
      MVT PromoteToVT =
          MVT::getVectorVT(PromotedElemVT, LegalizeVectorLength(W));

      setOperationPromotedToType(ISD::FP_TO_UINT, VT, PromoteToVT);
      setOperationPromotedToType(ISD::UINT_TO_FP, VT, PromoteToVT);
    }

    ///// (1 - 32) lane bits /////
    if (ElemBits >= 32)
      continue;

    {
      // Directly select the legal promotion target
      MVT PromotedElemVT = ElemVT.isInteger() ? MVT::i32 : MVT::f32;
      MVT PromoteToVT =
          MVT::getVectorVT(PromotedElemVT, LegalizeVectorLength(W));
      auto PromotionAction = [&](unsigned OC) {
        setOperationPromotedToType(OC, VT, PromoteToVT);
      };

      // fp16
      ForAll_Opcodes(FPArithOCs, PromotionAction);
      ForAll_Opcodes(FPReductionOCs, PromotionAction);
      ForAll_Opcodes(FPOrderedReductionOCs, PromotionAction);
      // i8, i16
      ForAll_Opcodes(IntArithOCs, PromotionAction);
      ForAll_Opcodes(IntReductionOCs, PromotionAction);
      ForAll_Opcodes(MemoryOCs, PromotionAction);
      ForAll_Opcodes(ToIntCastOCs, PromotionAction);
      ForAll_Opcodes(ToFPCastOCs, PromotionAction);
    }
  }

  for (MVT PackedVT : PackedVectorVTs) {
    setOperationAction(ISD::INSERT_VECTOR_ELT, PackedVT, Custom);
    setOperationAction(ISD::EXTRACT_VECTOR_ELT, PackedVT.getVectorElementType(),
                       Custom);
    setOperationAction(ISD::EXTRACT_VECTOR_ELT, PackedVT, Custom);
  }

  // All mask ops.
  for (MVT MaskVT : MVT::vector_valuetypes()) {
    if (MaskVT.isScalableVector())
      continue;
    if (MaskVT.getVectorElementType() != MVT::i1)
      continue;

    // Mask producing operations
    setOperationAction(ISD::INSERT_VECTOR_ELT, MaskVT, Expand);
    setOperationAction(ISD::EXTRACT_VECTOR_ELT, MaskVT, Custom);

    // Lower to vvp_trunc
    setOperationAction(ISD::TRUNCATE, MaskVT, Custom);

    ForAll_setOperationAction(IntReductionOCs, MaskVT, Custom);
    ForAll_setOperationAction(VectorTransformOCs, MaskVT, Custom);

    // Custom split packed mask operations.
    if (isPackedVectorType(MaskVT))
      ForAll_setOperationAction(IntArithOCs, MaskVT, Custom);
  }

  // Packed mask arithmetic.
  for (unsigned Opc : {ISD::AND, ISD::XOR, ISD::OR})
    setOperationAction(Opc, MVT::v512i1, Custom);

  // vNt32, vNt64 ops (legal element types)
  for (MVT VT : MVT::vector_valuetypes()) {
    MVT ElemVT = VT.getVectorElementType();
    unsigned ElemBits = ElemVT.getScalarSizeInBits();
    if (ElemBits != 32 && ElemBits != 64)
      continue;

    ForAll_setOperationAction(VectorTransformOCs, VT, Custom);
    ForAll_setOperationAction(MemoryOCs, VT, Custom);

    // VE doesn't have instructions for fp<->uint, so expand them by llvm
    if (ElemBits == 64) {
      setOperationAction(ISD::FP_TO_UINT, VT, Expand);
      setOperationAction(ISD::UINT_TO_FP, VT, Expand);
    }

    // Translate all ops with legal element types to VVP_* nodes
#define ADD_VVP_OP(VVP_NAME, ISD_NAME)                                         \
  if (ISD::ISD_NAME != ISD::DELETED_NODE)                                      \
    setOperationAction(ISD::ISD_NAME, VT, Custom);
#include "VVPNodes.def"
  }

  // X -> vp_* funnel
  for (MVT VT : MVT::vector_valuetypes()) {
    LegalizeAction Action;
    // FIXME query available vector width for this Op
    if (isLegalVectorVT(VT) &&
        VT.getVectorMinNumElements() <= PackedVectorWidth) {
      // We perform custom widening as necessary
      Action = Custom;
    } else {
      // Cannot do custom element type legalization at this point
      Action = Expand;
    }

    // llvm.masked.* -> vvp lowering
    setOperationAction(ISD::MSCATTER, VT, Custom);
    setOperationAction(ISD::MGATHER, VT, Custom);
    setOperationAction(ISD::MLOAD, VT, Custom);
    setOperationAction(ISD::MSTORE, VT, Custom);

    // VP -> VVP lowering
#define BEGIN_REGISTER_VP_SDNODE(VP_NAME, LEGALPOS, VP_TEXT, MASK_POS,         \
                                 LEN_POS)                                      \
  setOperationAction(ISD::VP_NAME, VT, Action);
#include "llvm/IR/VPIntrinsics.def"
  }

  // Reduction ops are mapped with their result type
  for (MVT ResVT : {MVT::f64, MVT::f32, MVT::i64, MVT::i32}) {
#define ADD_REDUCE_VVP_OP(VVP_NAME, ISD_NAME)                                  \
  setOperationAction(ISD::ISD_NAME, ResVT, Custom);
#include "VVPNodes.def"
  }

  // CUSTOM HANDLERS FOR VECTOR INSTRUCTIONS
  // horizontal reductions
  setOperationAction(ISD::VECREDUCE_ADD, MVT::i32, Custom);
  setOperationAction(ISD::VECREDUCE_ADD, MVT::i64, Custom);

  setOperationAction(ISD::VECREDUCE_OR, MVT::i32, Custom);
  setOperationAction(ISD::VECREDUCE_OR, MVT::i64, Custom);

  // re-write vector setcc to use a predicate mask
  setOperationAction(ISD::SETCC, MVT::v256i64, Custom);
  setOperationAction(ISD::SETCC, MVT::v256i32, Custom);

  // truncate of X to i1 -> X
  // setOperationAction(ISD::TRUNCATE, MVT::v256i32, Custom); // should not
  // generate invalid valid SETCC in the first place
  setOperationAction(ISD::VSELECT, MVT::v256i1, Custom);

  // v256i1 and v512i1 ops
  for (MVT MaskVT : AllMaskVTs) {
    // Custom lower mask ops
    setOperationAction(ISD::STORE, MaskVT, Custom);
    setOperationAction(ISD::LOAD, MaskVT, Custom);
  }
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
  CCInfo.AnalyzeReturn(Outs, getReturnCC(CallConv));

  SDValue Flag;
  SmallVector<SDValue, 4> RetOps(1, Chain);

  // Copy the result values into the output registers.
  for (unsigned i = 0; i != RVLocs.size(); ++i) {
    CCValAssign &VA = RVLocs[i];
    assert(VA.isRegLoc() && "Can only return in registers!");
    assert(!VA.needsCustom() && "Unexpected custom lowering");
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

  const VERegisterInfo *TRI = Subtarget->getRegisterInfo();

  for (unsigned i = 0, e = ArgLocs.size(); i != e; ++i) {
    CCValAssign &VA = ArgLocs[i];
    if (VA.isRegLoc()) {
      // This argument is passed in a register.
      // All integer register arguments are promoted by the caller to i64.

      // Immediately expand over-packed (v512i64, v512f64) register copies into
      // their parts.
      SDValue Arg;
      MVT ValVT = VA.getValVT();
      if ((Subtarget->enableVPU() && SplitCallRegs) &&
          (isPackedMaskType(ValVT) || isOverPackedType(ValVT))) {
        MVT PartVT = getUnpackSourceType(ValVT, PackElem::Lo);

        // Create two virtual registers for the V64 subregisters and pack them
        // into one value.
        Register LoLocReg, HiLocReg;
        if (isPackedMaskType(ValVT)) {
          LoLocReg = TRI->getSubReg(VA.getLocReg(),
                                    getPackedMaskSubRegIdx(PackElem::Lo));
          HiLocReg = TRI->getSubReg(VA.getLocReg(),
                                    getPackedMaskSubRegIdx(PackElem::Hi));
        } else {
          LoLocReg = TRI->getSubReg(VA.getLocReg(),
                                    getOverPackedSubRegIdx(PackElem::Lo));
          HiLocReg = TRI->getSubReg(VA.getLocReg(),
                                    getOverPackedSubRegIdx(PackElem::Hi));
        }

        Register VRegLo, VRegHi;
        if (isPackedMaskType(ValVT)) {
          VRegLo = MF.addLiveIn(LoLocReg, &VE::VMRegClass);
          VRegHi = MF.addLiveIn(HiLocReg, &VE::VMRegClass);
        } else {
          VRegLo = MF.addLiveIn(LoLocReg, &VE::V64RegClass);
          VRegHi = MF.addLiveIn(HiLocReg, &VE::V64RegClass);
        }

        SDValue ArgLo = DAG.getCopyFromReg(Chain, DL, VRegLo, PartVT);
        SDValue ArgHi = DAG.getCopyFromReg(Chain, DL, VRegHi, PartVT);
        VECustomDAG CDAG(*this, DAG, DL);
        Arg = CDAG.getPack(ValVT, ArgLo, ArgHi,
                           CDAG.getConstant(StandardVectorWidth, MVT::i32));

      } else {
        // Create a virtual register for the promoted live-in value.
        Register VReg =
            MF.addLiveIn(VA.getLocReg(), getRegClassFor(VA.getLocVT()));
        Arg = DAG.getCopyFromReg(Chain, DL, VReg, VA.getLocVT());
      }

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
  auto *CalleeG = dyn_cast<GlobalAddressSDNode>(Callee);
  if (CalleeG)
    GV = CalleeG->getGlobal();
  bool Local = TM.shouldAssumeDSOLocal(*Mod, GV);
  bool UsePlt = !Local;
  MachineFunction &MF = DAG.getMachineFunction();

  // Turn GlobalAddress/ExternalSymbol node into a value node
  // containing the address of them here.
  if (CalleeG) {
    if (IsPICCall) {
      if (UsePlt)
        Subtarget->getInstrInfo()->getGlobalBaseReg(&MF);
      Callee = DAG.getTargetGlobalAddress(GV, DL, PtrVT, 0, 0);
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
  Chain = DAG.getCALLSEQ_END(Chain, ArgsSize, 0, InGlue, DL);
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
    assert(!VA.needsCustom() && "Unexpected custom lowering");
    Register Reg = VA.getLocReg();

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
                                                      Align A,
                                                      MachineMemOperand::Flags,
                                                      bool *Fast) const {
  if (Fast) {
    // It's fast anytime on VE
    *Fast = true;
  }
  return true;
}

bool VETargetLowering::canMergeStoresTo(unsigned AddressSpace, EVT MemVT,
                                        const MachineFunction &MF) const {
  // Do not merge to float value size (128 bytes) if no implicit
  // float attribute is set.
  bool NoFloat = MF.getFunction().hasFnAttribute(Attribute::NoImplicitFloat);

  if (NoFloat) {
    unsigned MaxIntSize = 64;
    return (MemVT.getSizeInBits() <= MaxIntSize);
  }
  return true;
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

  LLVM_DEBUG(dbgs() << "VPU MODE:       " << Subtarget->enableVPU() << "\n";);
  initRegisterClasses();
  initSPUActions();

  // initIntrinsicActions();

  // VVP layer isel actions.
  initVPUActions();

  setStackPointerRegisterToSaveRestore(VE::SX11);

  // We have target-specific dag combine patterns for the following nodes:
  setTargetDAGCombine(ISD::SIGN_EXTEND);
  setTargetDAGCombine(ISD::ZERO_EXTEND);
  setTargetDAGCombine(ISD::ANY_EXTEND);
  setTargetDAGCombine(ISD::TRUNCATE);

  setTargetDAGCombine(ISD::SETCC);
  setTargetDAGCombine(ISD::SELECT);
  setTargetDAGCombine(ISD::SELECT_CC);

  // Set function alignment to 16 bytes
  setMinFunctionAlignment(Align(16));

  // VE stores all argument by 8 bytes alignment
  setMinStackArgumentAlignment(Align(8));

  // VE uses generic registers as conditional registers.
  setHasMultipleConditionRegisters(true);

  computeRegisterProperties(Subtarget->getRegisterInfo());
}

const char *VETargetLowering::getTargetNodeName(unsigned Opcode) const {
#define TARGET_NODE_CASE(NAME)                                                 \
  case VEISD::NAME:                                                            \
    return "VEISD::" #NAME;
  switch ((VEISD::NodeType)Opcode) {
  case VEISD::FIRST_NUMBER:
    break;
    TARGET_NODE_CASE(CALL)
    TARGET_NODE_CASE(EH_SJLJ_LONGJMP)
    TARGET_NODE_CASE(EH_SJLJ_SETJMP)
    TARGET_NODE_CASE(EH_SJLJ_SETUP_DISPATCH)
    TARGET_NODE_CASE(GETFUNPLT)
    TARGET_NODE_CASE(GETSTACKTOP)
    TARGET_NODE_CASE(GETTLSADDR)
    TARGET_NODE_CASE(GLOBAL_BASE_REG)
    TARGET_NODE_CASE(Hi)
    TARGET_NODE_CASE(Lo)
    TARGET_NODE_CASE(MEMBARRIER)
    TARGET_NODE_CASE(RET_FLAG)
    TARGET_NODE_CASE(TS1AM)
    TARGET_NODE_CASE(EQV)
    TARGET_NODE_CASE(XOR)
    TARGET_NODE_CASE(CMPI)
    TARGET_NODE_CASE(CMPU)
    TARGET_NODE_CASE(CMPF)
    TARGET_NODE_CASE(CMPQ)
    TARGET_NODE_CASE(CMOV)
    TARGET_NODE_CASE(FLUSHW)
    TARGET_NODE_CASE(Wrapper)

    TARGET_NODE_CASE(VEC_LVL)
    TARGET_NODE_CASE(VEC_BROADCAST)
    TARGET_NODE_CASE(VEC_GATHER)
    TARGET_NODE_CASE(VEC_SCATTER)
    TARGET_NODE_CASE(VEC_NARROW)
    TARGET_NODE_CASE(VEC_SEQ)
    TARGET_NODE_CASE(VEC_VMV)
    TARGET_NODE_CASE(VEC_TOMASK)

    TARGET_NODE_CASE(VEC_UNPACK_LO)
    TARGET_NODE_CASE(VEC_UNPACK_HI)
    TARGET_NODE_CASE(VEC_PACK)
    TARGET_NODE_CASE(VEC_SWAP)

    TARGET_NODE_CASE(VM_POPCOUNT)
    TARGET_NODE_CASE(VM_INSERT)
    TARGET_NODE_CASE(VM_EXTRACT)

    TARGET_NODE_CASE(REPL_F32)
    TARGET_NODE_CASE(REPL_I32)
    TARGET_NODE_CASE(LEGALAVL)

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

/// Custom Lower {

// The mappings for emitLeading/TrailingFence for VE is designed by following
// http://www.cl.cam.ac.uk/~pes20/cpp/cpp0xmappings.html
Instruction *VETargetLowering::emitLeadingFence(IRBuilderBase &Builder,
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

Instruction *VETargetLowering::emitTrailingFence(IRBuilderBase &Builder,
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

SDValue VETargetLowering::lowerATOMIC_FENCE(SDValue Op,
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

TargetLowering::AtomicExpansionKind
VETargetLowering::shouldExpandAtomicRMWInIR(AtomicRMWInst *AI) const {
  // We have TS1AM implementation for i8/i16/i32/i64, so use it.
  if (AI->getOperation() == AtomicRMWInst::Xchg) {
    return AtomicExpansionKind::None;
  }
  // FIXME: Support "ATMAM" instruction for LOAD_ADD/SUB/AND/OR.

  // Otherwise, expand it using compare and exchange instruction to not call
  // __sync_fetch_and_* functions.
  return AtomicExpansionKind::CmpXChg;
}

static SDValue prepareTS1AM(SDValue Op, SelectionDAG &DAG, SDValue &Flag,
                            SDValue &Bits) {
  SDLoc DL(Op);
  AtomicSDNode *N = cast<AtomicSDNode>(Op);
  SDValue Ptr = N->getOperand(1);
  SDValue Val = N->getOperand(2);
  EVT PtrVT = Ptr.getValueType();
  bool Byte = N->getMemoryVT() == MVT::i8;
  //   Remainder = AND Ptr, 3
  //   Flag = 1 << Remainder  ; If Byte is true (1 byte swap flag)
  //   Flag = 3 << Remainder  ; If Byte is false (2 bytes swap flag)
  //   Bits = Remainder << 3
  //   NewVal = Val << Bits
  SDValue Const3 = DAG.getConstant(3, DL, PtrVT);
  SDValue Remainder = DAG.getNode(ISD::AND, DL, PtrVT, {Ptr, Const3});
  SDValue Mask = Byte ? DAG.getConstant(1, DL, MVT::i32)
                      : DAG.getConstant(3, DL, MVT::i32);
  Flag = DAG.getNode(ISD::SHL, DL, MVT::i32, {Mask, Remainder});
  Bits = DAG.getNode(ISD::SHL, DL, PtrVT, {Remainder, Const3});
  return DAG.getNode(ISD::SHL, DL, Val.getValueType(), {Val, Bits});
}

static SDValue finalizeTS1AM(SDValue Op, SelectionDAG &DAG, SDValue Data,
                             SDValue Bits) {
  SDLoc DL(Op);
  EVT VT = Data.getValueType();
  bool Byte = cast<AtomicSDNode>(Op)->getMemoryVT() == MVT::i8;
  //   NewData = Data >> Bits
  //   Result = NewData & 0xff   ; If Byte is true (1 byte)
  //   Result = NewData & 0xffff ; If Byte is false (2 bytes)

  SDValue NewData = DAG.getNode(ISD::SRL, DL, VT, Data, Bits);
  return DAG.getNode(ISD::AND, DL, VT,
                     {NewData, DAG.getConstant(Byte ? 0xff : 0xffff, DL, VT)});
}

SDValue VETargetLowering::lowerATOMIC_SWAP(SDValue Op,
                                           SelectionDAG &DAG) const {
  SDLoc DL(Op);
  AtomicSDNode *N = cast<AtomicSDNode>(Op);

  if (N->getMemoryVT() == MVT::i8) {
    // For i8, use "ts1am"
    //   Input:
    //     ATOMIC_SWAP Ptr, Val, Order
    //
    //   Output:
    //     Remainder = AND Ptr, 3
    //     Flag = 1 << Remainder   ; 1 byte swap flag for TS1AM inst.
    //     Bits = Remainder << 3
    //     NewVal = Val << Bits
    //
    //     Aligned = AND Ptr, -4
    //     Data = TS1AM Aligned, Flag, NewVal
    //
    //     NewData = Data >> Bits
    //     Result = NewData & 0xff ; 1 byte result
    SDValue Flag;
    SDValue Bits;
    SDValue NewVal = prepareTS1AM(Op, DAG, Flag, Bits);

    SDValue Ptr = N->getOperand(1);
    SDValue Aligned = DAG.getNode(ISD::AND, DL, Ptr.getValueType(),
                                  {Ptr, DAG.getConstant(-4, DL, MVT::i64)});
    SDValue TS1AM = DAG.getAtomic(VEISD::TS1AM, DL, N->getMemoryVT(),
                                  DAG.getVTList(Op.getNode()->getValueType(0),
                                                Op.getNode()->getValueType(1)),
                                  {N->getChain(), Aligned, Flag, NewVal},
                                  N->getMemOperand());

    SDValue Result = finalizeTS1AM(Op, DAG, TS1AM, Bits);
    SDValue Chain = TS1AM.getValue(1);
    return DAG.getMergeValues({Result, Chain}, DL);
  }
  if (N->getMemoryVT() == MVT::i16) {
    // For i16, use "ts1am"
    SDValue Flag;
    SDValue Bits;
    SDValue NewVal = prepareTS1AM(Op, DAG, Flag, Bits);

    SDValue Ptr = N->getOperand(1);
    SDValue Aligned = DAG.getNode(ISD::AND, DL, Ptr.getValueType(),
                                  {Ptr, DAG.getConstant(-4, DL, MVT::i64)});
    SDValue TS1AM = DAG.getAtomic(VEISD::TS1AM, DL, N->getMemoryVT(),
                                  DAG.getVTList(Op.getNode()->getValueType(0),
                                                Op.getNode()->getValueType(1)),
                                  {N->getChain(), Aligned, Flag, NewVal},
                                  N->getMemOperand());

    SDValue Result = finalizeTS1AM(Op, DAG, TS1AM, Bits);
    SDValue Chain = TS1AM.getValue(1);
    return DAG.getMergeValues({Result, Chain}, DL);
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

  // Generate the following code:
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
  Chain = DAG.getCALLSEQ_END(Chain, 64, 0, Chain.getValue(1), DL);
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

SDValue VETargetLowering::lowerGlobalTLSAddress(SDValue Op,
                                                SelectionDAG &DAG) const {
  // The current implementation of nld (2.26) doesn't allow local exec model
  // code described in VE-tls_v1.1.pdf (*1) as its input. Instead, we always
  // generate the general dynamic model code sequence.
  //
  // *1: https://www.nec.com/en/global/prod/hpc/aurora/document/VE-tls_v1.1.pdf
  return lowerToTLSGeneralDynamicModel(Op, DAG);
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

  // always expand non-mask vector loads to VVP
  EVT MemVT = LdNode->getMemoryVT();
  if (MemVT.isVector() && !isMaskType(MemVT))
    return lowerToVVP(Op, DAG, VVPExpansionMode::ToNativeWidth);

  SDValue BasePtr = LdNode->getBasePtr();
  if (isa<FrameIndexSDNode>(BasePtr.getNode())) {
    // Do not expand store instruction with frame index here because of
    // dependency problems.  We expand it later in eliminateFrameIndex().
    return Op;
  }

  if (MemVT == MVT::f128)
    return lowerLoadF128(Op, DAG);
  if (isMaskType(MemVT))
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

  // always expand non-mask vector loads to VVP
  EVT MemVT = StNode->getMemoryVT();
  if (MemVT.isVector() && !isMaskType(MemVT))
    return lowerToVVP(Op, DAG, VVPExpansionMode::ToNativeWidth);

  SDValue BasePtr = StNode->getBasePtr();
  if (isa<FrameIndexSDNode>(BasePtr.getNode())) {
    // Do not expand store instruction with frame index here because of
    // dependency problems.  We expand it later in eliminateFrameIndex().
    return Op;
  }

  if (MemVT == MVT::f128)
    return lowerStoreF128(Op, DAG);
  if (isMaskType(MemVT))
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
  Chain = DAG.getCALLSEQ_END(Chain, 0, 0, SDValue(), DL);

  SDValue Ops[2] = {Result, Chain};
  return DAG.getMergeValues(Ops, DL);
}

SDValue VETargetLowering::lowerEH_SJLJ_LONGJMP(SDValue Op,
                                               SelectionDAG &DAG) const {
  SDLoc DL(Op);
  return DAG.getNode(VEISD::EH_SJLJ_LONGJMP, DL, MVT::Other, Op.getOperand(0),
                     Op.getOperand(1));
}

SDValue VETargetLowering::lowerEH_SJLJ_SETJMP(SDValue Op,
                                              SelectionDAG &DAG) const {
  SDLoc DL(Op);
  return DAG.getNode(VEISD::EH_SJLJ_SETJMP, DL,
                     DAG.getVTList(MVT::i32, MVT::Other), Op.getOperand(0),
                     Op.getOperand(1));
}

SDValue VETargetLowering::lowerEH_SJLJ_SETUP_DISPATCH(SDValue Op,
                                                      SelectionDAG &DAG) const {
  SDLoc DL(Op);
  return DAG.getNode(VEISD::EH_SJLJ_SETUP_DISPATCH, DL, MVT::Other,
                     Op.getOperand(0));
}

static SDValue lowerFRAMEADDR(SDValue Op, SelectionDAG &DAG,
                              const VETargetLowering &TLI,
                              const VESubtarget *Subtarget) {
  SDLoc DL(Op);
  MachineFunction &MF = DAG.getMachineFunction();
  EVT PtrVT = TLI.getPointerTy(MF.getDataLayout());

  MachineFrameInfo &MFI = MF.getFrameInfo();
  MFI.setFrameAddressIsTaken(true);

  unsigned Depth = Op.getConstantOperandVal(0);
  const VERegisterInfo *RegInfo = Subtarget->getRegisterInfo();
  Register FrameReg = RegInfo->getFrameRegister(MF);
  SDValue FrameAddr =
      DAG.getCopyFromReg(DAG.getEntryNode(), DL, FrameReg, PtrVT);
  while (Depth--)
    FrameAddr = DAG.getLoad(Op.getValueType(), DL, DAG.getEntryNode(),
                            FrameAddr, MachinePointerInfo());
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

  SDValue FrameAddr = lowerFRAMEADDR(Op, DAG, TLI, Subtarget);

  SDLoc DL(Op);
  EVT VT = Op.getValueType();
  SDValue Offset = DAG.getConstant(8, DL, VT);
  return DAG.getLoad(VT, DL, DAG.getEntryNode(),
                     DAG.getNode(ISD::ADD, DL, VT, FrameAddr, Offset),
                     MachinePointerInfo());
}

SDValue VETargetLowering::lowerINTRINSIC_WO_CHAIN(SDValue Op,
                                                  SelectionDAG &DAG) const {
  SDLoc DL(Op);
  unsigned IntNo = cast<ConstantSDNode>(Op.getOperand(0))->getZExtValue();
  switch (IntNo) {
  default: // Don't custom lower most intrinsics.
    return SDValue();
  case Intrinsic::thread_pointer: {
    report_fatal_error("Intrinsic::thread_point is not implemented yet");
  }
  case Intrinsic::eh_sjlj_lsda: {
    MachineFunction &MF = DAG.getMachineFunction();
    MVT VT = Op.getSimpleValueType();
    const VETargetMachine *TM =
        static_cast<const VETargetMachine *>(&DAG.getTarget());

    // Create GCC_except_tableXX string.  The real symbol for that will be
    // generated in EHStreamer::emitExceptionTable() later.  So, we just
    // borrow it's name here.
    TM->getStrList()->push_back(std::string(
        (Twine("GCC_except_table") + Twine(MF.getFunctionNumber())).str()));
    SDValue Addr =
        DAG.getTargetExternalSymbol(TM->getStrList()->back().c_str(), VT, 0);
    if (isPositionIndependent()) {
      Addr = makeHiLoPair(Addr, VEMCExpr::VK_VE_GOTOFF_HI32,
                          VEMCExpr::VK_VE_GOTOFF_LO32, DAG);
      SDValue GlobalBase = DAG.getNode(VEISD::GLOBAL_BASE_REG, DL, VT);
      return DAG.getNode(ISD::ADD, DL, VT, GlobalBase, Addr);
    }
    return makeHiLoPair(Addr, VEMCExpr::VK_VE_HI32, VEMCExpr::VK_VE_LO32, DAG);
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

SDValue VETargetLowering::LowerOperation(SDValue Op, SelectionDAG &DAG) const {
  LLVM_DEBUG(dbgs() << "::LowerOperation"; Op->print(dbgs()););
  unsigned Opcode = Op.getOpcode();
  switch (Opcode) {
  default:
    if (Subtarget->enableVPU())
      return LowerOperation_VVP(Op, DAG);
    llvm_unreachable("Unexpected Opcode in LowerOperation");

  case ISD::ATOMIC_FENCE:
    return lowerATOMIC_FENCE(Op, DAG);
  case ISD::ATOMIC_SWAP:
    return lowerATOMIC_SWAP(Op, DAG);
  case ISD::BlockAddress:
    return lowerBlockAddress(Op, DAG);
  case ISD::ConstantPool:
    return lowerConstantPool(Op, DAG);
  case ISD::DYNAMIC_STACKALLOC:
    return lowerDYNAMIC_STACKALLOC(Op, DAG);
  case ISD::EH_SJLJ_LONGJMP:
    return lowerEH_SJLJ_LONGJMP(Op, DAG);
  case ISD::EH_SJLJ_SETJMP:
    return lowerEH_SJLJ_SETJMP(Op, DAG);
  case ISD::EH_SJLJ_SETUP_DISPATCH:
    return lowerEH_SJLJ_SETUP_DISPATCH(Op, DAG);
  case ISD::FRAMEADDR:
    return lowerFRAMEADDR(Op, DAG, *this, Subtarget);
  case ISD::GlobalAddress:
    return lowerGlobalAddress(Op, DAG);
  case ISD::GlobalTLSAddress:
    return lowerGlobalTLSAddress(Op, DAG);
  case ISD::INTRINSIC_VOID:
    return lowerINTRINSIC_VOID(Op, DAG);
  case ISD::INTRINSIC_W_CHAIN:
    return lowerINTRINSIC_W_CHAIN(Op, DAG);
  case ISD::INTRINSIC_WO_CHAIN:
    return lowerINTRINSIC_WO_CHAIN(Op, DAG);
  case ISD::JumpTable:
    return lowerJumpTable(Op, DAG);
  case ISD::LOAD:
    return lowerLOAD(Op, DAG);
  case ISD::RETURNADDR:
    return lowerRETURNADDR(Op, DAG, *this, Subtarget);
  case ISD::STORE:
    return lowerSTORE(Op, DAG);
  case ISD::VASTART:
    return lowerVASTART(Op, DAG);
  case ISD::VAARG:
    return lowerVAARG(Op, DAG);
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

Register VETargetLowering::prepareMBB(MachineBasicBlock &MBB,
                                      MachineBasicBlock::iterator I,
                                      MachineBasicBlock *TargetBB,
                                      const DebugLoc &DL) const {
  MachineFunction *MF = MBB.getParent();
  MachineRegisterInfo &MRI = MF->getRegInfo();
  const VEInstrInfo *TII = Subtarget->getInstrInfo();

  const TargetRegisterClass *RC = &VE::I64RegClass;
  Register Tmp1 = MRI.createVirtualRegister(RC);
  Register Tmp2 = MRI.createVirtualRegister(RC);
  Register Result = MRI.createVirtualRegister(RC);

  if (isPositionIndependent()) {
    // Create following instructions for local linkage PIC code.
    //     lea %Tmp1, TargetBB@gotoff_lo
    //     and %Tmp2, %Tmp1, (32)0
    //     lea.sl %Result, TargetBB@gotoff_hi(%Tmp2, %s15) ; %s15 is GOT
    BuildMI(MBB, I, DL, TII->get(VE::LEAzii), Tmp1)
        .addImm(0)
        .addImm(0)
        .addMBB(TargetBB, VEMCExpr::VK_VE_GOTOFF_LO32);
    BuildMI(MBB, I, DL, TII->get(VE::ANDrm), Tmp2)
        .addReg(Tmp1, getKillRegState(true))
        .addImm(M0(32));
    BuildMI(MBB, I, DL, TII->get(VE::LEASLrri), Result)
        .addReg(VE::SX15)
        .addReg(Tmp2, getKillRegState(true))
        .addMBB(TargetBB, VEMCExpr::VK_VE_GOTOFF_HI32);
  } else {
    // Create following instructions for non-PIC code.
    //     lea     %Tmp1, TargetBB@lo
    //     and     %Tmp2, %Tmp1, (32)0
    //     lea.sl  %Result, TargetBB@hi(%Tmp2)
    BuildMI(MBB, I, DL, TII->get(VE::LEAzii), Tmp1)
        .addImm(0)
        .addImm(0)
        .addMBB(TargetBB, VEMCExpr::VK_VE_LO32);
    BuildMI(MBB, I, DL, TII->get(VE::ANDrm), Tmp2)
        .addReg(Tmp1, getKillRegState(true))
        .addImm(M0(32));
    BuildMI(MBB, I, DL, TII->get(VE::LEASLrii), Result)
        .addReg(Tmp2, getKillRegState(true))
        .addImm(0)
        .addMBB(TargetBB, VEMCExpr::VK_VE_HI32);
  }
  return Result;
}

Register VETargetLowering::prepareSymbol(MachineBasicBlock &MBB,
                                         MachineBasicBlock::iterator I,
                                         StringRef Symbol, const DebugLoc &DL,
                                         bool IsLocal = false,
                                         bool IsCall = false) const {
  MachineFunction *MF = MBB.getParent();
  MachineRegisterInfo &MRI = MF->getRegInfo();
  const VEInstrInfo *TII = Subtarget->getInstrInfo();

  const TargetRegisterClass *RC = &VE::I64RegClass;
  Register Result = MRI.createVirtualRegister(RC);

  if (isPositionIndependent()) {
    if (IsCall && !IsLocal) {
      // Create following instructions for non-local linkage PIC code function
      // calls.  These instructions uses IC and magic number -24, so we expand
      // them in VEAsmPrinter.cpp from GETFUNPLT pseudo instruction.
      //     lea %Reg, Symbol@plt_lo(-24)
      //     and %Reg, %Reg, (32)0
      //     sic %s16
      //     lea.sl %Result, Symbol@plt_hi(%Reg, %s16) ; %s16 is PLT
      BuildMI(MBB, I, DL, TII->get(VE::GETFUNPLT), Result)
          .addExternalSymbol("abort");
    } else if (IsLocal) {
      Register Tmp1 = MRI.createVirtualRegister(RC);
      Register Tmp2 = MRI.createVirtualRegister(RC);
      // Create following instructions for local linkage PIC code.
      //     lea %Tmp1, Symbol@gotoff_lo
      //     and %Tmp2, %Tmp1, (32)0
      //     lea.sl %Result, Symbol@gotoff_hi(%Tmp2, %s15) ; %s15 is GOT
      BuildMI(MBB, I, DL, TII->get(VE::LEAzii), Tmp1)
          .addImm(0)
          .addImm(0)
          .addExternalSymbol(Symbol.data(), VEMCExpr::VK_VE_GOTOFF_LO32);
      BuildMI(MBB, I, DL, TII->get(VE::ANDrm), Tmp2)
          .addReg(Tmp1, getKillRegState(true))
          .addImm(M0(32));
      BuildMI(MBB, I, DL, TII->get(VE::LEASLrri), Result)
          .addReg(VE::SX15)
          .addReg(Tmp2, getKillRegState(true))
          .addExternalSymbol(Symbol.data(), VEMCExpr::VK_VE_GOTOFF_HI32);
    } else {
      Register Tmp1 = MRI.createVirtualRegister(RC);
      Register Tmp2 = MRI.createVirtualRegister(RC);
      // Create following instructions for not local linkage PIC code.
      //     lea %Tmp1, Symbol@got_lo
      //     and %Tmp2, %Tmp1, (32)0
      //     lea.sl %Tmp3, Symbol@gotoff_hi(%Tmp2, %s15) ; %s15 is GOT
      //     ld %Result, 0(%Tmp3)
      Register Tmp3 = MRI.createVirtualRegister(RC);
      BuildMI(MBB, I, DL, TII->get(VE::LEAzii), Tmp1)
          .addImm(0)
          .addImm(0)
          .addExternalSymbol(Symbol.data(), VEMCExpr::VK_VE_GOT_LO32);
      BuildMI(MBB, I, DL, TII->get(VE::ANDrm), Tmp2)
          .addReg(Tmp1, getKillRegState(true))
          .addImm(M0(32));
      BuildMI(MBB, I, DL, TII->get(VE::LEASLrri), Tmp3)
          .addReg(VE::SX15)
          .addReg(Tmp2, getKillRegState(true))
          .addExternalSymbol(Symbol.data(), VEMCExpr::VK_VE_GOT_HI32);
      BuildMI(MBB, I, DL, TII->get(VE::LDrii), Result)
          .addReg(Tmp3, getKillRegState(true))
          .addImm(0)
          .addImm(0);
    }
  } else {
    Register Tmp1 = MRI.createVirtualRegister(RC);
    Register Tmp2 = MRI.createVirtualRegister(RC);
    // Create following instructions for non-PIC code.
    //     lea     %Tmp1, Symbol@lo
    //     and     %Tmp2, %Tmp1, (32)0
    //     lea.sl  %Result, Symbol@hi(%Tmp2)
    BuildMI(MBB, I, DL, TII->get(VE::LEAzii), Tmp1)
        .addImm(0)
        .addImm(0)
        .addExternalSymbol(Symbol.data(), VEMCExpr::VK_VE_LO32);
    BuildMI(MBB, I, DL, TII->get(VE::ANDrm), Tmp2)
        .addReg(Tmp1, getKillRegState(true))
        .addImm(M0(32));
    BuildMI(MBB, I, DL, TII->get(VE::LEASLrii), Result)
        .addReg(Tmp2, getKillRegState(true))
        .addImm(0)
        .addExternalSymbol(Symbol.data(), VEMCExpr::VK_VE_HI32);
  }
  return Result;
}

void VETargetLowering::setupEntryBlockForSjLj(MachineInstr &MI,
                                              MachineBasicBlock *MBB,
                                              MachineBasicBlock *DispatchBB,
                                              int FI, int Offset) const {
  DebugLoc DL = MI.getDebugLoc();
  const VEInstrInfo *TII = Subtarget->getInstrInfo();

  Register LabelReg =
      prepareMBB(*MBB, MachineBasicBlock::iterator(MI), DispatchBB, DL);

  // Store an address of DispatchBB to a given jmpbuf[1] where has next IC
  // referenced by longjmp (throw) later.
  MachineInstrBuilder MIB = BuildMI(*MBB, MI, DL, TII->get(VE::STrii));
  addFrameReference(MIB, FI, Offset); // jmpbuf[1]
  MIB.addReg(LabelReg, getKillRegState(true));
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

  // Memory Reference.
  SmallVector<MachineMemOperand *, 2> MMOs(MI.memoperands_begin(),
                                           MI.memoperands_end());
  Register BufReg = MI.getOperand(1).getReg();

  Register DstReg;

  DstReg = MI.getOperand(0).getReg();
  const TargetRegisterClass *RC = MRI.getRegClass(DstReg);
  assert(TRI->isTypeLegalForClass(*RC, MVT::i32) && "Invalid destination!");
  (void)TRI;
  Register MainDestReg = MRI.createVirtualRegister(RC);
  Register RestoreDestReg = MRI.createVirtualRegister(RC);

  // For `v = call @llvm.eh.sjlj.setjmp(buf)`, we generate following
  // instructions.  SP/FP must be saved in jmpbuf before `llvm.eh.sjlj.setjmp`.
  //
  // ThisMBB:
  //   buf[3] = %s17 iff %s17 is used as BP
  //   buf[1] = RestoreMBB as IC after longjmp
  //   # SjLjSetup RestoreMBB
  //
  // MainMBB:
  //   v_main = 0
  //
  // SinkMBB:
  //   v = phi(v_main, MainMBB, v_restore, RestoreMBB)
  //   ...
  //
  // RestoreMBB:
  //   %s17 = buf[3] = iff %s17 is used as BP
  //   v_restore = 1
  //   goto SinkMBB

  MachineBasicBlock *ThisMBB = MBB;
  MachineBasicBlock *MainMBB = MF->CreateMachineBasicBlock(BB);
  MachineBasicBlock *SinkMBB = MF->CreateMachineBasicBlock(BB);
  MachineBasicBlock *RestoreMBB = MF->CreateMachineBasicBlock(BB);
  MF->insert(I, MainMBB);
  MF->insert(I, SinkMBB);
  MF->push_back(RestoreMBB);
  RestoreMBB->setMachineBlockAddressTaken();

  // Transfer the remainder of BB and its successor edges to SinkMBB.
  SinkMBB->splice(SinkMBB->begin(), MBB,
                  std::next(MachineBasicBlock::iterator(MI)), MBB->end());
  SinkMBB->transferSuccessorsAndUpdatePHIs(MBB);

  // ThisMBB:
  Register LabelReg =
      prepareMBB(*MBB, MachineBasicBlock::iterator(MI), RestoreMBB, DL);

  // Store BP in buf[3] iff this function is using BP.
  const VEFrameLowering *TFI = Subtarget->getFrameLowering();
  if (TFI->hasBP(*MF)) {
    MachineInstrBuilder MIB = BuildMI(*MBB, MI, DL, TII->get(VE::STrii));
    MIB.addReg(BufReg);
    MIB.addImm(0);
    MIB.addImm(24);
    MIB.addReg(VE::SX17);
    MIB.setMemRefs(MMOs);
  }

  // Store IP in buf[1].
  MachineInstrBuilder MIB = BuildMI(*MBB, MI, DL, TII->get(VE::STrii));
  MIB.add(MI.getOperand(1)); // we can preserve the kill flags here.
  MIB.addImm(0);
  MIB.addImm(8);
  MIB.addReg(LabelReg, getKillRegState(true));
  MIB.setMemRefs(MMOs);

  // SP/FP are already stored in jmpbuf before `llvm.eh.sjlj.setjmp`.

  // Insert setup.
  MIB =
      BuildMI(*ThisMBB, MI, DL, TII->get(VE::EH_SjLj_Setup)).addMBB(RestoreMBB);

  const VERegisterInfo *RegInfo = Subtarget->getRegisterInfo();
  MIB.addRegMask(RegInfo->getNoPreservedMask());
  ThisMBB->addSuccessor(MainMBB);
  ThisMBB->addSuccessor(RestoreMBB);

  // MainMBB:
  BuildMI(MainMBB, DL, TII->get(VE::LEAzii), MainDestReg)
      .addImm(0)
      .addImm(0)
      .addImm(0);
  MainMBB->addSuccessor(SinkMBB);

  // SinkMBB:
  BuildMI(*SinkMBB, SinkMBB->begin(), DL, TII->get(VE::PHI), DstReg)
      .addReg(MainDestReg)
      .addMBB(MainMBB)
      .addReg(RestoreDestReg)
      .addMBB(RestoreMBB);

  // RestoreMBB:
  // Restore BP from buf[3] iff this function is using BP.  The address of
  // buf is in SX10.
  // FIXME: Better to not use SX10 here
  if (TFI->hasBP(*MF)) {
    MachineInstrBuilder MIB =
        BuildMI(RestoreMBB, DL, TII->get(VE::LDrii), VE::SX17);
    MIB.addReg(VE::SX10);
    MIB.addImm(0);
    MIB.addImm(24);
    MIB.setMemRefs(MMOs);
  }
  BuildMI(RestoreMBB, DL, TII->get(VE::LEAzii), RestoreDestReg)
      .addImm(0)
      .addImm(0)
      .addImm(1);
  BuildMI(RestoreMBB, DL, TII->get(VE::BRCFLa_t)).addMBB(SinkMBB);
  RestoreMBB->addSuccessor(SinkMBB);

  MI.eraseFromParent();
  return SinkMBB;
}

MachineBasicBlock *
VETargetLowering::emitEHSjLjLongJmp(MachineInstr &MI,
                                    MachineBasicBlock *MBB) const {
  DebugLoc DL = MI.getDebugLoc();
  MachineFunction *MF = MBB->getParent();
  const TargetInstrInfo *TII = Subtarget->getInstrInfo();
  MachineRegisterInfo &MRI = MF->getRegInfo();

  // Memory Reference.
  SmallVector<MachineMemOperand *, 2> MMOs(MI.memoperands_begin(),
                                           MI.memoperands_end());
  Register BufReg = MI.getOperand(0).getReg();

  Register Tmp = MRI.createVirtualRegister(&VE::I64RegClass);
  // Since FP is only updated here but NOT referenced, it's treated as GPR.
  const Register FP = VE::SX9;
  const Register SP = VE::SX11;

  MachineInstrBuilder MIB;

  MachineBasicBlock *ThisMBB = MBB;

  // For `call @llvm.eh.sjlj.longjmp(buf)`, we generate following instructions.
  //
  // ThisMBB:
  //   %fp = load buf[0]
  //   %jmp = load buf[1]
  //   %s10 = buf        ; Store an address of buf to SX10 for RestoreMBB
  //   %sp = load buf[2] ; generated by llvm.eh.sjlj.setjmp.
  //   jmp %jmp

  // Reload FP.
  MIB = BuildMI(*ThisMBB, MI, DL, TII->get(VE::LDrii), FP);
  MIB.addReg(BufReg);
  MIB.addImm(0);
  MIB.addImm(0);
  MIB.setMemRefs(MMOs);

  // Reload IP.
  MIB = BuildMI(*ThisMBB, MI, DL, TII->get(VE::LDrii), Tmp);
  MIB.addReg(BufReg);
  MIB.addImm(0);
  MIB.addImm(8);
  MIB.setMemRefs(MMOs);

  // Copy BufReg to SX10 for later use in setjmp.
  // FIXME: Better to not use SX10 here
  BuildMI(*ThisMBB, MI, DL, TII->get(VE::ORri), VE::SX10)
      .addReg(BufReg)
      .addImm(0);

  // Reload SP.
  MIB = BuildMI(*ThisMBB, MI, DL, TII->get(VE::LDrii), SP);
  MIB.add(MI.getOperand(0)); // we can preserve the kill flags here.
  MIB.addImm(0);
  MIB.addImm(16);
  MIB.setMemRefs(MMOs);

  // Jump.
  BuildMI(*ThisMBB, MI, DL, TII->get(VE::BCFLari_t))
      .addReg(Tmp, getKillRegState(true))
      .addImm(0);

  MI.eraseFromParent();
  return ThisMBB;
}

MachineBasicBlock *
VETargetLowering::emitSjLjDispatchBlock(MachineInstr &MI,
                                        MachineBasicBlock *BB) const {
  DebugLoc DL = MI.getDebugLoc();
  MachineFunction *MF = BB->getParent();
  MachineFrameInfo &MFI = MF->getFrameInfo();
  MachineRegisterInfo &MRI = MF->getRegInfo();
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

  // The %fn_context is allocated like below (from --print-after=sjljehprepare):
  //   %fn_context = alloca { i8*, i64, [4 x i64], i8*, i8*, [5 x i8*] }
  //
  // This `[5 x i8*]` is jmpbuf, so jmpbuf[1] is FI+72.
  // First `i64` is callsite, so callsite is FI+8.
  static const int OffsetIC = 72;
  static const int OffsetCS = 8;

  // Create the MBBs for the dispatch code like following:
  //
  // ThisMBB:
  //   Prepare DispatchBB address and store it to buf[1].
  //   ...
  //
  // DispatchBB:
  //   %s15 = GETGOT iff isPositionIndependent
  //   %callsite = load callsite
  //   brgt.l.t #size of callsites, %callsite, DispContBB
  //
  // TrapBB:
  //   Call abort.
  //
  // DispContBB:
  //   %breg = address of jump table
  //   %pc = load and calculate next pc from %breg and %callsite
  //   jmp %pc

  // Shove the dispatch's address into the return slot in the function context.
  MachineBasicBlock *DispatchBB = MF->CreateMachineBasicBlock();
  DispatchBB->setIsEHPad(true);

  // Trap BB will causes trap like `assert(0)`.
  MachineBasicBlock *TrapBB = MF->CreateMachineBasicBlock();
  DispatchBB->addSuccessor(TrapBB);

  MachineBasicBlock *DispContBB = MF->CreateMachineBasicBlock();
  DispatchBB->addSuccessor(DispContBB);

  // Insert MBBs.
  MF->push_back(DispatchBB);
  MF->push_back(DispContBB);
  MF->push_back(TrapBB);

  // Insert code to call abort in the TrapBB.
  Register Abort = prepareSymbol(*TrapBB, TrapBB->end(), "abort", DL,
                                 /* Local */ false, /* Call */ true);
  BuildMI(TrapBB, DL, TII->get(VE::BSICrii), VE::SX10)
      .addReg(Abort, getKillRegState(true))
      .addImm(0)
      .addImm(0);

  // Insert code into the entry block that creates and registers the function
  // context.
  setupEntryBlockForSjLj(MI, BB, DispatchBB, FI, OffsetIC);

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
    // Force to generate GETGOT, since current implementation doesn't store GOT
    // register.
    BuildMI(DispatchBB, DL, TII->get(VE::GETGOT), VE::SX15);
  }

  // IReg is used as an index in a memory operand and therefore can't be SP
  const TargetRegisterClass *RC = &VE::I64RegClass;
  Register IReg = MRI.createVirtualRegister(RC);
  addFrameReference(BuildMI(DispatchBB, DL, TII->get(VE::LDLZXrii), IReg), FI,
                    OffsetCS);
  if (LPadList.size() < 64) {
    BuildMI(DispatchBB, DL, TII->get(VE::BRCFLir_t))
        .addImm(VECC::CC_ILE)
        .addImm(LPadList.size())
        .addReg(IReg)
        .addMBB(TrapBB);
  } else {
    assert(LPadList.size() <= 0x7FFFFFFF && "Too large Landing Pad!");
    Register TmpReg = MRI.createVirtualRegister(RC);
    BuildMI(DispatchBB, DL, TII->get(VE::LEAzii), TmpReg)
        .addImm(0)
        .addImm(0)
        .addImm(LPadList.size());
    BuildMI(DispatchBB, DL, TII->get(VE::BRCFLrr_t))
        .addImm(VECC::CC_ILE)
        .addReg(TmpReg, getKillRegState(true))
        .addReg(IReg)
        .addMBB(TrapBB);
  }

  Register BReg = MRI.createVirtualRegister(RC);
  Register Tmp1 = MRI.createVirtualRegister(RC);
  Register Tmp2 = MRI.createVirtualRegister(RC);

  if (isPositionIndependent()) {
    // Create following instructions for local linkage PIC code.
    //     lea    %Tmp1, .LJTI0_0@gotoff_lo
    //     and    %Tmp2, %Tmp1, (32)0
    //     lea.sl %BReg, .LJTI0_0@gotoff_hi(%Tmp2, %s15) ; %s15 is GOT
    BuildMI(DispContBB, DL, TII->get(VE::LEAzii), Tmp1)
        .addImm(0)
        .addImm(0)
        .addJumpTableIndex(MJTI, VEMCExpr::VK_VE_GOTOFF_LO32);
    BuildMI(DispContBB, DL, TII->get(VE::ANDrm), Tmp2)
        .addReg(Tmp1, getKillRegState(true))
        .addImm(M0(32));
    BuildMI(DispContBB, DL, TII->get(VE::LEASLrri), BReg)
        .addReg(VE::SX15)
        .addReg(Tmp2, getKillRegState(true))
        .addJumpTableIndex(MJTI, VEMCExpr::VK_VE_GOTOFF_HI32);
  } else {
    // Create following instructions for non-PIC code.
    //     lea     %Tmp1, .LJTI0_0@lo
    //     and     %Tmp2, %Tmp1, (32)0
    //     lea.sl  %BReg, .LJTI0_0@hi(%Tmp2)
    BuildMI(DispContBB, DL, TII->get(VE::LEAzii), Tmp1)
        .addImm(0)
        .addImm(0)
        .addJumpTableIndex(MJTI, VEMCExpr::VK_VE_LO32);
    BuildMI(DispContBB, DL, TII->get(VE::ANDrm), Tmp2)
        .addReg(Tmp1, getKillRegState(true))
        .addImm(M0(32));
    BuildMI(DispContBB, DL, TII->get(VE::LEASLrii), BReg)
        .addReg(Tmp2, getKillRegState(true))
        .addImm(0)
        .addJumpTableIndex(MJTI, VEMCExpr::VK_VE_HI32);
  }

  switch (JTE) {
  case MachineJumpTableInfo::EK_BlockAddress: {
    // Generate simple block address code for no-PIC model.
    //     sll %Tmp1, %IReg, 3
    //     lds %TReg, 0(%Tmp1, %BReg)
    //     bcfla %TReg

    Register TReg = MRI.createVirtualRegister(RC);
    Register Tmp1 = MRI.createVirtualRegister(RC);

    BuildMI(DispContBB, DL, TII->get(VE::SLLri), Tmp1)
        .addReg(IReg, getKillRegState(true))
        .addImm(3);
    BuildMI(DispContBB, DL, TII->get(VE::LDrri), TReg)
        .addReg(BReg, getKillRegState(true))
        .addReg(Tmp1, getKillRegState(true))
        .addImm(0);
    BuildMI(DispContBB, DL, TII->get(VE::BCFLari_t))
        .addReg(TReg, getKillRegState(true))
        .addImm(0);
    break;
  }
  case MachineJumpTableInfo::EK_Custom32: {
    // Generate block address code using differences from the function pointer
    // for PIC model.
    //     sll %Tmp1, %IReg, 2
    //     ldl.zx %OReg, 0(%Tmp1, %BReg)
    //     Prepare function address in BReg2.
    //     adds.l %TReg, %BReg2, %OReg
    //     bcfla %TReg

    assert(isPositionIndependent());
    Register OReg = MRI.createVirtualRegister(RC);
    Register TReg = MRI.createVirtualRegister(RC);
    Register Tmp1 = MRI.createVirtualRegister(RC);

    BuildMI(DispContBB, DL, TII->get(VE::SLLri), Tmp1)
        .addReg(IReg, getKillRegState(true))
        .addImm(2);
    BuildMI(DispContBB, DL, TII->get(VE::LDLZXrri), OReg)
        .addReg(BReg, getKillRegState(true))
        .addReg(Tmp1, getKillRegState(true))
        .addImm(0);
    Register BReg2 =
        prepareSymbol(*DispContBB, DispContBB->end(),
                      DispContBB->getParent()->getName(), DL, /* Local */ true);
    BuildMI(DispContBB, DL, TII->get(VE::ADDSLrr), TReg)
        .addReg(OReg, getKillRegState(true))
        .addReg(BReg2, getKillRegState(true));
    BuildMI(DispContBB, DL, TII->get(VE::BCFLari_t))
        .addReg(TReg, getKillRegState(true))
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
    for (auto *MBBS : Successors) {
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
  case VE::EH_SjLj_LongJmp:
    return emitEHSjLjLongJmp(MI, BB);
  case VE::EH_SjLj_SetJmp:
    return emitEHSjLjSetJmp(MI, BB);
  case VE::EH_SjLj_Setup_Dispatch:
    return emitSjLjDispatchBlock(MI, BB);
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
      if (VT == MVT::f32 || VT == MVT::f64) {
        const APInt &Imm = C->getValueAPF().bitcastToAPInt();
        uint64_t Val = Imm.getSExtValue();
        if (Imm.getBitWidth() == 32)
          Val <<= 32; // Immediate value of float place at higher bits on VE.
        return isInt<7>(Val);
      }
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
      } else if (VT == MVT::f64) {
        return isMImmVal(getFpImmVal(C));
      }
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

static bool safeWithoutComp(EVT SrcVT, bool Signed, bool WithCMov) {
  if (SrcVT.isFloatingPoint()) {
    // For the case of floating point setcc, only unordered comparison
    // or general comparison with -enable-no-nans-fp-math option reach
    // here, so it is safe even if values are NaN.  Only f128 doesn't
    // safe since VE uses f64 result of f128 comparison.
    return SrcVT != MVT::f128;
  }
  if (WithCMov) {
    // For the case of integer setcc with cmov, all signed comparison with 0
    // are safe.
    return Signed ? true : false;
  }
  // For the case of integer setcc, only signed 64 bits comparison is safe.
  // For unsigned, "CMPU 0x80000000, 0" has to be greater than 0, but it becomes
  // less than 0 witout CMPU.  For 32 bits, other half of 32 bits are
  // uncoditional, so it is not safe too without CMPI..
  return (Signed && SrcVT == MVT::i64) ? true : false;
}

static SDValue generateComparison(EVT VT, SDValue LHS, SDValue RHS,
                                  bool Commutable, bool Signed, bool WithCMov,
                                  const SDLoc &DL, SelectionDAG &DAG) {
  if (Commutable && VT != MVT::f128) {
    // VE comparison can holds simm7 at lhs and mimm at rhs.  Swap operands
    // if it matches.
    if (isMImm(RHS)) {
      // VE's comparison can handle MImm in RHS, so nothing to do.
    } else if (isSimm7(RHS)) {
      // VE's comparison can handle Simm7 in LHS, so swap LHS and RHS, and
      // update condition code.
      std::swap(LHS, RHS);
    }
    assert(!(isNullConstant(LHS) || isNullFPConstant(LHS)) && "lhs is 0!");
  }

  // Compare values.  If RHS is 0 and it is safe to calculate without
  // comparison, we don't generate an instruction for comparison.
  EVT CompVT = decideCompType(VT);
  if (CompVT == VT && (Commutable || safeWithoutComp(VT, Signed, WithCMov)) &&
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
      generateComparison(SrcVT, Op0, Op1, false, Signed, false, DL, DAG);
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
  SDValue CompNode =
      generateComparison(SrcVT, Op0, Op1, true, true, false, DL, DAG);
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
  //   INSN                     LATENCY
  //   CMP       %cmp, %a, %b   1
  //   LEA       %res, 0        1
  //   CMOV.cond %res, 1, %cmp  3
  //
  // This uses 3 instructions.  CMP and LEA can be executed simultaneously.
  // So, this requires 4 to 5 cycles to complete.  In addition, the result
  // of LEA instruction may hold a register for a while if LEA instruction
  // is moved around.
  //
  // Therefore, we decide to optimize these instructions using better
  // instructions.

  ISD::CondCode CC = cast<CondCodeSDNode>(N->getOperand(2))->get();
  SelectionDAG &DAG = DCI.DAG;
  switch (CC) {
  default:
    break;
  case ISD::SETEQ:
    //   INSN                     LATENCY
    //   CMP %t1, %a, %b          1
    //   LDZ %t2, %t1             1       ; 64 iff %t1 is equal to 0
    //   SRL %res, %t2, 6         1       ; 64 becomes 1 now
    // Convert a DAG like below.
    //   a == b -> (LDZ (CMP a, b)) >> 6
    // 3 insns are equal to CMP+LEA+CMOV but faster.
    return generateEquivalentLdz(N, false, DAG);
    break;

  case ISD::SETNE:
    // Generate code for "setugt a, 0" instead of "setne a, 0" since it
    // requires only 2 cycles.
    if (isNullConstant(N->getOperand(1)))
      return generateEquivalentSub(N, false, false, true, DAG);
    LLVM_FALLTHROUGH;
  case ISD::SETUNE: {
    // Generate code for "setugt (cmp a, b), 0" instead of "setne a, b"
    // since it requires only 3 cycles.
    SDLoc DL(N);
    EVT CompVT = decideCompType(SrcVT);
    SDValue CompNode = generateComparison(
        SrcVT, N->getOperand(0), N->getOperand(1), true, true, false, DL, DAG);
    SDValue SetCC = DAG.getNode(ISD::SETCC, DL, MVT::i32, CompNode,
                                DAG.getConstant(0, DL, CompVT),
                                DAG.getCondCode(ISD::SETUGT));
    return generateEquivalentSub(SetCC.getNode(), false, false, true, DAG);
  }
  case ISD::SETLT:
    //   INSN                     LATENCY
    //   CMP %t1, %a, %b          1
    //   SRL %res, %t1, 63/31     1
    // Convert a DAG like below.
    //   a < b -> (CMP a, b) >> size(a)-1
    // 2 insns are less than CMP+LEA+CMOV.
    return generateEquivalentSub(N, true, false, false, DAG);
  case ISD::SETGT:
    // Convert a DAG like below.
    //   a > b -> (CMP b, a) >> size(a)-1
    // 2 insns are less than CMP+LEA+CMOV.
    return generateEquivalentSub(N, true, false, true, DAG);
  case ISD::SETLE:
    //   INSN                     LATENCY
    //   CMP %t1, %b, %a          1
    //   SRL %t2, %t1, 63/31      1
    //   XOR %res, %t2, 1         1
    // Convert a DAG like below.
    //   a <= b -> (XOR (CMP b, a) >> size(a)-1, 1)
    // 3 insns are equal to CMP+LEA+CMOV but faster.
    return generateEquivalentSub(N, true, true, true, DAG);
  case ISD::SETGE:
    // a >= b -> (XOR (CMP a, b) >> size(a)-1, 1)
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

static bool isI32InsnAllUses(const SDNode *User, const SDNode *N);
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
    return isI32InsnAllUses(User, N);
  case VEISD::CMOV:
    // CMOV in (cmov (trunc ...), true, false, int-comparison) is safe.
    // However, trunc in true or false clauses is not safe.
    if (User->getOperand(1).getNode() != N &&
        User->getOperand(2).getNode() != N &&
        isa<ConstantSDNode>(User->getOperand(3))) {
      VECC::CondCode VECCVal = static_cast<VECC::CondCode>(
          cast<ConstantSDNode>(User->getOperand(3))->getZExtValue());
      return isIntVECondCode(VECCVal);
    }
    [[fallthrough]];
  case ISD::AND:
  case ISD::OR:
  case ISD::XOR:
  case ISD::SELECT:
  case ISD::CopyToReg:
    // Check all use of selections, bit operations, and copies.  If all of them
    // are safe, optimize truncate to extract_subreg.
    return isI32InsnAllUses(User, N);
  }
}

static bool isI32InsnAllUses(const SDNode *User, const SDNode *N) {
  // Check all use of User node.  If all of them are safe, optimize
  // truncate to extract_subreg.
  for (const SDNode *U : User->uses()) {
    switch (U->getOpcode()) {
    default:
      // If the use is an instruction which treats the source operand as i32,
      // it is safe to avoid truncate here.
      if (isI32Insn(U, N))
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
          User->getOpcode() == ISD::SELECT || User->getOpcode() == VEISD::CMOV)
        continue;
      break;
    }
    }
    return false;
  }
  return true;
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
  for (const SDNode *User : N->uses()) {
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

  // We handle only scalar SELECT_CC.
  EVT VT = N->getValueType(0);
  if (VT.isVector())
    return SDValue();

  // We handle only i32/i64/f32/f64/f128 comparisons.
  EVT LHSVT = LHS.getValueType();
  assert(LHSVT == RHS.getValueType());
  switch (LHSVT.getSimpleVT().SimpleTy) {
  case MVT::i32:
  case MVT::i64:
  case MVT::f32:
  case MVT::f64:
  case MVT::f128:
    break;
  default:
    // Return SDValue to let llvm handle other types.
    return SDValue();
  }

  if (isMImm(RHS)) {
    // VE's comparison can handle MImm in RHS, so nothing to do.
  } else if (isSimm7(RHS)) {
    // VE's comparison can handle Simm7 in LHS, so swap LHS and RHS, and
    // update condition code.
    std::swap(LHS, RHS);
    CC = getSetCCSwappedOperands(CC);
  }
  if (isMImm(True)) {
    // VE's condition move can handle MImm in True clause, so nothing to do.
  } else if (isMImm(False)) {
    // VE's condition move can handle MImm in True clause, so swap True and
    // False clauses if False has MImm value.  And, update condition code.
    std::swap(True, False);
    CC = getSetCCInverse(CC, LHSVT);
  }

  SDLoc DL(N);
  SelectionDAG &DAG = DCI.DAG;

  bool Commutable = isIntEqualitySetCC(CC);
  bool Signed = isSignedIntSetCC(CC);
  bool WithCMov = true;
  SDValue CompNode = generateComparison(LHSVT, LHS, RHS, Commutable, Signed,
                                        WithCMov, DL, DAG);

  VECC::CondCode VECCVal;
  if (LHSVT.isFloatingPoint()) {
    VECCVal = fpCondCode2Fcc(CC);
  } else {
    VECCVal = intCondCode2Icc(CC);
  }
  SDValue Ops[] = {CompNode, True, False,
                   DAG.getConstant(VECCVal, DL, MVT::i32)};
  return DAG.getNode(VEISD::CMOV, DL, VT, Ops);
}

SDValue VETargetLowering::combineSelect(SDNode *N,
                                        DAGCombinerInfo &DCI) const {
  assert(N->getOpcode() == ISD::SELECT &&
         "Should be called with a SELECT node");
  ISD::CondCode CC = ISD::CondCode::SETNE;
  SDValue Cond = N->getOperand(0);
  SDValue True = N->getOperand(1);
  SDValue False = N->getOperand(2);

  // We handle only scalar SELECT.
  EVT VT = N->getValueType(0);
  if (VT.isVector())
    return SDValue();

  // Peform combineSelect after leagalize DAG.
  if (!DCI.isAfterLegalizeDAG())
    return SDValue();

  EVT VT0 = Cond.getValueType();
  if (isMImm(True)) {
    // VE's condition move can handle MImm in True clause, so nothing to do.
  } else if (isMImm(False)) {
    // VE's condition move can handle MImm in True clause, so swap True and
    // False clauses if False has MImm value.  And, update condition code.
    std::swap(True, False);
    CC = getSetCCInverse(CC, VT0);
  }

  SDLoc DL(N);
  SelectionDAG &DAG = DCI.DAG;
  VECC::CondCode VECCVal;
  if (VT0.isFloatingPoint()) {
    VECCVal = fpCondCode2Fcc(CC);
  } else {
    VECCVal = intCondCode2Icc(CC);
  }
  SDValue Ops[] = {Cond, True, False,
                   DAG.getConstant(VECCVal, DL, MVT::i32)};
  return DAG.getNode(VEISD::CMOV, DL, VT, Ops);
}

SDValue VETargetLowering::PerformDAGCombine(SDNode *N,
                                            DAGCombinerInfo &DCI) const {
  SDLoc dl(N);
  unsigned Opcode = N->getOpcode();
  switch (Opcode) {
  default:
    if (!Subtarget->enableVPU())
      return SDValue();
    if (isVVP(Opcode))
      return combineVVP(N, DCI);
    else if (isPackingSupportOpcode(Opcode))
      return combinePacking(N, DCI);
    break;
  // case ISD::CopyFromReg:
  //   return combineCopyFromRegVVP(N, DCI);
  case ISD::CopyToReg:
    if (Subtarget->enableVPU())
      return combineCopyToRegVVP(N, DCI);
    return SDValue();
  case ISD::ANY_EXTEND:
  case ISD::SIGN_EXTEND:
  case ISD::ZERO_EXTEND:
    return combineExtBoolTrunc(N, DCI);
  case ISD::SETCC:
    return combineSetCC(N, DCI);
  case ISD::SELECT_CC:
    return combineSelectCC(N, DCI);
  case ISD::SELECT:
    return combineSelect(N, DCI);
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

static bool isPackableElemVT(EVT VT) {
  if (VT.isVector())
    return false;
  return VT.getScalarSizeInBits() <= 32;
}

static bool isVectorRegisterVT(EVT VT) {
  if (!VT.isVector() || VT.isScalableVector())
    return false;
  unsigned NumElems = VT.getVectorNumElements();
  EVT ElemVT = VT.getVectorElementType();

  // Not a legal element count.
  if ((NumElems != 256) && (NumElems != 512))
    return false;

  // Legal as both regular and packed vectors.
  if (ElemVT == MVT::i1 || ElemVT == MVT::i32 || ElemVT == MVT::f32)
    return true;

  // Only legal in regular mode.
  return NumElems == 256;
}

static TargetLoweringBase::LegalizeKind
getPromoteElementConversion(LLVMContext &Context, EVT ElemVT,
                            unsigned NumElems) {
  using LegalizeKind = TargetLoweringBase::LegalizeKind;
  using LegalizeTypeAction = TargetLoweringBase::LegalizeTypeAction;

  LegalizeTypeAction LTA;
  MVT PromotedElemVT;
  if (ElemVT.isFloatingPoint()) {
    PromotedElemVT = MVT::f32;
    LTA = LegalizeTypeAction::TypePromoteFloat;
  } else {
    assert(ElemVT.isInteger());
    PromotedElemVT = MVT::i32;
    LTA = LegalizeTypeAction::TypePromoteInteger;
  }
  return LegalizeKind(LTA, EVT::getVectorVT(Context, PromotedElemVT, NumElems));
}

static TargetLoweringBase::LegalizeKind
getWidenVectorConversion(LLVMContext &Context, EVT ElemVT,
                         unsigned LegalNumElems) {
  using LegalizeKind = TargetLoweringBase::LegalizeKind;
  using LegalizeTypeAction = TargetLoweringBase::LegalizeTypeAction;

  return LegalizeKind(LegalizeTypeAction::TypeWidenVector,
                      EVT::getVectorVT(Context, ElemVT, LegalNumElems));
}

static TargetLoweringBase::LegalizeKind
getSplitVectorConversion(LLVMContext &Context, EVT ElemVT, unsigned NumElems) {
  using LegalizeKind = TargetLoweringBase::LegalizeKind;
  using LegalizeTypeAction = TargetLoweringBase::LegalizeTypeAction;

  return LegalizeKind(LegalizeTypeAction::TypeSplitVector,
                      EVT::getVectorVT(Context, ElemVT, (NumElems + 1) / 2));
}

Optional<TargetLoweringBase::LegalizeKind>
VETargetLowering::getCustomTypeConversion(LLVMContext &Context, EVT VT) const {
  // Do not interfere with SPU legalization.
  if (!VT.isVector() || !Subtarget->enableVPU() ||
      VT.getVectorNumElements() == 1)
    return None;

  EVT ElemVT = VT.getVectorElementType();
  unsigned NumElems = VT.getVectorNumElements();
  auto ElemBits = ElemVT.getScalarSizeInBits();

  // Only use packed mode when surpassing the regular (256 elements) vector
  // size.
  const bool RequiresPackedRegister =
      isOverPackedType(VT) ||
      (isPackableElemVT(ElemVT) && NumElems > StandardVectorWidth);

  // Already a legal type.
  if (isVectorRegisterVT(VT))
    return None;

  // Promote small elements to i/f32.
  if (1 < ElemBits && ElemBits < 32)
    return getPromoteElementConversion(Context, ElemVT, NumElems);

  // Excessive element size.
  if (ElemBits > 64)
    return None; // Defer to builtin expansion for oversized vectors.

  // Widen to register width.
  const unsigned RegisterNumElems =
      RequiresPackedRegister ? PackedVectorWidth : StandardVectorWidth;
  if (NumElems < RegisterNumElems)
    return getWidenVectorConversion(Context, ElemVT, RegisterNumElems);

  // Split to register width.
  // TODO: Teach isel to split non-power-of-two vectors.
  if (NumElems > RegisterNumElems && (NumElems % 2 == 0))
    return getSplitVectorConversion(Context, ElemVT, NumElems);

  // Type is either legal or not custom converted.
  return None;
}

Optional<VETargetLowering::RegisterCountPair>
VETargetLowering::getRegistersForCallingConv(LLVMContext &Context,
                                             CallingConv::ID CC, EVT VT) const {
  using RegisterCount = VETargetLowering::RegisterCountPair;
  if (CC != CallingConv::Fast)
    return None;
  if (!VT.isVector() || VT.isScalableVector())
    return None;

  MVT RegisterVT;
  EVT IntermediateVT;
  unsigned NumIntermediates;
  unsigned NumRegs = getVectorTypeBreakdownForCallingConv(
      Context, CC, VT, IntermediateVT, NumIntermediates, RegisterVT);
  return RegisterCount{RegisterVT, NumRegs};
}

unsigned VETargetLowering::getVectorTypeBreakdownForCallingConv(
    LLVMContext &Context, CallingConv::ID CC, EVT VT, EVT &IntermediateVT,
    unsigned &NumIntermediates, MVT &RegisterVT) const {
  auto DefaultImpl = [&]() {
    return TargetLoweringBase::getVectorTypeBreakdownForCallingConv(
        Context, CC, VT, IntermediateVT, NumIntermediates, RegisterVT);
  };

  if (CC != CallingConv::Fast || VT.isScalableVector())
    return DefaultImpl();

  // fastcc - map everything to vregs.
  auto LK = getCustomTypeConversion(Context, VT);
  // Non-custom converted type - back to builtin logic.
  if (!LK.has_value())
    return DefaultImpl();

  // Compute the fixed point of the custom type conversion rules.
  // We want to have the same vector layout inside functions as well as across
  // function boundaries.

  // IntermediateVT : used to copy the parts.
  IntermediateVT = VT;
  NumIntermediates = 1;

  EVT NextVT;
  do {
    NextVT = LK->second;
    auto LTA = LK->first;

    switch (LTA) {
    default:
      return DefaultImpl();

    case LegalizeTypeAction::TypePromoteFloat:
    case LegalizeTypeAction::TypePromoteInteger:
      // Promote elements across call boundaries.
      IntermediateVT = NextVT;
      break;

    case LegalizeTypeAction::TypeWidenVector:
      // Retain all information about the original vector length.
      // That is, keep the IntermediateVT at the original vector length if
      // possible
      break;

    case LegalizeTypeAction::TypeSplitVector:
      // The last split results in the intermediate VT used for copying vectors
      // at calls.
      IntermediateVT = NextVT;
      NumIntermediates *= 2;
      break;
    }

    LK = getCustomTypeConversion(Context, NextVT);
  } while (LK.has_value());

  RegisterVT = NextVT.getSimpleVT();

  // Must converge in a valid RegisterVT.
  return NumIntermediates;
}
