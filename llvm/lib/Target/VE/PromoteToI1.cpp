//===-- PromoteToI1.cpp - Promote to vector mask register -----------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
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
#include "llvm/ADT/SmallSet.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/CodeGen/TargetInstrInfo.h"
#include "llvm/CodeGen/TargetRegisterInfo.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Target/TargetMachine.h"

using namespace llvm;

#define DEBUG_TYPE "promote-to-i1"

static cl::opt<bool> DisablePromoteToI1(
  "disable-promote-to-i1",
  cl::init(false),
  cl::desc("Disable the VE vector mask register promoter."),
  cl::Hidden);

namespace {
  struct Promoter : public MachineFunctionPass {
    const VESubtarget *Subtarget;
    MachineRegisterInfo *MRI;
    const TargetRegisterInfo *TRI;

    struct Info {
      unsigned NewReg;
      unsigned GraphNo;
      bool Valid;
      const TargetRegisterClass *RegClass;
    };
    std::map<unsigned, Info> Candidates;
    std::vector<unsigned> GraphInfo;

    unsigned add_graph(unsigned reg)
    {
      unsigned graph = GraphInfo.size();
      GraphInfo.push_back(reg);
      return graph;
    }
    void remove_graph(unsigned graph)
    { GraphInfo[graph] = 0; }
    void merge_graph(unsigned oldg, unsigned newg)
    {
      remove_graph(oldg);
      for (auto &v : Candidates) {
        if (v.second.GraphNo == oldg)
          v.second.GraphNo = newg;
      }
    }

    void new_vec(unsigned reg, const TargetRegisterClass *rc)
    {
      unsigned graph = add_graph(reg);
      Candidates[reg] = { 0, graph, true, rc };
    }
    void new_vec(unsigned reg, unsigned graph, const TargetRegisterClass *rc)
    {
      Candidates[reg] = { 0, graph, true, rc };
    }
    bool exist_vec(unsigned reg)
    {
      return Candidates.find(reg) != Candidates.end();
    }
    bool valid_vec(unsigned reg)
    {
      return exist_vec(reg) && vec(reg).Valid;
    }
    Info& vec(unsigned reg)
    {
      return Candidates[reg];
    }

    void dump(void)
    {
      dbgs() << "Dump status of PromoteToV1\n";
      for (const auto &v64 : Candidates) {
        dbgs() << "vec " << printReg(v64.first, TRI) << " - V64, ("
          << printReg(v64.second.NewReg) << ", "
          << v64.second.GraphNo << ", "
          << v64.second.Valid << ", "
          << printRegClass(v64.second.RegClass) << ")\n";
      }
    }

    static char ID;
    Promoter() : MachineFunctionPass(ID) {}

    StringRef getPassName() const override
    { return "VE Vector Mask Register Promoter"; }

    static const char* printRegClass(const TargetRegisterClass* RC) {
      if (RC == nullptr) return "nullptr";
      else if (RC == &VE::I64RegClass) return "I64";
      else if (RC == &VE::I32RegClass) return "I32";
      else if (RC == &VE::F32RegClass) return "F32";
      else if (VE::F128RegClass.hasSubClassEq(RC))  return "F128";
      else if (RC == &VE::V64RegClass) return "V64";
      else if (RC == &VE::VMRegClass) return "VM";
      else if (RC == &VE::VM512RegClass) return "VM512";
      else  return "Unknown";
    }

    // Gather all v64 registers defined by VM2V or VMP2V instructions.
    void gatherVecCandidates(MachineBasicBlock &MBB);
    // Expand candidates using def-use relationships.
    bool expandVecCandidates(MachineBasicBlock &MBB);
    // Remove candidates if its def-use relationships are wrong.
    void removeVecCandidates(MachineBasicBlock &MBB);
    // Modify all instructions using v64 regsiters 
    bool runOnMachineBasicBlock(MachineBasicBlock &MBB);
    bool runOnMachineFunction(MachineFunction &F) override {
      bool Changed = false;
      Subtarget = &F.getSubtarget<VESubtarget>();
      MRI = &F.getRegInfo();
      TRI = Subtarget->getRegisterInfo();

      if (DisablePromoteToI1)
        return false;

      LLVM_DEBUG(F.dump());

      for (MachineFunction::iterator FI = F.begin(), FE = F.end();
           FI != FE; ++FI)
        gatherVecCandidates(*FI);

      bool changed;
      do {
        changed = false;
        for (MachineFunction::iterator FI = F.begin(), FE = F.end();
             FI != FE; ++FI)
          changed |= expandVecCandidates(*FI);
        LLVM_DEBUG(dump());
      } while (changed);

      for (MachineFunction::iterator FI = F.begin(), FE = F.end();
           FI != FE; ++FI)
        Changed |= runOnMachineBasicBlock(*FI);
      LLVM_DEBUG(F.dump());
      Candidates.clear();
      GraphInfo.clear();
      return Changed;
    }
  };
  char Promoter::ID = 0;
} // end of anonymous namespace

