# REQUIRES: ve

# Check @hi and @lo for VE.
# Fully 64 bit address can be referenced, so no relocation errors.

# RUN: llvm-mc -filetype=obj -triple=ve-unknown-elf %s -o %t.o

# RUN: ld.lld %t.o --defsym foo=0 --defsym bar=42 -o %t.exe
# RUN: llvm-objdump -d --no-show-raw-insn %t.exe | FileCheck %s
# CHECK:      lea %s0, 0
# CHECK-NEXT: and %s0, %s0, (32)0
# CHECK-NEXT: lea.sl %s0, (, %s0)
# CHECK-NEXT: st %s0, (, %s0)
# CHECK-NEXT: lea %s0, 42
# CHECK-NEXT: and %s0, %s0, (32)0
# CHECK-NEXT: lea.sl %s0, (, %s0)
# CHECK-NEXT: st %s0, (, %s0)

# RUN: ld.lld %t.o --defsym foo=0xffffffffffffffff --defsym bar=0x5555555555555555 -o %t.limits
# RUN: llvm-objdump -d --no-show-raw-insn %t.limits | FileCheck --check-prefix=LIMITS %s
# LIMITS:      lea %s0, -1
# LIMITS-NEXT: and %s0, %s0, (32)0
# LIMITS-NEXT: lea.sl %s0, -1(, %s0)
# LIMITS-NEXT: st %s0, (, %s0)
# LIMITS-NEXT: lea %s0, 1431655765
# LIMITS-NEXT: and %s0, %s0, (32)0
# LIMITS-NEXT: lea.sl %s0, 1431655765(, %s0)
# LIMITS-NEXT: st %s0, (, %s0)

.global _start

_start:
    lea %s0, foo@lo
    and %s0, %s0, (32)0
    lea.sl %s0, foo@hi(, %s0)
    st %s0, (, %s0)
    lea %s0, bar@lo
    and %s0, %s0, (32)0
    lea.sl %s0, bar@hi(, %s0)
    st %s0, (, %s0)
