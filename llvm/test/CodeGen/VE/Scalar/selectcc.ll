; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define double @selectccf64(double, double, double, double) {
; CHECK-LABEL: selectccf64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.d %s0, %s0, %s1
; CHECK-NEXT:    cmov.d.gt %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp ogt double %0, %1
  %6 = select i1 %5, double %2, double %3
  ret double %6
}

define float @selectccf32(float, float, float, float) {
; CHECK-LABEL: selectccf32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcmp.s %s0, %s0, %s1
; CHECK-NEXT:    cmov.s.gt %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = fcmp ogt float %0, %1
  %6 = select i1 %5, float %2, float %3
  ret float %6
}

define i64 @selectcci64(i64, i64, i64, i64) {
; CHECK-LABEL: selectcci64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmps.l %s0, %s0, %s1
; CHECK-NEXT:    cmov.l.gt %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = icmp sgt i64 %0, %1
  %6 = select i1 %5, i64 %2, i64 %3
  ret i64 %6
}

define signext i32 @selectcci32(i32 signext, i32 signext, i32 signext, i32 signext) {
; CHECK-LABEL: selectcci32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmps.w.zx %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.gt %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = icmp sgt i32 %0, %1
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define signext i32 @selectcci32_2(i32 signext, i32 signext, i32 signext, i32 signext) {
; CHECK-LABEL: selectcci32_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmps.w.zx %s0, %s0, %s1
; CHECK-NEXT:    or %s1, 0, %s3
; CHECK-NEXT:    cmov.w.gt %s1, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s1, %s3
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = icmp sgt i32 %0, %1
  %6 = select i1 %5, i32 %2, i32 %3
  %7 = add nsw i32 %6, %3
  ret i32 %7
}

define zeroext i1 @selectcci1(i32 signext, i32 signext, i1 zeroext, i1 zeroext) {
; CHECK-LABEL: selectcci1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmps.w.zx %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.gt %s3, %s2, %s0
; CHECK-NEXT:    adds.w.zx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = icmp sgt i32 %0, %1
  %6 = select i1 %5, i1 %2, i1 %3
  ret i1 %6
}
