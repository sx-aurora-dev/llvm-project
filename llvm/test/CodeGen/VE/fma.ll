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

; Function Attrs: norecurse nounwind readnone
define dso_local <256 x double> @fma_v256d_1(<256 x double>, <256 x double>, <256 x double>) {
; CHECK-LABEL: fma_v256d_1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  lea %s34,4528(,%s11)
; CHECK-NEXT:  lea %s35,2480(,%s11)
; CHECK-NEXT:  vld %v0,8,%s35
; CHECK-NEXT:  lea %s35,432(,%s11)
; CHECK-NEXT:  vld %v1,8,%s35
; CHECK-NEXT:  vld %v2,8,%s34
; CHECK-NEXT:  vfmul.d %v0,%v1,%v0
; CHECK-NEXT:  vfadd.d %v0,%v0,%v2
; CHECK-NEXT:  vst %v0,8,%s0
  %4 = fmul <256 x double> %0, %1
  %5 = fadd <256 x double> %4, %2
  ret <256 x double> %5
}

; Function Attrs: norecurse nounwind readnone
define dso_local <256 x double> @fma_v256d_2(<256 x double>, <256 x double>, <256 x double>) {
; CHECK-LABEL: fma_v256d_2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  lea %s34,2480(,%s11)
; CHECK-NEXT:  vld %v0,8,%s34
; CHECK-NEXT:  lea %s34,432(,%s11)
; CHECK-NEXT:  vld %v1,8,%s34
; CHECK-NEXT:  lea %s34,4528(,%s11)
; CHECK-NEXT:  vld %v2,8,%s34
; CHECK-NEXT:  vfmad.d %v0,%v2,%v1,%v0
; CHECK-NEXT:  vst %v0,8,%s0
  %4 = fmul fast <256 x double> %0, %1
  %5 = fadd fast <256 x double> %4, %2
  ret <256 x double> %5
}

; Function Attrs: norecurse nounwind readnone
define dso_local <256 x float> @fma_v256f_1(<256 x float>, <256 x float>, <256 x float>) {
; CHECK-LABEL: fma_v256f_1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  lea %s34,2480(,%s11)
; CHECK-NEXT:  lea %s35,1456(,%s11)
; CHECK-NEXT:  vldu %v0,4,%s35
; CHECK-NEXT:  lea %s35,432(,%s11)
; CHECK-NEXT:  vldu %v1,4,%s35
; CHECK-NEXT:  vldu %v2,4,%s34
; CHECK-NEXT:  vfmul.s %v0,%v1,%v0
; CHECK-NEXT:  vfadd.s %v0,%v0,%v2
; CHECK-NEXT:  vstu %v0,4,%s0
  %4 = fmul <256 x float> %0, %1
  %5 = fadd <256 x float> %4, %2
  ret <256 x float> %5
}

; Function Attrs: norecurse nounwind readnone
define dso_local <256 x float> @fma_v256f_2(<256 x float>, <256 x float>, <256 x float>) {
; CHECK-LABEL: fma_v256f_2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  lea %s34,1456(,%s11)
; CHECK-NEXT:  vldu %v0,4,%s34
; CHECK-NEXT:  lea %s34,432(,%s11)
; CHECK-NEXT:  vldu %v1,4,%s34
; CHECK-NEXT:  lea %s34,2480(,%s11)
; CHECK-NEXT:  vldu %v2,4,%s34
; CHECK-NEXT:  pvfmad %v0,%v2,%v1,%v0
; CHECK-NEXT:  vstu %v0,4,%s0
  %4 = fmul fast <256 x float> %0, %1
  %5 = fadd fast <256 x float> %4, %2
  ret <256 x float> %5
}
