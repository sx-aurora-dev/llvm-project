//===-- VEISelLowering.h - VE DAG Lowering Interface ------------*- C++ -*-===//
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

#ifndef LLVM_LIB_TARGET_VE_VEISELLOWERING_H
#define LLVM_LIB_TARGET_VE_VEISELLOWERING_H

#include "VE.h"
#include "VELoweringInfo.h"
#include "llvm/CodeGen/TargetLowering.h"
#include <optional>
#include <set>

namespace llvm {
class VESubtarget;
struct VECustomDAG;
struct MaskView;

namespace VEISD {
enum NodeType : unsigned {
  FIRST_NUMBER = ISD::BUILTIN_OP_END,

  EQV,  // Equivalence between two integer values.
  XOR,  // Exclusive-or between two integer values.
  CMPI, // Compare between two signed integer values.
  CMPU, // Compare between two unsigned integer values.
  CMPF, // Compare between two floating-point values.
  CMPQ, // Compare between two quad floating-point values.
  CMOV, // Select between two values using the result of comparison.

  FLUSHW, // FLUSH register windows to stack.

  CALL,                   // A call instruction.
  EH_SJLJ_LONGJMP,        // SjLj exception handling longjmp.
  EH_SJLJ_SETJMP,         // SjLj exception handling setjmp.
  EH_SJLJ_SETUP_DISPATCH, // SjLj exception handling setup_dispatch.
  GETFUNPLT,              // Load function address through %plt insturction.
  GETTLSADDR,             // Load address for TLS access.
  GETSTACKTOP,            // Retrieve address of stack top (first address of
                          // locals and temporaries).
  GLOBAL_BASE_REG,        // Global base reg for PIC.
  Hi,                     // Hi/Lo operations, typically on a global address.
  Lo,                     // Hi/Lo operations, typically on a global address.
  MEMBARRIER,             // Compiler barrier only; generate a no-op.
  RET_FLAG,               // Return with a flag operand.
  TS1AM,                  // A TS1AM instruction used for 1/2 bytes swap.

  // Mask support
  VM_POPCOUNT, // VM_POPCOUNT(v256i1: mask, i32:avl) -> i64
  VM_EXTRACT,  // VM_EXTRACT(v256i1:mask, i32:i) Extract a SX register from a
               // mask register
  VM_INSERT, // VM_INSERT(v256i1:mask, i32:i, i64:val) Insert a SX register into
             // a mask register
  VM_FIRST = VM_POPCOUNT,
  VM_LAST = VM_INSERT,

  /// VEC_ {
  // Packed mode support
  VEC_UNPACK_LO, // unpack the lo v256 slice of a packed v512 vector.
  VEC_UNPACK_HI, // unpack the hi v256 slice of a packed v512 vector.
                 //    0: v512 vector, 1: AVL
  VEC_PACK,      // pack a lo and a hi vector into one v512 vector
                 //    0: v256 lo vector, 1: v256 hi vector, 2: AVL
  VEC_SWAP, // exchange the odd-even positions (v256i32 <> v256f32) or (v512x32
            // <> v512y32) x != y

  VEC_BROADCAST, // A vector broadcast instruction.
                 //   0: scalar value, 1: VL

  VEC_GATHER,
  VEC_SCATTER,

  VEC_LVL, // TODO document - used by SIMD isel patterns.

  // Create a mask that is true where the vector lane is != 0
  VEC_TOMASK, // 0: Vector value, 1: AVL (no mask)
  // Create a sequence vector
  VEC_SEQ, // 1: the vector length (no mask)
  VEC_VMV, // custom lowering for vp_vshift

  // narrowing marker
  VEC_NARROW, // (Op, vector length)

  // VEC_* operator range
  VEC_FIRST = VEC_UNPACK_LO,
  VEC_LAST = VEC_NARROW,
  /// } VEC_

  // Replication on lower/upper32 bit to other half -> I64
  REPL_F32,
  REPL_I32,

  /// A wrapper node for TargetConstantPool, TargetJumpTable,
  /// TargetExternalSymbol, TargetGlobalAddress, TargetGlobalTLSAddress,
  /// MCSymbol and TargetBlockAddress.
  Wrapper,

