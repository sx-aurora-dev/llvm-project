//===-- VEFrameLowering.cpp - VE Frame Information ------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the VE implementation of TargetFrameLowering class.
//
//===----------------------------------------------------------------------===//

#include "VEFrameLowering.h"
#include "VEInstrInfo.h"
#include "VEMachineFunctionInfo.h"
#include "VESubtarget.h"
#include "llvm/CodeGen/MachineFrameInfo.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineModuleInfo.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Target/TargetOptions.h"

using namespace llvm;

static cl::opt<bool>
DisableLeafProc("disable-ve-leaf-proc",
                cl::init(false),
                cl::desc("Disable VE leaf procedure optimization."),
                cl::Hidden);

VEFrameLowering::VEFrameLowering(const VESubtarget &ST)
    : TargetFrameLowering(TargetFrameLowering::StackGrowsDown,
                          16, 0, 16) {}

void VEFrameLowering::emitPrologueInsns(
    MachineFunction &MF, MachineBasicBlock &MBB,
    MachineBasicBlock::iterator MBBI,
    int NumBytes, bool RequireFPUpdate) const {

  DebugLoc dl;
  const VEInstrInfo &TII =
      *static_cast<const VEInstrInfo *>(MF.getSubtarget().getInstrInfo());
  // Insert following codes here as prologue
  //
  //    st %lr, 8(,%sp)

  BuildMI(MBB, MBBI, dl, TII.get(VE::STSri))
    .addReg(VE::S11).addImm(8).addReg(VE::S10);
}

void VEFrameLowering::emitEpilogueInsns(
    MachineFunction &MF, MachineBasicBlock &MBB,
    MachineBasicBlock::iterator MBBI,
    int NumBytes, bool RequireFPUpdate) const {

  DebugLoc dl;
  const VEInstrInfo &TII =
      *static_cast<const VEInstrInfo *>(MF.getSubtarget().getInstrInfo());
  // Insert following codes here as epilogue
  //
  //    ld %lr, 8(,%sp)

  BuildMI(MBB, MBBI, dl, TII.get(VE::LDSri), VE::S10)
    .addReg(VE::S11).addImm(8);
}

void VEFrameLowering::emitSPAdjustment(MachineFunction &MF,
                                          MachineBasicBlock &MBB,
                                          MachineBasicBlock::iterator MBBI,
                                          int NumBytes) const {
  DebugLoc dl;
  const VEInstrInfo &TII =
      *static_cast<const VEInstrInfo *>(MF.getSubtarget().getInstrInfo());

  if (NumBytes >= -64 && NumBytes < 63) {
    BuildMI(MBB, MBBI, dl, TII.get(VE::ADXri), VE::S11)
      .addReg(VE::S11).addImm(NumBytes);
    return;
  }

  // Emit following codes.  This clobbers S13 which we always know is
  // available here.
  //   lea     %s13,%lo(NumBytes)
  //   and     %s13,%s13,(32)0
  //   lea.sl  %sp,%hi(NumBytes)(%sp, %s13)
  BuildMI(MBB, MBBI, dl, TII.get(VE::LEAzzi), VE::S13)
    .addImm(LO32(NumBytes));
  BuildMI(MBB, MBBI, dl, TII.get(VE::ANDrm0), VE::S13)
    .addReg(VE::S13).addImm(32);
  BuildMI(MBB, MBBI, dl, TII.get(VE::LEASLrri), VE::S11)
    .addReg(VE::S11).addReg(VE::S13).addImm(HI32(NumBytes));
}

