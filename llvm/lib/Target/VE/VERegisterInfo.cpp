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

#include "VE.h"
#include "VEMachineFunctionInfo.h"
#include "VERegisterInfo.h"
#include "VESubtarget.h"
#include "llvm/ADT/BitVector.h"
#include "llvm/ADT/STLExtras.h"
#include "llvm/ADT/SmallSet.h"
#include "llvm/CodeGen/LiveRegMatrix.h"
#include "llvm/CodeGen/MachineFrameInfo.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/CodeGen/TargetInstrInfo.h"
#include "llvm/IR/Type.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/ErrorHandling.h"

using namespace llvm;

#define GET_REGINFO_TARGET_DESC
#include "VEGenRegisterInfo.inc"

namespace llvm {
cl::opt<bool> EnableRoundRobinAlloc(
    "ve-regalloc", cl::init(false), cl::NotHidden,
    cl::desc("(Use improved vector register allocation (work in progress)"));
}

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
  case CallingConv::Fast:
    return CSR_RegCall_SaveList;
  default:
    return CSR_SaveList;
  case CallingConv::PreserveAll:
    return CSR_preserve_all_SaveList;
  }
}

const uint32_t *VERegisterInfo::getCallPreservedMask(const MachineFunction &MF,
                                                     CallingConv::ID CC) const {
  switch (CC) {
  case CallingConv::Fast:
    return CSR_RegCall_RegMask;
  default:
    // NCC default CC does not explictly mention vector (mask) regs - assume
    // that they are clobbered
    return CSR_RegMask;
  case CallingConv::PreserveAll:
    return CSR_preserve_all_RegMask;
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

      VE::SX14,  // Thread pointer
      VE::SX15,  // Global offset table register
      VE::SX16,  // Procedure linkage table register
      VE::SX17,  // Linkage-area register
                 // sx18-sx33 are callee-saved registers
                 // sx34-sx63 are temporary registers
      VE::USRCC, // User clock counter
      VE::PSW,   // Program status word
      VE::SAR,   // Store adress
      VE::PMMR,  // Performance monitor mode

      // Performance monitor configuration
      VE::PMCR0, VE::PMCR1, VE::PMCR2, VE::PMCR3,

      // Performance monitor counter
      VE::PMC0, VE::PMC1, VE::PMC2, VE::PMC3, VE::PMC4, VE::PMC5, VE::PMC6,
      VE::PMC7, VE::PMC8, VE::PMC9, VE::PMC10, VE::PMC11, VE::PMC12, VE::PMC13,
      VE::PMC14,

      // non-allocatable vector register
      VE::VIX,

      // Zero-mask registers
      VE::VM0, VE::VMP0,

      // FIXME testing VL as reserved register to enable undefined use of $vl
      // (MachineCodeVerifier fails otw because that one is run before LVLGen
      // runs and inserts definitions for the register)
      VE::VL};

  for (auto R : ReservedRegs)
    for (MCRegAliasIterator ItAlias(R, this, true); ItAlias.isValid();
         ++ItAlias)
      Reserved.set(*ItAlias);

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

static unsigned offsetToDisp(MachineInstr &MI) {
  // Default offset in instruction's operands (reg+reg+imm).
  unsigned OffDisp = 2;

#define RRCAS_multi_cases(NAME) NAME##rir : case NAME##rii

  {
    using namespace llvm::VE;
    switch (MI.getOpcode()) {
    case INLINEASM:
    case RRCAS_multi_cases(TS1AML):
    case RRCAS_multi_cases(TS1AMW):
    case RRCAS_multi_cases(CASL):
    case RRCAS_multi_cases(CASW):
      // These instructions use AS format (reg+imm).
      OffDisp = 1;
      break;
    }
  }
#undef RRCAS_multi_cases

  return OffDisp;
}

struct LVLInfo {
  Register VLReg;
  unsigned SuperReg; // ???
  bool IsKillSuper;

  LVLInfo() : VLReg(), SuperReg(0), IsKillSuper(false) {}
};

struct MIBuilder {
  const TargetInstrInfo &TII;
  const TargetRegisterInfo &TRI;
  const DebugLoc &DL;
  MachineBasicBlock &MBB;
  MachineBasicBlock::iterator II;

  MachineFunction &getFunc() const { return *MBB.getParent(); }
  inline MCRegister getSubReg(MCRegister Reg, unsigned Idx) const {
    return TRI.getSubReg(Reg, Idx);
  }

  inline const MCInstrDesc &get(unsigned Opcode) const {
    return TII.get(Opcode);
  }

  MIBuilder(const TargetInstrInfo &TII, const TargetRegisterInfo &TRI,
            const DebugLoc &DL, MachineBasicBlock &MBB,
            MachineBasicBlock::iterator II)
      : TII(TII), TRI(TRI), DL(DL), MBB(MBB), II(II) {}

  LVLInfo emitLVL(MachineOperand &AVLOp) {
    LVLInfo LVL;
    if (AVLOp.isImm()) {
      int64_t Val = AVLOp.getImm();
      // TODO: if 'val' is already assigned to a register, then use it
      // FIXME: it would be better to scavenge a register here instead of
      // reserving SX16 all of the time.
      LVL.SuperReg = VE::SX16;
      LVL.IsKillSuper = true;
      LVL.VLReg = TRI.getSubReg(LVL.SuperReg, VE::sub_i32);
      build(VE::LEAzii, LVL.SuperReg).addImm(0).addImm(0).addImm(Val);
    } else {
      LVL.VLReg = AVLOp.getReg();
    }
    return LVL;
  }

  inline MachineInstrBuilder build(const MCInstrDesc &MCID, Register DestReg) {
    return BuildMI(MBB, II, DL, MCID, DestReg);
  }
  inline MachineInstrBuilder build(unsigned InstOpc, Register DestReg) {
    return build(get(InstOpc), DestReg);
  }

  inline MachineInstrBuilder build(const MCInstrDesc &MCID) {
    return BuildMI(MBB, II, DL, MCID);
  }
  inline MachineInstrBuilder build(unsigned InstOpc) {
    return build(get(InstOpc));
  }

  Register createVirtualRegister(const TargetRegisterClass &RegClass) const {
    return getFunc().getRegInfo().createVirtualRegister(&RegClass);
  }

  // Replace the frame index in \p MI with a proper byte and framereg offset.
  void replaceFI(MachineInstr &MI, Register FrameReg, int64_t Offset,
                 int FIOperandNum) {
    MI.getOperand(FIOperandNum).ChangeToRegister(FrameReg, false);
    MI.getOperand(FIOperandNum + offsetToDisp(MI)).ChangeToImmediate(Offset);
  }
};

void VERegisterInfo::eliminateFrameIndex_Q(MachineInstr &MI, MIBuilder &MIB,
                                           Register FrameReg, int Offset,
                                           int FIOperandNum) const {
  LLVM_DEBUG(dbgs() << "eliminateFI_Q: "; MI.dump());

  if (MI.getOpcode() == VE::STQrii) {
    Register SrcReg = MI.getOperand(3).getReg();
    Register SrcHiReg = MIB.getSubReg(SrcReg, VE::sub_even);
    Register SrcLoReg = MIB.getSubReg(SrcReg, VE::sub_odd);
    // VE stores HiReg to 8(addr) and LoReg to 0(addr)
    MachineInstr *StMI =
        MIB.build(VE::STrii).addReg(FrameReg).addImm(0).addImm(0).addReg(
            SrcLoReg);
    MIB.replaceFI(*StMI, FrameReg, Offset, 0);
    // Mutate to 'hi' store.
    MI.setDesc(MIB.get(VE::STrii));
    MI.getOperand(3).setReg(SrcHiReg);
    Offset += 8;
    MIB.replaceFI(MI, FrameReg, Offset, FIOperandNum);
    return;
  }
  if (MI.getOpcode() == VE::LDQrii) {
    Register DestReg = MI.getOperand(0).getReg();
    Register DestHiReg = MIB.getSubReg(DestReg, VE::sub_even);
    Register DestLoReg = MIB.getSubReg(DestReg, VE::sub_odd);
    // VE loads HiReg from 8(addr) and LoReg from 0(addr)
    MachineInstr *StMI =
        MIB.build(VE::LDrii, DestLoReg).addReg(FrameReg).addImm(0).addImm(0);
    MIB.replaceFI(*StMI, FrameReg, Offset, 1);
    MI.setDesc(MIB.get(VE::LDrii));
    MI.getOperand(0).setReg(DestHiReg);
    Offset += 8;
    MIB.replaceFI(MI, FrameReg, Offset, FIOperandNum);
    return;
  }
  abort();
}

void VERegisterInfo::eliminateFrameIndex_VM(MachineInstr &MI, MIBuilder &MIB,
                                            Register FrameReg, int Offset,
                                            int FIOperandNum) const {
  LLVM_DEBUG(dbgs() << "eliminateFI_VM: "; MI.dump());

  if (MI.getOpcode() == VE::STVMrii) {
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
    Register SrcReg = MI.getOperand(3).getReg();
    bool isKill = MI.getOperand(3).isKill();
    // FIXME: it would be better to scavenge a register here instead of
    // reserving SX16 all of the time.
    Register TmpReg = VE::SX16;
    for (int i = 0; i < 3; ++i) {
      MIB.build(VE::SVMmr, TmpReg).addReg(SrcReg).addImm(i);
      MachineInstr *StMI =
          MIB.build(VE::STrii).addReg(FrameReg).addImm(0).addImm(0).addReg(
              TmpReg, getKillRegState(true));
      MIB.replaceFI(*StMI, FrameReg, Offset, 0);
      Offset += 8;
    }
    MIB.build(VE::SVMmr, TmpReg)
        .addReg(SrcReg, getKillRegState(isKill))
        .addImm(3);
    MI.setDesc(MIB.get(VE::STrii));
    MI.getOperand(3).ChangeToRegister(TmpReg, false, false, true);
    MIB.replaceFI(MI, FrameReg, Offset, FIOperandNum);
    return;
  }
  if (MI.getOpcode() == VE::LDVMrii) {
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

    Register DestReg = MI.getOperand(0).getReg();
    // FIXME: it would be better to scavenge a register here instead of
    // reserving SX16 all of the time.
    unsigned TmpReg = VE::SX16;
    for (int i = 0; i < 4; ++i) {
      if (i != 3) {
        MachineInstr *StMI =
            MIB.build(VE::LDrii, TmpReg).addReg(FrameReg).addImm(0).addImm(0);
        MIB.replaceFI(*StMI, FrameReg, Offset, 1);
        Offset += 8;
      } else {
        // Last LDrii replace the target instruction.
        MI.setDesc(MIB.get(VE::LDrii));
        MI.getOperand(0).ChangeToRegister(TmpReg, true);
      }
      // First LVM is LVMir.  Others are LVMir_m.  Last LVM places at the
      // next of the target instruction.
      if (i == 0)
        MIB.build(VE::LVMir, DestReg)
            .addImm(i)
            .addReg(TmpReg, getKillRegState(true));
      else if (i != 3)
        MIB.build(VE::LVMir_m, DestReg)
            .addImm(i)
            .addReg(TmpReg, getKillRegState(true))
            .addReg(DestReg);
      else
        BuildMI(*MI.getParent(), std::next(MIB.II), MIB.DL,
                MIB.get(VE::LVMir_m), DestReg)
            .addImm(3)
            .addReg(TmpReg, getKillRegState(true))
            .addReg(DestReg);
    }
    MIB.replaceFI(MI, FrameReg, Offset, FIOperandNum);
    return;
  }
  abort();
}

void VERegisterInfo::eliminateFrameIndex_VM512(MachineInstr &MI, MIBuilder &MIB,
                                               Register FrameReg, int Offset,
                                               int FIOperandNum) const {
  LLVM_DEBUG(dbgs() << "eliminateFI_VM512: "; MI.dump());
  if (MI.getOpcode() == VE::STVM512rii) {
    Register SrcReg = MI.getOperand(3).getReg();
    Register SrcLoReg = MIB.getSubReg(SrcReg, VE::sub_vm_odd);
    Register SrcHiReg = MIB.getSubReg(SrcReg, VE::sub_vm_even);
    bool isKill = MI.getOperand(3).isKill();
    // FIXME: it would be better to scavenge a register here instead of
    // reserving SX16 all of the time.
    Register TmpReg = VE::SX16;
    // store low part of VMP
    MachineInstr *LastMI = nullptr;
    for (int i = 0; i < 4; ++i) {
      LastMI = MIB.build(VE::SVMmr, TmpReg).addReg(SrcLoReg).addImm(i);
      MachineInstr *StMI =
          MIB.build(VE::STrii).addReg(FrameReg).addImm(0).addImm(0).addReg(
              TmpReg, getKillRegState(true));
      MIB.replaceFI(*StMI, FrameReg, Offset, 0);
      Offset += 8;
    }
    if (isKill)
      LastMI->addRegisterKilled(SrcLoReg, this, true);
    // store high part of VMP
    for (int i = 0; i < 3; ++i) {
      MIB.build(VE::SVMmr, TmpReg).addReg(SrcHiReg).addImm(i);
      MachineInstr *StMI =
          MIB.build(VE::STrii).addReg(FrameReg).addImm(0).addImm(0).addReg(
              TmpReg, getKillRegState(true));
      MIB.replaceFI(*StMI, FrameReg, Offset, 0);
      Offset += 8;
    }
    LastMI = MIB.build(VE::SVMmr, TmpReg).addReg(SrcHiReg).addImm(3);
    if (isKill) {
      LastMI->addRegisterKilled(SrcHiReg, this, true);
      // Add implicit super-register kills to the particular MI.
      LastMI->addRegisterKilled(SrcReg, this, true);
    }
    MI.setDesc(MIB.get(VE::STrii));
    MI.getOperand(3).ChangeToRegister(TmpReg, false, false, true);
    MIB.replaceFI(MI, FrameReg, Offset, FIOperandNum);
    return;
  }
  if (MI.getOpcode() == VE::LDVM512rii) {
    Register DestReg = MI.getOperand(0).getReg();
    Register DestLoReg = getSubReg(DestReg, VE::sub_vm_odd);
    Register DestHiReg = getSubReg(DestReg, VE::sub_vm_even);
    // FIXME: it would be better to scavenge a register here instead of
    // reserving SX16 all of the time.
    Register TmpReg = VE::SX16;
    MIB.build(VE::IMPLICIT_DEF, DestReg);
    for (int i = 0; i < 4; ++i) {
      MachineInstr *LdMI =
          MIB.build(VE::LDrii, TmpReg).addReg(FrameReg).addImm(0).addImm(0);
      MIB.replaceFI(*LdMI, FrameReg, Offset, 1);
      MIB.build(VE::LVMir_m, DestLoReg)
          .addImm(i)
          .addReg(TmpReg, getKillRegState(true))
          .addReg(DestLoReg);
      Offset += 8;
    }
    for (int i = 0; i < 3; ++i) {
      MachineInstr *LdMI =
          MIB.build(VE::LDrii, TmpReg).addReg(FrameReg).addImm(0).addImm(0);
      MIB.replaceFI(*LdMI, FrameReg, Offset, 1);
      MIB.build(VE::LVMir_m, DestHiReg)
          .addImm(i)
          .addReg(TmpReg, getKillRegState(true))
          .addReg(DestHiReg);
      Offset += 8;
    }
    MI.setDesc(MIB.get(VE::LDrii));
    MI.getOperand(0).ChangeToRegister(TmpReg, true);
    BuildMI(*MI.getParent(), std::next(MIB.II), MIB.DL, MIB.get(VE::LVMir_m),
            DestHiReg)
        .addImm(3)
        .addReg(TmpReg, getKillRegState(true))
        .addReg(DestHiReg);
    MIB.replaceFI(MI, FrameReg, Offset, FIOperandNum);
    return;
  }
  abort();
}

void VERegisterInfo::eliminateFrameIndex_V64(MachineInstr &MI, MIBuilder &MIB,
                                             Register FrameReg, int Offset,
                                             int FIOperandNum) const {
  LLVM_DEBUG(dbgs() << "eliminateFI_V64: "; MI.dump());
  assert(MI.getOpcode() == VE::LDVRrii || MI.getOpcode() == VE::STVRrii);

  // Replace frame index with a temporal register if the instruction is
  // vector load/store.

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
  const int opc = MI.getOpcode() == VE::LDVRrii ? VE::VLDirl : VE::VSTirvl;
  const int StrideIdx = MI.getOpcode() == VE::LDVRrii ? 1 : 0;
  const int PtrRegIdx = MI.getOpcode() == VE::LDVRrii ? 2 : 1;
  const int NewDataRegIdx = MI.getOpcode() == VE::LDVRrii ? 0 : 2;
  const int OldDataRegIdx = MI.getOpcode() == VE::LDVRrii ? 0 : 3;
  const int AVLRegIdx = 3;
  unsigned DataReg = MI.getOperand(OldDataRegIdx).getReg();
  bool isDef = MI.getOperand(OldDataRegIdx).isDef();
  bool isKill = MI.getOperand(OldDataRegIdx).isKill();

  // Prepare for VL
  auto LVL = MIB.emitLVL(MI.getOperand(4));

  // replaceFI
  unsigned Tmp1 = MIB.createVirtualRegister(VE::I64RegClass);
  MIB.build(VE::LEArii, Tmp1).addReg(FrameReg).addImm(0).addImm(Offset);

  // Mutate to VLD / VST with byte offset.
  MI.setDesc(MIB.get(opc));
  MI.getOperand(NewDataRegIdx).ChangeToRegister(DataReg, isDef, false, isKill);
  MI.getOperand(StrideIdx).ChangeToImmediate(8);
  MI.getOperand(PtrRegIdx).ChangeToRegister(Tmp1, false, false, true);
  MI.getOperand(AVLRegIdx).ChangeToRegister(LVL.VLReg, false, false, true);
  MI.removeOperand(4); // TODO: Discarding trailing memory operands????

  if (LVL.IsKillSuper)
    MI.addRegisterKilled(LVL.SuperReg, this, true);
}

void VERegisterInfo::eliminateFrameIndex_VP(MachineInstr &MI, MIBuilder &MIB,
                                            Register FrameReg, int Offset,
                                            int FIOperandNum) const {
  LLVM_DEBUG(dbgs() << "eliminateFI_VP: "; MI.dump());
  assert(MI.getOpcode() == VE::LDVPrii || MI.getOpcode() == VE::STVPrii);
  // Original MI is:
  //   STVPrii frame-index, 0, offset, reg, vl (, memory operand)
  // or
  //   LDVPrii reg, frame-index, 0, offset, vl (, memory operand)
  // Convert it to:
  //   LEA tmp-reg, frame-reg, 0, offset
  //   VSTirvl 16, tmp-reg, vp.sub_pack_hi, vl
  //   LEA tmp-reg, tmp-reg, 0, 8
  //   VSTirvl 16, tmp-reg, vp.sub_pack_lo, vl
  // or
  //   LEA tmp-reg, frame-reg, 0, offset
  //   VLDirl vr.sub_pack_hi, 16, tmp-reg, vl
  //   LEA tmp-reg, tmp-reg, 0, 8
  //   VLDirl vr.sub_pack_lo, 16, tmp-reg, vl
  const bool IsLoad = MI.getOpcode() == VE::LDVPrii;
  const int Opc = IsLoad ? VE::VLDirl : VE::VSTirvl;
  const int StrideIdx = IsLoad ? 1 : 0;
  const int PtrRegIdx = IsLoad ? 2 : 1;
  const int NewDataRegIdx = IsLoad ? 0 : 2;
  const int OldDataRegIdx = IsLoad ? 0 : 3;
  const int AVLRegIdx = 3;
  Register DataReg = MI.getOperand(OldDataRegIdx).getReg();
  bool isDef = MI.getOperand(OldDataRegIdx).isDef();
  bool isKill = MI.getOperand(OldDataRegIdx).isKill();

  Register DataRegLo = MIB.getSubReg(DataReg, VE::sub_pack_lo);
  Register DataRegHi = MIB.getSubReg(DataReg, VE::sub_pack_hi);

  // Prepare for VL
  auto LVL = MIB.emitLVL(MI.getOperand(4));

  Register PtrReg = MIB.createVirtualRegister(VE::I64RegClass);
  MIB.build(VE::LEArii, PtrReg).addReg(FrameReg).addImm(0).addImm(Offset);

  // Insert VLD / VST [hi]
  if (IsLoad) {
    MIB.build(Opc, DataRegHi)
        .addImm(16) // idx
        .addReg(PtrReg)
        .addReg(LVL.VLReg);
  } else {
    MIB.build(Opc)
        .addImm(16)
        .addReg(PtrReg)
        .addReg(DataRegHi)
        .addReg(LVL.VLReg);
  }

  // Offset by 8 byte for [lo]
  MIB.build(VE::LEArii, PtrReg).addReg(PtrReg).addImm(0).addImm(8);

  // Mutate to VLD / VST [lo]
  MI.setDesc(MIB.get(Opc));
  MI.getOperand(NewDataRegIdx).ChangeToRegister(DataRegLo, isDef, false, isKill);
  MI.getOperand(StrideIdx).ChangeToImmediate(16);
  MI.getOperand(PtrRegIdx).ChangeToRegister(PtrReg, false, false, true);
  MI.getOperand(AVLRegIdx).ChangeToRegister(LVL.VLReg, false, false, true);
  MI.removeOperand(4);

  if (LVL.IsKillSuper)
    MI.addRegisterKilled(LVL.SuperReg, &MIB.TRI, true);
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

  // Retrieve FrameReg and byte offset for stack slot.
  Register FrameReg;
  int64_t Offset =
      TFI->getFrameIndexReference(MF, FrameIndex, FrameReg).getFixed();
  Offset += MI.getOperand(FIOperandNum + offsetToDisp(MI)).getImm();

  const TargetInstrInfo &TII = *Subtarget.getInstrInfo();
  const VERegisterInfo &TRI = *Subtarget.getRegisterInfo();
  MIBuilder MIB(TII, TRI, dl, *MI.getParent(), II);

  switch (MI.getOpcode()) {
  default:
    MIB.replaceFI(MI, FrameReg, Offset, FIOperandNum);
    return;
  case VE::LDQrii:
  case VE::STQrii:
    eliminateFrameIndex_Q(MI, MIB, FrameReg, Offset, FIOperandNum);
    return;
  case VE::STVMrii:
  case VE::LDVMrii:
    eliminateFrameIndex_VM(MI, MIB, FrameReg, Offset, FIOperandNum);
    return;
  case VE::STVM512rii:
  case VE::LDVM512rii:
    eliminateFrameIndex_VM512(MI, MIB, FrameReg, Offset, FIOperandNum);
    return;
  case VE::STVRrii:
  case VE::LDVRrii:
    eliminateFrameIndex_V64(MI, MIB, FrameReg, Offset, FIOperandNum);
    return;
  case VE::STVPrii:
  case VE::LDVPrii:
    eliminateFrameIndex_VP(MI, MIB, FrameReg, Offset, FIOperandNum);
  }
}

unsigned VERegisterInfo::getRegPressureSetLimit(const MachineFunction &MF,
                                                unsigned Idx) const {
  return VEGenRegisterInfo::getRegPressureSetLimit(MF, Idx);
}

Register VERegisterInfo::getFrameRegister(const MachineFunction &MF) const {
  return VE::SX9;
}

static bool UseRoundRobinScheme(const TargetRegisterClass *RegClass) {
  return EnableRoundRobinAlloc && (RegClass == &VE::V64RegClass);
}

bool VERegisterInfo::getRegAllocationHints(Register VirtReg,
                                           ArrayRef<MCPhysReg> Order,
                                           SmallVectorImpl<MCPhysReg> &Hints,
                                           const MachineFunction &MF,
                                           const VirtRegMap *VRM,
                                           const LiveRegMatrix *Matrix) const {
  const MachineRegisterInfo &MRI = MF.getRegInfo();
  const auto *RegClass = MRI.getRegClass(VirtReg);

  // Default code path
  if (!UseRoundRobinScheme(RegClass)) {
    return TargetRegisterInfo::getRegAllocationHints(VirtReg, Order, Hints, MF,
                                                     VRM, Matrix);
  }

  // llvm::errs() << "=== VReg Allocation (vvreg " << printReg(VirtReg, this)
  // <<
  // ") ===\n";

  static const MachineFunction *LastMF = nullptr;
  static bool FirstVRAlloc = true;
  static unsigned LastVRIndex = 0; // last allocated vreg
  if (&MF != LastMF) {
    LastMF = &MF;
    // llvm::errs() << "\t first allocation\n";
    FirstVRAlloc = true;
    LastVRIndex = 0;
  } else {
    FirstVRAlloc = false;
  }

  // FIXME this is the default implementation
  const std::pair<Register, SmallVector<Register, 4>> &Hints_MRI =
      MRI.getRegAllocationHints(VirtReg);

  SmallSet<Register, 32> HintedRegs;
  // Respect any target hint first.
  bool Skip = (Hints_MRI.first != 0);
  Register Phys;
  unsigned VRIndex = 0;
  for (auto Reg : Hints_MRI.second) {
    if (Skip) {
      Skip = false;
      continue;
    }

    // Target-independent hints are either a physical or a virtual register.
    Phys = Reg;
    if (VRM && Phys.isVirtual())
      Phys = VRM->getPhys(Phys);
    break;
  }

  // There was not hint -> make up a vreg
  if (!Phys.isValid()) {
    if (!FirstVRAlloc) {
      VRIndex = LastVRIndex;
    } else {
      // FIXME round robin
      return false;
    }
  }

  // llvm::errs() << "\t Initial phys reg: " << printReg(Phys, this) << "\n";

  // FIXME This sometimes causes superfluous VORs though (register hinting is
  // stronger than vreg-move avoidance it seems) Trigger round robin hinting
  // if same or a lower/free'd register is reallocated otherwise
  if (!FirstVRAlloc && (VRIndex <= LastVRIndex)) {
    const unsigned NumRegs = RegClass->getNumRegs();

    for (unsigned Off = 1; Off < NumRegs; ++Off) {
      unsigned NextVRIdx = (LastVRIndex + Off) % NumRegs;
      Phys = VE::V64RegClass.getRegister(NextVRIdx);
      // Don't add the same reg twice (Hints_MRI may contain multiple virtual
      // registers allocated to the same physreg).
      if (!HintedRegs.insert(Phys).second)
        continue;
      // Check that Phys is a valid hint in VirtReg's register class.
      if (!Phys.isPhysical())
        continue;
      if (MRI.isReserved(Phys))
        continue;
      if (!is_contained(Order, Phys))
        continue;

      // We've found our round robin register
      // llvm::errs() << "\t RR re-mapped = " << printReg(Phys, this) << "\n";
      VRIndex = NextVRIdx;
      Phys = VE::V64RegClass.getRegister(VRIndex);
      break;
    }
  }

  // All clear, tell the register allocator to prefer this register.
  // llvm::errs() << "Hints[" << Hints.size() << "], vreg " << printReg(Phys,
  // this) << " for " << printReg(VirtReg, this) << "\n";
  if (!Phys.isValid())
    return false;
  Hints.push_back(Phys);

  // Track last allocated vreg
  LastVRIndex = VRIndex;
  FirstVRAlloc = false;
  return false;
}
