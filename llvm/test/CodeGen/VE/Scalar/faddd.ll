; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define double @faddd(double, double) {
; CHECK-LABEL: faddd:
; CHECK:       .LBB0_2:
; CHECK-NEXT:    fadd.d %s0, %s0, %s1
  %3 = fadd double %0, %1
  ret double %3
}
