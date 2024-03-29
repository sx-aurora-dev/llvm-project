; RUN: llc -O0 -mhwmult=f5series < %s | FileCheck %s
; RUN: llc -O0 -mattr=+hwmultf5 < %s | FileCheck %s

target datalayout = "e-p:16:16:16-i8:8:8-i16:16:16-i32:16:32-n8:16-a0:16:16"
target triple = "msp430---elf"

@g_i32 = global i32 123, align 8
@g_i64 = global i64 456, align 8
@g_i16 = global i16 789, align 8

define i16 @mpyi() #0 {
entry:
; CHECK: mpyi:

; CHECK: call #__mspabi_mpyi_f5hw
  %0 = load volatile i16, ptr @g_i16, align 8
  %1 = mul i16 %0, %0

  ret i16 %1
}

define i32 @mpyli() #0 {
entry:
; CHECK: mpyli:

; CHECK: call #__mspabi_mpyl_f5hw
  %0 = load volatile i32, ptr @g_i32, align 8
  %1 = mul i32 %0, %0

  ret i32 %1
}

define i64 @mpylli() #0 {
entry:
; CHECK: mpylli:

; CHECK: call #__mspabi_mpyll_f5hw
  %0 = load volatile i64, ptr @g_i64, align 8
  %1 = mul i64 %0, %0

  ret i64 %1
}

attributes #0 = { nounwind }
