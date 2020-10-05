; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define i64 @test(i32, i32) {
; CHECK-LABEL: test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    sll %s0, %s0, 32
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    or %s0, %s0, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = zext i32 %0 to i64
  %4 = shl nuw i64 %3, 32
  %5 = zext i32 %1 to i64
  %6 = or i64 %4, %5
  ret i64 %6
}
