; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define double @selectccf64(double, double, double, double) {
; CHECK-LABEL: selectccf64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fcmp.d %s34, %s0, %s1
; CHECK-NEXT:    cmov.d.gt %s3, %s2, %s34
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = fcmp ogt double %0, %1
  %6 = select i1 %5, double %2, double %3
  ret double %6
}

define float @selectccf32(float, float, float, float) {
; CHECK-LABEL: selectccf32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sf3 killed $sf3 def $sx3
; CHECK-NEXT:    # kill: def $sf2 killed $sf2 def $sx2
; CHECK-NEXT:    fcmp.s %s34, %s0, %s1
; CHECK-NEXT:    cmov.s.gt %s3, %s2, %s34
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = fcmp ogt float %0, %1
  %6 = select i1 %5, float %2, float %3
  ret float %6
}

define i64 @selectcci64(i64, i64, i64, i64) {
; CHECK-LABEL: selectcci64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmps.l %s34, %s0, %s1
; CHECK-NEXT:    cmov.l.gt %s3, %s2, %s34
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = icmp sgt i64 %0, %1
  %6 = select i1 %5, i64 %2, i64 %3
  ret i64 %6
}

define i32 @selectcci32(i32, i32, i32, i32) {
; CHECK-LABEL: selectcci32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw3 killed $sw3 def $sx3
; CHECK-NEXT:    # kill: def $sw2 killed $sw2 def $sx2
; CHECK-NEXT:    cmps.w.sx %s34, %s0, %s1
; CHECK-NEXT:    cmov.w.gt %s3, %s2, %s34
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = icmp sgt i32 %0, %1
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define i32 @selectcci32_2(i32, i32, i32, i32) {
; CHECK-LABEL: selectcci32_2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw3 killed $sw3 def $sx3
; CHECK-NEXT:    # kill: def $sw2 killed $sw2 def $sx2
; CHECK-NEXT:    cmps.w.sx %s34, %s0, %s1
; CHECK-NEXT:    or %s35, 0, %s3
; CHECK-NEXT:    cmov.w.gt %s35, %s2, %s34
; CHECK-NEXT:    adds.w.sx %s0, %s35, %s3
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = icmp sgt i32 %0, %1
  %6 = select i1 %5, i32 %2, i32 %3
  %7 = add nsw i32 %6, %3
  ret i32 %7
}

define zeroext i1 @selectcci1(i32, i32, i1 zeroext, i1 zeroext) {
; CHECK-LABEL: selectcci1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw3 killed $sw3 def $sx3
; CHECK-NEXT:    # kill: def $sw2 killed $sw2 def $sx2
; CHECK-NEXT:    cmps.w.sx %s34, %s0, %s1
; CHECK-NEXT:    cmov.w.gt %s3, %s2, %s34
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = icmp sgt i32 %0, %1
  %6 = select i1 %5, i1 %2, i1 %3
  ret i1 %6
}
