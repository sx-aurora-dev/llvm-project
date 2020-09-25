; RUN: llc < %s -mtriple=ve | FileCheck %s

; Function Attrs: nofree nounwind
define float @func_fp_powf_var_float(float %0, float %1) {
; CHECK-LABEL: func_fp_powf_var_float:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, powf@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, powf@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call float @powf(float %0, float %1)
  ret float %3
}

; Function Attrs: nofree nounwind
declare float @powf(float, float)

; Function Attrs: nounwind
define { float, float } @func_fp_cpowf_var_fcomp(float %0, float %1, float %2, float %3) {
; CHECK-LABEL: func_fp_cpowf_var_fcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s4, cpowf@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s12, cpowf@hi(, %s4)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = tail call { float, float } @cpowf(float %0, float %1, float %2, float %3)
  ret { float, float } %5
}

; Function Attrs: nounwind
declare { float, float } @cpowf(float, float, float, float)

; Function Attrs: nofree nounwind
define double @func_fp_pow_var_double(double %0, double %1) {
; CHECK-LABEL: func_fp_pow_var_double:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, pow@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, pow@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call double @pow(double %0, double %1)
  ret double %3
}

; Function Attrs: nofree nounwind
declare double @pow(double, double)

; Function Attrs: nounwind
define { double, double } @func_fp_cpow_var_dcomp(double %0, double %1, double %2, double %3) {
; CHECK-LABEL: func_fp_cpow_var_dcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s4, cpow@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s12, cpow@hi(, %s4)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = tail call { double, double } @cpow(double %0, double %1, double %2, double %3)
  ret { double, double } %5
}

; Function Attrs: nounwind
declare { double, double } @cpow(double, double, double, double)

; Function Attrs: nofree nounwind
define fp128 @func_fp_powl_var_quad(fp128 %0, fp128 %1) {
; CHECK-LABEL: func_fp_powl_var_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s4, powl@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s12, powl@hi(, %s4)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call fp128 @powl(fp128 %0, fp128 %1)
  ret fp128 %3
}

; Function Attrs: nofree nounwind
declare fp128 @powl(fp128, fp128)

; Function Attrs: nounwind
define { fp128, fp128 } @func_fp_cpowl_var_qcomp(fp128 %0, fp128 %1, fp128 %2, fp128 %3) {
; CHECK-LABEL: func_fp_cpowl_var_qcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, cpowl@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, cpowl@hi(, %s34)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = tail call { fp128, fp128 } @cpowl(fp128 %0, fp128 %1, fp128 %2, fp128 %3)
  ret { fp128, fp128 } %5
}

; Function Attrs: nounwind
declare { fp128, fp128 } @cpowl(fp128, fp128, fp128, fp128)

; Function Attrs: norecurse nounwind readnone
define float @func_fp_powf_zero_back_float(float %0) {
; CHECK-LABEL: func_fp_powf_zero_back_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s0, 1065353216
; CHECK-NEXT:    b.l.t (, %s10)
  ret float 1.000000e+00
}

; Function Attrs: nounwind
define { float, float } @func_fp_cpowf_zero_back_fcomp(float %0, float %1) {
; CHECK-LABEL: func_fp_cpowf_zero_back_fcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s2, 0
; CHECK-NEXT:    lea %s3, cpowf@lo
; CHECK-NEXT:    and %s3, %s3, (32)0
; CHECK-NEXT:    lea.sl %s12, cpowf@hi(, %s3)
; CHECK-NEXT:    or %s3, 0, %s2
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call { float, float } @cpowf(float %0, float %1, float 0.000000e+00, float 0.000000e+00)
  ret { float, float } %3
}

; Function Attrs: norecurse nounwind readnone
define double @func_fp_pow_zero_back_double(double %0) {
; CHECK-LABEL: func_fp_pow_zero_back_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s0, 1072693248
; CHECK-NEXT:    b.l.t (, %s10)
  ret double 1.000000e+00
}

; Function Attrs: nounwind
define { double, double } @func_fp_cpow_zero_back_dcomp(double %0, double %1) {
; CHECK-LABEL: func_fp_cpow_zero_back_dcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, cpow@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, cpow@hi(, %s2)
; CHECK-NEXT:    lea.sl %s2, 0
; CHECK-NEXT:    or %s3, 0, %s2
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call { double, double } @cpow(double %0, double %1, double 0.000000e+00, double 0.000000e+00)
  ret { double, double } %3
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_fp_powl_zero_back_quad(fp128 %0) {
; CHECK-LABEL: func_fp_powl_zero_back_quad:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s2)
; CHECK-NEXT:    ld %s1, (, %s2)
; CHECK-NEXT:    b.l.t (, %s10)
  ret fp128 0xL00000000000000003FFF000000000000
}

