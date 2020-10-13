; RUN: llc < %s -mtriple=ve | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define zeroext i1 @func_int1_t(i1 zeroext %0, i1 zeroext %1, i1 zeroext %2) {
; CHECK-LABEL: func_int1_t:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s2, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i1 %1, i1 %2
  ret i1 %4
}

; Function Attrs: norecurse nounwind readnone
define signext i8 @func_int8_t(i1 zeroext %0, i8 signext %1, i8 signext %2) {
; CHECK-LABEL: func_int8_t:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s2, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i8 %1, i8 %2
  ret i8 %4
}

; Function Attrs: norecurse nounwind readnone
define zeroext i8 @func_uint8_t(i1 zeroext %0, i8 zeroext %1, i8 zeroext %2) {
; CHECK-LABEL: func_uint8_t:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s2, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i8 %1, i8 %2
  ret i8 %4
}

; Function Attrs: norecurse nounwind readnone
define signext i16 @func_int16_t(i1 zeroext %0, i16 signext %1, i16 signext %2) {
; CHECK-LABEL: func_int16_t:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s2, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i16 %1, i16 %2
  ret i16 %4
}

; Function Attrs: norecurse nounwind readnone
define zeroext i16 @func_uint16_t(i1 zeroext %0, i16 zeroext %1, i16 zeroext %2) {
; CHECK-LABEL: func_uint16_t:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s2, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i16 %1, i16 %2
  ret i16 %4
}

; Function Attrs: norecurse nounwind readnone
define signext i32 @func_int32_t(i1 zeroext %0, i32 signext %1, i32 signext %2) {
; CHECK-LABEL: func_int32_t:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s2, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i32 %1, i32 %2
  ret i32 %4
}

; Function Attrs: norecurse nounwind readnone
define zeroext i32 @func_uint32_t(i1 zeroext %0, i32 zeroext %1, i32 zeroext %2) {
; CHECK-LABEL: func_uint32_t:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s2, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i32 %1, i32 %2
  ret i32 %4
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_int64_t(i1 zeroext %0, i64 %1, i64 %2) {
; CHECK-LABEL: func_int64_t:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i64 %1, i64 %2
  ret i64 %4
}

; Function Attrs: norecurse nounwind readnone
define i64 @func_uint64_t(i1 zeroext %0, i64 %1, i64 %2) {
; CHECK-LABEL: func_uint64_t:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, i64 %1, i64 %2
  ret i64 %4
}

; Function Attrs: norecurse nounwind readnone
define i128 @func_int128_t(i1 zeroext %0, i128 %1, i128 %2) {
; CHECK-LABEL: func_int128_t:
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
define i128 @func_uint128_t(i1 zeroext %0, i128 %1, i128 %2) {
; CHECK-LABEL: func_uint128_t:
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
define float @func_float(i1 zeroext %0, float %1, float %2) {
; CHECK-LABEL: func_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, float %1, float %2
  ret float %4
}

; Function Attrs: norecurse nounwind readnone
define double @func_double(i1 zeroext %0, double %1, double %2) {
; CHECK-LABEL: func_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmov.w.ne %s2, %s1, %s0
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = select i1 %0, double %1, double %2
  ret double %4
}

; Function Attrs: norecurse nounwind readnone
define fp128 @func_quad(i1 zeroext %0, fp128 %1, fp128 %2) {
; CHECK-LABEL: func_quad:
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
define { float, float } @func_fcomp(i1 zeroext %0, float %1, float %2, float %3, float %4) {
; CHECK-LABEL: func_fcomp:
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
define { double, double } @func_dcomp(i1 zeroext %0, double %1, double %2, double %3, double %4) {
; CHECK-LABEL: func_dcomp:
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
define { fp128, fp128 } @func_qcomp(i1 zeroext %0, fp128 %1, fp128 %2, fp128 %3, fp128 %4) {
; CHECK-LABEL: func_qcomp:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld %s35, 240(, %s9)
; CHECK-NEXT:    ld %s34, 248(, %s9)
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
