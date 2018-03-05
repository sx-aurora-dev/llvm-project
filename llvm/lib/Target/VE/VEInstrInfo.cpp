//===-- VEInstrInfo.cpp - VE Instruction Information ----------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the VE implementation of the TargetInstrInfo class.
//
//===----------------------------------------------------------------------===//

#include "VEInstrInfo.h"
#include "VE.h"
#include "VEMachineFunctionInfo.h"
#include "VESubtarget.h"
#include "llvm/ADT/STLExtras.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/CodeGen/MachineFrameInfo.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineMemOperand.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/TargetRegistry.h"

using namespace llvm;

#define GET_INSTRINFO_CTOR_DTOR
#include "VEGenInstrInfo.inc"

// Pin the vtable to this file.
void VEInstrInfo::anchor() {}

VEInstrInfo::VEInstrInfo(VESubtarget &ST)
    : VEGenInstrInfo(VE::ADJCALLSTACKDOWN, VE::ADJCALLSTACKUP), RI(),
      Subtarget(ST) {}

/// isLoadFromStackSlot - If the specified machine instruction is a direct
/// load from a stack slot, return the virtual or physical register number of
/// the destination along with the FrameIndex of the loaded stack slot.  If
/// not, return 0.  This predicate must return 0 if the instruction has
/// any side effects other than loading from the stack slot.
unsigned VEInstrInfo::isLoadFromStackSlot(const MachineInstr &MI,
                                             int &FrameIndex) const {
#if 0
  if (MI.getOpcode() == SP::LDri || MI.getOpcode() == SP::LDXri ||
      MI.getOpcode() == SP::LDFri || MI.getOpcode() == SP::LDDFri ||
      MI.getOpcode() == SP::LDQFri) {
    if (MI.getOperand(1).isFI() && MI.getOperand(2).isImm() &&
        MI.getOperand(2).getImm() == 0) {
      FrameIndex = MI.getOperand(1).getIndex();
      return MI.getOperand(0).getReg();
    }
  }
  return 0;
#endif
  report_fatal_error("isLoadFromStackSlot is not implemented yet");
}

/// isStoreToStackSlot - If the specified machine instruction is a direct
/// store to a stack slot, return the virtual or physical register number of
/// the source reg along with the FrameIndex of the loaded stack slot.  If
/// not, return 0.  This predicate must return 0 if the instruction has
/// any side effects other than storing to the stack slot.
unsigned VEInstrInfo::isStoreToStackSlot(const MachineInstr &MI,
                                            int &FrameIndex) const {
#if 0
  if (MI.getOpcode() == SP::STri || MI.getOpcode() == SP::STXri ||
      MI.getOpcode() == SP::STFri || MI.getOpcode() == SP::STDFri ||
      MI.getOpcode() == SP::STQFri) {
    if (MI.getOperand(0).isFI() && MI.getOperand(1).isImm() &&
        MI.getOperand(1).getImm() == 0) {
      FrameIndex = MI.getOperand(0).getIndex();
      return MI.getOperand(2).getReg();
    }
  }
  return 0;
#endif
  report_fatal_error("isStoreToStackSlot is not implemented yet");
}

#if 0
static bool IsIntegerCC(unsigned CC)
{
  return  (CC <= SPCC::ICC_VC);
}
#endif

static VECC::CondCodes GetOppositeBranchCondition(VECC::CondCodes CC)
{
  switch(CC) {
  case VECC::CC_AF:     return VECC::CC_AT;
  case VECC::CC_G:      return VECC::CC_LE;
  case VECC::CC_L:      return VECC::CC_GE;
  case VECC::CC_NE:     return VECC::CC_EQ;
  case VECC::CC_EQ:     return VECC::CC_NE;
  case VECC::CC_GE:     return VECC::CC_L;
  case VECC::CC_LE:     return VECC::CC_G;
  case VECC::CC_NUM:    return VECC::CC_NAN;
  case VECC::CC_NAN:    return VECC::CC_NUM;
  case VECC::CC_GNAN:   return VECC::CC_LENAN;
  case VECC::CC_LNAN:   return VECC::CC_GENAN;
  case VECC::CC_NENAN:  return VECC::CC_EQNAN;
  case VECC::CC_EQNAN:  return VECC::CC_NENAN;
  case VECC::CC_GENAN:  return VECC::CC_LNAN;
  case VECC::CC_LENAN:  return VECC::CC_GNAN;
  case VECC::CC_AT:     return VECC::CC_AF;
  }
  llvm_unreachable("Invalid cond code");
}

