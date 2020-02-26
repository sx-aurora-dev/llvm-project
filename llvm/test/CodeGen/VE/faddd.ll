; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define double @faddd(double, double) {
; CHECK-LABEL: faddd:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fadd.d %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = fadd double %0, %1
  ret double %3
}
