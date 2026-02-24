# REQUIRES: ve
# RUN: llvm-mc -filetype=obj -triple=ve %s -o %t.o
# RUN: ld.lld -shared %t.o -o %t.so
# RUN: llvm-nm %t.so | FileCheck --check-prefix=NM %s
# RUN: llvm-readobj -r %t.so | FileCheck --check-prefix=RELOC %s

## R_VE_REFQUAD is an absolute relocation type.
## In PIC mode, it creates a relative relocation if the symbol is
## non-preemptable.

# NM: 0000000000200318 d b

# RELOC:      .rela.dyn {
# RELOC-NEXT:   0x200318 R_VE_RELATIVE - 0x200318
# RELOC-NEXT:   0x200310 R_VE_REFQUAD a 0x0
# RELOC-NEXT: }

.globl a, b
.hidden b

.data
.quad a
b:
.quad b
