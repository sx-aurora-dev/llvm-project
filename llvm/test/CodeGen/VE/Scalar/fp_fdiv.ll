; RUN: llc < %s -mtriple=ve | FileCheck %s

;;; Test ‘fdiv’ Instruction
;;;
;;; Syntax:
;;;   <result> = fdiv [fast-math flags]* <ty> <op1>, <op2> ; yields ty:result
;;;
;;; Overview:
;;;   The ‘fdiv’ instruction returns the quotient of its two operands.
;;;
;;; Arguments:
;;;   The two arguments to the ‘fdiv’ instruction must be floating-point or
;;;   vector of floating-point values. Both arguments must have identical types.
;;;
;;; Semantics:
;;;   The value produced is the floating-point quotient of the two operands.
;;;   This instruction is assumed to execute in the default floating-point
;;;   environment. This instruction can also take any number of fast-math
;;;   flags, which are optimization hints to enable otherwise unsafe
;;;   floating-point optimizations:
;;;
;;; Example:
;;;   <result> = fdiv float 4.0, %var ; yields float:result = 4.0 / %var
;;;
;;; Note:
;;;   We test only float/double/fp128.

; Function Attrs: norecurse nounwind readnone
define float @fdiv_float_var(float %0, float %1) {
; CHECK-LABEL: fdiv_float_var:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fdiv.s %s0, %s0, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fdiv float %0, %1
  ret float %3
}

; Function Attrs: norecurse nounwind readnone
define double @fdiv_double_var(double %0, double %1) {
; CHECK-LABEL: fdiv_double_var:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fdiv.d %s0, %s0, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fdiv double %0, %1
  ret double %3
}

; Function Attrs: norecurse nounwind readnone
define fp128 @fdiv_quad_var(fp128 %0, fp128 %1) {
; CHECK-LABEL: fdiv_quad_var:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s4, __divtf3@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s12, __divtf3@hi(, %s4)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = fdiv fp128 %0, %1
  ret fp128 %3
}

; Function Attrs: norecurse nounwind readnone
define float @fdiv_float_zero_fore(float %0) {
; CHECK-LABEL: fdiv_float_zero_fore:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fdiv.s %s0, 0, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fdiv float 0.000000e+00, %0
  ret float %2
}

; Function Attrs: norecurse nounwind readnone
define double @fdiv_double_zero_fore(double %0) {
; CHECK-LABEL: fdiv_double_zero_fore:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fdiv.d %s0, 0, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fdiv double 0.000000e+00, %0
  ret double %2
}

; Function Attrs: norecurse nounwind readnone
define fp128 @fdiv_quad_zero_fore(fp128 %0) {
; CHECK-LABEL: fdiv_quad_zero_fore:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    or %s3, 0, %s1
; CHECK-NEXT:    lea %s0, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s4)
; CHECK-NEXT:    ld %s1, (, %s4)
; CHECK-NEXT:    lea %s4, __divtf3@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s12, __divtf3@hi(, %s4)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fdiv fp128 0xL00000000000000000000000000000000, %0
  ret fp128 %2
}

; Function Attrs: norecurse nounwind readnone
define float @fdiv_float_const_back(float %0) {
; CHECK-LABEL: fdiv_float_const_back:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s1, -1090519040
; CHECK-NEXT:    fmul.s %s0, %s0, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fmul float %0, -5.000000e-01
  ret float %2
}

; Function Attrs: norecurse nounwind readnone
define double @fdiv_double_const_back(double %0) {
; CHECK-LABEL: fdiv_double_const_back:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s1, -1075838976
; CHECK-NEXT:    fmul.d %s0, %s0, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fmul double %0, -5.000000e-01
  ret double %2
}

; Function Attrs: norecurse nounwind readnone
define fp128 @fdiv_quad_const_back(fp128 %0) {
; CHECK-LABEL: fdiv_quad_const_back:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s2, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s2)
; CHECK-NEXT:    ld %s4, 8(, %s2)
; CHECK-NEXT:    ld %s5, (, %s2)
; CHECK-NEXT:    fmul.q %s0, %s0, %s4
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fmul fp128 %0, 0xL0000000000000000BFFE000000000000
  ret fp128 %2
}

; Function Attrs: norecurse nounwind readnone
define float @fdiv_float_cont_fore(float %0) {
; CHECK-LABEL: fdiv_float_cont_fore:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s1, -1073741824
; CHECK-NEXT:    fdiv.s %s0, %s1, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fdiv float -2.000000e+00, %0
  ret float %2
}

; Function Attrs: norecurse nounwind readnone
define double @fdiv_double_cont_fore(double %0) {
; CHECK-LABEL: fdiv_double_cont_fore:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s1, -1073741824
; CHECK-NEXT:    fdiv.d %s0, %s1, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fdiv double -2.000000e+00, %0
  ret double %2
}

; Function Attrs: norecurse nounwind readnone
define fp128 @fdiv_quad_cont_fore(fp128 %0) {
; CHECK-LABEL: fdiv_quad_cont_fore:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    or %s3, 0, %s1
; CHECK-NEXT:    lea %s0, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s4)
; CHECK-NEXT:    ld %s1, (, %s4)
; CHECK-NEXT:    lea %s4, __divtf3@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s12, __divtf3@hi(, %s4)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fdiv fp128 0xL0000000000000000C000000000000000, %0
  ret fp128 %2
}
