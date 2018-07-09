//===-- VEFrameLowering.h - Define frame lowering for VE --*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
//
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_VE_VEFRAMELOWERING_H
#define LLVM_LIB_TARGET_VE_VEFRAMELOWERING_H

#include "VE.h"
#include "llvm/CodeGen/TargetFrameLowering.h"

namespace llvm {

class VESubtarget;
class VEFrameLowering : public TargetFrameLowering {
public:
  explicit VEFrameLowering(const VESubtarget &ST);

  /// emitProlog/emitEpilog - These methods insert prolog and epilog code into
  /// the function.
  void emitPrologue(MachineFunction &MF, MachineBasicBlock &MBB) const override;
  void emitEpilogue(MachineFunction &MF, MachineBasicBlock &MBB) const override;
  void emitPrologueInsns(MachineFunction &MF, MachineBasicBlock &MBB,
                         MachineBasicBlock::iterator MBBI,
                         int NumBytes, bool RequireFPUpdate) const;
  void emitEpilogueInsns(MachineFunction &MF, MachineBasicBlock &MBB,
                         MachineBasicBlock::iterator MBBI,
                         int NumBytes, bool RequireFPUpdate) const;

  MachineBasicBlock::iterator
  eliminateCallFramePseudoInstr(MachineFunction &MF,
                                MachineBasicBlock &MBB,
                                MachineBasicBlock::iterator I) const override;

  bool hasReservedCallFrame(const MachineFunction &MF) const override;
  bool hasFP(const MachineFunction &MF) const override;
  void determineCalleeSaves(MachineFunction &MF, BitVector &SavedRegs,
                            RegScavenger *RS = nullptr) const override;

  int getFrameIndexReference(const MachineFunction &MF, int FI,
                             unsigned &FrameReg) const override;

  const SpillSlot *getCalleeSavedSpillSlots(unsigned &NumEntries)
      const override {
    static const SpillSlot Offsets[] = {
      { VE::SX17,  40 }, { VE::SX18,  48 }, { VE::SX19,  56 },
      { VE::SX20,  64 }, { VE::SX21,  72 }, { VE::SX22,  80 },
      { VE::SX23,  88 }, { VE::SX24,  96 }, { VE::SX25, 104 },
      { VE::SX26, 112 }, { VE::SX27, 120 }, { VE::SX28, 128 },
      { VE::SX29, 136 }, { VE::SX30, 144 }, { VE::SX31, 152 },
      { VE::SX32, 160 }, { VE::SX33, 168 }
    };
    NumEntries = array_lengthof(Offsets);
    return Offsets;
  }

  /// targetHandlesStackFrameRounding - Returns true if the target is
  /// responsible for rounding up the stack frame (probably at emitPrologue
  /// time).
  bool targetHandlesStackFrameRounding() const override { return true; }

private:
  // Returns true if MF is a leaf procedure.
  bool isLeafProc(MachineFunction &MF) const;


  // Emits code for adjusting SP in function prologue/epilogue.
  void emitSPAdjustment(MachineFunction &MF,
                        MachineBasicBlock &MBB,
                        MachineBasicBlock::iterator MBBI,
                        int NumBytes) const;

  // Emits code for extending SP in function prologue/epilogue.
  void emitSPExtend(MachineFunction &MF,
                    MachineBasicBlock &MBB,
                    MachineBasicBlock::iterator MBBI,
                    int NumBytes) const;

};

} // End llvm namespace

#endif
