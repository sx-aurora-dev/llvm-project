; RUN: llc < %s -mtriple=ve | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define zeroext i1 @func_1_1(i1 zeroext %0, i1 zeroext %1, i1 zeroext %2, i1 zeroext %3) {
; CHECK-LABEL: func_1_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xor %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.ne %s2, %s3, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s2, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = xor i1 %0, %1
  %6 = select i1 %5, i1 %3, i1 %2
  ret i1 %6
}

; Function Attrs: norecurse nounwind readnone
define signext i8 @func_1_8(i1 zeroext %0, i1 zeroext %1, i8 signext %2, i8 signext %3) {
; CHECK-LABEL: func_1_8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xor %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.ne %s2, %s3, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s2, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = xor i1 %0, %1
  %6 = select i1 %5, i8 %3, i8 %2
  ret i8 %6
}

; Function Attrs: norecurse nounwind readnone
define zeroext i8 @func_1_u8(i1 zeroext %0, i1 zeroext %1, i8 zeroext %2, i8 zeroext %3) {
; CHECK-LABEL: func_1_u8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xor %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.ne %s2, %s3, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s2, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = xor i1 %0, %1
  %6 = select i1 %5, i8 %3, i8 %2
  ret i8 %6
}

; Function Attrs: norecurse nounwind readnone
define signext i16 @func_1_16(i1 zeroext %0, i1 zeroext %1, i16 signext %2, i16 signext %3) {
; CHECK-LABEL: func_1_16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xor %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.ne %s2, %s3, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s2, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = xor i1 %0, %1
  %6 = select i1 %5, i16 %3, i16 %2
  ret i16 %6
}

; Function Attrs: norecurse nounwind readnone
define zeroext i16 @func_1_u16(i1 zeroext %0, i1 zeroext %1, i16 zeroext %2, i16 zeroext %3) {
; CHECK-LABEL: func_1_u16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xor %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.ne %s2, %s3, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s2, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = xor i1 %0, %1
  %6 = select i1 %5, i16 %3, i16 %2
  ret i16 %6
}

; Function Attrs: norecurse nounwind readnone
define signext i32 @func_1_32(i1 zeroext %0, i1 zeroext %1, i32 signext %2, i32 signext %3) {
; CHECK-LABEL: func_1_32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xor %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.ne %s2, %s3, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s2, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = xor i1 %0, %1
  %6 = select i1 %5, i32 %3, i32 %2
  ret i32 %6
}

