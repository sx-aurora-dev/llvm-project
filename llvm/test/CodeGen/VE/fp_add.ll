; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define float @func1(float, float) {
; CHECK-LABEL: func1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fadd.s %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = fadd float %0, %1
  ret float %3
}

define double @func2(double, double) {
; CHECK-LABEL: func2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fadd.d %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = fadd double %0, %1
  ret double %3
}

define fp128 @func3(fp128, fp128) {
; CHECK-LABEL: func3:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fadd.q %s0, %s0, %s2
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = fadd fp128 %0, %1
  ret fp128 %3
}

define float @func4(float) {
; CHECK-LABEL: func4:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea.sl %s34, 1084227584
; CHECK-NEXT:  or %s34, 0, %s34
; CHECK-NEXT:  fadd.s %s0, %s0, %s34
; CHECK-NEXT:  or %s11, 0, %s9
  %2 = fadd float %0, 5.000000e+00
  ret float %2
}

define double @func5(double) {
; CHECK-LABEL: func5:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea.sl %s34, 1075052544
; CHECK-NEXT:  fadd.d %s0, %s0, %s34
; CHECK-NEXT:  or %s11, 0, %s9
  %2 = fadd double %0, 5.000000e+00
  ret double %2
}

define fp128 @func6(fp128) {
; CHECK-LABEL: func6:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s34, .LCPI{{[0-9]+}}_0@hi(%s34)
; CHECK-NEXT:    ld %s36, 8(,%s34)
; CHECK-NEXT:    ld %s37, (,%s34)
; CHECK-NEXT:    fadd.q %s0, %s0, %s36
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fadd fp128 %0, 0xL00000000000000004001400000000000
  ret fp128 %2
}

define float @func7(float) {
; CHECK-LABEL: func7:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea.sl %s34, 2139095039
; CHECK-NEXT:  or %s34, 0, %s34
; CHECK-NEXT:  fadd.s %s0, %s0, %s34
; CHECK-NEXT:  or %s11, 0, %s9
  %2 = fadd float %0, 0x47EFFFFFE0000000
  ret float %2
}

define double @func8(double) {
; CHECK-LABEL: func8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, -1
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, 2146435071(%s34)
; CHECK-NEXT:  fadd.d %s0, %s0, %s34
; CHECK-NEXT:  or %s11, 0, %s9
  %2 = fadd double %0, 0x7FEFFFFFFFFFFFFF
  ret double %2
}

define fp128 @func9(fp128) {
; CHECK-LABEL: func9:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s34, .LCPI{{[0-9]+}}_0@hi(%s34)
; CHECK-NEXT:    ld %s36, 8(,%s34)
; CHECK-NEXT:    ld %s37, (,%s34)
; CHECK-NEXT:    fadd.q %s0, %s0, %s36
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fadd fp128 %0, 0xLFFFFFFFFFFFFFFFF7FFEFFFFFFFFFFFF
  ret fp128 %2
}