; Function Attrs: nounwind
define { fp128, fp128 } @func_fp_cpowl_zero_back_qcomp(fp128 %0, fp128 %1) {
; CHECK-LABEL: func_fp_cpowl_zero_back_qcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s4, 8(, %s6)
; CHECK-NEXT:    ld %s5, (, %s6)
; CHECK-NEXT:    lea %s6, cpowl@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s12, cpowl@hi(, %s6)
; CHECK-NEXT:    or %s6, 0, %s4
; CHECK-NEXT:    or %s7, 0, %s5
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call { fp128, fp128 } @cpowl(fp128 %0, fp128 %1, fp128 0xL00000000000000000000000000000000, fp128 0xL00000000000000000000000000000000)
  ret { fp128, fp128 } %3
}

; Function Attrs: nofree nounwind
define float @func_fp_powf_zero_fore_float(float %0) {
; CHECK-LABEL: func_fp_powf_zero_fore_float:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    lea %s2, powf@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, powf@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call float @powf(float 0.000000e+00, float %0)
  ret float %2
}

; Function Attrs: nounwind
define { float, float } @func_fp_cpowf_zero_fore_fcomp(float %0, float %1) {
; CHECK-LABEL: func_fp_cpowf_zero_fore_fcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s3, 0, %s1
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    lea %s1, cpowf@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, cpowf@hi(, %s1)
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call { float, float } @cpowf(float 0.000000e+00, float 0.000000e+00, float %0, float %1)
  ret { float, float } %3
}

; Function Attrs: nofree nounwind
define double @func_fp_pow_zero_fore_double(double %0) {
; CHECK-LABEL: func_fp_pow_zero_fore_double:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    lea %s0, pow@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, pow@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call double @pow(double 0.000000e+00, double %0)
  ret double %2
}

; Function Attrs: nounwind
define { double, double } @func_fp_cpow_zero_fore_dcomp(double %0, double %1) {
; CHECK-LABEL: func_fp_cpow_zero_fore_dcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s3, 0, %s1
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    lea %s0, cpow@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, cpow@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call { double, double } @cpow(double 0.000000e+00, double 0.000000e+00, double %0, double %1)
  ret { double, double } %3
}

; Function Attrs: nofree nounwind
define fp128 @func_fp_powl_zero_fore_quad(fp128 %0) {
; CHECK-LABEL: func_fp_powl_zero_fore_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    or %s3, 0, %s1
; CHECK-NEXT:    lea %s0, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s4)
; CHECK-NEXT:    ld %s1, (, %s4)
; CHECK-NEXT:    lea %s4, powl@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s12, powl@hi(, %s4)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call fp128 @powl(fp128 0xL00000000000000000000000000000000, fp128 %0)
  ret fp128 %2
}

; Function Attrs: nounwind
define { fp128, fp128 } @func_fp_cpowl_zero_fore_qcomp(fp128 %0, fp128 %1) {
; CHECK-LABEL: func_fp_cpowl_zero_fore_qcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s6, 0, %s2
; CHECK-NEXT:    or %s7, 0, %s3
; CHECK-NEXT:    or %s4, 0, %s0
; CHECK-NEXT:    or %s5, 0, %s1
; CHECK-NEXT:    lea %s0, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s2)
; CHECK-NEXT:    ld %s1, (, %s2)
; CHECK-NEXT:    lea %s2, cpowl@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, cpowl@hi(, %s2)
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    or %s3, 0, %s1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call { fp128, fp128 } @cpowl(fp128 0xL00000000000000000000000000000000, fp128 0xL00000000000000000000000000000000, fp128 %0, fp128 %1)
  ret { fp128, fp128 } %3
}

; Function Attrs: nofree nounwind
define float @func_fp_powf_const_back_float(float %0) {
; CHECK-LABEL: func_fp_powf_const_back_float:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s1, -1073741824
; CHECK-NEXT:    lea %s2, powf@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, powf@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call float @powf(float %0, float -2.000000e+00)
  ret float %2
}

; Function Attrs: nounwind
define { float, float } @func_fp_cpowf_const_back_fcomp(float %0, float %1) {
; CHECK-LABEL: func_fp_cpowf_const_back_fcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s2, -1073741824
; CHECK-NEXT:    lea.sl %s3, 0
; CHECK-NEXT:    lea %s4, cpowf@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s12, cpowf@hi(, %s4)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call { float, float } @cpowf(float %0, float %1, float -2.000000e+00, float 0.000000e+00)
  ret { float, float } %3
}

; Function Attrs: nofree nounwind
define double @func_fp_pow_const_back_double(double %0) {
; CHECK-LABEL: func_fp_pow_const_back_double:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, pow@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, pow@hi(, %s1)
; CHECK-NEXT:    lea.sl %s1, -1073741824
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call double @pow(double %0, double -2.000000e+00)
  ret double %2
}

; Function Attrs: nounwind
define { double, double } @func_fp_cpow_const_back_dcomp(double %0, double %1) {
; CHECK-LABEL: func_fp_cpow_const_back_dcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, cpow@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, cpow@hi(, %s2)
; CHECK-NEXT:    lea.sl %s2, -1073741824
; CHECK-NEXT:    lea.sl %s3, 0
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call { double, double } @cpow(double %0, double %1, double -2.000000e+00, double 0.000000e+00)
  ret { double, double } %3
}

