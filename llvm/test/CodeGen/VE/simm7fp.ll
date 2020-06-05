;; Test that a backend correctly handles simm7fp.

; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define double @simm7fp_0(double %a) {
; CHECK-LABEL: simm7fp_0:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fsub.d %s0, 0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %res = fsub double 0.0, %a
  ret double %res
}

define double @simm7fp_1(double %a) {
; CHECK-LABEL: simm7fp_1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fsub.d %s0, 1, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %res = fsub double 0x0000000000000001, %a
  ret double %res
}

define double @simm7fp_2(double %a) {
; CHECK-LABEL: simm7fp_2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fadd.d %s0, 2, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %res = fadd double %a, 0x0000000000000002
  ret double %res
}

define double @simm7fp_63(double %a) {
; CHECK-LABEL: simm7fp_63:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fsub.d %s0, 63, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %res = fsub double 0x000000000000003F, %a
  ret double %res
}

define double @simm7fp_64(double %a) {
; CHECK-LABEL: simm7fp_64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 64
; CHECK-NEXT:    lea.sl %s1, (, %s1)
; CHECK-NEXT:    fsub.d %s0, %s1, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %res = fsub double 0x0000000000000040, %a
  ret double %res
}

define double @simm7fp_m1(double %a) {
; CHECK-LABEL: simm7fp_m1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fsub.d %s0, -1, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %res = fsub double 0xFFFFFFFFFFFFFFFF, %a
  ret double %res
}

define double @simm7fp_m2(double %a) {
; CHECK-LABEL: simm7fp_m2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fsub.d %s0, -2, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %res = fsub double 0xFFFFFFFFFFFFFFFE, %a
  ret double %res
}

define double @simm7fp_m64(double %a) {
; CHECK-LABEL: simm7fp_m64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fsub.d %s0, -64, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %res = fsub double 0xFFFFFFFFFFFFFFC0, %a
  ret double %res
}

define double @simm7fp_m65(double %a) {
; CHECK-LABEL: simm7fp_m65:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, -65
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, -1(, %s1)
; CHECK-NEXT:    fsub.d %s0, %s1, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %res = fsub double 0xFFFFFFFFFFFFFFBF, %a
  ret double %res
}
