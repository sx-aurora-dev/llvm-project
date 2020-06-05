# RUN: llvm-mc -triple=ve %s -o - | FileCheck %s
# RUN: llvm-mc -triple=ve -filetype=obj %s -o - | llvm-objdump -r - | FileCheck %s --check-prefix=CHECK-OBJ

        b.l.t tgt
        br.l.t tgt2
# CHECK: b.l.t tgt
# CHECK-NEXT: br.l.t tgt2

# CHECK-OBJ: 0 R_VE_REFLONG tgt
# CHECK-OBJ: 8 R_VE_PC_LO32 tgt2
