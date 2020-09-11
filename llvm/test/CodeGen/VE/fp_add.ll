; RUN: llc < %s -mtriple=ve | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define float @func_add_var_float(float %0, float %1) {
; CHECK-LABEL: func_add_var_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fadd.s %s0, %s0, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fadd float %0, %1
  ret float %3
}

; Function Attrs: norecurse nounwind readnone
define double @func_add_var_double(double %0, double %1) {
; CHECK-LABEL: func_add_var_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fadd.d %s0, %s0, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fadd double %0, %1
  ret double %3
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_add_var_quad(fp128 %0, fp128 %1) {
; CHECK-LABEL: func_add_var_quad:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fadd.q %s0, %s0, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fadd fp128 %0, %1
  ret fp128 %3
}

; Function Attrs: norecurse nounwind readnone
define { float, float } @func_add_var_fcomp(float %0, float %1, float %2, float %3) {
; CHECK-LABEL: func_add_var_fcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fadd.s %s0, %s0, %s2
; CHECK-NEXT:    fadd.s %s1, %s1, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fadd float %0, %2
  %6 = fadd float %1, %3
  %7 = insertvalue { float, float } undef, float %5, 0
  %8 = insertvalue { float, float } %7, float %6, 1
  ret { float, float } %8
}

; Function Attrs: norecurse nounwind readnone
define { double, double } @func_add_var_dcomp(double %0, double %1, double %2, double %3) {
; CHECK-LABEL: func_add_var_dcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fadd.d %s0, %s0, %s2
; CHECK-NEXT:    fadd.d %s1, %s1, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fadd double %0, %2
  %6 = fadd double %1, %3
  %7 = insertvalue { double, double } undef, double %5, 0
  %8 = insertvalue { double, double } %7, double %6, 1
  ret { double, double } %8
}

; Function Attrs: norecurse nounwind readnone
define { fp128, fp128 } @func_add_var_qcomp(fp128 %0, fp128 %1, fp128 %2, fp128 %3) {
; CHECK-LABEL: func_add_var_qcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fadd.q %s0, %s0, %s4
; CHECK-NEXT:    fadd.q %s2, %s2, %s6
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fadd fp128 %0, %2
  %6 = fadd fp128 %1, %3
  %7 = insertvalue { fp128, fp128 } undef, fp128 %5, 0
  %8 = insertvalue { fp128, fp128 } %7, fp128 %6, 1
  ret { fp128, fp128 } %8
}

; Function Attrs: norecurse nounwind readnone
define float @func_add_zero_float(float %0) {
; CHECK-LABEL: func_add_zero_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fadd.s %s0, %s0, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fadd float %0, 0.000000e+00
  ret float %2
}

; Function Attrs: norecurse nounwind readnone
define double @func_add_zero_double(double %0) {
; CHECK-LABEL: func_add_zero_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fadd.d %s0, %s0, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fadd double %0, 0.000000e+00
  ret double %2
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_add_zero_quad(fp128 %0) {
; CHECK-LABEL: func_add_zero_quad:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s2, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s2)
; CHECK-NEXT:    ld %s4, 8(, %s2)
; CHECK-NEXT:    ld %s5, (, %s2)
; CHECK-NEXT:    fadd.q %s0, %s0, %s4
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fadd fp128 %0, 0xL00000000000000000000000000000000
  ret fp128 %2
}

; Function Attrs: norecurse nounwind readnone
define { float, float } @func_add_zero_fcomp(float %0, float %1) {
; CHECK-LABEL: func_add_zero_fcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fadd.s %s0, %s0, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fadd float %0, 0.000000e+00
  %4 = insertvalue { float, float } undef, float %3, 0
  %5 = insertvalue { float, float } %4, float %1, 1
  ret { float, float } %5
}

; Function Attrs: norecurse nounwind readnone
define { double, double } @func_add_zero_dcomp(double %0, double %1) {
; CHECK-LABEL: func_add_zero_dcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fadd.d %s0, %s0, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fadd double %0, 0.000000e+00
  %4 = insertvalue { double, double } undef, double %3, 0
  %5 = insertvalue { double, double } %4, double %1, 1
  ret { double, double } %5
}

; Function Attrs: norecurse nounwind readnone
define { fp128, fp128 } @func_add_zero_qcomp(fp128 %0, fp128 %1) {
; CHECK-LABEL: func_add_zero_qcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fadd.q %s0, %s0, %s6
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fadd fp128 %0, 0xL00000000000000000000000000000000
  %4 = insertvalue { fp128, fp128 } undef, fp128 %3, 0
  %5 = insertvalue { fp128, fp128 } %4, fp128 %1, 1
  ret { fp128, fp128 } %5
}

; Function Attrs: norecurse nounwind readnone
define float @func_add_const_float(float %0) {
; CHECK-LABEL: func_add_const_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fadd.s %s0, %s0, (2)1
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fadd float %0, -2.000000e+00
  ret float %2
}

; Function Attrs: norecurse nounwind readnone
define double @func_add_const_double(double %0) {
; CHECK-LABEL: func_add_const_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fadd.d %s0, %s0, (2)1
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fadd double %0, -2.000000e+00
  ret double %2
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_add_const_quad(fp128 %0) {
; CHECK-LABEL: func_add_const_quad:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s2, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s2)
; CHECK-NEXT:    ld %s4, 8(, %s2)
; CHECK-NEXT:    ld %s5, (, %s2)
; CHECK-NEXT:    fadd.q %s0, %s0, %s4
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fadd fp128 %0, 0xL0000000000000000C000000000000000
  ret fp128 %2
}

; Function Attrs: norecurse nounwind readnone
define { float, float } @func_add_const_fcomp(float %0, float %1) {
; CHECK-LABEL: func_add_const_fcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fadd.s %s0, %s0, (2)1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fadd float %0, -2.000000e+00
  %4 = insertvalue { float, float } undef, float %3, 0
  %5 = insertvalue { float, float } %4, float %1, 1
  ret { float, float } %5
}

; Function Attrs: norecurse nounwind readnone
define { double, double } @func_add_const_dcomp(double %0, double %1) {
; CHECK-LABEL: func_add_const_dcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fadd.d %s0, %s0, (2)1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fadd double %0, -2.000000e+00
  %4 = insertvalue { double, double } undef, double %3, 0
  %5 = insertvalue { double, double } %4, double %1, 1
  ret { double, double } %5
}

; Function Attrs: norecurse nounwind readnone
define { fp128, fp128 } @func_add_const_qcomp(fp128 %0, fp128 %1) {
; CHECK-LABEL: func_add_const_qcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fadd.q %s0, %s0, %s6
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fadd fp128 %0, 0xL0000000000000000C000000000000000
  %4 = insertvalue { fp128, fp128 } undef, fp128 %3, 0
  %5 = insertvalue { fp128, fp128 } %4, fp128 %1, 1
  ret { fp128, fp128 } %5
}
