; RUN: llc < %s -mtriple=ve | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define float @func_sub_var_float(float %0, float %1) {
; CHECK-LABEL: func_sub_var_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fsub.s %s0, %s0, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fsub float %0, %1
  ret float %3
}

; Function Attrs: norecurse nounwind readnone
define double @func_sub_var_double(double %0, double %1) {
; CHECK-LABEL: func_sub_var_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fsub.d %s0, %s0, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fsub double %0, %1
  ret double %3
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_sub_var_quad(fp128 %0, fp128 %1) {
; CHECK-LABEL: func_sub_var_quad:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fsub.q %s0, %s0, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fsub fp128 %0, %1
  ret fp128 %3
}

; Function Attrs: norecurse nounwind readnone
define { float, float } @func_sub_var_fcomp(float %0, float %1, float %2, float %3) {
; CHECK-LABEL: func_sub_var_fcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fsub.s %s0, %s0, %s2
; CHECK-NEXT:    fsub.s %s1, %s1, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fsub float %0, %2
  %6 = fsub float %1, %3
  %7 = insertvalue { float, float } undef, float %5, 0
  %8 = insertvalue { float, float } %7, float %6, 1
  ret { float, float } %8
}

; Function Attrs: norecurse nounwind readnone
define { double, double } @func_sub_var_dcomp(double %0, double %1, double %2, double %3) {
; CHECK-LABEL: func_sub_var_dcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fsub.d %s0, %s0, %s2
; CHECK-NEXT:    fsub.d %s1, %s1, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fsub double %0, %2
  %6 = fsub double %1, %3
  %7 = insertvalue { double, double } undef, double %5, 0
  %8 = insertvalue { double, double } %7, double %6, 1
  ret { double, double } %8
}

; Function Attrs: norecurse nounwind readnone
define { fp128, fp128 } @func_sub_var_qcomp(fp128 %0, fp128 %1, fp128 %2, fp128 %3) {
; CHECK-LABEL: func_sub_var_qcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fsub.q %s0, %s0, %s4
; CHECK-NEXT:    fsub.q %s2, %s2, %s6
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fsub fp128 %0, %2
  %6 = fsub fp128 %1, %3
  %7 = insertvalue { fp128, fp128 } undef, fp128 %5, 0
  %8 = insertvalue { fp128, fp128 } %7, fp128 %6, 1
  ret { fp128, fp128 } %8
}

; Function Attrs: norecurse nounwind readnone
define float @func_sub_zero_back_float(float returned %0) {
; CHECK-LABEL: func_sub_zero_back_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    b.l.t (, %s10)
  ret float %0
}

; Function Attrs: norecurse nounwind readnone
define double @func_sub_zero_back_double(double returned %0) {
; CHECK-LABEL: func_sub_zero_back_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    b.l.t (, %s10)
  ret double %0
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_sub_zero_back_quad(fp128 returned %0) {
; CHECK-LABEL: func_sub_zero_back_quad:
; CHECK:       # %bb.0:
; CHECK-NEXT:    b.l.t (, %s10)
  ret fp128 %0
}

; Function Attrs: norecurse nounwind readnone
define { float, float } @func_sub_zero_back_fcomp(float %0, float %1) {
; CHECK-LABEL: func_sub_zero_back_fcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = insertvalue { float, float } undef, float %0, 0
  %4 = insertvalue { float, float } %3, float %1, 1
  ret { float, float } %4
}

; Function Attrs: norecurse nounwind readnone
define { double, double } @func_sub_zero_back_dcomp(double %0, double %1) {
; CHECK-LABEL: func_sub_zero_back_dcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = insertvalue { double, double } undef, double %0, 0
  %4 = insertvalue { double, double } %3, double %1, 1
  ret { double, double } %4
}

; Function Attrs: norecurse nounwind readnone
define { fp128, fp128 } @func_sub_zero_back_qcomp(fp128 %0, fp128 %1) {
; CHECK-LABEL: func_sub_zero_back_qcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = insertvalue { fp128, fp128 } undef, fp128 %0, 0
  %4 = insertvalue { fp128, fp128 } %3, fp128 %1, 1
  ret { fp128, fp128 } %4
}

; Function Attrs: norecurse nounwind readnone
define float @func_sub_zero_fore_float(float %0) {
; CHECK-LABEL: func_sub_zero_fore_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fsub.s %s0, 0, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fsub float 0.000000e+00, %0
  ret float %2
}

; Function Attrs: norecurse nounwind readnone
define double @func_sub_zero_fore_double(double %0) {
; CHECK-LABEL: func_sub_zero_fore_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fsub.d %s0, 0, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fsub double 0.000000e+00, %0
  ret double %2
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_sub_zero_fore_quad(fp128 %0) {
; CHECK-LABEL: func_sub_zero_fore_quad:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s2, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s2)
; CHECK-NEXT:    ld %s4, 8(, %s2)
; CHECK-NEXT:    ld %s5, (, %s2)
; CHECK-NEXT:    fsub.q %s0, %s4, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fsub fp128 0xL00000000000000000000000000000000, %0
  ret fp128 %2
}

; Function Attrs: norecurse nounwind readnone
define { float, float } @func_sub_zero_fore_fcomp(float %0, float %1) {
; CHECK-LABEL: func_sub_zero_fore_fcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fsub.s %s0, 0, %s0
; CHECK-NEXT:    sra.l %s1, %s1, 32
; CHECK-NEXT:    lea %s2, -2147483648
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    xor %s1, %s1, %s2
; CHECK-NEXT:    sll %s1, %s1, 32
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fsub float 0.000000e+00, %0
  %4 = fneg float %1
  %5 = insertvalue { float, float } undef, float %3, 0
  %6 = insertvalue { float, float } %5, float %4, 1
  ret { float, float } %6
}

; Function Attrs: norecurse nounwind readnone
define { double, double } @func_sub_zero_fore_dcomp(double %0, double %1) {
; CHECK-LABEL: func_sub_zero_fore_dcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fsub.d %s0, 0, %s0
; CHECK-NEXT:    xor %s1, %s1, (1)1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fsub double 0.000000e+00, %0
  %4 = fneg double %1
  %5 = insertvalue { double, double } undef, double %3, 0
  %6 = insertvalue { double, double } %5, double %4, 1
  ret { double, double } %6
}

; Function Attrs: norecurse nounwind readnone
define { fp128, fp128 } @func_sub_zero_fore_qcomp(fp128 %0, fp128 %1) {
; CHECK-LABEL: func_sub_zero_fore_qcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    st %s3, -16(, %s9)
; CHECK-NEXT:    st %s2, -8(, %s9)
; CHECK-NEXT:    ld1b.zx %s2, -1(, %s9)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    lea %s3, 128
; CHECK-NEXT:    xor %s2, %s2, %s3
; CHECK-NEXT:    st1b %s2, -1(, %s9)
; CHECK-NEXT:    ld %s3, -16(, %s9)
; CHECK-NEXT:    ld %s2, -8(, %s9)
; CHECK-NEXT:    fsub.q %s0, %s6, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = fsub fp128 0xL00000000000000000000000000000000, %0
  %4 = fneg fp128 %1
  %5 = insertvalue { fp128, fp128 } undef, fp128 %3, 0
  %6 = insertvalue { fp128, fp128 } %5, fp128 %4, 1
  ret { fp128, fp128 } %6
}

; Function Attrs: norecurse nounwind readnone
define float @func_sub_const_back_float(float %0) {
; CHECK-LABEL: func_sub_const_back_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s1, 1073741824
; CHECK-NEXT:    fadd.s %s0, %s0, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fadd float %0, 2.000000e+00
  ret float %2
}

; Function Attrs: norecurse nounwind readnone
define double @func_sub_const_back_double(double %0) {
; CHECK-LABEL: func_sub_const_back_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s1, 1073741824
; CHECK-NEXT:    fadd.d %s0, %s0, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fadd double %0, 2.000000e+00
  ret double %2
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_sub_const_back_quad(fp128 %0) {
; CHECK-LABEL: func_sub_const_back_quad:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s2, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s2)
; CHECK-NEXT:    ld %s4, 8(, %s2)
; CHECK-NEXT:    ld %s5, (, %s2)
; CHECK-NEXT:    fadd.q %s0, %s0, %s4
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fadd fp128 %0, 0xL00000000000000004000000000000000
  ret fp128 %2
}

; Function Attrs: norecurse nounwind readnone
define { float, float } @func_sub_const_back_fcomp(float %0, float %1) {
; CHECK-LABEL: func_sub_const_back_fcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s2, 1073741824
; CHECK-NEXT:    fadd.s %s0, %s0, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fadd float %0, 2.000000e+00
  %4 = insertvalue { float, float } undef, float %3, 0
  %5 = insertvalue { float, float } %4, float %1, 1
  ret { float, float } %5
}

; Function Attrs: norecurse nounwind readnone
define { double, double } @func_sub_const_back_dcomp(double %0, double %1) {
; CHECK-LABEL: func_sub_const_back_dcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s2, 1073741824
; CHECK-NEXT:    fadd.d %s0, %s0, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fadd double %0, 2.000000e+00
  %4 = insertvalue { double, double } undef, double %3, 0
  %5 = insertvalue { double, double } %4, double %1, 1
  ret { double, double } %5
}

; Function Attrs: norecurse nounwind readnone
define { fp128, fp128 } @func_sub_const_back_qcomp(fp128 %0, fp128 %1) {
; CHECK-LABEL: func_sub_const_back_qcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fadd.q %s0, %s0, %s6
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fadd fp128 %0, 0xL00000000000000004000000000000000
  %4 = insertvalue { fp128, fp128 } undef, fp128 %3, 0
  %5 = insertvalue { fp128, fp128 } %4, fp128 %1, 1
  ret { fp128, fp128 } %5
}

; Function Attrs: norecurse nounwind readnone
define float @func__const_fore_float(float %0) {
; CHECK-LABEL: func__const_fore_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s1, -1073741824
; CHECK-NEXT:    fsub.s %s0, %s1, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fsub float -2.000000e+00, %0
  ret float %2
}

; Function Attrs: norecurse nounwind readnone
define double @func__const_fore_double(double %0) {
; CHECK-LABEL: func__const_fore_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s1, -1073741824
; CHECK-NEXT:    fsub.d %s0, %s1, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fsub double -2.000000e+00, %0
  ret double %2
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func__const_fore_quad(fp128 %0) {
; CHECK-LABEL: func__const_fore_quad:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s2, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s2)
; CHECK-NEXT:    ld %s4, 8(, %s2)
; CHECK-NEXT:    ld %s5, (, %s2)
; CHECK-NEXT:    fsub.q %s0, %s4, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fsub fp128 0xL0000000000000000C000000000000000, %0
  ret fp128 %2
}

; Function Attrs: norecurse nounwind readnone
define { float, float } @func__const_fore_fcomp(float %0, float %1) {
; CHECK-LABEL: func__const_fore_fcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s2, -1073741824
; CHECK-NEXT:    fsub.s %s0, %s2, %s0
; CHECK-NEXT:    sra.l %s1, %s1, 32
; CHECK-NEXT:    lea %s2, -2147483648
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    xor %s1, %s1, %s2
; CHECK-NEXT:    sll %s1, %s1, 32
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fsub float -2.000000e+00, %0
  %4 = fneg float %1
  %5 = insertvalue { float, float } undef, float %3, 0
  %6 = insertvalue { float, float } %5, float %4, 1
  ret { float, float } %6
}

; Function Attrs: norecurse nounwind readnone
define { double, double } @func__const_fore_dcomp(double %0, double %1) {
; CHECK-LABEL: func__const_fore_dcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s2, -1073741824
; CHECK-NEXT:    fsub.d %s0, %s2, %s0
; CHECK-NEXT:    xor %s1, %s1, (1)1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fsub double -2.000000e+00, %0
  %4 = fneg double %1
  %5 = insertvalue { double, double } undef, double %3, 0
  %6 = insertvalue { double, double } %5, double %4, 1
  ret { double, double } %6
}

; Function Attrs: norecurse nounwind readnone
define { fp128, fp128 } @func__const_fore_qcomp(fp128 %0, fp128 %1) {
; CHECK-LABEL: func__const_fore_qcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    st %s3, -16(, %s9)
; CHECK-NEXT:    st %s2, -8(, %s9)
; CHECK-NEXT:    ld1b.zx %s2, -1(, %s9)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    lea %s3, 128
; CHECK-NEXT:    xor %s2, %s2, %s3
; CHECK-NEXT:    st1b %s2, -1(, %s9)
; CHECK-NEXT:    ld %s3, -16(, %s9)
; CHECK-NEXT:    ld %s2, -8(, %s9)
; CHECK-NEXT:    fsub.q %s0, %s6, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = fsub fp128 0xL0000000000000000C000000000000000, %0
  %4 = fneg fp128 %1
  %5 = insertvalue { fp128, fp128 } undef, fp128 %3, 0
  %6 = insertvalue { fp128, fp128 } %5, fp128 %4, 1
  ret { fp128, fp128 } %6
}
