;; Test that a backend correctly handles simm7.

; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define i64 @simm7_0(i64 %a) {
; CHECK-LABEL: simm7_0:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    subs.l %s0, 0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %res = sub i64 0, %a
  ret i64 %res
}

define i64 @simm7_1(i64 %a) {
; CHECK-LABEL: simm7_1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %res = and i64 %a, 1
  ret i64 %res
}

define i64 @simm7_2(i64 %a) {
; CHECK-LABEL: simm7_2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 2, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %res = and i64 %a, 2
  ret i64 %res
}

define i64 @simm7_3(i64 %a) {
; CHECK-LABEL: simm7_3:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 3, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %res = and i64 %a, 3
  ret i64 %res
}

define i64 @simm7_63(i64 %a) {
; CHECK-LABEL: simm7_63:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 63, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %res = and i64 %a, 63
  ret i64 %res
}

define i64 @simm7_64(i64 %a) {
; CHECK-LABEL: simm7_64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 64
; CHECK-NEXT:    and %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %res = and i64 %a, 64
  ret i64 %res
}

define i64 @simm7_m1(i64 %a) {
; CHECK-LABEL: simm7_m1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    xor %s0, -1, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %res = xor i64 %a, -1
  ret i64 %res
}

define i64 @simm7_m2(i64 %a) {
; CHECK-LABEL: simm7_m2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, -2, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %res = and i64 %a, -2
  ret i64 %res
}

define i64 @simm7_m3(i64 %a) {
; CHECK-LABEL: simm7_m3:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, -3, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %res = and i64 %a, -3
  ret i64 %res
}

define i64 @simm7_m63(i64 %a) {
; CHECK-LABEL: simm7_m63:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, -63, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %res = and i64 %a, -63
  ret i64 %res
}

define i64 @simm7_m64(i64 %a) {
; CHECK-LABEL: simm7_m64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, -64, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %res = and i64 %a, -64
  ret i64 %res
}

define i64 @simm7_m65(i64 %a) {
; CHECK-LABEL: simm7_m65:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, -65
; CHECK-NEXT:    and %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %res = and i64 %a, -65
  ret i64 %res
}
