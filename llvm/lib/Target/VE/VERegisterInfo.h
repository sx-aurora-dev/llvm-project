//===-- VERegisterInfo.h - VE Register Information Impl ---------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the VE implementation of the TargetRegisterInfo class.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_VE_VEREGISTERINFO_H
#define LLVM_LIB_TARGET_VE_VEREGISTERINFO_H

#include "llvm/CodeGen/TargetRegisterInfo.h"

#define GET_REGINFO_HEADER
#include "VEGenRegisterInfo.inc"

namespace llvm {
struct VERegisterInfo : public VEGenRegisterInfo {
private:
  // VLS register class's Pressure Set ID.
  unsigned VLSPSetID;

public:
  VERegisterInfo();

  /// Code Generation virtual methods...
  const MCPhysReg *getCalleeSavedRegs(const MachineFunction *MF) const override;
  const uint32_t *getCallPreservedMask(const MachineFunction &MF,
                                       CallingConv::ID CC) const override;
  const uint32_t *getNoPreservedMask() const override;

  BitVector getReservedRegs(const MachineFunction &MF) const override;

  const TargetRegisterClass *getPointerRegClass(const MachineFunction &MF,
                                                unsigned Kind) const override;

  bool requiresRegisterScavenging(const MachineFunction &MF) const override;
  bool requiresFrameIndexScavenging(const MachineFunction &MF) const override;

  void eliminateFrameIndex(MachineBasicBlock::iterator II,
                           int SPAdj, unsigned FIOperandNum,
                           RegScavenger *RS = nullptr) const override;

  unsigned getFrameRegister(const MachineFunction &MF) const override;

  bool canRealignStack(const MachineFunction &MF) const override;

  unsigned getRegPressureSetLimit(const MachineFunction &MF,
                                  unsigned Idx) const override;
};

} // end namespace llvm

#endif
