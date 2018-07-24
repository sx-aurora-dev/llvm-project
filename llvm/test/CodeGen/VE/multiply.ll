; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define dso_local signext i8 @func1(i8 signext, i8 signext) local_unnamed_addr #0 {
; CHECK-LABEL: func1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s34, %s1, %s0
; CHECK-NEXT:    sla.w.sx %s34, %s34, 24
; CHECK-NEXT:    sra.w.sx %s0, %s34, 24
  %3 = mul i8 %1, %0
  ret i8 %3
}

define dso_local signext i16 @func2(i16 signext, i16 signext) local_unnamed_addr #0 {
; CHECK-LABEL: func2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s34, %s1, %s0
; CHECK-NEXT:    sla.w.sx %s34, %s34, 16
; CHECK-NEXT:    sra.w.sx %s0, %s34, 16
  %3 = mul i16 %1, %0
  ret i16 %3
}

define dso_local i32 @func3(i32, i32) local_unnamed_addr #0 {
; CHECK-LABEL: func3:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s0, %s1, %s0
  %3 = mul nsw i32 %1, %0
  ret i32 %3
}

define dso_local i64 @func4(i64, i64) local_unnamed_addr #0 {
; CHECK-LABEL: func4:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.l %s0, %s1, %s0
  %3 = mul nsw i64 %1, %0
  ret i64 %3
}

define dso_local zeroext i8 @func5(i8 zeroext, i8 zeroext) local_unnamed_addr #0 {
; CHECK-LABEL: func5:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s34, %s1, %s0
; CHECK-NEXT:    and %s0, %s34, (56)0
  %3 = mul i8 %1, %0
  ret i8 %3
}

define dso_local zeroext i16 @func6(i16 zeroext, i16 zeroext) local_unnamed_addr #0 {
; CHECK-LABEL: func6:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s34, %s1, %s0
; CHECK-NEXT:    and %s0, %s34, (48)0
  %3 = mul i16 %1, %0
  ret i16 %3
}

define dso_local i32 @func7(i32, i32) local_unnamed_addr #0 {
; CHECK-LABEL: func7:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s0, %s1, %s0
  %3 = mul i32 %1, %0
  ret i32 %3
}

define dso_local i64 @func8(i64, i64) local_unnamed_addr #0 {
; CHECK-LABEL: func8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.l %s0, %s1, %s0
  %3 = mul i64 %1, %0
  ret i64 %3
}

define dso_local float @func9(float, float) local_unnamed_addr #0 {
; CHECK-LABEL: func9:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fmul.s %s0, %s0, %s1
  %3 = fmul float %0, %1
  ret float %3
}

define dso_local double @func10(double, double) local_unnamed_addr #0 {
; CHECK-LABEL: func10:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fmul.d %s0, %s0, %s1
  %3 = fmul double %0, %1
  ret double %3
}

define dso_local signext i8 @func11(i8 signext) local_unnamed_addr #0 {
; CHECK-LABEL: func11:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s34, 5, %s0
; CHECK-NEXT:    sla.w.sx %s34, %s34, 24
; CHECK-NEXT:    sra.w.sx %s0, %s34, 24
  %2 = mul i8 %0, 5
  ret i8 %2
}

define dso_local signext i16 @func12(i16 signext) local_unnamed_addr #0 {
; CHECK-LABEL: func12:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s34, 5, %s0
; CHECK-NEXT:    sla.w.sx %s34, %s34, 16
; CHECK-NEXT:    sra.w.sx %s0, %s34, 16
  %2 = mul i16 %0, 5
  ret i16 %2
}

define dso_local i32 @func13(i32) local_unnamed_addr #0 {
; CHECK-LABEL: func13:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s0, 5, %s0
  %2 = mul nsw i32 %0, 5
  ret i32 %2
}

define dso_local i64 @func14(i64) local_unnamed_addr #0 {
; CHECK-LABEL: func14:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.l %s0, 5, %s0
  %2 = mul nsw i64 %0, 5
  ret i64 %2
}

define dso_local zeroext i8 @func15(i8 zeroext) local_unnamed_addr #0 {
; CHECK-LABEL: func15:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s34, 5, %s0
; CHECK-NEXT:    and %s0, %s34, (56)0
  %2 = mul i8 %0, 5
  ret i8 %2
}

define dso_local zeroext i16 @func16(i16 zeroext) local_unnamed_addr #0 {
; CHECK-LABEL: func16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s34, 5, %s0
; CHECK-NEXT:    and %s0, %s34, (48)0
  %2 = mul i16 %0, 5
  ret i16 %2
}

define dso_local i32 @func17(i32) local_unnamed_addr #0 {
; CHECK-LABEL: func17:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.w.sx %s0, 5, %s0
  %2 = mul i32 %0, 5
  ret i32 %2
}

define dso_local i64 @func18(i64) local_unnamed_addr #0 {
; CHECK-LABEL: func18:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    muls.l %s0, 5, %s0
  %2 = mul i64 %0, 5
  ret i64 %2
}

define dso_local float @func19(float) local_unnamed_addr #0 {
; CHECK-LABEL: func19:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s34, %hi(.LCPI18_0)
; CHECK-NEXT:    ldu %s34, %lo(.LCPI18_0)(,%s34)
; CHECK-NEXT:    fmul.s %s0, %s0, %s34
  %2 = fmul float %0, 5.000000e+00
  ret float %2
}

define dso_local double @func20(double) local_unnamed_addr #0 {
; CHECK-LABEL: func20:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s34, %hi(.LCPI19_0)
; CHECK-NEXT:    ld %s34, %lo(.LCPI19_0)(,%s34)
; CHECK-NEXT:    fmul.d %s0, %s0, %s34
  %2 = fmul double %0, 5.000000e+00
  ret double %2
}

define dso_local i32 @func21(i32) local_unnamed_addr #0 {
; CHECK-LABEL: func21:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s0, %s0, 31
  %2 = shl i32 %0, 31
  ret i32 %2
}

define dso_local i64 @func22(i64) local_unnamed_addr #0 {
; CHECK-LABEL: func22:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sll %s0, %s0, 31
  %2 = shl nsw i64 %0, 31
  ret i64 %2
}
