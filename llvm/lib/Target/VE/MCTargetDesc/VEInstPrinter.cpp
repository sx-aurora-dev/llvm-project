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

#define DEBUG_TYPE "ve-asmprinter"

// The generated AsmMatcher VEGenAsmWriter uses "VE" as the target
// namespace.
namespace llvm {
namespace VE {
using namespace VE;
}
} // namespace llvm

#define GET_INSTRUCTION_NAME
#define PRINT_ALIAS_INSTR
#include "VEGenAsmWriter.inc"

void VEInstPrinter::printRegName(raw_ostream &OS, unsigned RegNo) const {
  unsigned AltIdx = VE::NoRegAltName;
  // Generic registers have identical regitster name among register classes.
  if (!MRI.getRegClass(VE::MISCRegClassID).contains(RegNo))
    AltIdx = VE::AsmName;
  OS << '%' << StringRef(getRegisterName(RegNo, AltIdx)).lower();
}

void VEInstPrinter::printInst(const MCInst *MI, uint64_t Address,
                              StringRef Annot, const MCSubtargetInfo &STI,
                              raw_ostream &OS) {
  if (!printAliasInstr(MI, STI, OS))
    printInstruction(MI, Address, STI, OS);
  printAnnotation(OS, Annot);
}

void VEInstPrinter::printOperand(const MCInst *MI, int opNum,
                                 const MCSubtargetInfo &STI, raw_ostream &O) {
  const MCOperand &MO = MI->getOperand(opNum);

  if (MO.isReg()) {
    printRegName(O, MO.getReg());
    return;
  }

  if (MO.isImm()) {
    switch (MI->getOpcode()) {
    default:
      // Expects signed 32bit literals
      int32_t TruncatedImm = static_cast<int32_t>(MO.getImm());
      O << TruncatedImm;
      return;
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
    printOperand(MI, opNum + 1, STI, O);
    return;
  }

  if (MI->getOperand(opNum+2).isImm() &&
      MI->getOperand(opNum+2).getImm() == 0) {
    // don't print "+0"
  } else {
    printOperand(MI, opNum+2, STI, O);
  }
  if (MI->getOperand(opNum+1).isImm() &&
      MI->getOperand(opNum+1).getImm() == 0 &&
      MI->getOperand(opNum).isImm() &&
      MI->getOperand(opNum).getImm() == 0) {
    if (MI->getOperand(opNum+2).isImm() &&
        MI->getOperand(opNum+2).getImm() == 0) {
      O << "0";
    } else {
      // don't print "+0,+0"
    }
  } else {
    O << "(";
    if (MI->getOperand(opNum+1).isImm() &&
        MI->getOperand(opNum+1).getImm() == 0) {
      // don't print "+0"
    } else {
      printOperand(MI, opNum+1, STI, O);
    }
    if (MI->getOperand(opNum).isImm() &&
        MI->getOperand(opNum).getImm() == 0) {
      // don't print "+0"
    } else {
      O << ", ";
      printOperand(MI, opNum, STI, O);
    }
    O << ")";
  }
}

void VEInstPrinter::printMemASOperandASX(const MCInst *MI, int opNum,
                                         const MCSubtargetInfo &STI,
                                         raw_ostream &O, const char *Modifier) {
  // If this is an ADD operand, emit it like normal operands.
  if (Modifier && !strcmp(Modifier, "arith")) {
    printOperand(MI, opNum, STI, O);
    O << ", ";
    printOperand(MI, opNum+1, STI, O);
    return;
  }

  if (MI->getOperand(opNum+1).isImm() &&
      MI->getOperand(opNum+1).getImm() == 0) {
    // don't print "+0"
  } else {
    printOperand(MI, opNum+1, STI, O);
  }
  if (MI->getOperand(opNum).isImm() &&
      MI->getOperand(opNum).getImm() == 0) {
    if (MI->getOperand(opNum+1).isImm() &&
        MI->getOperand(opNum+1).getImm() == 0) {
      O << "0";
    } else {
      // don't print "(0)"
    }
  } else {
    O << "(, ";
    printOperand(MI, opNum, STI, O);
    O << ")";
  }
}

void VEInstPrinter::printMemASOperandRRM(const MCInst *MI, int opNum,
                                         const MCSubtargetInfo &STI,
                                         raw_ostream &O, const char *Modifier) {
  // If this is an ADD operand, emit it like normal operands.
  if (Modifier && !strcmp(Modifier, "arith")) {
    printOperand(MI, opNum, STI, O);
    O << ", ";
    printOperand(MI, opNum+1, STI, O);
    return;
  }

  if (MI->getOperand(opNum+1).isImm() &&
      MI->getOperand(opNum+1).getImm() == 0) {
    // don't print "+0"
  } else {
    printOperand(MI, opNum+1, STI, O);
  }
  if (MI->getOperand(opNum).isImm() &&
      MI->getOperand(opNum).getImm() == 0) {
    if (MI->getOperand(opNum+1).isImm() &&
        MI->getOperand(opNum+1).getImm() == 0) {
      O << "0";
    } else {
      // don't print "(0)"
    }
  } else {
    O << "(";
    printOperand(MI, opNum, STI, O);
    O << ")";
  }
}

void VEInstPrinter::printMemASOperandHM(const MCInst *MI, int opNum,
                                        const MCSubtargetInfo &STI,
                                        raw_ostream &O, const char *Modifier) {
  // If this is an ADD operand, emit it like normal operands.
  if (Modifier && !strcmp(Modifier, "arith")) {
    printOperand(MI, opNum, STI, O);
    O << ", ";
    printOperand(MI, opNum+1, STI, O);
    return;
  }

  if (MI->getOperand(opNum+1).isImm() &&
      MI->getOperand(opNum+1).getImm() == 0) {
    // don't print "+0"
  } else {
    printOperand(MI, opNum+1, STI, O);
  }
  O << "(";
  if (MI->getOperand(opNum).isReg())
    printOperand(MI, opNum, STI, O);
  O << ")";
}

void VEInstPrinter::printCCOperand(const MCInst *MI, int opNum,
                                   const MCSubtargetInfo &STI, raw_ostream &O) {
  int CC = (int)MI->getOperand(opNum).getImm();
  O << VECondCodeToString((VECC::CondCode)CC);
}

void VEInstPrinter::printCCOperandDot(const MCInst *MI, int opNum,
                                   const MCSubtargetInfo &STI, raw_ostream &O) {
  int CC = (int)MI->getOperand(opNum).getImm();
  O << "." << VECondCodeToString((VECC::CondCode)CC);
}

void VEInstPrinter::printRDOperand(const MCInst *MI, int opNum,
                                   const MCSubtargetInfo &STI,
                                   raw_ostream &O) {
  int RD = (int)MI->getOperand(opNum).getImm();
  O << VERDToString((VERD::RoundingMode)RD);
}

bool VEInstPrinter::printGetGOT(const MCInst *MI, unsigned opNum,
                                const MCSubtargetInfo &STI, raw_ostream &O) {
  llvm_unreachable("FIXME: Implement VEInstPrinter::printGetGOT.");
  return true;
}
