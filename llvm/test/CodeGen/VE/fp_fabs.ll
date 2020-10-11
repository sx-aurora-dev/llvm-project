; RUN: llc < %s -mtriple=ve | FileCheck %s

; Function Attrs: nounwind readnone
define float @func_fp_fabsf_var_float(float %0) {
; CHECK-LABEL: func_fp_fabsf_var_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    sra.l %s0, %s0, 32
; CHECK-NEXT:    and %s0, %s0, (33)0
; CHECK-NEXT:    sll %s0, %s0, 32
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = tail call float @llvm.fabs.f32(float %0)
  ret float %2
}

; Function Attrs: nounwind readnone speculatable willreturn
declare float @llvm.fabs.f32(float)

; Function Attrs: nofree nounwind
define { float, float } @func_fp_cabsf_var_fcomp(float %0, float %1) {
; CHECK-LABEL: func_fp_cabsf_var_fcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, cabsf@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, cabsf@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    lea.sl %s1, 0
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call float @cabsf(float %0, float %1)
  %4 = insertvalue { float, float } undef, float %3, 0
  %5 = insertvalue { float, float } %4, float 0.000000e+00, 1
  ret { float, float } %5
}

; Function Attrs: nofree nounwind
declare float @cabsf(float, float)

; Function Attrs: nounwind readnone
define double @func_fp_fabs_var_double(double %0) {
; CHECK-LABEL: func_fp_fabs_var_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (1)0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = tail call double @llvm.fabs.f64(double %0)
  ret double %2
}

; Function Attrs: nounwind readnone speculatable willreturn
declare double @llvm.fabs.f64(double)

; Function Attrs: nofree nounwind
define { double, double } @func_fp_cabs_var_dcomp(double %0, double %1) {
; CHECK-LABEL: func_fp_cabs_var_dcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, cabs@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, cabs@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    lea.sl %s1, 0
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call double @cabs(double %0, double %1)
  %4 = insertvalue { double, double } undef, double %3, 0
  %5 = insertvalue { double, double } %4, double 0.000000e+00, 1
  ret { double, double } %5
}

; Function Attrs: nofree nounwind
declare double @cabs(double, double)

; Function Attrs: nounwind readnone
define fp128 @func_fp_fabsl_var_quad(fp128 %0) {
; CHECK-LABEL: func_fp_fabsl_var_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    st %s1, -16(, %s9)
; CHECK-NEXT:    st %s0, -8(, %s9)
; CHECK-NEXT:    ld1b.zx %s0, -1(, %s9)
; CHECK-NEXT:    and %s0, %s0, (57)0
; CHECK-NEXT:    st1b %s0, -1(, %s9)
; CHECK-NEXT:    ld %s1, -16(, %s9)
; CHECK-NEXT:    ld %s0, -8(, %s9)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call fp128 @llvm.fabs.f128(fp128 %0)
  ret fp128 %2
}

; Function Attrs: nounwind readnone speculatable willreturn
declare fp128 @llvm.fabs.f128(fp128)

; Function Attrs: nofree nounwind
define { fp128, fp128 } @func_fp_cabsl_var_qcomp(fp128 %0, fp128 %1) {
; CHECK-LABEL: func_fp_cabsl_var_qcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s4, cabsl@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s12, cabsl@hi(, %s4)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    lea %s2, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s2)
; CHECK-NEXT:    ld %s2, 8(, %s4)
; CHECK-NEXT:    ld %s3, (, %s4)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call fp128 @cabsl(fp128 %0, fp128 %1)
  %4 = insertvalue { fp128, fp128 } undef, fp128 %3, 0
  %5 = insertvalue { fp128, fp128 } %4, fp128 0xL00000000000000000000000000000000, 1
  ret { fp128, fp128 } %5
}

; Function Attrs: nofree nounwind
declare fp128 @cabsl(fp128, fp128)

; Function Attrs: norecurse nounwind readnone
define float @func_fp_fabsf_zero_float() {
; CHECK-LABEL: func_fp_fabsf_zero_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    b.l.t (, %s10)
  ret float 0.000000e+00
}

