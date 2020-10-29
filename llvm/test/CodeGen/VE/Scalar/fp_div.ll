; RUN: llc < %s -mtriple=ve | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define float @func_div_var_float(float %0, float %1) {
; CHECK-LABEL: func_div_var_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fdiv.s %s0, %s0, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fdiv float %0, %1
  ret float %3
}

; Function Attrs: norecurse nounwind readnone
define double @func_div_var_double(double %0, double %1) {
; CHECK-LABEL: func_div_var_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fdiv.d %s0, %s0, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fdiv double %0, %1
  ret double %3
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_div_var_quad(fp128 %0, fp128 %1) {
; CHECK-LABEL: func_div_var_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s4, __divtf3@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s12, __divtf3@hi(, %s4)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = fdiv fp128 %0, %1
  ret fp128 %3
}

; Function Attrs: nounwind
define { float, float } @func_div_var_fcomp(float %0, float %1, float %2, float %3) {
; CHECK-LABEL: func_div_var_fcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s4, __divsc3@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s12, __divsc3@hi(, %s4)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = tail call { float, float } @__divsc3(float %0, float %1, float %2, float %3)
  ret { float, float } %5
}

declare { float, float } @__divsc3(float, float, float, float)

; Function Attrs: nounwind
define { double, double } @func_div_var_dcomp(double %0, double %1, double %2, double %3) {
; CHECK-LABEL: func_div_var_dcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s4, __divdc3@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s12, __divdc3@hi(, %s4)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = tail call { double, double } @__divdc3(double %0, double %1, double %2, double %3)
  ret { double, double } %5
}

declare { double, double } @__divdc3(double, double, double, double)

; Function Attrs: nounwind
define { fp128, fp128 } @func_div_var_qcomp(fp128 %0, fp128 %1, fp128 %2, fp128 %3) {
; CHECK-LABEL: func_div_var_qcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, __divtc3@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __divtc3@hi(, %s34)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = tail call { fp128, fp128 } @__divtc3(fp128 %0, fp128 %1, fp128 %2, fp128 %3)
  ret { fp128, fp128 } %5
}

declare { fp128, fp128 } @__divtc3(fp128, fp128, fp128, fp128)

; Function Attrs: norecurse nounwind readnone
define float @func_div_zero_float(float %0) {
; CHECK-LABEL: func_div_zero_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fdiv.s %s0, 0, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fdiv float 0.000000e+00, %0
  ret float %2
}

; Function Attrs: norecurse nounwind readnone
define double @func_div_zero_double(double %0) {
; CHECK-LABEL: func_div_zero_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fdiv.d %s0, 0, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fdiv double 0.000000e+00, %0
  ret double %2
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_div_zero_quad(fp128 %0) {
; CHECK-LABEL: func_div_zero_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    or %s3, 0, %s1
; CHECK-NEXT:    lea %s0, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s4)
; CHECK-NEXT:    ld %s1, (, %s4)
; CHECK-NEXT:    lea %s4, __divtf3@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s12, __divtf3@hi(, %s4)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fdiv fp128 0xL00000000000000000000000000000000, %0
  ret fp128 %2
}

; Function Attrs: nounwind
define { float, float } @func_div_zero_fcomp(float %0, float %1) {
; CHECK-LABEL: func_div_zero_fcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    srl %s3, (8)1, 1
; CHECK-NEXT:    cmps.l %s4, %s0, %s3
; CHECK-NEXT:    cvt.d.s %s2, %s0
; CHECK-NEXT:    cmov.l.gt %s2, (1)0, %s4
; CHECK-NEXT:    cmps.l %s0, %s1, %s3
; CHECK-NEXT:    cvt.d.s %s3, %s1
; CHECK-NEXT:    cmov.l.gt %s3, (1)0, %s0
; CHECK-NEXT:    lea %s0, __divdc3@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __divdc3@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    cvt.s.d %s0, %s0
; CHECK-NEXT:    cvt.s.d %s1, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = fpext float %0 to double
  %4 = fpext float %1 to double
  %5 = tail call { double, double } @__divdc3(double 0.000000e+00, double 0.000000e+00, double %3, double %4)
  %6 = extractvalue { double, double } %5, 0
  %7 = extractvalue { double, double } %5, 1
  %8 = fptrunc double %6 to float
  %9 = fptrunc double %7 to float
  %10 = insertvalue { float, float } undef, float %8, 0
  %11 = insertvalue { float, float } %10, float %9, 1
  ret { float, float } %11
}

; Function Attrs: nounwind
define { double, double } @func_div_zero_dcomp(double %0, double %1) {
; CHECK-LABEL: func_div_zero_dcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s3, 0, %s1
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    lea %s0, __divdc3@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __divdc3@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call { double, double } @__divdc3(double 0.000000e+00, double 0.000000e+00, double %0, double %1)
  ret { double, double } %3
}

; Function Attrs: nounwind
define { fp128, fp128 } @func_div_zero_qcomp(fp128 %0, fp128 %1) {
; CHECK-LABEL: func_div_zero_qcomp:
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
; CHECK-NEXT:    lea %s2, __divtc3@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, __divtc3@hi(, %s2)
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    or %s3, 0, %s1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call { fp128, fp128 } @__divtc3(fp128 0xL00000000000000000000000000000000, fp128 0xL00000000000000000000000000000000, fp128 %0, fp128 %1)
  ret { fp128, fp128 } %3
}

; Function Attrs: norecurse nounwind readnone
define float @func_div_const_back_float(float %0) {
; CHECK-LABEL: func_div_const_back_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s1, -1090519040
; CHECK-NEXT:    fmul.s %s0, %s0, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fmul float %0, -5.000000e-01
  ret float %2
}

; Function Attrs: norecurse nounwind readnone
define double @func_div_const_back_double(double %0) {
; CHECK-LABEL: func_div_const_back_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s1, -1075838976
; CHECK-NEXT:    fmul.d %s0, %s0, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fmul double %0, -5.000000e-01
  ret double %2
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_div_const_back_quad(fp128 %0) {
; CHECK-LABEL: func_div_const_back_quad:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s2, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s2)
; CHECK-NEXT:    ld %s4, 8(, %s2)
; CHECK-NEXT:    ld %s5, (, %s2)
; CHECK-NEXT:    fmul.q %s0, %s0, %s4
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fmul fp128 %0, 0xL0000000000000000BFFE000000000000
  ret fp128 %2
}

; Function Attrs: norecurse nounwind readnone
define { float, float } @func_div_const_back_fcomp(float %0, float %1) {
; CHECK-LABEL: func_div_const_back_fcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s2, -1090519040
; CHECK-NEXT:    fmul.s %s0, %s0, %s2
; CHECK-NEXT:    fmul.s %s1, %s1, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fmul float %0, -5.000000e-01
  %4 = fmul float %1, -5.000000e-01
  %5 = insertvalue { float, float } undef, float %3, 0
  %6 = insertvalue { float, float } %5, float %4, 1
  ret { float, float } %6
}

; Function Attrs: norecurse nounwind readnone
define { double, double } @func_div_const_back_dcomp(double %0, double %1) {
; CHECK-LABEL: func_div_const_back_dcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s2, -1075838976
; CHECK-NEXT:    fmul.d %s0, %s0, %s2
; CHECK-NEXT:    fmul.d %s1, %s1, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fmul double %0, -5.000000e-01
  %4 = fmul double %1, -5.000000e-01
  %5 = insertvalue { double, double } undef, double %3, 0
  %6 = insertvalue { double, double } %5, double %4, 1
  ret { double, double } %6
}

; Function Attrs: norecurse nounwind readnone
define { fp128, fp128 } @func_div_const_back_qcomp(fp128 %0, fp128 %1) {
; CHECK-LABEL: func_div_const_back_qcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fmul.q %s0, %s0, %s6
; CHECK-NEXT:    fmul.q %s2, %s2, %s6
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fmul fp128 %0, 0xL0000000000000000BFFE000000000000
  %4 = fmul fp128 %1, 0xL0000000000000000BFFE000000000000
  %5 = insertvalue { fp128, fp128 } undef, fp128 %3, 0
  %6 = insertvalue { fp128, fp128 } %5, fp128 %4, 1
  ret { fp128, fp128 } %6
}

; Function Attrs: norecurse nounwind readnone
define float @func_div_cont_fore_float(float %0) {
; CHECK-LABEL: func_div_cont_fore_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s1, -1073741824
; CHECK-NEXT:    fdiv.s %s0, %s1, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fdiv float -2.000000e+00, %0
  ret float %2
}

; Function Attrs: norecurse nounwind readnone
define double @func_div_cont_fore_double(double %0) {
; CHECK-LABEL: func_div_cont_fore_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s1, -1073741824
; CHECK-NEXT:    fdiv.d %s0, %s1, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fdiv double -2.000000e+00, %0
  ret double %2
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_div_cont_fore_quad(fp128 %0) {
; CHECK-LABEL: func_div_cont_fore_quad:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    or %s3, 0, %s1
; CHECK-NEXT:    lea %s0, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s4)
; CHECK-NEXT:    ld %s1, (, %s4)
; CHECK-NEXT:    lea %s4, __divtf3@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s12, __divtf3@hi(, %s4)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fdiv fp128 0xL0000000000000000C000000000000000, %0
  ret fp128 %2
}

; Function Attrs: nounwind
define { float, float } @func_div_cont_fore_fcomp(float %0, float %1) {
; CHECK-LABEL: func_div_cont_fore_fcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    srl %s3, (8)1, 1
; CHECK-NEXT:    cmps.l %s4, %s0, %s3
; CHECK-NEXT:    cvt.d.s %s2, %s0
; CHECK-NEXT:    cmov.l.gt %s2, (1)0, %s4
; CHECK-NEXT:    cmps.l %s0, %s1, %s3
; CHECK-NEXT:    cvt.d.s %s3, %s1
; CHECK-NEXT:    cmov.l.gt %s3, (1)0, %s0
; CHECK-NEXT:    lea %s0, __divdc3@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __divdc3@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, -1073741824
; CHECK-NEXT:    lea.sl %s1, 0
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    cvt.s.d %s0, %s0
; CHECK-NEXT:    cvt.s.d %s1, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = fpext float %0 to double
  %4 = fpext float %1 to double
  %5 = tail call { double, double } @__divdc3(double -2.000000e+00, double 0.000000e+00, double %3, double %4)
  %6 = extractvalue { double, double } %5, 0
  %7 = extractvalue { double, double } %5, 1
  %8 = fptrunc double %6 to float
  %9 = fptrunc double %7 to float
  %10 = insertvalue { float, float } undef, float %8, 0
  %11 = insertvalue { float, float } %10, float %9, 1
  ret { float, float } %11
}

; Function Attrs: nounwind
define { double, double } @func_div_cont_fore_dcomp(double %0, double %1) {
; CHECK-LABEL: func_div_cont_fore_dcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s3, 0, %s1
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    lea %s0, __divdc3@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __divdc3@hi(, %s0)
; CHECK-NEXT:    lea.sl %s0, -1073741824
; CHECK-NEXT:    lea.sl %s1, 0
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call { double, double } @__divdc3(double -2.000000e+00, double 0.000000e+00, double %0, double %1)
  ret { double, double } %3
}

; Function Attrs: nounwind
define { fp128, fp128 } @func_div_cont_fore_qcomp(fp128 %0, fp128 %1) {
; CHECK-LABEL: func_div_cont_fore_qcomp:
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
; CHECK-NEXT:    lea %s34, __divtc3@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __divtc3@hi(, %s34)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call { fp128, fp128 } @__divtc3(fp128 0xL0000000000000000C000000000000000, fp128 0xL00000000000000000000000000000000, fp128 %0, fp128 %1)
  ret { fp128, fp128 } %3
}
