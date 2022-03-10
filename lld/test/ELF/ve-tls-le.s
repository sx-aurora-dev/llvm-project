# REQUIRES: ve

# RUN: llvm-mc -filetype=obj -triple=ve %s -o %t.o
# RUN: ld.lld %t.o -o %t
# RUN: llvm-nm -p %t | FileCheck --check-prefixes=NM %s
# RUN: llvm-objdump -d --no-show-raw-insn %t | FileCheck --check-prefixes=LE %s
# RUN: ld.lld -pie %t.o -o %t
# RUN: llvm-objdump -d --no-show-raw-insn %t | FileCheck --check-prefixes=LE %s

# NM: {{0*}}00000008 b .LANCHOR0
# NM: {{0*}}0000000c B a

## .LANCHOR0@tprel = 8 -> 8 + 0x30 = 56
## a@tprel = 12 -> 12 + 0x30 = 60
# LE:      lea %s0, 56
# LE-NEXT: and %s0, %s0, (32)0
# LE-NEXT: lea.sl %s0, (%s14, %s0)
# LE-NEXT: lea %s0, 60
# LE-NEXT: and %s0, %s0, (32)0
# LE-NEXT: lea.sl %s0, (%s14, %s0)

lea %s0, .LANCHOR0@tpoff_lo
and %s0, %s0, (32)0
lea.sl %s0, .LANCHOR0@tpoff_hi(%tp, %s0)

lea %s0, a@tpoff_lo
and %s0, %s0, (32)0
lea.sl %s0, a@tpoff_hi(%tp, %s0)

.section .tbss
.space 8
.LANCHOR0:
.zero 4
.globl a
a:
