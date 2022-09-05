; RUN: llc < %s -mtriple=ve | FileCheck %s

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define float @func_fp_log_var_float(float noundef %0) {
; CHECK-LABEL: func_fp_log_var_float:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, logf@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, logf@hi(, %s1)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call fast float @llvm.log.f32(float %0)
  ret float %2
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind readnone speculatable willreturn
declare float @llvm.log.f32(float)

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define double @func_fp_log_var_double(double noundef %0) {
; CHECK-LABEL: func_fp_log_var_double:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, log@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, log@hi(, %s1)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call fast double @llvm.log.f64(double %0)
  ret double %2
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind readnone speculatable willreturn
declare double @llvm.log.f64(double)

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define fp128 @func_fp_log_var_quad(fp128 noundef %0) {
; CHECK-LABEL: func_fp_log_var_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, logl@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, logl@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call fast fp128 @llvm.log.f128(fp128 %0)
  ret fp128 %2
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind readnone speculatable willreturn
declare fp128 @llvm.log.f128(fp128)

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define float @func_fp_log_zero_float() {
; CHECK-LABEL: func_fp_log_zero_float:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, logf@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, logf@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call fast float @llvm.log.f32(float 0.000000e+00)
  ret float %1
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define double @func_fp_log_zero_double() {
; CHECK-LABEL: func_fp_log_zero_double:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, log@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, log@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call fast double @llvm.log.f64(double 0.000000e+00)
  ret double %1
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define fp128 @func_fp_log_zero_quad() {
; CHECK-LABEL: func_fp_log_zero_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s2)
; CHECK-NEXT:    ld %s1, (, %s2)
; CHECK-NEXT:    lea %s2, logl@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, logl@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call fast fp128 @llvm.log.f128(fp128 0xL00000000000000000000000000000000)
  ret fp128 %1
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define float @func_fp_log_const_float() {
; CHECK-LABEL: func_fp_log_const_float:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, logf@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, logf@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, -1073741824
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call fast float @llvm.log.f32(float -2.000000e+00)
  ret float %1
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define double @func_fp_log_const_double() {
; CHECK-LABEL: func_fp_log_const_double:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, log@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, log@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, -1073741824
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call fast double @llvm.log.f64(double -2.000000e+00)
  ret double %1
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define fp128 @func_fp_log_const_quad() {
; CHECK-LABEL: func_fp_log_const_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s2)
; CHECK-NEXT:    ld %s1, (, %s2)
; CHECK-NEXT:    lea %s2, logl@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, logl@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call fast fp128 @llvm.log.f128(fp128 0xL0000000000000000C000000000000000)
  ret fp128 %1
}