void VEFrameLowering::emitPrologue(MachineFunction &MF,
                                      MachineBasicBlock &MBB) const {
#if 0
  VEMachineFunctionInfo *FuncInfo = MF.getInfo<VEMachineFunctionInfo>();
#endif

  assert(&MF.front() == &MBB && "Shrink-wrapping not yet supported");
  MachineFrameInfo &MFI = MF.getFrameInfo();
  const VESubtarget &Subtarget = MF.getSubtarget<VESubtarget>();
  const VEInstrInfo &TII =
      *static_cast<const VEInstrInfo *>(Subtarget.getInstrInfo());
  const VERegisterInfo &RegInfo =
      *static_cast<const VERegisterInfo *>(Subtarget.getRegisterInfo());
  MachineBasicBlock::iterator MBBI = MBB.begin();
  // Debug location must be unknown since the first debug location is used
  // to determine the end of the prologue.
  DebugLoc dl;
  bool NeedsStackRealignment = RegInfo.needsStackRealignment(MF);

  // FIXME: unfortunately, returning false from canRealignStack
  // actually just causes needsStackRealignment to return false,
  // rather than reporting an error, as would be sensible. This is
  // poor, but fixing that bogosity is going to be a large project.
  // For now, just see if it's lied, and report an error here.
  if (!NeedsStackRealignment && MFI.getMaxAlignment() > getStackAlignment())
    report_fatal_error("Function \"" + Twine(MF.getName()) + "\" required "
                       "stack re-alignment, but LLVM couldn't handle it "
                       "(probably because it has a dynamic alloca).");

  // Get the number of bytes to allocate from the FrameInfo
  int NumBytes = (int) MFI.getStackSize();
#if 0
  if (FuncInfo->isLeafProc()) {
    if (NumBytes == 0)
      return;
  }
#endif
  // The SPARC ABI is a bit odd in that it requires a reserved 92-byte
  // (128 in v9) area in the user's stack, starting at %sp. Thus, the
  // first part of the stack that can actually be used is located at
  // %sp + 92.
  //
  // We therefore need to add that offset to the total stack size
  // after all the stack objects are placed by
  // PrologEpilogInserter calculateFrameObjectOffsets. However, since the stack needs to be
  // aligned *after* the extra size is added, we need to disable
  // calculateFrameObjectOffsets's built-in stack alignment, by having
  // targetHandlesStackFrameRounding return true.


  // Add the extra call frame stack size, if needed. (This is the same
  // code as in PrologEpilogInserter, but also gets disabled by
  // targetHandlesStackFrameRounding)
  if (MFI.adjustsStack() && hasReservedCallFrame(MF))
    NumBytes += MFI.getMaxCallFrameSize();

  // Adds the SPARC subtarget-specific spill area to the stack
  // size. Also ensures target-required alignment.
  NumBytes = Subtarget.getAdjustedFrameSize(NumBytes);

  // Finally, ensure that the size is sufficiently aligned for the
  // data on the stack.
  if (MFI.getMaxAlignment() > 0) {
    NumBytes = alignTo(NumBytes, MFI.getMaxAlignment());
  }

  // Update stack size with corrected value.
  MFI.setStackSize(NumBytes);

  // emit Prologue instructions to save %lr
  emitPrologueInsns(MF, MBB, MBBI, NumBytes, true);

  // emit stack adjust instructions
  emitSPAdjustment(MF, MBB, MBBI, -NumBytes);

  unsigned regFP = RegInfo.getDwarfRegNum(VE::S9, true);

  // Emit ".cfi_def_cfa_register 30".
  unsigned CFIIndex =
      MF.addFrameInst(MCCFIInstruction::createDefCfaRegister(nullptr, regFP));
  BuildMI(MBB, MBBI, dl, TII.get(TargetOpcode::CFI_INSTRUCTION))
      .addCFIIndex(CFIIndex);

  // Emit ".cfi_window_save".
  CFIIndex = MF.addFrameInst(MCCFIInstruction::createWindowSave(nullptr));
  BuildMI(MBB, MBBI, dl, TII.get(TargetOpcode::CFI_INSTRUCTION))
      .addCFIIndex(CFIIndex);

#if 0
  unsigned regInRA = RegInfo.getDwarfRegNum(VE::I7, true);
  unsigned regOutRA = RegInfo.getDwarfRegNum(VE::O7, true);
  // Emit ".cfi_register 15, 31".
  CFIIndex = MF.addFrameInst(
      MCCFIInstruction::createRegister(nullptr, regOutRA, regInRA));
  BuildMI(MBB, MBBI, dl, TII.get(TargetOpcode::CFI_INSTRUCTION))
      .addCFIIndex(CFIIndex);
#endif

  if (NeedsStackRealignment) {
#if 0
    unsigned regUnbiased;
    regUnbiased = VE::S11; // %sp

    // andn %regUnbiased, MaxAlign-1, %regUnbiased
    int MaxAlign = MFI.getMaxAlignment();
    BuildMI(MBB, MBBI, dl, TII.get(VE::ANDNri), regUnbiased)
      .addReg(regUnbiased).addImm(MaxAlign - 1);

    if (Bias) {
      // add %g1, -BIAS, %o6
      BuildMI(MBB, MBBI, dl, TII.get(VE::ADXri), VE::S11)
        .addReg(regUnbiased).addImm(-Bias);
    }
#endif
  }
}

MachineBasicBlock::iterator VEFrameLowering::
eliminateCallFramePseudoInstr(MachineFunction &MF, MachineBasicBlock &MBB,
                              MachineBasicBlock::iterator I) const {
  if (!hasReservedCallFrame(MF)) {
    MachineInstr &MI = *I;
    int Size = MI.getOperand(0).getImm();
    if (MI.getOpcode() == VE::ADJCALLSTACKDOWN)
      Size = -Size;

    if (Size)
      emitSPAdjustment(MF, MBB, I, Size);
  }
  return MBB.erase(I);
}


