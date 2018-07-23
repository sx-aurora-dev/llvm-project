; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define dso_local signext i8 @func1(i8 signext, i8 signext) local_unnamed_addr #0 {
; CHECK-LABEL: func1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    subs.w.sx %s34, %s0, %s1
  %3 = sub i8 %0, %1
  ret i8 %3
}

define dso_local signext i16 @func2(i16 signext, i16 signext) local_unnamed_addr #0 {
; CHECK-LABEL: func2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    subs.w.sx %s34, %s0, %s1
  %3 = sub i16 %0, %1
  ret i16 %3
}

define dso_local i32 @func3(i32, i32) local_unnamed_addr #0 {
; CHECK-LABEL: func3:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    subs.w.sx %s0, %s0, %s1
  %3 = sub nsw i32 %0, %1
  ret i32 %3
}

define dso_local i64 @func4(i64, i64) local_unnamed_addr #0 {
; CHECK-LABEL: func4:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    subs.l %s0, %s0, %s1
  %3 = sub nsw i64 %0, %1
  ret i64 %3
}

define dso_local zeroext i8 @func5(i8 zeroext, i8 zeroext) local_unnamed_addr #0 {
; CHECK-LABEL: func5:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    subs.w.sx %s34, %s0, %s1
  %3 = sub i8 %0, %1
  ret i8 %3
}

define dso_local zeroext i16 @func6(i16 zeroext, i16 zeroext) local_unnamed_addr #0 {
; CHECK-LABEL: func6:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    subs.w.sx %s34, %s0, %s1
  %3 = sub i16 %0, %1
  ret i16 %3
}

define dso_local i32 @func7(i32, i32) local_unnamed_addr #0 {
; CHECK-LABEL: func7:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    subs.w.sx %s0, %s0, %s1
  %3 = sub i32 %0, %1
  ret i32 %3
}

define dso_local i64 @func8(i64, i64) local_unnamed_addr #0 {
; CHECK-LABEL: func8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    subs.l %s0, %s0, %s1
  %3 = sub i64 %0, %1
  ret i64 %3
}

define dso_local float @func9(float, float) local_unnamed_addr #0 {
; CHECK-LABEL: func9:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fsub.s %s0, %s0, %s1
  %3 = fsub float %0, %1
  ret float %3
}

define dso_local double @func10(double, double) local_unnamed_addr #0 {
; CHECK-LABEL: func10:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fsub.d %s0, %s0, %s1
  %3 = fsub double %0, %1
  ret double %3
}

define dso_local signext i8 @func11(i8 signext, i8 signext) local_unnamed_addr #0 {
; CHECK-LABEL: func11:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, -5(%s0)
; CHECK-NEXT:    sla.w.sx %s34, %s34, 24
; CHECK-NEXT:    sra.w.sx %s0, %s34, 24
  %3 = add i8 %0, -5
  ret i8 %3
}

define dso_local signext i16 @func12(i16 signext, i16 signext) local_unnamed_addr #0 {
; CHECK-LABEL: func12:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, -5(%s0)
; CHECK-NEXT:    sla.w.sx %s34, %s34, 16
; CHECK-NEXT:    sra.w.sx %s0, %s34, 16
  %3 = add i16 %0, -5
  ret i16 %3
}

define dso_local i32 @func13(i32, i32) local_unnamed_addr #0 {
; CHECK-LABEL: func13:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, -5(%s0)
  %3 = add nsw i32 %0, -5
  ret i32 %3
}

define dso_local i64 @func14(i64, i64) local_unnamed_addr #0 {
; CHECK-LABEL: func14:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, -5(%s0)
  %3 = add nsw i64 %0, -5
  ret i64 %3
}

define dso_local zeroext i8 @func15(i8 zeroext, i8 zeroext) local_unnamed_addr #0 {
; CHECK-LABEL: func15:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, -5(%s0)
; CHECK-NEXT:    and %s0, %s34, (56)0
  %3 = add i8 %0, -5
  ret i8 %3
}

define dso_local zeroext i16 @func16(i16 zeroext, i16 zeroext) local_unnamed_addr #0 {
; CHECK-LABEL: func16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, -5(%s0)
; CHECK-NEXT:    and %s0, %s34, (48)0
  %3 = add i16 %0, -5
  ret i16 %3
}

define dso_local i32 @func17(i32, i32) local_unnamed_addr #0 {
; CHECK-LABEL: func17:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, -5(%s0)
  %3 = add i32 %0, -5
  ret i32 %3
}

define dso_local i64 @func18(i64, i64) local_unnamed_addr #0 {
; CHECK-LABEL: func18:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, -5(%s0)
  %3 = add i64 %0, -5
  ret i64 %3
}

define dso_local float @func19(float, float) local_unnamed_addr #0 {
; CHECK-LABEL: func19:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s34, %hi(.LCPI18_0)
; CHECK-NEXT:    ldu %s34, %lo(.LCPI18_0)(,%s34)
; CHECK-NEXT:    fadd.s %s0, %s0, %s34
  %3 = fadd float %0, -5.000000e+00
  ret float %3
}

define dso_local double @func20(double, double) local_unnamed_addr #0 {
; CHECK-LABEL: func20:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s34, %hi(.LCPI19_0)
; CHECK-NEXT:    ld %s34, %lo(.LCPI19_0)(,%s34)
; CHECK-NEXT:    fadd.d %s0, %s0, %s34
  %3 = fadd double %0, -5.000000e+00
  ret double %3
}

define dso_local i32 @func21(i32, i32) local_unnamed_addr #0 {
; CHECK-LABEL: func21:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, -2147483648
; CHECK-NEXT:    xor %s0, %s0, %s34
  %3 = xor i32 %0, -2147483648
  ret i32 %3
}

define dso_local i64 @func22(i64, i64) local_unnamed_addr #0 {
; CHECK-LABEL: func22:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, -2147483648(%s0)
  %3 = add nsw i64 %0, -2147483648
  ret i64 %3
}
