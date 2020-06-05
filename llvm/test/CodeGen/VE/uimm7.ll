;; Test that a backend correctly handles uimm7.

; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define i64 @uimm7_0(i64 %a) {
; CHECK-LABEL: uimm7_0:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  %res = shl i64 %a, 0
  ret i64 %res
}

define i64 @uimm7_1(i64 %a) {
; CHECK-LABEL: uimm7_1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sll %s0, %s0, 1
; CHECK-NEXT:    or %s11, 0, %s9
  %res = shl i64 %a, 1
  ret i64 %res
}

define i64 @uimm7_2(i64 %a) {
; CHECK-LABEL: uimm7_2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sll %s0, %s0, 2
; CHECK-NEXT:    or %s11, 0, %s9
  %res = shl i64 %a, 2
  ret i64 %res
}

define i64 @uimm7_63(i64 %a) {
; CHECK-LABEL: uimm7_63:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sll %s0, %s0, 63
; CHECK-NEXT:    or %s11, 0, %s9
  %res = shl i64 %a, 63
  ret i64 %res
}

define i128 @uimm7_64(i128 %a) {
; CHECK-LABEL: uimm7_64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    or %s0, 0, %s1
; CHECK-NEXT:    or %s1, 0, %s2
; CHECK-NEXT:    or %s11, 0, %s9
  %res = shl i128 %a, 64
  ret i128 %res
}

define i128 @uimm7_65(i128 %a) {
; CHECK-LABEL: uimm7_65:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sll %s1, %s0, 1
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %res = shl i128 %a, 65
  ret i128 %res
}

define i128 @uimm7_127(i128 %a) {
; CHECK-LABEL: uimm7_127:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sll %s1, %s0, 63
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %res = shl i128 %a, 127
  ret i128 %res
}
