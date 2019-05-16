//===-- VEInstPrinter.cpp - Convert VE MCInst to assembly syntax -----------==//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This class prints an VE MCInst to a .s file.
//
//===----------------------------------------------------------------------===//

#include "VEInstPrinter.h"
#include "VE.h"
#include "llvm/MC/MCExpr.h"
#include "llvm/MC/MCInst.h"
#include "llvm/MC/MCRegisterInfo.h"
#include "llvm/MC/MCSubtargetInfo.h"
#include "llvm/MC/MCSymbol.h"
#include "llvm/Support/raw_ostream.h"
using namespace llvm;

#define DEBUG_TYPE "asm-printer"

// The generated AsmMatcher VEGenAsmWriter uses "VE" as the target
// namespace. But SPARC backend uses "SP" as its namespace.
namespace llvm {
namespace VE {
  using namespace VE;
}
}

#define GET_INSTRUCTION_NAME
#define PRINT_ALIAS_INSTR
#include "VEGenAsmWriter.inc"

void VEInstPrinter::printRegName(raw_ostream &OS, unsigned RegNo) const
{
  OS << '%' << StringRef(getRegisterName(RegNo)).lower();
}

void VEInstPrinter::printInst(const MCInst *MI, raw_ostream &O,
                                 StringRef Annot, const MCSubtargetInfo &STI) {
  if (!printAliasInstr(MI, STI, O) && !printVEAliasInstr(MI, STI, O))
    printInstruction(MI, STI, O);
  printAnnotation(O, Annot);
}

bool VEInstPrinter::printVEAliasInstr(const MCInst *MI,
                                            const MCSubtargetInfo &STI,
                                            raw_ostream &O) {
  switch (MI->getOpcode()) {
  default: return false;
#if 0
  case SP::JMPLrr:
  case SP::JMPLri: {
    if (MI->getNumOperands() != 3)
      return false;
    if (!MI->getOperand(0).isReg())
      return false;
    switch (MI->getOperand(0).getReg()) {
    default: return false;
    case SP::G0: // jmp $addr | ret | retl
      if (MI->getOperand(2).isImm() &&
          MI->getOperand(2).getImm() == 8) {
        switch(MI->getOperand(1).getReg()) {
        default: break;
        case SP::I7: O << "\tret"; return true;
        case SP::O7: O << "\tretl"; return true;
        }
      }
      O << "\tjmp "; printMemASXOperand(MI, 1, STI, O);
      return true;
    case SP::O7: // call $addr
      O << "\tcall "; printMemASXOperand(MI, 1, STI, O);
      return true;
    }
  }
#if 0
  case SP::V9FCMPS:  case SP::V9FCMPD:  case SP::V9FCMPQ:
  case SP::V9FCMPES: case SP::V9FCMPED: case SP::V9FCMPEQ: {
    if (isV9(STI)
        || (MI->getNumOperands() != 3)
        || (!MI->getOperand(0).isReg())
        || (MI->getOperand(0).getReg() != SP::FCC0))
      return false;
    // if V8, skip printing %fcc0.
    switch(MI->getOpcode()) {
    default:
    case SP::V9FCMPS:  O << "\tfcmps "; break;
    case SP::V9FCMPD:  O << "\tfcmpd "; break;
    case SP::V9FCMPQ:  O << "\tfcmpq "; break;
    case SP::V9FCMPES: O << "\tfcmpes "; break;
    case SP::V9FCMPED: O << "\tfcmped "; break;
    case SP::V9FCMPEQ: O << "\tfcmpeq "; break;
    }
    printOperand(MI, 1, STI, O);
    O << ", ";
    printOperand(MI, 2, STI, O);
    return true;
  }
#endif
#endif
  }
}

