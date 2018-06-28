; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define double @minf64(double, double) #0 {
; CHECK-LABEL: minf64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fmin.d %s0,%s0,%s1
  %3 = fcmp olt double %0, %1
  %4 = select i1 %3, double %0, double %1
  ret double %4
}

define float @minf32(float, float) #0 {
; CHECK-LABEL: minf32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fmin.s %s0,%s0,%s1
  %3 = fcmp olt float %0, %1
  %4 = select i1 %3, float %0, float %1
  ret float %4
}

define i64 @mini64(i64, i64) #0 {
; CHECK-LABEL: mini64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    mins.l %s0, %s0, %s1
  %3 = icmp slt i64 %0, %1
  %4 = select i1 %3, i64 %0, i64 %1
  ret i64 %4
}

define i32 @mini32(i32, i32) #0 {
; CHECK-LABEL: mini32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    mins.w.zx %s0, %s0, %s1
  %3 = icmp slt i32 %0, %1
  %4 = select i1 %3, i32 %0, i32 %1
  ret i32 %4
}

; this test case crashes llvm
;define zeroext i1 @mini1(i1 zeroext, i1 zeroext) #0 {
;  %3 = xor i1 %0, true
;  %4 = and i1 %3, %1
;  %5 = select i1 %4, i1 %0, i1 %1
;  ret i1 %5
;}
