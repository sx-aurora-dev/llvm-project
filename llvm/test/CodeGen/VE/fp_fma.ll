; RUN: llc < %s -mtriple=ve | FileCheck %s

; Function Attrs: nounwind readnone
define float @func_fp_fmaf_var_float(float %0, float %1, float %2) {
; CHECK-LABEL: func_fp_fmaf_var_float:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s3, fmaf@lo
; CHECK-NEXT:    and %s3, %s3, (32)0
; CHECK-NEXT:    lea.sl %s12, fmaf@hi(, %s3)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %4 = tail call float @llvm.fma.f32(float %0, float %1, float %2)
  ret float %4
}

; Function Attrs: nounwind readnone speculatable willreturn
declare float @llvm.fma.f32(float, float, float)

; Function Attrs: nounwind readnone
define double @func_fp_fma_var_double(double %0, double %1, double %2) {
; CHECK-LABEL: func_fp_fma_var_double:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s3, fma@lo
; CHECK-NEXT:    and %s3, %s3, (32)0
; CHECK-NEXT:    lea.sl %s12, fma@hi(, %s3)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %4 = tail call double @llvm.fma.f64(double %0, double %1, double %2)
  ret double %4
}

; Function Attrs: nounwind readnone speculatable willreturn
declare double @llvm.fma.f64(double, double, double)

; Function Attrs: nounwind readnone
define fp128 @func_fp_fmal_var_quad(fp128 %0, fp128 %1, fp128 %2) {
; CHECK-LABEL: func_fp_fmal_var_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s6, fmal@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s12, fmal@hi(, %s6)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %4 = tail call fp128 @llvm.fma.f128(fp128 %0, fp128 %1, fp128 %2)
  ret fp128 %4
}

; Function Attrs: nounwind readnone speculatable willreturn
declare fp128 @llvm.fma.f128(fp128, fp128, fp128)

; Function Attrs: nounwind readnone
define float @func_fp_fmaf_zero_fore_float(float %0, float %1) {
; CHECK-LABEL: func_fp_fmaf_zero_fore_float:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s2, 0, %s1
; CHECK-NEXT:    lea.sl %s1, 0
; CHECK-NEXT:    lea %s3, fmaf@lo
; CHECK-NEXT:    and %s3, %s3, (32)0
; CHECK-NEXT:    lea.sl %s12, fmaf@hi(, %s3)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call float @llvm.fma.f32(float %0, float 0.000000e+00, float %1)
  ret float %3
}

; Function Attrs: nounwind readnone
define double @func_fp_fma_zero_fore_double(double %0, double %1) {
; CHECK-LABEL: func_fp_fma_zero_fore_double:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s2, 0, %s1
; CHECK-NEXT:    lea %s1, fma@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, fma@hi(, %s1)
; CHECK-NEXT:    lea.sl %s1, 0
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call double @llvm.fma.f64(double %0, double 0.000000e+00, double %1)
  ret double %3
}

; Function Attrs: nounwind readnone
define fp128 @func_fp_fmal_zero_fore_quad(fp128 %0, fp128 %1) {
; CHECK-LABEL: func_fp_fmal_zero_fore_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s4, 0, %s2
; CHECK-NEXT:    or %s5, 0, %s3
; CHECK-NEXT:    lea %s2, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s2)
; CHECK-NEXT:    ld %s2, 8(, %s6)
; CHECK-NEXT:    ld %s3, (, %s6)
; CHECK-NEXT:    lea %s6, fmal@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s12, fmal@hi(, %s6)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call fp128 @llvm.fma.f128(fp128 %0, fp128 0xL00000000000000000000000000000000, fp128 %1)
  ret fp128 %3
}

; Function Attrs: nounwind readnone
define float @func_fp_fmaf_zero_back_float(float %0, float %1) {
; CHECK-LABEL: func_fp_fmaf_zero_back_float:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s2, 0
; CHECK-NEXT:    lea %s3, fmaf@lo
; CHECK-NEXT:    and %s3, %s3, (32)0
; CHECK-NEXT:    lea.sl %s12, fmaf@hi(, %s3)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call float @llvm.fma.f32(float %0, float %1, float 0.000000e+00)
  ret float %3
}

