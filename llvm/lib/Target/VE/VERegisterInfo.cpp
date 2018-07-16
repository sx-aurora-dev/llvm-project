//===-- VERegisterInfo.cpp - VE Register Information ----------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the VE implementation of the TargetRegisterInfo class.
//
//===----------------------------------------------------------------------===//

#include "VERegisterInfo.h"
#include "VE.h"
#include "VEMachineFunctionInfo.h"
#include "VESubtarget.h"
#include "llvm/ADT/BitVector.h"
#include "llvm/ADT/STLExtras.h"
#include "llvm/CodeGen/MachineFrameInfo.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/CodeGen/TargetInstrInfo.h"
#include "llvm/IR/Type.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/ErrorHandling.h"

using namespace llvm;

#define GET_REGINFO_TARGET_DESC
#include "VEGenRegisterInfo.inc"

// VE uses %s10 == %lp to keep return address
VERegisterInfo::VERegisterInfo() : VEGenRegisterInfo(VE::SX10) {}

const MCPhysReg*
VERegisterInfo::getCalleeSavedRegs(const MachineFunction *MF) const {
  return CSR_SaveList;
}

const uint32_t *
VERegisterInfo::getCallPreservedMask(const MachineFunction &MF,
                                        CallingConv::ID CC) const {
  if (CC == CallingConv::VE_VEC_EXPF) {
    return CSR_vec_expf_RegMask;
  }
  return CSR_RegMask;
}

BitVector VERegisterInfo::getReservedRegs(const MachineFunction &MF) const {
  BitVector Reserved(getNumRegs());
  Reserved.set(VE::SX8);        // stack limit
  Reserved.set(VE::SX9);        // frame pointer
  Reserved.set(VE::SX10);       // link register (return address)
  Reserved.set(VE::SX11);       // stack pointer

  // FIXME: maybe not need to be reserved
  Reserved.set(VE::SX12);       // outer register
  Reserved.set(VE::SX13);       // id register for dynamic linker

  Reserved.set(VE::SX14);       // thread pointer
  Reserved.set(VE::SX15);       // global offset table register
  Reserved.set(VE::SX16);       // procedure linkage table register
  Reserved.set(VE::SX17);       // linkage-area register

  // Also reserve the register pair aliases covering the above
  // registers, with the same conditions.  This is required since
  // LiveIntervals treat a register as a non reserved register if any
  // of its aliases are not reserved.
  Reserved.set(VE::Q4);         // SX8_SX9
  Reserved.set(VE::Q5);         // SX10_SX11
  Reserved.set(VE::Q6);         // SX12_SX13
  Reserved.set(VE::Q7);         // SX14_SX15
  Reserved.set(VE::Q8);         // SX16_SX17

  // Also reserve the integer 32 bit registers convering the above registers.
  Reserved.set(VE::SW8);
  Reserved.set(VE::SW9);
  Reserved.set(VE::SW10);
  Reserved.set(VE::SW11);
  Reserved.set(VE::SW12);
  Reserved.set(VE::SW13);
  Reserved.set(VE::SW14);
  Reserved.set(VE::SW15);
  Reserved.set(VE::SW16);
  Reserved.set(VE::SW17);

  // Also reserve the floating point 32 bit registers convering the above
  // registers.
  Reserved.set(VE::SF8);
  Reserved.set(VE::SF9);
  Reserved.set(VE::SF10);
  Reserved.set(VE::SF11);
  Reserved.set(VE::SF12);
  Reserved.set(VE::SF13);
  Reserved.set(VE::SF14);
  Reserved.set(VE::SF15);
  Reserved.set(VE::SF16);
  Reserved.set(VE::SF17);

  // Also reserve the integer 16 bit registers convering the above registers.
  Reserved.set(VE::SH8);
  Reserved.set(VE::SH9);
  Reserved.set(VE::SH10);
  Reserved.set(VE::SH11);
  Reserved.set(VE::SH12);
  Reserved.set(VE::SH13);
  Reserved.set(VE::SH14);
  Reserved.set(VE::SH15);
  Reserved.set(VE::SH16);
  Reserved.set(VE::SH17);

  // Also reserve the integer 8 bit registers convering the above registers.
  Reserved.set(VE::SB8);
  Reserved.set(VE::SB9);
  Reserved.set(VE::SB10);
  Reserved.set(VE::SB11);
  Reserved.set(VE::SB12);
  Reserved.set(VE::SB13);
  Reserved.set(VE::SB14);
  Reserved.set(VE::SB15);
  Reserved.set(VE::SB16);
  Reserved.set(VE::SB17);

  // sx18-sx33 are callee-saved registers
  // sx34-sx63 are temporary registers

  return Reserved;
}

