; RUN: llc < %s -mtriple=ve | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define zeroext i1 @func_dcomp_1(double %0, double %1, double %2, double %3, i1 zeroext %4, i1 zeroext %5) {
; CHECK-LABEL: func_dcomp_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, %s2
; CHECK-NEXT:    or %s2, 0, (0)1
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s0
; CHECK-NEXT:    fcmp.d %s0, %s1, %s3
; CHECK-NEXT:    cmov.d.eq %s2, (63)0, %s0
; CHECK-NEXT:    and %s0, %s6, %s2
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq double %0, %2
  %8 = fcmp oeq double %1, %3
  %9 = and i1 %7, %8
  %10 = select i1 %9, i1 %4, i1 %5
  ret i1 %10
}

; Function Attrs: norecurse nounwind readnone
define signext i8 @func_dcomp_8(double %0, double %1, double %2, double %3, i8 signext %4, i8 signext %5) {
; CHECK-LABEL: func_dcomp_8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, %s2
; CHECK-NEXT:    or %s2, 0, (0)1
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s0
; CHECK-NEXT:    fcmp.d %s0, %s1, %s3
; CHECK-NEXT:    cmov.d.eq %s2, (63)0, %s0
; CHECK-NEXT:    and %s0, %s6, %s2
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq double %0, %2
  %8 = fcmp oeq double %1, %3
  %9 = and i1 %7, %8
  %10 = select i1 %9, i8 %4, i8 %5
  ret i8 %10
}

; Function Attrs: norecurse nounwind readnone
define zeroext i8 @func_dcomp_u8(double %0, double %1, double %2, double %3, i8 zeroext %4, i8 zeroext %5) {
; CHECK-LABEL: func_dcomp_u8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, %s2
; CHECK-NEXT:    or %s2, 0, (0)1
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s0
; CHECK-NEXT:    fcmp.d %s0, %s1, %s3
; CHECK-NEXT:    cmov.d.eq %s2, (63)0, %s0
; CHECK-NEXT:    and %s0, %s6, %s2
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq double %0, %2
  %8 = fcmp oeq double %1, %3
  %9 = and i1 %7, %8
  %10 = select i1 %9, i8 %4, i8 %5
  ret i8 %10
}

; Function Attrs: norecurse nounwind readnone
define signext i16 @func_dcomp_16(double %0, double %1, double %2, double %3, i16 signext %4, i16 signext %5) {
; CHECK-LABEL: func_dcomp_16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, %s2
; CHECK-NEXT:    or %s2, 0, (0)1
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s0
; CHECK-NEXT:    fcmp.d %s0, %s1, %s3
; CHECK-NEXT:    cmov.d.eq %s2, (63)0, %s0
; CHECK-NEXT:    and %s0, %s6, %s2
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq double %0, %2
  %8 = fcmp oeq double %1, %3
  %9 = and i1 %7, %8
  %10 = select i1 %9, i16 %4, i16 %5
  ret i16 %10
}

; Function Attrs: norecurse nounwind readnone
define zeroext i16 @func_dcomp_u16(double %0, double %1, double %2, double %3, i16 zeroext %4, i16 zeroext %5) {
; CHECK-LABEL: func_dcomp_u16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, %s2
; CHECK-NEXT:    or %s2, 0, (0)1
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s0
; CHECK-NEXT:    fcmp.d %s0, %s1, %s3
; CHECK-NEXT:    cmov.d.eq %s2, (63)0, %s0
; CHECK-NEXT:    and %s0, %s6, %s2
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq double %0, %2
  %8 = fcmp oeq double %1, %3
  %9 = and i1 %7, %8
  %10 = select i1 %9, i16 %4, i16 %5
  ret i16 %10
}

; Function Attrs: norecurse nounwind readnone
define signext i32 @func_dcomp_32(double %0, double %1, double %2, double %3, i32 signext %4, i32 signext %5) {
; CHECK-LABEL: func_dcomp_32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, %s2
; CHECK-NEXT:    or %s2, 0, (0)1
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s0
; CHECK-NEXT:    fcmp.d %s0, %s1, %s3
; CHECK-NEXT:    cmov.d.eq %s2, (63)0, %s0
; CHECK-NEXT:    and %s0, %s6, %s2
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq double %0, %2
  %8 = fcmp oeq double %1, %3
  %9 = and i1 %7, %8
  %10 = select i1 %9, i32 %4, i32 %5
  ret i32 %10
}

