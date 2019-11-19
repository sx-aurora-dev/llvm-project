//===- VEMachineFunctionInfo.h - VE Machine Function Info -------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file declares  VE specific per-machine-function information.
//
//===----------------------------------------------------------------------===//
#ifndef LLVM_LIB_TARGET_VE_VEMACHINEFUNCTIONINFO_H
#define LLVM_LIB_TARGET_VE_VEMACHINEFUNCTIONINFO_H

#include "llvm/CodeGen/MachineFunction.h"

namespace llvm {

  class VEMachineFunctionInfo : public MachineFunctionInfo {
    virtual void anchor();
  private:
    unsigned GlobalBaseReg;

    /// VectorLengthReg - Holds the virtual register for VL register.
    unsigned VectorLengthReg;

    /// VarArgsFrameOffset - Frame offset to start of varargs area.
    int VarArgsFrameOffset;

    /// SRetReturnReg - Holds the virtual register into which the sret
    /// argument is passed.
    unsigned SRetReturnReg;

    /// IsLeafProc - True if the function is a leaf procedure.
    bool IsLeafProc;
  public:
    VEMachineFunctionInfo()
      : GlobalBaseReg(0), VectorLengthReg(0),
        VarArgsFrameOffset(0), SRetReturnReg(0),
        IsLeafProc(false) {}
    explicit VEMachineFunctionInfo(MachineFunction &MF)
      : GlobalBaseReg(0), VectorLengthReg(0),
        VarArgsFrameOffset(0), SRetReturnReg(0),
        IsLeafProc(false) {}

    unsigned getGlobalBaseReg() const { return GlobalBaseReg; }
    void setGlobalBaseReg(unsigned Reg) { GlobalBaseReg = Reg; }

    unsigned getVectorLengthReg() const { return VectorLengthReg; }
    void setVectorLengthReg(unsigned Reg) { VectorLengthReg = Reg; }

    int getVarArgsFrameOffset() const { return VarArgsFrameOffset; }
    void setVarArgsFrameOffset(int Offset) { VarArgsFrameOffset = Offset; }

    unsigned getSRetReturnReg() const { return SRetReturnReg; }
    void setSRetReturnReg(unsigned Reg) { SRetReturnReg = Reg; }

    void setLeafProc(bool rhs) { IsLeafProc = rhs; }
    bool isLeafProc() const { return IsLeafProc; }
  };
}

#endif