const TargetRegisterClass*
VERegisterInfo::getPointerRegClass(const MachineFunction &MF,
                                      unsigned Kind) const {
  return &VE::I64RegClass;
}

#define DEBUG_TYPE "ve"

static void replaceFI(MachineFunction &MF, MachineBasicBlock::iterator II,
                      MachineInstr &MI, const DebugLoc &dl,
                      unsigned FIOperandNum, int Offset, unsigned FramePtr) {
  if (1) {
      LLVM_DEBUG(dbgs() << "replaceFI: "; MI.dump());
  }
  // Replace frame index with a frame pointer reference.
  if (1) { //Offset >= -4096 && Offset <= 4095) {
    // If the offset is small enough to fit in the immediate field, directly
    // encode it.
    MI.getOperand(FIOperandNum).ChangeToRegister(FramePtr, false);
    MI.getOperand(FIOperandNum + 1).ChangeToImmediate(Offset);
    return;
  }

#if 0
  const TargetInstrInfo &TII = *MF.getSubtarget().getInstrInfo();
  unsigned Reg = MF.getRegInfo().createVirtualRegister(&VE::I64RegClass);
  BuildMI(*MI.getParent(), II, dl, TII.get(VE::LEAzzi), Reg).addImm(Offset);
  MI.getOperand(FIOperandNum).ChangeToRegister(FramePtr, false);
  MI.getOperand(FIOperandNum + 1).ChangeToRegister(Reg, false);
  return;
#endif

  report_fatal_error("replaceFI for large number is not implemented yet");
#if 0
  const TargetInstrInfo &TII = *MF.getSubtarget().getInstrInfo();

  // FIXME: it would be better to scavenge a register here instead of
  // reserving G1 all of the time.
  if (Offset >= 0) {
    // Emit nonnegaive immediates with sethi + or.
    // sethi %hi(Offset), %g1
    // add %g1, %fp, %g1
    // Insert G1+%lo(offset) into the user.
    BuildMI(*MI.getParent(), II, dl, TII.get(SP::SETHIi), SP::G1)
      .addImm(HI22(Offset));


    // Emit G1 = G1 + I6
    BuildMI(*MI.getParent(), II, dl, TII.get(SP::ADDrr), SP::G1).addReg(SP::G1)
      .addReg(FramePtr);
    // Insert: G1+%lo(offset) into the user.
    MI.getOperand(FIOperandNum).ChangeToRegister(SP::G1, false);
    MI.getOperand(FIOperandNum + 1).ChangeToImmediate(LO10(Offset));
    return;
  }

  // Emit Negative numbers with sethi + xor
  // sethi %hix(Offset), %g1
  // xor  %g1, %lox(offset), %g1
  // add %g1, %fp, %g1
  // Insert: G1 + 0 into the user.
  BuildMI(*MI.getParent(), II, dl, TII.get(SP::SETHIi), SP::G1)
    .addImm(HIX22(Offset));
  BuildMI(*MI.getParent(), II, dl, TII.get(SP::XORri), SP::G1)
    .addReg(SP::G1).addImm(LOX10(Offset));

  BuildMI(*MI.getParent(), II, dl, TII.get(SP::ADDrr), SP::G1).addReg(SP::G1)
    .addReg(FramePtr);
  // Insert: G1+%lo(offset) into the user.
  MI.getOperand(FIOperandNum).ChangeToRegister(SP::G1, false);
  MI.getOperand(FIOperandNum + 1).ChangeToImmediate(0);
#endif
}


