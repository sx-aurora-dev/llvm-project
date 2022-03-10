# REQUIRES: ve

# RUN: llvm-mc -filetype=obj -triple=ve-unknown-elf %s -o %t.o

# RUN: ld.lld %t.o --defsym foo=_start+8 --defsym bar=_start -o %t.exe
# RUN: llvm-objdump -d --no-show-raw-insn %t.exe | FileCheck %s
# CHECK: breq.l.t %s0, %s0, 8
# CHECK: brne.l.t %s0, %s0, -8
#
# RUN: ld.lld %t.o --defsym foo=_start+0x7ffffff8 --defsym bar=_start+8-0x80000000 -o %t.limits
# RUN: llvm-objdump -d --no-show-raw-insn %t.limits | FileCheck --check-prefix=LIMITS %s
# LIMITS:      breq.l.t %s0, %s0, 2147483640
# LIMITS-NEXT: brne.l.t %s0, %s0, -2147483648

# RUN: not ld.lld %t.o --defsym foo=_start+0x80000000 --defsym bar=_start+8-0x80000008 -o /dev/null 2>&1 | FileCheck --check-prefix=ERROR-RANGE %s
# ERROR-RANGE: relocation R_VE_SREL32 out of range: 2147483648 is not in [-2147483648, 2147483647]; references foo
# ERROR-RANGE: relocation R_VE_SREL32 out of range: -2147483656 is not in [-2147483648, 2147483647]; references bar

.global _start
_start:
     breq.l.t %s0, %s0, foo
     brne.l.t %s0, %s0, bar
