; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define i128 @selectccsgti8(i8 signext, i8 signext, i128, i128) {
; CHECK-LABEL: selectccsgti8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmps.w.zx %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.gt %s4, %s2, %s0
; CHECK-NEXT:    cmov.w.gt %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = icmp sgt i8 %0, %1
  %6 = select i1 %5, i128 %2, i128 %3
  ret i128 %6
}

define i128 @selectccsgti16(i16 signext, i16 signext, i128, i128) {
; CHECK-LABEL: selectccsgti16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmps.w.zx %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.gt %s4, %s2, %s0
; CHECK-NEXT:    cmov.w.gt %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = icmp sgt i16 %0, %1
  %6 = select i1 %5, i128 %2, i128 %3
  ret i128 %6
}

define i128 @selectccsgti32(i32 signext, i32 signext, i128, i128) {
; CHECK-LABEL: selectccsgti32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmps.w.zx %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.gt %s4, %s2, %s0
; CHECK-NEXT:    cmov.w.gt %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = icmp sgt i32 %0, %1
  %6 = select i1 %5, i128 %2, i128 %3
  ret i128 %6
}

define i128 @selectccsgti64(i64, i64, i128, i128) {
; CHECK-LABEL: selectccsgti64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmps.l %s0, %s0, %s1
; CHECK-NEXT:    cmov.l.gt %s4, %s2, %s0
; CHECK-NEXT:    cmov.l.gt %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = icmp sgt i64 %0, %1
  %6 = select i1 %5, i128 %2, i128 %3
  ret i128 %6
}

define i128 @selectccsgti128(i128, i128, i128, i128) {
; CHECK-LABEL: selectccsgti128:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmpu.l %s34, %s1, %s3
; CHECK-NEXT:    cmps.l %s1, %s3, %s1
; CHECK-NEXT:    srl %s1, %s1, 63
; CHECK-NEXT:    cmpu.l %s0, %s2, %s0
; CHECK-NEXT:    srl %s0, %s0, 63
; CHECK-NEXT:    cmov.l.eq %s1, %s0, %s34
; CHECK-NEXT:    cmov.w.ne %s6, %s4, %s1
; CHECK-NEXT:    cmov.w.ne %s7, %s5, %s1
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = icmp sgt i128 %0, %1
  %6 = select i1 %5, i128 %2, i128 %3
  ret i128 %6
}

define i128 @selectccogtf32(float, float, i128, i128) {
; CHECK-LABEL: selectccogtf32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.s %s0, %s0, %s1
; CHECK-NEXT:    cmov.s.gt %s4, %s2, %s0
; CHECK-NEXT:    cmov.s.gt %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp ogt float %0, %1
  %6 = select i1 %5, i128 %2, i128 %3
  ret i128 %6
}

define i128 @selectccogtf64(double, double, i128, i128) {
; CHECK-LABEL: selectccogtf64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, %s1
; CHECK-NEXT:    cmov.d.gt %s4, %s2, %s0
; CHECK-NEXT:    cmov.d.gt %s5, %s3, %s0
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp ogt double %0, %1
  %6 = select i1 %5, i128 %2, i128 %3
  ret i128 %6
}

define i128 @selectccogtf128(fp128, fp128, i128, i128) {
; CHECK-LABEL: selectccogtf128:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.q %s0, %s0, %s2
; CHECK-NEXT:    cmov.d.gt %s6, %s4, %s0
; CHECK-NEXT:    cmov.d.gt %s7, %s5, %s0
; CHECK-NEXT:    or %s0, 0, %s6
; CHECK-NEXT:    or %s1, 0, %s7
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp ogt fp128 %0, %1
  %6 = select i1 %5, i128 %2, i128 %3
  ret i128 %6
}
