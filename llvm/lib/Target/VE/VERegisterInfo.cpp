//===-- VERegisterInfo.cpp - VE Register Information ----------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
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
VERegisterInfo::VERegisterInfo() : VEGenRegisterInfo(VE::SX10) {

  // Initialize VLSPSetID
  const int* PSet = getRegClassPressureSets(&VE::VLSRegClass);
  assert(*PSet != -1);
  VLSPSetID = *PSet++;
  assert(*PSet == -1);
}

bool VERegisterInfo::requiresRegisterScavenging(
    const MachineFunction &MF) const {
  return true;
}

bool VERegisterInfo::requiresFrameIndexScavenging(
    const MachineFunction &MF) const {
  return true;
}

const MCPhysReg*
VERegisterInfo::getCalleeSavedRegs(const MachineFunction *MF) const {
  const Function &F = MF->getFunction();
  CallingConv::ID CC = F.getCallingConv();

  switch (CC) {
  case CallingConv::X86_RegCall:
    return CSR_RegCall_SaveList;
  default:
    return CSR_SaveList;
  }
}

const uint32_t *
VERegisterInfo::getCallPreservedMask(const MachineFunction &MF,
                                        CallingConv::ID CC) const {
  switch (CC) {
  case CallingConv::X86_RegCall:
    return CSR_RegCall_RegMask;
  case CallingConv::VE_VEC_EXPF:
    return CSR_vec_expf_RegMask;
  case CallingConv::VE_LLVM_GROW_STACK:
    return CSR_llvm_grow_stack_RegMask;
  default:
    return CSR_RegMask;
  }
}

const uint32_t*
VERegisterInfo::getNoPreservedMask() const {
  return CSR_NoRegs_RegMask;
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

  // VL register is reserved
  // Reserved.set(VE::VL);

  // Other Misc registers are reserved
  Reserved.set(VE::UCC);
  Reserved.set(VE::PSW);
  Reserved.set(VE::SAR);
  Reserved.set(VE::PMMR);
  Reserved.set(VE::PMCR0);
  Reserved.set(VE::PMCR1);
  Reserved.set(VE::PMCR2);
  Reserved.set(VE::PMCR3);
  Reserved.set(VE::PMC0);
  Reserved.set(VE::PMC1);
  Reserved.set(VE::PMC2);
  Reserved.set(VE::PMC3);
  Reserved.set(VE::PMC4);
  Reserved.set(VE::PMC5);
  Reserved.set(VE::PMC6);
  Reserved.set(VE::PMC7);
  Reserved.set(VE::PMC8);
  Reserved.set(VE::PMC9);
  Reserved.set(VE::PMC10);
  Reserved.set(VE::PMC11);
  Reserved.set(VE::PMC12);
  Reserved.set(VE::PMC13);
  Reserved.set(VE::PMC14);

  // reserve constant registers
  Reserved.set(VE::VM0);
  Reserved.set(VE::VMP0);

  // sx18-sx33 are callee-saved registers
  // sx34-sx63 are temporary registers

  return Reserved;
}

