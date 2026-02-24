# REQUIRES: ve

# RUN: llvm-mc -filetype=obj -triple=ve %s -o %t.o
# RUN: ld.lld %t.o -shared -o %t.so
# RUN: llvm-readelf -S %t.so | FileCheck %s -check-prefix=SECTION
# RUN: llvm-objdump -d %t.so | FileCheck %s

# SECTION: .got.plt PROGBITS 00000000004002b8 0002b8 000018

# 0x4002b8 (.got.plt) - 0x23c = 0x40007c = 4194428
# CHECK: <gotpc64>:
# CHECK-NEXT: 23c: 7c 00 40 00 00 00 00 06       lea %s0, 4194428

.global gotpc64
gotpc64:
  lea %s0, _GLOBAL_OFFSET_TABLE_-.
