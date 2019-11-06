; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define dso_local double @fma_d_1(double, double, double) local_unnamed_addr #0 {
; CHECK-LABEL: fma_d_1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fmul.d %s34, %s1, %s0
; CHECK-NEXT:  fadd.d %s0, %s34, %s2
  %4 = fmul double %1, %0
  %5 = fadd double %4, %2
  ret double %5
}

; Function Attrs: norecurse nounwind readnone
define dso_local double @fma_d_2(double, double, double) local_unnamed_addr #0 {
; CHECK-LABEL: fma_d_2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fmul.d %s34, %s1, %s0
; CHECK-NEXT:  fadd.d %s0, %s34, %s2
  %4 = fmul fast double %1, %0
  %5 = fadd fast double %4, %2
  ret double %5
}

; Function Attrs: norecurse nounwind readnone
define dso_local float @fma_f_1(float, float, float) local_unnamed_addr #0 {
; CHECK-LABEL: fma_f_1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fmul.s %s34, %s1, %s0
; CHECK-NEXT:  fadd.s %s0, %s34, %s2
  %4 = fmul float %1, %0
  %5 = fadd float %4, %2
  ret float %5
}

; Function Attrs: norecurse nounwind readnone
define dso_local float @fma_f_2(float, float, float) local_unnamed_addr #0 {
; CHECK-LABEL: fma_f_2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fmul.s %s34, %s1, %s0
; CHECK-NEXT:  fadd.s %s0, %s34, %s2
  %4 = fmul fast float %1, %0
  %5 = fadd fast float %4, %2
  ret float %5
}
