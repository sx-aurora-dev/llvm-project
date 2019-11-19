; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define i32 @sample_add(i32, i32) {
; CHECK-LABEL: sample_add:
; CHECK:       .LBB0_2:
; CHECK-NEXT:    adds.w.sx %s0, %s1, %s0
  %3 = add nsw i32 %1, %0
  ret i32 %3
}
