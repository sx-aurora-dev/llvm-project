// REQUIRES: ve
// RUN: llvm-mc -filetype=obj -triple=ve-unknown-linux %s -o %t
// RUN: ld.lld --hash-style=sysv -shared %t -o %t2
// RUN: llvm-readobj --symbols %t2 | FileCheck %s

// The VE _GLOBAL_OFFSET_TABLE_ is defined at the start of the .got.plt
// section.
.globl  a
.type   a,@object
.comm   a,4,4

.globl  f
.type   f,@function
f:
        st %s15, 24(, %s11)
        st %s16, 32(, %s11)
        lea %s15, _GLOBAL_OFFSET_TABLE_@pc_lo(-24)
        and %s15, %s15, (32)0
        sic %s16
        lea.sl %s15, _GLOBAL_OFFSET_TABLE_@pc_hi(%s16, %s15)
        lea %s0, a@got_lo
        and %s0, %s0, (32)0
        lea.sl %s0, a@got_hi(, %s0)
        ld %s0, (%s0, %s15)
        ldl.sx %s0, (, %s0)
        ld %s16, 32(, %s11)
        ld %s15, 24(, %s11)
        b.l.t (, %s10)

.global _start
.type _start,@function
_start:
        st %s9, (, %s11)
        st %s10, 8(, %s11)
        st %s15, 24(, %s11)
        st %s16, 32(, %s11)
        or %s9, 0, %s11

        lea %s15, _GLOBAL_OFFSET_TABLE_@pc_lo(-24)
        and %s15, %s15, (32)0
        sic %s16
        lea.sl %s15, _GLOBAL_OFFSET_TABLE_@pc_hi(%s16, %s15)
        or %s0, 0, (0)1
                                        # kill: def $sw0 killed $sw0 killed $sx0
        stl %s0, -4(, %s9)
        lea %s0, f@plt_lo(-24)
        and %s0, %s0, (32)0
        sic %s16
        lea.sl %s0, f@plt_hi(%s16, %s0)
        or %s12, 0, %s0
        bsic %s10, (, %s12)
        or %s11, 0, %s9
        ld %s16, 32(, %s11)
        ld %s15, 24(, %s11)
        ld %s10, 8(, %s11)
        ld %s9, (, %s11)
        b.l.t (, %s10)

// CHECK:     Name: _GLOBAL_OFFSET_TABLE_
// CHECK-NEXT:     Value:
// CHECK-NEXT:     Size: 0
// CHECK-NEXT:     Binding: Local (0x0)
// CHECK-NEXT:     Type: None (0x0)
// CHECK-NEXT:     Other [ (0x2)
// CHECK-NEXT:       STV_HIDDEN (0x2)
// CHECK-NEXT:     ]
// CHECK-NEXT:     Section: .got.plt
