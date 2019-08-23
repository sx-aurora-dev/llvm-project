; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define i64 @test(i32, i32) {
; CHECK-LABEL: test:
; CHECK:       .LBB0_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    sll %s34, %s0, 32
; CHECK-NEXT:    adds.w.zx %s35, %s1, (0)1
; CHECK-NEXT:    or %s0, %s34, %s35
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = zext i32 %0 to i64
  %4 = shl nuw i64 %3, 32
  %5 = zext i32 %1 to i64
  %6 = or i64 %4, %5
  ret i64 %6
}