/// createVEPromoteToI1Pass - Returns a pass that promotes vector registers
/// to vector mask registers in VE MachineFunctions
///
FunctionPass *llvm::createVEPromoteToI1Pass() {
  return new Promoter;
}


void Promoter::gatherVecCandidates(MachineBasicBlock &MBB) {

  for (MachineBasicBlock::iterator I = MBB.begin(); I != MBB.end(); ) {
    MachineBasicBlock::iterator MI = I;
    ++I;

    // If MI is VM2V or VMP2V, result operand is the target.
    if (MI->getOpcode() == VE::VM2V || MI->getOpcode() == VE::VMP2V) {
      assert (MI->getOperand(0).isReg() && MI->getOperand(1).isReg() &&
              "one of VM*2V operands is not a register.");
      unsigned VR = MI->getOperand(0).getReg();
      unsigned VMR = MI->getOperand(1).getReg();
      assert (TargetRegisterInfo::isVirtualRegister(VMR) &&
              "one of VM*2V operands is not a virtual register.");
      new_vec(VR, MRI->getRegClass(VMR));
      continue;
    }
  }
}

bool Promoter::expandVecCandidates(MachineBasicBlock &MBB) {
  bool Changed = false;

  for (MachineBasicBlock::iterator I = MBB.begin(); I != MBB.end(); ) {
    MachineBasicBlock::iterator MI = I;
    ++I;

    if (MI->isPHI() || MI->isCopy()) {
      for (const auto &v : Candidates) {
        if (!MI->readsVirtualRegister(v.first))
          continue;
        if (MI->getNumOperands() == 0)
          continue;
        for (unsigned i = 0, e = MI->getNumOperands(); i != e; ++i) {
          const MachineOperand &MO = MI->getOperand(i);
          if (!MO.isReg()) continue;
          // Check a register in def which uses one of vector register in
          // Candidates.
          unsigned reg = MO.getReg();
          if (exist_vec(reg) && vec(reg).GraphNo != v.second.GraphNo) {
            // If a reg is registered in Candidates with different graph
            // number, we merge two def-use graph into one.
            LLVM_DEBUG(dbgs() << "merging " << v.second.GraphNo \
                         << " to " << vec(reg).GraphNo << "\n");
            merge_graph(v.second.GraphNo, vec(reg).GraphNo);
            Changed = true;
          } else if (!exist_vec(reg)) {
            // If a reg is not registered, add new reg as a new node of
            // existing graph
            LLVM_DEBUG(dbgs() << "adding " << printReg(reg, TRI) \
                         << " as part of " << v.second.GraphNo << "\n");
            new_vec(reg, v.second.GraphNo, v.second.RegClass);
            Changed = true;
          }
        }
      }
    }
  }
  return Changed;
}

void Promoter::removeVecCandidates(MachineBasicBlock &MBB) {
  for (MachineBasicBlock::iterator I = MBB.begin(); I != MBB.end(); ) {
    MachineBasicBlock::iterator MI = I;
    ++I;

    for (auto &v : Candidates) {
      auto result = MI->readsWritesVirtualRegister(v.first);
      if (result.first || result.second) {
        if (MI->isPHI() || MI->isCopy() || MI->isImplicitDef()) {
          // it's OK, so nothing to do here
        } else if (MI->getOpcode() == VE::VM2V
                   || MI->getOpcode() == VE::VMP2V) {
        } else if (MI->getOpcode() == VE::V2VM
                   || MI->getOpcode() == VE::V2VMP) {
        } else {
          LLVM_DEBUG(dbgs() << "invalidating " << printReg(v.first, TRI) \
                       << " because of "; MI->dump());
          v.second.Valid = false;
        }
      }
    }
  }
  return;
}

