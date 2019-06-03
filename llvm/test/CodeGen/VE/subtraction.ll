; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define signext i8 @func1(i8 signext, i8 signext) {
; CHECK-LABEL: func1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    subs.w.sx %s34, %s0, %s1
  %3 = sub i8 %0, %1
  ret i8 %3
}

define signext i16 @func2(i16 signext, i16 signext) {
; CHECK-LABEL: func2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    subs.w.sx %s34, %s0, %s1
  %3 = sub i16 %0, %1
  ret i16 %3
}

define i32 @func3(i32, i32) {
; CHECK-LABEL: func3:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    subs.w.sx %s0, %s0, %s1
  %3 = sub nsw i32 %0, %1
  ret i32 %3
}

define i64 @func4(i64, i64) {
; CHECK-LABEL: func4:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    subs.l %s0, %s0, %s1
  %3 = sub nsw i64 %0, %1
  ret i64 %3
}

define i128 @func5(i128, i128) {
; CHECK-LABEL: func5:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    subs.l %s34, %s1, %s3
; CHECK-NEXT:    cmpu.l %s35, %s0, %s2
; CHECK-NEXT:    or %s36, 0, (0)1
; CHECK-NEXT:    cmov.l.lt %s36, (63)0, %s35
; CHECK-NEXT:    adds.w.zx %s35, %s36, (0)1
; CHECK-NEXT:    subs.l %s1, %s34, %s35
; CHECK-NEXT:    subs.l %s0, %s0, %s2
  %3 = sub nsw i128 %0, %1
  ret i128 %3
}

define zeroext i8 @func6(i8 zeroext, i8 zeroext) {
; CHECK-LABEL: func6:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    subs.w.sx %s34, %s0, %s1
  %3 = sub i8 %0, %1
  ret i8 %3
}

define zeroext i16 @func7(i16 zeroext, i16 zeroext) {
; CHECK-LABEL: func7:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    subs.w.sx %s34, %s0, %s1
  %3 = sub i16 %0, %1
  ret i16 %3
}

define i32 @func8(i32, i32) {
; CHECK-LABEL: func8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    subs.w.sx %s0, %s0, %s1
  %3 = sub i32 %0, %1
  ret i32 %3
}

define i64 @func9(i64, i64) {
; CHECK-LABEL: func9:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    subs.l %s0, %s0, %s1
  %3 = sub i64 %0, %1
  ret i64 %3
}

define i128 @func10(i128, i128) {
; CHECK-LABEL: func10:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    subs.l %s34, %s1, %s3
; CHECK-NEXT:    cmpu.l %s35, %s0, %s2
; CHECK-NEXT:    or %s36, 0, (0)1
; CHECK-NEXT:    cmov.l.lt %s36, (63)0, %s35
; CHECK-NEXT:    adds.w.zx %s35, %s36, (0)1
; CHECK-NEXT:    subs.l %s1, %s34, %s35
; CHECK-NEXT:    subs.l %s0, %s0, %s2
  %3 = sub i128 %0, %1
  ret i128 %3
}

define float @func11(float, float) {
; CHECK-LABEL: func11:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fsub.s %s0, %s0, %s1
  %3 = fsub float %0, %1
  ret float %3
}

define double @func12(double, double) {
; CHECK-LABEL: func12:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fsub.d %s0, %s0, %s1
  %3 = fsub double %0, %1
  ret double %3
}

define signext i8 @func13(i8 signext, i8 signext) {
; CHECK-LABEL: func13:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, -5(%s0)
; CHECK-NEXT:    sla.w.sx %s34, %s34, 24
; CHECK-NEXT:    sra.w.sx %s0, %s34, 24
  %3 = add i8 %0, -5
  ret i8 %3
}

define signext i16 @func14(i16 signext, i16 signext) {
; CHECK-LABEL: func14:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, -5(%s0)
; CHECK-NEXT:    sla.w.sx %s34, %s34, 16
; CHECK-NEXT:    sra.w.sx %s0, %s34, 16
  %3 = add i16 %0, -5
  ret i16 %3
}

