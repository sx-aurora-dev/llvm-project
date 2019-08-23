; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define signext i8 @func1(i8 signext, i8 signext) {
; CHECK-LABEL: func1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s34, %s1, %s0
  %3 = add i8 %1, %0
  ret i8 %3
}

define signext i16 @func2(i16 signext, i16 signext) {
; CHECK-LABEL: func2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s34, %s1, %s0
  %3 = add i16 %1, %0
  ret i16 %3
}

define i32 @func3(i32, i32) {
; CHECK-LABEL: func3:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s1, %s0
  %3 = add nsw i32 %1, %0
  ret i32 %3
}

define i64 @func4(i64, i64) {
; CHECK-LABEL: func4:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.l %s0, %s1, %s0
  %3 = add nsw i64 %1, %0
  ret i64 %3
}

define i128 @func5(i128, i128) {
; CHECK-LABEL: func5:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.l %s34, %s3, %s1
; CHECK-NEXT:    adds.l %s0, %s2, %s0
; CHECK-NEXT:    cmpu.l %s35, %s0, %s2
; CHECK-NEXT:    or %s36, 0, (0)1
; CHECK-NEXT:    cmov.l.lt %s36, (63)0, %s35
; CHECK-NEXT:    adds.w.zx %s35, %s36, (0)1
; CHECK-NEXT:    adds.l %s1, %s34, %s35
  %3 = add nsw i128 %1, %0
  ret i128 %3
}

define zeroext i8 @func6(i8 zeroext, i8 zeroext) {
; CHECK-LABEL: func6:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s34, %s1, %s0
  %3 = add i8 %1, %0
  ret i8 %3
}

define zeroext i16 @func7(i16 zeroext, i16 zeroext) {
; CHECK-LABEL: func7:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s34, %s1, %s0
  %3 = add i16 %1, %0
  ret i16 %3
}

define i32 @func8(i32, i32) {
; CHECK-LABEL: func8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s1, %s0
  %3 = add i32 %1, %0
  ret i32 %3
}

define i64 @func9(i64, i64) {
; CHECK-LABEL: func9:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.l %s0, %s1, %s0
  %3 = add i64 %1, %0
  ret i64 %3
}

define i128 @func10(i128, i128) {
; CHECK-LABEL: func10:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.l %s34, %s3, %s1
; CHECK-NEXT:    adds.l %s0, %s2, %s0
; CHECK-NEXT:    cmpu.l %s35, %s0, %s2
; CHECK-NEXT:    or %s36, 0, (0)1
; CHECK-NEXT:    cmov.l.lt %s36, (63)0, %s35
; CHECK-NEXT:    adds.w.zx %s35, %s36, (0)1
; CHECK-NEXT:    adds.l %s1, %s34, %s35
  %3 = add i128 %1, %0
  ret i128 %3
}

define float @func11(float, float) {
; CHECK-LABEL: func11:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fadd.s %s0, %s0, %s1
  %3 = fadd float %0, %1
  ret float %3
}

define double @func12(double, double) {
; CHECK-LABEL: func12:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fadd.d %s0, %s0, %s1
  %3 = fadd double %0, %1
  ret double %3
}

define signext i8 @func13(i8 signext) {
; CHECK-LABEL: func13:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, 5(%s0)
; CHECK-NEXT:    sla.w.sx %s34, %s34, 24
; CHECK-NEXT:    sra.w.sx %s0, %s34, 24
  %2 = add i8 %0, 5
  ret i8 %2
}

define signext i16 @func14(i16 signext) {
; CHECK-LABEL: func14:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, 5(%s0)
; CHECK-NEXT:    sla.w.sx %s34, %s34, 16
; CHECK-NEXT:    sra.w.sx %s0, %s34, 16
  %2 = add i16 %0, 5
  ret i16 %2
}

