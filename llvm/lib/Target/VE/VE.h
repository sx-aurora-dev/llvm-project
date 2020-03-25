//===-- VE.h - Top-level interface for VE representation --------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
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
FunctionPass *createVEPromoteToI1Pass();
FunctionPass *createLVLGenPass();

void LowerVEMachineInstrToMCInst(const MachineInstr *MI, MCInst &OutMI,
                                 AsmPrinter &AP);
} // namespace llvm

namespace llvm {

/// Target Constants {
const unsigned StandardVectorWidth = 256;
const unsigned PackedWidth = 512;
/// } Target Constants


// Enums corresponding to VE condition codes, both icc's and fcc's.  These
// values must be kept in sync with the ones in the .td file.
namespace VECC {
enum CondCodes {
  // Integer comparison
  CC_IG = 0,  // Greater
  CC_IL = 1,  // Less
  CC_INE = 2, // Not Equal
  CC_IEQ = 3, // Equal
  CC_IGE = 4, // Greater or Equal
  CC_ILE = 5, // Less or Equal

  // Floating point comparison
  CC_AF = 0 + 6,     // Never
  CC_G = 1 + 6,      // Greater
  CC_L = 2 + 6,      // Less
  CC_NE = 3 + 6,     // Not Equal
  CC_EQ = 4 + 6,     // Equal
  CC_GE = 5 + 6,     // Greater or Equal
  CC_LE = 6 + 6,     // Less or Equal
  CC_NUM = 7 + 6,    // Number
  CC_NAN = 8 + 6,    // NaN
  CC_GNAN = 9 + 6,   // Greater or NaN
  CC_LNAN = 10 + 6,  // Less or NaN
  CC_NENAN = 11 + 6, // Not Equal or NaN
  CC_EQNAN = 12 + 6, // Equal or NaN
  CC_GENAN = 13 + 6, // Greater or Equal or NaN
  CC_LENAN = 14 + 6, // Less or Equal or NaN
  CC_AT = 15 + 6,    // Always
};
}

inline static const char *VECondCodeToString(VECC::CondCodes CC) {
  switch (CC) {
  case VECC::CC_IG:    return "gt";
  case VECC::CC_IL:    return "lt";
  case VECC::CC_INE:   return "ne";
  case VECC::CC_IEQ:   return "eq";
  case VECC::CC_IGE:   return "ge";
  case VECC::CC_ILE:   return "le";
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

inline static unsigned VECondCodeToVal(VECC::CondCodes CC) {
  switch (CC) {
  case VECC::CC_IG:    return 1;
  case VECC::CC_IL:    return 2;
  case VECC::CC_INE:   return 3;
  case VECC::CC_IEQ:   return 4;
  case VECC::CC_IGE:   return 5;
  case VECC::CC_ILE:   return 6;
  case VECC::CC_AF:    return 0;
  case VECC::CC_G:     return 1;
  case VECC::CC_L:     return 2;
  case VECC::CC_NE:    return 3;
  case VECC::CC_EQ:    return 4;
  case VECC::CC_GE:    return 5;
  case VECC::CC_LE:    return 6;
  case VECC::CC_NUM:   return 7;
  case VECC::CC_NAN:   return 8;
  case VECC::CC_GNAN:  return 9;
  case VECC::CC_LNAN:  return 10;
  case VECC::CC_NENAN: return 11;
  case VECC::CC_EQNAN: return 12;
  case VECC::CC_GENAN: return 13;
  case VECC::CC_LENAN: return 14;
  case VECC::CC_AT:    return 15;
  }
  llvm_unreachable("Invalid cond code");
}

inline static VECC::CondCodes VEValToCondCode(unsigned Val, bool IsInteger) {
  if (IsInteger) {
    switch (Val) {
    case 0: return VECC::CC_AF;
    case 1: return VECC::CC_IG;
    case 2: return VECC::CC_IL;
    case 3: return VECC::CC_INE;
    case 4: return VECC::CC_IEQ;
    case 5: return VECC::CC_IGE;
    case 6: return VECC::CC_ILE;
    case 15: return VECC::CC_AT;
    }
  } else {
    switch (Val) {
    case 0: return VECC::CC_AF;
    case 1: return VECC::CC_G;
    case 2: return VECC::CC_L;
    case 3: return VECC::CC_NE;
    case 4: return VECC::CC_EQ;
    case 5: return VECC::CC_GE;
    case 6: return VECC::CC_LE;
    case 7: return VECC::CC_NUM;
    case 8: return VECC::CC_NAN;
    case 9: return VECC::CC_GNAN;
    case 10: return VECC::CC_LNAN;
    case 11: return VECC::CC_NENAN;
    case 12: return VECC::CC_EQNAN;
    case 13: return VECC::CC_GENAN;
    case 14: return VECC::CC_LENAN;
    case 15: return VECC::CC_AT;
    }
  }
  llvm_unreachable("Invalid cond code");
  return VECC::CC_AF;
}

} // namespace llvm
#endif
