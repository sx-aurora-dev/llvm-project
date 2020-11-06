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
VERegisterInfo::VERegisterInfo() : VEGenRegisterInfo(VE::SX10) {}

bool VERegisterInfo::requiresRegisterScavenging(
    const MachineFunction &MF) const {
  return true;
}

bool VERegisterInfo::requiresFrameIndexScavenging(
    const MachineFunction &MF) const {
  return true;
}

const MCPhysReg *
VERegisterInfo::getCalleeSavedRegs(const MachineFunction *MF) const {
  switch (MF->getFunction().getCallingConv()) {
  default:
    return CSR_SaveList;
  case CallingConv::PreserveAll:
    return CSR_preserve_all_SaveList;
  case CallingConv::X86_RegCall:
    return CSR_RegCall_SaveList;
  }
}

const uint32_t *VERegisterInfo::getCallPreservedMask(const MachineFunction &MF,
                                                     CallingConv::ID CC) const {
  switch (CC) {
  default:
    return CSR_RegMask;
  case CallingConv::PreserveAll:
    return CSR_preserve_all_RegMask;
  case CallingConv::VE_VEC_EXPF:
    return CSR_vec_expf_RegMask;
  case CallingConv::X86_RegCall:
    return CSR_RegCall_RegMask;
  }
}

const uint32_t *VERegisterInfo::getNoPreservedMask() const {
  return CSR_NoRegs_RegMask;
}

BitVector VERegisterInfo::getReservedRegs(const MachineFunction &MF) const {
  BitVector Reserved(getNumRegs());

  const Register ReservedRegs[] = {
      VE::SX8,  // Stack limit
      VE::SX9,  // Frame pointer
      VE::SX10, // Link register (return address)
      VE::SX11, // Stack pointer

      // FIXME: maybe not need to be reserved
      VE::SX12, // Outer register
      VE::SX13, // Id register for dynamic linker

      VE::SX14, // Thread pointer
      VE::SX15, // Global offset table register
      VE::SX16, // Procedure linkage table register
      VE::SX17, // Linkage-area register
                // sx18-sx33 are callee-saved registers
                // sx34-sx63 are temporary registers
  };

  for (auto R : ReservedRegs)
    for (MCRegAliasIterator ItAlias(R, this, true); ItAlias.isValid();
         ++ItAlias)
      Reserved.set(*ItAlias);

  // VL register is reserved
  // Reserved.set(VE::VL);

  // Other Misc registers are reserved
  Reserved.set(VE::USRCC);
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

  return Reserved;
}

bool VERegisterInfo::isConstantPhysReg(MCRegister PhysReg) const {
  switch (PhysReg) {
  case VE::VM0:
  case VE::VMP0:
    return true;
  default:
    return false;
  }
}

const TargetRegisterClass *
VERegisterInfo::getPointerRegClass(const MachineFunction &MF,
                                   unsigned Kind) const {
  return &VE::I64RegClass;
}

#define DEBUG_TYPE "ve-register-info"

static unsigned offset_to_disp(MachineInstr &MI) {
  // Default offset in instruction's operands (reg+reg+imm).
  unsigned OffDisp = 2;

#define RRCASm_kind(NAME) \
  case NAME ## rir: \
  case NAME ## rii:

  {
    using namespace llvm::VE;
    switch (MI.getOpcode()) {
    case INLINEASM:
    RRCASm_kind(TS1AML)
    RRCASm_kind(TS1AMW)
    RRCASm_kind(CASL)
    RRCASm_kind(CASW)
      // These instructions use AS format (reg+imm).
      OffDisp = 1;
    }
  }
#undef RRCASm_kind

  return OffDisp;
}

