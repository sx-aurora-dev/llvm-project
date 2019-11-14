//===- VEMCAsmInfo.cpp - VE asm properties --------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file contains the declarations of the VEMCAsmInfo properties.
//
//===----------------------------------------------------------------------===//

#include "VEMCAsmInfo.h"
#include "VEMCExpr.h"
#include "llvm/ADT/Triple.h"
#include "llvm/BinaryFormat/Dwarf.h"
#include "llvm/MC/MCExpr.h"
#include "llvm/MC/MCStreamer.h"
#include "llvm/MC/MCTargetOptions.h"

using namespace llvm;

void VEELFMCAsmInfo::anchor() {}

VEELFMCAsmInfo::VEELFMCAsmInfo(const Triple &TheTriple) {

  CodePointerSize = CalleeSaveStackSlotSize = 8;
  MaxInstLength = MinInstAlignment = 8;

  // VE has ".zero" directive although it is not listed in assembler manual.
  // ZeroDirective = nullptr;

  // VE uses ".*byte" directive for unaligned data.
  Data8bitsDirective = "\t.byte\t";
  Data16bitsDirective = "\t.2byte\t";
  Data32bitsDirective = "\t.4byte\t";
  Data64bitsDirective = "\t.8byte\t";

  // Uses '.section' before '.bss' directive.  VE requires this although
  // assembler manual says sinple '.bss' is supported.
  UsesELFSectionDirectiveForBSS = true;

  // ExceptionsType = ExceptionHandling::DwarfCFI;
  SupportsDebugInformation = true;
  // SunStyleELFSectionSwitchSyntax = true;
  // UseIntegratedAssembler = true;
}

const MCExpr*
VEELFMCAsmInfo::getExprForPersonalitySymbol(const MCSymbol *Sym,
                                               unsigned Encoding,
                                               MCStreamer &Streamer) const {
  if (Encoding & dwarf::DW_EH_PE_pcrel) {
    MCContext &Ctx = Streamer.getContext();
    return VEMCExpr::create(VEMCExpr::VK_VE_R_DISP32,
                               MCSymbolRefExpr::create(Sym, Ctx), Ctx);
  }

  return MCAsmInfo::getExprForPersonalitySymbol(Sym, Encoding, Streamer);
}

const MCExpr*
VEELFMCAsmInfo::getExprForFDESymbol(const MCSymbol *Sym,
                                       unsigned Encoding,
                                       MCStreamer &Streamer) const {
  if (Encoding & dwarf::DW_EH_PE_pcrel) {
    MCContext &Ctx = Streamer.getContext();
    return VEMCExpr::create(VEMCExpr::VK_VE_R_DISP32,
                               MCSymbolRefExpr::create(Sym, Ctx), Ctx);
  }
  return MCAsmInfo::getExprForFDESymbol(Sym, Encoding, Streamer);
}
