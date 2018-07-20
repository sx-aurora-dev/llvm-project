; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define i32 @selectccsgti8(i8, i8, i32, i32) #0 {
; CHECK-LABEL: selectccsgti8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw3 killed $sw3 def $sx3
; CHECK-NEXT:    # kill: def $sw2 killed $sw2 def $sx2
; CHECK-NEXT:    sla.w.sx %s34, %s1, 24
; CHECK-NEXT:    sra.w.sx %s34, %s34, 24
; CHECK-NEXT:    sla.w.sx %s35, %s0, 24
; CHECK-NEXT:    sra.w.sx %s35, %s35, 24
; CHECK-NEXT:    cmps.w.sx %s34, %s35, %s34
; CHECK-NEXT:    cmov.w.gt %s3, %s2, %s34
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = icmp sgt i8 %0, %1
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define i32 @selectccsgti16(i16, i16, i32, i32) #0 {
; CHECK-LABEL: selectccsgti16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw3 killed $sw3 def $sx3
; CHECK-NEXT:    # kill: def $sw2 killed $sw2 def $sx2
; CHECK-NEXT:    sla.w.sx %s34, %s1, 16
; CHECK-NEXT:    sra.w.sx %s34, %s34, 16
; CHECK-NEXT:    sla.w.sx %s35, %s0, 16
; CHECK-NEXT:    sra.w.sx %s35, %s35, 16
; CHECK-NEXT:    cmps.w.sx %s34, %s35, %s34
; CHECK-NEXT:    cmov.w.gt %s3, %s2, %s34
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = icmp sgt i16 %0, %1
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define i32 @selectccsgti32(i32, i32, i32, i32) #0 {
; CHECK-LABEL: selectccsgti32:
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

define i32 @selectccsgti64(i64, i64, i32, i32) #0 {
; CHECK-LABEL: selectccsgti64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw3 killed $sw3 def $sx3
; CHECK-NEXT:    # kill: def $sw2 killed $sw2 def $sx2
; CHECK-NEXT:    cmps.l %s34, %s0, %s1
; CHECK-NEXT:    cmov.l.gt %s3, %s2, %s34
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = icmp sgt i64 %0, %1
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define i32 @selectccogtf32(float, float, i32, i32) #0 {
; CHECK-LABEL: selectccogtf32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw3 killed $sw3 def $sx3
; CHECK-NEXT:    # kill: def $sw2 killed $sw2 def $sx2
; CHECK-NEXT:    fcmp.s %s34, %s0, %s1
; CHECK-NEXT:    cmov.s.gt %s3, %s2, %s34
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = fcmp ogt float %0, %1
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define i32 @selectccogtf64(double, double, i32, i32) #0 {
; CHECK-LABEL: selectccogtf64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw3 killed $sw3 def $sx3
; CHECK-NEXT:    # kill: def $sw2 killed $sw2 def $sx2
; CHECK-NEXT:    fcmp.d %s34, %s0, %s1
; CHECK-NEXT:    cmov.d.gt %s3, %s2, %s34
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = fcmp ogt double %0, %1
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