static void replaceFI(MachineFunction &MF, MachineBasicBlock::iterator II,
                      MachineInstr &MI, const DebugLoc &dl,
                      unsigned FIOperandNum, int Offset, Register FrameReg) {
  if (1) {
      LLVM_DEBUG(dbgs() << "replaceFI: "; MI.dump());
  }

  // Replace frame index with a temporal register if the instruction is
  // vector load/store.
  if (MI.getOpcode() == VE::LDVRrii || MI.getOpcode() == VE::STVRrii) {
    // Original MI is:
    //   STVRrii frame-index, 0, offset, reg, vl (, memory operand)
    // or
    //   LDVRrii reg, frame-index, 0, offset, vl (, memory operand)
    // Convert it to:
    //   LEA tmp, frame-reg, 0, offset
    //   VSTirvl 8, tmp-reg, vr, vl
    // or
    //   LEA tmp, frame-reg, 0, offset
    //   VLDirl vr, 8, tmp-reg, vl
    int opc = MI.getOpcode() == VE::LDVRrii ? VE::VLDirl : VE::VSTirvl;
    int regi = MI.getOpcode() == VE::LDVRrii ? 0 : 3;
    int idxo = MI.getOpcode() == VE::LDVRrii ? 1 : 0;
    int baseo = MI.getOpcode() == VE::LDVRrii ? 2 : 1;
    int rego = MI.getOpcode() == VE::LDVRrii ? 0 : 2;
    int vlo = 3;
    const TargetInstrInfo &TII = *MF.getSubtarget().getInstrInfo();
    unsigned Reg = MI.getOperand(regi).getReg();
    bool isDef = MI.getOperand(regi).isDef();
    bool isKill = MI.getOperand(regi).isKill();

    // Prepare for VL
    unsigned VLReg;
    bool isKillSuper = false;
    unsigned SuperReg;
    const TargetRegisterInfo *TRI = MF.getSubtarget().getRegisterInfo();
    if (MI.getOperand(4).isImm()) {
      int64_t val = MI.getOperand(4).getImm();
      // TODO: if 'val' is already assigned to a register, then use it
      // FIXME: it would be better to scavenge a register here instead of
      // reserving SX16 all of the time.
      SuperReg = VE::SX16;
      isKillSuper = true;
      VLReg = TRI->getSubReg(SuperReg, VE::sub_i32);
      BuildMI(*MI.getParent(), II, dl, TII.get(VE::LEAzii), SuperReg)
          .addImm(0).addImm(0).addImm(val);
    } else {
      VLReg = MI.getOperand(4).getReg();
    }

    unsigned Tmp1 = MF.getRegInfo().createVirtualRegister(&VE::I64RegClass);
    BuildMI(*MI.getParent(), II, dl, TII.get(VE::LEArri), Tmp1)
      .addReg(FrameReg).addImm(0).addImm(Offset);

    MI.setDesc(TII.get(opc));
    MI.getOperand(rego).ChangeToRegister(Reg, isDef, false, isKill);
    MI.getOperand(idxo).ChangeToImmediate(8);
    MI.getOperand(baseo).ChangeToRegister(Tmp1, false, false, true);
    MI.getOperand(vlo).ChangeToRegister(VLReg, false, false, true);
    MI.RemoveOperand(4);
    if (isKillSuper)
      MI.addRegisterKilled(SuperReg, TRI, true);
    return;
  }

  // Otherwise, replace frame index with a frame pointer reference directly.

  // VE has 32 bit offset field, so no need to expand a target instruction.
  // Directly encode it.
  MI.getOperand(FIOperandNum).ChangeToRegister(FrameReg, false);
  MI.getOperand(FIOperandNum + offset_to_disp(MI)).ChangeToImmediate(Offset);
}

