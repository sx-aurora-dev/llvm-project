# REQUIRES: ve
# RUN: echo '.tbss; .globl b, c; b: .zero 4; c:' > %t.s
# RUN: echo '.globl __tls_get_addr; __tls_get_addr:' > %tga.s

## RISC-V psABI doesn't specify TLS relaxation. Though the code sequences are not
## relaxed, dynamic relocations can be omitted for GD->LE relaxation.

# RUN: llvm-mc -filetype=obj -triple=ve %s -o %t.o
# RUN: llvm-mc -filetype=obj -triple=ve %t.s -o %t1.o
# RUN: ld.lld -shared -soname=t1.so %t1.o -o %t1.so
# RUN: llvm-mc -filetype=obj -triple=ve %tga.s -o %tga.o
## GD
# RUN: ld.lld -shared %t.o %t1.o -o %t.so
# RUN: llvm-readobj -r %t.so | FileCheck --check-prefix=GD-REL %s
# RUN: llvm-objdump -d --no-show-raw-insn %t.so | FileCheck --check-prefix=GD %s
## GD -> LE
# IGNORE: ld.lld %t.o %t1.o %tga.o -o %t
# IGNORE: llvm-readelf -r %t | FileCheck --check-prefix=NOREL %s
# IGNORE: llvm-readelf -x .got %t | FileCheck --check-prefix=LE-GOT %s
# IGNORE: ld.lld -pie %t.o %t1.o %tga.o -o %t
# IGNORE: llvm-readelf -r %t| FileCheck --check-prefix=NOREL %s
# IGNORE: llvm-readelf -x .got %t| FileCheck --check-prefix=LE-GOT %s
## GD -> IE
# RUN: ld.lld %t.o %t1.so %tga.o -o %t
# RUN: llvm-readobj -r %t | FileCheck --check-prefix=IE-REL %s
# RUN: llvm-readelf -x .got %t | FileCheck --check-prefix=IE-GOT %s
# RUN: llvm-objdump -d --no-show-raw-insn %t | FileCheck --check-prefix=IE %s

# GD-REL:      .rela.dyn {
# GD-REL-NEXT:   0x2005B0 R_VE_DTPMOD64 a 0x0
# GD-REL-NEXT:   0x2005B8 R_VE_DTPOFF64 a 0x0
# GD-REL-NEXT:   0x2005C0 R_VE_DTPMOD64 b 0x0
# GD-REL-NEXT:   0x2005C8 R_VE_DTPOFF64 b 0x0
# GD-REL-NEXT: }

## &DTPMOD(a) - . = 0x200580 - 0x100398 = 0 : 0x1001e8 = 0 : 1049064
# GD:      1003c8: lea %s0, 1049064(-24)
# GD-NEXT:         and %s0, %s0, (32)0
# GD-NEXT:         sic %s10
# GD-NEXT:         lea.sl %s0, (%s0, %s10)
# GD-NEXT:         lea %s12, 168(8)
# GD-NEXT:         and %s12, %s12, (32)0
# GD-NEXT:         lea.sl %s12, (%s12, %s10)
# GD-NEXT:         bsic %s10, (, %s12)

## &DTPMOD(b) - . = 0x200590 - 0x1003d8 = 0: 0x1002b8 = 0 : 1049016
# GD:      100408: lea %s0, 1049016(-24)
# GD-NEXT:         and %s0, %s0, (32)0
# GD-NEXT:         sic %s10
# GD-NEXT:         lea.sl %s0, (%s0, %s10)
# GD-NEXT:         lea %s12, 104(8)
# GD-NEXT:         and %s12, %s12, (32)0
# GD-NEXT:         lea.sl %s12, (%s12, %s10)
# GD-NEXT:         bsic %s10, (, %s12)

# NOREL: no relocations

## .got contains pre-populated values: [a@dtpmod, a@dtprel, b@dtpmod, b@dtprel]
## a@dtprel = st_value(a)-0x800 = 0xfffff808
## b@dtprel = st_value(b)-0x800 = 0xfffff80c
# LE-GOT: section '.got':
# LE-GOT-NEXT: 0x[[#%x,A:]] [[#%x,GOT:]] [[#%x,GOT:]] 01000000 00000000
# LE-GOT-NEXT: 0x[[#%x,A:]] 08f8ffff ffffffff 01000000 00000000
# LE-GOT-NEXT: 0x[[#%x,A:]] 0cf8ffff ffffffff

## a is local - relaxed to LE - its DTPMOD/DTPREL slots are link-time constants.
## b is external - DTPMOD/DTPREL dynamic relocations are required.
# IE-REL:      .rela.dyn {
# IE-REL-NEXT:   0x6000002003F0 R_VE_DTPMOD64 b 0x0
# IE-REL-NEXT:   0x6000002003F8 R_VE_DTPOFF64 b 0x0
# IE-REL-NEXT: }
# IE-GOT:      section '.got':
# IE-GOT-NEXT: 0x6000002003e0 01000000 00000000 08000000 00000000
# IE-GOT-NEXT: 0x6000002003f0 00000000 00000000 00000000 00000000

## &DTPMOD(a) - . = 0x200580 - 0x6000001002a0 = 0 : 0x100138 = 0 : 1048888
# IE:      6000001002a0: lea %s0, 1048888(-24)
# IE-NEXT:               and %s0, %s0, (32)0
# IE-NEXT:               sic %s10
# IE-NEXT:               lea.sl %s0, (%s0, %s10)
# IE-NEXT:               lea %s12, 168(8)
# IE-NEXT:               and %s12, %s12, (32)0
# IE-NEXT:               lea.sl %s12, (%s12, %s10)
# IE-NEXT:               bsic %s10, (, %s12)

## &DTPMOD(b) - . = 0x200590 - 0x1003d8 = 0: 0x1002b8 = 0 : 1049016
# IE:      1003d8: lea %s0, 1049016(-24)
# IE-NEXT:         and %s0, %s0, (32)0
# IE-NEXT:         sic %s10
# IE-NEXT:         lea.sl %s0, (%s0, %s10)
# IE-NEXT:         lea %s12, 104(8)
# IE-NEXT:         and %s12, %s12, (32)0
# IE-NEXT:         lea.sl %s12, (%s12, %s10)
# IE-NEXT:         bsic %s10, (, %s12)

.global _start
_start:
lea %s0, a@tls_gd_lo(-24)
and %s0, %s0, (32)0
sic %lr
lea.sl %s0, a@tls_gd_hi(%s0, %lr)
lea %s12, __tls_get_addr@plt_lo(8)
and %s12, %s12, (32)0
lea.sl %s12, __tls_get_addr@plt_hi(%s12, %lr)
bsic %lr, (, %s12)

lea %s0, b@tls_gd_lo(-24)
and %s0, %s0, (32)0
sic %lr
lea.sl %s0, b@tls_gd_hi(%s0, %lr)
lea %s12, __tls_get_addr@plt_lo(8)
and %s12, %s12, (32)0
lea.sl %s12, __tls_get_addr@plt_hi(%s12, %lr)
bsic %lr, (, %s12)

# la.tls.gd a0,a
# call __tls_get_addr@plt

# la.tls.gd a0,b
# call __tls_get_addr@plt

.section .tbss
.globl a
.zero 8
a:
.zero 4
