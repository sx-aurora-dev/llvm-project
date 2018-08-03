//===-- VEMCExpr.cpp - VE specific MC expression classes ------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the implementation of the assembly expression modifiers
// accepted by the VE architecture (e.g. "%hi", "%lo", ...).
//
//===----------------------------------------------------------------------===//

#include "VEMCExpr.h"
#include "llvm/MC/MCAssembler.h"
#include "llvm/MC/MCContext.h"
#include "llvm/MC/MCObjectStreamer.h"
#include "llvm/MC/MCSymbolELF.h"
#include "llvm/Object/ELF.h"

using namespace llvm;

#define DEBUG_TYPE "vemcexpr"

const VEMCExpr*
VEMCExpr::create(VariantKind Kind, const MCExpr *Expr,
                      MCContext &Ctx) {
    return new (Ctx) VEMCExpr(Kind, Expr);
}

void VEMCExpr::printImpl(raw_ostream &OS, const MCAsmInfo *MAI) const {

  bool closeParen = printVariantKind(OS, Kind);

  const MCExpr *Expr = getSubExpr();
  Expr->print(OS, MAI);

  if (closeParen)
    OS << ')';
}

bool VEMCExpr::printVariantKind(raw_ostream &OS, VariantKind Kind)
{
  bool closeParen = true;
  switch (Kind) {
  case VK_VE_None:     closeParen = false; break;
  case VK_VE_LO:       OS << "%lo(";  break;
  case VK_VE_HI:       OS << "%hi(";  break;
  case VK_VE_H44:      OS << "%h44("; break;
  case VK_VE_M44:      OS << "%m44("; break;
  case VK_VE_L44:      OS << "%l44("; break;
  case VK_VE_HH:       OS << "%hh(";  break;
  case VK_VE_HM:       OS << "%hm(";  break;
  case VK_VE_PCHI:     OS << "%pc_hi("; break;
  case VK_VE_PCLO:     OS << "%pc_lo("; break;
  case VK_VE_GOTHI:    OS << "%got_hi("; break;
  case VK_VE_GOTLO:    OS << "%got_lo("; break;
  case VK_VE_GOTOFFHI: OS << "%gotoff_hi("; break;
  case VK_VE_GOTOFFLO: OS << "%gotoff_lo("; break;
  case VK_VE_PLTHI:    OS << "%plt_hi("; break;
  case VK_VE_PLTLO:    OS << "%plt_lo("; break;
  case VK_VE_R_DISP32: OS << "%r_disp32("; break;
  case VK_VE_TLS_GD_HI22:   OS << "%tgd_hi22(";   break;
  case VK_VE_TLS_GD_LO10:   OS << "%tgd_lo10(";   break;
  case VK_VE_TLS_GD_ADD:    OS << "%tgd_add(";    break;
  case VK_VE_TLS_GD_CALL:   OS << "%tgd_call(";   break;
  case VK_VE_TLS_LDM_HI22:  OS << "%tldm_hi22(";  break;
  case VK_VE_TLS_LDM_LO10:  OS << "%tldm_lo10(";  break;
  case VK_VE_TLS_LDM_ADD:   OS << "%tldm_add(";   break;
  case VK_VE_TLS_LDM_CALL:  OS << "%tldm_call(";  break;
  case VK_VE_TLS_LDO_HIX22: OS << "%tldo_hix22("; break;
  case VK_VE_TLS_LDO_LOX10: OS << "%tldo_lox10("; break;
  case VK_VE_TLS_LDO_ADD:   OS << "%tldo_add(";   break;
  case VK_VE_TLS_IE_HI22:   OS << "%tie_hi22(";   break;
  case VK_VE_TLS_IE_LO10:   OS << "%tie_lo10(";   break;
  case VK_VE_TLS_IE_LD:     OS << "%tie_ld(";     break;
  case VK_VE_TLS_IE_LDX:    OS << "%tie_ldx(";    break;
  case VK_VE_TLS_IE_ADD:    OS << "%tie_add(";    break;
  case VK_VE_TLS_LE_HIX22:  OS << "%tle_hix22(";  break;
  case VK_VE_TLS_LE_LOX10:  OS << "%tle_lox10(";  break;
  }
  return closeParen;
}

