; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define i32 @sample_sub(i32, i32) {
; CHECK-LABEL: sample_sub:
; CHECK:       .LBB0_2:
; CHECK-NEXT:    subs.w.sx %s0, %s1, %s0
  %3 = sub nsw i32 %1, %0
  ret i32 %3
}
