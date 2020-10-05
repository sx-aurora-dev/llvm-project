;; Promoting AND may cause infinity visit/combine loop.  So, test it.

; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define hidden signext i32 @__paritysi2(i32 signext %0) {
; CHECK-LABEL: __paritysi2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s1, %s0, (32)0
; CHECK-NEXT:    srl %s1, %s1, 16
; CHECK-NEXT:    xor %s0, %s1, %s0
; CHECK-NEXT:    and %s1, %s0, (32)0
; CHECK-NEXT:    srl %s1, %s1, 8
; CHECK-NEXT:    xor %s0, %s1, %s0
; CHECK-NEXT:    and %s1, %s0, (32)0
; CHECK-NEXT:    srl %s1, %s1, 4
; CHECK-NEXT:    xor %s0, %s1, %s0
; CHECK-NEXT:    and %s0, 15, %s0
; CHECK-NEXT:    lea %s1, 27030
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    srl %s0, %s1, %s0
; CHECK-NEXT:    and %s0, 1, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = lshr i32 %0, 16
  %3 = xor i32 %2, %0
  %4 = lshr i32 %3, 8
  %5 = xor i32 %4, %3
  %6 = lshr i32 %5, 4
  %7 = xor i32 %6, %5
  %8 = and i32 %7, 15
  %9 = lshr i32 27030, %8
  %10 = and i32 %9, 1
  ret i32 %10
}