  // Annotation as a wrapper. LEGALAVL(VL) means that VL refers to 64bit of
  // data, whereas the raw EVL coming in from VP nodes always refers to number
  // of elements, regardless of their size.
  LEGALAVL,

// VVP_* nodes.
#define ADD_VVP_OP(VVP_NAME, ...) VVP_NAME,
#include "VVPNodes.def"
  // TODO: Use 'FIRST_TARGET_MEMORY_OPCODE'
};
} // namespace VEISD

using VecLenOpt = std::optional<unsigned>;

struct VVPWideningInfo {
  EVT ResultVT;
  unsigned ActiveVectorLength;
  bool PackedMode;
  bool NeedsPackedMasking;

  bool isValid() const { return ActiveVectorLength != 0; }

  VVPWideningInfo(EVT ResultVT, unsigned StaticVL, bool PackedMode,
                  bool NeedsPackedMasking)
      : ResultVT(ResultVT), ActiveVectorLength(StaticVL),
        PackedMode(PackedMode), NeedsPackedMasking(NeedsPackedMasking) {}

  VVPWideningInfo()
      : ResultVT(), ActiveVectorLength(0), PackedMode(false),
        NeedsPackedMasking(false) {}
};

class VETargetLowering final : public TargetLowering, public VELoweringInfo {
  const VESubtarget *Subtarget;

  void initRegisterClasses();
  void initRegisterClasses_VVP();

  // setOperationAction for all scalar ops
  void initSPUActions();
  // setOperationAction for all vector ops
  void initVPUActions();
  // setOperationAction for the fixed-SIMD code path
  void initSIMDActions();

public:
  VETargetLowering(const TargetMachine &TM, const VESubtarget &STI);

  const char *getTargetNodeName(unsigned Opcode) const override;
  MVT getScalarShiftAmountTy(const DataLayout &, EVT) const override {
    return MVT::i32;
  }

  Register getRegisterByName(const char *RegName, LLT VT,
                             const MachineFunction &MF) const override;

  /// getSetCCResultType - Return the ISD::SETCC ValueType
  EVT getSetCCResultType(const DataLayout &DL, LLVMContext &Context,
                         EVT VT) const override;

  SDValue LowerFormalArguments(SDValue Chain, CallingConv::ID CallConv,
                               bool isVarArg,
                               const SmallVectorImpl<ISD::InputArg> &Ins,
                               const SDLoc &dl, SelectionDAG &DAG,
                               SmallVectorImpl<SDValue> &InVals) const override;

  SDValue LowerCall(TargetLowering::CallLoweringInfo &CLI,
                    SmallVectorImpl<SDValue> &InVals) const override;

  bool CanLowerReturn(CallingConv::ID CallConv, MachineFunction &MF,
                      bool isVarArg,
                      const SmallVectorImpl<ISD::OutputArg> &ArgsFlags,
                      LLVMContext &Context) const override;
  SDValue LowerReturn(SDValue Chain, CallingConv::ID CallConv, bool isVarArg,
                      const SmallVectorImpl<ISD::OutputArg> &Outs,
                      const SmallVectorImpl<SDValue> &OutVals, const SDLoc &dl,
                      SelectionDAG &DAG) const override;

  /// Helper functions for atomic operations.
  bool shouldInsertFencesForAtomic(const Instruction *I) const override {
    // VE uses release consistency, so need fence for each atomics.
    return true;
  }
  Instruction *emitLeadingFence(IRBuilderBase &Builder, Instruction *Inst,
                                AtomicOrdering Ord) const override;
  Instruction *emitTrailingFence(IRBuilderBase &Builder, Instruction *Inst,
                                 AtomicOrdering Ord) const override;
  TargetLoweringBase::AtomicExpansionKind
  shouldExpandAtomicRMWInIR(AtomicRMWInst *AI) const override;
  ISD::NodeType getExtendForAtomicOps() const override {
    return ISD::ANY_EXTEND;
  }

  /// Custom CC Mapping {
  using RegisterCountPair = std::pair<MVT, unsigned>;
  // Map all vector EVTs to vector or vector mask registers.
  MVT getRegisterTypeForCallingConv(LLVMContext &Context, CallingConv::ID CC,
                                    EVT VT) const override {
    auto Opt = getRegistersForCallingConv(Context, CC, VT);
    if (!Opt.has_value())
      return TargetLowering::getRegisterTypeForCallingConv(Context, CC, VT);
    return Opt->first;
  }

  unsigned getNumRegistersForCallingConv(LLVMContext &Context,
                                         CallingConv::ID CC,
                                         EVT VT) const override {
    auto Opt = getRegistersForCallingConv(Context, CC, VT);
    if (!Opt.has_value())
      return TargetLowering::getNumRegistersForCallingConv(Context, CC, VT);
    return Opt->second;
  }

