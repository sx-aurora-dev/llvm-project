# REQUIRES: ve
# RUN: llvm-mc -filetype=obj -triple=ve %s -o %t.o
# RUN: not ld.lld -shared %t.o -o /dev/null 2>&1 | FileCheck %s

# CHECK: error: relocation R_VE_REFLONG cannot be used against symbol 'a'

.globl a

.data
.int a
