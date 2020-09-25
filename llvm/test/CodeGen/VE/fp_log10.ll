; RUN: llc < %s -mtriple=ve | FileCheck %s

; Function Attrs: nofree nounwind
define float @func_fp_log10f_var_float(float %0) {
; CHECK-LABEL: func_fp_log10f_var_float:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, log10f@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, log10f@hi(, %s1)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call float @log10f(float %0)
  ret float %2
}

; Function Attrs: nofree nounwind
declare float @log10f(float)

; Function Attrs: nofree nounwind
define double @func_fp_log10_var_double(double %0) {
; CHECK-LABEL: func_fp_log10_var_double:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, log10@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, log10@hi(, %s1)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call double @log10(double %0)
  ret double %2
}

; Function Attrs: nofree nounwind
declare double @log10(double)

; Function Attrs: nofree nounwind
define fp128 @func_fp_log10l_var_quad(fp128 %0) {
; CHECK-LABEL: func_fp_log10l_var_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, log10l@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, log10l@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call fp128 @log10l(fp128 %0)
  ret fp128 %2
}

; Function Attrs: nofree nounwind
declare fp128 @log10l(fp128)

; Function Attrs: nofree nounwind
define float @func_fp_log10f_zero_float() {
; CHECK-LABEL: func_fp_log10f_zero_float:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    lea %s1, log10f@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, log10f@hi(, %s1)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call float @log10f(float 0.000000e+00)
  ret float %1
}

; Function Attrs: nofree nounwind
define double @func_fp_LOG10_zero_double() {
; CHECK-LABEL: func_fp_LOG10_zero_double:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, log10@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, log10@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call double @log10(double 0.000000e+00)
  ret double %1
}

; Function Attrs: nofree nounwind
define fp128 @func_fp_log10l_zero_quad() {
; CHECK-LABEL: func_fp_log10l_zero_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s2)
; CHECK-NEXT:    ld %s1, (, %s2)
; CHECK-NEXT:    lea %s2, log10l@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, log10l@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call fp128 @log10l(fp128 0xL00000000000000000000000000000000)
  ret fp128 %1
}

; Function Attrs: nofree nounwind
define float @func_fp_log10f_const_float() {
; CHECK-LABEL: func_fp_log10f_const_float:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s0, -1073741824
; CHECK-NEXT:    lea %s1, log10f@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, log10f@hi(, %s1)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call float @log10f(float -2.000000e+00)
  ret float %1
}

; Function Attrs: nofree nounwind
define double @func_fp_log10_const_double() {
; CHECK-LABEL: func_fp_log10_const_double:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, log10@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, log10@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, -1073741824
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call double @log10(double -2.000000e+00)
  ret double %1
}

; Function Attrs: nofree nounwind
define fp128 @func_fp_log10l_const_quad() {
; CHECK-LABEL: func_fp_log10l_const_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s2)
; CHECK-NEXT:    ld %s1, (, %s2)
; CHECK-NEXT:    lea %s2, log10l@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, log10l@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call fp128 @log10l(fp128 0xL0000000000000000C000000000000000)
  ret fp128 %1
}