  std::optional<RegisterCountPair>
  getRegistersForCallingConv(LLVMContext &Context,
                             CallingConv::ID CC, EVT VT) const;

  unsigned getVectorTypeBreakdownForCallingConv(LLVMContext &Context,
                                                CallingConv::ID CC, EVT VT,
                                                EVT &IntermediateVT,
                                                unsigned &NumIntermediates,
                                                MVT &RegisterVT) const override;
  /// } Custom CC Mapping

  /// Custom Lower {
  TargetLoweringBase::LegalizeAction
  getCustomOperationAction(SDNode &) const override;

  SDValue LowerOperation(SDValue Op, SelectionDAG &DAG) const override;
  unsigned getJumpTableEncoding() const override;
  const MCExpr *LowerCustomJumpTableEntry(const MachineJumpTableInfo *MJTI,
                                          const MachineBasicBlock *MBB,
                                          unsigned Uid,
                                          MCContext &Ctx) const override;

  // Lowering hooks.
  // Only used by VVP layer to intercept EVT-typed nodes before MVT widening
  // kicks in.
  // TODO: Clean these hooks implemented in
  //       `include/llvm/CodeGen/TargetLowering.h`
  TargetLowering::LegalizeAction
  getActionForExtendedType(unsigned Op, EVT VT) const override;
  std::optional<LegalizeKind> getCustomTypeConversion(LLVMContext &Context,
                                                      EVT VT) const override;

  void LowerOperationWrapper(
      SDNode *N, SmallVectorImpl<SDValue> &Results, SelectionDAG &DAG,
      std::function<SDValue(SDValue)> PromotedopCB,
      std::function<SDValue(SDValue)> WidenedOpCB) const override;

  SDNode *widenInternalVectorOperation(SDNode *N, SelectionDAG &DAG) const;
  // legalize the result vector type for operation \p Op

  // Custom Operations
  // SDValue CreateConstMask(SDLoc DL, unsigned NumElements, SelectionDAG &DAG,
  // bool IsTrue=true) const; SDValue CreateBroadcast(SDLoc dl, EVT ResTy,
  // SDValue ScaValue, SelectionDAG &DAG, std::optional<SDValue> OpVectorLength=std::nullopt)
  // const; SDValue CreateSeq(SDLoc dl, EVT ResTy, SelectionDAG &DAG,
  // std::optional<SDValue> OpVectorLength=std::nullopt) const;

  // Vector Operations
  // main shuffle handler
  // SDValue LowerVECTOR_SHUFFLE(SDValue Op, SelectionDAG &DAG, VVPExpansionMode
  // Mode) const; SDValue LowerBUILD_VECTOR(SDValue Op, SelectionDAG &DAG,
  // VVPExpansionMode Mode) const;

