; RUN: llc < %s -mtriple=ve | FileCheck %s

; Function Attrs: nounwind readnone
define float @func_fp_copysignf_var_float(float %0, float %1) {
; CHECK-LABEL: func_fp_copysignf_var_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    sra.l %s1, %s1, 32
; CHECK-NEXT:    lea %s2, -2147483648
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    and %s1, %s1, %s2
; CHECK-NEXT:    sra.l %s0, %s0, 32
; CHECK-NEXT:    and %s0, %s0, (33)0
; CHECK-NEXT:    or %s0, %s0, %s1
; CHECK-NEXT:    sll %s0, %s0, 32
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = tail call float @llvm.copysign.f32(float %0, float %1)
  ret float %3
}

; Function Attrs: nounwind readnone speculatable willreturn
declare float @llvm.copysign.f32(float, float)

; Function Attrs: nounwind readnone
define double @func_fp_copysign_var_double(double %0, double %1) {
; CHECK-LABEL: func_fp_copysign_var_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s1, %s1, (1)1
; CHECK-NEXT:    and %s0, %s0, (1)0
; CHECK-NEXT:    or %s0, %s0, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = tail call double @llvm.copysign.f64(double %0, double %1)
  ret double %3
}

; Function Attrs: nounwind readnone speculatable willreturn
declare double @llvm.copysign.f64(double, double)

; Function Attrs: nounwind readnone
define fp128 @func_fp_copysignl_var_quad(fp128 %0, fp128 %1) {
; CHECK-LABEL: func_fp_copysignl_var_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    st %s3, -16(, %s9)
; CHECK-NEXT:    st %s2, -8(, %s9)
; CHECK-NEXT:    st %s1, -32(, %s9)
; CHECK-NEXT:    st %s0, -24(, %s9)
; CHECK-NEXT:    ld1b.zx %s0, -1(, %s9)
; CHECK-NEXT:    ld1b.zx %s1, -17(, %s9)
; CHECK-NEXT:    lea %s2, 128
; CHECK-NEXT:    and %s0, %s0, %s2
; CHECK-NEXT:    and %s1, %s1, (57)0
; CHECK-NEXT:    or %s0, %s1, %s0
; CHECK-NEXT:    st1b %s0, -17(, %s9)
; CHECK-NEXT:    ld %s1, -32(, %s9)
; CHECK-NEXT:    ld %s0, -24(, %s9)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call fp128 @llvm.copysign.f128(fp128 %0, fp128 %1)
  ret fp128 %3
}

; Function Attrs: nounwind readnone speculatable willreturn
declare fp128 @llvm.copysign.f128(fp128, fp128)

; Function Attrs: nounwind readnone
define float @func_fp_copysignf_zero_float(float %0) {
; CHECK-LABEL: func_fp_copysignf_zero_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    sra.l %s0, %s0, 32
; CHECK-NEXT:    lea %s1, -2147483648
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    and %s0, %s0, %s1
; CHECK-NEXT:    sll %s0, %s0, 32
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = tail call float @llvm.copysign.f32(float 0.000000e+00, float %0)
  ret float %2
}

; Function Attrs: nounwind readnone
define double @func_fp_copysign_zero_double(double %0) {
; CHECK-LABEL: func_fp_copysign_zero_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (1)1
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = tail call double @llvm.copysign.f64(double 0.000000e+00, double %0)
  ret double %2
}

; Function Attrs: nounwind readnone
define fp128 @func_fp_copysignl_zero_quad(fp128 %0) {
; CHECK-LABEL: func_fp_copysignl_zero_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s2)
; CHECK-NEXT:    ld %s4, 8(, %s2)
; CHECK-NEXT:    ld %s5, (, %s2)
; CHECK-NEXT:    st %s1, -16(, %s9)
; CHECK-NEXT:    st %s0, -8(, %s9)
; CHECK-NEXT:    st %s5, -32(, %s9)
; CHECK-NEXT:    st %s4, -24(, %s9)
; CHECK-NEXT:    ld1b.zx %s0, -1(, %s9)
; CHECK-NEXT:    ld1b.zx %s1, -17(, %s9)
; CHECK-NEXT:    lea %s2, 128
; CHECK-NEXT:    and %s0, %s0, %s2
; CHECK-NEXT:    and %s1, %s1, (57)0
; CHECK-NEXT:    or %s0, %s1, %s0
; CHECK-NEXT:    st1b %s0, -17(, %s9)
; CHECK-NEXT:    ld %s1, -32(, %s9)
; CHECK-NEXT:    ld %s0, -24(, %s9)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call fp128 @llvm.copysign.f128(fp128 0xL00000000000000000000000000000000, fp128 %0)
  ret fp128 %2
}

; Function Attrs: nounwind readnone
define float @func_fp_copysignf_const_float(float %0) {
; CHECK-LABEL: func_fp_copysignf_const_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    sra.l %s0, %s0, 32
; CHECK-NEXT:    lea %s1, -2147483648
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    and %s0, %s0, %s1
; CHECK-NEXT:    lea %s1, 1073741824
; CHECK-NEXT:    or %s0, %s0, %s1
; CHECK-NEXT:    sll %s0, %s0, 32
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = tail call float @llvm.copysign.f32(float -2.000000e+00, float %0)
  ret float %2
}

; Function Attrs: nounwind readnone
define double @func_fp_copysign_const_double(double %0) {
; CHECK-LABEL: func_fp_copysign_const_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (1)1
; CHECK-NEXT:    lea.sl %s1, 1073741824
; CHECK-NEXT:    or %s0, %s0, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = tail call double @llvm.copysign.f64(double -2.000000e+00, double %0)
  ret double %2
}

; Function Attrs: nounwind readnone
define fp128 @func_fp_copysignl_const_quad(fp128 %0) {
; CHECK-LABEL: func_fp_copysignl_const_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s2)
; CHECK-NEXT:    ld %s4, 8(, %s2)
; CHECK-NEXT:    ld %s5, (, %s2)
; CHECK-NEXT:    st %s1, -16(, %s9)
; CHECK-NEXT:    st %s0, -8(, %s9)
; CHECK-NEXT:    st %s5, -32(, %s9)
; CHECK-NEXT:    st %s4, -24(, %s9)
; CHECK-NEXT:    ld1b.zx %s0, -1(, %s9)
; CHECK-NEXT:    ld1b.zx %s1, -17(, %s9)
; CHECK-NEXT:    lea %s2, 128
; CHECK-NEXT:    and %s0, %s0, %s2
; CHECK-NEXT:    and %s1, %s1, (57)0
; CHECK-NEXT:    or %s0, %s1, %s0
; CHECK-NEXT:    st1b %s0, -17(, %s9)
; CHECK-NEXT:    ld %s1, -32(, %s9)
; CHECK-NEXT:    ld %s0, -24(, %s9)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call fp128 @llvm.copysign.f128(fp128 0xL0000000000000000C000000000000000, fp128 %0)
  ret fp128 %2
}
