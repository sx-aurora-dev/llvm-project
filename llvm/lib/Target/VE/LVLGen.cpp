//===-- LVLGen.cpp - LVL instruction generator ----------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
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
  int getVLIndex(unsigned op) {
    switch (op) {
#include "vl-index.inc"
    case VE::vor_v1vl: return 3;
    }
  }

  struct LVLGen : public MachineFunctionPass {
    MCInstrDesc LVLInstDesc;
    static char ID;
    LVLGen() : MachineFunctionPass(ID) {}
    bool runOnMachineBasicBlock(MachineBasicBlock &MBB);
    bool runOnMachineFunction(MachineFunction &F) override;
  };
  char LVLGen::ID = 0;

  // returns a register holding a vector length. NoRegister is returned when
  // this MI does not have a vector length.
  unsigned getVL(const MachineInstr &MI)
  {
    int index = getVLIndex(MI.getOpcode());
    if (index >= 0)
      return MI.getOperand(index).getReg();

    return VE::NoRegister;
  }

} // end of anonymous namespace

FunctionPass *llvm::createLVLGenPass() {
  return new LVLGen;
}

bool LVLGen::runOnMachineBasicBlock(MachineBasicBlock &MBB)
{
#define RegName(no) \
  (MBB.getParent()->getSubtarget<VESubtarget>().getRegisterInfo()->getName(no))

  bool Changed = false;
  bool hasRegForVL = false;
  unsigned RegForVL;

  for (MachineBasicBlock::iterator I = MBB.begin(); I != MBB.end(); ) {
    MachineBasicBlock::iterator MI = I;

    unsigned Reg = getVL(*MI);
    if (Reg != VE::NoRegister) {
      LLVM_DEBUG(dbgs() << "Vector instruction found: ");
      LLVM_DEBUG(MI->dump());
      LLVM_DEBUG(dbgs() << "Vector length is " << RegName(Reg) << ". ");
      LLVM_DEBUG(dbgs() << "Current VL is " 
                 << (hasRegForVL ? RegName(RegForVL) : "unknown") << ". ");

      if (!hasRegForVL || RegForVL != Reg) {
        LLVM_DEBUG(dbgs() << "Generate a LVL instruction to load "
                << RegName(Reg) << ".\n");
        BuildMI(MBB, I, MI->getDebugLoc(), LVLInstDesc).addReg(Reg);
        hasRegForVL = true;
        RegForVL = Reg;
        Changed = true;
      } else {
        LLVM_DEBUG(dbgs() << "Reuse current VL.\n");
      }
    } else if (hasRegForVL) {
      for (const MachineOperand &MO : MI->defs()) {
        if (MO.isReg() && MO.getReg() == RegForVL) {
          LLVM_DEBUG(dbgs() << RegName(RegForVL) << " is killed: ");
          LLVM_DEBUG(MI->dump());
          hasRegForVL = false;
          break;
        }
      }
    }

    ++I;
  }
  return Changed;
}

bool LVLGen::runOnMachineFunction(MachineFunction &F) 
{
  LLVM_DEBUG(dbgs() << "********** Begin LVLGen **********\n");
  LLVM_DEBUG(dbgs() << "********** Function: " << F.getName() << '\n');
  LLVM_DEBUG(F.dump());

  bool Changed = false;

  const VESubtarget& Subtarget = F.getSubtarget<VESubtarget>();
  const TargetInstrInfo *TII = Subtarget.getInstrInfo();
  LVLInstDesc = TII->get(VE::LVL);

  for (MachineFunction::iterator FI = F.begin(), FE = F.end();
       FI != FE; ++FI)
    Changed |= runOnMachineBasicBlock(*FI);

  if (Changed) {
    LLVM_DEBUG(dbgs() << "\n");
    LLVM_DEBUG(F.dump());
  }
  LLVM_DEBUG(dbgs() << "********** End LVLGen **********\n");
  return Changed;
}

