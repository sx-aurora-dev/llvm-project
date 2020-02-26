; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define float @func1(float %a, float %b) {
; CHECK-LABEL: func1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fadd.s %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd float %a, %b
  ret float %r
}

define double @func2(double %a, double %b) {
; CHECK-LABEL: func2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fadd.d %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd double %a, %b
  ret double %r
}

define fp128 @func3(fp128 %a, fp128 %b) {
; CHECK-LABEL: func3:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fadd.q %s0, %s0, %s2
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd fp128 %a, %b
  ret fp128 %r
}

define float @func4(float %x) {
; CHECK-LABEL: func4:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s1, 1084227584
; CHECK-NEXT:    or %s1, 0, %s1
; CHECK-NEXT:    fadd.s %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd float %x, 5.000000e+00
  ret float %r
}

define double @func5(double %x) {
; CHECK-LABEL: func5:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s1, 1075052544
; CHECK-NEXT:    fadd.d %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd double %x, 5.000000e+00
  ret double %r
}

define fp128 @func6(fp128 %x) {
; CHECK-LABEL: func6:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, .LCPI5_0@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI5_0@hi(%s2)
; CHECK-NEXT:    ld %s4, 8(,%s2)
; CHECK-NEXT:    ld %s5, (,%s2)
; CHECK-NEXT:    fadd.q %s0, %s0, %s4
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd fp128 %x, 0xL00000000000000004001400000000000
  ret fp128 %r
}

define float @func7(float %x) {
; CHECK-LABEL: func7:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s1, 2139095039
; CHECK-NEXT:    or %s1, 0, %s1
; CHECK-NEXT:    fadd.s %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd float %x, 0x47EFFFFFE0000000
  ret float %r
}

define double @func8(double %x) {
; CHECK-LABEL: func8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, -1
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, 2146435071(%s1)
; CHECK-NEXT:    fadd.d %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd double %x, 0x7FEFFFFFFFFFFFFF
  ret double %r
}

define fp128 @func9(fp128 %x) {
; CHECK-LABEL: func9:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, .LCPI8_0@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, .LCPI8_0@hi(%s2)
; CHECK-NEXT:    ld %s4, 8(,%s2)
; CHECK-NEXT:    ld %s5, (,%s2)
; CHECK-NEXT:    fadd.q %s0, %s0, %s4
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd fp128 %x, 0xLFFFFFFFFFFFFFFFF7FFEFFFFFFFFFFFF
  ret fp128 %r
}