#if 0
static bool isUncondBranchOpcode(int Opc) { return Opc == SP::BA; }
#endif

static bool isCondBranchOpcode(int Opc) {
#if 0
  return Opc == SP::FBCOND || Opc == SP::BCOND;
#endif
  report_fatal_error("isCondBranchOpcode is not implemented yet");
}

static bool isIndirectBranchOpcode(int Opc) {
#if 0
  return Opc == SP::BINDrr || Opc == SP::BINDri;
#endif
  report_fatal_error("isIndirectBranchOpcode is not implemented yet");
}

static void parseCondBranch(MachineInstr *LastInst, MachineBasicBlock *&Target,
                            SmallVectorImpl<MachineOperand> &Cond) {
#if 0
  Cond.push_back(MachineOperand::CreateImm(LastInst->getOperand(1).getImm()));
  Target = LastInst->getOperand(0).getMBB();
#endif
  report_fatal_error("parseCondBranch is not implemented yet");
}

bool VEInstrInfo::analyzeBranch(MachineBasicBlock &MBB,
                                   MachineBasicBlock *&TBB,
                                   MachineBasicBlock *&FBB,
                                   SmallVectorImpl<MachineOperand> &Cond,
                                   bool AllowModify) const {
#if 0
  MachineBasicBlock::iterator I = MBB.getLastNonDebugInstr();
  if (I == MBB.end())
    return false;

  if (!isUnpredicatedTerminator(*I))
    return false;

  // Get the last instruction in the block.
  MachineInstr *LastInst = &*I;
  unsigned LastOpc = LastInst->getOpcode();

  // If there is only one terminator instruction, process it.
  if (I == MBB.begin() || !isUnpredicatedTerminator(*--I)) {
    if (isUncondBranchOpcode(LastOpc)) {
      TBB = LastInst->getOperand(0).getMBB();
      return false;
    }
    if (isCondBranchOpcode(LastOpc)) {
      // Block ends with fall-through condbranch.
      parseCondBranch(LastInst, TBB, Cond);
      return false;
    }
    return true; // Can't handle indirect branch.
  }

  // Get the instruction before it if it is a terminator.
  MachineInstr *SecondLastInst = &*I;
  unsigned SecondLastOpc = SecondLastInst->getOpcode();

  // If AllowModify is true and the block ends with two or more unconditional
  // branches, delete all but the first unconditional branch.
  if (AllowModify && isUncondBranchOpcode(LastOpc)) {
    while (isUncondBranchOpcode(SecondLastOpc)) {
      LastInst->eraseFromParent();
      LastInst = SecondLastInst;
      LastOpc = LastInst->getOpcode();
      if (I == MBB.begin() || !isUnpredicatedTerminator(*--I)) {
        // Return now the only terminator is an unconditional branch.
        TBB = LastInst->getOperand(0).getMBB();
        return false;
      } else {
        SecondLastInst = &*I;
        SecondLastOpc = SecondLastInst->getOpcode();
      }
    }
  }

  // If there are three terminators, we don't know what sort of block this is.
  if (SecondLastInst && I != MBB.begin() && isUnpredicatedTerminator(*--I))
    return true;

  // If the block ends with a B and a Bcc, handle it.
  if (isCondBranchOpcode(SecondLastOpc) && isUncondBranchOpcode(LastOpc)) {
    parseCondBranch(SecondLastInst, TBB, Cond);
    FBB = LastInst->getOperand(0).getMBB();
    return false;
  }

  // If the block ends with two unconditional branches, handle it.  The second
  // one is not executed.
  if (isUncondBranchOpcode(SecondLastOpc) && isUncondBranchOpcode(LastOpc)) {
    TBB = SecondLastInst->getOperand(0).getMBB();
    return false;
  }

  // ...likewise if it ends with an indirect branch followed by an unconditional
  // branch.
  if (isIndirectBranchOpcode(SecondLastOpc) && isUncondBranchOpcode(LastOpc)) {
    I = LastInst;
    if (AllowModify)
      I->eraseFromParent();
    return true;
  }

  // Otherwise, can't handle this.
  return true;
#endif
  report_fatal_error("analyzeBranch is not implemented yet");
}

