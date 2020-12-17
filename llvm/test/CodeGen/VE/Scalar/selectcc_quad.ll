; RUN: llc < %s -mtriple=ve | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define zeroext i1 @func_quad_1(fp128 %0, fp128 %1, i1 zeroext %2, i1 zeroext %3) {
; CHECK-LABEL: func_quad_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.q %s0, %s0, %s2
; CHECK-NEXT:    cmov.d.eq %s5, %s4, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, %1
  %6 = select i1 %5, i1 %2, i1 %3
  ret i1 %6
}

; Function Attrs: norecurse nounwind readnone
define signext i8 @func_quad_8(fp128 %0, fp128 %1, i8 signext %2, i8 signext %3) {
; CHECK-LABEL: func_quad_8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.q %s0, %s0, %s2
; CHECK-NEXT:    cmov.d.eq %s5, %s4, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, %1
  %6 = select i1 %5, i8 %2, i8 %3
  ret i8 %6
}

; Function Attrs: norecurse nounwind readnone
define zeroext i8 @func_quad_u8(fp128 %0, fp128 %1, i8 zeroext %2, i8 zeroext %3) {
; CHECK-LABEL: func_quad_u8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.q %s0, %s0, %s2
; CHECK-NEXT:    cmov.d.eq %s5, %s4, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, %1
  %6 = select i1 %5, i8 %2, i8 %3
  ret i8 %6
}

; Function Attrs: norecurse nounwind readnone
define signext i16 @func_quad_16(fp128 %0, fp128 %1, i16 signext %2, i16 signext %3) {
; CHECK-LABEL: func_quad_16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.q %s0, %s0, %s2
; CHECK-NEXT:    cmov.d.eq %s5, %s4, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, %1
  %6 = select i1 %5, i16 %2, i16 %3
  ret i16 %6
}

; Function Attrs: norecurse nounwind readnone
define zeroext i16 @func_quad_u16(fp128 %0, fp128 %1, i16 zeroext %2, i16 zeroext %3) {
; CHECK-LABEL: func_quad_u16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.q %s0, %s0, %s2
; CHECK-NEXT:    cmov.d.eq %s5, %s4, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, %1
  %6 = select i1 %5, i16 %2, i16 %3
  ret i16 %6
}

