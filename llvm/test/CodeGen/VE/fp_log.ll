; RUN: llc < %s -mtriple=ve | FileCheck %s

; Function Attrs: nofree nounwind
define float @func_fp_logf_var_float(float %0) {
; CHECK-LABEL: func_fp_logf_var_float:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, logf@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, logf@hi(, %s1)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call float @logf(float %0)
  ret float %2
}

; Function Attrs: nofree nounwind
declare float @logf(float)

; Function Attrs: nounwind
define { float, float } @func_fp_clogf_var_fcomp(float %0, float %1) {
; CHECK-LABEL: func_fp_clogf_var_fcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, clogf@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, clogf@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call { float, float } @clogf(float %0, float %1)
  ret { float, float } %3
}

; Function Attrs: nounwind
declare { float, float } @clogf(float, float)

; Function Attrs: nofree nounwind
define double @func_fp_log_var_double(double %0) {
; CHECK-LABEL: func_fp_log_var_double:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, log@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, log@hi(, %s1)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call double @log(double %0)
  ret double %2
}

; Function Attrs: nofree nounwind
declare double @log(double)

; Function Attrs: nounwind
define { double, double } @func_fp_clog_var_dcomp(double %0, double %1) {
; CHECK-LABEL: func_fp_clog_var_dcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, clog@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, clog@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call { double, double } @clog(double %0, double %1)
  ret { double, double } %3
}

; Function Attrs: nounwind
declare { double, double } @clog(double, double)

; Function Attrs: nofree nounwind
define fp128 @func_fp_logl_var_quad(fp128 %0) {
; CHECK-LABEL: func_fp_logl_var_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, logl@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, logl@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call fp128 @logl(fp128 %0)
  ret fp128 %2
}

; Function Attrs: nofree nounwind
declare fp128 @logl(fp128)

; Function Attrs: nounwind
define { fp128, fp128 } @func_fp_clogl_var_qcomp(fp128 %0, fp128 %1) {
; CHECK-LABEL: func_fp_clogl_var_qcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s4, clogl@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s12, clogl@hi(, %s4)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call { fp128, fp128 } @clogl(fp128 %0, fp128 %1)
  ret { fp128, fp128 } %3
}

; Function Attrs: nounwind
declare { fp128, fp128 } @clogl(fp128, fp128)

; Function Attrs: nofree nounwind
define float @func_fp_logf_zero_float() {
; CHECK-LABEL: func_fp_logf_zero_float:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    lea %s1, logf@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, logf@hi(, %s1)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call float @logf(float 0.000000e+00)
  ret float %1
}

; Function Attrs: nounwind
define { float, float } @func_fp_clogf_zero_fcomp() {
; CHECK-LABEL: func_fp_clogf_zero_fcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    lea %s1, clogf@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, clogf@hi(, %s1)
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call { float, float } @clogf(float 0.000000e+00, float 0.000000e+00)
  ret { float, float } %1
}

; Function Attrs: nofree nounwind
define double @func_fp_LOG_zero_double() {
; CHECK-LABEL: func_fp_LOG_zero_double:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, log@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, log@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call double @log(double 0.000000e+00)
  ret double %1
}

; Function Attrs: nounwind
define { double, double } @func_fp_clog_zero_dcomp() {
; CHECK-LABEL: func_fp_clog_zero_dcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, clog@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, clog@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call { double, double } @clog(double 0.000000e+00, double 0.000000e+00)
  ret { double, double } %1
}

; Function Attrs: nofree nounwind
define fp128 @func_fp_logl_zero_quad() {
; CHECK-LABEL: func_fp_logl_zero_quad:
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
  %1 = tail call fp128 @logl(fp128 0xL00000000000000000000000000000000)
  ret fp128 %1
}

; Function Attrs: nounwind
define { fp128, fp128 } @func_fp_clogl_zero_qcomp() {
; CHECK-LABEL: func_fp_clogl_zero_qcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s2)
; CHECK-NEXT:    ld %s1, (, %s2)
; CHECK-NEXT:    lea %s2, clogl@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, clogl@hi(, %s2)
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    or %s3, 0, %s1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call { fp128, fp128 } @clogl(fp128 0xL00000000000000000000000000000000, fp128 0xL00000000000000000000000000000000)
  ret { fp128, fp128 } %1
}

; Function Attrs: nofree nounwind
define float @func_fp_logf_const_float() {
; CHECK-LABEL: func_fp_logf_const_float:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s0, -1073741824
; CHECK-NEXT:    lea %s1, logf@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, logf@hi(, %s1)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call float @logf(float -2.000000e+00)
  ret float %1
}

; Function Attrs: nounwind
define { float, float } @func_fp_clogf_const_fcomp() {
; CHECK-LABEL: func_fp_clogf_const_fcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s0, -1073741824
; CHECK-NEXT:    lea.sl %s1, 0
; CHECK-NEXT:    lea %s2, clogf@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, clogf@hi(, %s2)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call { float, float } @clogf(float -2.000000e+00, float 0.000000e+00)
  ret { float, float } %1
}

; Function Attrs: nofree nounwind
define double @func_fp_log_const_double() {
; CHECK-LABEL: func_fp_log_const_double:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, log@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, log@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, -1073741824
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call double @log(double -2.000000e+00)
  ret double %1
}

; Function Attrs: nounwind
define { double, double } @func_fp_clog_const_dcomp() {
; CHECK-LABEL: func_fp_clog_const_dcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, clog@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, clog@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, -1073741824
; CHECK-NEXT:    lea.sl %s1, 0
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call { double, double } @clog(double -2.000000e+00, double 0.000000e+00)
  ret { double, double } %1
}

; Function Attrs: nofree nounwind
define fp128 @func_fp_logl_const_quad() {
; CHECK-LABEL: func_fp_logl_const_quad:
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
  %1 = tail call fp128 @logl(fp128 0xL0000000000000000C000000000000000)
  ret fp128 %1
}

; Function Attrs: nounwind
define { fp128, fp128 } @func_fp_clogl_const_qcomp() {
; CHECK-LABEL: func_fp_clogl_const_qcomp:
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
; CHECK-NEXT:    lea %s4, clogl@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s12, clogl@hi(, %s4)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = tail call { fp128, fp128 } @clogl(fp128 0xL0000000000000000C000000000000000, fp128 0xL00000000000000000000000000000000)
  ret { fp128, fp128 } %1
}