; Function Attrs: nofree nounwind
define { float, float } @func_fp_cabsf_zero_fcomp() {
; CHECK-LABEL: func_fp_cabsf_zero_fcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    st %s18, 48(, %s9) # 8-byte Folded Spill
; CHECK-NEXT:    lea.sl %s18, 0
; CHECK-NEXT:    lea %s0, cabsf@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, cabsf@hi(, %s0)
; CHECK-NEXT:    or %s0, 0, %s18
; CHECK-NEXT:    or %s1, 0, %s18
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s1, 0, %s18
; CHECK-NEXT:    ld %s18, 48(, %s9) # 8-byte Folded Reload
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call float @cabsf(float 0.000000e+00, float 0.000000e+00)
  %2 = insertvalue { float, float } undef, float %1, 0
  %3 = insertvalue { float, float } %2, float 0.000000e+00, 1
  ret { float, float } %3
}

; Function Attrs: norecurse nounwind readnone
define double @func_fp_FABS_zero_double() {
; CHECK-LABEL: func_fp_FABS_zero_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    b.l.t (, %s10)
  ret double 0.000000e+00
}

; Function Attrs: nofree nounwind
define { double, double } @func_fp_CABS_zero_dcomp() {
; CHECK-LABEL: func_fp_CABS_zero_dcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    st %s18, 48(, %s9) # 8-byte Folded Spill
; CHECK-NEXT:    lea %s0, cabs@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, cabs@hi(, %s0)
; CHECK-NEXT:    lea.sl %s18, 0
; CHECK-NEXT:    or %s0, 0, %s18
; CHECK-NEXT:    or %s1, 0, %s18
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s1, 0, %s18
; CHECK-NEXT:    ld %s18, 48(, %s9) # 8-byte Folded Reload
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call double @cabs(double 0.000000e+00, double 0.000000e+00)
  %2 = insertvalue { double, double } undef, double %1, 0
  %3 = insertvalue { double, double } %2, double 0.000000e+00, 1
  ret { double, double } %3
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_fp_fabsl_zero_quad() {
; CHECK-LABEL: func_fp_fabsl_zero_quad:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s2)
; CHECK-NEXT:    ld %s1, (, %s2)
; CHECK-NEXT:    b.l.t (, %s10)
  ret fp128 0xL00000000000000000000000000000000
}

; Function Attrs: nofree nounwind
define { fp128, fp128 } @func_fp_cabsl_zero_qcomp() {
; CHECK-LABEL: func_fp_cabsl_zero_qcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    st %s18, 48(, %s9) # 8-byte Folded Spill
; CHECK-NEXT:    st %s19, 56(, %s9) # 8-byte Folded Spill
; CHECK-NEXT:    lea %s0, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, .LCPI{{[0-9]+}}_0@hi(, %s0)
; CHECK-NEXT:    ld %s18, 8(, %s0)
; CHECK-NEXT:    ld %s19, (, %s0)
; CHECK-NEXT:    lea %s0, cabsl@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, cabsl@hi(, %s0)
; CHECK-NEXT:    or %s0, 0, %s18
; CHECK-NEXT:    or %s1, 0, %s19
; CHECK-NEXT:    or %s2, 0, %s18
; CHECK-NEXT:    or %s3, 0, %s19
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s2, 0, %s18
; CHECK-NEXT:    or %s3, 0, %s19
; CHECK-NEXT:    ld %s19, 56(, %s9) # 8-byte Folded Reload
; CHECK-NEXT:    ld %s18, 48(, %s9) # 8-byte Folded Reload
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call fp128 @cabsl(fp128 0xL00000000000000000000000000000000, fp128 0xL00000000000000000000000000000000)
  %2 = insertvalue { fp128, fp128 } undef, fp128 %1, 0
  %3 = insertvalue { fp128, fp128 } %2, fp128 0xL00000000000000000000000000000000, 1
  ret { fp128, fp128 } %3
}

; Function Attrs: norecurse nounwind readnone
define float @func_fp_fabsf_const_float() {
; CHECK-LABEL: func_fp_fabsf_const_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s0, 1073741824
; CHECK-NEXT:    b.l.t (, %s10)
  ret float 2.000000e+00
}