define i32 @func15(i32) {
; CHECK-LABEL: func15:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 5(%s0)
  %2 = add nsw i32 %0, 5
  ret i32 %2
}

define i64 @func16(i64) {
; CHECK-LABEL: func16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 5(%s0)
  %2 = add nsw i64 %0, 5
  ret i64 %2
}

define i128 @func17(i128) {
; CHECK-LABEL: func17:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, 5(%s0)
; CHECK-NEXT:    cmpu.l %s35, %s34, %s0
; CHECK-NEXT:    or %s36, 0, (0)1
; CHECK-NEXT:    cmov.l.lt %s36, (63)0, %s35
; CHECK-NEXT:    adds.w.zx %s35, %s36, (0)1
; CHECK-NEXT:    adds.l %s1, %s1, %s35
; CHECK-NEXT:    or %s0, 0, %s34
  %2 = add nsw i128 %0, 5
  ret i128 %2
}

define zeroext i8 @func18(i8 zeroext) {
; CHECK-LABEL: func18:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, 5(%s0)
; CHECK-NEXT:    and %s0, %s34, (56)0
  %2 = add i8 %0, 5
  ret i8 %2
}

define zeroext i16 @func19(i16 zeroext) {
; CHECK-LABEL: func19:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, 5(%s0)
; CHECK-NEXT:    and %s0, %s34, (48)0
  %2 = add i16 %0, 5
  ret i16 %2
}

define i32 @func20(i32) {
; CHECK-LABEL: func20:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 5(%s0)
  %2 = add i32 %0, 5
  ret i32 %2
}

define i64 @func21(i64) {
; CHECK-LABEL: func21:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 5(%s0)
  %2 = add i64 %0, 5
  ret i64 %2
}

define i128 @func22(i128) {
; CHECK-LABEL: func22:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, 5(%s0)
; CHECK-NEXT:    cmpu.l %s35, %s34, %s0
; CHECK-NEXT:    or %s36, 0, (0)1
; CHECK-NEXT:    cmov.l.lt %s36, (63)0, %s35
; CHECK-NEXT:    adds.w.zx %s35, %s36, (0)1
; CHECK-NEXT:    adds.l %s1, %s1, %s35
; CHECK-NEXT:    or %s0, 0, %s34
  %2 = add i128 %0, 5
  ret i128 %2
}

define float @func23(float) {
; CHECK-LABEL: func23:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s34, 1084227584
; CHECK-NEXT:    or %s34, 0, %s34
; CHECK-NEXT:    fadd.s %s0, %s0, %s34
  %2 = fadd float %0, 5.000000e+00
  ret float %2
}

define double @func24(double) {
; CHECK-LABEL: func24:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s34, 1075052544
; CHECK-NEXT:    fadd.d %s0, %s0, %s34
  %2 = fadd double %0, 5.000000e+00
  ret double %2
}

define i32 @func25(i32) {
; CHECK-LABEL: func25:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, -2147483648
; CHECK-NEXT:    xor %s0, %s0, %s34
  %2 = xor i32 %0, -2147483648
  ret i32 %2
}

define i64 @func26(i64) {
; CHECK-LABEL: func26:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, -2147483648
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    adds.l %s0, %s0, %s34
  %2 = add nsw i64 %0, 2147483648
  ret i64 %2
}

define i128 @func27(i128) {
; CHECK-LABEL: func27:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, -2147483648
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    adds.l %s34, %s0, %s34
; CHECK-NEXT:    cmpu.l %s35, %s34, %s0
; CHECK-NEXT:    or %s36, 0, (0)1
; CHECK-NEXT:    cmov.l.lt %s36, (63)0, %s35
; CHECK-NEXT:    adds.w.zx %s35, %s36, (0)1
; CHECK-NEXT:    adds.l %s1, %s1, %s35
; CHECK-NEXT:    or %s0, 0, %s34
  %2 = add nsw i128 %0, 2147483648
  ret i128 %2
}

