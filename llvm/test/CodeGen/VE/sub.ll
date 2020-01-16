; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define i32 @sample_sub(i32, i32) {
; CHECK-LABEL: sample_sub:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    subs.w.sx %s0, %s1, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = sub nsw i32 %1, %0
  ret i32 %3
}