unsigned VEInstrInfo::insertBranch(MachineBasicBlock &MBB,
                                      MachineBasicBlock *TBB,
                                      MachineBasicBlock *FBB,
                                      ArrayRef<MachineOperand> Cond,
                                      const DebugLoc &DL,
                                      int *BytesAdded) const {
  assert(TBB && "insertBranch must not be told to insert a fallthrough");
  assert((Cond.size() == 1 || Cond.size() == 0) &&
         "VE branch conditions should have one component!");
  assert(!BytesAdded && "code size not handled");
#if 0
  if (Cond.empty()) {
    assert(!FBB && "Unconditional branch with multiple successors!");
    BuildMI(&MBB, DL, get(SP::BA)).addMBB(TBB);
    return 1;
  }

  // Conditional branch
  unsigned CC = Cond[0].getImm();

  if (IsIntegerCC(CC))
    BuildMI(&MBB, DL, get(SP::BCOND)).addMBB(TBB).addImm(CC);
  else
    BuildMI(&MBB, DL, get(SP::FBCOND)).addMBB(TBB).addImm(CC);
  if (!FBB)
    return 1;

  BuildMI(&MBB, DL, get(SP::BA)).addMBB(FBB);
  return 2;
#endif
  report_fatal_error("insertBranch is not implemented yet");
}

unsigned VEInstrInfo::removeBranch(MachineBasicBlock &MBB,
                                      int *BytesRemoved) const {
#if 0
  assert(!BytesRemoved && "code size not handled");

  MachineBasicBlock::iterator I = MBB.end();
  unsigned Count = 0;
  while (I != MBB.begin()) {
    --I;

    if (I->isDebugValue())
      continue;

    if (I->getOpcode() != SP::BA
        && I->getOpcode() != SP::BCOND
        && I->getOpcode() != SP::FBCOND)
      break; // Not a branch

    I->eraseFromParent();
    I = MBB.end();
    ++Count;
  }
  return Count;
#endif
  report_fatal_error("removeBranch is not implemented yet");
}

bool VEInstrInfo::reverseBranchCondition(
    SmallVectorImpl<MachineOperand> &Cond) const {
  assert(Cond.size() == 1);
  VECC::CondCodes CC = static_cast<VECC::CondCodes>(Cond[0].getImm());
  Cond[0].setImm(GetOppositeBranchCondition(CC));
  return false;
}

void VEInstrInfo::copyPhysReg(MachineBasicBlock &MBB,
                                 MachineBasicBlock::iterator I,
                                 const DebugLoc &DL, unsigned DestReg,
                                 unsigned SrcReg, bool KillSrc) const {
#if 0
  unsigned numSubRegs = 0;
  unsigned movOpc     = 0;
  const unsigned *subRegIdx = nullptr;
  bool ExtraG0 = false;

  const unsigned DW_SubRegsIdx[]  = { SP::sub_even, SP::sub_odd };
  const unsigned DFP_FP_SubRegsIdx[]  = { SP::sub_even, SP::sub_odd };
  const unsigned QFP_DFP_SubRegsIdx[] = { SP::sub_even64, SP::sub_odd64 };
  const unsigned QFP_FP_SubRegsIdx[]  = { SP::sub_even, SP::sub_odd,
                                          SP::sub_odd64_then_sub_even,
                                          SP::sub_odd64_then_sub_odd };

  if (SP::IntRegsRegClass.contains(DestReg, SrcReg))
    BuildMI(MBB, I, DL, get(SP::ORrr), DestReg).addReg(SP::G0)
      .addReg(SrcReg, getKillRegState(KillSrc));
  else if (SP::IntPairRegClass.contains(DestReg, SrcReg)) {
    subRegIdx  = DW_SubRegsIdx;
    numSubRegs = 2;
    movOpc     = SP::ORrr;
    ExtraG0 = true;
  } else if (SP::FPRegsRegClass.contains(DestReg, SrcReg))
    BuildMI(MBB, I, DL, get(SP::FMOVS), DestReg)
      .addReg(SrcReg, getKillRegState(KillSrc));
  else if (SP::DFPRegsRegClass.contains(DestReg, SrcReg)) {
    if (Subtarget.isV9()) {
      BuildMI(MBB, I, DL, get(SP::FMOVD), DestReg)
        .addReg(SrcReg, getKillRegState(KillSrc));
    } else {
      // Use two FMOVS instructions.
      subRegIdx  = DFP_FP_SubRegsIdx;
      numSubRegs = 2;
      movOpc     = SP::FMOVS;
    }
  } else if (SP::QFPRegsRegClass.contains(DestReg, SrcReg)) {
    if (Subtarget.isV9()) {
      if (Subtarget.hasHardQuad()) {
        BuildMI(MBB, I, DL, get(SP::FMOVQ), DestReg)
          .addReg(SrcReg, getKillRegState(KillSrc));
      } else {
        // Use two FMOVD instructions.
        subRegIdx  = QFP_DFP_SubRegsIdx;
        numSubRegs = 2;
        movOpc     = SP::FMOVD;
      }
    } else {
      // Use four FMOVS instructions.
      subRegIdx  = QFP_FP_SubRegsIdx;
      numSubRegs = 4;
      movOpc     = SP::FMOVS;
    }
  } else if (SP::ASRRegsRegClass.contains(DestReg) &&
             SP::IntRegsRegClass.contains(SrcReg)) {
    BuildMI(MBB, I, DL, get(SP::WRASRrr), DestReg)
        .addReg(SP::G0)
        .addReg(SrcReg, getKillRegState(KillSrc));
  } else if (SP::IntRegsRegClass.contains(DestReg) &&
             SP::ASRRegsRegClass.contains(SrcReg)) {
    BuildMI(MBB, I, DL, get(SP::RDASR), DestReg)
        .addReg(SrcReg, getKillRegState(KillSrc));
  } else
    llvm_unreachable("Impossible reg-to-reg copy");

  if (numSubRegs == 0 || subRegIdx == nullptr || movOpc == 0)
    return;

  const TargetRegisterInfo *TRI = &getRegisterInfo();
  MachineInstr *MovMI = nullptr;

  for (unsigned i = 0; i != numSubRegs; ++i) {
    unsigned Dst = TRI->getSubReg(DestReg, subRegIdx[i]);
    unsigned Src = TRI->getSubReg(SrcReg,  subRegIdx[i]);
    assert(Dst && Src && "Bad sub-register");

    MachineInstrBuilder MIB = BuildMI(MBB, I, DL, get(movOpc), Dst);
    if (ExtraG0)
      MIB.addReg(SP::G0);
    MIB.addReg(Src);
    MovMI = MIB.getInstr();
  }
  // Add implicit super-register defs and kills to the last MovMI.
  MovMI->addRegisterDefined(DestReg, TRI);
  if (KillSrc)
    MovMI->addRegisterKilled(SrcReg, TRI);
#endif
  report_fatal_error("copyPhysReg is not implemented yet");
}