void
VERegisterInfo::eliminateFrameIndex(MachineBasicBlock::iterator II,
                                       int SPAdj, unsigned FIOperandNum,
                                       RegScavenger *RS) const {
  assert(SPAdj == 0 && "Unexpected");

  MachineInstr &MI = *II;
  DebugLoc dl = MI.getDebugLoc();
  int FrameIndex = MI.getOperand(FIOperandNum).getIndex();
  MachineFunction &MF = *MI.getParent()->getParent();
#if 0
  const VESubtarget &Subtarget = MF.getSubtarget<VESubtarget>();
#endif
  const VEFrameLowering *TFI = getFrameLowering(MF);

  unsigned FrameReg;
  int Offset;
  Offset = TFI->getFrameIndexReference(MF, FrameIndex, FrameReg);

  Offset += MI.getOperand(FIOperandNum + 1).getImm();

#if 0
  if (!Subtarget.isV9() || !Subtarget.hasHardQuad()) {
    if (MI.getOpcode() == SP::STQFri) {
      const TargetInstrInfo &TII = *Subtarget.getInstrInfo();
      unsigned SrcReg = MI.getOperand(2).getReg();
      unsigned SrcEvenReg = getSubReg(SrcReg, SP::sub_even64);
      unsigned SrcOddReg  = getSubReg(SrcReg, SP::sub_odd64);
      MachineInstr *StMI =
        BuildMI(*MI.getParent(), II, dl, TII.get(SP::STDFri))
        .addReg(FrameReg).addImm(0).addReg(SrcEvenReg);
      replaceFI(MF, II, *StMI, dl, 0, Offset, FrameReg);
      MI.setDesc(TII.get(SP::STDFri));
      MI.getOperand(2).setReg(SrcOddReg);
      Offset += 8;
    } else if (MI.getOpcode() == SP::LDQFri) {
      const TargetInstrInfo &TII = *Subtarget.getInstrInfo();
      unsigned DestReg     = MI.getOperand(0).getReg();
      unsigned DestEvenReg = getSubReg(DestReg, SP::sub_even64);
      unsigned DestOddReg  = getSubReg(DestReg, SP::sub_odd64);
      MachineInstr *StMI =
        BuildMI(*MI.getParent(), II, dl, TII.get(SP::LDDFri), DestEvenReg)
        .addReg(FrameReg).addImm(0);
      replaceFI(MF, II, *StMI, dl, 1, Offset, FrameReg);

      MI.setDesc(TII.get(SP::LDDFri));
      MI.getOperand(0).setReg(DestOddReg);
      Offset += 8;
    }
  }
#endif

  replaceFI(MF, II, MI, dl, FIOperandNum, Offset, FrameReg);
}

unsigned VERegisterInfo::getFrameRegister(const MachineFunction &MF) const {
  return VE::SX9;
}

// VE has no architectural need for stack realignment support,
// except that LLVM unfortunately currently implements overaligned
// stack objects by depending upon stack realignment support.
// If that ever changes, this can probably be deleted.
bool VERegisterInfo::canRealignStack(const MachineFunction &MF) const {
  if (!TargetRegisterInfo::canRealignStack(MF))
    return false;

  // VE always has a fixed frame pointer register, so don't need to
  // worry about needing to reserve it. [even if we don't have a frame
  // pointer for our frame, it still cannot be used for other things,
  // or register window traps will be SADNESS.]

  // If there's a reserved call frame, we can use VE to access locals.
  if (getFrameLowering(MF)->hasReservedCallFrame(MF))
    return true;

  // Otherwise, we'd need a base pointer, but those aren't implemented
  // for VE at the moment.

  return false;
}
