//===-- PromoteToI1.cpp - Promote to vector mask register -----------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This is a simple local pass that tries to promote vector registers to
// expected vector mask registers if and only if those vector registers
// defined as vector mask registers.  As you know, C/clang doesn't support
// i1 type natively, so vector mask registers are declared as v4i64 in C
// instead of v256i1.  This involves cast between v4i64 and v256i1.
// Unfortunately, SX-Aurora Tsubasa has penalties for such casts.
// This pass promotes all vector register which is used as vector mask
// registers into expacted vector mask registers to avoid cast penalties.
//
// Input:
//   v4i64 m = (v4i64)create_mask(...);
//   v256i64 v = vadd_mask(..., (v256i1)m);
//
// Output:
//   v256i1 m = create_mask(...);
//   v256i64 v = vadd_mask(..., m);
//===----------------------------------------------------------------------===//

#include "VE.h"
#include "VESubtarget.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/CodeGen/TargetInstrInfo.h"
#include "llvm/Target/TargetMachine.h"

using namespace llvm;

#define DEBUG_TYPE "lvl-gen"

namespace {
  struct LVLGen : public MachineFunctionPass {
    const MachineRegisterInfo *MRI;
    static char ID;
    LVLGen() : MachineFunctionPass(ID) {}
    bool runOnMachineBasicBlock(MachineBasicBlock &MBB);
    bool runOnMachineFunction(MachineFunction &F) override;
  };
  char LVLGen::ID = 0;

  bool useVL(const MachineRegisterInfo *MRI, const MachineInstr &MI)
  {
    for (const MachineOperand &MO : MI.operands()) {
      //if (MO.isReg() && MRI->getRegClass(MO.getReg()) == &VE::V64RegClass)
      if (MO.isReg() && VE::V64RegClass.contains(MO.getReg()))
        return true;
    }
    return false;
  }

} // end of anonymous namespace

FunctionPass *llvm::createLVLGenPass() {
  return new LVLGen;
}

bool LVLGen::runOnMachineBasicBlock(MachineBasicBlock &MBB)
{
  const VESubtarget *Subtarget = &MBB.getParent()->getSubtarget<VESubtarget>();
  const TargetInstrInfo *TII = Subtarget->getInstrInfo();

  bool hasRegForVL = false;
  unsigned RegForVL;

  for (MachineBasicBlock::iterator I = MBB.begin(); I != MBB.end(); ) {
    MachineBasicBlock::iterator MI = I;

    MI->dump();

    if (useVL(MRI, *MI)) {
      dbgs() << "LVLGen: Find instruction that uses the VL\n";

      // Last operand is a register for vector length
      unsigned Reg = MI->getOperand(MI->getNumOperands() - 1).getReg();

      if (!hasRegForVL || RegForVL != Reg) {
        dbgs() << "LVLGen: hasRegForVL=" << hasRegForVL
          << " RegForVL=" << RegForVL << " Reg" << Reg << "\n";
        BuildMI(MBB, I, MI->getDebugLoc(), TII->get(VE::LVL2)).addReg(Reg);
        hasRegForVL = true;
        RegForVL = Reg;
      }
    } else if (hasRegForVL) {
      for (const MachineOperand &MO : MI->defs()) {
        if (MO.isReg() && MO.getReg() == RegForVL) {
          hasRegForVL = false;
          break;
        }
      }
    }

    ++I;
  }
  return false;
}

bool LVLGen::runOnMachineFunction(MachineFunction &F) 
{
    dbgs() << "LVLGen::runOnMachineFunction" << "\n";
    bool Changed = false;

    MRI = &F.getRegInfo();

    LLVM_DEBUG(F.dump());

    for (MachineFunction::iterator FI = F.begin(), FE = F.end();
         FI != FE; ++FI)
        Changed |= runOnMachineBasicBlock(*FI);

    LLVM_DEBUG(F.dump());
    dbgs() << "LVLGen::runOnMachineFunction: done" << "\n";
    return Changed;
}