; Function Attrs: nofree nounwind
define fp128 @func_fp_powl_const_back_quad(fp128 %0) {
; CHECK-LABEL: func_fp_powl_const_back_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s2)
; CHECK-NEXT:    ld %s2, 8(, %s4)
; CHECK-NEXT:    ld %s3, (, %s4)
; CHECK-NEXT:    lea %s4, powl@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s12, powl@hi(, %s4)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call fp128 @powl(fp128 %0, fp128 0xL0000000000000000C000000000000000)
  ret fp128 %2
}

; Function Attrs: nounwind
define { fp128, fp128 } @func_fp_cpowl_const_back_qcomp(fp128 %0, fp128 %1) {
; CHECK-LABEL: func_fp_cpowl_const_back_qcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s4, 8(, %s6)
; CHECK-NEXT:    ld %s5, (, %s6)
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s34, .LCPI{{[0-9]+}}_1@hi(, %s6)
; CHECK-NEXT:    ld %s6, 8(, %s34)
; CHECK-NEXT:    ld %s7, (, %s34)
; CHECK-NEXT:    lea %s34, cpowl@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, cpowl@hi(, %s34)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call { fp128, fp128 } @cpowl(fp128 %0, fp128 %1, fp128 0xL0000000000000000C000000000000000, fp128 0xL00000000000000000000000000000000)
  ret { fp128, fp128 } %3
}

; Function Attrs: nofree nounwind
define float @func_fp_powf_const_fore_float(float %0) {
; CHECK-LABEL: func_fp_powf_const_fore_float:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    lea.sl %s0, -1073741824
; CHECK-NEXT:    lea %s2, powf@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, powf@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call float @powf(float -2.000000e+00, float %0)
  ret float %2
}

; Function Attrs: nounwind
define { float, float } @func_fp_cpowf_const_fore_fcomp(float %0, float %1) {
; CHECK-LABEL: func_fp_cpowf_const_fore_fcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s3, 0, %s1
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    lea.sl %s0, -1073741824
; CHECK-NEXT:    lea.sl %s1, 0
; CHECK-NEXT:    lea %s4, cpowf@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s12, cpowf@hi(, %s4)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call { float, float } @cpowf(float -2.000000e+00, float 0.000000e+00, float %0, float %1)
  ret { float, float } %3
}

; Function Attrs: nofree nounwind
define double @func_fp_pow_const_fore_double(double %0) {
; CHECK-LABEL: func_fp_pow_const_fore_double:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    lea %s0, pow@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, pow@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, -1073741824
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call double @pow(double -2.000000e+00, double %0)
  ret double %2
}

; Function Attrs: nounwind
define { double, double } @func_fp_cpow_const_fore_dcomp(double %0, double %1) {
; CHECK-LABEL: func_fp_cpow_const_fore_dcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s3, 0, %s1
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    lea %s0, cpow@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, cpow@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, -1073741824
; CHECK-NEXT:    lea.sl %s1, 0
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call { double, double } @cpow(double -2.000000e+00, double 0.000000e+00, double %0, double %1)
  ret { double, double } %3
}

; Function Attrs: nofree nounwind
define fp128 @func_fp_powl_const_fore_quad(fp128 %0) {
; CHECK-LABEL: func_fp_powl_const_fore_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    or %s3, 0, %s1
; CHECK-NEXT:    lea %s0, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s4)
; CHECK-NEXT:    ld %s1, (, %s4)
; CHECK-NEXT:    lea %s4, powl@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s12, powl@hi(, %s4)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call fp128 @powl(fp128 0xL0000000000000000C000000000000000, fp128 %0)
  ret fp128 %2
}

; Function Attrs: nounwind
define { fp128, fp128 } @func_fp_cpowl_const_fore_qcomp(fp128 %0, fp128 %1) {
; CHECK-LABEL: func_fp_cpowl_const_fore_qcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s6, 0, %s2
; CHECK-NEXT:    or %s7, 0, %s3
; CHECK-NEXT:    or %s4, 0, %s0
; CHECK-NEXT:    or %s5, 0, %s1
; CHECK-NEXT:    lea %s0, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s2)
; CHECK-NEXT:    ld %s1, (, %s2)
; CHECK-NEXT:    lea %s2, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s34, .LCPI{{[0-9]+}}_1@hi(, %s2)
; CHECK-NEXT:    ld %s2, 8(, %s34)
; CHECK-NEXT:    ld %s3, (, %s34)
; CHECK-NEXT:    lea %s34, cpowl@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, cpowl@hi(, %s34)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call { fp128, fp128 } @cpowl(fp128 0xL0000000000000000C000000000000000, fp128 0xL00000000000000000000000000000000, fp128 %0, fp128 %1)
  ret { fp128, fp128 } %3
}