bool VERegisterInfo::isConstantPhysReg(unsigned PhysReg) const {
  switch (PhysReg) {
  case VE::VM0:
  case VE::VMP0:
    return true;
  default:
    return false;
  }
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

  // Replace frame index with a temporal register if the instruction is
  // vector load/store.
  if (MI.getOpcode() == VE::LDVRri || MI.getOpcode() == VE::STVRri) {
#ifdef OBSOLETE_VE_VECTOR
    // Original MI is:
    //   STVRri frame-index, offset, reg, 256 (, memory operand)
    // or
    //   LDVRri reg, frame-index, offset, 256 (, memory operand)
    // Convert it to:
    //   LEA    tmp-reg, frame-reg, offset
    //   VSTir  reg, 8, tmp-reg, 256 (ignored)
    // or
    //   VLDir  reg, 8, tmp-reg, 256 (ignored)
    int opc = MI.getOpcode() == VE::LDVRri ? VE::VLDir : VE::VSTir;
    int regi = MI.getOpcode() == VE::LDVRri ? 0 : 2;
    const TargetInstrInfo &TII = *MF.getSubtarget().getInstrInfo();
    unsigned Reg = MI.getOperand(regi).getReg();
    bool isDef = MI.getOperand(regi).isDef();
    bool isKill = MI.getOperand(regi).isKill();

    // Prepare for VL
    unsigned VLReg = MF.getRegInfo().createVirtualRegister(&VE::VLSRegClass);
    if (MI.getOperand(3).isImm()) {
      int64_t val = MI.getOperand(3).getImm();
      if (val >= 0 && val < 64) {
        BuildMI(*MI.getParent(), II, dl, TII.get(VE::LVL), VLReg)
          .addImm(val);
      } else {
        unsigned Tmp1 = MF.getRegInfo().createVirtualRegister(&VE::I32RegClass);
        BuildMI(*MI.getParent(), II, dl, TII.get(VE::LEAzzi), Tmp1)
          .addImm(val);
        BuildMI(*MI.getParent(), II, dl, TII.get(VE::COPY), VLReg)
          .addReg(Tmp1, getKillRegState(true));
      }
    } else {
      BuildMI(*MI.getParent(), II, dl, TII.get(VE::COPY), VLReg)
        .add(MI.getOperand(3));
    }

    unsigned Tmp1 = MF.getRegInfo().createVirtualRegister(&VE::I64RegClass);
    BuildMI(*MI.getParent(), II, dl, TII.get(VE::LEAasx), Tmp1)
      .addReg(FramePtr).addImm(Offset);

    MI.setDesc(TII.get(opc));
    MI.getOperand(0).ChangeToRegister(Reg, isDef, false, isKill);
    MI.getOperand(1).ChangeToImmediate(8);
    MI.getOperand(2).ChangeToRegister(Tmp1, false, false, true);
    MI.getOperand(3).ChangeToRegister(VLReg, false, false, true);
#else
    // Original MI is:
    //   STVRri frame-index, offset, reg, vl (, memory operand)
    // or
    //   LDVRri reg, frame-index, offset, vl (, memory operand)
    // Convert it to:
    //   LEA       tmp-reg, frame-reg, offset
    //   vst_vIsl  reg, 8, tmp-reg, vl (ignored)
    // or
    //   vld_vIsl  reg, 8, tmp-reg, vl (ignored)
    int opc = MI.getOpcode() == VE::LDVRri ? VE::vld_vIsl : VE::vst_vIsl;
    int regi = MI.getOpcode() == VE::LDVRri ? 0 : 2;
    const TargetInstrInfo &TII = *MF.getSubtarget().getInstrInfo();
    unsigned Reg = MI.getOperand(regi).getReg();
    bool isDef = MI.getOperand(regi).isDef();
    bool isKill = MI.getOperand(regi).isKill();

    // Prepare for VL
    unsigned VLReg;
    if (MI.getOperand(3).isImm()) {
      int64_t val = MI.getOperand(3).getImm();
      // TODO: if 'val' is already assigned to a register, then use it
      VLReg = MF.getRegInfo().createVirtualRegister(&VE::I32RegClass);
      BuildMI(*MI.getParent(), II, dl, TII.get(VE::LEA32zzi), VLReg).addImm(val);
    } else {
      VLReg = MI.getOperand(3).getReg();
    }

    unsigned Tmp1 = MF.getRegInfo().createVirtualRegister(&VE::I64RegClass);
    BuildMI(*MI.getParent(), II, dl, TII.get(VE::LEAasx), Tmp1)
      .addReg(FramePtr).addImm(Offset);

    MI.setDesc(TII.get(opc));
    MI.getOperand(0).ChangeToRegister(Reg, isDef, false, isKill);
    MI.getOperand(1).ChangeToImmediate(8);
    MI.getOperand(2).ChangeToRegister(Tmp1, false, false, true);
    MI.getOperand(3).ChangeToRegister(VLReg, false, false, true);
#endif
    return;
  }

  // Otherwise, replace frame index with a frame pointer reference directly.
  // VE has 32 bit offset field, so no need to expand a target instruction.
  // Directly encode it.
  MI.getOperand(FIOperandNum).ChangeToRegister(FramePtr, false);
  MI.getOperand(FIOperandNum + 1).ChangeToImmediate(Offset);
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
  const VESubtarget &Subtarget = MF.getSubtarget<VESubtarget>();
  const VEFrameLowering *TFI = getFrameLowering(MF);

  unsigned FrameReg;
  int Offset;
  Offset = TFI->getFrameIndexReference(MF, FrameIndex, FrameReg);

  Offset += MI.getOperand(FIOperandNum + 1).getImm();

  if (MI.getOpcode() == VE::STQri) {
    const TargetInstrInfo &TII = *Subtarget.getInstrInfo();
    unsigned SrcReg   = MI.getOperand(2).getReg();
    unsigned SrcHiReg = getSubReg(SrcReg, VE::sub_even);
    unsigned SrcLoReg = getSubReg(SrcReg, VE::sub_odd);
    // VE stores HiReg to 8(addr) and LoReg to 0(addr)
    MachineInstr *StMI =
      BuildMI(*MI.getParent(), II, dl, TII.get(VE::STSri))
      .addReg(FrameReg).addImm(0).addReg(SrcLoReg);
    replaceFI(MF, II, *StMI, dl, 0, Offset, FrameReg);
    MI.setDesc(TII.get(VE::STSri));
    MI.getOperand(2).setReg(SrcHiReg);
    Offset += 8;
  } else if (MI.getOpcode() == VE::LDQri) {
    const TargetInstrInfo &TII = *Subtarget.getInstrInfo();
    unsigned DestReg   = MI.getOperand(0).getReg();
    unsigned DestHiReg = getSubReg(DestReg, VE::sub_even);
    unsigned DestLoReg = getSubReg(DestReg, VE::sub_odd);
    // VE loads HiReg from 8(addr) and LoReg from 0(addr)
    MachineInstr *StMI =
      BuildMI(*MI.getParent(), II, dl, TII.get(VE::LDSri), DestLoReg)
      .addReg(FrameReg).addImm(0);
    replaceFI(MF, II, *StMI, dl, 1, Offset, FrameReg);
    MI.setDesc(TII.get(VE::LDSri));
    MI.getOperand(0).setReg(DestHiReg);
    Offset += 8;
  } else if (MI.getOpcode() == VE::STVRri) {
    // fall-through
  } else if (MI.getOpcode() == VE::LDVRri) {
    // fall-through
  } else if (MI.getOpcode() == VE::STVMri) {
    // Original MI is:
    //   STVMri frame-index, offset, reg (, memory operand)
    // Convert it to:
    //   SVMi   tmp-reg, reg, 0
    //   STSri  frame-reg, offset, tmp-reg
    //   SVMi   tmp-reg, reg, 1
    //   STSri  frame-reg, offset+8, tmp-reg
    //   SVMi   tmp-reg, reg, 2
    //   STSri  frame-reg, offset+16, tmp-reg
    //   SVMi   tmp-reg, reg, 3
    //   STSri  frame-reg, offset+24, tmp-reg

    const TargetInstrInfo &TII = *Subtarget.getInstrInfo();
    unsigned SrcReg = MI.getOperand(2).getReg();
    bool isKill = MI.getOperand(2).isKill();
    // FIXME: it would be better to scavenge a register here instead of
    // reserving SX16 all of the time.
    unsigned TmpReg = VE::SX16;
    for (int i = 0; i < 3; ++i) {
      BuildMI(*MI.getParent(), II, dl, TII.get(VE::SVMi), TmpReg)
        .addReg(SrcReg).addImm(i);
      MachineInstr *StMI =
        BuildMI(*MI.getParent(), II, dl, TII.get(VE::STSri))
          .addReg(FrameReg).addImm(0)
          .addReg(TmpReg, getKillRegState(true));
      replaceFI(MF, II, *StMI, dl, 0, Offset, FrameReg);
      Offset += 8;
    }
    BuildMI(*MI.getParent(), II, dl, TII.get(VE::SVMi), TmpReg)
      .addReg(SrcReg, getKillRegState(isKill)).addImm(3);
    MI.setDesc(TII.get(VE::STSri));
    MI.getOperand(2).ChangeToRegister(TmpReg, false, false, true);
  } else if (MI.getOpcode() == VE::LDVMri) {
    // Original MI is:
    //   LDVMri reg, frame-index, offset (, memory operand)
    // Convert it to:
    //   LDSri  tmp-reg, frame-reg, offset
    //   LVMi   reg, reg, 0, tmp-reg
    //   LDSri  tmp-reg, frame-reg, offset+8
    //   LVMi   reg, reg, 1, tmp-reg
    //   LDSri  tmp-reg, frame-reg, offset+16
    //   LVMi   reg, reg, 2, tmp-reg
    //   LDSri  tmp-reg, frame-reg, offset+24
    //   LVMi   reg, reg, 3, tmp-reg

    const TargetInstrInfo &TII = *Subtarget.getInstrInfo();
    unsigned DestReg = MI.getOperand(0).getReg();
    // FIXME: it would be better to scavenge a register here instead of
    // reserving SX16 all of the time.
    unsigned TmpReg = VE::SX16;
    BuildMI(*MI.getParent(), II, dl, TII.get(VE::IMPLICIT_DEF), DestReg);
    for (int i = 0; i < 3; ++i) {
      MachineInstr *StMI =
        BuildMI(*MI.getParent(), II, dl, TII.get(VE::LDSri), TmpReg)
          .addReg(FrameReg).addImm(0);
      replaceFI(MF, II, *StMI, dl, 1, Offset, FrameReg);
      BuildMI(*MI.getParent(), II, dl, TII.get(VE::LVMi), DestReg)
        .addReg(DestReg).addImm(i).addReg(TmpReg, getKillRegState(true));
      Offset += 8;
    }
    MI.setDesc(TII.get(VE::LDSri));
    MI.getOperand(0).ChangeToRegister(TmpReg, true);
    BuildMI(*MI.getParent(), std::next(II), dl, TII.get(VE::LVMi), DestReg)
      .addReg(DestReg).addImm(3).addReg(TmpReg, getKillRegState(true));
  } else if (MI.getOpcode() == VE::STVM512ri) {
    const TargetInstrInfo &TII = *Subtarget.getInstrInfo();
    unsigned SrcReg   = MI.getOperand(2).getReg();
    unsigned SrcLoReg = getSubReg(SrcReg, VE::sub_vm_odd);
    unsigned SrcHiReg = getSubReg(SrcReg, VE::sub_vm_even);
    bool isKill = MI.getOperand(2).isKill();
    // FIXME: it would be better to scavenge a register here instead of
    // reserving SX16 all of the time.
    unsigned TmpReg = VE::SX16;
    // store low part of VMP
    MachineInstr *LastMI = nullptr;
    for (int i = 0; i < 4; ++i) {
      LastMI =
        BuildMI(*MI.getParent(), II, dl, TII.get(VE::SVMi), TmpReg)
          .addReg(SrcLoReg).addImm(i);
      MachineInstr *StMI =
        BuildMI(*MI.getParent(), II, dl, TII.get(VE::STSri))
          .addReg(FrameReg).addImm(0).addReg(TmpReg, getKillRegState(true));
      replaceFI(MF, II, *StMI, dl, 0, Offset, FrameReg);
      Offset += 8;
    }
    if (isKill)
      LastMI->addRegisterKilled(SrcLoReg, this);
    // store high part of VMP
    for (int i = 0; i < 3; ++i) {
      BuildMI(*MI.getParent(), II, dl, TII.get(VE::SVMi), TmpReg)
        .addReg(SrcHiReg).addImm(i);
      MachineInstr *StMI =
        BuildMI(*MI.getParent(), II, dl, TII.get(VE::STSri))
          .addReg(FrameReg).addImm(0).addReg(TmpReg, getKillRegState(true));
      replaceFI(MF, II, *StMI, dl, 0, Offset, FrameReg);
      Offset += 8;
    }
    LastMI =
      BuildMI(*MI.getParent(), II, dl, TII.get(VE::SVMi), TmpReg)
        .addReg(SrcHiReg).addImm(3);
    if (isKill) {
      LastMI->addRegisterKilled(SrcHiReg, this);
      // Add implicit super-register kills to the particular MI.
      LastMI->addRegisterKilled(SrcReg, this);
    }
    MI.setDesc(TII.get(VE::STSri));
    MI.getOperand(2).ChangeToRegister(TmpReg, false, false, true);
  } else if (MI.getOpcode() == VE::LDVM512ri) {
    const TargetInstrInfo &TII = *Subtarget.getInstrInfo();
    unsigned DestReg   = MI.getOperand(0).getReg();
    unsigned DestLoReg = getSubReg(DestReg, VE::sub_vm_odd);
    unsigned DestHiReg = getSubReg(DestReg, VE::sub_vm_even);
    // FIXME: it would be better to scavenge a register here instead of
    // reserving SX16 all of the time.
    unsigned TmpReg = VE::SX16;
    BuildMI(*MI.getParent(), II, dl, TII.get(VE::IMPLICIT_DEF), DestReg);
    for (int i = 0; i < 4; ++i) {
      MachineInstr *StMI =
        BuildMI(*MI.getParent(), II, dl, TII.get(VE::LDSri), TmpReg)
          .addReg(FrameReg).addImm(0);
      replaceFI(MF, II, *StMI, dl, 1, Offset, FrameReg);
      BuildMI(*MI.getParent(), II, dl, TII.get(VE::LVMi), DestLoReg)
        .addReg(DestLoReg).addImm(i).addReg(TmpReg, getKillRegState(true));
      Offset += 8;
    }
    for (int i = 0; i < 3; ++i) {
      MachineInstr *StMI =
        BuildMI(*MI.getParent(), II, dl, TII.get(VE::LDSri), TmpReg)
          .addReg(FrameReg).addImm(0);
      replaceFI(MF, II, *StMI, dl, 1, Offset, FrameReg);
      BuildMI(*MI.getParent(), II, dl, TII.get(VE::LVMi), DestHiReg)
        .addReg(DestHiReg).addImm(i).addReg(TmpReg, getKillRegState(true));
      Offset += 8;
    }
    MI.setDesc(TII.get(VE::LDSri));
    MI.getOperand(0).ChangeToRegister(TmpReg, true);
    BuildMI(*MI.getParent(), std::next(II), dl, TII.get(VE::LVMi), DestHiReg)
      .addReg(DestHiReg).addImm(3).addReg(TmpReg, getKillRegState(true));
  } else if (MI.getOpcode() == VE::STVLri) {
    const TargetInstrInfo &TII = *Subtarget.getInstrInfo();
    unsigned SrcReg = MI.getOperand(2).getReg();
    bool isKill = MI.getOperand(2).isKill();
    unsigned TmpReg = MF.getRegInfo().createVirtualRegister(&VE::I32RegClass);
    BuildMI(*MI.getParent(), II, dl, TII.get(VE::SVL), TmpReg)
      .addReg(SrcReg, getKillRegState(isKill));
    MI.setDesc(TII.get(VE::STLri));
    MI.getOperand(2).setReg(TmpReg);
  } else if (MI.getOpcode() == VE::LDVLri) {
    const TargetInstrInfo &TII = *Subtarget.getInstrInfo();
    unsigned DestReg = MI.getOperand(0).getReg();
    unsigned TmpReg = MF.getRegInfo().createVirtualRegister(&VE::I32RegClass);
    MI.setDesc(TII.get(VE::LDLri));
    MI.getOperand(0).ChangeToRegister(TmpReg, true);
    // MI.getOperand(0).setReg(TmpReg);
    BuildMI(*MI.getParent(), std::next(II), dl, TII.get(VE::LVL), DestReg)
      .addReg(TmpReg, getKillRegState(true));
  }

  replaceFI(MF, II, MI, dl, FIOperandNum, Offset, FrameReg);
}

unsigned VERegisterInfo::getRegPressureSetLimit(const MachineFunction &MF,
                                                unsigned Idx) const {
  // VE has only one single physical VL register, but considering VL
  // register presssure in MI scheduling cause many vector registers
  // spills/restores and decrease performance of generated codes.
  // Therefore, we pretend having 128 VL registers.  This way, llvm
  // forgets about VL register in MI scheduling.
  if (Idx == VLSPSetID)
    return 128;

  return VEGenRegisterInfo::getRegPressureSetLimit(MF, Idx);
}

Register VERegisterInfo::getFrameRegister(const MachineFunction &MF) const {
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
