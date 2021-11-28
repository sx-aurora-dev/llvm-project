# REQUIRES: ve

# RUN: llvm-mc -filetype=obj -triple=ve %p/Inputs/relocation-copy.s -o %t1.o
# RUN: ld.lld -shared %t1.o -soname=t1.so -o %t1.so
# RUN: llvm-mc -filetype=obj -triple=ve %s -o %t.o
# RUN: ld.lld %t.o %t1.so -o %t
# RUN: llvm-readobj -r %t | FileCheck --check-prefixes=REL %s
# RUN: llvm-nm -S %t | FileCheck --check-prefix=NM %s

# REL:        .rela.dyn {
# REL-NEXT:   0x600000300360 R_VE_COPY x 0x0
# REL-NEXT:   }

# NM: 0000600000300360 0000000000000004 B x

lea %s0, x