; Function Attrs: nounwind readnone
define double @func_fp_fma_zero_back_double(double %0, double %1) {
; CHECK-LABEL: func_fp_fma_zero_back_double:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, fma@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, fma@hi(, %s2)
; CHECK-NEXT:    lea.sl %s2, 0
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call double @llvm.fma.f64(double %0, double %1, double 0.000000e+00)
  ret double %3
}

; Function Attrs: nounwind readnone
define fp128 @func_fp_fmal_zero_back_quad(fp128 %0, fp128 %1) {
; CHECK-LABEL: func_fp_fmal_zero_back_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s4, 8(, %s6)
; CHECK-NEXT:    ld %s5, (, %s6)
; CHECK-NEXT:    lea %s6, fmal@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s12, fmal@hi(, %s6)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call fp128 @llvm.fma.f128(fp128 %0, fp128 %1, fp128 0xL00000000000000000000000000000000)
  ret fp128 %3
}

; Function Attrs: nounwind readnone
define float @func_fp_fmaf_const_fore_float(float %0, float %1) {
; CHECK-LABEL: func_fp_fmaf_const_fore_float:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s2, 0, %s1
; CHECK-NEXT:    lea.sl %s1, -1073741824
; CHECK-NEXT:    lea %s3, fmaf@lo
; CHECK-NEXT:    and %s3, %s3, (32)0
; CHECK-NEXT:    lea.sl %s12, fmaf@hi(, %s3)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call float @llvm.fma.f32(float %0, float -2.000000e+00, float %1)
  ret float %3
}

; Function Attrs: nounwind readnone
define double @func_fp_fma_const_fore_double(double %0, double %1) {
; CHECK-LABEL: func_fp_fma_const_fore_double:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s2, 0, %s1
; CHECK-NEXT:    lea %s1, fma@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, fma@hi(, %s1)
; CHECK-NEXT:    lea.sl %s1, -1073741824
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call double @llvm.fma.f64(double %0, double -2.000000e+00, double %1)
  ret double %3
}

; Function Attrs: nounwind readnone
define fp128 @func_fp_fmal_const_fore_quad(fp128 %0, fp128 %1) {
; CHECK-LABEL: func_fp_fmal_const_fore_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s4, 0, %s2
; CHECK-NEXT:    or %s5, 0, %s3
; CHECK-NEXT:    lea %s2, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s2)
; CHECK-NEXT:    ld %s2, 8(, %s6)
; CHECK-NEXT:    ld %s3, (, %s6)
; CHECK-NEXT:    lea %s6, fmal@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s12, fmal@hi(, %s6)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call fp128 @llvm.fma.f128(fp128 %0, fp128 0xL0000000000000000C000000000000000, fp128 %1)
  ret fp128 %3
}

; Function Attrs: nounwind readnone
define float @func_fp_fmaf_const_back_float(float %0, float %1) {
; CHECK-LABEL: func_fp_fmaf_const_back_float:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s2, -1073741824
; CHECK-NEXT:    lea %s3, fmaf@lo
; CHECK-NEXT:    and %s3, %s3, (32)0
; CHECK-NEXT:    lea.sl %s12, fmaf@hi(, %s3)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call float @llvm.fma.f32(float %0, float %1, float -2.000000e+00)
  ret float %3
}

; Function Attrs: nounwind readnone
define double @func_fp_fma_const_back_double(double %0, double %1) {
; CHECK-LABEL: func_fp_fma_const_back_double:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, fma@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, fma@hi(, %s2)
; CHECK-NEXT:    lea.sl %s2, -1073741824
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call double @llvm.fma.f64(double %0, double %1, double -2.000000e+00)
  ret double %3
}

; Function Attrs: nounwind readnone
define fp128 @func_fp_fmal_const_BACK_quad(fp128 %0, fp128 %1) {
; CHECK-LABEL: func_fp_fmal_const_BACK_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s4, 8(, %s6)
; CHECK-NEXT:    ld %s5, (, %s6)
; CHECK-NEXT:    lea %s6, fmal@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s12, fmal@hi(, %s6)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call fp128 @llvm.fma.f128(fp128 %0, fp128 %1, fp128 0xL0000000000000000C000000000000000)
  ret fp128 %3
}
