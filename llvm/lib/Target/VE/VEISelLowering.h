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

  EH_SJLJ_SETJMP,           // SjLj exception handling setjmp.
  EH_SJLJ_LONGJMP,          // SjLj exception handling longjmp.
  EH_SJLJ_SETUP_DISPATCH,   // SjLj exception handling setup_dispatch.

  Hi,
  Lo, // Hi/Lo operations, typically on a global address.

  GETFUNPLT,   // load function address through %plt insturction
  GETSTACKTOP, // retrieve address of stack top (first address of
               // locals and temporaries)
  GETTLSADDR,  // load address for TLS access

  MEMBARRIER,  // Compiler barrier only; generate a no-op.

  CALL,        // A call instruction.
  RET_FLAG,    // Return with a flag operand.
  GLOBAL_BASE_REG, // Global base reg for PIC.
  FLUSHW,      // FLUSH register windows to stack.

  VEC_BROADCAST,   // a scalar value is broadcast across all vector lanes (Operand 0: the broadcast register)
  VEC_SEQ,         // sequence vector match (Operand 0: the constant stride)

  VEC_VMV,

  /// Scatter and gather instructions.
  VEC_GATHER,
  VEC_SCATTER,

  VEC_LVL,

  /// A wrapper node for TargetConstantPool, TargetJumpTable,
  /// TargetExternalSymbol, TargetGlobalAddress, TargetGlobalTLSAddress,
  /// MCSymbol and TargetBlockAddress.
  Wrapper,
};
}

class VETargetLowering : public TargetLowering {
  const VESubtarget *Subtarget;

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

  /// Custom Lower {
  SDValue LowerOperation(SDValue Op, SelectionDAG &DAG) const override;

  SDValue LowerVASTART(SDValue Op, SelectionDAG &DAG) const;
  SDValue LowerVAARG(SDValue Op, SelectionDAG &DAG) const;
  SDValue LowerBlockAddress(SDValue Op, SelectionDAG &DAG) const;
  SDValue LowerGlobalAddress(SDValue Op, SelectionDAG &DAG) const;
  SDValue LowerGlobalTLSAddress(SDValue Op, SelectionDAG &DAG) const;
  SDValue LowerToTLSGeneralDynamicModel(SDValue Op, SelectionDAG &DAG) const;
  SDValue LowerToTLSLocalExecModel(SDValue Op, SelectionDAG &DAG) const;
  /// } Custom Lower

  SDValue withTargetFlags(SDValue Op, unsigned TF, SelectionDAG &DAG) const;
  SDValue makeHiLoPair(SDValue Op, unsigned HiTF, unsigned LoTF,
                       SelectionDAG &DAG) const;
  SDValue makeAddress(SDValue Op, SelectionDAG &DAG) const;

  bool isFPImmLegal(const APFloat &Imm, EVT VT,
                    bool ForCodeSize) const override;
  /// Returns true if the target allows unaligned memory accesses of the
  /// specified type.
  bool allowsMisalignedMemoryAccesses(EVT VT, unsigned AS, unsigned Align,
                                      MachineMemOperand::Flags Flags,
                                      bool *Fast) const override;

  // SX-Aurora VE s/udiv is 5-9 times slower than multiply.
  bool isIntDivCheap(EVT VT, AttributeList Attr) const override
  { return false; }

  /// computeKnownBitsForTargetNode - Determine which of the bits specified
  /// in Mask are known to be either zero or one and return them in the
  /// KnownZero/KnownOne bitsets.
  void computeKnownBitsForTargetNode(const SDValue Op,
                                     KnownBits &Known,
                                     const APInt &DemandedElts,
                                     const SelectionDAG &DAG,
                                     unsigned Depth = 0) const override;

  MachineBasicBlock *
  EmitInstrWithCustomInserter(MachineInstr &MI,
                              MachineBasicBlock *MBB) const override;

#if 0
  SDValue PerformDAGCombine(SDNode *N, DAGCombinerInfo &DCI) const override;
#endif

  ConstraintType getConstraintType(StringRef Constraint) const override;
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

  std::pair<unsigned, const TargetRegisterClass *>
  getRegForInlineAsmConstraint(const TargetRegisterInfo *TRI,
                               StringRef Constraint, MVT VT) const override;

  bool isOffsetFoldingLegal(const GlobalAddressSDNode *GA) const override;

  /// Override to support customized stack guard loading.
  bool useLoadStackGuardNode() const override;
  void insertSSPDeclarations(Module &M) const override;

  SDValue LowerConstantPool(SDValue Op, SelectionDAG &DAG) const;
  SDValue LowerBUILD_VECTOR(SDValue Op, SelectionDAG &DAG) const;