void VEInstrInfo::
storeRegToStackSlot(MachineBasicBlock &MBB, MachineBasicBlock::iterator I,
                    unsigned SrcReg, bool isKill, int FI,
                    const TargetRegisterClass *RC,
                    const TargetRegisterInfo *TRI) const {
#if 0
  DebugLoc DL;
  if (I != MBB.end()) DL = I->getDebugLoc();

  MachineFunction *MF = MBB.getParent();
  const MachineFrameInfo &MFI = MF->getFrameInfo();
  MachineMemOperand *MMO = MF->getMachineMemOperand(
      MachinePointerInfo::getFixedStack(*MF, FI), MachineMemOperand::MOStore,
      MFI.getObjectSize(FI), MFI.getObjectAlignment(FI));

  // On the order of operands here: think "[FrameIdx + 0] = SrcReg".
  if (RC == &SP::I64RegsRegClass)
    BuildMI(MBB, I, DL, get(SP::STXri)).addFrameIndex(FI).addImm(0)
      .addReg(SrcReg, getKillRegState(isKill)).addMemOperand(MMO);
  else if (RC == &SP::IntRegsRegClass)
    BuildMI(MBB, I, DL, get(SP::STri)).addFrameIndex(FI).addImm(0)
      .addReg(SrcReg, getKillRegState(isKill)).addMemOperand(MMO);
  else if (RC == &SP::IntPairRegClass)
    BuildMI(MBB, I, DL, get(SP::STDri)).addFrameIndex(FI).addImm(0)
      .addReg(SrcReg, getKillRegState(isKill)).addMemOperand(MMO);
  else if (RC == &SP::FPRegsRegClass)
    BuildMI(MBB, I, DL, get(SP::STFri)).addFrameIndex(FI).addImm(0)
      .addReg(SrcReg,  getKillRegState(isKill)).addMemOperand(MMO);
  else if (SP::DFPRegsRegClass.hasSubClassEq(RC))
    BuildMI(MBB, I, DL, get(SP::STDFri)).addFrameIndex(FI).addImm(0)
      .addReg(SrcReg,  getKillRegState(isKill)).addMemOperand(MMO);
  else if (SP::QFPRegsRegClass.hasSubClassEq(RC))
    // Use STQFri irrespective of its legality. If STQ is not legal, it will be
    // lowered into two STDs in eliminateFrameIndex.
    BuildMI(MBB, I, DL, get(SP::STQFri)).addFrameIndex(FI).addImm(0)
      .addReg(SrcReg,  getKillRegState(isKill)).addMemOperand(MMO);
  else
    llvm_unreachable("Can't store this register to stack slot");
#endif
  report_fatal_error("storeRegToStackSlot is not implemented yet");
}