void VEFrameLowering::emitEpilogue(MachineFunction &MF,
                                  MachineBasicBlock &MBB) const {
  MachineBasicBlock::iterator MBBI = MBB.getLastNonDebugInstr();
#if 0
  VEMachineFunctionInfo *FuncInfo = MF.getInfo<VEMachineFunctionInfo>();
  const VEInstrInfo &TII =
      *static_cast<const VEInstrInfo *>(MF.getSubtarget().getInstrInfo());
#endif
  DebugLoc dl = MBBI->getDebugLoc();
#if 0
  assert(MBBI->getOpcode() == SP::RETL &&
         "Can only put epilog before 'retl' instruction!");
  if (!FuncInfo->isLeafProc()) {
    BuildMI(MBB, MBBI, dl, TII.get(SP::RESTORErr), SP::G0).addReg(SP::G0)
      .addReg(SP::G0);
    return;
  }
#endif
  MachineFrameInfo &MFI = MF.getFrameInfo();

  int NumBytes = (int) MFI.getStackSize();
  if (NumBytes == 0)
    return;

  // emit stack adjust instructions
  emitSPAdjustment(MF, MBB, MBBI, NumBytes);

  // emit Epilogue instructions to restore %lr
  emitEpilogueInsns(MF, MBB, MBBI, NumBytes, true);
}

bool VEFrameLowering::hasReservedCallFrame(const MachineFunction &MF) const {
  // Reserve call frame if there are no variable sized objects on the stack.
  return !MF.getFrameInfo().hasVarSizedObjects();
}

// hasFP - Return true if the specified function should have a dedicated frame
// pointer register.  This is true if the function has variable sized allocas or
// if frame pointer elimination is disabled.
bool VEFrameLowering::hasFP(const MachineFunction &MF) const {
  const TargetRegisterInfo *RegInfo = MF.getSubtarget().getRegisterInfo();

  const MachineFrameInfo &MFI = MF.getFrameInfo();
  return MF.getTarget().Options.DisableFramePointerElim(MF) ||
      RegInfo->needsStackRealignment(MF) ||
      MFI.hasVarSizedObjects() ||
      MFI.isFrameAddressTaken();
}


int VEFrameLowering::getFrameIndexReference(const MachineFunction &MF, int FI,
                                               unsigned &FrameReg) const {
  const VESubtarget &Subtarget = MF.getSubtarget<VESubtarget>();
  const MachineFrameInfo &MFI = MF.getFrameInfo();
  const VERegisterInfo *RegInfo = Subtarget.getRegisterInfo();
  const VEMachineFunctionInfo *FuncInfo = MF.getInfo<VEMachineFunctionInfo>();
  bool isFixed = MFI.isFixedObjectIndex(FI);

  // Addressable stack objects are accessed using neg. offsets from
  // %fp, or positive offsets from %sp.
  bool UseFP;

  // VE uses FP-based references in general, even when "hasFP" is
  // false. That function is rather a misnomer, because %fp is
  // actually always available, unless isLeafProc.
  if (FuncInfo->isLeafProc()) {
    // If there's a leaf proc, all offsets need to be %sp-based,
    // because we haven't caused %fp to actually point to our frame.
    UseFP = false;
  } else if (isFixed) {
    // Otherwise, argument access should always use %fp.
    UseFP = true;
  } else if (RegInfo->needsStackRealignment(MF)) {
    // If there is dynamic stack realignment, all local object
    // references need to be via %sp, to take account of the
    // re-alignment.
    UseFP = false;
  } else {
    // Finally, default to using %fp.
    UseFP = true;
  }

  int64_t FrameOffset = MF.getFrameInfo().getObjectOffset(FI);

  if (UseFP) {
    FrameReg = RegInfo->getFrameRegister(MF);
    return FrameOffset;
  } else {
    FrameReg = VE::S11; // %sp
    return FrameOffset + MF.getFrameInfo().getStackSize();
  }
}

static bool LLVM_ATTRIBUTE_UNUSED verifyLeafProcRegUse(MachineRegisterInfo *MRI)
{

  // If any of parameter registers are used, this is not leaf function.
  for (unsigned reg = VE::S0; reg <= VE::S7; ++reg)
    if (MRI->isPhysRegUsed(reg))
      return false;

  // If any of callee-saved registers are used, this is not leaf function.
  for (unsigned reg = VE::S18; reg <= VE::S33; ++reg)
    if (MRI->isPhysRegUsed(reg))
      return false;

  return true;
}

bool VEFrameLowering::isLeafProc(MachineFunction &MF) const
{

  MachineRegisterInfo &MRI = MF.getRegInfo();
  MachineFrameInfo    &MFI = MF.getFrameInfo();

  return !(MFI.hasCalls()                  // has calls
           || MRI.isPhysRegUsed(VE::S18)   // Too many registers needed
                                           //   (s18 is first CSR)
           || MRI.isPhysRegUsed(VE::S11)   // %sp is used
           || hasFP(MF));                  // need %fp
}

void VEFrameLowering::determineCalleeSaves(MachineFunction &MF,
                                              BitVector &SavedRegs,
                                              RegScavenger *RS) const {
  TargetFrameLowering::determineCalleeSaves(MF, SavedRegs, RS);
  if (!DisableLeafProc && isLeafProc(MF)) {
    VEMachineFunctionInfo *MFI = MF.getInfo<VEMachineFunctionInfo>();
    MFI->setLeafProc(true);
  }
}
