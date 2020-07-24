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