; Function Attrs: norecurse nounwind readnone
define zeroext i32 @func_dcomp_u32(double %0, double %1, double %2, double %3, i32 zeroext %4, i32 zeroext %5) {
; CHECK-LABEL: func_dcomp_u32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, %s2
; CHECK-NEXT:    or %s2, 0, (0)1
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s0
; CHECK-NEXT:    fcmp.d %s0, %s1, %s3
; CHECK-NEXT:    cmov.d.eq %s2, (63)0, %s0
; CHECK-NEXT:    and %s0, %s6, %s2
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq double %0, %2
  %8 = fcmp oeq double %1, %3
  %9 = and i1 %7, %8
  %10 = select i1 %9, i32 %4, i32 %5
  ret i32 %10
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_dcomp_64(double %0, double %1, double %2, double %3, i64 %4, i64 %5) {
; CHECK-LABEL: func_dcomp_64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, %s2
; CHECK-NEXT:    or %s2, 0, (0)1
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s0
; CHECK-NEXT:    fcmp.d %s0, %s1, %s3
; CHECK-NEXT:    cmov.d.eq %s2, (63)0, %s0
; CHECK-NEXT:    and %s0, %s6, %s2
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    or %s0, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq double %0, %2
  %8 = fcmp oeq double %1, %3
  %9 = and i1 %7, %8
  %10 = select i1 %9, i64 %4, i64 %5
  ret i64 %10
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_dcomp_u64(double %0, double %1, double %2, double %3, i64 %4, i64 %5) {
; CHECK-LABEL: func_dcomp_u64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, %s2
; CHECK-NEXT:    or %s2, 0, (0)1
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s0
; CHECK-NEXT:    fcmp.d %s0, %s1, %s3
; CHECK-NEXT:    cmov.d.eq %s2, (63)0, %s0
; CHECK-NEXT:    and %s0, %s6, %s2
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    or %s0, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq double %0, %2
  %8 = fcmp oeq double %1, %3
  %9 = and i1 %7, %8
  %10 = select i1 %9, i64 %4, i64 %5
  ret i64 %10
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_dcomp_128(double %0, double %1, double %2, double %3, i128 %4, i128 %5) {
; CHECK-LABEL: func_dcomp_128:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, %s2
; CHECK-NEXT:    or %s2, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.d %s0, %s1, %s3
; CHECK-NEXT:    cmov.d.eq %s2, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s2
; CHECK-NEXT:    cmov.w.ne %s6, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s7, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq double %0, %2
  %8 = fcmp oeq double %1, %3
  %9 = and i1 %7, %8
  %10 = select i1 %9, i128 %4, i128 %5
  ret i128 %10
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_dcomp_u128(double %0, double %1, double %2, double %3, i128 %4, i128 %5) {
; CHECK-LABEL: func_dcomp_u128:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, %s2
; CHECK-NEXT:    or %s2, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.d %s0, %s1, %s3
; CHECK-NEXT:    cmov.d.eq %s2, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s2
; CHECK-NEXT:    cmov.w.ne %s6, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s7, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq double %0, %2
  %8 = fcmp oeq double %1, %3
  %9 = and i1 %7, %8
  %10 = select i1 %9, i128 %4, i128 %5
  ret i128 %10
}

; Function Attrs: norecurse nounwind readnone
define float @func_dcomp_float(double %0, double %1, double %2, double %3, float %4, float %5) {
; CHECK-LABEL: func_dcomp_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, %s2
; CHECK-NEXT:    or %s2, 0, (0)1
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s0
; CHECK-NEXT:    fcmp.d %s0, %s1, %s3
; CHECK-NEXT:    cmov.d.eq %s2, (63)0, %s0
; CHECK-NEXT:    and %s0, %s6, %s2
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    or %s0, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq double %0, %2
  %8 = fcmp oeq double %1, %3
  %9 = and i1 %7, %8
  %10 = select i1 %9, float %4, float %5
  ret float %10
}

; Function Attrs: norecurse nounwind readnone
define double @func_dcomp_double(double %0, double %1, double %2, double %3, double %4, double %5) {
; CHECK-LABEL: func_dcomp_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, %s2
; CHECK-NEXT:    or %s2, 0, (0)1
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s0
; CHECK-NEXT:    fcmp.d %s0, %s1, %s3
; CHECK-NEXT:    cmov.d.eq %s2, (63)0, %s0
; CHECK-NEXT:    and %s0, %s6, %s2
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    or %s0, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq double %0, %2
  %8 = fcmp oeq double %1, %3
  %9 = and i1 %7, %8
  %10 = select i1 %9, double %4, double %5
  ret double %10
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_dcomp_quad(double %0, double %1, double %2, double %3, fp128 %4, fp128 %5) {
; CHECK-LABEL: func_dcomp_quad:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, %s2
; CHECK-NEXT:    or %s2, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.d %s0, %s1, %s3
; CHECK-NEXT:    cmov.d.eq %s2, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s2
; CHECK-NEXT:    cmov.w.ne %s6, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s7, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq double %0, %2
  %8 = fcmp oeq double %1, %3
  %9 = and i1 %7, %8
  %10 = select i1 %9, fp128 %4, fp128 %5
  ret fp128 %10
}

; Function Attrs: norecurse nounwind readnone
define { float, float } @func_dcomp_fcomp(double %0, double %1, double %2, double %3, float %4, float %5, float %6, float %7) {
; CHECK-LABEL: func_dcomp_fcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, %s2
; CHECK-NEXT:    or %s2, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.d %s0, %s1, %s3
; CHECK-NEXT:    cmov.d.eq %s2, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s2
; CHECK-NEXT:    cmov.w.ne %s6, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s7, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    b.l.t (, %s10)
  %9 = fcmp oeq double %0, %2
  %10 = fcmp oeq double %1, %3
  %11 = and i1 %9, %10
  %12 = select i1 %11, float %4, float %6
  %13 = select i1 %11, float %5, float %7
  %14 = insertvalue { float, float } undef, float %12, 0
  %15 = insertvalue { float, float } %14, float %13, 1
  ret { float, float } %15
}

; Function Attrs: norecurse nounwind readnone
define { double, double } @func_dcomp_dcomp(double %0, double %1, double %2, double %3, double %4, double %5, double %6, double %7) {
; CHECK-LABEL: func_dcomp_dcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, %s2
; CHECK-NEXT:    or %s2, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.d %s0, %s1, %s3
; CHECK-NEXT:    cmov.d.eq %s2, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s2
; CHECK-NEXT:    cmov.w.ne %s6, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s7, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    b.l.t (, %s10)
  %9 = fcmp oeq double %0, %2
  %10 = fcmp oeq double %1, %3
  %11 = and i1 %9, %10
  %12 = select i1 %11, double %4, double %6
  %13 = select i1 %11, double %5, double %7
  %14 = insertvalue { double, double } undef, double %12, 0
  %15 = insertvalue { double, double } %14, double %13, 1
  ret { double, double } %15
}

; Function Attrs: norecurse nounwind readnone
define { fp128, fp128 } @func_dcomp_qcomp(double %0, double %1, double %2, double %3, fp128 %4, fp128 %5, fp128 %6, fp128 %7) {
; CHECK-LABEL: func_dcomp_qcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld %s35, 256(, %s11)
; CHECK-NEXT:    ld %s34, 264(, %s11)
; CHECK-NEXT:    ld %s37, 240(, %s11)
; CHECK-NEXT:    ld %s36, 248(, %s11)
; CHECK-NEXT:    fcmp.d %s0, %s0, %s2
; CHECK-NEXT:    or %s2, 0, (0)1
; CHECK-NEXT:    or %s38, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s38, (63)0, %s0
; CHECK-NEXT:    fcmp.d %s0, %s1, %s3
; CHECK-NEXT:    cmov.d.eq %s2, (63)0, %s0
; CHECK-NEXT:    and %s0, %s38, %s2
; CHECK-NEXT:    cmov.w.ne %s36, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s37, %s5, %s0
; CHECK-NEXT:    cmov.w.ne %s34, %s6, %s0
; CHECK-NEXT:    cmov.w.ne %s35, %s7, %s0
; CHECK-NEXT:    or %s0, 0, %s36
; CHECK-NEXT:    or %s1, 0, %s37
; CHECK-NEXT:    or %s2, 0, %s34
; CHECK-NEXT:    or %s3, 0, %s35
; CHECK-NEXT:    b.l.t (, %s10)
  %9 = fcmp oeq double %0, %2
  %10 = fcmp oeq double %1, %3
  %11 = and i1 %9, %10
  %12 = select i1 %11, fp128 %4, fp128 %6
  %13 = select i1 %11, fp128 %5, fp128 %7
  %14 = insertvalue { fp128, fp128 } undef, fp128 %12, 0
  %15 = insertvalue { fp128, fp128 } %14, fp128 %13, 1
  ret { fp128, fp128 } %15
}

; Function Attrs: norecurse nounwind readnone
define zeroext i1 @func_dcomp_1_zero(double %0, double %1, i1 zeroext %2, i1 zeroext %3) {
; CHECK-LABEL: func_dcomp_1_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, 0.000000e+00
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i1 %2, i1 %3
  ret i1 %8
}

; Function Attrs: norecurse nounwind readnone
define signext i8 @func_dcomp_8_zero(double %0, double %1, i8 signext %2, i8 signext %3) {
; CHECK-LABEL: func_dcomp_8_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, 0.000000e+00
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i8 %2, i8 %3
  ret i8 %8
}

; Function Attrs: norecurse nounwind readnone
define zeroext i8 @func_dcomp_u8_zero(double %0, double %1, i8 zeroext %2, i8 zeroext %3) {
; CHECK-LABEL: func_dcomp_u8_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, 0.000000e+00
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i8 %2, i8 %3
  ret i8 %8
}

; Function Attrs: norecurse nounwind readnone
define signext i16 @func_dcomp_16_zero(double %0, double %1, i16 signext %2, i16 signext %3) {
; CHECK-LABEL: func_dcomp_16_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, 0.000000e+00
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i16 %2, i16 %3
  ret i16 %8
}

; Function Attrs: norecurse nounwind readnone
define zeroext i16 @func_dcomp_u16_zero(double %0, double %1, i16 zeroext %2, i16 zeroext %3) {
; CHECK-LABEL: func_dcomp_u16_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, 0.000000e+00
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i16 %2, i16 %3
  ret i16 %8
}

; Function Attrs: norecurse nounwind readnone
define signext i32 @func_dcomp_32_zero(double %0, double %1, i32 signext %2, i32 signext %3) {
; CHECK-LABEL: func_dcomp_32_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, 0.000000e+00
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i32 %2, i32 %3
  ret i32 %8
}

; Function Attrs: norecurse nounwind readnone
define zeroext i32 @func_dcomp_u32_zero(double %0, double %1, i32 zeroext %2, i32 zeroext %3) {
; CHECK-LABEL: func_dcomp_u32_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, 0.000000e+00
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i32 %2, i32 %3
  ret i32 %8
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_dcomp_64_zero(double %0, double %1, i64 %2, i64 %3) {
; CHECK-LABEL: func_dcomp_64_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, 0.000000e+00
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i64 %2, i64 %3
  ret i64 %8
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_dcomp_u64_zero(double %0, double %1, i64 %2, i64 %3) {
; CHECK-LABEL: func_dcomp_u64_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, 0.000000e+00
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i64 %2, i64 %3
  ret i64 %8
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_dcomp_128_zero(double %0, double %1, i128 %2, i128 %3) {
; CHECK-LABEL: func_dcomp_128_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    or %s7, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s7, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s1
; CHECK-NEXT:    and %s0, %s7, %s6
; CHECK-NEXT:    cmov.w.ne %s4, %s2, %s0
; CHECK-NEXT:    cmov.w.ne %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, 0.000000e+00
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i128 %2, i128 %3
  ret i128 %8
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_dcomp_u128_zero(double %0, double %1, i128 %2, i128 %3) {
; CHECK-LABEL: func_dcomp_u128_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    or %s7, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s7, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s1
; CHECK-NEXT:    and %s0, %s7, %s6
; CHECK-NEXT:    cmov.w.ne %s4, %s2, %s0
; CHECK-NEXT:    cmov.w.ne %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, 0.000000e+00
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i128 %2, i128 %3
  ret i128 %8
}

; Function Attrs: norecurse nounwind readnone
define float @func_dcomp_float_zero(double %0, double %1, float %2, float %3) {
; CHECK-LABEL: func_dcomp_float_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, 0.000000e+00
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, float %2, float %3
  ret float %8
}

; Function Attrs: norecurse nounwind readnone
define double @func_dcomp_double_zero(double %0, double %1, double %2, double %3) {
; CHECK-LABEL: func_dcomp_double_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, 0.000000e+00
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, double %2, double %3
  ret double %8
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_dcomp_quad_zero(double %0, double %1, fp128 %2, fp128 %3) {
; CHECK-LABEL: func_dcomp_quad_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    or %s7, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s7, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s1
; CHECK-NEXT:    and %s0, %s7, %s6
; CHECK-NEXT:    cmov.w.ne %s4, %s2, %s0
; CHECK-NEXT:    cmov.w.ne %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, 0.000000e+00
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, fp128 %2, fp128 %3
  ret fp128 %8
}

; Function Attrs: norecurse nounwind readnone
define { float, float } @func_dcomp_fcomp_zero(double %0, double %1, float %2, float %3, float %4, float %5) {
; CHECK-LABEL: func_dcomp_fcomp_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    or %s7, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s7, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s1
; CHECK-NEXT:    and %s0, %s7, %s6
; CHECK-NEXT:    cmov.w.ne %s4, %s2, %s0
; CHECK-NEXT:    cmov.w.ne %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq double %0, 0.000000e+00
  %8 = fcmp oeq double %1, 0.000000e+00
  %9 = and i1 %7, %8
  %10 = select i1 %9, float %2, float %4
  %11 = select i1 %9, float %3, float %5
  %12 = insertvalue { float, float } undef, float %10, 0
  %13 = insertvalue { float, float } %12, float %11, 1
  ret { float, float } %13
}

; Function Attrs: norecurse nounwind readnone
define { double, double } @func_dcomp_dcomp_zero(double %0, double %1, double %2, double %3, double %4, double %5) {
; CHECK-LABEL: func_dcomp_dcomp_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    or %s7, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s7, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s1
; CHECK-NEXT:    and %s0, %s7, %s6
; CHECK-NEXT:    cmov.w.ne %s4, %s2, %s0
; CHECK-NEXT:    cmov.w.ne %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq double %0, 0.000000e+00
  %8 = fcmp oeq double %1, 0.000000e+00
  %9 = and i1 %7, %8
  %10 = select i1 %9, double %2, double %4
  %11 = select i1 %9, double %3, double %5
  %12 = insertvalue { double, double } undef, double %10, 0
  %13 = insertvalue { double, double } %12, double %11, 1
  ret { double, double } %13
}

; Function Attrs: norecurse nounwind readnone
define { fp128, fp128 } @func_dcomp_qcomp_zero(double %0, double %1, fp128 %2, fp128 %3, fp128 %4, fp128 %5) {
; CHECK-LABEL: func_dcomp_qcomp_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld %s35, 240(, %s11)
; CHECK-NEXT:    ld %s34, 248(, %s11)
; CHECK-NEXT:    or %s36, 0, (0)1
; CHECK-NEXT:    or %s37, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s37, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s36, (63)0, %s1
; CHECK-NEXT:    and %s0, %s37, %s36
; CHECK-NEXT:    cmov.w.ne %s6, %s2, %s0
; CHECK-NEXT:    cmov.w.ne %s7, %s3, %s0
; CHECK-NEXT:    cmov.w.ne %s34, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s35, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    or %s2, 0, %s34
; CHECK-NEXT:    or %s3, 0, %s35
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq double %0, 0.000000e+00
  %8 = fcmp oeq double %1, 0.000000e+00
  %9 = and i1 %7, %8
  %10 = select i1 %9, fp128 %2, fp128 %4
  %11 = select i1 %9, fp128 %3, fp128 %5
  %12 = insertvalue { fp128, fp128 } undef, fp128 %10, 0
  %13 = insertvalue { fp128, fp128 } %12, fp128 %11, 1
  ret { fp128, fp128 } %13
}

; Function Attrs: norecurse nounwind readnone
define zeroext i1 @func_dcomp_1_i(double %0, double %1, i1 zeroext %2, i1 zeroext %3) {
; CHECK-LABEL: func_dcomp_1_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s4, 1076363264
; CHECK-NEXT:    fcmp.d %s0, %s0, %s4
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, 1.200000e+01
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i1 %2, i1 %3
  ret i1 %8
}

; Function Attrs: norecurse nounwind readnone
define signext i8 @func_dcomp_8_i(double %0, double %1, i8 signext %2, i8 signext %3) {
; CHECK-LABEL: func_dcomp_8_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s4, 1076363264
; CHECK-NEXT:    fcmp.d %s0, %s0, %s4
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, 1.200000e+01
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i8 %2, i8 %3
  ret i8 %8
}

; Function Attrs: norecurse nounwind readnone
define zeroext i8 @func_dcomp_u8_i(double %0, double %1, i8 zeroext %2, i8 zeroext %3) {
; CHECK-LABEL: func_dcomp_u8_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s4, 1076363264
; CHECK-NEXT:    fcmp.d %s0, %s0, %s4
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, 1.200000e+01
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i8 %2, i8 %3
  ret i8 %8
}

; Function Attrs: norecurse nounwind readnone
define signext i16 @func_dcomp_16_i(double %0, double %1, i16 signext %2, i16 signext %3) {
; CHECK-LABEL: func_dcomp_16_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s4, 1076363264
; CHECK-NEXT:    fcmp.d %s0, %s0, %s4
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, 1.200000e+01
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i16 %2, i16 %3
  ret i16 %8
}

; Function Attrs: norecurse nounwind readnone
define zeroext i16 @func_dcomp_u16_i(double %0, double %1, i16 zeroext %2, i16 zeroext %3) {
; CHECK-LABEL: func_dcomp_u16_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s4, 1076363264
; CHECK-NEXT:    fcmp.d %s0, %s0, %s4
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, 1.200000e+01
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i16 %2, i16 %3
  ret i16 %8
}

; Function Attrs: norecurse nounwind readnone
define signext i32 @func_dcomp_32_i(double %0, double %1, i32 signext %2, i32 signext %3) {
; CHECK-LABEL: func_dcomp_32_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s4, 1076363264
; CHECK-NEXT:    fcmp.d %s0, %s0, %s4
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, 1.200000e+01
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i32 %2, i32 %3
  ret i32 %8
}

; Function Attrs: norecurse nounwind readnone
define zeroext i32 @func_dcomp_u32_i(double %0, double %1, i32 zeroext %2, i32 zeroext %3) {
; CHECK-LABEL: func_dcomp_u32_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s4, 1076363264
; CHECK-NEXT:    fcmp.d %s0, %s0, %s4
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, 1.200000e+01
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i32 %2, i32 %3
  ret i32 %8
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_dcomp_64_i(double %0, double %1, i64 %2, i64 %3) {
; CHECK-LABEL: func_dcomp_64_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s4, 1076363264
; CHECK-NEXT:    fcmp.d %s0, %s0, %s4
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, 1.200000e+01
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i64 %2, i64 %3
  ret i64 %8
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_dcomp_u64_i(double %0, double %1, i64 %2, i64 %3) {
; CHECK-LABEL: func_dcomp_u64_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s4, 1076363264
; CHECK-NEXT:    fcmp.d %s0, %s0, %s4
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, 1.200000e+01
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i64 %2, i64 %3
  ret i64 %8
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_dcomp_128_i(double %0, double %1, i128 %2, i128 %3) {
; CHECK-LABEL: func_dcomp_128_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s6, 1076363264
; CHECK-NEXT:    fcmp.d %s0, %s0, %s6
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    or %s7, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s7, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s1
; CHECK-NEXT:    and %s0, %s7, %s6
; CHECK-NEXT:    cmov.w.ne %s4, %s2, %s0
; CHECK-NEXT:    cmov.w.ne %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, 1.200000e+01
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i128 %2, i128 %3
  ret i128 %8
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_dcomp_u128_i(double %0, double %1, i128 %2, i128 %3) {
; CHECK-LABEL: func_dcomp_u128_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s6, 1076363264
; CHECK-NEXT:    fcmp.d %s0, %s0, %s6
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    or %s7, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s7, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s1
; CHECK-NEXT:    and %s0, %s7, %s6
; CHECK-NEXT:    cmov.w.ne %s4, %s2, %s0
; CHECK-NEXT:    cmov.w.ne %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, 1.200000e+01
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i128 %2, i128 %3
  ret i128 %8
}

; Function Attrs: norecurse nounwind readnone
define float @func_dcomp_float_i(double %0, double %1, float %2, float %3) {
; CHECK-LABEL: func_dcomp_float_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s4, 1076363264
; CHECK-NEXT:    fcmp.d %s0, %s0, %s4
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, 1.200000e+01
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, float %2, float %3
  ret float %8
}

; Function Attrs: norecurse nounwind readnone
define double @func_dcomp_double_i(double %0, double %1, double %2, double %3) {
; CHECK-LABEL: func_dcomp_double_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s4, 1076363264
; CHECK-NEXT:    fcmp.d %s0, %s0, %s4
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, 1.200000e+01
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, double %2, double %3
  ret double %8
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_dcomp_quad_i(double %0, double %1, fp128 %2, fp128 %3) {
; CHECK-LABEL: func_dcomp_quad_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s6, 1076363264
; CHECK-NEXT:    fcmp.d %s0, %s0, %s6
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    or %s7, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s7, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s1
; CHECK-NEXT:    and %s0, %s7, %s6
; CHECK-NEXT:    cmov.w.ne %s4, %s2, %s0
; CHECK-NEXT:    cmov.w.ne %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, 1.200000e+01
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, fp128 %2, fp128 %3
  ret fp128 %8
}

; Function Attrs: norecurse nounwind readnone
define { float, float } @func_dcomp_fcomp_i(double %0, double %1, float %2, float %3, float %4, float %5) {
; CHECK-LABEL: func_dcomp_fcomp_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s6, 1076363264
; CHECK-NEXT:    fcmp.d %s0, %s0, %s6
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    or %s7, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s7, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s1
; CHECK-NEXT:    and %s0, %s7, %s6
; CHECK-NEXT:    cmov.w.ne %s4, %s2, %s0
; CHECK-NEXT:    cmov.w.ne %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq double %0, 1.200000e+01
  %8 = fcmp oeq double %1, 0.000000e+00
  %9 = and i1 %7, %8
  %10 = select i1 %9, float %2, float %4
  %11 = select i1 %9, float %3, float %5
  %12 = insertvalue { float, float } undef, float %10, 0
  %13 = insertvalue { float, float } %12, float %11, 1
  ret { float, float } %13
}

; Function Attrs: norecurse nounwind readnone
define { double, double } @func_dcomp_dcomp_i(double %0, double %1, double %2, double %3, double %4, double %5) {
; CHECK-LABEL: func_dcomp_dcomp_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea.sl %s6, 1076363264
; CHECK-NEXT:    fcmp.d %s0, %s0, %s6
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    or %s7, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s7, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s1
; CHECK-NEXT:    and %s0, %s7, %s6
; CHECK-NEXT:    cmov.w.ne %s4, %s2, %s0
; CHECK-NEXT:    cmov.w.ne %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq double %0, 1.200000e+01
  %8 = fcmp oeq double %1, 0.000000e+00
  %9 = and i1 %7, %8
  %10 = select i1 %9, double %2, double %4
  %11 = select i1 %9, double %3, double %5
  %12 = insertvalue { double, double } undef, double %10, 0
  %13 = insertvalue { double, double } %12, double %11, 1
  ret { double, double } %13
}

; Function Attrs: norecurse nounwind readnone
define { fp128, fp128 } @func_dcomp_qcomp_i(double %0, double %1, fp128 %2, fp128 %3, fp128 %4, fp128 %5) {
; CHECK-LABEL: func_dcomp_qcomp_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld %s35, 240(, %s11)
; CHECK-NEXT:    ld %s34, 248(, %s11)
; CHECK-NEXT:    lea.sl %s36, 1076363264
; CHECK-NEXT:    fcmp.d %s0, %s0, %s36
; CHECK-NEXT:    or %s36, 0, (0)1
; CHECK-NEXT:    or %s37, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s37, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s36, (63)0, %s1
; CHECK-NEXT:    and %s0, %s37, %s36
; CHECK-NEXT:    cmov.w.ne %s6, %s2, %s0
; CHECK-NEXT:    cmov.w.ne %s7, %s3, %s0
; CHECK-NEXT:    cmov.w.ne %s34, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s35, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    or %s2, 0, %s34
; CHECK-NEXT:    or %s3, 0, %s35
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq double %0, 1.200000e+01
  %8 = fcmp oeq double %1, 0.000000e+00
  %9 = and i1 %7, %8
  %10 = select i1 %9, fp128 %2, fp128 %4
  %11 = select i1 %9, fp128 %3, fp128 %5
  %12 = insertvalue { fp128, fp128 } undef, fp128 %10, 0
  %13 = insertvalue { fp128, fp128 } %12, fp128 %11, 1
  ret { fp128, fp128 } %13
}

; Function Attrs: norecurse nounwind readnone
define zeroext i1 @func_dcomp_1_m(double %0, double %1, i1 zeroext %2, i1 zeroext %3) {
; CHECK-LABEL: func_dcomp_1_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, (2)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, -2.000000e+00
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i1 %2, i1 %3
  ret i1 %8
}

; Function Attrs: norecurse nounwind readnone
define signext i8 @func_dcomp_8_m(double %0, double %1, i8 signext %2, i8 signext %3) {
; CHECK-LABEL: func_dcomp_8_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, (2)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, -2.000000e+00
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i8 %2, i8 %3
  ret i8 %8
}

; Function Attrs: norecurse nounwind readnone
define zeroext i8 @func_dcomp_u8_m(double %0, double %1, i8 zeroext %2, i8 zeroext %3) {
; CHECK-LABEL: func_dcomp_u8_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, (2)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, -2.000000e+00
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i8 %2, i8 %3
  ret i8 %8
}

; Function Attrs: norecurse nounwind readnone
define signext i16 @func_dcomp_16_m(double %0, double %1, i16 signext %2, i16 signext %3) {
; CHECK-LABEL: func_dcomp_16_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, (2)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, -2.000000e+00
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i16 %2, i16 %3
  ret i16 %8
}

; Function Attrs: norecurse nounwind readnone
define zeroext i16 @func_dcomp_u16_m(double %0, double %1, i16 zeroext %2, i16 zeroext %3) {
; CHECK-LABEL: func_dcomp_u16_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, (2)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, -2.000000e+00
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i16 %2, i16 %3
  ret i16 %8
}

; Function Attrs: norecurse nounwind readnone
define signext i32 @func_dcomp_32_m(double %0, double %1, i32 signext %2, i32 signext %3) {
; CHECK-LABEL: func_dcomp_32_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, (2)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, -2.000000e+00
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i32 %2, i32 %3
  ret i32 %8
}

; Function Attrs: norecurse nounwind readnone
define zeroext i32 @func_dcomp_u32_m(double %0, double %1, i32 zeroext %2, i32 zeroext %3) {
; CHECK-LABEL: func_dcomp_u32_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, (2)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, -2.000000e+00
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i32 %2, i32 %3
  ret i32 %8
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_dcomp_64_m(double %0, double %1, i64 %2, i64 %3) {
; CHECK-LABEL: func_dcomp_64_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, (2)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, -2.000000e+00
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i64 %2, i64 %3
  ret i64 %8
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_dcomp_u64_m(double %0, double %1, i64 %2, i64 %3) {
; CHECK-LABEL: func_dcomp_u64_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, (2)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, -2.000000e+00
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i64 %2, i64 %3
  ret i64 %8
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_dcomp_128_m(double %0, double %1, i128 %2, i128 %3) {
; CHECK-LABEL: func_dcomp_128_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, (2)1
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    or %s7, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s7, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s1
; CHECK-NEXT:    and %s0, %s7, %s6
; CHECK-NEXT:    cmov.w.ne %s4, %s2, %s0
; CHECK-NEXT:    cmov.w.ne %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, -2.000000e+00
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i128 %2, i128 %3
  ret i128 %8
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_dcomp_u128_m(double %0, double %1, i128 %2, i128 %3) {
; CHECK-LABEL: func_dcomp_u128_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, (2)1
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    or %s7, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s7, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s1
; CHECK-NEXT:    and %s0, %s7, %s6
; CHECK-NEXT:    cmov.w.ne %s4, %s2, %s0
; CHECK-NEXT:    cmov.w.ne %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, -2.000000e+00
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, i128 %2, i128 %3
  ret i128 %8
}

; Function Attrs: norecurse nounwind readnone
define float @func_dcomp_float_m(double %0, double %1, float %2, float %3) {
; CHECK-LABEL: func_dcomp_float_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, (2)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, -2.000000e+00
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, float %2, float %3
  ret float %8
}

; Function Attrs: norecurse nounwind readnone
define double @func_dcomp_double_m(double %0, double %1, double %2, double %3) {
; CHECK-LABEL: func_dcomp_double_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, (2)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s5, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s1
; CHECK-NEXT:    and %s0, %s5, %s4
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, -2.000000e+00
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, double %2, double %3
  ret double %8
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_dcomp_quad_m(double %0, double %1, fp128 %2, fp128 %3) {
; CHECK-LABEL: func_dcomp_quad_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, (2)1
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    or %s7, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s7, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s1
; CHECK-NEXT:    and %s0, %s7, %s6
; CHECK-NEXT:    cmov.w.ne %s4, %s2, %s0
; CHECK-NEXT:    cmov.w.ne %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq double %0, -2.000000e+00
  %6 = fcmp oeq double %1, 0.000000e+00
  %7 = and i1 %5, %6
  %8 = select i1 %7, fp128 %2, fp128 %3
  ret fp128 %8
}

; Function Attrs: norecurse nounwind readnone
define { float, float } @func_dcomp_fcomp_m(double %0, double %1, float %2, float %3, float %4, float %5) {
; CHECK-LABEL: func_dcomp_fcomp_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, (2)1
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    or %s7, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s7, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s1
; CHECK-NEXT:    and %s0, %s7, %s6
; CHECK-NEXT:    cmov.w.ne %s4, %s2, %s0
; CHECK-NEXT:    cmov.w.ne %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq double %0, -2.000000e+00
  %8 = fcmp oeq double %1, 0.000000e+00
  %9 = and i1 %7, %8
  %10 = select i1 %9, float %2, float %4
  %11 = select i1 %9, float %3, float %5
  %12 = insertvalue { float, float } undef, float %10, 0
  %13 = insertvalue { float, float } %12, float %11, 1
  ret { float, float } %13
}

; Function Attrs: norecurse nounwind readnone
define { double, double } @func_dcomp_dcomp_m(double %0, double %1, double %2, double %3, double %4, double %5) {
; CHECK-LABEL: func_dcomp_dcomp_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, (2)1
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    or %s7, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s7, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s1
; CHECK-NEXT:    and %s0, %s7, %s6
; CHECK-NEXT:    cmov.w.ne %s4, %s2, %s0
; CHECK-NEXT:    cmov.w.ne %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq double %0, -2.000000e+00
  %8 = fcmp oeq double %1, 0.000000e+00
  %9 = and i1 %7, %8
  %10 = select i1 %9, double %2, double %4
  %11 = select i1 %9, double %3, double %5
  %12 = insertvalue { double, double } undef, double %10, 0
  %13 = insertvalue { double, double } %12, double %11, 1
  ret { double, double } %13
}

; Function Attrs: norecurse nounwind readnone
define { fp128, fp128 } @func_dcomp_qcomp_m(double %0, double %1, fp128 %2, fp128 %3, fp128 %4, fp128 %5) {
; CHECK-LABEL: func_dcomp_qcomp_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld %s35, 240(, %s11)
; CHECK-NEXT:    ld %s34, 248(, %s11)
; CHECK-NEXT:    fcmp.d %s0, %s0, (2)1
; CHECK-NEXT:    or %s36, 0, (0)1
; CHECK-NEXT:    or %s37, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s37, (63)0, %s0
; CHECK-NEXT:    cmov.d.eq %s36, (63)0, %s1
; CHECK-NEXT:    and %s0, %s37, %s36
; CHECK-NEXT:    cmov.w.ne %s6, %s2, %s0
; CHECK-NEXT:    cmov.w.ne %s7, %s3, %s0
; CHECK-NEXT:    cmov.w.ne %s34, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s35, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    or %s2, 0, %s34
; CHECK-NEXT:    or %s3, 0, %s35
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq double %0, -2.000000e+00
  %8 = fcmp oeq double %1, 0.000000e+00
  %9 = and i1 %7, %8
  %10 = select i1 %9, fp128 %2, fp128 %4
  %11 = select i1 %9, fp128 %3, fp128 %5
  %12 = insertvalue { fp128, fp128 } undef, fp128 %10, 0
  %13 = insertvalue { fp128, fp128 } %12, fp128 %11, 1
  ret { fp128, fp128 } %13
}
