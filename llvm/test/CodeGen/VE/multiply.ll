; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define signext i8 @func1(i8 signext %a, i8 signext %b) {
; CHECK-LABEL: func1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s0, %s1, %s0
; CHECK-NEXT:    sla.w.sx %s0, %s0, 24
; CHECK-NEXT:    sra.w.sx %s0, %s0, 24
; CHECK-NEXT:    or %s11, 0, %s9
  %r = mul i8 %b, %a
  ret i8 %r
}

define signext i16 @func2(i16 signext %a, i16 signext %b) {
; CHECK-LABEL: func2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s0, %s1, %s0
; CHECK-NEXT:    sla.w.sx %s0, %s0, 16
; CHECK-NEXT:    sra.w.sx %s0, %s0, 16
; CHECK-NEXT:    or %s11, 0, %s9
  %r = mul i16 %b, %a
  ret i16 %r
}

define i32 @func3(i32 %a, i32 %b) {
; CHECK-LABEL: func3:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s0, %s1, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = mul nsw i32 %b, %a
  ret i32 %r
}

define i64 @func4(i64 %a, i64 %b) {
; CHECK-LABEL: func4:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.l %s0, %s1, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = mul nsw i64 %b, %a
  ret i64 %r
}

define i128 @func5(i128 %a, i128 %b) {
; CHECK-LABEL: func5:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s4, 0, %s1
; CHECK-NEXT:    or %s5, 0, %s0
; CHECK-NEXT:    lea %s0, __multi3@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __multi3@hi(, %s0)
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    or %s1, 0, %s3
; CHECK-NEXT:    or %s2, 0, %s5
; CHECK-NEXT:    or %s3, 0, %s4
; CHECK-NEXT:    bsic %s10, (, %s12)
  %r = mul nsw i128 %b, %a
  ret i128 %r
}

define zeroext i8 @func6(i8 zeroext %a, i8 zeroext %b) {
; CHECK-LABEL: func6:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s0, %s1, %s0
; CHECK-NEXT:    and %s0, %s0, (56)0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = mul i8 %b, %a
  ret i8 %r
}

define zeroext i16 @func7(i16 zeroext %a, i16 zeroext %b) {
; CHECK-LABEL: func7:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s0, %s1, %s0
; CHECK-NEXT:    and %s0, %s0, (48)0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = mul i16 %b, %a
  ret i16 %r
}

define i32 @func8(i32 %a, i32 %b) {
; CHECK-LABEL: func8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s0, %s1, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = mul i32 %b, %a
  ret i32 %r
}

define i64 @func9(i64 %a, i64 %b) {
; CHECK-LABEL: func9:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.l %s0, %s1, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = mul i64 %b, %a
  ret i64 %r
}

define i128 @func10(i128 %a, i128 %b) {
; CHECK-LABEL: func10:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s4, 0, %s1
; CHECK-NEXT:    or %s5, 0, %s0
; CHECK-NEXT:    lea %s0, __multi3@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __multi3@hi(, %s0)
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    or %s1, 0, %s3
; CHECK-NEXT:    or %s2, 0, %s5
; CHECK-NEXT:    or %s3, 0, %s4
; CHECK-NEXT:    bsic %s10, (, %s12)
  %r = mul i128 %b, %a
  ret i128 %r
}

define float @func11(float %a, float %b) {
; CHECK-LABEL: func11:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fmul.s %s0, %s0, %s1
  %r = fmul float %a, %b
  ret float %r
}

define double @func12(double %a, double %b) {
; CHECK-LABEL: func12:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fmul.d %s0, %s0, %s1
  %r = fmul double %a, %b
  ret double %r
}

define signext i8 @func13(i8 signext %a) {
; CHECK-LABEL: func13:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s0, 5, %s0
; CHECK-NEXT:    sla.w.sx %s0, %s0, 24
; CHECK-NEXT:    sra.w.sx %s0, %s0, 24
; CHECK-NEXT:    or %s11, 0, %s9
  %r = mul i8 %a, 5
  ret i8 %r
}

define signext i16 @func14(i16 signext %a) {
; CHECK-LABEL: func14:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s0, 5, %s0
; CHECK-NEXT:    sla.w.sx %s0, %s0, 16
; CHECK-NEXT:    sra.w.sx %s0, %s0, 16
; CHECK-NEXT:    or %s11, 0, %s9
  %r = mul i16 %a, 5
  ret i16 %r
}

define i32 @func15(i32 %a) {
; CHECK-LABEL: func15:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s0, 5, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = mul nsw i32 %a, 5
  ret i32 %r
}

define i64 @func16(i64 %a) {
; CHECK-LABEL: func16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.l %s0, 5, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = mul nsw i64 %a, 5
  ret i64 %r
}

define i128 @func17(i128 %a) {
; CHECK-LABEL: func17:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, __multi3@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, __multi3@hi(, %s2)
; CHECK-NEXT:    or %s2, 5, (0)1
; CHECK-NEXT:    or %s3, 0, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
  %r = mul nsw i128 %a, 5
  ret i128 %r
}

define zeroext i8 @func18(i8 zeroext %a) {
; CHECK-LABEL: func18:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s0, 5, %s0
; CHECK-NEXT:    and %s0, %s0, (56)0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = mul i8 %a, 5
  ret i8 %r
}

define zeroext i16 @func19(i16 zeroext %a) {
; CHECK-LABEL: func19:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s0, 5, %s0
; CHECK-NEXT:    and %s0, %s0, (48)0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = mul i16 %a, 5
  ret i16 %r
}

define i32 @func20(i32 %a) {
; CHECK-LABEL: func20:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s0, 5, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = mul i32 %a, 5
  ret i32 %r
}

define i64 @func21(i64 %a) {
; CHECK-LABEL: func21:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.l %s0, 5, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = mul i64 %a, 5
  ret i64 %r
}

define i128 @func22(i128 %a) {
; CHECK-LABEL: func22:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, __multi3@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, __multi3@hi(, %s2)
; CHECK-NEXT:    or %s2, 5, (0)1
; CHECK-NEXT:    or %s3, 0, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
  %r = mul i128 %a, 5
  ret i128 %r
}

define float @func23(float %a) {
; CHECK-LABEL: func23:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s1, 1084227584
; CHECK-NEXT:    or %s1, 0, %s1
; CHECK-NEXT:    fmul.s %s0, %s0, %s1
  %r = fmul float %a, 5.000000e+00
  ret float %r
}

define double @func24(double %a) {
; CHECK-LABEL: func24:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s1, 1075052544
; CHECK-NEXT:    fmul.d %s0, %s0, %s1
  %r = fmul double %a, 5.000000e+00
  ret double %r
}

define i32 @func25(i32 %a) {
; CHECK-LABEL: func25:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s0, %s0, 31
; CHECK-NEXT:    or %s11, 0, %s9
  %r = shl i32 %a, 31
  ret i32 %r
}

define i64 @func26(i64 %a) {
; CHECK-LABEL: func26:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sll %s0, %s0, 31
; CHECK-NEXT:    or %s11, 0, %s9
  %r = shl nsw i64 %a, 31
  ret i64 %r
}

define i128 @func27(i128 %a) {
; CHECK-LABEL: func27:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    srl %s2, %s0, 33
; CHECK-NEXT:    sll %s1, %s1, 31
; CHECK-NEXT:    or %s1, %s1, %s2
; CHECK-NEXT:    sll %s0, %s0, 31
  %r = shl nsw i128 %a, 31
  ret i128 %r
}
