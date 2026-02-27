# REQUIRES: ve

# RUN: llvm-mc -filetype=obj -triple=ve %s -o %t.o
# RUN: ld.lld %t.o -shared -o %t.so
# RUN: llvm-readelf -S %t.so | FileCheck %s -check-prefix=SECTION
# RUN: llvm-objdump -d %t.so | FileCheck %s

# SECTION: .got.plt PROGBITS 0000000000200248 000248 000018

# 0x200248 (.got.plt) - 0x1cc = 0x20007c = 2097276
# CHECK: <gotpc64>:
# CHECK-NEXT: 1cc: 7c 00 20 00 00 00 00 06       lea %s0, 2097276

.global gotpc64
gotpc64:
  lea %s0, _GLOBAL_OFFSET_TABLE_-.
