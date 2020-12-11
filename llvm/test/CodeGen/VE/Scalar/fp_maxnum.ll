; RUN: llc < %s -mtriple=ve | FileCheck %s

; Function Attrs: nounwind readnone
define float @func_fp_fmaxf_var_float(float %0, float %1) {
; CHECK-LABEL: func_fp_fmaxf_var_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmax.s %s0, %s0, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = tail call float @llvm.maxnum.f32(float %0, float %1)
  ret float %3
}

; Function Attrs: nounwind readnone speculatable willreturn
declare float @llvm.maxnum.f32(float, float)

; Function Attrs: nounwind readnone
define double @func_fp_fmax_var_double(double %0, double %1) {
; CHECK-LABEL: func_fp_fmax_var_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmax.d %s0, %s0, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = tail call double @llvm.maxnum.f64(double %0, double %1)
  ret double %3
}

; Function Attrs: nounwind readnone speculatable willreturn
declare double @llvm.maxnum.f64(double, double)

; Function Attrs: nounwind readnone
define fp128 @func_fp_fmaxl_var_quad(fp128 %0, fp128 %1) {
; CHECK-LABEL: func_fp_fmaxl_var_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s4, fmaxl@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s12, fmaxl@hi(, %s4)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call fp128 @llvm.maxnum.f128(fp128 %0, fp128 %1)
  ret fp128 %3
}

; Function Attrs: nounwind readnone speculatable willreturn
declare fp128 @llvm.maxnum.f128(fp128, fp128)

; Function Attrs: nounwind readnone
define float @func_fp_fmaxf_zero_float(float %0) {
; CHECK-LABEL: func_fp_fmaxf_zero_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmax.s %s0, %s0, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = tail call float @llvm.maxnum.f32(float %0, float 0.000000e+00)
  ret float %2
}

; Function Attrs: nounwind readnone
define double @func_fp_fmax_zero_double(double %0) {
; CHECK-LABEL: func_fp_fmax_zero_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmax.d %s0, %s0, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = tail call double @llvm.maxnum.f64(double %0, double 0.000000e+00)
  ret double %2
}

; Function Attrs: nounwind readnone
define fp128 @func_fp_fmaxl_zero_quad(fp128 %0) {
; CHECK-LABEL: func_fp_fmaxl_zero_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s2)
; CHECK-NEXT:    ld %s2, 8(, %s4)
; CHECK-NEXT:    ld %s3, (, %s4)
; CHECK-NEXT:    lea %s4, fmaxl@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s12, fmaxl@hi(, %s4)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call fp128 @llvm.maxnum.f128(fp128 %0, fp128 0xL00000000000000000000000000000000)
  ret fp128 %2
}

; Function Attrs: nounwind readnone
define float @func_fp_fmaxf_const_float(float %0) {
; CHECK-LABEL: func_fp_fmaxf_const_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmax.s %s0, %s0, (2)1
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = tail call float @llvm.maxnum.f32(float %0, float -2.000000e+00)
  ret float %2
}

; Function Attrs: nounwind readnone
define double @func_fp_fmax_const_double(double %0) {
; CHECK-LABEL: func_fp_fmax_const_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmax.d %s0, %s0, (2)1
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = tail call double @llvm.maxnum.f64(double %0, double -2.000000e+00)
  ret double %2
}

; Function Attrs: nounwind readnone
define fp128 @func_fp_fmaxl_const_quad(fp128 %0) {
; CHECK-LABEL: func_fp_fmaxl_const_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s2)
; CHECK-NEXT:    ld %s2, 8(, %s4)
; CHECK-NEXT:    ld %s3, (, %s4)
; CHECK-NEXT:    lea %s4, fmaxl@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s12, fmaxl@hi(, %s4)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call fp128 @llvm.maxnum.f128(fp128 %0, fp128 0xL0000000000000000C000000000000000)
  ret fp128 %2
}
