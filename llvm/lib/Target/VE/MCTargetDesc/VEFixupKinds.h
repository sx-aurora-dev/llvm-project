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

      /// fixup_ve_hi   - 32-bit fixup corresponding to %hi(foo)
      /// for sethi
      fixup_ve_hi,

      /// fixup_ve_lo   - 32-bit fixup corresponding to %lo(foo)
      fixup_ve_lo,

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

      /// fixup_ve_pchi - 32-bit fixup corresponding to %pc_hi(foo)
      fixup_ve_pchi,

      /// fixup_ve_pclo - 32-bit fixup corresponding to %pc_lo(foo)
      fixup_ve_pclo,

      /// fixup_ve_gothi - 32-bit fixup corresponding to %got_hi(foo)
      fixup_ve_gothi,

      /// fixup_ve_gotlo - 32-bit fixup corresponding to %got_lo(foo)
      fixup_ve_gotlo,

      /// fixup_ve_gotoffhi - 32-bit fixup corresponding to %gotoff_hi(foo)
      fixup_ve_gotoffhi,

      /// fixup_ve_gotofflo - 32-bit fixup corresponding to %gotoff_lo(foo)
      fixup_ve_gotofflo,

      /// fixup_ve_plthi/lo
      fixup_ve_plthi,
      fixup_ve_pltlo,

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
