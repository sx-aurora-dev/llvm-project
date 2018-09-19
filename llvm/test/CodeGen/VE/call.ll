; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define i32 @sample_call() {
; CHECK-LABEL: sample_call:
; CHECK:       .LBB0_2:
; CHECK-NEXT:    lea %s34, sample_add@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, sample_add@hi(%s34)
; CHECK-NEXT:    or %s0, 1, (0)1
; CHECK-NEXT:    or %s1, 2, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
  %1 = tail call i32 @sample_add(i32 1, i32 2)
  ret i32 %1
}

declare i32 @sample_add(i32, i32)
