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
#include "llvm/Support/Debug.h"

#define DEBUG_TYPE "ve"

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
  if (MI.getOpcode() == VE::LDSri || MI.getOpcode() == VE::LDUri ||
      MI.getOpcode() == VE::LDLri || MI.getOpcode() == VE::LDLUri ||
      MI.getOpcode() == VE::LD2Bri || MI.getOpcode() == VE::LD2BUri ||
      MI.getOpcode() == VE::LD1Bri || MI.getOpcode() == VE::LD1BUri) {
    if (MI.getOperand(1).isFI() && MI.getOperand(2).isImm() &&
        MI.getOperand(2).getImm() == 0) {
      FrameIndex = MI.getOperand(1).getIndex();
      return MI.getOperand(0).getReg();
    }
  }
  return 0;
}

/// isStoreToStackSlot - If the specified machine instruction is a direct
/// store to a stack slot, return the virtual or physical register number of
/// the source reg along with the FrameIndex of the loaded stack slot.  If
/// not, return 0.  This predicate must return 0 if the instruction has
/// any side effects other than storing to the stack slot.
unsigned VEInstrInfo::isStoreToStackSlot(const MachineInstr &MI,
                                            int &FrameIndex) const {
  if (MI.getOpcode() == VE::STSri || MI.getOpcode() == VE::STUri ||
      MI.getOpcode() == VE::STLri || MI.getOpcode() == VE::ST2Bri ||
      MI.getOpcode() == VE::ST1Bri) {
    if (MI.getOperand(0).isFI() && MI.getOperand(1).isImm() &&
        MI.getOperand(1).getImm() == 0) {
      FrameIndex = MI.getOperand(0).getIndex();
      return MI.getOperand(2).getReg();
    }
  }
  return 0;
}

static bool IsIntegerCC(unsigned CC)
{
  return  (CC < VECC::CC_AF);
}

