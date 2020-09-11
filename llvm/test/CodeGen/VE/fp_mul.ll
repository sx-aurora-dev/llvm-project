; RUN: llc < %s -mtriple=ve | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define float @func_mul_var_float(float %0, float %1) {
; CHECK-LABEL: func_mul_var_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmul.s %s0, %s0, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fmul float %0, %1
  ret float %3
}

; Function Attrs: norecurse nounwind readnone
define double @func_mul_var_double(double %0, double %1) {
; CHECK-LABEL: func_mul_var_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmul.d %s0, %s0, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fmul double %0, %1
  ret double %3
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_mul_var_quad(fp128 %0, fp128 %1) {
; CHECK-LABEL: func_mul_var_quad:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmul.q %s0, %s0, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fmul fp128 %0, %1
  ret fp128 %3
}

; Function Attrs: nounwind
define { float, float } @func_mul_var_fcomp(float %0, float %1, float %2, float %3) {
; CHECK-LABEL: func_mul_var_fcomp:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    fmul.s %s4, %s0, %s2
; CHECK-NEXT:    fmul.s %s5, %s1, %s3
; CHECK-NEXT:    fmul.s %s6, %s0, %s3
; CHECK-NEXT:    fmul.s %s7, %s1, %s2
; CHECK-NEXT:    fsub.s %s4, %s4, %s5
; CHECK-NEXT:    fadd.s %s5, %s7, %s6
; CHECK-NEXT:    brnum.s %s4, %s4, .LBB{{[0-9]+}}_3
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    brnan.s %s5, %s5, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  .LBB{{[0-9]+}}_3:
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = fmul float %0, %2
  %6 = fmul float %1, %3
  %7 = fmul float %0, %3
  %8 = fmul float %1, %2
  %9 = fsub float %5, %6
  %10 = fadd float %8, %7
  %11 = fcmp uno float %9, 0.000000e+00
  %12 = fcmp uno float %10, 0.000000e+00
  %13 = and i1 %11, %12
  br i1 %13, label %14, label %18, !prof !2

14:                                               ; preds = %4
  %15 = tail call { float, float } @__mulsc3(float %0, float %1, float %2, float %3)
  %16 = extractvalue { float, float } %15, 0
  %17 = extractvalue { float, float } %15, 1
  br label %18

18:                                               ; preds = %14, %4
  %19 = phi float [ %9, %4 ], [ %16, %14 ]
  %20 = phi float [ %10, %4 ], [ %17, %14 ]
  %21 = insertvalue { float, float } undef, float %19, 0
  %22 = insertvalue { float, float } %21, float %20, 1
  ret { float, float } %22
}

declare { float, float } @__mulsc3(float, float, float, float)

; Function Attrs: nounwind
define { double, double } @func_mul_var_dcomp(double %0, double %1, double %2, double %3) {
; CHECK-LABEL: func_mul_var_dcomp:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    or %s5, 0, %s0
; CHECK-NEXT:    fmul.d %s0, %s0, %s2
; CHECK-NEXT:    fmul.d %s4, %s1, %s3
; CHECK-NEXT:    fmul.d %s6, %s5, %s3
; CHECK-NEXT:    fmul.d %s7, %s1, %s2
; CHECK-NEXT:    fsub.d %s0, %s0, %s4
; CHECK-NEXT:    fadd.d %s4, %s7, %s6
; CHECK-NEXT:    brnum.d %s0, %s0, .LBB{{[0-9]+}}_3
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    brnan.d %s4, %s4, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  .LBB{{[0-9]+}}_3:
; CHECK-NEXT:    or %s1, 0, %s4
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = fmul double %0, %2
  %6 = fmul double %1, %3
  %7 = fmul double %0, %3
  %8 = fmul double %1, %2
  %9 = fsub double %5, %6
  %10 = fadd double %8, %7
  %11 = fcmp uno double %9, 0.000000e+00
  %12 = fcmp uno double %10, 0.000000e+00
  %13 = and i1 %11, %12
  br i1 %13, label %14, label %18, !prof !2

14:                                               ; preds = %4
  %15 = tail call { double, double } @__muldc3(double %0, double %1, double %2, double %3)
  %16 = extractvalue { double, double } %15, 0
  %17 = extractvalue { double, double } %15, 1
  br label %18

18:                                               ; preds = %14, %4
  %19 = phi double [ %9, %4 ], [ %16, %14 ]
  %20 = phi double [ %10, %4 ], [ %17, %14 ]
  %21 = insertvalue { double, double } undef, double %19, 0
  %22 = insertvalue { double, double } %21, double %20, 1
  ret { double, double } %22
}

declare { double, double } @__muldc3(double, double, double, double)

; Function Attrs: nounwind
define { fp128, fp128 } @func_mul_var_qcomp(fp128 %0, fp128 %1, fp128 %2, fp128 %3) {
; CHECK-LABEL: func_mul_var_qcomp:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    or %s34, 0, %s0
; CHECK-NEXT:    or %s35, 0, %s1
; CHECK-NEXT:    fmul.q %s0, %s0, %s4
; CHECK-NEXT:    fmul.q %s36, %s2, %s6
; CHECK-NEXT:    fmul.q %s38, %s34, %s6
; CHECK-NEXT:    fmul.q %s40, %s2, %s4
; CHECK-NEXT:    fsub.q %s0, %s0, %s36
; CHECK-NEXT:    fcmp.q %s42, %s0, %s0
; CHECK-NEXT:    fadd.q %s36, %s40, %s38
; CHECK-NEXT:    brnum.d 0, %s42, .LBB{{[0-9]+}}_3
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    fcmp.q %s38, %s36, %s36
; CHECK-NEXT:    brnan.d 0, %s38, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  .LBB{{[0-9]+}}_3:
; CHECK-NEXT:    or %s2, 0, %s36
; CHECK-NEXT:    or %s3, 0, %s37
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = fmul fp128 %0, %2
  %6 = fmul fp128 %1, %3
  %7 = fmul fp128 %0, %3
  %8 = fmul fp128 %1, %2
  %9 = fsub fp128 %5, %6
  %10 = fadd fp128 %8, %7
  %11 = fcmp uno fp128 %9, 0xL00000000000000000000000000000000
  %12 = fcmp uno fp128 %10, 0xL00000000000000000000000000000000
  %13 = and i1 %11, %12
  br i1 %13, label %14, label %18, !prof !2

14:                                               ; preds = %4
  %15 = tail call { fp128, fp128 } @__multc3(fp128 %0, fp128 %1, fp128 %2, fp128 %3)
  %16 = extractvalue { fp128, fp128 } %15, 0
  %17 = extractvalue { fp128, fp128 } %15, 1
  br label %18

18:                                               ; preds = %14, %4
  %19 = phi fp128 [ %9, %4 ], [ %16, %14 ]
  %20 = phi fp128 [ %10, %4 ], [ %17, %14 ]
  %21 = insertvalue { fp128, fp128 } undef, fp128 %19, 0
  %22 = insertvalue { fp128, fp128 } %21, fp128 %20, 1
  ret { fp128, fp128 } %22
}

declare { fp128, fp128 } @__multc3(fp128, fp128, fp128, fp128)

; Function Attrs: norecurse nounwind readnone
define float @func_mul_zero_float(float %0) {
; CHECK-LABEL: func_mul_zero_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmul.s %s0, %s0, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fmul float %0, 0.000000e+00
  ret float %2
}

; Function Attrs: norecurse nounwind readnone
define double @func_mul_zero_double(double %0) {
; CHECK-LABEL: func_mul_zero_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmul.d %s0, %s0, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fmul double %0, 0.000000e+00
  ret double %2
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_mul_zero_quad(fp128 %0) {
; CHECK-LABEL: func_mul_zero_quad:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s2, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s2)
; CHECK-NEXT:    ld %s4, 8(, %s2)
; CHECK-NEXT:    ld %s5, (, %s2)
; CHECK-NEXT:    fmul.q %s0, %s0, %s4
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fmul fp128 %0, 0xL00000000000000000000000000000000
  ret fp128 %2
}

; Function Attrs: norecurse nounwind readnone
define { float, float } @func_mul_zero_fcomp(float %0, float %1) {
; CHECK-LABEL: func_mul_zero_fcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmul.s %s0, %s0, (0)1
; CHECK-NEXT:    fmul.s %s1, %s1, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fmul float %0, 0.000000e+00
  %4 = fmul float %1, 0.000000e+00
  %5 = insertvalue { float, float } undef, float %3, 0
  %6 = insertvalue { float, float } %5, float %4, 1
  ret { float, float } %6
}

; Function Attrs: norecurse nounwind readnone
define { double, double } @func_mul_zero_dcomp(double %0, double %1) {
; CHECK-LABEL: func_mul_zero_dcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmul.d %s0, %s0, (0)1
; CHECK-NEXT:    fmul.d %s1, %s1, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fmul double %0, 0.000000e+00
  %4 = fmul double %1, 0.000000e+00
  %5 = insertvalue { double, double } undef, double %3, 0
  %6 = insertvalue { double, double } %5, double %4, 1
  ret { double, double } %6
}

; Function Attrs: norecurse nounwind readnone
define { fp128, fp128 } @func_mul_zero_qcomp(fp128 %0, fp128 %1) {
; CHECK-LABEL: func_mul_zero_qcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fmul.q %s0, %s0, %s6
; CHECK-NEXT:    fmul.q %s2, %s2, %s6
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fmul fp128 %0, 0xL00000000000000000000000000000000
  %4 = fmul fp128 %1, 0xL00000000000000000000000000000000
  %5 = insertvalue { fp128, fp128 } undef, fp128 %3, 0
  %6 = insertvalue { fp128, fp128 } %5, fp128 %4, 1
  ret { fp128, fp128 } %6
}

; Function Attrs: norecurse nounwind readnone
define float @func_mul_const_float(float %0) {
; CHECK-LABEL: func_mul_const_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmul.s %s0, %s0, (2)1
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fmul float %0, -2.000000e+00
  ret float %2
}

; Function Attrs: norecurse nounwind readnone
define double @func_mul_const_double(double %0) {
; CHECK-LABEL: func_mul_const_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmul.d %s0, %s0, (2)1
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fmul double %0, -2.000000e+00
  ret double %2
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_mul_const_quad(fp128 %0) {
; CHECK-LABEL: func_mul_const_quad:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s2, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s2)
; CHECK-NEXT:    ld %s4, 8(, %s2)
; CHECK-NEXT:    ld %s5, (, %s2)
; CHECK-NEXT:    fmul.q %s0, %s0, %s4
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = fmul fp128 %0, 0xL0000000000000000C000000000000000
  ret fp128 %2
}

; Function Attrs: norecurse nounwind readnone
define { float, float } @func_mul_const_fcomp(float %0, float %1) {
; CHECK-LABEL: func_mul_const_fcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmul.s %s0, %s0, (2)1
; CHECK-NEXT:    fmul.s %s1, %s1, (2)1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fmul float %0, -2.000000e+00
  %4 = fmul float %1, -2.000000e+00
  %5 = insertvalue { float, float } undef, float %3, 0
  %6 = insertvalue { float, float } %5, float %4, 1
  ret { float, float } %6
}

; Function Attrs: norecurse nounwind readnone
define { double, double } @func_mul_const_dcomp(double %0, double %1) {
; CHECK-LABEL: func_mul_const_dcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmul.d %s0, %s0, (2)1
; CHECK-NEXT:    fmul.d %s1, %s1, (2)1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fmul double %0, -2.000000e+00
  %4 = fmul double %1, -2.000000e+00
  %5 = insertvalue { double, double } undef, double %3, 0
  %6 = insertvalue { double, double } %5, double %4, 1
  ret { double, double } %6
}

; Function Attrs: norecurse nounwind readnone
define { fp128, fp128 } @func_mul_const_qcomp(fp128 %0, fp128 %1) {
; CHECK-LABEL: func_mul_const_qcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fmul.q %s0, %s0, %s6
; CHECK-NEXT:    fmul.q %s2, %s2, %s6
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = fmul fp128 %0, 0xL0000000000000000C000000000000000
  %4 = fmul fp128 %1, 0xL0000000000000000C000000000000000
  %5 = insertvalue { fp128, fp128 } undef, fp128 %3, 0
  %6 = insertvalue { fp128, fp128 } %5, fp128 %4, 1
  ret { fp128, fp128 } %6
}

!2 = !{!"branch_weights", i32 0, i32 -1}
