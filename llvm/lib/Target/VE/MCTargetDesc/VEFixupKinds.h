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

      /// fixup_ve_hi32 - 32-bit fixup corresponding to foo@hi
      fixup_ve_hi32,

      /// fixup_ve_lo32 - 32-bit fixup corresponding to foo@lo
      fixup_ve_lo32,

      /// fixup_ve_pc_hi32 - 32-bit fixup corresponding to foo@pc_hi
      fixup_ve_pc_hi32,

      /// fixup_ve_pc_lo32 - 32-bit fixup corresponding to foo@pc_lo
      fixup_ve_pc_lo32,

      /// fixup_ve_got_hi32 - 32-bit fixup corresponding to foo@got_hi
      fixup_ve_got_hi32,

      /// fixup_ve_got_lo32 - 32-bit fixup corresponding to foo@got_lo
      fixup_ve_got_lo32,

      /// fixup_ve_gotoff_hi32 - 32-bit fixup corresponding to foo@gotoff_hi
      fixup_ve_gotoff_hi32,

      /// fixup_ve_gotoff_lo32 - 32-bit fixup corresponding to foo@gotoff_lo
      fixup_ve_gotoff_lo32,

      /// fixup_ve_plt_hi32/lo32
      fixup_ve_plt_hi32,
      fixup_ve_plt_lo32,

      /// fixups for Thread Local Storage
      fixup_ve_tls_gd_hi32,
      fixup_ve_tls_gd_lo32,
      fixup_ve_tpoff_hi32,
      fixup_ve_tpoff_lo32,

      // Marker
      LastTargetFixupKind,
      NumTargetFixupKinds = LastTargetFixupKind - FirstTargetFixupKind
    };
  }
}

#endif
