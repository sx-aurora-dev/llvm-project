; RUN: llc < %s -mtriple=ve | FileCheck %s

; Function Attrs: nofree nounwind
define float @func_fp_expf_var_float(float %0) {
; CHECK-LABEL: func_fp_expf_var_float:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, expf@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, expf@hi(, %s1)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call float @expf(float %0)
  ret float %2
}

; Function Attrs: nofree nounwind
declare float @expf(float)

; Function Attrs: nounwind
define { float, float } @func_fp_cexpf_var_fcomp(float %0, float %1) {
; CHECK-LABEL: func_fp_cexpf_var_fcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, cexpf@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, cexpf@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call { float, float } @cexpf(float %0, float %1)
  ret { float, float } %3
}

; Function Attrs: nounwind
declare { float, float } @cexpf(float, float)

; Function Attrs: nofree nounwind
define double @func_fp_exp_var_double(double %0) {
; CHECK-LABEL: func_fp_exp_var_double:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, exp@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, exp@hi(, %s1)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call double @exp(double %0)
  ret double %2
}

; Function Attrs: nofree nounwind
declare double @exp(double)

; Function Attrs: nounwind
define { double, double } @func_fp_cexp_var_dcomp(double %0, double %1) {
; CHECK-LABEL: func_fp_cexp_var_dcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, cexp@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, cexp@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call { double, double } @cexp(double %0, double %1)
  ret { double, double } %3
}

; Function Attrs: nounwind
declare { double, double } @cexp(double, double)

; Function Attrs: nofree nounwind
define fp128 @func_fp_expl_var_quad(fp128 %0) {
; CHECK-LABEL: func_fp_expl_var_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, expl@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, expl@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call fp128 @expl(fp128 %0)
  ret fp128 %2
}

; Function Attrs: nofree nounwind
declare fp128 @expl(fp128)

; Function Attrs: nounwind
define { fp128, fp128 } @func_fp_cexpl_var_qcomp(fp128 %0, fp128 %1) {
; CHECK-LABEL: func_fp_cexpl_var_qcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s4, cexpl@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s12, cexpl@hi(, %s4)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call { fp128, fp128 } @cexpl(fp128 %0, fp128 %1)
  ret { fp128, fp128 } %3
}

; Function Attrs: nounwind
declare { fp128, fp128 } @cexpl(fp128, fp128)

; Function Attrs: norecurse nounwind readnone
define float @func_fp_expf_zero_float() {
; CHECK-LABEL: func_fp_expf_zero_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s0, 1065353216
; CHECK-NEXT:    b.l.t (, %s10)
  ret float 1.000000e+00
}

; Function Attrs: nounwind
define { float, float } @func_fp_cexpf_zero_fcomp() {
; CHECK-LABEL: func_fp_cexpf_zero_fcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    lea %s1, cexpf@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, cexpf@hi(, %s1)
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call { float, float } @cexpf(float 0.000000e+00, float 0.000000e+00)
  ret { float, float } %1
}

; Function Attrs: norecurse nounwind readnone
define double @func_fp_EXP_zero_double() {
; CHECK-LABEL: func_fp_EXP_zero_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s0, 1072693248
; CHECK-NEXT:    b.l.t (, %s10)
  ret double 1.000000e+00
}

; Function Attrs: nounwind
define { double, double } @func_fp_cexp_zero_dcomp() {
; CHECK-LABEL: func_fp_cexp_zero_dcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, cexp@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, cexp@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call { double, double } @cexp(double 0.000000e+00, double 0.000000e+00)
  ret { double, double } %1
}

; Function Attrs: nofree nounwind
define fp128 @func_fp_expl_zero_quad() {
; CHECK-LABEL: func_fp_expl_zero_quad:
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
  %1 = tail call fp128 @expl(fp128 0xL00000000000000000000000000000000)
  ret fp128 %1
}

; Function Attrs: nounwind
define { fp128, fp128 } @func_fp_cexpl_zero_qcomp() {
; CHECK-LABEL: func_fp_cexpl_zero_qcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s2)
; CHECK-NEXT:    ld %s1, (, %s2)
; CHECK-NEXT:    lea %s2, cexpl@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, cexpl@hi(, %s2)
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    or %s3, 0, %s1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call { fp128, fp128 } @cexpl(fp128 0xL00000000000000000000000000000000, fp128 0xL00000000000000000000000000000000)
  ret { fp128, fp128 } %1
}

; Function Attrs: norecurse nounwind readnone
define float @func_fp_expf_const_float() {
; CHECK-LABEL: func_fp_expf_const_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s0, 1040880981
; CHECK-NEXT:    b.l.t (, %s10)
  ret float 0x3FC152AAA0000000
}

; Function Attrs: nounwind
define { float, float } @func_fp_cexpf_const_fcomp() {
; CHECK-LABEL: func_fp_cexpf_const_fcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s0, -1073741824
; CHECK-NEXT:    lea.sl %s1, 0
; CHECK-NEXT:    lea %s2, cexpf@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, cexpf@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call { float, float } @cexpf(float -2.000000e+00, float 0.000000e+00)
  ret { float, float } %1
}

; Function Attrs: norecurse nounwind readnone
define double @func_fp_exp_const_double() {
; CHECK-LABEL: func_fp_exp_const_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, -1547730484
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, 1069634218(, %s0)
; CHECK-NEXT:    b.l.t (, %s10)
  ret double 0x3FC152AAA3BF81CC
}

; Function Attrs: nounwind
define { double, double } @func_fp_cexp_const_dcomp() {
; CHECK-LABEL: func_fp_cexp_const_dcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, cexp@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, cexp@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, -1073741824
; CHECK-NEXT:    lea.sl %s1, 0
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call { double, double } @cexp(double -2.000000e+00, double 0.000000e+00)
  ret { double, double } %1
}

; Function Attrs: nofree nounwind
define fp128 @func_fp_expl_const_quad() {
; CHECK-LABEL: func_fp_expl_const_quad:
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
  %1 = tail call fp128 @expl(fp128 0xL0000000000000000C000000000000000)
  ret fp128 %1
}

; Function Attrs: nounwind
define { fp128, fp128 } @func_fp_cexpl_const_qcomp() {
; CHECK-LABEL: func_fp_cexpl_const_qcomp:
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
; CHECK-NEXT:    lea %s4, cexpl@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s12, cexpl@hi(, %s4)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call { fp128, fp128 } @cexpl(fp128 0xL0000000000000000C000000000000000, fp128 0xL00000000000000000000000000000000)
  ret { fp128, fp128 } %1
}