  /// Custom Lower {
  SDValue lowerVAARG(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerVASTART(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerATOMIC_FENCE(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerATOMIC_SWAP(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerBlockAddress(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerConstantPool(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerDYNAMIC_STACKALLOC(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerEH_SJLJ_LONGJMP(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerEH_SJLJ_SETJMP(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerEH_SJLJ_SETUP_DISPATCH(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerGlobalAddress(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerGlobalTLSAddress(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerINTRINSIC_VOID(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerINTRINSIC_W_CHAIN(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerINTRINSIC_WO_CHAIN(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerJumpTable(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerLOAD(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerSTORE(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerToTLSGeneralDynamicModel(SDValue Op, SelectionDAG &DAG) const;
  /// } Custom Lower

  /// Replace the results of node with an illegal result
  /// type with new values built out of custom code.
  ///
  void ReplaceNodeResults(SDNode *N, SmallVectorImpl<SDValue> &Results,
                          SelectionDAG &DAG) const override;

  /// Custom Lower for SIMD {
  SDValue LowerOperation_SIMD(SDValue Op, SelectionDAG &DAG) const;

  SDValue lowerSIMD_MLOAD(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerSIMD_BUILD_VECTOR(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerSIMD_EXTRACT_VECTOR_ELT(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerSIMD_INSERT_VECTOR_ELT(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerSIMD_VECTOR_SHUFFLE(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerSIMD_MGATHER_MSCATTER(SDValue Op, SelectionDAG &DAG) const;
  /// } Custom Lower for SIMD

  /// VVP Lowering {
  // internal node tracker reset checkpoint.

  // Expand SETCC operands directly used in vector arithmetic ops.
  SDValue lowerSETCCInVectorArithmetic(SDValue Op, SelectionDAG &DAG) const;
  SDValue expandSELECT(SDValue MaskV, SDValue OnTrueV, SDValue OnFalseV,
                       EVT LegalResVT, VECustomDAG &CDAG, SDValue AVL) const;

  /// Custom Lower for VVP {
  SDValue LowerOperation_VVP(SDValue Op, SelectionDAG &DAG) const;

  SDValue lowerVP_VSHIFT(SDValue Op, SelectionDAG &DAG) const;

  SDValue lowerVVP_TRUNCATE(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerVVP_Bitcast(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerVVP_BUILD_VECTOR(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerVVP_CONCAT_VECTOR(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerVectorShuffleOp(SDValue Op, SelectionDAG &DAG,
                               VVPExpansionMode) const;
  SDValue lowerVVP_EXTRACT_SUBVECTOR(SDValue Op, SelectionDAG &DAG,
                                     VVPExpansionMode) const;
  SDValue lowerVVP_SCALAR_TO_VECTOR(SDValue Op, SelectionDAG &DAG,
                                    VVPExpansionMode,
                                    VecLenOpt VecLenHint = std::nullopt) const;
  SDValue lowerVVP_INSERT_VECTOR_ELT(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerVVP_EXTRACT_VECTOR_ELT(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerVVP_GATHER_SCATTER(SDValue Op, SelectionDAG &DAG,
                                  VVPExpansionMode Mode,
                                  VecLenOpt VecLenHint = std::nullopt) const;
  SDValue lowerVVP_LOAD_STORE(SDValue Op, SelectionDAG &DAG,
                              VVPExpansionMode Mode,
                              VecLenOpt VecLenHint = std::nullopt) const;
  /// } Custom Lower for VVP

  EVT LegalizeVectorType(EVT ResTy, SDValue Op, SelectionDAG &DAG,
                         VVPExpansionMode) const override;
  VVPWideningInfo pickResultType(VECustomDAG &CDAG, SDValue Op,
                                 VVPExpansionMode Mode) const;

  LegalizeTypeAction getPreferredVectorAction(MVT VT) const override;

  // Widening configuration & legalizer
  SDValue TryNarrowExtractVectorLoad(SDNode *ExtractN, SelectionDAG &DAG) const;

  /// Custom Inserter {
  MachineBasicBlock *
  EmitInstrWithCustomInserter(MachineInstr &MI,
                              MachineBasicBlock *MBB) const override;
  MachineBasicBlock *emitEHSjLjLongJmp(MachineInstr &MI,
                                       MachineBasicBlock *MBB) const;
  MachineBasicBlock *emitEHSjLjSetJmp(MachineInstr &MI,
                                      MachineBasicBlock *MBB) const;
  MachineBasicBlock *emitSjLjDispatchBlock(MachineInstr &MI,
                                           MachineBasicBlock *BB) const;

  void setupEntryBlockForSjLj(MachineInstr &MI, MachineBasicBlock *MBB,
                              MachineBasicBlock *DispatchBB, int FI,
                              int Offset) const;
  // Setup basic block address.
  Register prepareMBB(MachineBasicBlock &MBB, MachineBasicBlock::iterator I,
                      MachineBasicBlock *TargetBB, const DebugLoc &DL) const;
  // Prepare function/variable address.
  Register prepareSymbol(MachineBasicBlock &MBB, MachineBasicBlock::iterator I,
                         StringRef Symbol, const DebugLoc &DL, bool IsLocal,
                         bool IsCall) const;
  /// } Custom Inserter

  /// Packed Op Splitting {
  SDValue synthesizeView(MaskView &MV, EVT LegalResVT, VECustomDAG &CDAG) const;
  SDValue splitVectorShuffle(SDValue Op, VECustomDAG &CDAG,
                             VVPExpansionMode Mode) const;
  SDValue splitVectorOp(SDValue Op, VECustomDAG &CDAG,
                        VVPExpansionMode Mode) const;
  SDValue computeGatherScatterAddress(VECustomDAG &CDAG, SDValue BasePtr,
                                      SDValue Scale, SDValue Index,
                                      SDValue Mask, SDValue AVL) const;
  SDValue splitGatherScatter(SDValue Op, VECustomDAG &CDAG,
                             VVPExpansionMode Mode) const;
  SDValue splitPackedLoadStore(SDValue Op, VECustomDAG &CDAG,
                               VVPExpansionMode Mode) const;
  // Split this packed (vector) mask operation retaining the ISD opcode.
  SDValue splitMaskArithmetic(SDValue Op, SelectionDAG &DAG) const;
  /// } Packed Op Splitting

  /// VVP Lowering {
  SDValue lowerReduction_VPToVVP(SDValue Op, SelectionDAG &DAG,
                                 VVPExpansionMode Mode) const;
  SDValue lowerVPToVVP(SDValue Op, SelectionDAG &DAG,
                       VVPExpansionMode Mode) const;
  SDValue lowerToVVP(SDValue Op, SelectionDAG &DAG,
                     VVPExpansionMode Mode) const;
  // main entry point for regular OC to VVP_* ISD expansion
  // Called in TL::ReplaceNodeResults
  // This replaces the standard ISD node with VVP VEISD node(s) with a widened
  // result type.

  // Convert the mask x AVL into AVL/2 and update the mask as necessary (VVP and
  // VEC only).
  SDValue legalizePackedAVL(SDValue Op, VECustomDAG &CDAG) const;

  // Packed splitting, packed-mode AVL/mask legalization.
  SDValue legalizeVM_POPCOUNT(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerToVVP(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerVVP_LOAD_STORE(SDValue Op, VECustomDAG &) const;
  SDValue lowerVVP_GATHER_SCATTER(SDValue Op, VECustomDAG &) const;

  SDValue legalizeInternalVectorOp(SDValue Op, SelectionDAG &DAG) const;
  SDValue legalizeInternalLoadStoreOp(SDValue Op, VECustomDAG &CDAG) const;
  /// } VVPLowering

  /// Custom DAGCombine {
  SDValue PerformDAGCombine(SDNode *N, DAGCombinerInfo &DCI) const override;
  SDValue combineVVP(SDNode *N, DAGCombinerInfo &DCI) const;
  SDValue combinePacking(SDNode *N, DAGCombinerInfo &DCI) const;
  SDValue combineCopyToRegVVP(SDNode *N, DAGCombinerInfo &DCI) const;

  SDValue combineExtBoolTrunc(SDNode *N, DAGCombinerInfo &DCI) const;
  SDValue combineSelect(SDNode *N, DAGCombinerInfo &DCI) const;
  SDValue combineSelectCC(SDNode *N, DAGCombinerInfo &DCI) const;
  SDValue combineSetCC(SDNode *N, DAGCombinerInfo &DCI) const;
  SDValue combineTRUNCATE(SDNode *N, DAGCombinerInfo &DCI) const;
  /// } Custom DAGCombine

  SDValue withTargetFlags(SDValue Op, unsigned TF, SelectionDAG &DAG) const;
  SDValue makeHiLoPair(SDValue Op, unsigned HiTF, unsigned LoTF,
                       SelectionDAG &DAG) const;
  SDValue makeAddress(SDValue Op, SelectionDAG &DAG) const;

  /// Constant Info {
  bool isOffsetFoldingLegal(const GlobalAddressSDNode *GA) const override;
  bool isFPImmLegal(const APFloat &Imm, EVT VT,
                    bool ForCodeSize) const override;
  bool ShouldShrinkFPConstant(EVT VT) const override {
    // Do not shrink FP constpool if VT == MVT::f128.
    // (ldd, call _Q_fdtoq) is more expensive than two ldds.
    return VT != MVT::f128;
  }
  /// } Constant Info
  /// Returns true if the target allows unaligned memory accesses of the
  /// specified type.
  bool allowsMisalignedMemoryAccesses(EVT VT, unsigned AS, Align A,
                                      MachineMemOperand::Flags Flags,
                                      unsigned *Fast) const override;

  /// computeKnownBitsForTargetNode - Determine which of the bits specified
  /// in Mask are known to be either zero or one and return them in the
  /// KnownZero/KnownOne bitsets.
  void computeKnownBitsForTargetNode(const SDValue Op, KnownBits &Known,
                                     const APInt &DemandedElts,
                                     const SelectionDAG &DAG,
                                     unsigned Depth = 0) const override;

  /// Return true if the target has native support for
  /// the specified value type and it is 'desirable' to use the type for the
  /// given node type. e.g. On VE i32 is legal, but undesirable i32 for
  /// AND/OR/XOR instructions since VE doesn't have those instructions for
  /// i32.
  bool isTypeDesirableForOp(unsigned Opc, EVT VT) const override;

  /// This function looks at SETCC that compares integers. It replaces
  /// SETCC with integer arithmetic operations when there is a legal way
  /// of doing it.
  SDValue optimizeSetCC(SDNode *N, DAGCombinerInfo &DCI) const;

  SDValue generateEquivalentSub(EVT VT, SDValue LHS, SDValue RHS,
                                ISD::CondCode CC, const SDLoc &DL,
                                SelectionDAG &DAG) const;
  SDValue generateEquivalentLdz(EVT VT, SDValue LHS, SDValue RHS,
                                ISD::CondCode CC, const SDLoc &DL,
                                SelectionDAG &DAG) const;

  /// Inline Assembly {
  ConstraintWeight
  getSingleConstraintMatchWeight(AsmOperandInfo &info,
                                 const char *constraint) const override;
  void LowerAsmOperandForConstraint(SDValue Op, std::string &Constraint,
                                    std::vector<SDValue> &Ops,
                                    SelectionDAG &DAG) const override;

  ConstraintType getConstraintType(StringRef Constraint) const override;
  std::pair<unsigned, const TargetRegisterClass *>
  getRegForInlineAsmConstraint(const TargetRegisterInfo *TRI,
                               StringRef Constraint, MVT VT) const override;

  unsigned getInlineAsmMemConstraint(StringRef ConstraintCode) const override {
    if (ConstraintCode == "o")
      return InlineAsm::Constraint_o;
    return TargetLowering::getInlineAsmMemConstraint(ConstraintCode);
  }

  /// } Inline Assembly

  /// Override to support customized stack guard loading.
  bool useLoadStackGuardNode() const override;
  void insertSSPDeclarations(Module &M) const override;

  SDValue getPICJumpTableRelocBase(SDValue Table,
                                   SelectionDAG &DAG) const override;
  // VE doesn't need getPICJumpTableRelocBaseExpr since it is used for only
  // EK_LabelDifference32.

  unsigned getSRetArgSize(SelectionDAG &DAG, SDValue Callee) const;

  // Should we expand the build vector with shuffles?
  bool
  shouldExpandBuildVectorWithShuffles(EVT VT,
                                      unsigned DefinedValues) const override;

  /// Returns true if the target allows unaligned memory accesses of the
  /// specified type.
  bool mergeStoresAfterLegalization(EVT) const override { return true; }

  bool canMergeStoresTo(unsigned AddressSpace, EVT MemVT,
                        const MachineFunction &MF) const override;

  MachineBasicBlock *expandSelectCC(MachineInstr &MI, MachineBasicBlock *BB,
                                    unsigned BROpcode) const;
  void finalizeLowering(MachineFunction &MF) const override;

#if 0
  // TODO map *ALL* vector types, including EVTs to vregs
  /// Certain combinations of ABIs, Targets and features require that types
  /// are legal for some operations and not for other operations.
  /// For MIPS all vector types must be passed through the integer register set.
  MVT getRegisterTypeForCallingConv(LLVMContext &Context,
                                            CallingConv::ID CC, EVT VT) const override {
  }

  /// Certain targets require unusual breakdowns of certain types. For MIPS,
  /// this occurs when a vector type is used, as vector are passed through the
  /// integer register set.
  unsigned getNumRegistersForCallingConv(LLVMContext &Context,
                                                 CallingConv::ID CC,
                                                 EVT VT) const override {
  }
#endif

  bool convertSetCCLogicToBitwiseLogic(EVT VT) const override { return true; }

  /// Target Optimization {
  // VE supports only vector FMA
  bool isFMAFasterThanFMulAndFAdd(const MachineFunction &MF,
                                  EVT VT) const override {
    return VT.isVector();
  }

  // Return lower limit for number of blocks in a jump table.
  unsigned getMinimumJumpTableEntries() const override;

  // SX-Aurora VE's s/udiv is 5-9 times slower than multiply.
  bool isIntDivCheap(EVT, AttributeList) const override { return false; }
  // VE doesn't have rem.
  bool hasStandaloneRem(EVT) const override { return false; }
  // VE LDZ instruction returns 64 if the input is zero.
  bool isCheapToSpeculateCtlz(Type *) const override { return true; }
  // VE LDZ instruction is fast.
  bool isCtlzFast() const override { return true; }
  // VE has NND instruction.
  bool hasAndNot(SDValue Y) const override;

  /// } Target Optimization
};
} // namespace llvm

#endif // LLVM_LIB_TARGET_VE_VEISELLOWERING_H
