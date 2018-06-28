; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define double @maxf64(double, double) #0 {
; CHECK-LABEL: maxf64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fmax.d %s0,%s0,%s1
  %3 = fcmp ogt double %0, %1
  %4 = select i1 %3, double %0, double %1
  ret double %4
}

define float @maxf32(float, float) #0 {
; CHECK-LABEL: maxf32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fmax.s %s0,%s0,%s1
  %3 = fcmp ogt float %0, %1
  %4 = select i1 %3, float %0, float %1
  ret float %4
}

define i64 @maxi64(i64, i64) #0 {
; CHECK-LABEL: maxi64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    maxs.l %s0, %s0, %s1
  %3 = icmp sgt i64 %0, %1
  %4 = select i1 %3, i64 %0, i64 %1
  ret i64 %4
}

define i32 @maxi32(i32, i32) #0 {
; CHECK-LABEL: maxi32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    maxs.w.zx %s0, %s0, %s1
  %3 = icmp sgt i32 %0, %1
  %4 = select i1 %3, i32 %0, i32 %1
  ret i32 %4
}

define zeroext i1 @maxi1(i1 zeroext, i1 zeroext) #0 {
; CHECK-LABEL: maxi1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s34, %s0, %s1
; CHECK-NEXT:    or %s0, %s1, %s34
  %3 = xor i1 %1, true
  %4 = and i1 %3, %0
  %5 = select i1 %4, i1 %0, i1 %1
  ret i1 %5
}
