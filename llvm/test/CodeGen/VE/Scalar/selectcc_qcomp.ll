; RUN: llc < %s -mtriple=ve | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define zeroext i1 @func_qcomp_1(fp128 %0, fp128 %1, fp128 %2, fp128 %3, i1 zeroext %4, i1 zeroext %5) {
; CHECK-LABEL: func_qcomp_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ldl.sx %s34, 240(, %s11)
; CHECK-NEXT:    ldl.sx %s35, 248(, %s11)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s4
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s4, %s1
; CHECK-NEXT:    cmov.w.ne %s35, %s34, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s35, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq fp128 %0, %2
  %8 = fcmp oeq fp128 %1, %3
  %9 = and i1 %7, %8
  %10 = select i1 %9, i1 %4, i1 %5
  ret i1 %10
}

; Function Attrs: norecurse nounwind readnone
define signext i8 @func_qcomp_8(fp128 %0, fp128 %1, fp128 %2, fp128 %3, i8 signext %4, i8 signext %5) {
; CHECK-LABEL: func_qcomp_8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ldl.sx %s34, 240(, %s11)
; CHECK-NEXT:    ldl.sx %s35, 248(, %s11)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s4
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s4, %s1
; CHECK-NEXT:    cmov.w.ne %s35, %s34, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s35, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq fp128 %0, %2
  %8 = fcmp oeq fp128 %1, %3
  %9 = and i1 %7, %8
  %10 = select i1 %9, i8 %4, i8 %5
  ret i8 %10
}

; Function Attrs: norecurse nounwind readnone
define zeroext i8 @func_qcomp_u8(fp128 %0, fp128 %1, fp128 %2, fp128 %3, i8 zeroext %4, i8 zeroext %5) {
; CHECK-LABEL: func_qcomp_u8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ldl.sx %s34, 240(, %s11)
; CHECK-NEXT:    ldl.sx %s35, 248(, %s11)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s4
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s4, %s1
; CHECK-NEXT:    cmov.w.ne %s35, %s34, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s35, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq fp128 %0, %2
  %8 = fcmp oeq fp128 %1, %3
  %9 = and i1 %7, %8
  %10 = select i1 %9, i8 %4, i8 %5
  ret i8 %10
}

; Function Attrs: norecurse nounwind readnone
define signext i16 @func_qcomp_16(fp128 %0, fp128 %1, fp128 %2, fp128 %3, i16 signext %4, i16 signext %5) {
; CHECK-LABEL: func_qcomp_16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ldl.sx %s34, 240(, %s11)
; CHECK-NEXT:    ldl.sx %s35, 248(, %s11)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s4
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s4, %s1
; CHECK-NEXT:    cmov.w.ne %s35, %s34, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s35, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq fp128 %0, %2
  %8 = fcmp oeq fp128 %1, %3
  %9 = and i1 %7, %8
  %10 = select i1 %9, i16 %4, i16 %5
  ret i16 %10
}

; Function Attrs: norecurse nounwind readnone
define zeroext i16 @func_qcomp_u16(fp128 %0, fp128 %1, fp128 %2, fp128 %3, i16 zeroext %4, i16 zeroext %5) {
; CHECK-LABEL: func_qcomp_u16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ldl.sx %s34, 240(, %s11)
; CHECK-NEXT:    ldl.sx %s35, 248(, %s11)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s4
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s4, %s1
; CHECK-NEXT:    cmov.w.ne %s35, %s34, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s35, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq fp128 %0, %2
  %8 = fcmp oeq fp128 %1, %3
  %9 = and i1 %7, %8
  %10 = select i1 %9, i16 %4, i16 %5
  ret i16 %10
}

; Function Attrs: norecurse nounwind readnone
define signext i32 @func_qcomp_32(fp128 %0, fp128 %1, fp128 %2, fp128 %3, i32 signext %4, i32 signext %5) {
; CHECK-LABEL: func_qcomp_32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.q %s0, %s0, %s4
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s4, %s1
; CHECK-NEXT:    lea %s1, 248(, %s11)
; CHECK-NEXT:    lea %s2, 240(, %s11)
; CHECK-NEXT:    cmov.w.ne %s1, %s2, %s0
; CHECK-NEXT:    ldl.sx %s0, (, %s1)
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq fp128 %0, %2
  %8 = fcmp oeq fp128 %1, %3
  %9 = and i1 %7, %8
  %10 = select i1 %9, i32 %4, i32 %5
  ret i32 %10
}

