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
  struct LVLGen : public MachineFunctionPass {
    const MachineRegisterInfo *MRI;
    static char ID;
    LVLGen() : MachineFunctionPass(ID) {}
    bool runOnMachineBasicBlock(MachineBasicBlock &MBB);
    bool runOnMachineFunction(MachineFunction &F) override;
  };
  char LVLGen::ID = 0;

  // returns a register holding a vector length. NoRegister is returned when
  // this MI does not have a vector length.
  //
  // FIXME: is this reasonable impl?
  unsigned getVL(const MachineRegisterInfo *MRI, const MachineInstr &MI)
  {
    unsigned opc = MI.getOpcode();
    if (opc < VE::andm_MMMl 
            || (opc > VE::xorm_MMMl && opc < VE::andm_mmml)
            || opc > VE::xorm_mmml)
      return VE::NoRegister;

    for (const MachineOperand &MO : MI.operands()) {
      //if (MO.isReg() && MRI->getRegClass(MO.getReg()) == &VE::V64RegClass)
      if (MO.isReg() && VE::V64RegClass.contains(MO.getReg())) {
        // last operand should be a vector length
        return MI.getOperand(MI.getNumOperands() - 1).getReg();
      }
    }
    return VE::NoRegister;
  }

} // end of anonymous namespace

FunctionPass *llvm::createLVLGenPass() {
  return new LVLGen;
}

bool LVLGen::runOnMachineBasicBlock(MachineBasicBlock &MBB)
{
  bool Changed = false;
  const VESubtarget *Subtarget = &MBB.getParent()->getSubtarget<VESubtarget>();
  const TargetInstrInfo *TII = Subtarget->getInstrInfo();
  const TargetRegisterInfo* TRI = Subtarget->getRegisterInfo();

  bool hasRegForVL = false;
  unsigned RegForVL;

  for (MachineBasicBlock::iterator I = MBB.begin(); I != MBB.end(); ) {
    MachineBasicBlock::iterator MI = I;

    unsigned Reg = getVL(MRI, *MI);
    if (Reg != VE::NoRegister) {
      LLVM_DEBUG(dbgs() << "Vector instruction found: ");
      LLVM_DEBUG(MI->dump());
      LLVM_DEBUG(dbgs() << "Vector length is " << TRI->getName(Reg) << ". ");
      LLVM_DEBUG(dbgs() << "Current VL is " 
                 << (hasRegForVL ? TRI->getName(RegForVL) : "unknown") << ". ");

      if (!hasRegForVL || RegForVL != Reg) {
        LLVM_DEBUG(dbgs() << "Generate a LVL instruction to load " << TRI->getName(Reg) << ".\n");
        BuildMI(MBB, I, MI->getDebugLoc(), TII->get(VE::LVL2)).addReg(Reg);
        hasRegForVL = true;
        RegForVL = Reg;
        Changed = true;
      } else {
        LLVM_DEBUG(dbgs() << "Reuse current VL.\n");
      }
    } else if (hasRegForVL) {
      for (const MachineOperand &MO : MI->defs()) {
        if (MO.isReg() && MO.getReg() == RegForVL) {
          LLVM_DEBUG(dbgs() << TRI->getName(RegForVL) << " is killed: ");
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

  bool Changed = false;

  MRI = &F.getRegInfo();

  LLVM_DEBUG(F.dump());

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