static VECC::CondCodes GetOppositeBranchCondition(VECC::CondCodes CC)
{
  switch(CC) {
  case VECC::CC_IG:     return VECC::CC_ILE;
  case VECC::CC_IL:     return VECC::CC_IGE;
  case VECC::CC_INE:    return VECC::CC_IEQ;
  case VECC::CC_IEQ:    return VECC::CC_INE;
  case VECC::CC_IGE:    return VECC::CC_IL;
  case VECC::CC_ILE:    return VECC::CC_IG;
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

// Treat br.l [BCR AT] as unconditional branch
static bool isUncondBranchOpcode(int Opc) {
  return Opc == VE::BCRLa || Opc == VE::BCRWa ||
         Opc == VE::BCRDa || Opc == VE::BCRSa;
}

static bool isCondBranchOpcode(int Opc) {
  return Opc == VE::BCRLrr  || Opc == VE::BCRLir  ||
         Opc == VE::BCRLrm0 || Opc == VE::BCRLrm1 ||
         Opc == VE::BCRLim0 || Opc == VE::BCRLim1 ||
         Opc == VE::BCRWrr  || Opc == VE::BCRWir  ||
         Opc == VE::BCRWrm0 || Opc == VE::BCRWrm1 ||
         Opc == VE::BCRWim0 || Opc == VE::BCRWim1 ||
         Opc == VE::BCRDrr  || Opc == VE::BCRDir  ||
         Opc == VE::BCRDrm0 || Opc == VE::BCRDrm1 ||
         Opc == VE::BCRDim0 || Opc == VE::BCRDim1 ||
         Opc == VE::BCRSrr  || Opc == VE::BCRSir  ||
         Opc == VE::BCRSrm0 || Opc == VE::BCRSrm1 ||
         Opc == VE::BCRSim0 || Opc == VE::BCRSim1;
}

static bool isIndirectBranchOpcode(int Opc) {
#if 0
  return Opc == SP::BINDrr || Opc == SP::BINDri;
#endif
  report_fatal_error("isIndirectBranchOpcode is not implemented yet");
}

static void parseCondBranch(MachineInstr *LastInst, MachineBasicBlock *&Target,
                            SmallVectorImpl<MachineOperand> &Cond) {
  Cond.push_back(MachineOperand::CreateImm(LastInst->getOperand(0).getImm()));
  Cond.push_back(LastInst->getOperand(1));
  Cond.push_back(LastInst->getOperand(2));
  Target = LastInst->getOperand(3).getMBB();
}

bool VEInstrInfo::analyzeBranch(MachineBasicBlock &MBB,
                                   MachineBasicBlock *&TBB,
                                   MachineBasicBlock *&FBB,
                                   SmallVectorImpl<MachineOperand> &Cond,
                                   bool AllowModify) const {
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
}

unsigned VEInstrInfo::insertBranch(MachineBasicBlock &MBB,
                                      MachineBasicBlock *TBB,
                                      MachineBasicBlock *FBB,
                                      ArrayRef<MachineOperand> Cond,
                                      const DebugLoc &DL,
                                      int *BytesAdded) const {
  assert(TBB && "insertBranch must not be told to insert a fallthrough");
  assert((Cond.size() == 3 || Cond.size() == 0) &&
         "VE branch conditions should have three component!");
  assert(!BytesAdded && "code size not handled");
  if (Cond.empty()) {
    // Uncondition branch
    assert(!FBB && "Unconditional branch with multiple successors!");
    BuildMI(&MBB, DL, get(VE::BCRLa)).addMBB(TBB);
    return 1;
  }

  // Conditional branch
  //   (BCRir CC sy sz addr)

  assert(Cond[0].isImm() && Cond[2].isReg() && "not implemented");

  unsigned opc[2];
  if (IsIntegerCC(Cond[0].getImm())) {
    if (VE::I32RegClass.contains(Cond[2].getReg())) {
      opc[0] = VE::BCRWir;
      opc[1] = VE::BCRWrr;
    } else {
      opc[0] = VE::BCRLir;
      opc[1] = VE::BCRLrr;
    }
  } else {
    if (VE::F32RegClass.contains(Cond[2].getReg())) {
      opc[0] = VE::BCRSir;
      opc[1] = VE::BCRSrr;
    } else {
      opc[0] = VE::BCRDir;
      opc[1] = VE::BCRDrr;
    }
  }
  if (Cond[1].isImm()) {
      BuildMI(&MBB, DL, get(opc[0]))
          .add(Cond[0]) // condition code
          .add(Cond[1]) // lhs 
          .add(Cond[2]) // rhs
          .addMBB(TBB);
  } else {
      BuildMI(&MBB, DL, get(opc[1]))
          .add(Cond[0])
          .add(Cond[1])
          .add(Cond[2])
          .addMBB(TBB);
  }

  if (!FBB)
    return 1;
  BuildMI(&MBB, DL, get(VE::BCRLa)).addMBB(FBB);
  return 2;
}

unsigned VEInstrInfo::removeBranch(MachineBasicBlock &MBB,
                                      int *BytesRemoved) const {
  assert(!BytesRemoved && "code size not handled");

  MachineBasicBlock::iterator I = MBB.end();
  unsigned Count = 0;
  while (I != MBB.begin()) {
    --I;

    if (I->isDebugValue())
      continue;

    if (!isUncondBranchOpcode(I->getOpcode()) &&
        !isCondBranchOpcode(I->getOpcode()))
      break; // Not a branch

    I->eraseFromParent();
    I = MBB.end();
    ++Count;
  }
  return Count;

  //report_fatal_error("removeBranch is not implemented yet");
}

bool VEInstrInfo::reverseBranchCondition(
    SmallVectorImpl<MachineOperand> &Cond) const {
#if 0
  assert(Cond.size() == 1);
#endif
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
#endif

  // For the case of VE, I32, I64, and F32 uses the identical
  // registers %s0-%s63, so no need to check other register classes
  // here
  if (VE::I32RegClass.contains(DestReg, SrcReg))
    BuildMI(MBB, I, DL, get(VE::ORri), DestReg)
      .addReg(SrcReg, getKillRegState(KillSrc)).addImm(0);
  // any scaler to any scaler
  else if ((VE::I32RegClass.contains(SrcReg) ||
            VE::F32RegClass.contains(SrcReg) ||
            VE::I64RegClass.contains(SrcReg)) &&
           (VE::I32RegClass.contains(DestReg) ||
            VE::F32RegClass.contains(DestReg) ||
            VE::I64RegClass.contains(DestReg)))
    BuildMI(MBB, I, DL, get(VE::ORri), DestReg)
      .addReg(SrcReg, getKillRegState(KillSrc)).addImm(0);
  else if (VE::V64RegClass.contains(DestReg, SrcReg))
    BuildMI(MBB, I, DL, get(VE::VORi1), DestReg)
        .addImm(0)
        .addReg(SrcReg, getKillRegState(KillSrc));
  else {
    const TargetRegisterInfo *TRI = &getRegisterInfo();
    dbgs() << "Impossible reg-to-reg copy from " << printReg(SrcReg, TRI) << " to " << printReg(DestReg, TRI) << "\n";
    llvm_unreachable("Impossible reg-to-reg copy");
  }
#if 0
  else if (SP::IntPairRegClass.contains(DestReg, SrcReg)) {
    subRegIdx  = DW_SubRegsIdx;
    numSubRegs = 2;
    movOpc     = SP::ORrr;
    ExtraG0 = true;
  } else if (SP::DFPRegsRegClass.contains(DestReg, SrcReg)) {
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
}

void VEInstrInfo::
storeRegToStackSlot(MachineBasicBlock &MBB, MachineBasicBlock::iterator I,
                    unsigned SrcReg, bool isKill, int FI,
                    const TargetRegisterClass *RC,
                    const TargetRegisterInfo *TRI) const {
  DebugLoc DL;
  if (I != MBB.end()) DL = I->getDebugLoc();

  MachineFunction *MF = MBB.getParent();
  const MachineFrameInfo &MFI = MF->getFrameInfo();
  MachineMemOperand *MMO = MF->getMachineMemOperand(
      MachinePointerInfo::getFixedStack(*MF, FI), MachineMemOperand::MOStore,
      MFI.getObjectSize(FI), MFI.getObjectAlignment(FI));

  // On the order of operands here: think "[FrameIdx + 0] = SrcReg".
  if (RC == &VE::I64RegClass)
    BuildMI(MBB, I, DL, get(VE::STSri)).addFrameIndex(FI).addImm(0)
      .addReg(SrcReg, getKillRegState(isKill)).addMemOperand(MMO);
  else if (RC == &VE::I32RegClass)
    BuildMI(MBB, I, DL, get(VE::STLri)).addFrameIndex(FI).addImm(0)
      .addReg(SrcReg, getKillRegState(isKill)).addMemOperand(MMO);
  else if (RC == &VE::F32RegClass)
    BuildMI(MBB, I, DL, get(VE::STUri)).addFrameIndex(FI).addImm(0)
      .addReg(SrcReg, getKillRegState(isKill)).addMemOperand(MMO);
#if 0
  else if (SP::F128RegClass.hasSubClassEq(RC))
    // Use STQFri irrespective of its legality. If STQ is not legal, it will be
    // lowered into two STDs in eliminateFrameIndex.
    BuildMI(MBB, I, DL, get(SP::STQFri)).addFrameIndex(FI).addImm(0)
      .addReg(SrcReg,  getKillRegState(isKill)).addMemOperand(MMO);
#endif
  else
    llvm_unreachable("Can't store this register to stack slot");
}

void VEInstrInfo::
loadRegFromStackSlot(MachineBasicBlock &MBB, MachineBasicBlock::iterator I,
                     unsigned DestReg, int FI,
                     const TargetRegisterClass *RC,
                     const TargetRegisterInfo *TRI) const {
  DebugLoc DL;
  if (I != MBB.end()) DL = I->getDebugLoc();

  MachineFunction *MF = MBB.getParent();
  const MachineFrameInfo &MFI = MF->getFrameInfo();
  MachineMemOperand *MMO = MF->getMachineMemOperand(
      MachinePointerInfo::getFixedStack(*MF, FI), MachineMemOperand::MOLoad,
      MFI.getObjectSize(FI), MFI.getObjectAlignment(FI));

  if (RC == &VE::I64RegClass)
    BuildMI(MBB, I, DL, get(VE::LDSri), DestReg).addFrameIndex(FI).addImm(0)
      .addMemOperand(MMO);
  else if (RC == &VE::I32RegClass)
    BuildMI(MBB, I, DL, get(VE::LDLri), DestReg).addFrameIndex(FI).addImm(0)
      .addMemOperand(MMO);
  else if (RC == &VE::F32RegClass)
    BuildMI(MBB, I, DL, get(VE::LDUri), DestReg).addFrameIndex(FI).addImm(0)
      .addMemOperand(MMO);
#if 0
  else if (VE::F128RegClass.hasSubClassEq(RC))
    // Use LDQFri irrespective of its legality. If LDQ is not legal, it will be
    // lowered into two LDDs in eliminateFrameIndex.
    BuildMI(MBB, I, DL, get(SP::LDQFri), DestReg).addFrameIndex(FI).addImm(0)
      .addMemOperand(MMO);
#endif
  else
    llvm_unreachable("Can't load this register from stack slot");
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

static void buildVMRInst(MachineInstr& MI, const MCInstrDesc& MCID) {
  MachineBasicBlock* MBB = MI.getParent();
  DebugLoc dl = MI.getDebugLoc();

  unsigned VMXu = (MI.getOperand(0).getReg() - VE::VMP0) * 2 + VE::VM0; 
  unsigned VMXl = VMXu + 1;
  unsigned VMYu = (MI.getOperand(1).getReg() - VE::VMP0) * 2 + VE::VM0; 
  unsigned VMYl = VMYu + 1;

  if (MI.getNumOperands() > 3) { // includes VL
      unsigned VMZu = (MI.getOperand(2).getReg() - VE::VMP0) * 2 + VE::VM0; 
      unsigned VMZl = VMZu + 1;
      BuildMI(*MBB, MI, dl, MCID).addDef(VMXu).addUse(VMYu).addUse(VMZu);
      BuildMI(*MBB, MI, dl, MCID).addDef(VMXl).addUse(VMYl).addUse(VMZl);
  } else {
      BuildMI(*MBB, MI, dl, MCID).addDef(VMXu).addUse(VMYu);
      BuildMI(*MBB, MI, dl, MCID).addDef(VMXl).addUse(VMYl);
  }
  MI.eraseFromParent();
}

bool VEInstrInfo::expandPostRAPseudo(MachineInstr &MI) const {
  switch (MI.getOpcode()) {
  case VE::EXTEND_STACK: {
    return expandExtendStackPseudo(MI);
  }
  case VE::EXTEND_STACK_GUARD: {
    MI.eraseFromParent(); // The pseudo instruction is gone now.
    return true;
  }
  case TargetOpcode::LOAD_STACK_GUARD: {
    assert(Subtarget.isTargetLinux() &&
           "Only Linux target is expected to contain LOAD_STACK_GUARD");
    report_fatal_error("expandPostRAPseudo for LOAD_STACK_GUARD is not implemented yet");
#if 0
    // offsetof(tcbhead_t, stack_guard) from sysdeps/sparc/nptl/tls.h in glibc.
    const int64_t Offset = Subtarget.is64Bit() ? 0x28 : 0x14;
    MI.setDesc(get(Subtarget.is64Bit() ? SP::LDXri : SP::LDri));
    MachineInstrBuilder(*MI.getParent()->getParent(), MI)
        .addReg(SP::G7)
        .addImm(Offset);
    return true;
#endif
  }
#if 0
  case VE::VE_SELECT: {
    // (VESelect $dst, $CC, $condVal, $trueVal, $dst)
    //   -> (CMOVrr $dst, condCode, $trueVal, $condVal)
    // cmov.$df.$cf $dst, $trueval, $cond

    assert(MI.getOperand(0).getReg() == MI.getOperand(4).getReg());

    MachineBasicBlock* MBB = MI.getParent();
    DebugLoc dl = MI.getDebugLoc();
    BuildMI(*MBB, MI, dl, get(VE::CMOVWrr))
      .addReg(MI.getOperand(0).getReg())
      .addImm(MI.getOperand(1).getImm())
      .addReg(MI.getOperand(3).getReg())
      .addReg(MI.getOperand(2).getReg());

    MI.eraseFromParent();
    return true;
  }
#endif
  case VE::VFMSpv:
  case VE::VFMFpv:
  case VE::VFMKpat:
  case VE::VFMKpaf: {
    // replace to pvfmk.w.up and pvfmk.w.lo (VFMSpv)
    // replace to pvfmk.s.up and pvfmk.s.lo (VFMFpv)

    unsigned Opcode = MI.getOpcode();

    // change VMP to VM
    unsigned VMu = (MI.getOperand(0).getReg() - VE::VMP0) * 2 + VE::VM0; 
    unsigned VMl = VMu + 1;

    unsigned OpcodeUpper;
    unsigned OpcodeLower;
    if (Opcode == VE::VFMSpv) {
      OpcodeUpper = VE::VFMSuv;
      OpcodeLower = VE::VFMSv;
    } else if (Opcode == VE::VFMFpv) {
      OpcodeUpper = VE::VFMFsv;
      OpcodeLower = VE::VFMFlv;
    } else if (Opcode == VE::VFMKpat) {
      OpcodeUpper = VE::VFMSuat;
      OpcodeLower = VE::VFMSlat;
    } else if (Opcode == VE::VFMKpaf) {
      OpcodeUpper = VE::VFMSuaf;
      OpcodeLower = VE::VFMSlaf;
    }
#if 0
    DEBUG(dbgs() << "expandPostRAPseudo: VFMSpv:"
          << " op0=" << MI.getOperand(0).getReg()
          << " VMP0=" << VE::VMP0
          << " VM0=" << VE::VM0
          << " VMu" << VMu << " VMl=" << VMl
          << "\n");
#endif
    MachineBasicBlock* MBB = MI.getParent();
    DebugLoc dl = MI.getDebugLoc();
    MachineInstrBuilder Bu = BuildMI(*MBB, MI, dl, get(OpcodeUpper)).addReg(VMu);
    MachineInstrBuilder Bl = BuildMI(*MBB, MI, dl, get(OpcodeLower)).addReg(VMl);

    if (MI.getOpcode() == VE::VFMSpv || MI.getOpcode() == VE::VFMFpv) {
      Bu.addImm(MI.getOperand(1).getImm()).addReg(MI.getOperand(2).getReg());
      Bl.addImm(MI.getOperand(1).getImm()).addReg(MI.getOperand(2).getReg());
    }

    MI.eraseFromParent();
    return true;
    }
  case VE::LVMpi: {
    unsigned VMXu = (MI.getOperand(0).getReg() - VE::VMP0) * 2 + VE::VM0; 
    unsigned VMXl = VMXu + 1;
    unsigned VMDu = (MI.getOperand(1).getReg() - VE::VMP0) * 2 + VE::VM0; 
    unsigned VMDl = VMDu + 1;
    int64_t imm = MI.getOperand(2).getImm();
    unsigned VMX = VMXl;
    unsigned VMD = VMDl;
    if (imm >= 4) {
        VMX = VMXu;
        VMD = VMDu;
        imm -= 4;
    }
    MachineBasicBlock* MBB = MI.getParent();
    DebugLoc dl = MI.getDebugLoc();
    BuildMI(*MBB, MI, dl, get(VE::LVMi))
      .addDef(VMX)
      .addReg(VMD)
      .addImm(imm)
      .addReg(MI.getOperand(3).getReg());
    MI.eraseFromParent();
    return true;
  }
  case VE::SVMpi: {
    unsigned VMZu = (MI.getOperand(1).getReg() - VE::VMP0) * 2 + VE::VM0; 
    unsigned VMZl = VMZu + 1;
    int64_t imm = MI.getOperand(2).getImm();
    unsigned VMZ = VMZl;
    if (imm >= 4) {
        VMZ = VMZu;
        imm -= 4;
    }
    MachineBasicBlock* MBB = MI.getParent();
    DebugLoc dl = MI.getDebugLoc();
    BuildMI(*MBB, MI, dl, get(VE::SVMi))
      .add(MI.getOperand(0))
      .addReg(VMZ)
      .addImm(imm);
    MI.eraseFromParent();
    return true;
  }
  case VE::ANDMp: buildVMRInst(MI, get(VE::ANDM)); return true;
  case VE::ORMp:  buildVMRInst(MI, get(VE::ORM)); return true;
  case VE::XORMp: buildVMRInst(MI, get(VE::XORM)); return true;
  case VE::EQVMp: buildVMRInst(MI, get(VE::EQVM)); return true;
  case VE::NNDMp: buildVMRInst(MI, get(VE::NNDM)); return true;
  case VE::NEGMp: buildVMRInst(MI, get(VE::NEGM)); return true;
  }
  return false;
}

bool VEInstrInfo::expandExtendStackPseudo(MachineInstr &MI) const {
  MachineBasicBlock &MBB = *MI.getParent();
  MachineFunction &MF = *MBB.getParent();
  const VEInstrInfo &TII =
      *static_cast<const VEInstrInfo *>(MF.getSubtarget().getInstrInfo());
  DebugLoc dl = MBB.findDebugLoc(MI);

  // Create following instructions and multiple basic blocks.
  //
  // thisBB:
  //   brge.l.t %sp, %sl, sinkBB
  // syscallBB:
  //   ld      %s61, 0x18(, %tp)        // load param area
  //   or      %s62, 0, %s0             // spill the value of %s0
  //   lea     %s63, 0x13b              // syscall # of grow
  //   shm.l   %s63, 0x0(%s61)          // store syscall # at addr:0
  //   shm.l   %sl, 0x8(%s61)           // store old limit at addr:8
  //   shm.l   %sp, 0x10(%s61)          // store new limit at addr:16
  //   monc                             // call monitor
  //   or      %s0, 0, %s62             // restore the value of %s0
  // sinkBB:

  // Create new MBB
  MachineBasicBlock *BB = &MBB;
  const BasicBlock *LLVM_BB = BB->getBasicBlock();
  MachineBasicBlock *syscallMBB = MF.CreateMachineBasicBlock(LLVM_BB);
  MachineBasicBlock *sinkMBB = MF.CreateMachineBasicBlock(LLVM_BB);
  MachineFunction::iterator It = ++(BB->getIterator());
  MF.insert(It, syscallMBB);
  MF.insert(It, sinkMBB);

  // Transfer the remainder of BB and its successor edges to sinkMBB.
  sinkMBB->splice(sinkMBB->begin(), BB,
                  std::next(std::next(MachineBasicBlock::iterator(MI))),
                  BB->end());
  sinkMBB->transferSuccessorsAndUpdatePHIs(BB);

  // Next, add the true and fallthrough blocks as its successors.
  BB->addSuccessor(syscallMBB);
  BB->addSuccessor(sinkMBB);
  BuildMI(BB, dl, TII.get(VE::BCRLrr))
      .addImm(VECC::CC_IGE)
      .addReg(VE::SX11)                          // %sp
      .addReg(VE::SX8)                           // %sl
      .addMBB(sinkMBB);

  BB = syscallMBB;

  // Update machine-CFG edges
  BB->addSuccessor(sinkMBB);

  BuildMI(BB, dl, TII.get(VE::LDSri), VE::SX61)
    .addReg(VE::SX14).addImm(0x18);
  BuildMI(BB, dl, TII.get(VE::ORri), VE::SX62)
    .addReg(VE::SX0).addImm(0);
  BuildMI(BB, dl, TII.get(VE::LEAzzi), VE::SX63)
    .addImm(0x13b);
  BuildMI(BB, dl, TII.get(VE::SHMri))
    .addReg(VE::SX61).addImm(0).addReg(VE::SX63);
  BuildMI(BB, dl, TII.get(VE::SHMri))
    .addReg(VE::SX61).addImm(8).addReg(VE::SX8);
  BuildMI(BB, dl, TII.get(VE::SHMri))
    .addReg(VE::SX61).addImm(16).addReg(VE::SX11);
  BuildMI(BB, dl, TII.get(VE::MONC));

  BuildMI(BB, dl, TII.get(VE::ORri), VE::SX0)
    .addReg(VE::SX62).addImm(0);

  MI.eraseFromParent(); // The pseudo instruction is gone now.
  return true;
}
