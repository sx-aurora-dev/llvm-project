# REQUIRES: ve
# RUN: llvm-mc -filetype=obj -triple=ve %s -o %t.o
# RUN: ld.lld -shared %t.o -o %t.so
# RUN: llvm-nm %t.so | FileCheck --check-prefix=NM %s
# RUN: llvm-readobj -r %t.so | FileCheck --check-prefix=RELOC %s

## R_VE_REFQUAD is an absolute relocation type.
## In PIC mode, it creates a relative relocation if the symbol is
## non-preemptable.

# NM: 00000000002001f8 d b

# RELOC:      .rela.dyn {
# RELOC-NEXT:   0x2001F8 R_VE_RELATIVE - 0x2001F8
# RELOC-NEXT:   0x2001F0 R_VE_REFQUAD a 0x0
# RELOC-NEXT: }

.globl a, b
.hidden b

.data
.quad a
b:
.quad b
