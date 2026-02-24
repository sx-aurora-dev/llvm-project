# REQUIRES: ve

# RUN: echo '.globl bar, weak; .type bar,@function; .type weak,@function; bar: weak:' > %t1.s

# RUN: llvm-mc -filetype=obj -triple=ve %t1.s -o %t1.o
# RUN: ld.lld -shared %t1.o -soname=t1.so -o %t1.so
# RUN: llvm-mc -filetype=obj -triple=ve %s -o %t.o
# RUN: ld.lld %t.o %t1.so -z separate-code -o %t.exe
# RUN: llvm-readelf -S -s %t.exe | FileCheck --check-prefixes=SEC,NM %s
# RUN: llvm-readobj -r %t.exe | FileCheck --check-prefix=RELOC %s
# RUN: llvm-readelf -x .got.plt %t.exe | FileCheck --check-prefix=GOTPLT %s
# RUN: llvm-objdump -d --no-show-raw-insn %t.exe | FileCheck --check-prefixes=DIS %s

# SEC: .plt PROGBITS 0000600000000330

## A canonical PLT has a non-zero st_value.
# NM: Symbol table '.dynsym' contains
# NM: 0000000000000000 0 FUNC WEAK   DEFAULT UND weak
# NM: 0000600000000370 0 FUNC GLOBAL DEFAULT UND bar
# NM: Symbol table '.symtab' contains
# NM: 0000600000000320     0 NOTYPE  GLOBAL DEFAULT     6 foo
# NM: 0000600000000370     0 FUNC    GLOBAL DEFAULT   UND bar
# NM: 0000000000000000     0 FUNC    WEAK   DEFAULT   UND weak

## The .got.plt slots relocated by .rela.plt point to .plt
## This is required by glibc.
# RELOC:      .rela.plt {
# RELOC-NEXT:   0x6000002000E8 R_VE_JUMP_SLOT bar 0x0
# RELOC-NEXT:   0x6000002000F0 R_VE_JUMP_SLOT weak 0x0
# RELOC-NEXT: }
# GOTPLT:      section '.got.plt'
# GOTPLT-NEXT: 0x6000002000d0 00001000 00600000 00000000 00000000
# GOTPLT-NEXT: 0x6000002000e0 00000000 00000000 98030000 00600000
# GOTPLT-NEXT: 0x6000002000f0 d8030000 00600000

# DIS:      <_start>:
## Direct call
## foo = 0x0000600000000320 = (24576 << 32) | 800
# DIS-NEXT:   600000000290: lea %s12, 800
# DIS-NEXT:                 and %s12, %s12, (32)0
# DIS-NEXT:                 lea.sl %s12, 24576(, %s12)
# DIS-NEXT:                 bsic %s10, (%s12)
## bar = 0x0000600000000370 = (24576 << 32) | 880
# DIS-NEXT:   6000000002b0: lea %s12, 880
# DIS-NEXT:                 and %s12, %s12, (32)0
# DIS-NEXT:                 lea.sl %s12, 24576(, %s12)
# DIS-NEXT:                 bsic %s10, (%s12)
## bar@plt - . = 0x0000600000000370 - 0x00006000000002d0
##             = 0x00000000000000a0 = 160
# DIS-NEXT:   6000000002d0: lea %s12, 160(-24)
# DIS-NEXT:                 and %s12, %s12, (32)0
# DIS-NEXT:                 sic %s60
# DIS-NEXT:                 lea.sl %s12, (%s12, %s60)
# DIS-NEXT:                 bsic %s10, (%s12)
## weak@plt - . = 0x00006000000003b0 - 0x00006000000002f8
##              = 0x00000000000000b8 = 184
# DIS-NEXT:   6000000002f8: lea %s12, 184(-24)
# DIS-NEXT:                 and %s12, %s12, (32)0
# DIS-NEXT:                 sic %s60
# DIS-NEXT:                 lea.sl %s12, (%s12, %s60)
# DIS-NEXT:                 bsic %s10, (%s12)
# DIS:      <foo>:
# DIS-NEXT:   600000000320: b.l (, %s10)

# DIS:      Disassembly of section .plt:
# DIS:      <.plt>:
## .got.plt - .plt = 0x2000d0 - 0x330 = 2097360
# DIS-NEXT:   600000000330: lea %s62, 2097360
# DIS-NEXT:                 and %s62, %s62, (32)0
# DIS-NEXT:                 lea.sl %s62, 24576(, %s62)
# DIS-NEXT:                 ld %s63, 8(, %s62)
# DIS-NEXT:                 b.l.t (, %s63)

## &.got.plt[bar] = 0x6000002000e8 = (24576 << 32) | 2097384
# DIS:        600000000370: lea %s13, 2097384
# DIS-NEXT:                 and %s13, %s13, (32)0
# DIS-NEXT:                 lea.sl %s13, 24576(, %s13)
# DIS-NEXT:                 ld %s12, (, %s13)
# DIS-NEXT:                 b.l.t (, %s12)
# DIS-NEXT:                 lea %s13, 0
# DIS-NEXT:                 br.l.t -112

## &.got.plt[weak] = 0x6000002000f0 = (24576 << 32) | 2097392
# DIS:        6000000003b0: lea %s13, 2097392
# DIS-NEXT:                 and %s13, %s13, (32)0
# DIS-NEXT:                 lea.sl %s13, 24576(, %s13)
# DIS-NEXT:                 ld %s12, (, %s13)
# DIS-NEXT:                 b.l.t (, %s12)
# DIS-NEXT:                 lea %s13, 1
# DIS-NEXT:                 br.l.t -176

.global _start, foo, bar
.weak weak

_start:
  lea %s12, foo@lo
  and %s12, %s12, (32)0
  lea.sl %s12, foo@hi(, %s12)
  bsic %s10, (%s12)
  lea %s12, bar@lo
  and %s12, %s12, (32)0
  lea.sl %s12, bar@hi(, %s12)
  bsic %s10, (%s12)
  lea %s12, bar@plt_lo(-24)
  and %s12, %s12, (32)0
  sic %s60
  lea.sl %s12, bar@plt_hi(%s12, %s60)
  bsic %s10, (%s12)
  lea %s12, weak@plt_lo(-24)
  and %s12, %s12, (32)0
  sic %s60
  lea.sl %s12, weak@plt_hi(%s12, %s60)
  bsic %s10, (%s12)

## foo is local and non-preemptale, no PLT is generated.
foo:
  b.l (, %s10)