void VERegisterInfo::eliminateFrameIndex(MachineBasicBlock::iterator II,
                                         int SPAdj, unsigned FIOperandNum,
                                         RegScavenger *RS) const {
  assert(SPAdj == 0 && "Unexpected");

  MachineInstr &MI = *II;
  DebugLoc dl = MI.getDebugLoc();
  int FrameIndex = MI.getOperand(FIOperandNum).getIndex();
  MachineFunction &MF = *MI.getParent()->getParent();
  const VESubtarget &Subtarget = MF.getSubtarget<VESubtarget>();
  const VEFrameLowering *TFI = getFrameLowering(MF);

  Register FrameReg;
  int Offset;
  Offset = TFI->getFrameIndexReference(MF, FrameIndex, FrameReg).getFixed();

  Offset += MI.getOperand(FIOperandNum + offset_to_disp(MI)).getImm();

  if (MI.getOpcode() == VE::STQrii) {
    const TargetInstrInfo &TII = *Subtarget.getInstrInfo();
    unsigned SrcReg   = MI.getOperand(3).getReg();
    unsigned SrcHiReg = getSubReg(SrcReg, VE::sub_even);
    unsigned SrcLoReg = getSubReg(SrcReg, VE::sub_odd);
    // VE stores HiReg to 8(addr) and LoReg to 0(addr)
    MachineInstr *StMI =
      BuildMI(*MI.getParent(), II, dl, TII.get(VE::STrii))
      .addReg(FrameReg).addImm(0).addImm(0).addReg(SrcLoReg);
    replaceFI(MF, II, *StMI, dl, 0, Offset, FrameReg);
    MI.setDesc(TII.get(VE::STrii));
    MI.getOperand(3).setReg(SrcHiReg);
    Offset += 8;
  } else if (MI.getOpcode() == VE::LDQrii) {
    const TargetInstrInfo &TII = *Subtarget.getInstrInfo();
    unsigned DestReg   = MI.getOperand(0).getReg();
    unsigned DestHiReg = getSubReg(DestReg, VE::sub_even);
    unsigned DestLoReg = getSubReg(DestReg, VE::sub_odd);
    // VE loads HiReg from 8(addr) and LoReg from 0(addr)
    MachineInstr *StMI =
      BuildMI(*MI.getParent(), II, dl, TII.get(VE::LDrii), DestLoReg)
      .addReg(FrameReg).addImm(0).addImm(0);
    replaceFI(MF, II, *StMI, dl, 1, Offset, FrameReg);
    MI.setDesc(TII.get(VE::LDrii));
    MI.getOperand(0).setReg(DestHiReg);
    Offset += 8;
  } else if (MI.getOpcode() == VE::STVRrii) {
    // fall-through
  } else if (MI.getOpcode() == VE::LDVRrii) {
    // fall-through
  } else if (MI.getOpcode() == VE::STVMrii) {
    // Original MI is:
    //   STVMrii frame-index, 0, offset, reg (, memory operand)
    // Convert it to:
    //   SVMi   tmp-reg, reg, 0
    //   STrii  frame-reg, 0, offset, tmp-reg
    //   SVMi   tmp-reg, reg, 1
    //   STrii  frame-reg, 0, offset+8, tmp-reg
    //   SVMi   tmp-reg, reg, 2
    //   STrii  frame-reg, 0, offset+16, tmp-reg
    //   SVMi   tmp-reg, reg, 3
    //   STrii  frame-reg, 0, offset+24, tmp-reg

    const TargetInstrInfo &TII = *Subtarget.getInstrInfo();
    unsigned SrcReg = MI.getOperand(3).getReg();
    bool isKill = MI.getOperand(3).isKill();
    // FIXME: it would be better to scavenge a register here instead of
    // reserving SX16 all of the time.
    unsigned TmpReg = VE::SX16;
    for (int i = 0; i < 3; ++i) {
      BuildMI(*MI.getParent(), II, dl, TII.get(VE::SVMmr), TmpReg)
        .addReg(SrcReg).addImm(i);
      MachineInstr *StMI =
        BuildMI(*MI.getParent(), II, dl, TII.get(VE::STrii))
          .addReg(FrameReg).addImm(0).addImm(0)
          .addReg(TmpReg, getKillRegState(true));
      replaceFI(MF, II, *StMI, dl, 0, Offset, FrameReg);
      Offset += 8;
    }
    BuildMI(*MI.getParent(), II, dl, TII.get(VE::SVMmr), TmpReg)
      .addReg(SrcReg, getKillRegState(isKill)).addImm(3);
    MI.setDesc(TII.get(VE::STrii));
    MI.getOperand(3).ChangeToRegister(TmpReg, false, false, true);
  } else if (MI.getOpcode() == VE::LDVMrii) {
    // Original MI is:
    //   LDVMri reg, frame-index, 0, offset (, memory operand)
    // Convert it to:
    //   LDrii  tmp-reg, frame-reg, 0, offset
    //   LVMir vm, 0, tmp-reg
    //   LDrii  tmp-reg, frame-reg, 0, offset+8
    //   LVMir_m vm, 1, tmp-reg, vm
    //   LDrii  tmp-reg, frame-reg, 0, offset+16
    //   LVMir_m vm, 2, tmp-reg, vm
    //   LDrii  tmp-reg, frame-reg, 0, offset+24
    //   LVMir_m vm, 3, tmp-reg, vm

    const TargetInstrInfo &TII = *Subtarget.getInstrInfo();
    unsigned DestReg = MI.getOperand(0).getReg();
    // FIXME: it would be better to scavenge a register here instead of
    // reserving SX16 all of the time.
    unsigned TmpReg = VE::SX16;
    for (int i = 0; i < 4; ++i) {
      if (i != 3) {
        MachineInstr *StMI =
          BuildMI(*MI.getParent(), II, dl, TII.get(VE::LDrii), TmpReg)
            .addReg(FrameReg).addImm(0).addImm(0);
        replaceFI(MF, II, *StMI, dl, 1, Offset, FrameReg);
        Offset += 8;
      } else {
        // Last LDrii replace the target instruction.
        MI.setDesc(TII.get(VE::LDrii));
        MI.getOperand(0).ChangeToRegister(TmpReg, true);
      }
      // First LVM is LVMir.  Others are LVMir_m.  Last LVM places at the
      // next of the target instruction.
      if (i == 0)
        BuildMI(*MI.getParent(), II, dl, TII.get(VE::LVMir), DestReg)
          .addImm(i).addReg(TmpReg, getKillRegState(true));
      else if (i != 3)
        BuildMI(*MI.getParent(), II, dl, TII.get(VE::LVMir_m), DestReg)
          .addImm(i).addReg(TmpReg, getKillRegState(true)).addReg(DestReg);
      else
        BuildMI(*MI.getParent(), std::next(II), dl, TII.get(VE::LVMir_m),
                DestReg)
          .addImm(3).addReg(TmpReg, getKillRegState(true)).addReg(DestReg);
    }
  } else if (MI.getOpcode() == VE::STVM512rii) {
    const TargetInstrInfo &TII = *Subtarget.getInstrInfo();
    unsigned SrcReg   = MI.getOperand(3).getReg();
    unsigned SrcLoReg = getSubReg(SrcReg, VE::sub_vm_odd);
    unsigned SrcHiReg = getSubReg(SrcReg, VE::sub_vm_even);
    bool isKill = MI.getOperand(3).isKill();
    // FIXME: it would be better to scavenge a register here instead of
    // reserving SX16 all of the time.
    unsigned TmpReg = VE::SX16;
    // store low part of VMP
    MachineInstr *LastMI = nullptr;
    for (int i = 0; i < 4; ++i) {
      LastMI =
        BuildMI(*MI.getParent(), II, dl, TII.get(VE::SVMmr), TmpReg)
          .addReg(SrcLoReg).addImm(i);
      MachineInstr *StMI =
        BuildMI(*MI.getParent(), II, dl, TII.get(VE::STrii))
          .addReg(FrameReg).addImm(0).addImm(0)
          .addReg(TmpReg, getKillRegState(true));
      replaceFI(MF, II, *StMI, dl, 0, Offset, FrameReg);
      Offset += 8;
    }
    if (isKill)
      LastMI->addRegisterKilled(SrcLoReg, this, true);
    // store high part of VMP
    for (int i = 0; i < 3; ++i) {
      BuildMI(*MI.getParent(), II, dl, TII.get(VE::SVMmr), TmpReg)
        .addReg(SrcHiReg).addImm(i);
      MachineInstr *StMI =
        BuildMI(*MI.getParent(), II, dl, TII.get(VE::STrii))
          .addReg(FrameReg).addImm(0).addImm(0)
          .addReg(TmpReg, getKillRegState(true));
      replaceFI(MF, II, *StMI, dl, 0, Offset, FrameReg);
      Offset += 8;
    }
    LastMI =
      BuildMI(*MI.getParent(), II, dl, TII.get(VE::SVMmr), TmpReg)
        .addReg(SrcHiReg).addImm(3);
    if (isKill) {
      LastMI->addRegisterKilled(SrcHiReg, this, true);
      // Add implicit super-register kills to the particular MI.
      LastMI->addRegisterKilled(SrcReg, this, true);
    }
    MI.setDesc(TII.get(VE::STrii));
    MI.getOperand(3).ChangeToRegister(TmpReg, false, false, true);
  } else if (MI.getOpcode() == VE::LDVM512rii) {
    const TargetInstrInfo &TII = *Subtarget.getInstrInfo();
    unsigned DestReg   = MI.getOperand(0).getReg();
    unsigned DestLoReg = getSubReg(DestReg, VE::sub_vm_odd);
    unsigned DestHiReg = getSubReg(DestReg, VE::sub_vm_even);
    // FIXME: it would be better to scavenge a register here instead of
    // reserving SX16 all of the time.
    unsigned TmpReg = VE::SX16;
    BuildMI(*MI.getParent(), II, dl, TII.get(VE::IMPLICIT_DEF), DestReg);
    for (int i = 0; i < 4; ++i) {
      MachineInstr *LdMI =
        BuildMI(*MI.getParent(), II, dl, TII.get(VE::LDrii), TmpReg)
          .addReg(FrameReg).addImm(0).addImm(0);
      replaceFI(MF, II, *LdMI, dl, 1, Offset, FrameReg);
      BuildMI(*MI.getParent(), II, dl, TII.get(VE::LVMir_m), DestLoReg)
        .addImm(i)
        .addReg(TmpReg, getKillRegState(true))
        .addReg(DestLoReg);
      Offset += 8;
    }
    for (int i = 0; i < 3; ++i) {
      MachineInstr *LdMI =
        BuildMI(*MI.getParent(), II, dl, TII.get(VE::LDrii), TmpReg)
          .addReg(FrameReg).addImm(0).addImm(0);
      replaceFI(MF, II, *LdMI, dl, 1, Offset, FrameReg);
      BuildMI(*MI.getParent(), II, dl, TII.get(VE::LVMir_m), DestHiReg)
        .addImm(i)
        .addReg(TmpReg, getKillRegState(true))
        .addReg(DestHiReg);
      Offset += 8;
    }
    MI.setDesc(TII.get(VE::LDrii));
    MI.getOperand(0).ChangeToRegister(TmpReg, true);
    BuildMI(*MI.getParent(), std::next(II), dl, TII.get(VE::LVMir_m),
            DestHiReg)
      .addImm(3)
      .addReg(TmpReg, getKillRegState(true))
      .addReg(DestHiReg);
  }

  if (MI.getOpcode() == VE::STQrii) {
    const TargetInstrInfo &TII = *MF.getSubtarget().getInstrInfo();
    Register SrcReg = MI.getOperand(3).getReg();
    Register SrcHiReg = getSubReg(SrcReg, VE::sub_even);
    Register SrcLoReg = getSubReg(SrcReg, VE::sub_odd);
    // VE stores HiReg to 8(addr) and LoReg to 0(addr)
    MachineInstr *StMI = BuildMI(*MI.getParent(), II, dl, TII.get(VE::STrii))
                             .addReg(FrameReg)
                             .addImm(0)
                             .addImm(0)
                             .addReg(SrcLoReg);
    replaceFI(MF, II, *StMI, dl, 0, Offset, FrameReg);
    MI.setDesc(TII.get(VE::STrii));
    MI.getOperand(3).setReg(SrcHiReg);
    Offset += 8;
  } else if (MI.getOpcode() == VE::LDQrii) {
    const TargetInstrInfo &TII = *MF.getSubtarget().getInstrInfo();
    Register DestReg = MI.getOperand(0).getReg();
    Register DestHiReg = getSubReg(DestReg, VE::sub_even);
    Register DestLoReg = getSubReg(DestReg, VE::sub_odd);
    // VE loads HiReg from 8(addr) and LoReg from 0(addr)
    MachineInstr *StMI =
        BuildMI(*MI.getParent(), II, dl, TII.get(VE::LDrii), DestLoReg)
            .addReg(FrameReg)
            .addImm(0)
            .addImm(0);
    replaceFI(MF, II, *StMI, dl, 1, Offset, FrameReg);
    MI.setDesc(TII.get(VE::LDrii));
    MI.getOperand(0).setReg(DestHiReg);
    Offset += 8;
  }

  replaceFI(MF, II, MI, dl, FIOperandNum, Offset, FrameReg);
}

unsigned VERegisterInfo::getRegPressureSetLimit(const MachineFunction &MF,
                                                unsigned Idx) const {
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
