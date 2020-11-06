; RUN: llc < %s -mtriple=ve | FileCheck %s

; Function Attrs: nounwind
define float @func_fp_lrintf_var_float(float %0) {
; CHECK-LABEL: func_fp_lrintf_var_float:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, lrintf@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, lrintf@hi(, %s1)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    cvt.d.l %s0, %s0
; CHECK-NEXT:    cvt.s.d %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i64 @lrintf(float %0)
  %3 = sitofp i64 %2 to float
  ret float %3
}

; Function Attrs: nounwind
declare i64 @lrintf(float)

; Function Attrs: nounwind
define double @func_fp_lrint_var_double(double %0) {
; CHECK-LABEL: func_fp_lrint_var_double:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, lrint@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, lrint@hi(, %s1)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    cvt.d.l %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i64 @lrint(double %0)
  %3 = sitofp i64 %2 to double
  ret double %3
}

; Function Attrs: nounwind
declare i64 @lrint(double)

; Function Attrs: nounwind
define fp128 @func_fp_lrintl_var_quad(fp128 %0) {
; CHECK-LABEL: func_fp_lrintl_var_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, lrintl@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, lrintl@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    cvt.d.l %s0, %s0
; CHECK-NEXT:    cvt.q.d %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i64 @lrintl(fp128 %0)
  %3 = sitofp i64 %2 to fp128
  ret fp128 %3
}

; Function Attrs: nounwind
declare i64 @lrintl(fp128)

; Function Attrs: nounwind
define float @func_fp_lrintf_zero_float() {
; CHECK-LABEL: func_fp_lrintf_zero_float:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, lrintf@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, lrintf@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    cvt.d.l %s0, %s0
; CHECK-NEXT:    cvt.s.d %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call i64 @lrintf(float 0.000000e+00)
  %2 = sitofp i64 %1 to float
  ret float %2
}

; Function Attrs: nounwind
define double @func_fp_LRINT_zero_double() {
; CHECK-LABEL: func_fp_LRINT_zero_double:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, lrint@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, lrint@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    cvt.d.l %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call i64 @lrint(double 0.000000e+00)
  %2 = sitofp i64 %1 to double
  ret double %2
}

; Function Attrs: nounwind
define fp128 @func_fp_lrintl_zero_quad() {
; CHECK-LABEL: func_fp_lrintl_zero_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s2)
; CHECK-NEXT:    ld %s1, (, %s2)
; CHECK-NEXT:    lea %s2, lrintl@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, lrintl@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    cvt.d.l %s0, %s0
; CHECK-NEXT:    cvt.q.d %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call i64 @lrintl(fp128 0xL00000000000000000000000000000000)
  %2 = sitofp i64 %1 to fp128
  ret fp128 %2
}

; Function Attrs: nounwind
define float @func_fp_lrintf_const_float() {
; CHECK-LABEL: func_fp_lrintf_const_float:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, lrintf@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, lrintf@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, -1073741824
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    cvt.d.l %s0, %s0
; CHECK-NEXT:    cvt.s.d %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call i64 @lrintf(float -2.000000e+00)
  %2 = sitofp i64 %1 to float
  ret float %2
}

; Function Attrs: nounwind
define double @func_fp_lrint_const_double() {
; CHECK-LABEL: func_fp_lrint_const_double:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, lrint@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, lrint@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, -1073741824
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    cvt.d.l %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call i64 @lrint(double -2.000000e+00)
  %2 = sitofp i64 %1 to double
  ret double %2
}

; Function Attrs: nounwind
define fp128 @func_fp_lrintl_const_quad() {
; CHECK-LABEL: func_fp_lrintl_const_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s2)
; CHECK-NEXT:    ld %s1, (, %s2)
; CHECK-NEXT:    lea %s2, lrintl@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, lrintl@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    cvt.d.l %s0, %s0
; CHECK-NEXT:    cvt.q.d %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call i64 @lrintl(fp128 0xL0000000000000000C000000000000000)
  %2 = sitofp i64 %1 to fp128
  ret fp128 %2
}
