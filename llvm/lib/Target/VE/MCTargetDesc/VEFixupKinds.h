//===-- VEFixupKinds.h - VE Specific Fixup Entries --------------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_VE_MCTARGETDESC_VEFIXUPKINDS_H
#define LLVM_LIB_TARGET_VE_MCTARGETDESC_VEFIXUPKINDS_H

#include "llvm/MC/MCFixup.h"

namespace llvm {
  namespace VE {
    enum Fixups {
      // fixup_ve_call30 - 30-bit PC relative relocation for call
      fixup_ve_call30 = FirstTargetFixupKind,

      /// fixup_ve_br22 - 22-bit PC relative relocation for
      /// branches
      fixup_ve_br22,

      /// fixup_ve_br19 - 19-bit PC relative relocation for
      /// branches on icc/xcc
      fixup_ve_br19,

      /// fixup_ve_bpr  - 16-bit fixup for bpr
      fixup_ve_br16_2,
      fixup_ve_br16_14,

      /// fixup_ve_hi22  - 22-bit fixup corresponding to %hi(foo)
      /// for sethi
      fixup_ve_hi22,

      /// fixup_ve_lo10  - 10-bit fixup corresponding to %lo(foo)
      fixup_ve_lo10,

      /// fixup_ve_h44  - 22-bit fixup corresponding to %h44(foo)
      fixup_ve_h44,

      /// fixup_ve_m44  - 10-bit fixup corresponding to %m44(foo)
      fixup_ve_m44,

      /// fixup_ve_l44  - 12-bit fixup corresponding to %l44(foo)
      fixup_ve_l44,

      /// fixup_ve_hh  -  22-bit fixup corresponding to %hh(foo)
      fixup_ve_hh,

      /// fixup_ve_hm  -  10-bit fixup corresponding to %hm(foo)
      fixup_ve_hm,

      /// fixup_ve_pc22 - 22-bit fixup corresponding to %pc22(foo)
      fixup_ve_pc22,

      /// fixup_ve_pc10 - 10-bit fixup corresponding to %pc10(foo)
      fixup_ve_pc10,

      /// fixup_ve_got22 - 22-bit fixup corresponding to %got22(foo)
      fixup_ve_got22,

      /// fixup_ve_got10 - 10-bit fixup corresponding to %got10(foo)
      fixup_ve_got10,

      /// fixup_ve_wplt30
      fixup_ve_wplt30,

      /// fixups for Thread Local Storage
      fixup_ve_tls_gd_hi22,
      fixup_ve_tls_gd_lo10,
      fixup_ve_tls_gd_add,
      fixup_ve_tls_gd_call,
      fixup_ve_tls_ldm_hi22,
      fixup_ve_tls_ldm_lo10,
      fixup_ve_tls_ldm_add,
      fixup_ve_tls_ldm_call,
      fixup_ve_tls_ldo_hix22,
      fixup_ve_tls_ldo_lox10,
      fixup_ve_tls_ldo_add,
      fixup_ve_tls_ie_hi22,
      fixup_ve_tls_ie_lo10,
      fixup_ve_tls_ie_ld,
      fixup_ve_tls_ie_ldx,
      fixup_ve_tls_ie_add,
      fixup_ve_tls_le_hix22,
      fixup_ve_tls_le_lox10,

      // Marker
      LastTargetFixupKind,
      NumTargetFixupKinds = LastTargetFixupKind - FirstTargetFixupKind
    };
  }
}

#endif
