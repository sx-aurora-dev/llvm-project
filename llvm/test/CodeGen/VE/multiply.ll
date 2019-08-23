; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define signext i8 @func1(i8 signext, i8 signext) {
; CHECK-LABEL: func1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s34, %s1, %s0
; CHECK-NEXT:    sla.w.sx %s34, %s34, 24
; CHECK-NEXT:    sra.w.sx %s0, %s34, 24
  %3 = mul i8 %1, %0
  ret i8 %3
}

define signext i16 @func2(i16 signext, i16 signext) {
; CHECK-LABEL: func2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s34, %s1, %s0
; CHECK-NEXT:    sla.w.sx %s34, %s34, 16
; CHECK-NEXT:    sra.w.sx %s0, %s34, 16
  %3 = mul i16 %1, %0
  ret i16 %3
}

define i32 @func3(i32, i32) {
; CHECK-LABEL: func3:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s0, %s1, %s0
  %3 = mul nsw i32 %1, %0
  ret i32 %3
}

define i64 @func4(i64, i64) {
; CHECK-LABEL: func4:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.l %s0, %s1, %s0
  %3 = mul nsw i64 %1, %0
  ret i64 %3
}

define i128 @func5(i128, i128) {
; CHECK-LABEL: func5:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s34, 0, %s1
; CHECK-NEXT:    or %s35, 0, %s0
; CHECK-NEXT:    lea %s36, __multi3@lo
; CHECK-NEXT:    and %s36, %s36, (32)0
; CHECK-NEXT:    lea.sl %s12, __multi3@hi(%s36)
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    or %s1, 0, %s3
; CHECK-NEXT:    or %s2, 0, %s35
; CHECK-NEXT:    or %s3, 0, %s34
; CHECK-NEXT:    bsic %lr, (,%s12)
  %3 = mul nsw i128 %1, %0
  ret i128 %3
}

define zeroext i8 @func6(i8 zeroext, i8 zeroext) {
; CHECK-LABEL: func6:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s34, %s1, %s0
; CHECK-NEXT:    and %s0, %s34, (56)0
  %3 = mul i8 %1, %0
  ret i8 %3
}

define zeroext i16 @func7(i16 zeroext, i16 zeroext) {
; CHECK-LABEL: func7:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s34, %s1, %s0
; CHECK-NEXT:    and %s0, %s34, (48)0
  %3 = mul i16 %1, %0
  ret i16 %3
}

define i32 @func8(i32, i32) {
; CHECK-LABEL: func8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s0, %s1, %s0
  %3 = mul i32 %1, %0
  ret i32 %3
}

define i64 @func9(i64, i64) {
; CHECK-LABEL: func9:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.l %s0, %s1, %s0
  %3 = mul i64 %1, %0
  ret i64 %3
}

define i128 @func10(i128, i128) {
; CHECK-LABEL: func10:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s34, 0, %s1
; CHECK-NEXT:    or %s35, 0, %s0
; CHECK-NEXT:    lea %s36, __multi3@lo
; CHECK-NEXT:    and %s36, %s36, (32)0
; CHECK-NEXT:    lea.sl %s12, __multi3@hi(%s36)
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    or %s1, 0, %s3
; CHECK-NEXT:    or %s2, 0, %s35
; CHECK-NEXT:    or %s3, 0, %s34
; CHECK-NEXT:    bsic %lr, (,%s12)
  %3 = mul i128 %1, %0
  ret i128 %3
}

define float @func11(float, float) {
; CHECK-LABEL: func11:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fmul.s %s0, %s0, %s1
  %3 = fmul float %0, %1
  ret float %3
}

define double @func12(double, double) {
; CHECK-LABEL: func12:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fmul.d %s0, %s0, %s1
  %3 = fmul double %0, %1
  ret double %3
}

define signext i8 @func13(i8 signext) {
; CHECK-LABEL: func13:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s34, 5, %s0
; CHECK-NEXT:    sla.w.sx %s34, %s34, 24
; CHECK-NEXT:    sra.w.sx %s0, %s34, 24
  %2 = mul i8 %0, 5
  ret i8 %2
}

define signext i16 @func14(i16 signext) {
; CHECK-LABEL: func14:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s34, 5, %s0
; CHECK-NEXT:    sla.w.sx %s34, %s34, 16
; CHECK-NEXT:    sra.w.sx %s0, %s34, 16
  %2 = mul i16 %0, 5
  ret i16 %2
}

define i32 @func15(i32) {
; CHECK-LABEL: func15:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s0, 5, %s0
  %2 = mul nsw i32 %0, 5
  ret i32 %2
}

define i64 @func16(i64) {
; CHECK-LABEL: func16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.l %s0, 5, %s0
  %2 = mul nsw i64 %0, 5
  ret i64 %2
}

define i128 @func17(i128) {
; CHECK-LABEL: func17:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, __multi3@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __multi3@hi(%s34)
; CHECK-NEXT:    or %s2, 5, (0)1
; CHECK-NEXT:    or %s3, 0, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
  %2 = mul nsw i128 %0, 5
  ret i128 %2
}

define zeroext i8 @func18(i8 zeroext) {
; CHECK-LABEL: func18:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s34, 5, %s0
; CHECK-NEXT:    and %s0, %s34, (56)0
  %2 = mul i8 %0, 5
  ret i8 %2
}

define zeroext i16 @func19(i16 zeroext) {
; CHECK-LABEL: func19:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s34, 5, %s0
; CHECK-NEXT:    and %s0, %s34, (48)0
  %2 = mul i16 %0, 5
  ret i16 %2
}

define i32 @func20(i32) {
; CHECK-LABEL: func20:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s0, 5, %s0
  %2 = mul i32 %0, 5
  ret i32 %2
}

define i64 @func21(i64) {
; CHECK-LABEL: func21:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.l %s0, 5, %s0
  %2 = mul i64 %0, 5
  ret i64 %2
}

define i128 @func22(i128) {
; CHECK-LABEL: func22:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, __multi3@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __multi3@hi(%s34)
; CHECK-NEXT:    or %s2, 5, (0)1
; CHECK-NEXT:    or %s3, 0, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
  %2 = mul i128 %0, 5
  ret i128 %2
}

define float @func23(float) {
; CHECK-LABEL: func23:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s34, 1084227584
; CHECK-NEXT:    or %s34, 0, %s34
; CHECK-NEXT:    fmul.s %s0, %s0, %s34
  %2 = fmul float %0, 5.000000e+00
  ret float %2
}

define double @func24(double) {
; CHECK-LABEL: func24:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s34, 1075052544
; CHECK-NEXT:    fmul.d %s0, %s0, %s34
  %2 = fmul double %0, 5.000000e+00
  ret double %2
}

define i32 @func25(i32) {
; CHECK-LABEL: func25:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s0, %s0, 31
  %2 = shl i32 %0, 31
  ret i32 %2
}

define i64 @func26(i64) {
; CHECK-LABEL: func26:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sll %s0, %s0, 31
  %2 = shl nsw i64 %0, 31
  ret i64 %2
}

define i128 @func27(i128) {
; CHECK-LABEL: func27:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    srl %s34, %s0, 33
; CHECK-NEXT:    sll %s35, %s1, 31
; CHECK-NEXT:    or %s1, %s35, %s34
; CHECK-NEXT:    sll %s0, %s0, 31
  %2 = shl nsw i128 %0, 31
  ret i128 %2
}