/// runOnMachineBasicBlock - Fill in delay slots for the given basic block.
/// We assume there is only one delay slot per delayed instruction.
///
bool Promoter::runOnMachineBasicBlock(MachineBasicBlock &MBB) {
  bool Changed = false;
  Subtarget = &MBB.getParent()->getSubtarget<VESubtarget>();
  const TargetInstrInfo *TII = Subtarget->getInstrInfo();

  for (MachineBasicBlock::iterator I = MBB.begin(); I != MBB.end(); ) {
    MachineBasicBlock::iterator MI = I;
    ++I;

    if (!MI->isPHI() && !MI->isCopy() && !MI->isImplicitDef()
      && MI->getOpcode() != VE::VM2V && MI->getOpcode() != VE::VMP2V
      && MI->getOpcode() != VE::V2VM && MI->getOpcode() != VE::V2VMP)
      continue;

    // Check whether this MI access one of Candidates registers.
    if (MI->isPHI() || MI->isCopy() || MI->isImplicitDef()
      || MI->getOpcode() == VE::VM2V || MI->getOpcode() == VE::VMP2V) {
      const MachineOperand &MO = MI->getOperand(0);
      if (!MO.isReg() || !valid_vec(MO.getReg()))
        continue;
    }
    if (MI->getOpcode() == VE::V2VM || MI->getOpcode() == VE::V2VMP) {
      const MachineOperand &MO = MI->getOperand(1);
      if (!MO.isReg() || !valid_vec(MO.getReg()))
        continue;
    }

    // Convert MI to new MI using VM/VMP registers
    //
    // For example:
    //    input:  %12:v64 = VM2V %11:v256i1
    //            v
    //    output: %13:v256i1 = COPY %11:v256i1
    //

    // create virtual register first
    for (unsigned i = 0, e = MI->getNumOperands(); i != e; ++i) {
      const MachineOperand &MO = MI->getOperand(i);
      if (!MO.isReg()) continue;
      unsigned v = MO.getReg();
      if (valid_vec(v) && vec(v).NewReg == 0)
        vec(v).NewReg = MRI->createVirtualRegister(vec(v).RegClass);
    }
    // convert MI
    if (MI->isPHI()) {
      MachineInstrBuilder MIB = BuildMI(
        MBB, I, MI->getDebugLoc(), TII->get(MI->getOpcode()),
        vec(MI->getOperand(0).getReg()).NewReg);
      for (unsigned i = 1, e = MI->getNumOperands(); i != e; ++i) {
        const MachineOperand &MO = MI->getOperand(i);
        if (MO.isReg()) {
          MIB.addReg(vec(MO.getReg()).NewReg);
        } else if (MO.isMBB()) {
          MIB.addMBB(MO.getMBB());
        } else {
          llvm_unreachable("PHI has unexpected operand.");
        }
      }
    } else if (MI->isCopy()) {
      BuildMI(MBB, I, MI->getDebugLoc(), TII->get(TargetOpcode::COPY),
              vec(MI->getOperand(0).getReg()).NewReg)
        .addReg(vec(MI->getOperand(1).getReg()).NewReg);
    } else if (MI->isImplicitDef()) {
      BuildMI(MBB, I, MI->getDebugLoc(), TII->get(MI->getOpcode()),
              vec(MI->getOperand(0).getReg()).NewReg);
    } else if (MI->getOpcode() == VE::VM2V || MI->getOpcode() == VE::VMP2V) {
      BuildMI(MBB, I, MI->getDebugLoc(), TII->get(TargetOpcode::COPY),
              vec(MI->getOperand(0).getReg()).NewReg)
        .addReg(MI->getOperand(1).getReg());
    } else if (MI->getOpcode() == VE::V2VM || MI->getOpcode() == VE::V2VMP) {
      BuildMI(MBB, I, MI->getDebugLoc(), TII->get(TargetOpcode::COPY),
              MI->getOperand(0).getReg())
        .addReg(vec(MI->getOperand(1).getReg()).NewReg);
    }
    MI->eraseFromParent();
    Changed = true;
  }
  return Changed;
}
