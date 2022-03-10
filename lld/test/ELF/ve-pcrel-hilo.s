# REQUIRES: ve

# Check @pc_hi and @pc_lo for VE.
# Fully 64 bit address can be referenced, so no relocation errors.

# RUN: llvm-mc -filetype=obj -triple=ve-unknown-elf %s -o %t.o

# RUN: ld.lld %t.o --defsym foo=_start+40 --defsym bar=_start -o %t.exe
# RUN: llvm-objdump -d --no-show-raw-insn %t.exe | FileCheck %s
# RUN: ld.lld -pie %t.o --defsym foo=_start+40 --defsym bar=_start -o %t.exe.pie
# RUN: llvm-objdump -d --no-show-raw-insn %t.exe.pie | FileCheck %s
# CHECK:      lea %s0, 40(-24)
# CHECK-NEXT: and %s0, %s0, (32)0
# CHECK-NEXT: sic %s16
# CHECK-NEXT: lea.sl %s0, (%s16, %s0)
# CHECK-NEXT: st %s0, (, %s0)
# CHECK:      lea %s0, -40(-24)
# CHECK-NEXT: and %s0, %s0, (32)0
# CHECK-NEXT: sic %s16
# CHECK-NEXT: lea.sl %s0, -1(%s16, %s0)
# CHECK-NEXT: st %s0, (, %s0)

# RUN: ld.lld %t.o --defsym foo=_start+0x7fffffff7fffffff --defsym bar=_start+40-0x8000000000000000 -o %t.exe.limits
# RUN: llvm-objdump -d --no-show-raw-insn %t.exe.limits | FileCheck --check-prefix=LIMITS %s
# LIMITS:      lea %s0, 2147483647(-24)
# LIMITS-NEXT: and %s0, %s0, (32)0
# LIMITS-NEXT: sic %s16
# LIMITS-NEXT: lea.sl %s0, 2147483647(%s16, %s0)
# LIMITS-NEXT: st %s0, (, %s0)
# LIMITS:      lea %s0, (-24)
# LIMITS-NEXT: and %s0, %s0, (32)0
# LIMITS-NEXT: sic %s16
# LIMITS-NEXT: lea.sl %s0, 2147483647(%s16, %s0)
# LIMITS-NEXT: st %s0, (, %s0)

.global _start
_start:
    lea %s0, foo@pc_lo(-24)
    and %s0, %s0, (32)0
    sic %s16
    lea.sl %s0, foo@pc_hi(%s16, %s0)
    st %s0, (, %s0)
    lea %s0, bar@pc_lo(-24)
    and %s0, %s0, (32)0
    sic %s16
    lea.sl %s0, bar@pc_hi(%s16, %s0)
    st %s0, (, %s0)
