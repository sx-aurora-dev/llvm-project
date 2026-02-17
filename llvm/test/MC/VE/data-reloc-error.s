# RUN: not llvm-mc -filetype=obj -triple=ve %s -o /dev/null 2>&1 | \
# RUN:     FileCheck %s
# RUN: not llvm-mc -filetype=obj -triple=ve -position-independent %s \
# RUN:     -o /dev/null 2>&1 | FileCheck %s

.data
a:
## An undefined reference of _GLOBAL_OFFSET_TABLE_ causes .got[0] to be
## allocated to store _DYNAMIC.
.byte _GLOBAL_OFFSET_TABLE_
.byte _GLOBAL_OFFSET_TABLE_ - .
.2byte _GLOBAL_OFFSET_TABLE_
.2byte _GLOBAL_OFFSET_TABLE_ - .
## 4-byte pc-relative data emits R_VE_SREL32 as-is.
## 8-byte pc-relative data is downgraded to R_VE_SREL32 because R_VE_PC64
## does not exist (similar to COFF IMAGE_REL_AMD64_REL32).
.4byte _GLOBAL_OFFSET_TABLE_ - .
.8byte _GLOBAL_OFFSET_TABLE_ - .

# CHECK:      data-reloc-error.s:10:7: error: 1-byte data relocation is not supported
# CHECK-NEXT: .byte _GLOBAL_OFFSET_TABLE_
# CHECK:      data-reloc-error.s:11:29: error: 1-byte pc-relative data relocation is not supported
# CHECK-NEXT: .byte _GLOBAL_OFFSET_TABLE_ - .
# CHECK:      data-reloc-error.s:12:8: error: 2-byte data relocation is not supported
# CHECK-NEXT: .2byte _GLOBAL_OFFSET_TABLE_
# CHECK:      data-reloc-error.s:13:30: error: 2-byte pc-relative data relocation is not supported
# CHECK-NEXT: .2byte _GLOBAL_OFFSET_TABLE_ - .

