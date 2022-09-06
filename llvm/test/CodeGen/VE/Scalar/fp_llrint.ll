; RUN: llc < %s -mtriple=ve | FileCheck %s

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define i64 @func_fp_llrint_var_float(float noundef %0) {
; CHECK-LABEL: func_fp_llrint_var_float:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, llrintf@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, llrintf@hi(, %s1)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i64 @llvm.llrint.i64.f32(float %0)
  ret i64 %2
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind readnone speculatable willreturn
declare i64 @llvm.llrint.i64.f32(float)

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define i64 @func_fp_llrint_var_double(double noundef %0) {
; CHECK-LABEL: func_fp_llrint_var_double:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, llrint@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, llrint@hi(, %s1)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i64 @llvm.llrint.i64.f64(double %0)
  ret i64 %2
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind readnone speculatable willreturn
declare i64 @llvm.llrint.i64.f64(double)

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define i64 @func_fp_llrint_var_quad(fp128 noundef %0) {
; CHECK-LABEL: func_fp_llrint_var_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, llrintl@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, llrintl@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i64 @llvm.llrint.i64.f128(fp128 %0)
  ret i64 %2
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind readnone speculatable willreturn
declare i64 @llvm.llrint.i64.f128(fp128)

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define i64 @func_fp_llrint_zero_float() {
; CHECK-LABEL: func_fp_llrint_zero_float:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, llrintf@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, llrintf@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call i64 @llvm.llrint.i64.f32(float 0.000000e+00)
  ret i64 %1
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define i64 @func_fp_llrint_zero_double() {
; CHECK-LABEL: func_fp_llrint_zero_double:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, llrint@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, llrint@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call i64 @llvm.llrint.i64.f64(double 0.000000e+00)
  ret i64 %1
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define i64 @func_fp_llrint_zero_quad() {
; CHECK-LABEL: func_fp_llrint_zero_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s2)
; CHECK-NEXT:    ld %s1, (, %s2)
; CHECK-NEXT:    lea %s2, llrintl@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, llrintl@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call i64 @llvm.llrint.i64.f128(fp128 0xL00000000000000000000000000000000)
  ret i64 %1
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define i64 @func_fp_llrint_const_float() {
; CHECK-LABEL: func_fp_llrint_const_float:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, llrintf@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, llrintf@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, -1073741824
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call i64 @llvm.llrint.i64.f32(float -2.000000e+00)
  ret i64 %1
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define i64 @func_fp_llrint_const_double() {
; CHECK-LABEL: func_fp_llrint_const_double:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, llrint@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, llrint@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, -1073741824
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call i64 @llvm.llrint.i64.f64(double -2.000000e+00)
  ret i64 %1
}

; Function Attrs: mustprogress nofree nosync nounwind readnone willreturn
define i64 @func_fp_llrint_const_quad() {
; CHECK-LABEL: func_fp_llrint_const_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s2)
; CHECK-NEXT:    ld %s1, (, %s2)
; CHECK-NEXT:    lea %s2, llrintl@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, llrintl@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call i64 @llvm.llrint.i64.f128(fp128 0xL0000000000000000C000000000000000)
  ret i64 %1
}
