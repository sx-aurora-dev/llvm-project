;; Promoting AND may cause infinity visit/combine loop.  So, test it.

; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define hidden signext i32 @__paritysi2(i32 signext %0) {
; CHECK-LABEL: __paritysi2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s1, %s0, (0)1
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    srl %s1, %s1, 16
; CHECK-NEXT:    xor %s0, %s1, %s0
; CHECK-NEXT:    adds.w.sx %s1, %s0, (0)1
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    srl %s1, %s1, 8
; CHECK-NEXT:    xor %s0, %s1, %s0
; CHECK-NEXT:    adds.w.sx %s1, %s0, (0)1
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    srl %s1, %s1, 4
; CHECK-NEXT:    xor %s0, %s1, %s0
; CHECK-NEXT:    and %s0, 15, %s0
; CHECK-NEXT:    lea %s1, 27030
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    srl %s0, %s1, %s0
; CHECK-NEXT:    and %s0, 1, %s0
; CHECK-NEXT:    or %s11, 0, %s9
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
