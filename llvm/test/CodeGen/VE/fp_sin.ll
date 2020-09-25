; RUN: llc < %s -mtriple=ve | FileCheck %s

; Function Attrs: nofree nounwind
define float @func_fp_sinf_var_float(float %0) {
; CHECK-LABEL: func_fp_sinf_var_float:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, sinf@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, sinf@hi(, %s1)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call float @sinf(float %0)
  ret float %2
}

; Function Attrs: nofree nounwind
declare float @sinf(float)

; Function Attrs: nounwind
define { float, float } @func_fp_csinf_var_fcomp(float %0, float %1) {
; CHECK-LABEL: func_fp_csinf_var_fcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, csinf@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, csinf@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call { float, float } @csinf(float %0, float %1)
  ret { float, float } %3
}

; Function Attrs: nounwind
declare { float, float } @csinf(float, float)

; Function Attrs: nofree nounwind
define double @func_fp_sin_var_double(double %0) {
; CHECK-LABEL: func_fp_sin_var_double:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, sin@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, sin@hi(, %s1)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call double @sin(double %0)
  ret double %2
}

; Function Attrs: nofree nounwind
declare double @sin(double)

; Function Attrs: nounwind
define { double, double } @func_fp_csin_var_dcomp(double %0, double %1) {
; CHECK-LABEL: func_fp_csin_var_dcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, csin@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, csin@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call { double, double } @csin(double %0, double %1)
  ret { double, double } %3
}

; Function Attrs: nounwind
declare { double, double } @csin(double, double)

; Function Attrs: nofree nounwind
define fp128 @func_fp_sinl_var_quad(fp128 %0) {
; CHECK-LABEL: func_fp_sinl_var_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, sinl@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, sinl@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call fp128 @sinl(fp128 %0)
  ret fp128 %2
}

; Function Attrs: nofree nounwind
declare fp128 @sinl(fp128)

; Function Attrs: nounwind
define { fp128, fp128 } @func_fp_csinl_var_qcomp(fp128 %0, fp128 %1) {
; CHECK-LABEL: func_fp_csinl_var_qcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s4, csinl@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s12, csinl@hi(, %s4)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call { fp128, fp128 } @csinl(fp128 %0, fp128 %1)
  ret { fp128, fp128 } %3
}

; Function Attrs: nounwind
declare { fp128, fp128 } @csinl(fp128, fp128)

; Function Attrs: norecurse nounwind readnone
define float @func_fp_sinf_zero_float() {
; CHECK-LABEL: func_fp_sinf_zero_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    b.l.t (, %s10)
  ret float 0.000000e+00
}

; Function Attrs: nounwind
define { float, float } @func_fp_csinf_zero_fcomp() {
; CHECK-LABEL: func_fp_csinf_zero_fcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    lea %s1, csinf@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, csinf@hi(, %s1)
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call { float, float } @csinf(float 0.000000e+00, float 0.000000e+00)
  ret { float, float } %1
}

; Function Attrs: norecurse nounwind readnone
define double @func_fp_SIN_zero_double() {
; CHECK-LABEL: func_fp_SIN_zero_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    b.l.t (, %s10)
  ret double 0.000000e+00
}

; Function Attrs: nounwind
define { double, double } @func_fp_CSIN_zero_dcomp() {
; CHECK-LABEL: func_fp_CSIN_zero_dcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, csin@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, csin@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call { double, double } @csin(double 0.000000e+00, double 0.000000e+00)
  ret { double, double } %1
}

; Function Attrs: nofree nounwind
define fp128 @func_fp_sinl_zero_quad() {
; CHECK-LABEL: func_fp_sinl_zero_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s2)
; CHECK-NEXT:    ld %s1, (, %s2)
; CHECK-NEXT:    lea %s2, sinl@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, sinl@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call fp128 @sinl(fp128 0xL00000000000000000000000000000000)
  ret fp128 %1
}

; Function Attrs: nounwind
define { fp128, fp128 } @func_fp_csinl_zero_qcomp() {
; CHECK-LABEL: func_fp_csinl_zero_qcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s2)
; CHECK-NEXT:    ld %s1, (, %s2)
; CHECK-NEXT:    lea %s2, csinl@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, csinl@hi(, %s2)
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    or %s3, 0, %s1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call { fp128, fp128 } @csinl(fp128 0xL00000000000000000000000000000000, fp128 0xL00000000000000000000000000000000)
  ret { fp128, fp128 } %1
}

; Function Attrs: norecurse nounwind readnone
define float @func_fp_sinf_const_float() {
; CHECK-LABEL: func_fp_sinf_const_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s0, -1083652169
; CHECK-NEXT:    b.l.t (, %s10)
  ret float 0xBFED18F6E0000000
}

; Function Attrs: nounwind
define { float, float } @func_fp_csinf_const_fcomp() {
; CHECK-LABEL: func_fp_csinf_const_fcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s0, -1073741824
; CHECK-NEXT:    lea.sl %s1, 0
; CHECK-NEXT:    lea %s2, csinf@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, csinf@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call { float, float } @csinf(float -2.000000e+00, float 0.000000e+00)
  ret { float, float } %1
}

; Function Attrs: norecurse nounwind readnone
define double @func_fp_sin_const_double() {
; CHECK-LABEL: func_fp_sin_const_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, -355355578
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, -1074980618(, %s0)
; CHECK-NEXT:    b.l.t (, %s10)
  ret double 0xBFED18F6EAD1B446
}

; Function Attrs: nounwind
define { double, double } @func_fp_csin_const_dcomp() {
; CHECK-LABEL: func_fp_csin_const_dcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, csin@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, csin@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, -1073741824
; CHECK-NEXT:    lea.sl %s1, 0
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call { double, double } @csin(double -2.000000e+00, double 0.000000e+00)
  ret { double, double } %1
}

; Function Attrs: nofree nounwind
define fp128 @func_fp_sinl_const_quad() {
; CHECK-LABEL: func_fp_sinl_const_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s2)
; CHECK-NEXT:    ld %s1, (, %s2)
; CHECK-NEXT:    lea %s2, sinl@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, sinl@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call fp128 @sinl(fp128 0xL0000000000000000C000000000000000)
  ret fp128 %1
}

; Function Attrs: nounwind
define { fp128, fp128 } @func_fp_csinl_const_qcomp() {
; CHECK-LABEL: func_fp_csinl_const_qcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s2)
; CHECK-NEXT:    ld %s1, (, %s2)
; CHECK-NEXT:    lea %s2, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_1@hi(, %s2)
; CHECK-NEXT:    ld %s2, 8(, %s4)
; CHECK-NEXT:    ld %s3, (, %s4)
; CHECK-NEXT:    lea %s4, csinl@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s12, csinl@hi(, %s4)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call { fp128, fp128 } @csinl(fp128 0xL0000000000000000C000000000000000, fp128 0xL00000000000000000000000000000000)
  ret { fp128, fp128 } %1
}
