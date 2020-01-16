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
  const Function &F = MF->getFunction();
  CallingConv::ID CC = F.getCallingConv();

  switch (CC) {
  default:
    return CSR_SaveList;
  }
}

const uint32_t *VERegisterInfo::getCallPreservedMask(const MachineFunction &MF,
                                                     CallingConv::ID CC) const {
  switch (CC) {
  case CallingConv::VE_VEC_EXPF:
    return CSR_vec_expf_RegMask;
  case CallingConv::VE_LLVM_GROW_STACK:
    return CSR_llvm_grow_stack_RegMask;
  default:
    return CSR_RegMask;
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

      VE::UCC,  // User clock counter
      VE::PSW,  // Program status word
      VE::SAR,  // Store adress
      VE::PMMR, // Performance monitor mode

      // Performance monitor configuration
      VE::PMCR0,
      VE::PMCR1,
      VE::PMCR2,
      VE::PMCR3,

      // Performance monitor counter
      VE::PMC0,
      VE::PMC1,
      VE::PMC2,
      VE::PMC3,
      VE::PMC4,
      VE::PMC5,
      VE::PMC6,
      VE::PMC7,
      VE::PMC8,
      VE::PMC9,
      VE::PMC10,
      VE::PMC11,
      VE::PMC12,
      VE::PMC13,
      VE::PMC14,
  };

  for (auto R : ReservedRegs)
    for (MCRegAliasIterator ItAlias(R, this, true); ItAlias.isValid();
         ++ItAlias)
      Reserved.set(*ItAlias);

  return Reserved;
}

bool VERegisterInfo::isConstantPhysReg(unsigned PhysReg) const {
  switch (PhysReg) {
  default:
    return false;
  }
}

const TargetRegisterClass *
VERegisterInfo::getPointerRegClass(const MachineFunction &MF,
                                   unsigned Kind) const {
  return &VE::I64RegClass;
}

static void replaceFI(MachineFunction &MF, MachineBasicBlock::iterator II,
                      MachineInstr &MI, const DebugLoc &dl,
                      unsigned FIOperandNum, int Offset, unsigned FramePtr) {
  // Replace frame index with a frame pointer reference directly.
  // VE has 32 bit offset field, so no need to expand a target instruction.
  // Directly encode it.
  MI.getOperand(FIOperandNum).ChangeToRegister(FramePtr, false);
  MI.getOperand(FIOperandNum + 1).ChangeToImmediate(Offset);
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

  unsigned FrameReg;
  int Offset;
  Offset = TFI->getFrameIndexReference(MF, FrameIndex, FrameReg);

  Offset += MI.getOperand(FIOperandNum + 1).getImm();

  if (MI.getOpcode() == VE::STQri) {
    const TargetInstrInfo &TII = *Subtarget.getInstrInfo();
    unsigned SrcReg = MI.getOperand(2).getReg();
    unsigned SrcHiReg = getSubReg(SrcReg, VE::sub_even);
    unsigned SrcLoReg = getSubReg(SrcReg, VE::sub_odd);
    // VE stores HiReg to 8(addr) and LoReg to 0(addr)
    MachineInstr *StMI = BuildMI(*MI.getParent(), II, dl, TII.get(VE::STSri))
                             .addReg(FrameReg)
                             .addImm(0)
                             .addReg(SrcLoReg);
    replaceFI(MF, II, *StMI, dl, 0, Offset, FrameReg);
    MI.setDesc(TII.get(VE::STSri));
    MI.getOperand(2).setReg(SrcHiReg);
    Offset += 8;
  } else if (MI.getOpcode() == VE::LDQri) {
    const TargetInstrInfo &TII = *Subtarget.getInstrInfo();
    unsigned DestReg = MI.getOperand(0).getReg();
    unsigned DestHiReg = getSubReg(DestReg, VE::sub_even);
    unsigned DestLoReg = getSubReg(DestReg, VE::sub_odd);
    // VE loads HiReg from 8(addr) and LoReg from 0(addr)
    MachineInstr *StMI =
        BuildMI(*MI.getParent(), II, dl, TII.get(VE::LDSri), DestLoReg)
            .addReg(FrameReg)
            .addImm(0);
    replaceFI(MF, II, *StMI, dl, 1, Offset, FrameReg);
    MI.setDesc(TII.get(VE::LDSri));
    MI.getOperand(0).setReg(DestHiReg);
    Offset += 8;
  }

  replaceFI(MF, II, MI, dl, FIOperandNum, Offset, FrameReg);
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
