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
#include "llvm/CodeGen/TargetLowering.h"

namespace llvm {
class VESubtarget;

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

  FLUSHW,          // FLUSH register windows to stack.

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
  VEC_BROADCAST,          // A vector broadcast instruction.
                          //   0: scalar value, 1: VL
  VEC_GATHER,      // Gather instructions.
  VEC_LVL,
  VEC_SCATTER,     // Scatter instructions.
  VEC_SEQ,         // Sequence vector match (Operand 0: the constant stride).
  VEC_VMV,

  /// A wrapper node for TargetConstantPool, TargetJumpTable,
  /// TargetExternalSymbol, TargetGlobalAddress, TargetGlobalTLSAddress,
  /// MCSymbol and TargetBlockAddress.
  Wrapper,

// VVP_* nodes.
#define ADD_VVP_OP(VVP_NAME, ...) VVP_NAME,
#include "VVPNodes.def"
};
}

class VETargetLowering : public TargetLowering {
  const VESubtarget *Subtarget;

  void initRegisterClasses();
  void initSPUActions();
  void initVPUActions();
  void initIntrinsicActions();
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
  Instruction *emitLeadingFence(IRBuilder<> &Builder, Instruction *Inst,
                                AtomicOrdering Ord) const override;
  Instruction *emitTrailingFence(IRBuilder<> &Builder, Instruction *Inst,
                                 AtomicOrdering Ord) const override;
  TargetLoweringBase::AtomicExpansionKind
  shouldExpandAtomicRMWInIR(AtomicRMWInst *AI) const override;

  /// Custom Lower {
  SDValue LowerOperation(SDValue Op, SelectionDAG &DAG) const override;
  unsigned getJumpTableEncoding() const override;
  const MCExpr *LowerCustomJumpTableEntry(const MachineJumpTableInfo *MJTI,
                                          const MachineBasicBlock *MBB,
                                          unsigned Uid,
                                          MCContext &Ctx) const override;
  SDValue getPICJumpTableRelocBase(SDValue Table,
                                   SelectionDAG &DAG) const override;
  // VE doesn't need getPICJumpTableRelocBaseExpr since it is used for only
  // EK_LabelDifference32.

