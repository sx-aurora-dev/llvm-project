; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define i32 @sample_add(i32, i32) {
; CHECK-LABEL: sample_add:
; CHECK:       # %bb.0:
; CHECK-NEXT:    st %s9, (,%s11)
; CHECK-NEXT:    st %s10, 8(,%s11)
; CHECK-NEXT:    st %s15, 24(,%s11)
; CHECK-NEXT:    st %s16, 32(,%s11)
; CHECK-NEXT:    or %s9, 0, %s11
  %3 = add nsw i32 %1, %0
  ret i32 %3
}