; Function Attrs: norecurse nounwind readnone
define zeroext i32 @func_1_u32(i1 zeroext %0, i1 zeroext %1, i32 zeroext %2, i32 zeroext %3) {
; CHECK-LABEL: func_1_u32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xor %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.ne %s2, %s3, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s2, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = xor i1 %0, %1
  %6 = select i1 %5, i32 %3, i32 %2
  ret i32 %6
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_1_64(i1 zeroext %0, i1 zeroext %1, i64 %2, i64 %3) {
; CHECK-LABEL: func_1_64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xor %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.ne %s2, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = xor i1 %0, %1
  %6 = select i1 %5, i64 %3, i64 %2
  ret i64 %6
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_1_u64(i1 zeroext %0, i1 zeroext %1, i64 %2, i64 %3) {
; CHECK-LABEL: func_1_u64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xor %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.ne %s2, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = xor i1 %0, %1
  %6 = select i1 %5, i64 %3, i64 %2
  ret i64 %6
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_1_128(i1 zeroext %0, i1 zeroext %1, i128 %2, i128 %3) {
; CHECK-LABEL: func_1_128:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xor %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.ne %s2, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s3, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    or %s1, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = xor i1 %0, %1
  %6 = select i1 %5, i128 %3, i128 %2
  ret i128 %6
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_1_u128(i1 zeroext %0, i1 zeroext %1, i128 %2, i128 %3) {
; CHECK-LABEL: func_1_u128:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xor %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.ne %s2, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s3, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    or %s1, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = xor i1 %0, %1
  %6 = select i1 %5, i128 %3, i128 %2
  ret i128 %6
}

; Function Attrs: norecurse nounwind readnone
define float @func_1_float(i1 zeroext %0, i1 zeroext %1, float %2, float %3) {
; CHECK-LABEL: func_1_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xor %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.ne %s2, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = xor i1 %0, %1
  %6 = select i1 %5, float %3, float %2
  ret float %6
}

; Function Attrs: norecurse nounwind readnone
define double @func_1_double(i1 zeroext %0, i1 zeroext %1, double %2, double %3) {
; CHECK-LABEL: func_1_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xor %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.ne %s2, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = xor i1 %0, %1
  %6 = select i1 %5, double %3, double %2
  ret double %6
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_1_quad(i1 zeroext %0, i1 zeroext %1, fp128 %2, fp128 %3) {
; CHECK-LABEL: func_1_quad:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xor %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.ne %s2, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s3, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    or %s1, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = xor i1 %0, %1
  %6 = select i1 %5, fp128 %3, fp128 %2
  ret fp128 %6
}

; Function Attrs: norecurse nounwind readnone
define { float, float } @func_1_fcomp(i1 zeroext %0, i1 zeroext %1, float %2, float %3, float %4, float %5) {
; CHECK-LABEL: func_1_fcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xor %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.ne %s2, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s3, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    or %s1, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = xor i1 %0, %1
  %8 = select i1 %7, float %4, float %2
  %9 = select i1 %7, float %5, float %3
  %10 = insertvalue { float, float } undef, float %8, 0
  %11 = insertvalue { float, float } %10, float %9, 1
  ret { float, float } %11
}

; Function Attrs: norecurse nounwind readnone
define { double, double } @func_1_dcomp(i1 zeroext %0, i1 zeroext %1, double %2, double %3, double %4, double %5) {
; CHECK-LABEL: func_1_dcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xor %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.ne %s2, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s3, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    or %s1, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = xor i1 %0, %1
  %8 = select i1 %7, double %4, double %2
  %9 = select i1 %7, double %5, double %3
  %10 = insertvalue { double, double } undef, double %8, 0
  %11 = insertvalue { double, double } %10, double %9, 1
  ret { double, double } %11
}

; Function Attrs: norecurse nounwind readnone
define { fp128, fp128 } @func_1_qcomp(i1 zeroext %0, i1 zeroext %1, fp128 %2, fp128 %3, fp128 %4, fp128 %5) {
; CHECK-LABEL: func_1_qcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld %s35, 416(, %s11)
; CHECK-NEXT:    ld %s34, 424(, %s11)
; CHECK-NEXT:    xor %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.ne %s2, %s6, %s0
; CHECK-NEXT:    cmov.w.ne %s3, %s7, %s0
; CHECK-NEXT:    cmov.w.ne %s4, %s34, %s0
; CHECK-NEXT:    cmov.w.ne %s5, %s35, %s0
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    or %s1, 0, %s3
; CHECK-NEXT:    or %s2, 0, %s4
; CHECK-NEXT:    or %s3, 0, %s5
; CHECK-NEXT:    or %s11, 0, %s9
  %7 = xor i1 %0, %1
  %8 = select i1 %7, fp128 %4, fp128 %2
  %9 = select i1 %7, fp128 %5, fp128 %3
  %10 = insertvalue { fp128, fp128 } undef, fp128 %8, 0
  %11 = insertvalue { fp128, fp128 } %10, fp128 %9, 1
  ret { fp128, fp128 } %11
}

; Function Attrs: norecurse nounwind readnone
define zeroext i1 @func_1_1_zero(i1 zeroext %0, i1 zeroext %1, i1 zeroext %2) {
; CHECK-LABEL: func_1_1_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s1, %s2, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s1, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i1 %2, i1 %1
  ret i1 %4
}

; Function Attrs: norecurse nounwind readnone
define signext i8 @func_1_8_zero(i1 zeroext %0, i8 signext %1, i8 signext %2) {
; CHECK-LABEL: func_1_8_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s1, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s1, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i8 %2, i8 %1
  ret i8 %4
}

; Function Attrs: norecurse nounwind readnone
define zeroext i8 @func_1_u8_zero(i1 zeroext %0, i8 zeroext %1, i8 zeroext %2) {
; CHECK-LABEL: func_1_u8_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s1, %s2, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s1, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i8 %2, i8 %1
  ret i8 %4
}

; Function Attrs: norecurse nounwind readnone
define signext i16 @func_1_16_zero(i1 zeroext %0, i16 signext %1, i16 signext %2) {
; CHECK-LABEL: func_1_16_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s1, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s1, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i16 %2, i16 %1
  ret i16 %4
}

; Function Attrs: norecurse nounwind readnone
define zeroext i16 @func_1_u16_zero(i1 zeroext %0, i16 zeroext %1, i16 zeroext %2) {
; CHECK-LABEL: func_1_u16_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s1, %s2, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s1, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i16 %2, i16 %1
  ret i16 %4
}

; Function Attrs: norecurse nounwind readnone
define signext i32 @func_1_32_zero(i1 zeroext %0, i32 signext %1, i32 signext %2) {
; CHECK-LABEL: func_1_32_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s1, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s1, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i32 %2, i32 %1
  ret i32 %4
}

; Function Attrs: norecurse nounwind readnone
define zeroext i32 @func_1_u32_zero(i1 zeroext %0, i32 zeroext %1, i32 zeroext %2) {
; CHECK-LABEL: func_1_u32_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s1, %s2, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s1, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i32 %2, i32 %1
  ret i32 %4
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_1_64_zero(i1 zeroext %0, i64 %1, i64 %2) {
; CHECK-LABEL: func_1_64_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s1, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i64 %2, i64 %1
  ret i64 %4
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_1_u64_zero(i1 zeroext %0, i64 %1, i64 %2) {
; CHECK-LABEL: func_1_u64_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s1, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i64 %2, i64 %1
  ret i64 %4
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_1_128_zero(i1 zeroext %0, i128 %1, i128 %2) {
; CHECK-LABEL: func_1_128_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s1, %s3, %s0
; CHECK-NEXT:    cmov.w.ne %s2, %s4, %s0
; CHECK-NEXT:    or %s0, 0, %s1
; CHECK-NEXT:    or %s1, 0, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i128 %2, i128 %1
  ret i128 %4
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_1_u128_zero(i1 zeroext %0, i128 %1, i128 %2) {
; CHECK-LABEL: func_1_u128_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s1, %s3, %s0
; CHECK-NEXT:    cmov.w.ne %s2, %s4, %s0
; CHECK-NEXT:    or %s0, 0, %s1
; CHECK-NEXT:    or %s1, 0, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i128 %2, i128 %1
  ret i128 %4
}

; Function Attrs: norecurse nounwind readnone
define float @func_1_float_zero(i1 zeroext %0, float %1, float %2) {
; CHECK-LABEL: func_1_float_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s1, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, float %2, float %1
  ret float %4
}

; Function Attrs: norecurse nounwind readnone
define double @func_1_double_zero(i1 zeroext %0, double %1, double %2) {
; CHECK-LABEL: func_1_double_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s1, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, double %2, double %1
  ret double %4
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_1_quad_zero(i1 zeroext %0, fp128 %1, fp128 %2) {
; CHECK-LABEL: func_1_quad_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s3, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    or %s1, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, fp128 %2, fp128 %1
  ret fp128 %4
}

; Function Attrs: norecurse nounwind readnone
define { float, float } @func_1_fcomp_zero(i1 zeroext %0, float %1, float %2, float %3, float %4) {
; CHECK-LABEL: func_1_fcomp_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s1, %s3, %s0
; CHECK-NEXT:    cmov.w.ne %s2, %s4, %s0
; CHECK-NEXT:    or %s0, 0, %s1
; CHECK-NEXT:    or %s1, 0, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %6 = select i1 %0, float %3, float %1
  %7 = select i1 %0, float %4, float %2
  %8 = insertvalue { float, float } undef, float %6, 0
  %9 = insertvalue { float, float } %8, float %7, 1
  ret { float, float } %9
}

; Function Attrs: norecurse nounwind readnone
define { double, double } @func_1_dcomp_zero(i1 zeroext %0, double %1, double %2, double %3, double %4) {
; CHECK-LABEL: func_1_dcomp_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s1, %s3, %s0
; CHECK-NEXT:    cmov.w.ne %s2, %s4, %s0
; CHECK-NEXT:    or %s0, 0, %s1
; CHECK-NEXT:    or %s1, 0, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %6 = select i1 %0, double %3, double %1
  %7 = select i1 %0, double %4, double %2
  %8 = insertvalue { double, double } undef, double %6, 0
  %9 = insertvalue { double, double } %8, double %7, 1
  ret { double, double } %9
}

; Function Attrs: norecurse nounwind readnone
define { fp128, fp128 } @func_1_qcomp_zero(i1 zeroext %0, fp128 %1, fp128 %2, fp128 %3, fp128 %4) {
; CHECK-LABEL: func_1_qcomp_zero:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld %s35, 416(, %s11)
; CHECK-NEXT:    ld %s34, 424(, %s11)
; CHECK-NEXT:    cmov.w.ne %s2, %s6, %s0
; CHECK-NEXT:    cmov.w.ne %s3, %s7, %s0
; CHECK-NEXT:    cmov.w.ne %s4, %s34, %s0
; CHECK-NEXT:    cmov.w.ne %s5, %s35, %s0
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    or %s1, 0, %s3
; CHECK-NEXT:    or %s2, 0, %s4
; CHECK-NEXT:    or %s3, 0, %s5
; CHECK-NEXT:    or %s11, 0, %s9
  %6 = select i1 %0, fp128 %3, fp128 %1
  %7 = select i1 %0, fp128 %4, fp128 %2
  %8 = insertvalue { fp128, fp128 } undef, fp128 %6, 0
  %9 = insertvalue { fp128, fp128 } %8, fp128 %7, 1
  ret { fp128, fp128 } %9
}

; Function Attrs: norecurse nounwind readnone
define zeroext i1 @func_1_1_i(i1 zeroext %0, i1 zeroext %1, i1 zeroext %2) {
; CHECK-LABEL: func_1_1_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s2, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i1 %1, i1 %2
  ret i1 %4
}

; Function Attrs: norecurse nounwind readnone
define signext i8 @func_1_8_i(i1 zeroext %0, i8 signext %1, i8 signext %2) {
; CHECK-LABEL: func_1_8_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s2, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i8 %1, i8 %2
  ret i8 %4
}

; Function Attrs: norecurse nounwind readnone
define zeroext i8 @func_1_u8_i(i1 zeroext %0, i8 zeroext %1, i8 zeroext %2) {
; CHECK-LABEL: func_1_u8_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s2, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i8 %1, i8 %2
  ret i8 %4
}

; Function Attrs: norecurse nounwind readnone
define signext i16 @func_1_16_i(i1 zeroext %0, i16 signext %1, i16 signext %2) {
; CHECK-LABEL: func_1_16_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s2, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i16 %1, i16 %2
  ret i16 %4
}

; Function Attrs: norecurse nounwind readnone
define zeroext i16 @func_1_u16_i(i1 zeroext %0, i16 zeroext %1, i16 zeroext %2) {
; CHECK-LABEL: func_1_u16_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s2, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i16 %1, i16 %2
  ret i16 %4
}

; Function Attrs: norecurse nounwind readnone
define signext i32 @func_1_32_i(i1 zeroext %0, i32 signext %1, i32 signext %2) {
; CHECK-LABEL: func_1_32_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s2, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i32 %1, i32 %2
  ret i32 %4
}

; Function Attrs: norecurse nounwind readnone
define zeroext i32 @func_1_u32_i(i1 zeroext %0, i32 zeroext %1, i32 zeroext %2) {
; CHECK-LABEL: func_1_u32_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s2, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i32 %1, i32 %2
  ret i32 %4
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_1_64_i(i1 zeroext %0, i64 %1, i64 %2) {
; CHECK-LABEL: func_1_64_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i64 %1, i64 %2
  ret i64 %4
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_1_u64_i(i1 zeroext %0, i64 %1, i64 %2) {
; CHECK-LABEL: func_1_u64_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i64 %1, i64 %2
  ret i64 %4
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_1_128_i(i1 zeroext %0, i128 %1, i128 %2) {
; CHECK-LABEL: func_1_128_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s3, %s1, %s0
; CHECK-NEXT:    cmov.w.ne %s4, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    or %s1, 0, %s4
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i128 %1, i128 %2
  ret i128 %4
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_1_u128_i(i1 zeroext %0, i128 %1, i128 %2) {
; CHECK-LABEL: func_1_u128_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s3, %s1, %s0
; CHECK-NEXT:    cmov.w.ne %s4, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    or %s1, 0, %s4
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i128 %1, i128 %2
  ret i128 %4
}

; Function Attrs: norecurse nounwind readnone
define float @func_1_float_i(i1 zeroext %0, float %1, float %2) {
; CHECK-LABEL: func_1_float_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, float %1, float %2
  ret float %4
}

; Function Attrs: norecurse nounwind readnone
define double @func_1_double_i(i1 zeroext %0, double %1, double %2) {
; CHECK-LABEL: func_1_double_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, double %1, double %2
  ret double %4
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_1_quad_i(i1 zeroext %0, fp128 %1, fp128 %2) {
; CHECK-LABEL: func_1_quad_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s4, %s2, %s0
; CHECK-NEXT:    cmov.w.ne %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, fp128 %1, fp128 %2
  ret fp128 %4
}

; Function Attrs: norecurse nounwind readnone
define { float, float } @func_1_fcomp_i(i1 zeroext %0, float %1, float %2, float %3, float %4) {
; CHECK-LABEL: func_1_fcomp_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s3, %s1, %s0
; CHECK-NEXT:    cmov.w.ne %s4, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    or %s1, 0, %s4
; CHECK-NEXT:    b.l.t (, %s10)
  %6 = select i1 %0, float %1, float %3
  %7 = select i1 %0, float %2, float %4
  %8 = insertvalue { float, float } undef, float %6, 0
  %9 = insertvalue { float, float } %8, float %7, 1
  ret { float, float } %9
}

; Function Attrs: norecurse nounwind readnone
define { double, double } @func_1_dcomp_i(i1 zeroext %0, double %1, double %2, double %3, double %4) {
; CHECK-LABEL: func_1_dcomp_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s3, %s1, %s0
; CHECK-NEXT:    cmov.w.ne %s4, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    or %s1, 0, %s4
; CHECK-NEXT:    b.l.t (, %s10)
  %6 = select i1 %0, double %1, double %3
  %7 = select i1 %0, double %2, double %4
  %8 = insertvalue { double, double } undef, double %6, 0
  %9 = insertvalue { double, double } %8, double %7, 1
  ret { double, double } %9
}

; Function Attrs: norecurse nounwind readnone
define { fp128, fp128 } @func_1_qcomp_i(i1 zeroext %0, fp128 %1, fp128 %2, fp128 %3, fp128 %4) {
; CHECK-LABEL: func_1_qcomp_i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld %s35, 416(, %s11)
; CHECK-NEXT:    ld %s34, 424(, %s11)
; CHECK-NEXT:    cmov.w.ne %s6, %s2, %s0
; CHECK-NEXT:    cmov.w.ne %s7, %s3, %s0
; CHECK-NEXT:    cmov.w.ne %s34, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s35, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    or %s2, 0, %s34
; CHECK-NEXT:    or %s3, 0, %s35
; CHECK-NEXT:    or %s11, 0, %s9
  %6 = select i1 %0, fp128 %1, fp128 %3
  %7 = select i1 %0, fp128 %2, fp128 %4
  %8 = insertvalue { fp128, fp128 } undef, fp128 %6, 0
  %9 = insertvalue { fp128, fp128 } %8, fp128 %7, 1
  ret { fp128, fp128 } %9
}

; Function Attrs: norecurse nounwind readnone
define zeroext i1 @func_1_1_m(i1 zeroext %0, i1 zeroext %1, i1 zeroext %2) {
; CHECK-LABEL: func_1_1_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s2, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i1 %1, i1 %2
  ret i1 %4
}

; Function Attrs: norecurse nounwind readnone
define signext i8 @func_1_8_m(i1 zeroext %0, i8 signext %1, i8 signext %2) {
; CHECK-LABEL: func_1_8_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s2, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i8 %1, i8 %2
  ret i8 %4
}

; Function Attrs: norecurse nounwind readnone
define zeroext i8 @func_1_u8_m(i1 zeroext %0, i8 zeroext %1, i8 zeroext %2) {
; CHECK-LABEL: func_1_u8_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s2, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i8 %1, i8 %2
  ret i8 %4
}

; Function Attrs: norecurse nounwind readnone
define signext i16 @func_1_16_m(i1 zeroext %0, i16 signext %1, i16 signext %2) {
; CHECK-LABEL: func_1_16_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s2, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i16 %1, i16 %2
  ret i16 %4
}

; Function Attrs: norecurse nounwind readnone
define zeroext i16 @func_1_u16_m(i1 zeroext %0, i16 zeroext %1, i16 zeroext %2) {
; CHECK-LABEL: func_1_u16_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s2, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i16 %1, i16 %2
  ret i16 %4
}

; Function Attrs: norecurse nounwind readnone
define signext i32 @func_1_32_m(i1 zeroext %0, i32 signext %1, i32 signext %2) {
; CHECK-LABEL: func_1_32_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s2, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i32 %1, i32 %2
  ret i32 %4
}

; Function Attrs: norecurse nounwind readnone
define zeroext i32 @func_1_u32_m(i1 zeroext %0, i32 zeroext %1, i32 zeroext %2) {
; CHECK-LABEL: func_1_u32_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s2, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i32 %1, i32 %2
  ret i32 %4
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_1_64_m(i1 zeroext %0, i64 %1, i64 %2) {
; CHECK-LABEL: func_1_64_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i64 %1, i64 %2
  ret i64 %4
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_1_u64_m(i1 zeroext %0, i64 %1, i64 %2) {
; CHECK-LABEL: func_1_u64_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i64 %1, i64 %2
  ret i64 %4
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_1_128_m(i1 zeroext %0, i128 %1, i128 %2) {
; CHECK-LABEL: func_1_128_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s3, %s1, %s0
; CHECK-NEXT:    cmov.w.ne %s4, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    or %s1, 0, %s4
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i128 %1, i128 %2
  ret i128 %4
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_1_u128_m(i1 zeroext %0, i128 %1, i128 %2) {
; CHECK-LABEL: func_1_u128_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s3, %s1, %s0
; CHECK-NEXT:    cmov.w.ne %s4, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    or %s1, 0, %s4
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i128 %1, i128 %2
  ret i128 %4
}

; Function Attrs: norecurse nounwind readnone
define float @func_1_float_m(i1 zeroext %0, float %1, float %2) {
; CHECK-LABEL: func_1_float_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, float %1, float %2
  ret float %4
}

; Function Attrs: norecurse nounwind readnone
define double @func_1_double_m(i1 zeroext %0, double %1, double %2) {
; CHECK-LABEL: func_1_double_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, double %1, double %2
  ret double %4
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_1_quad_m(i1 zeroext %0, fp128 %1, fp128 %2) {
; CHECK-LABEL: func_1_quad_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s4, %s2, %s0
; CHECK-NEXT:    cmov.w.ne %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, fp128 %1, fp128 %2
  ret fp128 %4
}

; Function Attrs: norecurse nounwind readnone
define { float, float } @func_1_fcomp_m(i1 zeroext %0, float %1, float %2, float %3, float %4) {
; CHECK-LABEL: func_1_fcomp_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s3, %s1, %s0
; CHECK-NEXT:    cmov.w.ne %s4, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    or %s1, 0, %s4
; CHECK-NEXT:    b.l.t (, %s10)
  %6 = select i1 %0, float %1, float %3
  %7 = select i1 %0, float %2, float %4
  %8 = insertvalue { float, float } undef, float %6, 0
  %9 = insertvalue { float, float } %8, float %7, 1
  ret { float, float } %9
}

; Function Attrs: norecurse nounwind readnone
define { double, double } @func_1_dcomp_m(i1 zeroext %0, double %1, double %2, double %3, double %4) {
; CHECK-LABEL: func_1_dcomp_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s3, %s1, %s0
; CHECK-NEXT:    cmov.w.ne %s4, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    or %s1, 0, %s4
; CHECK-NEXT:    b.l.t (, %s10)
  %6 = select i1 %0, double %1, double %3
  %7 = select i1 %0, double %2, double %4
  %8 = insertvalue { double, double } undef, double %6, 0
  %9 = insertvalue { double, double } %8, double %7, 1
  ret { double, double } %9
}

; Function Attrs: norecurse nounwind readnone
define { fp128, fp128 } @func_1_qcomp_m(i1 zeroext %0, fp128 %1, fp128 %2, fp128 %3, fp128 %4) {
; CHECK-LABEL: func_1_qcomp_m:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld %s35, 416(, %s11)
; CHECK-NEXT:    ld %s34, 424(, %s11)
; CHECK-NEXT:    cmov.w.ne %s6, %s2, %s0
; CHECK-NEXT:    cmov.w.ne %s7, %s3, %s0
; CHECK-NEXT:    cmov.w.ne %s34, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s35, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    or %s2, 0, %s34
; CHECK-NEXT:    or %s3, 0, %s35
; CHECK-NEXT:    or %s11, 0, %s9
  %6 = select i1 %0, fp128 %1, fp128 %3
  %7 = select i1 %0, fp128 %2, fp128 %4
  %8 = insertvalue { fp128, fp128 } undef, fp128 %6, 0
  %9 = insertvalue { fp128, fp128 } %8, fp128 %7, 1
  ret { fp128, fp128 } %9
}
