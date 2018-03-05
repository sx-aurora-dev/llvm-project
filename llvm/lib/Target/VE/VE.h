//===-- VE.h - Top-level interface for VE representation --------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the entry points for global functions defined in the LLVM
// VE back-end.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_VE_VE_H
#define LLVM_LIB_TARGET_VE_VE_H

#include "MCTargetDesc/VEMCTargetDesc.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Target/TargetMachine.h"

namespace llvm {
  class FunctionPass;
  class VETargetMachine;
  class formatted_raw_ostream;
  class AsmPrinter;
  class MCInst;
  class MachineInstr;

  FunctionPass *createVEISelDag(VETargetMachine &TM);
  FunctionPass *createVEDelaySlotFillerPass();

  void LowerVEMachineInstrToMCInst(const MachineInstr *MI,
                                      MCInst &OutMI,
                                      AsmPrinter &AP);
} // end namespace llvm;

namespace llvm {
  // Enums corresponding to VE condition codes, both icc's and fcc's.  These
  // values must be kept in sync with the ones in the .td file.
  namespace VECC {
    enum CondCodes {
      CC_AF    =  0   ,  // Never
      CC_G     =  1   ,  // Greater
      CC_L     =  2   ,  // Less
      CC_NE    =  3   ,  // Not Equal
      CC_EQ    =  4   ,  // Equal
      CC_GE    =  5   ,  // Greater or Equal
      CC_LE    =  6   ,  // Less or Equal
      CC_NUM   =  7   ,  // Number
      CC_NAN   =  8   ,  // NaN
      CC_GNAN  =  9   ,  // Greater or NaN
      CC_LNAN  = 10   ,  // Less or NaN
      CC_NENAN = 11   ,  // Not Equal or NaN
      CC_EQNAN = 12   ,  // Equal or NaN
      CC_GENAN = 13   ,  // Greater or Equal or NaN
      CC_LENAN = 14   ,  // Less or Equal or NaN
      CC_AT    = 15   ,  // Always
    };
  }

  inline static const char *VECondCodeToString(VECC::CondCodes CC) {
    switch (CC) {
    case VECC::CC_AF:    return "af";
    case VECC::CC_G:     return "gt";
    case VECC::CC_L:     return "lt";
    case VECC::CC_NE:    return "ne";
    case VECC::CC_EQ:    return "eq";
    case VECC::CC_GE:    return "ge";
    case VECC::CC_LE:    return "le";
    case VECC::CC_NUM:   return "num";
    case VECC::CC_NAN:   return "nan";
    case VECC::CC_GNAN:  return "gtnan";
    case VECC::CC_LNAN:  return "ltnan";
    case VECC::CC_NENAN: return "nenan";
    case VECC::CC_EQNAN: return "eqnan";
    case VECC::CC_GENAN: return "genan";
    case VECC::CC_LENAN: return "lenan";
    case VECC::CC_AT:    return "at";
    }
    llvm_unreachable("Invalid cond code");
  }

  inline static unsigned HI32(int64_t imm) {
    return (unsigned)((imm >> 32) & 0xFFFFFFFF);
  }

  inline static unsigned LO32(int64_t imm) {
    return (unsigned)(imm & 0xFFFFFFFF);
  }

}  // end namespace llvm
#endif