define i32 @func15(i32, i32) {
; CHECK-LABEL: func15:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, -5(%s0)
  %3 = add nsw i32 %0, -5
  ret i32 %3
}

define i64 @func16(i64, i64) {
; CHECK-LABEL: func16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, -5(%s0)
  %3 = add nsw i64 %0, -5
  ret i64 %3
}

define i128 @func17(i128) {
; CHECK-LABEL: func17:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, -5(%s0)
; CHECK-NEXT:    cmpu.l %s35, %s34, %s0
; CHECK-NEXT:    or %s36, 0, (0)1
; CHECK-NEXT:    cmov.l.lt %s36, (63)0, %s35
; CHECK-NEXT:    adds.w.zx %s35, %s36, (0)1
; CHECK-NEXT:    lea %s1, -1(%s1, %s35)
; CHECK-NEXT:    or %s0, 0, %s34
  %2 = add nsw i128 %0, -5
  ret i128 %2
}

define zeroext i8 @func18(i8 zeroext, i8 zeroext) {
; CHECK-LABEL: func18:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, -5(%s0)
; CHECK-NEXT:    and %s0, %s34, (56)0
  %3 = add i8 %0, -5
  ret i8 %3
}

define zeroext i16 @func19(i16 zeroext, i16 zeroext) {
; CHECK-LABEL: func19:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, -5(%s0)
; CHECK-NEXT:    and %s0, %s34, (48)0
  %3 = add i16 %0, -5
  ret i16 %3
}

define i32 @func20(i32, i32) {
; CHECK-LABEL: func20:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, -5(%s0)
  %3 = add i32 %0, -5
  ret i32 %3
}

define i64 @func21(i64, i64) {
; CHECK-LABEL: func21:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, -5(%s0)
  %3 = add i64 %0, -5
  ret i64 %3
}

define i128 @func22(i128) {
; CHECK-LABEL: func22:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, -5(%s0)
; CHECK-NEXT:    cmpu.l %s35, %s34, %s0
; CHECK-NEXT:    or %s36, 0, (0)1
; CHECK-NEXT:    cmov.l.lt %s36, (63)0, %s35
; CHECK-NEXT:    adds.w.zx %s35, %s36, (0)1
; CHECK-NEXT:    lea %s1, -1(%s1, %s35)
; CHECK-NEXT:    or %s0, 0, %s34
  %2 = add i128 %0, -5
  ret i128 %2
}

define float @func23(float, float) {
; CHECK-LABEL: func23:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea.sl %s34, -1063256064
; CHECK-NEXT:  or %s34, 0, %s34
; CHECK-NEXT:  fadd.s %s0, %s0, %s34
  %3 = fadd float %0, -5.000000e+00
  ret float %3
}

define double @func24(double, double) {
; CHECK-LABEL: func24:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea.sl %s34, -1072431104
; CHECK-NEXT:  fadd.d %s0, %s0, %s34
  %3 = fadd double %0, -5.000000e+00
  ret double %3
}

define i32 @func25(i32, i32) {
; CHECK-LABEL: func25:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, -2147483648
; CHECK-NEXT:    xor %s0, %s0, %s34
  %3 = xor i32 %0, -2147483648
  ret i32 %3
}

define i64 @func26(i64, i64) {
; CHECK-LABEL: func26:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, -2147483648(%s0)
  %3 = add nsw i64 %0, -2147483648
  ret i64 %3
}

define i128 @func27(i128) {
; CHECK-LABEL: func27:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, -2147483648(%s0)
; CHECK-NEXT:    cmpu.l %s35, %s34, %s0
; CHECK-NEXT:    or %s36, 0, (0)1
; CHECK-NEXT:    cmov.l.lt %s36, (63)0, %s35
; CHECK-NEXT:    adds.w.zx %s35, %s36, (0)1
; CHECK-NEXT:    lea %s1, -1(%s1, %s35)
; CHECK-NEXT:    or %s0, 0, %s34
  %2 = add nsw i128 %0, -2147483648
  ret i128 %2
}