; Function Attrs: norecurse nounwind readnone
define zeroext i32 @func_qcomp_u32(fp128 %0, fp128 %1, fp128 %2, fp128 %3, i32 zeroext %4, i32 zeroext %5) {
; CHECK-LABEL: func_qcomp_u32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.q %s0, %s0, %s4
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s4, %s1
; CHECK-NEXT:    lea %s1, 248(, %s11)
; CHECK-NEXT:    lea %s2, 240(, %s11)
; CHECK-NEXT:    cmov.w.ne %s1, %s2, %s0
; CHECK-NEXT:    ldl.zx %s0, (, %s1)
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq fp128 %0, %2
  %8 = fcmp oeq fp128 %1, %3
  %9 = and i1 %7, %8
  %10 = select i1 %9, i32 %4, i32 %5
  ret i32 %10
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_qcomp_64(fp128 %0, fp128 %1, fp128 %2, fp128 %3, i64 %4, i64 %5) {
; CHECK-LABEL: func_qcomp_64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.q %s0, %s0, %s4
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s4, %s1
; CHECK-NEXT:    lea %s1, 248(, %s11)
; CHECK-NEXT:    lea %s2, 240(, %s11)
; CHECK-NEXT:    cmov.w.ne %s1, %s2, %s0
; CHECK-NEXT:    ld %s0, (, %s1)
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq fp128 %0, %2
  %8 = fcmp oeq fp128 %1, %3
  %9 = and i1 %7, %8
  %10 = select i1 %9, i64 %4, i64 %5
  ret i64 %10
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_qcomp_u64(fp128 %0, fp128 %1, fp128 %2, fp128 %3, i64 %4, i64 %5) {
; CHECK-LABEL: func_qcomp_u64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.q %s0, %s0, %s4
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s4, %s1
; CHECK-NEXT:    lea %s1, 248(, %s11)
; CHECK-NEXT:    lea %s2, 240(, %s11)
; CHECK-NEXT:    cmov.w.ne %s1, %s2, %s0
; CHECK-NEXT:    ld %s0, (, %s1)
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq fp128 %0, %2
  %8 = fcmp oeq fp128 %1, %3
  %9 = and i1 %7, %8
  %10 = select i1 %9, i64 %4, i64 %5
  ret i64 %10
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_qcomp_128(fp128 %0, fp128 %1, fp128 %2, fp128 %3, i128 %4, i128 %5) {
; CHECK-LABEL: func_qcomp_128:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.q %s0, %s0, %s4
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s4, %s1
; CHECK-NEXT:    lea %s1, 256(, %s11)
; CHECK-NEXT:    lea %s2, 240(, %s11)
; CHECK-NEXT:    cmov.w.ne %s1, %s2, %s0
; CHECK-NEXT:    ld %s0, (, %s1)
; CHECK-NEXT:    ld %s1, 8(, %s1)
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq fp128 %0, %2
  %8 = fcmp oeq fp128 %1, %3
  %9 = and i1 %7, %8
  %10 = select i1 %9, i128 %4, i128 %5
  ret i128 %10
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_qcomp_u128(fp128 %0, fp128 %1, fp128 %2, fp128 %3, i128 %4, i128 %5) {
; CHECK-LABEL: func_qcomp_u128:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.q %s0, %s0, %s4
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s4, %s1
; CHECK-NEXT:    lea %s1, 256(, %s11)
; CHECK-NEXT:    lea %s2, 240(, %s11)
; CHECK-NEXT:    cmov.w.ne %s1, %s2, %s0
; CHECK-NEXT:    ld %s0, (, %s1)
; CHECK-NEXT:    ld %s1, 8(, %s1)
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq fp128 %0, %2
  %8 = fcmp oeq fp128 %1, %3
  %9 = and i1 %7, %8
  %10 = select i1 %9, i128 %4, i128 %5
  ret i128 %10
}

; Function Attrs: norecurse nounwind readnone
define float @func_qcomp_float(fp128 %0, fp128 %1, fp128 %2, fp128 %3, float %4, float %5) {
; CHECK-LABEL: func_qcomp_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.q %s0, %s0, %s4
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s4, %s1
; CHECK-NEXT:    lea %s1, 252(, %s11)
; CHECK-NEXT:    lea %s2, 244(, %s11)
; CHECK-NEXT:    cmov.w.ne %s1, %s2, %s0
; CHECK-NEXT:    ldu %s0, (, %s1)
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq fp128 %0, %2
  %8 = fcmp oeq fp128 %1, %3
  %9 = and i1 %7, %8
  %10 = select i1 %9, float %4, float %5
  ret float %10
}

; Function Attrs: norecurse nounwind readnone
define double @func_qcomp_double(fp128 %0, fp128 %1, fp128 %2, fp128 %3, double %4, double %5) {
; CHECK-LABEL: func_qcomp_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.q %s0, %s0, %s4
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s4, %s1
; CHECK-NEXT:    lea %s1, 248(, %s11)
; CHECK-NEXT:    lea %s2, 240(, %s11)
; CHECK-NEXT:    cmov.w.ne %s1, %s2, %s0
; CHECK-NEXT:    ld %s0, (, %s1)
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq fp128 %0, %2
  %8 = fcmp oeq fp128 %1, %3
  %9 = and i1 %7, %8
  %10 = select i1 %9, double %4, double %5
  ret double %10
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_qcomp_quad(fp128 %0, fp128 %1, fp128 %2, fp128 %3, fp128 %4, fp128 %5) {
; CHECK-LABEL: func_qcomp_quad:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.q %s0, %s0, %s4
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s4, %s1
; CHECK-NEXT:    lea %s2, 256(, %s11)
; CHECK-NEXT:    lea %s1, 240(, %s11)
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    ld %s0, 8(, %s2)
; CHECK-NEXT:    ld %s1, (, %s2)
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq fp128 %0, %2
  %8 = fcmp oeq fp128 %1, %3
  %9 = and i1 %7, %8
  %10 = select i1 %9, fp128 %4, fp128 %5
  ret fp128 %10
}

; Function Attrs: norecurse nounwind readnone
define { float, float } @func_qcomp_fcomp(fp128 %0, fp128 %1, fp128 %2, fp128 %3, float %4, float %5, float %6, float %7) {
; CHECK-LABEL: func_qcomp_fcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.q %s0, %s0, %s4
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s1, %s4, %s1
; CHECK-NEXT:    lea %s0, 260(, %s11)
; CHECK-NEXT:    lea %s2, 244(, %s11)
; CHECK-NEXT:    cmov.w.ne %s0, %s2, %s1
; CHECK-NEXT:    ldu %s0, (, %s0)
; CHECK-NEXT:    lea %s2, 268(, %s11)
; CHECK-NEXT:    lea %s3, 252(, %s11)
; CHECK-NEXT:    cmov.w.ne %s2, %s3, %s1
; CHECK-NEXT:    ldu %s1, (, %s2)
; CHECK-NEXT:    b.l.t (, %s10)
  %9 = fcmp oeq fp128 %0, %2
  %10 = fcmp oeq fp128 %1, %3
  %11 = and i1 %9, %10
  %12 = select i1 %11, float %4, float %6
  %13 = select i1 %11, float %5, float %7
  %14 = insertvalue { float, float } undef, float %12, 0
  %15 = insertvalue { float, float } %14, float %13, 1
  ret { float, float } %15
}

; Function Attrs: norecurse nounwind readnone
define { double, double } @func_qcomp_dcomp(fp128 %0, fp128 %1, fp128 %2, fp128 %3, double %4, double %5, double %6, double %7) {
; CHECK-LABEL: func_qcomp_dcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.q %s0, %s0, %s4
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s1, %s4, %s1
; CHECK-NEXT:    lea %s0, 256(, %s11)
; CHECK-NEXT:    lea %s2, 240(, %s11)
; CHECK-NEXT:    cmov.w.ne %s0, %s2, %s1
; CHECK-NEXT:    ld %s0, (, %s0)
; CHECK-NEXT:    lea %s2, 264(, %s11)
; CHECK-NEXT:    lea %s3, 248(, %s11)
; CHECK-NEXT:    cmov.w.ne %s2, %s3, %s1
; CHECK-NEXT:    ld %s1, (, %s2)
; CHECK-NEXT:    b.l.t (, %s10)
  %9 = fcmp oeq fp128 %0, %2
  %10 = fcmp oeq fp128 %1, %3
  %11 = and i1 %9, %10
  %12 = select i1 %11, double %4, double %6
  %13 = select i1 %11, double %5, double %7
  %14 = insertvalue { double, double } undef, double %12, 0
  %15 = insertvalue { double, double } %14, double %13, 1
  ret { double, double } %15
}

; Function Attrs: norecurse nounwind readnone
define { fp128, fp128 } @func_qcomp_qcomp(fp128 %0, fp128 %1, fp128 %2, fp128 %3, fp128 %4, fp128 %5, fp128 %6, fp128 %7) {
; CHECK-LABEL: func_qcomp_qcomp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.q %s0, %s0, %s4
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s4, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s2, %s4, %s1
; CHECK-NEXT:    lea %s3, 272(, %s11)
; CHECK-NEXT:    lea %s0, 240(, %s11)
; CHECK-NEXT:    cmov.w.ne %s3, %s0, %s2
; CHECK-NEXT:    ld %s0, 8(, %s3)
; CHECK-NEXT:    ld %s1, (, %s3)
; CHECK-NEXT:    lea %s4, 288(, %s11)
; CHECK-NEXT:    lea %s3, 256(, %s11)
; CHECK-NEXT:    cmov.w.ne %s4, %s3, %s2
; CHECK-NEXT:    ld %s2, 8(, %s4)
; CHECK-NEXT:    ld %s3, (, %s4)
; CHECK-NEXT:    b.l.t (, %s10)
  %9 = fcmp oeq fp128 %0, %2
  %10 = fcmp oeq fp128 %1, %3
  %11 = and i1 %9, %10
  %12 = select i1 %11, fp128 %4, fp128 %6
  %13 = select i1 %11, fp128 %5, fp128 %7
  %14 = insertvalue { fp128, fp128 } undef, fp128 %12, 0
  %15 = insertvalue { fp128, fp128 } %14, fp128 %13, 1
  ret { fp128, fp128 } %15
}

; Function Attrs: norecurse nounwind readnone
define zeroext i1 @func_qcomp_1_zero(fp128 %0, fp128 %1, i1 zeroext %2, i1 zeroext %3) {
; CHECK-LABEL: func_qcomp_1_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s34
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s6, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i1 %2, i1 %3
  ret i1 %8
}

; Function Attrs: norecurse nounwind readnone
define signext i8 @func_qcomp_8_zero(fp128 %0, fp128 %1, i8 signext %2, i8 signext %3) {
; CHECK-LABEL: func_qcomp_8_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s34
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s6, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i8 %2, i8 %3
  ret i8 %8
}

; Function Attrs: norecurse nounwind readnone
define zeroext i8 @func_qcomp_u8_zero(fp128 %0, fp128 %1, i8 zeroext %2, i8 zeroext %3) {
; CHECK-LABEL: func_qcomp_u8_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s34
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s6, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i8 %2, i8 %3
  ret i8 %8
}

; Function Attrs: norecurse nounwind readnone
define signext i16 @func_qcomp_16_zero(fp128 %0, fp128 %1, i16 signext %2, i16 signext %3) {
; CHECK-LABEL: func_qcomp_16_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s34
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s6, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i16 %2, i16 %3
  ret i16 %8
}

; Function Attrs: norecurse nounwind readnone
define zeroext i16 @func_qcomp_u16_zero(fp128 %0, fp128 %1, i16 zeroext %2, i16 zeroext %3) {
; CHECK-LABEL: func_qcomp_u16_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s34
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s6, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i16 %2, i16 %3
  ret i16 %8
}

; Function Attrs: norecurse nounwind readnone
define signext i32 @func_qcomp_32_zero(fp128 %0, fp128 %1, i32 signext %2, i32 signext %3) {
; CHECK-LABEL: func_qcomp_32_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s34
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s6, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i32 %2, i32 %3
  ret i32 %8
}

; Function Attrs: norecurse nounwind readnone
define zeroext i32 @func_qcomp_u32_zero(fp128 %0, fp128 %1, i32 zeroext %2, i32 zeroext %3) {
; CHECK-LABEL: func_qcomp_u32_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s34
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s6, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i32 %2, i32 %3
  ret i32 %8
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_qcomp_64_zero(fp128 %0, fp128 %1, i64 %2, i64 %3) {
; CHECK-LABEL: func_qcomp_64_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s34
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s6, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    or %s0, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i64 %2, i64 %3
  ret i64 %8
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_qcomp_u64_zero(fp128 %0, fp128 %1, i64 %2, i64 %3) {
; CHECK-LABEL: func_qcomp_u64_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s34
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s6, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    or %s0, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i64 %2, i64 %3
  ret i64 %8
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_qcomp_128_zero(fp128 %0, fp128 %1, i128 %2, i128 %3) {
; CHECK-LABEL: func_qcomp_128_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s34, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s34, .LCPI{{[0-9]+}}_0@hi(, %s34)
; CHECK-NEXT:    ld %s36, 8(, %s34)
; CHECK-NEXT:    ld %s37, (, %s34)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s36
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s36
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s1
; CHECK-NEXT:    cmov.w.ne %s6, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s7, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i128 %2, i128 %3
  ret i128 %8
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_qcomp_u128_zero(fp128 %0, fp128 %1, i128 %2, i128 %3) {
; CHECK-LABEL: func_qcomp_u128_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s34, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s34, .LCPI{{[0-9]+}}_0@hi(, %s34)
; CHECK-NEXT:    ld %s36, 8(, %s34)
; CHECK-NEXT:    ld %s37, (, %s34)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s36
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s36
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s1
; CHECK-NEXT:    cmov.w.ne %s6, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s7, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i128 %2, i128 %3
  ret i128 %8
}

; Function Attrs: norecurse nounwind readnone
define float @func_qcomp_float_zero(fp128 %0, fp128 %1, float %2, float %3) {
; CHECK-LABEL: func_qcomp_float_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s34
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s6, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    or %s0, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, float %2, float %3
  ret float %8
}

; Function Attrs: norecurse nounwind readnone
define double @func_qcomp_double_zero(fp128 %0, fp128 %1, double %2, double %3) {
; CHECK-LABEL: func_qcomp_double_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s6, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s6, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s34
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s6, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    or %s0, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, double %2, double %3
  ret double %8
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_qcomp_quad_zero(fp128 %0, fp128 %1, fp128 %2, fp128 %3) {
; CHECK-LABEL: func_qcomp_quad_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s34, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s34, .LCPI{{[0-9]+}}_0@hi(, %s34)
; CHECK-NEXT:    ld %s36, 8(, %s34)
; CHECK-NEXT:    ld %s37, (, %s34)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s36
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s36
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s1
; CHECK-NEXT:    cmov.w.ne %s6, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s7, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, fp128 %2, fp128 %3
  ret fp128 %8
}

; Function Attrs: norecurse nounwind readnone
define { float, float } @func_qcomp_fcomp_zero(fp128 %0, fp128 %1, float %2, float %3, float %4, float %5) {
; CHECK-LABEL: func_qcomp_fcomp_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s34, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s34, .LCPI{{[0-9]+}}_0@hi(, %s34)
; CHECK-NEXT:    ld %s36, 8(, %s34)
; CHECK-NEXT:    ld %s37, (, %s34)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s36
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s36
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s1
; CHECK-NEXT:    cmov.w.ne %s6, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s7, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %8 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %9 = and i1 %7, %8
  %10 = select i1 %9, float %2, float %4
  %11 = select i1 %9, float %3, float %5
  %12 = insertvalue { float, float } undef, float %10, 0
  %13 = insertvalue { float, float } %12, float %11, 1
  ret { float, float } %13
}

; Function Attrs: norecurse nounwind readnone
define { double, double } @func_qcomp_dcomp_zero(fp128 %0, fp128 %1, double %2, double %3, double %4, double %5) {
; CHECK-LABEL: func_qcomp_dcomp_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s34, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s34, .LCPI{{[0-9]+}}_0@hi(, %s34)
; CHECK-NEXT:    ld %s36, 8(, %s34)
; CHECK-NEXT:    ld %s37, (, %s34)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s36
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s36
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s1
; CHECK-NEXT:    cmov.w.ne %s6, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s7, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %8 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %9 = and i1 %7, %8
  %10 = select i1 %9, double %2, double %4
  %11 = select i1 %9, double %3, double %5
  %12 = insertvalue { double, double } undef, double %10, 0
  %13 = insertvalue { double, double } %12, double %11, 1
  ret { double, double } %13
}

; Function Attrs: norecurse nounwind readnone
define { fp128, fp128 } @func_qcomp_qcomp_zero(fp128 %0, fp128 %1, fp128 %2, fp128 %3, fp128 %4, fp128 %5) {
; CHECK-LABEL: func_qcomp_qcomp_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s34, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s34, .LCPI{{[0-9]+}}_0@hi(, %s34)
; CHECK-NEXT:    ld %s38, 8(, %s34)
; CHECK-NEXT:    ld %s39, (, %s34)
; CHECK-NEXT:    ld %s35, 256(, %s11)
; CHECK-NEXT:    ld %s34, 264(, %s11)
; CHECK-NEXT:    ld %s37, 240(, %s11)
; CHECK-NEXT:    ld %s36, 248(, %s11)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s38
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s40, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s40, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s38
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s40, %s1
; CHECK-NEXT:    cmov.w.ne %s36, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s37, %s5, %s0
; CHECK-NEXT:    cmov.w.ne %s34, %s6, %s0
; CHECK-NEXT:    cmov.w.ne %s35, %s7, %s0
; CHECK-NEXT:    or %s0, 0, %s36
; CHECK-NEXT:    or %s1, 0, %s37
; CHECK-NEXT:    or %s2, 0, %s34
; CHECK-NEXT:    or %s3, 0, %s35
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq fp128 %0, 0xL00000000000000000000000000000000
  %8 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %9 = and i1 %7, %8
  %10 = select i1 %9, fp128 %2, fp128 %4
  %11 = select i1 %9, fp128 %3, fp128 %5
  %12 = insertvalue { fp128, fp128 } undef, fp128 %10, 0
  %13 = insertvalue { fp128, fp128 } %12, fp128 %11, 1
  ret { fp128, fp128 } %13
}

; Function Attrs: norecurse nounwind readnone
define zeroext i1 @func_qcomp_1_i(fp128 %0, fp128 %1, i1 zeroext %2, i1 zeroext %3) {
; CHECK-LABEL: func_qcomp_1_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s6, 8(, %s1)
; CHECK-NEXT:    ld %s7, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i1 %2, i1 %3
  ret i1 %8
}

; Function Attrs: norecurse nounwind readnone
define signext i8 @func_qcomp_8_i(fp128 %0, fp128 %1, i8 signext %2, i8 signext %3) {
; CHECK-LABEL: func_qcomp_8_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s6, 8(, %s1)
; CHECK-NEXT:    ld %s7, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i8 %2, i8 %3
  ret i8 %8
}

; Function Attrs: norecurse nounwind readnone
define zeroext i8 @func_qcomp_u8_i(fp128 %0, fp128 %1, i8 zeroext %2, i8 zeroext %3) {
; CHECK-LABEL: func_qcomp_u8_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s6, 8(, %s1)
; CHECK-NEXT:    ld %s7, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i8 %2, i8 %3
  ret i8 %8
}

; Function Attrs: norecurse nounwind readnone
define signext i16 @func_qcomp_16_i(fp128 %0, fp128 %1, i16 signext %2, i16 signext %3) {
; CHECK-LABEL: func_qcomp_16_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s6, 8(, %s1)
; CHECK-NEXT:    ld %s7, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i16 %2, i16 %3
  ret i16 %8
}

; Function Attrs: norecurse nounwind readnone
define zeroext i16 @func_qcomp_u16_i(fp128 %0, fp128 %1, i16 zeroext %2, i16 zeroext %3) {
; CHECK-LABEL: func_qcomp_u16_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s6, 8(, %s1)
; CHECK-NEXT:    ld %s7, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i16 %2, i16 %3
  ret i16 %8
}

; Function Attrs: norecurse nounwind readnone
define signext i32 @func_qcomp_32_i(fp128 %0, fp128 %1, i32 signext %2, i32 signext %3) {
; CHECK-LABEL: func_qcomp_32_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s6, 8(, %s1)
; CHECK-NEXT:    ld %s7, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i32 %2, i32 %3
  ret i32 %8
}

; Function Attrs: norecurse nounwind readnone
define zeroext i32 @func_qcomp_u32_i(fp128 %0, fp128 %1, i32 zeroext %2, i32 zeroext %3) {
; CHECK-LABEL: func_qcomp_u32_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s6, 8(, %s1)
; CHECK-NEXT:    ld %s7, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i32 %2, i32 %3
  ret i32 %8
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_qcomp_64_i(fp128 %0, fp128 %1, i64 %2, i64 %3) {
; CHECK-LABEL: func_qcomp_64_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s6, 8(, %s1)
; CHECK-NEXT:    ld %s7, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    or %s0, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i64 %2, i64 %3
  ret i64 %8
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_qcomp_u64_i(fp128 %0, fp128 %1, i64 %2, i64 %3) {
; CHECK-LABEL: func_qcomp_u64_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s6, 8(, %s1)
; CHECK-NEXT:    ld %s7, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    or %s0, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i64 %2, i64 %3
  ret i64 %8
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_qcomp_128_i(fp128 %0, fp128 %1, i128 %2, i128 %3) {
; CHECK-LABEL: func_qcomp_128_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s34, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s34, .LCPI{{[0-9]+}}_0@hi(, %s34)
; CHECK-NEXT:    ld %s36, 8(, %s34)
; CHECK-NEXT:    ld %s37, (, %s34)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s36
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s34, 8(, %s1)
; CHECK-NEXT:    ld %s35, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s36, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s36, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s34
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s36, %s1
; CHECK-NEXT:    cmov.w.ne %s6, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s7, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i128 %2, i128 %3
  ret i128 %8
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_qcomp_u128_i(fp128 %0, fp128 %1, i128 %2, i128 %3) {
; CHECK-LABEL: func_qcomp_u128_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s34, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s34, .LCPI{{[0-9]+}}_0@hi(, %s34)
; CHECK-NEXT:    ld %s36, 8(, %s34)
; CHECK-NEXT:    ld %s37, (, %s34)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s36
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s34, 8(, %s1)
; CHECK-NEXT:    ld %s35, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s36, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s36, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s34
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s36, %s1
; CHECK-NEXT:    cmov.w.ne %s6, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s7, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i128 %2, i128 %3
  ret i128 %8
}

; Function Attrs: norecurse nounwind readnone
define float @func_qcomp_float_i(fp128 %0, fp128 %1, float %2, float %3) {
; CHECK-LABEL: func_qcomp_float_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s6, 8(, %s1)
; CHECK-NEXT:    ld %s7, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    or %s0, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, float %2, float %3
  ret float %8
}

; Function Attrs: norecurse nounwind readnone
define double @func_qcomp_double_i(fp128 %0, fp128 %1, double %2, double %3) {
; CHECK-LABEL: func_qcomp_double_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s6, 8(, %s1)
; CHECK-NEXT:    ld %s7, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    or %s0, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, double %2, double %3
  ret double %8
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_qcomp_quad_i(fp128 %0, fp128 %1, fp128 %2, fp128 %3) {
; CHECK-LABEL: func_qcomp_quad_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s34, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s34, .LCPI{{[0-9]+}}_0@hi(, %s34)
; CHECK-NEXT:    ld %s36, 8(, %s34)
; CHECK-NEXT:    ld %s37, (, %s34)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s36
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s34, 8(, %s1)
; CHECK-NEXT:    ld %s35, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s36, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s36, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s34
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s36, %s1
; CHECK-NEXT:    cmov.w.ne %s6, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s7, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, fp128 %2, fp128 %3
  ret fp128 %8
}

; Function Attrs: norecurse nounwind readnone
define { float, float } @func_qcomp_fcomp_i(fp128 %0, fp128 %1, float %2, float %3, float %4, float %5) {
; CHECK-LABEL: func_qcomp_fcomp_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s34, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s34, .LCPI{{[0-9]+}}_0@hi(, %s34)
; CHECK-NEXT:    ld %s36, 8(, %s34)
; CHECK-NEXT:    ld %s37, (, %s34)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s36
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s34, 8(, %s1)
; CHECK-NEXT:    ld %s35, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s36, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s36, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s34
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s36, %s1
; CHECK-NEXT:    cmov.w.ne %s6, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s7, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %8 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %9 = and i1 %7, %8
  %10 = select i1 %9, float %2, float %4
  %11 = select i1 %9, float %3, float %5
  %12 = insertvalue { float, float } undef, float %10, 0
  %13 = insertvalue { float, float } %12, float %11, 1
  ret { float, float } %13
}

; Function Attrs: norecurse nounwind readnone
define { double, double } @func_qcomp_dcomp_i(fp128 %0, fp128 %1, double %2, double %3, double %4, double %5) {
; CHECK-LABEL: func_qcomp_dcomp_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s34, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s34, .LCPI{{[0-9]+}}_0@hi(, %s34)
; CHECK-NEXT:    ld %s36, 8(, %s34)
; CHECK-NEXT:    ld %s37, (, %s34)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s36
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s34, 8(, %s1)
; CHECK-NEXT:    ld %s35, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s36, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s36, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s34
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s36, %s1
; CHECK-NEXT:    cmov.w.ne %s6, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s7, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %8 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %9 = and i1 %7, %8
  %10 = select i1 %9, double %2, double %4
  %11 = select i1 %9, double %3, double %5
  %12 = insertvalue { double, double } undef, double %10, 0
  %13 = insertvalue { double, double } %12, double %11, 1
  ret { double, double } %13
}

; Function Attrs: norecurse nounwind readnone
define { fp128, fp128 } @func_qcomp_qcomp_i(fp128 %0, fp128 %1, fp128 %2, fp128 %3, fp128 %4, fp128 %5) {
; CHECK-LABEL: func_qcomp_qcomp_i:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s34, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s34, .LCPI{{[0-9]+}}_0@hi(, %s34)
; CHECK-NEXT:    ld %s38, 8(, %s34)
; CHECK-NEXT:    ld %s39, (, %s34)
; CHECK-NEXT:    ld %s35, 256(, %s11)
; CHECK-NEXT:    ld %s34, 264(, %s11)
; CHECK-NEXT:    ld %s37, 240(, %s11)
; CHECK-NEXT:    ld %s36, 248(, %s11)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s38
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s38, 8(, %s1)
; CHECK-NEXT:    ld %s39, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s40, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s40, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s38
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s40, %s1
; CHECK-NEXT:    cmov.w.ne %s36, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s37, %s5, %s0
; CHECK-NEXT:    cmov.w.ne %s34, %s6, %s0
; CHECK-NEXT:    cmov.w.ne %s35, %s7, %s0
; CHECK-NEXT:    or %s0, 0, %s36
; CHECK-NEXT:    or %s1, 0, %s37
; CHECK-NEXT:    or %s2, 0, %s34
; CHECK-NEXT:    or %s3, 0, %s35
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq fp128 %0, 0xL00000000000000004002800000000000
  %8 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %9 = and i1 %7, %8
  %10 = select i1 %9, fp128 %2, fp128 %4
  %11 = select i1 %9, fp128 %3, fp128 %5
  %12 = insertvalue { fp128, fp128 } undef, fp128 %10, 0
  %13 = insertvalue { fp128, fp128 } %12, fp128 %11, 1
  ret { fp128, fp128 } %13
}

; Function Attrs: norecurse nounwind readnone
define zeroext i1 @func_qcomp_1_m(fp128 %0, fp128 %1, i1 zeroext %2, i1 zeroext %3) {
; CHECK-LABEL: func_qcomp_1_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s6, 8(, %s1)
; CHECK-NEXT:    ld %s7, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i1 %2, i1 %3
  ret i1 %8
}

; Function Attrs: norecurse nounwind readnone
define signext i8 @func_qcomp_8_m(fp128 %0, fp128 %1, i8 signext %2, i8 signext %3) {
; CHECK-LABEL: func_qcomp_8_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s6, 8(, %s1)
; CHECK-NEXT:    ld %s7, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i8 %2, i8 %3
  ret i8 %8
}

; Function Attrs: norecurse nounwind readnone
define zeroext i8 @func_qcomp_u8_m(fp128 %0, fp128 %1, i8 zeroext %2, i8 zeroext %3) {
; CHECK-LABEL: func_qcomp_u8_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s6, 8(, %s1)
; CHECK-NEXT:    ld %s7, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i8 %2, i8 %3
  ret i8 %8
}

; Function Attrs: norecurse nounwind readnone
define signext i16 @func_qcomp_16_m(fp128 %0, fp128 %1, i16 signext %2, i16 signext %3) {
; CHECK-LABEL: func_qcomp_16_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s6, 8(, %s1)
; CHECK-NEXT:    ld %s7, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i16 %2, i16 %3
  ret i16 %8
}

; Function Attrs: norecurse nounwind readnone
define zeroext i16 @func_qcomp_u16_m(fp128 %0, fp128 %1, i16 zeroext %2, i16 zeroext %3) {
; CHECK-LABEL: func_qcomp_u16_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s6, 8(, %s1)
; CHECK-NEXT:    ld %s7, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i16 %2, i16 %3
  ret i16 %8
}

; Function Attrs: norecurse nounwind readnone
define signext i32 @func_qcomp_32_m(fp128 %0, fp128 %1, i32 signext %2, i32 signext %3) {
; CHECK-LABEL: func_qcomp_32_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s6, 8(, %s1)
; CHECK-NEXT:    ld %s7, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i32 %2, i32 %3
  ret i32 %8
}

; Function Attrs: norecurse nounwind readnone
define zeroext i32 @func_qcomp_u32_m(fp128 %0, fp128 %1, i32 zeroext %2, i32 zeroext %3) {
; CHECK-LABEL: func_qcomp_u32_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s6, 8(, %s1)
; CHECK-NEXT:    ld %s7, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s5, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i32 %2, i32 %3
  ret i32 %8
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_qcomp_64_m(fp128 %0, fp128 %1, i64 %2, i64 %3) {
; CHECK-LABEL: func_qcomp_64_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s6, 8(, %s1)
; CHECK-NEXT:    ld %s7, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    or %s0, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i64 %2, i64 %3
  ret i64 %8
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_qcomp_u64_m(fp128 %0, fp128 %1, i64 %2, i64 %3) {
; CHECK-LABEL: func_qcomp_u64_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s6, 8(, %s1)
; CHECK-NEXT:    ld %s7, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    or %s0, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i64 %2, i64 %3
  ret i64 %8
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_qcomp_128_m(fp128 %0, fp128 %1, i128 %2, i128 %3) {
; CHECK-LABEL: func_qcomp_128_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s34, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s34, .LCPI{{[0-9]+}}_0@hi(, %s34)
; CHECK-NEXT:    ld %s36, 8(, %s34)
; CHECK-NEXT:    ld %s37, (, %s34)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s36
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s34, 8(, %s1)
; CHECK-NEXT:    ld %s35, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s36, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s36, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s34
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s36, %s1
; CHECK-NEXT:    cmov.w.ne %s6, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s7, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i128 %2, i128 %3
  ret i128 %8
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_qcomp_u128_m(fp128 %0, fp128 %1, i128 %2, i128 %3) {
; CHECK-LABEL: func_qcomp_u128_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s34, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s34, .LCPI{{[0-9]+}}_0@hi(, %s34)
; CHECK-NEXT:    ld %s36, 8(, %s34)
; CHECK-NEXT:    ld %s37, (, %s34)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s36
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s34, 8(, %s1)
; CHECK-NEXT:    ld %s35, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s36, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s36, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s34
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s36, %s1
; CHECK-NEXT:    cmov.w.ne %s6, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s7, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, i128 %2, i128 %3
  ret i128 %8
}

; Function Attrs: norecurse nounwind readnone
define float @func_qcomp_float_m(fp128 %0, fp128 %1, float %2, float %3) {
; CHECK-LABEL: func_qcomp_float_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s6, 8(, %s1)
; CHECK-NEXT:    ld %s7, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    or %s0, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, float %2, float %3
  ret float %8
}

; Function Attrs: norecurse nounwind readnone
define double @func_qcomp_double_m(fp128 %0, fp128 %1, double %2, double %3) {
; CHECK-LABEL: func_qcomp_double_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s6, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s6, %s6, (32)0
; CHECK-NEXT:    lea.sl %s6, .LCPI{{[0-9]+}}_0@hi(, %s6)
; CHECK-NEXT:    ld %s34, 8(, %s6)
; CHECK-NEXT:    ld %s35, (, %s6)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s34
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s6, 8(, %s1)
; CHECK-NEXT:    ld %s7, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s34, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s6
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s34, %s1
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s0
; CHECK-NEXT:    or %s0, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, double %2, double %3
  ret double %8
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_qcomp_quad_m(fp128 %0, fp128 %1, fp128 %2, fp128 %3) {
; CHECK-LABEL: func_qcomp_quad_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s34, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s34, .LCPI{{[0-9]+}}_0@hi(, %s34)
; CHECK-NEXT:    ld %s36, 8(, %s34)
; CHECK-NEXT:    ld %s37, (, %s34)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s36
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s34, 8(, %s1)
; CHECK-NEXT:    ld %s35, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s36, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s36, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s34
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s36, %s1
; CHECK-NEXT:    cmov.w.ne %s6, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s7, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %6 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %7 = and i1 %5, %6
  %8 = select i1 %7, fp128 %2, fp128 %3
  ret fp128 %8
}

; Function Attrs: norecurse nounwind readnone
define { float, float } @func_qcomp_fcomp_m(fp128 %0, fp128 %1, float %2, float %3, float %4, float %5) {
; CHECK-LABEL: func_qcomp_fcomp_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s34, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s34, .LCPI{{[0-9]+}}_0@hi(, %s34)
; CHECK-NEXT:    ld %s36, 8(, %s34)
; CHECK-NEXT:    ld %s37, (, %s34)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s36
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s34, 8(, %s1)
; CHECK-NEXT:    ld %s35, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s36, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s36, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s34
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s36, %s1
; CHECK-NEXT:    cmov.w.ne %s6, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s7, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %8 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %9 = and i1 %7, %8
  %10 = select i1 %9, float %2, float %4
  %11 = select i1 %9, float %3, float %5
  %12 = insertvalue { float, float } undef, float %10, 0
  %13 = insertvalue { float, float } %12, float %11, 1
  ret { float, float } %13
}

; Function Attrs: norecurse nounwind readnone
define { double, double } @func_qcomp_dcomp_m(fp128 %0, fp128 %1, double %2, double %3, double %4, double %5) {
; CHECK-LABEL: func_qcomp_dcomp_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s34, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s34, .LCPI{{[0-9]+}}_0@hi(, %s34)
; CHECK-NEXT:    ld %s36, 8(, %s34)
; CHECK-NEXT:    ld %s37, (, %s34)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s36
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s34, 8(, %s1)
; CHECK-NEXT:    ld %s35, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s36, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s36, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s34
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s36, %s1
; CHECK-NEXT:    cmov.w.ne %s6, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s7, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %8 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %9 = and i1 %7, %8
  %10 = select i1 %9, double %2, double %4
  %11 = select i1 %9, double %3, double %5
  %12 = insertvalue { double, double } undef, double %10, 0
  %13 = insertvalue { double, double } %12, double %11, 1
  ret { double, double } %13
}

; Function Attrs: norecurse nounwind readnone
define { fp128, fp128 } @func_qcomp_qcomp_m(fp128 %0, fp128 %1, fp128 %2, fp128 %3, fp128 %4, fp128 %5) {
; CHECK-LABEL: func_qcomp_qcomp_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s34, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s34, .LCPI{{[0-9]+}}_0@hi(, %s34)
; CHECK-NEXT:    ld %s38, 8(, %s34)
; CHECK-NEXT:    ld %s39, (, %s34)
; CHECK-NEXT:    ld %s35, 256(, %s11)
; CHECK-NEXT:    ld %s34, 264(, %s11)
; CHECK-NEXT:    ld %s37, 240(, %s11)
; CHECK-NEXT:    ld %s36, 248(, %s11)
; CHECK-NEXT:    fcmp.q %s0, %s0, %s38
; CHECK-NEXT:    lea %s1, .LCPI{{[0-9]+}}_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI{{[0-9]+}}_1@hi(, %s1)
; CHECK-NEXT:    ld %s38, 8(, %s1)
; CHECK-NEXT:    ld %s39, (, %s1)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s40, 0, (0)1
; CHECK-NEXT:    cmov.d.eq %s40, (63)0, %s0
; CHECK-NEXT:    fcmp.q %s0, %s2, %s38
; CHECK-NEXT:    cmov.d.eq %s1, (63)0, %s0
; CHECK-NEXT:    and %s0, %s40, %s1
; CHECK-NEXT:    cmov.w.ne %s36, %s4, %s0
; CHECK-NEXT:    cmov.w.ne %s37, %s5, %s0
; CHECK-NEXT:    cmov.w.ne %s34, %s6, %s0
; CHECK-NEXT:    cmov.w.ne %s35, %s7, %s0
; CHECK-NEXT:    or %s0, 0, %s36
; CHECK-NEXT:    or %s1, 0, %s37
; CHECK-NEXT:    or %s2, 0, %s34
; CHECK-NEXT:    or %s3, 0, %s35
; CHECK-NEXT:    b.l.t (, %s10)
  %7 = fcmp oeq fp128 %0, 0xL0000000000000000C000000000000000
  %8 = fcmp oeq fp128 %1, 0xL00000000000000000000000000000000
  %9 = and i1 %7, %8
  %10 = select i1 %9, fp128 %2, fp128 %4
  %11 = select i1 %9, fp128 %3, fp128 %5
  %12 = insertvalue { fp128, fp128 } undef, fp128 %10, 0
  %13 = insertvalue { fp128, fp128 } %12, fp128 %11, 1
  ret { fp128, fp128 } %13
}
