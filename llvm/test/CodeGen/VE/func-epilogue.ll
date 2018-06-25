; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define i32 @sample_add(i32, i32) {
; CHECK-LABEL: sample_add:
; CHECK:       .LBB0_2:
; CHECK-NEXT:    addu.w %s0, %s1, %s0
; CHECK-NEXT:    or %s11, 0, %s9
; CHECK-NEXT:    ld %s16, 32(,%s11)
; CHECK-NEXT:    ld %s15, 24(,%s11)
; CHECK-NEXT:    ld %s10, 8(,%s11)
; CHECK-NEXT:    ld %s9, (,%s11)
; CHECK-NEXT:    b.l (,%lr)
  %3 = add nsw i32 %1, %0
  ret i32 %3
}