; Function Attrs: nofree nounwind
define { float, float } @func_fp_cabsf_const_fcomp() {
; CHECK-LABEL: func_fp_cabsf_const_fcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    st %s18, 48(, %s9) # 8-byte Folded Spill
; CHECK-NEXT:    lea.sl %s0, -1073741824
; CHECK-NEXT:    lea.sl %s18, 0
; CHECK-NEXT:    lea %s1, cabsf@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, cabsf@hi(, %s1)
; CHECK-NEXT:    or %s1, 0, %s18
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s1, 0, %s18
; CHECK-NEXT:    ld %s18, 48(, %s9) # 8-byte Folded Reload
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call float @cabsf(float -2.000000e+00, float 0.000000e+00)
  %2 = insertvalue { float, float } undef, float %1, 0
  %3 = insertvalue { float, float } %2, float 0.000000e+00, 1
  ret { float, float } %3
}

; Function Attrs: norecurse nounwind readnone
define double @func_fp_fabs_const_double() {
; CHECK-LABEL: func_fp_fabs_const_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s0, 1073741824
; CHECK-NEXT:    b.l.t (, %s10)
  ret double 2.000000e+00
}

; Function Attrs: nofree nounwind
define { double, double } @func_fp_cabs_const_dcomp() {
; CHECK-LABEL: func_fp_cabs_const_dcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    st %s18, 48(, %s9) # 8-byte Folded Spill
; CHECK-NEXT:    lea %s0, cabs@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, cabs@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, -1073741824
; CHECK-NEXT:    lea.sl %s18, 0
; CHECK-NEXT:    or %s1, 0, %s18
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s1, 0, %s18
; CHECK-NEXT:    ld %s18, 48(, %s9) # 8-byte Folded Reload
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call double @cabs(double -2.000000e+00, double 0.000000e+00)
  %2 = insertvalue { double, double } undef, double %1, 0
  %3 = insertvalue { double, double } %2, double 0.000000e+00, 1
  ret { double, double } %3
}

; Function Attrs: nounwind readnone
define fp128 @func_fp_fabsl_const_quad() {
; CHECK-LABEL: func_fp_fabsl_const_quad:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s2)
; CHECK-NEXT:    ld %s1, (, %s2)
; CHECK-NEXT:    b.l.t (, %s10)
  %1 = tail call fp128 @llvm.fabs.f128(fp128 0xL0000000000000000C000000000000000)
  ret fp128 %1
}

; Function Attrs: nofree nounwind
define { fp128, fp128 } @func_fp_cabsl_const_qcomp() {
; CHECK-LABEL: func_fp_cabsl_const_qcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    st %s18, 48(, %s9) # 8-byte Folded Spill
; CHECK-NEXT:    st %s19, 56(, %s9) # 8-byte Folded Spill
; CHECK-NEXT:    lea %s0, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s2)
; CHECK-NEXT:    ld %s1, (, %s2)
; CHECK-NEXT:    lea %s2, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_1@hi(, %s2)
; CHECK-NEXT:    ld %s18, 8(, %s2)
; CHECK-NEXT:    ld %s19, (, %s2)
; CHECK-NEXT:    lea %s2, cabsl@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, cabsl@hi(, %s2)
; CHECK-NEXT:    or %s2, 0, %s18
; CHECK-NEXT:    or %s3, 0, %s19
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s2, 0, %s18
; CHECK-NEXT:    or %s3, 0, %s19
; CHECK-NEXT:    ld %s19, 56(, %s9) # 8-byte Folded Reload
; CHECK-NEXT:    ld %s18, 48(, %s9) # 8-byte Folded Reload
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call fp128 @cabsl(fp128 0xL0000000000000000C000000000000000, fp128 0xL00000000000000000000000000000000)
  %2 = insertvalue { fp128, fp128 } undef, fp128 %1, 0
  %3 = insertvalue { fp128, fp128 } %2, fp128 0xL00000000000000000000000000000000, 1
  ret { fp128, fp128 } %3
}
