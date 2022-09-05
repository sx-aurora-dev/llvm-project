; RUN: llc < %s -mtriple=ve | FileCheck %s

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define float @func_fp_exp_var_float(float noundef %0) {
; CHECK-LABEL: func_fp_exp_var_float:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, expf@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, expf@hi(, %s1)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call fast float @llvm.exp.f32(float %0)
  ret float %2
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind readnone speculatable willreturn
declare float @llvm.exp.f32(float)

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define double @func_fp_exp_var_double(double noundef %0) {
; CHECK-LABEL: func_fp_exp_var_double:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, exp@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, exp@hi(, %s1)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call fast double @llvm.exp.f64(double %0)
  ret double %2
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind readnone speculatable willreturn
declare double @llvm.exp.f64(double)

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define fp128 @func_fp_exp_var_quad(fp128 noundef %0) {
; CHECK-LABEL: func_fp_exp_var_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, expl@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, expl@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call fast fp128 @llvm.exp.f128(fp128 %0)
  ret fp128 %2
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind readnone speculatable willreturn
declare fp128 @llvm.exp.f128(fp128)

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define float @func_fp_exp_zero_float() {
; CHECK-LABEL: func_fp_exp_zero_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s0, 1065353216
; CHECK-NEXT:    b.l.t (, %s10)
  ret float 1.000000e+00
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define double @func_fp_exp_zero_double() {
; CHECK-LABEL: func_fp_exp_zero_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s0, 1072693248
; CHECK-NEXT:    b.l.t (, %s10)
  ret double 1.000000e+00
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define fp128 @func_fp_exp_zero_quad() {
; CHECK-LABEL: func_fp_exp_zero_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s2)
; CHECK-NEXT:    ld %s1, (, %s2)
; CHECK-NEXT:    lea %s2, expl@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, expl@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call fast fp128 @llvm.exp.f128(fp128 0xL00000000000000000000000000000000)
  ret fp128 %1
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define float @func_fp_exp_const_float() {
; CHECK-LABEL: func_fp_exp_const_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s0, 1040880981
; CHECK-NEXT:    b.l.t (, %s10)
  ret float 0x3FC152AAA0000000
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define double @func_fp_exp_const_double() {
; CHECK-LABEL: func_fp_exp_const_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, -1547730484
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, 1069634218(, %s0)
; CHECK-NEXT:    b.l.t (, %s10)
  ret double 0x3FC152AAA3BF81CC
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define fp128 @func_fp_exp_const_quad() {
; CHECK-LABEL: func_fp_exp_const_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s2)
; CHECK-NEXT:    ld %s1, (, %s2)
; CHECK-NEXT:    lea %s2, expl@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, expl@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call fast fp128 @llvm.exp.f128(fp128 0xL0000000000000000C000000000000000)
  ret fp128 %1
}