void VEInstrInfo::
loadRegFromStackSlot(MachineBasicBlock &MBB, MachineBasicBlock::iterator I,
                     unsigned DestReg, int FI,
                     const TargetRegisterClass *RC,
                     const TargetRegisterInfo *TRI) const {
#if 0
  DebugLoc DL;
  if (I != MBB.end()) DL = I->getDebugLoc();

  MachineFunction *MF = MBB.getParent();
  const MachineFrameInfo &MFI = MF->getFrameInfo();
  MachineMemOperand *MMO = MF->getMachineMemOperand(
      MachinePointerInfo::getFixedStack(*MF, FI), MachineMemOperand::MOLoad,
      MFI.getObjectSize(FI), MFI.getObjectAlignment(FI));

  if (RC == &SP::I64RegsRegClass)
    BuildMI(MBB, I, DL, get(SP::LDXri), DestReg).addFrameIndex(FI).addImm(0)
      .addMemOperand(MMO);
  else if (RC == &SP::IntRegsRegClass)
    BuildMI(MBB, I, DL, get(SP::LDri), DestReg).addFrameIndex(FI).addImm(0)
      .addMemOperand(MMO);
  else if (RC == &SP::IntPairRegClass)
    BuildMI(MBB, I, DL, get(SP::LDDri), DestReg).addFrameIndex(FI).addImm(0)
      .addMemOperand(MMO);
  else if (RC == &SP::FPRegsRegClass)
    BuildMI(MBB, I, DL, get(SP::LDFri), DestReg).addFrameIndex(FI).addImm(0)
      .addMemOperand(MMO);
  else if (SP::DFPRegsRegClass.hasSubClassEq(RC))
    BuildMI(MBB, I, DL, get(SP::LDDFri), DestReg).addFrameIndex(FI).addImm(0)
      .addMemOperand(MMO);
  else if (SP::QFPRegsRegClass.hasSubClassEq(RC))
    // Use LDQFri irrespective of its legality. If LDQ is not legal, it will be
    // lowered into two LDDs in eliminateFrameIndex.
    BuildMI(MBB, I, DL, get(SP::LDQFri), DestReg).addFrameIndex(FI).addImm(0)
      .addMemOperand(MMO);
  else
    llvm_unreachable("Can't load this register from stack slot");
#endif
  report_fatal_error("loadRegFromStackSlot is not implemented yet");
}

unsigned VEInstrInfo::getGlobalBaseReg(MachineFunction *MF) const
{
#if 0
  VEMachineFunctionInfo *VEFI = MF->getInfo<VEMachineFunctionInfo>();
  unsigned GlobalBaseReg = VEFI->getGlobalBaseReg();
  if (GlobalBaseReg != 0)
    return GlobalBaseReg;

  // Insert the set of GlobalBaseReg into the first MBB of the function
  MachineBasicBlock &FirstMBB = MF->front();
  MachineBasicBlock::iterator MBBI = FirstMBB.begin();
  MachineRegisterInfo &RegInfo = MF->getRegInfo();

  const TargetRegisterClass *PtrRC =
    Subtarget.is64Bit() ? &SP::I64RegsRegClass : &SP::IntRegsRegClass;
  GlobalBaseReg = RegInfo.createVirtualRegister(PtrRC);

  DebugLoc dl;

  BuildMI(FirstMBB, MBBI, dl, get(SP::GETPCX), GlobalBaseReg);
  VEFI->setGlobalBaseReg(GlobalBaseReg);
  return GlobalBaseReg;
#endif
  report_fatal_error("getGlobalBaseReg is not implemented yet");
}

bool VEInstrInfo::expandPostRAPseudo(MachineInstr &MI) const {
#if 0
  switch (MI.getOpcode()) {
  case TargetOpcode::LOAD_STACK_GUARD: {
    assert(Subtarget.isTargetLinux() &&
           "Only Linux target is expected to contain LOAD_STACK_GUARD");
    // offsetof(tcbhead_t, stack_guard) from sysdeps/sparc/nptl/tls.h in glibc.
    const int64_t Offset = Subtarget.is64Bit() ? 0x28 : 0x14;
    MI.setDesc(get(Subtarget.is64Bit() ? SP::LDXri : SP::LDri));
    MachineInstrBuilder(*MI.getParent()->getParent(), MI)
        .addReg(SP::G7)
        .addImm(Offset);
    return true;
  }
  }
  return false;
#endif
  report_fatal_error("expandPostRAPseudo is not implemented yet");
}