VEMCExpr::VariantKind VEMCExpr::parseVariantKind(StringRef name)
{
  return StringSwitch<VEMCExpr::VariantKind>(name)
    .Case("lo",  VK_VE_LO)
    .Case("hi",  VK_VE_HI)
    .Case("h44", VK_VE_H44)
    .Case("m44", VK_VE_M44)
    .Case("l44", VK_VE_L44)
    .Case("hh",  VK_VE_HH)
    .Case("hm",  VK_VE_HM)
    .Case("pc_hi",  VK_VE_PCHI)
    .Case("pc_lo",  VK_VE_PCLO)
    .Case("got_hi", VK_VE_GOTHI)
    .Case("got_lo", VK_VE_GOTLO)
    .Case("gotoff_hi", VK_VE_GOTOFFHI)
    .Case("gotoff_lo", VK_VE_GOTOFFLO)
    .Case("plthi",  VK_VE_PLTHI)
    .Case("pltlo",  VK_VE_PLTLO)
    .Case("r_disp32",   VK_VE_R_DISP32)
    .Case("tgd_hi22",   VK_VE_TLS_GD_HI22)
    .Case("tgd_lo10",   VK_VE_TLS_GD_LO10)
    .Case("tgd_add",    VK_VE_TLS_GD_ADD)
    .Case("tgd_call",   VK_VE_TLS_GD_CALL)
    .Case("tldm_hi22",  VK_VE_TLS_LDM_HI22)
    .Case("tldm_lo10",  VK_VE_TLS_LDM_LO10)
    .Case("tldm_add",   VK_VE_TLS_LDM_ADD)
    .Case("tldm_call",  VK_VE_TLS_LDM_CALL)
    .Case("tldo_hix22", VK_VE_TLS_LDO_HIX22)
    .Case("tldo_lox10", VK_VE_TLS_LDO_LOX10)
    .Case("tldo_add",   VK_VE_TLS_LDO_ADD)
    .Case("tie_hi22",   VK_VE_TLS_IE_HI22)
    .Case("tie_lo10",   VK_VE_TLS_IE_LO10)
    .Case("tie_ld",     VK_VE_TLS_IE_LD)
    .Case("tie_ldx",    VK_VE_TLS_IE_LDX)
    .Case("tie_add",    VK_VE_TLS_IE_ADD)
    .Case("tle_hix22",  VK_VE_TLS_LE_HIX22)
    .Case("tle_lox10",  VK_VE_TLS_LE_LOX10)
    .Default(VK_VE_None);
}

VE::Fixups VEMCExpr::getFixupKind(VEMCExpr::VariantKind Kind) {
  switch (Kind) {
  default: llvm_unreachable("Unhandled VEMCExpr::VariantKind");
  case VK_VE_LO:       return VE::fixup_ve_lo;
  case VK_VE_HI:       return VE::fixup_ve_hi;
  case VK_VE_H44:      return VE::fixup_ve_h44;
  case VK_VE_M44:      return VE::fixup_ve_m44;
  case VK_VE_L44:      return VE::fixup_ve_l44;
  case VK_VE_HH:       return VE::fixup_ve_hh;
  case VK_VE_HM:       return VE::fixup_ve_hm;
  case VK_VE_PCHI:     return VE::fixup_ve_pchi;
  case VK_VE_PCLO:     return VE::fixup_ve_pclo;
  case VK_VE_GOTHI:    return VE::fixup_ve_gothi;
  case VK_VE_GOTLO:    return VE::fixup_ve_gotlo;
  case VK_VE_GOTOFFHI: return VE::fixup_ve_gotoffhi;
  case VK_VE_GOTOFFLO: return VE::fixup_ve_gotofflo;
  case VK_VE_PLTHI:    return VE::fixup_ve_plthi;
  case VK_VE_PLTLO:    return VE::fixup_ve_pltlo;
  case VK_VE_TLS_GD_HI22:   return VE::fixup_ve_tls_gd_hi22;
  case VK_VE_TLS_GD_LO10:   return VE::fixup_ve_tls_gd_lo10;
  case VK_VE_TLS_GD_ADD:    return VE::fixup_ve_tls_gd_add;
  case VK_VE_TLS_GD_CALL:   return VE::fixup_ve_tls_gd_call;
  case VK_VE_TLS_LDM_HI22:  return VE::fixup_ve_tls_ldm_hi22;
  case VK_VE_TLS_LDM_LO10:  return VE::fixup_ve_tls_ldm_lo10;
  case VK_VE_TLS_LDM_ADD:   return VE::fixup_ve_tls_ldm_add;
  case VK_VE_TLS_LDM_CALL:  return VE::fixup_ve_tls_ldm_call;
  case VK_VE_TLS_LDO_HIX22: return VE::fixup_ve_tls_ldo_hix22;
  case VK_VE_TLS_LDO_LOX10: return VE::fixup_ve_tls_ldo_lox10;
  case VK_VE_TLS_LDO_ADD:   return VE::fixup_ve_tls_ldo_add;
  case VK_VE_TLS_IE_HI22:   return VE::fixup_ve_tls_ie_hi22;
  case VK_VE_TLS_IE_LO10:   return VE::fixup_ve_tls_ie_lo10;
  case VK_VE_TLS_IE_LD:     return VE::fixup_ve_tls_ie_ld;
  case VK_VE_TLS_IE_LDX:    return VE::fixup_ve_tls_ie_ldx;
  case VK_VE_TLS_IE_ADD:    return VE::fixup_ve_tls_ie_add;
  case VK_VE_TLS_LE_HIX22:  return VE::fixup_ve_tls_le_hix22;
  case VK_VE_TLS_LE_LOX10:  return VE::fixup_ve_tls_le_lox10;
  }
}

