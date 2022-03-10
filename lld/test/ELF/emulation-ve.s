# REQUIRES: ve
# RUN: llvm-mc -filetype=obj -triple=ve-unknown-linux %s -o %t.o
# RUN: ld.lld -m elf64ve -e _start %t.o -o %t2ve
# RUN: llvm-readobj --file-headers %t2ve | FileCheck %s
# RUN: ld.lld %t.o -e _start -o %t3ve
# RUN: llvm-readobj --file-headers %t3ve | FileCheck %s
# RUN: echo 'OUTPUT_FORMAT(elf64-ve)' > %t.script
# RUN: ld.lld %t.script %t.o -o %t3ve
# RUN: llvm-readobj --file-headers %t3ve | FileCheck %s
# CHECK:      ElfHeader {
# CHECK-NEXT:   Ident {
# CHECK-NEXT:     Magic: (7F 45 4C 46)
# CHECK-NEXT:     Class: 64-bit (0x2)
# CHECK-NEXT:     DataEncoding: LittleEndian (0x1)
# CHECK-NEXT:     FileVersion: 1
# CHECK-NEXT:     OS/ABI: SystemV (0x0)
# CHECK-NEXT:     ABIVersion: 0
# CHECK-NEXT:     Unused: (00 00 00 00 00 00 00)
# CHECK-NEXT:   }
# CHECK-NEXT:   Type: Executable (0x2)
# CHECK-NEXT:   Machine: EM_VE (0xFB)
# CHECK-NEXT:   Version: 1
# CHECK-NEXT:   Entry:
# CHECK-NEXT:   ProgramHeaderOffset: 0x40
# CHECK-NEXT:   SectionHeaderOffset: 0x190
# CHECK-NEXT:   Flags [ (0x0)
# CHECK-NEXT:   ]

.globl _start
_start:
