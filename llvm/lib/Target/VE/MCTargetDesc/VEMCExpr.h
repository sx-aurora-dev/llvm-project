//====- VEMCExpr.h - VE specific MC expression classes --------*- C++ -*-=====//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file describes VE-specific MCExprs, used for modifiers like
// "%hi" or "%lo" etc.,
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_VE_MCTARGETDESC_VEMCEXPR_H
#define LLVM_LIB_TARGET_VE_MCTARGETDESC_VEMCEXPR_H

#include "VEFixupKinds.h"
#include "llvm/MC/MCExpr.h"

namespace llvm {

class StringRef;
class VEMCExpr : public MCTargetExpr {
public:
  enum VariantKind {
    VK_VE_None,
    VK_VE_LO,
    VK_VE_HI,
    VK_VE_H44,
    VK_VE_M44,
    VK_VE_L44,
    VK_VE_HH,
    VK_VE_HM,
    VK_VE_PCHI,
    VK_VE_PCLO,
    VK_VE_GOTHI,
    VK_VE_GOTLO,
    VK_VE_GOTOFFHI,
    VK_VE_GOTOFFLO,
    VK_VE_PLTHI,
    VK_VE_PLTLO,
    VK_VE_R_DISP32,
    VK_VE_TLS_GD_HI22,
    VK_VE_TLS_GD_LO10,
    VK_VE_TLS_GD_ADD,
    VK_VE_TLS_GD_CALL,
    VK_VE_TLS_LDM_HI22,
    VK_VE_TLS_LDM_LO10,
    VK_VE_TLS_LDM_ADD,
    VK_VE_TLS_LDM_CALL,
    VK_VE_TLS_LDO_HIX22,
    VK_VE_TLS_LDO_LOX10,
    VK_VE_TLS_LDO_ADD,
    VK_VE_TLS_IE_HI22,
    VK_VE_TLS_IE_LO10,
    VK_VE_TLS_IE_LD,
    VK_VE_TLS_IE_LDX,
    VK_VE_TLS_IE_ADD,
    VK_VE_TLS_LE_HIX22,
    VK_VE_TLS_LE_LOX10
  };

private:
  const VariantKind Kind;
  const MCExpr *Expr;

  explicit VEMCExpr(VariantKind Kind, const MCExpr *Expr)
      : Kind(Kind), Expr(Expr) {}

public:
  /// @name Construction
  /// @{

  static const VEMCExpr *create(VariantKind Kind, const MCExpr *Expr,
                                 MCContext &Ctx);
  /// @}
  /// @name Accessors
  /// @{

  /// getOpcode - Get the kind of this expression.
  VariantKind getKind() const { return Kind; }

  /// getSubExpr - Get the child of this expression.
  const MCExpr *getSubExpr() const { return Expr; }

  /// getFixupKind - Get the fixup kind of this expression.
  VE::Fixups getFixupKind() const { return getFixupKind(Kind); }

  /// @}
  void printImpl(raw_ostream &OS, const MCAsmInfo *MAI) const override;
  bool evaluateAsRelocatableImpl(MCValue &Res,
                                 const MCAsmLayout *Layout,
                                 const MCFixup *Fixup) const override;
  void visitUsedExpr(MCStreamer &Streamer) const override;
  MCFragment *findAssociatedFragment() const override {
    return getSubExpr()->findAssociatedFragment();
  }

  void fixELFSymbolsInTLSFixups(MCAssembler &Asm) const override;

  static bool classof(const MCExpr *E) {
    return E->getKind() == MCExpr::Target;
  }

  static bool classof(const VEMCExpr *) { return true; }

  static VariantKind parseVariantKind(StringRef name);
  static bool printVariantKind(raw_ostream &OS, VariantKind Kind);
  static VE::Fixups getFixupKind(VariantKind Kind);
};

} // end namespace llvm.

#endif