  SDValue lowerATOMIC_FENCE(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerATOMIC_SWAP(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerBUILD_VECTOR(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerBlockAddress(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerConstantPool(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerDYNAMIC_STACKALLOC(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerEH_SJLJ_LONGJMP(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerEH_SJLJ_SETJMP(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerEH_SJLJ_SETUP_DISPATCH(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerEXTRACT_VECTOR_ELT(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerGlobalAddress(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerGlobalTLSAddress(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerINSERT_VECTOR_ELT(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerINTRINSIC_VOID(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerINTRINSIC_W_CHAIN(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerINTRINSIC_WO_CHAIN(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerJumpTable(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerLOAD(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerMGATHER(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerMLOAD(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerMSCATTER(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerSTORE(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerToTLSGeneralDynamicModel(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerToTLSLocalExecModel(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerVASTART(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerVAARG(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerVECTOR_SHUFFLE(SDValue Op, SelectionDAG &DAG) const;
  /// } Custom Lower

  /// Replace the results of node with an illegal result
  /// type with new values built out of custom code.
  ///
  void ReplaceNodeResults(SDNode *N, SmallVectorImpl<SDValue> &Results,
                          SelectionDAG &DAG) const override;

  /// Custom Lower for SIMD {
  SDValue lowerSIMD_BUILD_VECTOR(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerSIMD_EXTRACT_VECTOR_ELT(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerSIMD_INSERT_VECTOR_ELT(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerSIMD_VECTOR_SHUFFLE(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerSIMD_MGATHER_MSCATTER(SDValue Op, SelectionDAG &DAG) const;
  SDValue lowerSIMD_MLOAD(SDValue Op, SelectionDAG &DAG) const;
  /// } Custom Lower for SIMD

  /// Custom Lower for VVP {
  SDValue lowerVVP_BUILD_VECTOR(SDValue Op, SelectionDAG &DAG) const;
  /// } Custom Lower for VVP

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

  /// VVP Lowering {
  SDValue lowerToVVP(SDValue Op, SelectionDAG &DAG) const;
  /// } VVPLowering

  /// Custom DAGCombine {
  SDValue PerformDAGCombine(SDNode *N, DAGCombinerInfo &DCI) const override;

  SDValue combineExtBoolTrunc(SDNode *N, DAGCombinerInfo &DCI) const;
  SDValue combineTRUNCATE(SDNode *N, DAGCombinerInfo &DCI) const;
  SDValue combineSetCC(SDNode *N, DAGCombinerInfo &DCI) const;
  SDValue combineSelectCC(SDNode *N, DAGCombinerInfo &DCI) const;
  SDValue combineSelect(SDNode *N, DAGCombinerInfo &DCI) const;
  /// } Custom DAGCombine

  SDValue withTargetFlags(SDValue Op, unsigned TF, SelectionDAG &DAG) const;
  SDValue makeHiLoPair(SDValue Op, unsigned HiTF, unsigned LoTF,
                       SelectionDAG &DAG) const;
  SDValue makeAddress(SDValue Op, SelectionDAG &DAG) const;

  bool isOffsetFoldingLegal(const GlobalAddressSDNode *GA) const override;
  bool isFPImmLegal(const APFloat &Imm, EVT VT,
                    bool ForCodeSize) const override;
  /// Returns true if the target allows unaligned memory accesses of the
  /// specified type.
  bool allowsMisalignedMemoryAccesses(EVT VT, unsigned AS, unsigned Align,
                                      MachineMemOperand::Flags Flags,
                                      bool *Fast) const override;

  /// computeKnownBitsForTargetNode - Determine which of the bits specified
  /// in Mask are known to be either zero or one and return them in the
  /// KnownZero/KnownOne bitsets.
  void computeKnownBitsForTargetNode(const SDValue Op,
                                     KnownBits &Known,
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

  SDValue generateEquivalentSub(SDNode *N, bool Signed, bool Complement,
                                bool Swap, SelectionDAG &DAG) const;
  SDValue generateEquivalentCmp(SDNode *N, bool UseCompAsBase,
                                SelectionDAG &DAG) const;
  SDValue generateEquivalentLdz(SDNode *N, bool Complement,
                                SelectionDAG &DAG) const;

  ConstraintWeight
  getSingleConstraintMatchWeight(AsmOperandInfo &info,
                                 const char *constraint) const override;
  void LowerAsmOperandForConstraint(SDValue Op,
                                    std::string &Constraint,
                                    std::vector<SDValue> &Ops,
                                    SelectionDAG &DAG) const override;

  unsigned
  getInlineAsmMemConstraint(StringRef ConstraintCode) const override {
    if (ConstraintCode == "o")
      return InlineAsm::Constraint_o;
    return TargetLowering::getInlineAsmMemConstraint(ConstraintCode);
  }

  /// Inline Assembly {

  ConstraintType getConstraintType(StringRef Constraint) const override;
  std::pair<unsigned, const TargetRegisterClass *>
  getRegForInlineAsmConstraint(const TargetRegisterInfo *TRI,
                               StringRef Constraint, MVT VT) const override;

  /// } Inline Assembly

  /// Override to support customized stack guard loading.
  bool useLoadStackGuardNode() const override;
  void insertSSPDeclarations(Module &M) const override;

  unsigned getSRetArgSize(SelectionDAG &DAG, SDValue Callee) const;

  // Should we expand the build vector with shuffles?
  bool shouldExpandBuildVectorWithShuffles(EVT VT,
      unsigned DefinedValues) const override;

  bool ShouldShrinkFPConstant(EVT VT) const override {
    // Do not shrink FP constpool if VT == MVT::f128.
    // (ldd, call _Q_fdtoq) is more expensive than two ldds.
    return VT != MVT::f128;
  }

  bool mergeStoresAfterLegalization(EVT) const override { return true; }

  bool canMergeStoresTo(unsigned AddressSpace, EVT MemVT,
                        const SelectionDAG &DAG) const override;

  MachineBasicBlock *expandSelectCC(MachineInstr &MI, MachineBasicBlock *BB,
                                    unsigned BROpcode) const;
  void finalizeLowering(MachineFunction &MF) const override;

  bool isVectorMaskType(EVT VT) const;

  bool convertSetCCLogicToBitwiseLogic(EVT VT) const override {
    return true;
  }

  // VE supports only vector FMA
  bool isFMAFasterThanFMulAndFAdd(const MachineFunction &MF,
                                  EVT VT) const override
  { return VT.isVector() ? true : false; }

  /// Target Optimization {

  // Return lower limit for number of blocks in a jump table.
  unsigned getMinimumJumpTableEntries() const override;

  // SX-Aurora VE's s/udiv is 5-9 times slower than multiply.
  bool isIntDivCheap(EVT, AttributeList) const override { return false; }
  // VE doesn't have rem.
  bool hasStandaloneRem(EVT) const override { return false; }
  // VE LDZ instruction returns 64 if the input is zero.
  bool isCheapToSpeculateCtlz() const override { return true; }
  // VE LDZ instruction is fast.
  bool isCtlzFast() const override { return true; }
  // VE has NND instruction.
  bool hasAndNot(SDValue Y) const override;

  /// } Target Optimization
};
} // namespace llvm

#endif // VE_ISELLOWERING_H
