;; Test that a backend correctly handles mimm.

; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define double @mimm_0000000000000000(double %a) {
; CHECK-LABEL: mimm_0000000000000000:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fadd.d %s0, 0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %res = fadd double %a, 0x0000000000000000
  ret double %res
}

define double @mimm_0000000000000001(double %a) {
; CHECK-LABEL: mimm_0000000000000001:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fadd.d %s0, %s0, (63)0
; CHECK-NEXT:    or %s11, 0, %s9
  %res = fadd double %a, 0x0000000000000001
  ret double %res
}

define double @mimm_0000000000000003(double %a) {
; CHECK-LABEL: mimm_0000000000000003:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fadd.d %s0, %s0, (62)0
; CHECK-NEXT:    or %s11, 0, %s9
  %res = fadd double %a, 0x0000000000000003
  ret double %res
}

define double @mimm_000000000000007F(double %a) {
; CHECK-LABEL: mimm_000000000000007F:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fadd.d %s0, %s0, (57)0
; CHECK-NEXT:    or %s11, 0, %s9
  %res = fadd double %a, 0x000000000000007F
  ret double %res
}

define double @mimm_00000000000000FF(double %a) {
; CHECK-LABEL: mimm_00000000000000FF:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fadd.d %s0, %s0, (56)0
; CHECK-NEXT:    or %s11, 0, %s9
  %res = fadd double %a, 0x00000000000000FF
  ret double %res
}

define double @mimm_000000000000FFFF(double %a) {
; CHECK-LABEL: mimm_000000000000FFFF:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fadd.d %s0, %s0, (48)0
; CHECK-NEXT:    or %s11, 0, %s9
  %res = fadd double %a, 0x000000000000FFFF
  ret double %res
}

define double @mimm_000000FFFFFFFFFF(double %a) {
; CHECK-LABEL: mimm_000000FFFFFFFFFF
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fadd.d %s0, %s0, (24)0
; CHECK-NEXT:    or %s11, 0, %s9
  %res = fadd double %a, 0x000000FFFFFFFFFF
  ret double %res
}

define double @mimm_7FFFFFFFFFFFFFFF(double %a) {
; CHECK-LABEL: mimm_7FFFFFFFFFFFFFFF:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fadd.d %s0, %s0, (1)0
; CHECK-NEXT:    or %s11, 0, %s9
  %res = fadd double %a, 0x7FFFFFFFFFFFFFFF
  ret double %res
}

define double @mimm_FFFFFFFFFFFFFFFF(double %a) {
; CHECK-LABEL: mimm_FFFFFFFFFFFFFFFF:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fadd.d %s0, %s0, (0)0
; CHECK-NEXT:    or %s11, 0, %s9
  %res = fadd double %a, 0xFFFFFFFFFFFFFFFF
  ret double %res
}

define double @mimm_FFFFFFFFFFFFFFFE(double %a) {
; CHECK-LABEL: mimm_FFFFFFFFFFFFFFFE:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fadd.d %s0, %s0, (63)1
; CHECK-NEXT:    or %s11, 0, %s9
  %res = fadd double %a, 0xFFFFFFFFFFFFFFFE
  ret double %res
}

define double @mimm_FFFFFFFFFFFFFFFC(double %a) {
; CHECK-LABEL: mimm_FFFFFFFFFFFFFFFC:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fadd.d %s0, %s0, (62)1
; CHECK-NEXT:    or %s11, 0, %s9
  %res = fadd double %a, 0xFFFFFFFFFFFFFFFC
  ret double %res
}

define double @mimm_FFFFFFFFFFFFFF80(double %a) {
; CHECK-LABEL: mimm_FFFFFFFFFFFFFF80:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fadd.d %s0, %s0, (57)1
; CHECK-NEXT:    or %s11, 0, %s9
  %res = fadd double %a, 0xFFFFFFFFFFFFFF80
  ret double %res
}

define double @mimm_FFFFFFF000000000(double %a) {
; CHECK-LABEL: mimm_FFFFFFF000000000:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fadd.d %s0, %s0, (28)1
; CHECK-NEXT:    or %s11, 0, %s9
  %res = fadd double %a, 0xFFFFFFF000000000
  ret double %res
}

define double @mimm_C000000000000000(double %a) {
; CHECK-LABEL: mimm_C000000000000000:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fadd.d %s0, %s0, (2)1
; CHECK-NEXT:    or %s11, 0, %s9
  %res = fadd double %a, -2.0
  ret double %res
}

define double @mimm_8000000000000000(double %a) {
; CHECK-LABEL: mimm_8000000000000000:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s0, -2147483648
; CHECK-NEXT:    or %s11, 0, %s9
  ret double -0.0
}