void VEInstPrinter::printOperand(const MCInst *MI, int opNum,
                                    const MCSubtargetInfo &STI,
                                    raw_ostream &O) {
  const MCOperand &MO = MI->getOperand (opNum);

  if (MO.isReg()) {
    printRegName(O, MO.getReg());
    return ;
  }

  if (MO.isImm()) {
    switch (MI->getOpcode()) {
      default:
        O << (int)MO.getImm(); 
        return;
        
#if 0
      case SP::TICCri: // Fall through
      case SP::TICCrr: // Fall through
      case SP::TRAPri: // Fall through
      case SP::TRAPrr: // Fall through
      case SP::TXCCri: // Fall through
      case SP::TXCCrr: // Fall through
        // Only seven-bit values up to 127.
        O << ((int) MO.getImm() & 0x7f);  
        return;
#endif
    }
  }

  assert(MO.isExpr() && "Unknown operand kind in printOperand");
  MO.getExpr()->print(O, &MAI);
}

void VEInstPrinter::printMemASXOperand(const MCInst *MI, int opNum,
                                       const MCSubtargetInfo &STI,
                                       raw_ostream &O, const char *Modifier) {
  // If this is an ADD operand, emit it like normal operands.
  if (Modifier && !strcmp(Modifier, "arith")) {
    printOperand(MI, opNum, STI, O);
    O << ", ";
    printOperand(MI, opNum+1, STI, O);
    return;
  }

  const MCOperand &MO = MI->getOperand(opNum+1);
  if (MO.isImm() && MO.getImm() == 0) {
    // don't print "+0"
  } else {
    printOperand(MI, opNum+1, STI, O);
  }
  O << "(,";
  printOperand(MI, opNum, STI, O);
  O << ")";
}

void VEInstPrinter::printMemASOperand(const MCInst *MI, int opNum,
                                      const MCSubtargetInfo &STI,
                                      raw_ostream &O, const char *Modifier) {
  // If this is an ADD operand, emit it like normal operands.
  if (Modifier && !strcmp(Modifier, "arith")) {
    printOperand(MI, opNum, STI, O);
    O << ", ";
    printOperand(MI, opNum+1, STI, O);
    return;
  }

  const MCOperand &MO = MI->getOperand(opNum+1);
  if (MO.isImm() && MO.getImm() == 0) {
    // don't print "+0"
  } else {
    printOperand(MI, opNum+1, STI, O);
  }
  O << "(";
  printOperand(MI, opNum, STI, O);
  O << ")";
}

void VEInstPrinter::printCCOperand(const MCInst *MI, int opNum,
                                      const MCSubtargetInfo &STI,
                                      raw_ostream &O) {
  int CC = (int)MI->getOperand(opNum).getImm();
  switch (MI->getOpcode()) {
  default: break;
#if 0
  case SP::FBCOND:
  case SP::FBCONDA:
  case SP::BPFCC:
  case SP::BPFCCA:
  case SP::BPFCCNT:
  case SP::BPFCCANT:
  case SP::MOVFCCrr:  case SP::V9MOVFCCrr:
  case SP::MOVFCCri:  case SP::V9MOVFCCri:
  case SP::FMOVS_FCC: case SP::V9FMOVS_FCC:
  case SP::FMOVD_FCC: case SP::V9FMOVD_FCC:
  case SP::FMOVQ_FCC: case SP::V9FMOVQ_FCC:
    // Make sure CC is a fp conditional flag.
    CC = (CC < 16) ? (CC + 16) : CC;
    break;
  case SP::CBCOND:
  case SP::CBCONDA:
    // Make sure CC is a cp conditional flag.
    CC = (CC < 32) ? (CC + 32) : CC;
    break;
#endif
  }
  O << VECondCodeToString((VECC::CondCodes)CC);
}

bool VEInstPrinter::printGetGOT(const MCInst *MI, unsigned opNum,
                                   const MCSubtargetInfo &STI,
                                   raw_ostream &O) {
  llvm_unreachable("FIXME: Implement VEInstPrinter::printGetGOT.");
  return true;
}
