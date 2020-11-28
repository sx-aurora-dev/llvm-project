; RUN: llc < %s -mtriple=ve | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define double @fma_d_1(double, double, double) {
; CHECK-LABEL: fma_d_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmul.d %s0, %s1, %s0
; CHECK-NEXT:    fadd.d %s0, %s0, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fmul double %1, %0
  %5 = fadd double %4, %2
  ret double %5
}

; Function Attrs: norecurse nounwind readnone
define double @fma_d_2(double, double, double) {
; CHECK-LABEL: fma_d_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmul.d %s0, %s1, %s0
; CHECK-NEXT:    fadd.d %s0, %s0, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fmul fast double %1, %0
  %5 = fadd fast double %4, %2
  ret double %5
}

; Function Attrs: norecurse nounwind readnone
define float @fma_f_1(float, float, float) {
; CHECK-LABEL: fma_f_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmul.s %s0, %s1, %s0
; CHECK-NEXT:    fadd.s %s0, %s0, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fmul float %1, %0
  %5 = fadd float %4, %2
  ret float %5
}

; Function Attrs: norecurse nounwind readnone
define float @fma_f_2(float, float, float) {
; CHECK-LABEL: fma_f_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmul.s %s0, %s1, %s0
; CHECK-NEXT:    fadd.s %s0, %s0, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = fmul fast float %1, %0
  %5 = fadd fast float %4, %2
  ret float %5
}