  SDValue LowerBitcast(SDValue Op, SelectionDAG &DAG) const;

  SDValue LowerVECTOR_SHUFFLE(SDValue Op, SelectionDAG &DAG) const;

  SDValue LowerMGATHER_MSCATTER(SDValue Op, SelectionDAG &DAG) const;

  SDValue LowerMLOAD(SDValue Op, SelectionDAG &DAG) const;

  SDValue LowerEH_SJLJ_SETJMP(SDValue Op, SelectionDAG &DAG) const;
  SDValue LowerEH_SJLJ_LONGJMP(SDValue Op, SelectionDAG &DAG) const;
  SDValue LowerEH_SJLJ_SETUP_DISPATCH(SDValue Op, SelectionDAG &DAG) const;

  unsigned getSRetArgSize(SelectionDAG &DAG, SDValue Callee) const;

  SDValue LowerINTRINSIC_VOID(SDValue Op, SelectionDAG &DAG) const;
  SDValue LowerINTRINSIC_W_CHAIN(SDValue Op, SelectionDAG &DAG) const;
  SDValue LowerINTRINSIC_WO_CHAIN(SDValue Op, SelectionDAG &DAG) const;

  SDValue LowerDYNAMIC_STACKALLOC(SDValue Op, SelectionDAG &DAG) const;

  SDValue LowerATOMIC_FENCE(SDValue Op, SelectionDAG &DAG) const;
  SDValue LowerATOMIC_LOAD(SDValue Op, SelectionDAG &DAG) const;
  SDValue LowerATOMIC_STORE(SDValue Op, SelectionDAG &DAG) const;

  // Should we expand the build vector with shuffles?
  bool shouldExpandBuildVectorWithShuffles(EVT VT,
      unsigned DefinedValues) const override;

  SDValue LowerEXTRACT_VECTOR_ELT(SDValue Op, SelectionDAG &DAG) const;
  SDValue LowerINSERT_VECTOR_ELT(SDValue Op, SelectionDAG &DAG) const;

  bool ShouldShrinkFPConstant(EVT VT) const override {
    // Do not shrink FP constpool if VT == MVT::f128.
    // (ldd, call _Q_fdtoq) is more expensive than two ldds.
    return VT != MVT::f128;
  }

  bool mergeStoresAfterLegalization(EVT) const override { return true; }

  bool canMergeStoresTo(unsigned AddressSpace, EVT MemVT,
                        const SelectionDAG &DAG) const override;

  unsigned getJumpTableEncoding() const override;

  const MCExpr *
  LowerCustomJumpTableEntry(const MachineJumpTableInfo *MJTI,
                            const MachineBasicBlock *MBB, unsigned uid,
                            MCContext &Ctx) const override;

  bool shouldInsertFencesForAtomic(const Instruction *I) const override {
    // VE uses Release consistency, so need fence for each atomics.
    return true;
  }
  Instruction *emitLeadingFence(IRBuilder<> &Builder, Instruction *Inst,
                                AtomicOrdering Ord) const override;
  Instruction *emitTrailingFence(IRBuilder<> &Builder, Instruction *Inst,
                                 AtomicOrdering Ord) const override;

  AtomicExpansionKind shouldExpandAtomicRMWInIR(AtomicRMWInst *AI) const override;

  void ReplaceNodeResults(SDNode *N,
                          SmallVectorImpl<SDValue>& Results,
                          SelectionDAG &DAG) const override;

  MachineBasicBlock *expandSelectCC(MachineInstr &MI, MachineBasicBlock *BB,
                                    unsigned BROpcode) const;
  MachineBasicBlock *emitEHSjLjSetJmp(MachineInstr &MI,
                                      MachineBasicBlock *MBB) const;
  MachineBasicBlock *emitEHSjLjLongJmp(MachineInstr &MI,
                                       MachineBasicBlock *MBB) const;
  MachineBasicBlock *EmitSjLjDispatchBlock(MachineInstr &MI,
                                           MachineBasicBlock *BB) const;
  void SetupEntryBlockForSjLj(MachineInstr &MI, MachineBasicBlock *MBB,
                              MachineBasicBlock *DispatchBB, int FI) const;
  void finalizeLowering(MachineFunction &MF) const override;

  bool isVectorMaskType(EVT VT) const;

  /// Target Optimization {

  bool hasAndNot(SDValue Y) const override;

  // VE supports only vector FMA
  bool isFMAFasterThanFMulAndFAdd(const MachineFunction &MF,
                                  EVT VT) const override
  { return VT.isVector() ? true : false; }

  /// } Target Optimization
};
} // namespace llvm

#endif // VE_ISELLOWERING_H