; Function Attrs: norecurse nounwind readnone
define signext i32 @func_quad_32(fp128 %0, fp128 %1, i32 signext %2, i32 signext %3) {
; CHECK-LABEL: func_quad_32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.q %s0, %s0, %s2
; CHECK-NEXT:    cmov.d.eq %s5, %s4, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, %1
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

; Function Attrs: norecurse nounwind readnone
define zeroext i32 @func_quad_u32(fp128 %0, fp128 %1, i32 zeroext %2, i32 zeroext %3) {
; CHECK-LABEL: func_quad_u32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.q %s0, %s0, %s2
; CHECK-NEXT:    cmov.d.eq %s5, %s4, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, %1
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_quad_64(fp128 %0, fp128 %1, i64 %2, i64 %3) {
; CHECK-LABEL: func_quad_64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.q %s0, %s0, %s2
; CHECK-NEXT:    cmov.d.eq %s5, %s4, %s0
; CHECK-NEXT:    or %s0, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, %1
  %6 = select i1 %5, i64 %2, i64 %3
  ret i64 %6
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_quad_u64(fp128 %0, fp128 %1, i64 %2, i64 %3) {
; CHECK-LABEL: func_quad_u64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.q %s0, %s0, %s2
; CHECK-NEXT:    cmov.d.eq %s5, %s4, %s0
; CHECK-NEXT:    or %s0, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, %1
  %6 = select i1 %5, i64 %2, i64 %3
  ret i64 %6
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_quad_128(fp128 %0, fp128 %1, i128 %2, i128 %3) {
; CHECK-LABEL: func_quad_128:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.q %s0, %s0, %s2
; CHECK-NEXT:    cmov.d.eq %s6, %s4, %s0
; CHECK-NEXT:    cmov.d.eq %s7, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, %1
  %6 = select i1 %5, i128 %2, i128 %3
  ret i128 %6
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_quad_u128(fp128 %0, fp128 %1, i128 %2, i128 %3) {
; CHECK-LABEL: func_quad_u128:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.q %s0, %s0, %s2
; CHECK-NEXT:    cmov.d.eq %s6, %s4, %s0
; CHECK-NEXT:    cmov.d.eq %s7, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, %1
  %6 = select i1 %5, i128 %2, i128 %3
  ret i128 %6
}

; Function Attrs: norecurse nounwind readnone
define float @func_quad_float(fp128 %0, fp128 %1, float %2, float %3) {
; CHECK-LABEL: func_quad_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.q %s0, %s0, %s2
; CHECK-NEXT:    cmov.d.eq %s5, %s4, %s0
; CHECK-NEXT:    or %s0, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, %1
  %6 = select i1 %5, float %2, float %3
  ret float %6
}

; Function Attrs: norecurse nounwind readnone
define double @func_quad_double(fp128 %0, fp128 %1, double %2, double %3) {
; CHECK-LABEL: func_quad_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.q %s0, %s0, %s2
; CHECK-NEXT:    cmov.d.eq %s5, %s4, %s0
; CHECK-NEXT:    or %s0, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, %1
  %6 = select i1 %5, double %2, double %3
  ret double %6
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_quad_quad(fp128 %0, fp128 %1, fp128 %2, fp128 %3) {
; CHECK-LABEL: func_quad_quad:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.q %s0, %s0, %s2
; CHECK-NEXT:    cmov.d.eq %s6, %s4, %s0
; CHECK-NEXT:    cmov.d.eq %s7, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, %1
  %6 = select i1 %5, fp128 %2, fp128 %3
  ret fp128 %6
}

; Function Attrs: norecurse nounwind readnone
define { float, float } @func_quad_fcomp(fp128 %0, fp128 %1, float %2, float %3, float %4, float %5) {
; CHECK-LABEL: func_quad_fcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.q %s0, %s0, %s2
; CHECK-NEXT:    cmov.d.eq %s6, %s4, %s0
; CHECK-NEXT:    cmov.d.eq %s7, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq fp128 %0, %1
  %8 = select i1 %7, float %2, float %4
  %9 = select i1 %7, float %3, float %5
  %10 = insertvalue { float, float } undef, float %8, 0
  %11 = insertvalue { float, float } %10, float %9, 1
  ret { float, float } %11
}

; Function Attrs: norecurse nounwind readnone
define { double, double } @func_quad_dcomp(fp128 %0, fp128 %1, double %2, double %3, double %4, double %5) {
; CHECK-LABEL: func_quad_dcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.q %s0, %s0, %s2
; CHECK-NEXT:    cmov.d.eq %s6, %s4, %s0
; CHECK-NEXT:    cmov.d.eq %s7, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq fp128 %0, %1
  %8 = select i1 %7, double %2, double %4
  %9 = select i1 %7, double %3, double %5
  %10 = insertvalue { double, double } undef, double %8, 0
  %11 = insertvalue { double, double } %10, double %9, 1
  ret { double, double } %11
}

; Function Attrs: norecurse nounwind readnone
define { fp128, fp128 } @func_quad_qcomp(fp128 %0, fp128 %1, fp128 %2, fp128 %3, fp128 %4, fp128 %5) {
; CHECK-LABEL: func_quad_qcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld %s35, 240(, %s11)
; CHECK-NEXT:    ld %s34, 248(, %s11)
; CHECK-NEXT:    ld %s37, 256(, %s11)
; CHECK-NEXT:    ld %s36, 264(, %s11)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s2
; CHECK-NEXT:    cmov.d.eq %s34, %s4, %s0
; CHECK-NEXT:    cmov.d.eq %s35, %s5, %s0
; CHECK-NEXT:    cmov.d.eq %s36, %s6, %s0
; CHECK-NEXT:    cmov.d.eq %s37, %s7, %s0
; CHECK-NEXT:    or %s0, 0, %s34
; CHECK-NEXT:    or %s1, 0, %s35
; CHECK-NEXT:    or %s2, 0, %s36
; CHECK-NEXT:    or %s3, 0, %s37
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq fp128 %0, %1
  %8 = select i1 %7, fp128 %2, fp128 %4
  %9 = select i1 %7, fp128 %3, fp128 %5
  %10 = insertvalue { fp128, fp128 } undef, fp128 %8, 0
  %11 = insertvalue { fp128, fp128 } %10, fp128 %9, 1
  ret { fp128, fp128 } %11
}

; Function Attrs: norecurse nounwind readnone
define zeroext i1 @func_quad_1_zero(fp128 %0, i1 zeroext %1, i1 zeroext %2) {
; CHECK-LABEL: func_quad_1_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %5 = select i1 %4, i1 %1, i1 %2
  ret i1 %5
}

; Function Attrs: norecurse nounwind readnone
define signext i8 @func_quad_8_zero(fp128 %0, i8 signext %1, i8 signext %2) {
; CHECK-LABEL: func_quad_8_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %5 = select i1 %4, i8 %1, i8 %2
  ret i8 %5
}

; Function Attrs: norecurse nounwind readnone
define zeroext i8 @func_quad_u8_zero(fp128 %0, i8 zeroext %1, i8 zeroext %2) {
; CHECK-LABEL: func_quad_u8_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %5 = select i1 %4, i8 %1, i8 %2
  ret i8 %5
}

; Function Attrs: norecurse nounwind readnone
define signext i16 @func_quad_16_zero(fp128 %0, i16 signext %1, i16 signext %2) {
; CHECK-LABEL: func_quad_16_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %5 = select i1 %4, i16 %1, i16 %2
  ret i16 %5
}

; Function Attrs: norecurse nounwind readnone
define zeroext i16 @func_quad_u16_zero(fp128 %0, i16 zeroext %1, i16 zeroext %2) {
; CHECK-LABEL: func_quad_u16_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %5 = select i1 %4, i16 %1, i16 %2
  ret i16 %5
}

; Function Attrs: norecurse nounwind readnone
define signext i32 @func_quad_32_zero(fp128 %0, i32 signext %1, i32 signext %2) {
; CHECK-LABEL: func_quad_32_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %5 = select i1 %4, i32 %1, i32 %2
  ret i32 %5
}

; Function Attrs: norecurse nounwind readnone
define zeroext i32 @func_quad_u32_zero(fp128 %0, i32 zeroext %1, i32 zeroext %2) {
; CHECK-LABEL: func_quad_u32_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %5 = select i1 %4, i32 %1, i32 %2
  ret i32 %5
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_quad_64_zero(fp128 %0, i64 %1, i64 %2) {
; CHECK-LABEL: func_quad_64_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %5 = select i1 %4, i64 %1, i64 %2
  ret i64 %5
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_quad_u64_zero(fp128 %0, i64 %1, i64 %2) {
; CHECK-LABEL: func_quad_u64_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %5 = select i1 %4, i64 %1, i64 %2
  ret i64 %5
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_quad_128_zero(fp128 %0, i128 %1, i128 %2) {
; CHECK-LABEL: func_quad_128_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    cmov.d.eq %s4, %s2, %s0
; CHECK-NEXT:    cmov.d.eq %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %5 = select i1 %4, i128 %1, i128 %2
  ret i128 %5
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_quad_u128_zero(fp128 %0, i128 %1, i128 %2) {
; CHECK-LABEL: func_quad_u128_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    cmov.d.eq %s4, %s2, %s0
; CHECK-NEXT:    cmov.d.eq %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %5 = select i1 %4, i128 %1, i128 %2
  ret i128 %5
}

; Function Attrs: norecurse nounwind readnone
define float @func_quad_float_zero(fp128 %0, float %1, float %2) {
; CHECK-LABEL: func_quad_float_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %5 = select i1 %4, float %1, float %2
  ret float %5
}

; Function Attrs: norecurse nounwind readnone
define double @func_quad_double_zero(fp128 %0, double %1, double %2) {
; CHECK-LABEL: func_quad_double_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %5 = select i1 %4, double %1, double %2
  ret double %5
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_quad_quad_zero(fp128 %0, fp128 %1, fp128 %2) {
; CHECK-LABEL: func_quad_quad_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    cmov.d.eq %s4, %s2, %s0
; CHECK-NEXT:    cmov.d.eq %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %5 = select i1 %4, fp128 %1, fp128 %2
  ret fp128 %5
}

; Function Attrs: norecurse nounwind readnone
define { float, float } @func_quad_fcomp_zero(fp128 %0, float %1, float %2, float %3, float %4) {
; CHECK-LABEL: func_quad_fcomp_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    cmov.d.eq %s4, %s2, %s0
; CHECK-NEXT:    cmov.d.eq %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %6 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %7 = select i1 %6, float %1, float %3
  %8 = select i1 %6, float %2, float %4
  %9 = insertvalue { float, float } undef, float %7, 0
  %10 = insertvalue { float, float } %9, float %8, 1
  ret { float, float } %10
}

; Function Attrs: norecurse nounwind readnone
define { double, double } @func_quad_dcomp_zero(fp128 %0, double %1, double %2, double %3, double %4) {
; CHECK-LABEL: func_quad_dcomp_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    cmov.d.eq %s4, %s2, %s0
; CHECK-NEXT:    cmov.d.eq %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %6 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %7 = select i1 %6, double %1, double %3
  %8 = select i1 %6, double %2, double %4
  %9 = insertvalue { double, double } undef, double %7, 0
  %10 = insertvalue { double, double } %9, double %8, 1
  ret { double, double } %10
}

; Function Attrs: norecurse nounwind readnone
define { fp128, fp128 } @func_quad_qcomp_zero(fp128 %0, fp128 %1, fp128 %2, fp128 %3, fp128 %4) {
; CHECK-LABEL: func_quad_qcomp_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s34, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s34, .LCPI{{[0-9]+}}_0@hi(, %s34)
; CHECK-NEXT:    ld %s36, 8(, %s34)
; CHECK-NEXT:    ld %s37, (, %s34)
; CHECK-NEXT:    ld %s35, 240(, %s11)
; CHECK-NEXT:    ld %s34, 248(, %s11)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s36
; CHECK-NEXT:    cmov.d.eq %s6, %s2, %s0
; CHECK-NEXT:    cmov.d.eq %s7, %s3, %s0
; CHECK-NEXT:    cmov.d.eq %s34, %s4, %s0
; CHECK-NEXT:    cmov.d.eq %s35, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    or %s2, 0, %s34
; CHECK-NEXT:    or %s3, 0, %s35
; CHECK-NEXT:    b.l.t (, %s10)
  %6 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %7 = select i1 %6, fp128 %1, fp128 %3
  %8 = select i1 %6, fp128 %2, fp128 %4
  %9 = insertvalue { fp128, fp128 } undef, fp128 %7, 0
  %10 = insertvalue { fp128, fp128 } %9, fp128 %8, 1
  ret { fp128, fp128 } %10
}

; Function Attrs: norecurse nounwind readnone
define zeroext i1 @func_quad_1_i(fp128 %0, i1 zeroext %1, i1 zeroext %2) {
; CHECK-LABEL: func_quad_1_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %5 = select i1 %4, i1 %1, i1 %2
  ret i1 %5
}

; Function Attrs: norecurse nounwind readnone
define signext i8 @func_quad_8_i(fp128 %0, i8 signext %1, i8 signext %2) {
; CHECK-LABEL: func_quad_8_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %5 = select i1 %4, i8 %1, i8 %2
  ret i8 %5
}

; Function Attrs: norecurse nounwind readnone
define zeroext i8 @func_quad_u8_i(fp128 %0, i8 zeroext %1, i8 zeroext %2) {
; CHECK-LABEL: func_quad_u8_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %5 = select i1 %4, i8 %1, i8 %2
  ret i8 %5
}

; Function Attrs: norecurse nounwind readnone
define signext i16 @func_quad_16_i(fp128 %0, i16 signext %1, i16 signext %2) {
; CHECK-LABEL: func_quad_16_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %5 = select i1 %4, i16 %1, i16 %2
  ret i16 %5
}

; Function Attrs: norecurse nounwind readnone
define zeroext i16 @func_quad_u16_i(fp128 %0, i16 zeroext %1, i16 zeroext %2) {
; CHECK-LABEL: func_quad_u16_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %5 = select i1 %4, i16 %1, i16 %2
  ret i16 %5
}

; Function Attrs: norecurse nounwind readnone
define signext i32 @func_quad_32_i(fp128 %0, i32 signext %1, i32 signext %2) {
; CHECK-LABEL: func_quad_32_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %5 = select i1 %4, i32 %1, i32 %2
  ret i32 %5
}

; Function Attrs: norecurse nounwind readnone
define zeroext i32 @func_quad_u32_i(fp128 %0, i32 zeroext %1, i32 zeroext %2) {
; CHECK-LABEL: func_quad_u32_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %5 = select i1 %4, i32 %1, i32 %2
  ret i32 %5
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_quad_64_i(fp128 %0, i64 %1, i64 %2) {
; CHECK-LABEL: func_quad_64_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %5 = select i1 %4, i64 %1, i64 %2
  ret i64 %5
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_quad_u64_i(fp128 %0, i64 %1, i64 %2) {
; CHECK-LABEL: func_quad_u64_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %5 = select i1 %4, i64 %1, i64 %2
  ret i64 %5
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_quad_128_i(fp128 %0, i128 %1, i128 %2) {
; CHECK-LABEL: func_quad_128_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    cmov.d.eq %s4, %s2, %s0
; CHECK-NEXT:    cmov.d.eq %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %5 = select i1 %4, i128 %1, i128 %2
  ret i128 %5
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_quad_u128_i(fp128 %0, i128 %1, i128 %2) {
; CHECK-LABEL: func_quad_u128_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    cmov.d.eq %s4, %s2, %s0
; CHECK-NEXT:    cmov.d.eq %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %5 = select i1 %4, i128 %1, i128 %2
  ret i128 %5
}

; Function Attrs: norecurse nounwind readnone
define float @func_quad_float_i(fp128 %0, float %1, float %2) {
; CHECK-LABEL: func_quad_float_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %5 = select i1 %4, float %1, float %2
  ret float %5
}

; Function Attrs: norecurse nounwind readnone
define double @func_quad_double_i(fp128 %0, double %1, double %2) {
; CHECK-LABEL: func_quad_double_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %5 = select i1 %4, double %1, double %2
  ret double %5
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_quad_quad_i(fp128 %0, fp128 %1, fp128 %2) {
; CHECK-LABEL: func_quad_quad_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    cmov.d.eq %s4, %s2, %s0
; CHECK-NEXT:    cmov.d.eq %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %5 = select i1 %4, fp128 %1, fp128 %2
  ret fp128 %5
}

; Function Attrs: norecurse nounwind readnone
define { float, float } @func_quad_fcomp_i(fp128 %0, float %1, float %2, float %3, float %4) {
; CHECK-LABEL: func_quad_fcomp_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    cmov.d.eq %s4, %s2, %s0
; CHECK-NEXT:    cmov.d.eq %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %6 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %7 = select i1 %6, float %1, float %3
  %8 = select i1 %6, float %2, float %4
  %9 = insertvalue { float, float } undef, float %7, 0
  %10 = insertvalue { float, float } %9, float %8, 1
  ret { float, float } %10
}

; Function Attrs: norecurse nounwind readnone
define { double, double } @func_quad_dcomp_i(fp128 %0, double %1, double %2, double %3, double %4) {
; CHECK-LABEL: func_quad_dcomp_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    cmov.d.eq %s4, %s2, %s0
; CHECK-NEXT:    cmov.d.eq %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %6 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %7 = select i1 %6, double %1, double %3
  %8 = select i1 %6, double %2, double %4
  %9 = insertvalue { double, double } undef, double %7, 0
  %10 = insertvalue { double, double } %9, double %8, 1
  ret { double, double } %10
}

; Function Attrs: norecurse nounwind readnone
define { fp128, fp128 } @func_quad_qcomp_i(fp128 %0, fp128 %1, fp128 %2, fp128 %3, fp128 %4) {
; CHECK-LABEL: func_quad_qcomp_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s34, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s34, .LCPI{{[0-9]+}}_0@hi(, %s34)
; CHECK-NEXT:    ld %s36, 8(, %s34)
; CHECK-NEXT:    ld %s37, (, %s34)
; CHECK-NEXT:    ld %s35, 240(, %s11)
; CHECK-NEXT:    ld %s34, 248(, %s11)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s36
; CHECK-NEXT:    cmov.d.eq %s6, %s2, %s0
; CHECK-NEXT:    cmov.d.eq %s7, %s3, %s0
; CHECK-NEXT:    cmov.d.eq %s34, %s4, %s0
; CHECK-NEXT:    cmov.d.eq %s35, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    or %s2, 0, %s34
; CHECK-NEXT:    or %s3, 0, %s35
; CHECK-NEXT:    b.l.t (, %s10)
  %6 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %7 = select i1 %6, fp128 %1, fp128 %3
  %8 = select i1 %6, fp128 %2, fp128 %4
  %9 = insertvalue { fp128, fp128 } undef, fp128 %7, 0
  %10 = insertvalue { fp128, fp128 } %9, fp128 %8, 1
  ret { fp128, fp128 } %10
}

; Function Attrs: norecurse nounwind readnone
define zeroext i1 @func_quad_1_m(fp128 %0, i1 zeroext %1, i1 zeroext %2) {
; CHECK-LABEL: func_quad_1_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %5 = select i1 %4, i1 %1, i1 %2
  ret i1 %5
}

; Function Attrs: norecurse nounwind readnone
define signext i8 @func_quad_8_m(fp128 %0, i8 signext %1, i8 signext %2) {
; CHECK-LABEL: func_quad_8_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %5 = select i1 %4, i8 %1, i8 %2
  ret i8 %5
}

; Function Attrs: norecurse nounwind readnone
define zeroext i8 @func_quad_u8_m(fp128 %0, i8 zeroext %1, i8 zeroext %2) {
; CHECK-LABEL: func_quad_u8_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %5 = select i1 %4, i8 %1, i8 %2
  ret i8 %5
}

; Function Attrs: norecurse nounwind readnone
define signext i16 @func_quad_16_m(fp128 %0, i16 signext %1, i16 signext %2) {
; CHECK-LABEL: func_quad_16_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %5 = select i1 %4, i16 %1, i16 %2
  ret i16 %5
}

; Function Attrs: norecurse nounwind readnone
define zeroext i16 @func_quad_u16_m(fp128 %0, i16 zeroext %1, i16 zeroext %2) {
; CHECK-LABEL: func_quad_u16_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %5 = select i1 %4, i16 %1, i16 %2
  ret i16 %5
}

; Function Attrs: norecurse nounwind readnone
define signext i32 @func_quad_32_m(fp128 %0, i32 signext %1, i32 signext %2) {
; CHECK-LABEL: func_quad_32_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %5 = select i1 %4, i32 %1, i32 %2
  ret i32 %5
}

; Function Attrs: norecurse nounwind readnone
define zeroext i32 @func_quad_u32_m(fp128 %0, i32 zeroext %1, i32 zeroext %2) {
; CHECK-LABEL: func_quad_u32_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %5 = select i1 %4, i32 %1, i32 %2
  ret i32 %5
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_quad_64_m(fp128 %0, i64 %1, i64 %2) {
; CHECK-LABEL: func_quad_64_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %5 = select i1 %4, i64 %1, i64 %2
  ret i64 %5
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_quad_u64_m(fp128 %0, i64 %1, i64 %2) {
; CHECK-LABEL: func_quad_u64_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %5 = select i1 %4, i64 %1, i64 %2
  ret i64 %5
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_quad_128_m(fp128 %0, i128 %1, i128 %2) {
; CHECK-LABEL: func_quad_128_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    cmov.d.eq %s4, %s2, %s0
; CHECK-NEXT:    cmov.d.eq %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %5 = select i1 %4, i128 %1, i128 %2
  ret i128 %5
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_quad_u128_m(fp128 %0, i128 %1, i128 %2) {
; CHECK-LABEL: func_quad_u128_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    cmov.d.eq %s4, %s2, %s0
; CHECK-NEXT:    cmov.d.eq %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %5 = select i1 %4, i128 %1, i128 %2
  ret i128 %5
}

; Function Attrs: norecurse nounwind readnone
define float @func_quad_float_m(fp128 %0, float %1, float %2) {
; CHECK-LABEL: func_quad_float_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %5 = select i1 %4, float %1, float %2
  ret float %5
}

; Function Attrs: norecurse nounwind readnone
define double @func_quad_double_m(fp128 %0, double %1, double %2) {
; CHECK-LABEL: func_quad_double_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s4, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s4, .LCPI{{[0-9]+}}_0@hi(, %s4)
; CHECK-NEXT:    ld %s6, 8(, %s4)
; CHECK-NEXT:    ld %s7, (, %s4)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s6
; CHECK-NEXT:    cmov.d.eq %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %5 = select i1 %4, double %1, double %2
  ret double %5
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_quad_quad_m(fp128 %0, fp128 %1, fp128 %2) {
; CHECK-LABEL: func_quad_quad_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    cmov.d.eq %s4, %s2, %s0
; CHECK-NEXT:    cmov.d.eq %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %5 = select i1 %4, fp128 %1, fp128 %2
  ret fp128 %5
}

; Function Attrs: norecurse nounwind readnone
define { float, float } @func_quad_fcomp_m(fp128 %0, float %1, float %2, float %3, float %4) {
; CHECK-LABEL: func_quad_fcomp_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    cmov.d.eq %s4, %s2, %s0
; CHECK-NEXT:    cmov.d.eq %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %6 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %7 = select i1 %6, float %1, float %3
  %8 = select i1 %6, float %2, float %4
  %9 = insertvalue { float, float } undef, float %7, 0
  %10 = insertvalue { float, float } %9, float %8, 1
  ret { float, float } %10
}

; Function Attrs: norecurse nounwind readnone
define { double, double } @func_quad_dcomp_m(fp128 %0, double %1, double %2, double %3, double %4) {
; CHECK-LABEL: func_quad_dcomp_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    cmov.d.eq %s4, %s2, %s0
; CHECK-NEXT:    cmov.d.eq %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %6 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %7 = select i1 %6, double %1, double %3
  %8 = select i1 %6, double %2, double %4
  %9 = insertvalue { double, double } undef, double %7, 0
  %10 = insertvalue { double, double } %9, double %8, 1
  ret { double, double } %10
}

; Function Attrs: norecurse nounwind readnone
define { fp128, fp128 } @func_quad_qcomp_m(fp128 %0, fp128 %1, fp128 %2, fp128 %3, fp128 %4) {
; CHECK-LABEL: func_quad_qcomp_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s34, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s34, .LCPI{{[0-9]+}}_0@hi(, %s34)
; CHECK-NEXT:    ld %s36, 8(, %s34)
; CHECK-NEXT:    ld %s37, (, %s34)
; CHECK-NEXT:    ld %s35, 240(, %s11)
; CHECK-NEXT:    ld %s34, 248(, %s11)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s36
; CHECK-NEXT:    cmov.d.eq %s6, %s2, %s0
; CHECK-NEXT:    cmov.d.eq %s7, %s3, %s0
; CHECK-NEXT:    cmov.d.eq %s34, %s4, %s0
; CHECK-NEXT:    cmov.d.eq %s35, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    or %s2, 0, %s34
; CHECK-NEXT:    or %s3, 0, %s35
; CHECK-NEXT:    b.l.t (, %s10)
  %6 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %7 = select i1 %6, fp128 %1, fp128 %3
  %8 = select i1 %6, fp128 %2, fp128 %4
  %9 = insertvalue { fp128, fp128 } undef, fp128 %7, 0
  %10 = insertvalue { fp128, fp128 } %9, fp128 %8, 1
  ret { fp128, fp128 } %10
}