bool
VEMCExpr::evaluateAsRelocatableImpl(MCValue &Res,
                                       const MCAsmLayout *Layout,
                                       const MCFixup *Fixup) const {
  return getSubExpr()->evaluateAsRelocatable(Res, Layout, Fixup);
}

static void fixELFSymbolsInTLSFixupsImpl(const MCExpr *Expr, MCAssembler &Asm) {
  switch (Expr->getKind()) {
  case MCExpr::Target:
    llvm_unreachable("Can't handle nested target expr!");
    break;

  case MCExpr::Constant:
    break;

  case MCExpr::Binary: {
    const MCBinaryExpr *BE = cast<MCBinaryExpr>(Expr);
    fixELFSymbolsInTLSFixupsImpl(BE->getLHS(), Asm);
    fixELFSymbolsInTLSFixupsImpl(BE->getRHS(), Asm);
    break;
  }

  case MCExpr::SymbolRef: {
    const MCSymbolRefExpr &SymRef = *cast<MCSymbolRefExpr>(Expr);
    cast<MCSymbolELF>(SymRef.getSymbol()).setType(ELF::STT_TLS);
    break;
  }

  case MCExpr::Unary:
    fixELFSymbolsInTLSFixupsImpl(cast<MCUnaryExpr>(Expr)->getSubExpr(), Asm);
    break;
  }

}

void VEMCExpr::fixELFSymbolsInTLSFixups(MCAssembler &Asm) const {
  switch(getKind()) {
  default: return;
  case VK_VE_TLS_GD_CALL:
  case VK_VE_TLS_LDM_CALL: {
    // The corresponding relocations reference __tls_get_addr, as they call it,
    // but this is only implicit; we must explicitly add it to our symbol table
    // to bind it for these uses.
    MCSymbol *Symbol = Asm.getContext().getOrCreateSymbol("__tls_get_addr");
    Asm.registerSymbol(*Symbol);
    auto ELFSymbol = cast<MCSymbolELF>(Symbol);
    if (!ELFSymbol->isBindingSet()) {
      ELFSymbol->setBinding(ELF::STB_GLOBAL);
      ELFSymbol->setExternal(true);
    }
    LLVM_FALLTHROUGH;
  }
  case VK_VE_TLS_GD_HI22:
  case VK_VE_TLS_GD_LO10:
  case VK_VE_TLS_GD_ADD:
  case VK_VE_TLS_LDM_HI22:
  case VK_VE_TLS_LDM_LO10:
  case VK_VE_TLS_LDM_ADD:
  case VK_VE_TLS_LDO_HIX22:
  case VK_VE_TLS_LDO_LOX10:
  case VK_VE_TLS_LDO_ADD:
  case VK_VE_TLS_IE_HI22:
  case VK_VE_TLS_IE_LO10:
  case VK_VE_TLS_IE_LD:
  case VK_VE_TLS_IE_LDX:
  case VK_VE_TLS_IE_ADD:
  case VK_VE_TLS_LE_HIX22:
  case VK_VE_TLS_LE_LOX10: break;
  }
  fixELFSymbolsInTLSFixupsImpl(getSubExpr(), Asm);
}

void VEMCExpr::visitUsedExpr(MCStreamer &Streamer) const {
  Streamer.visitUsedExpr(*getSubExpr());
}
