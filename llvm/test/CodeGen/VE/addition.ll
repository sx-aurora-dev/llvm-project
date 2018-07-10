; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define dso_local signext i8 @func1(i8 signext, i8 signext) local_unnamed_addr #0 {
; CHECK-LABEL: func1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s34, %s1, %s0
  %3 = add i8 %1, %0
  ret i8 %3
}

define dso_local signext i16 @func2(i16 signext, i16 signext) local_unnamed_addr #0 {
; CHECK-LABEL: func2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s34, %s1, %s0
  %3 = add i16 %1, %0
  ret i16 %3
}

define dso_local i32 @func3(i32, i32) local_unnamed_addr #0 {
; CHECK-LABEL: func3:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s1, %s0
  %3 = add nsw i32 %1, %0
  ret i32 %3
}

define dso_local i64 @func4(i64, i64) local_unnamed_addr #0 {
; CHECK-LABEL: func4:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.l %s0, %s1, %s0
  %3 = add nsw i64 %1, %0
  ret i64 %3
}

define dso_local zeroext i8 @func5(i8 zeroext, i8 zeroext) local_unnamed_addr #0 {
; CHECK-LABEL: func5:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s34, %s1, %s0
  %3 = add i8 %1, %0
  ret i8 %3
}

define dso_local zeroext i16 @func6(i16 zeroext, i16 zeroext) local_unnamed_addr #0 {
; CHECK-LABEL: func6:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s34, %s1, %s0
  %3 = add i16 %1, %0
  ret i16 %3
}

define dso_local i32 @func7(i32, i32) local_unnamed_addr #0 {
; CHECK-LABEL: func7:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s1, %s0
  %3 = add i32 %1, %0
  ret i32 %3
}

define dso_local i32 @func8(i32, i32) local_unnamed_addr #0 {
; CHECK-LABEL: func8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s1, %s0
  %3 = add i32 %1, %0
  ret i32 %3
}

define dso_local i64 @func9(i64, i64) local_unnamed_addr #0 {
; CHECK-LABEL: func9:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.l %s0, %s1, %s0
  %3 = add i64 %1, %0
  ret i64 %3
}

define dso_local float @func10(float, float) local_unnamed_addr #0 {
; CHECK-LABEL: func10:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fadd.s %s0, %s0, %s1
  %3 = fadd float %0, %1
  ret float %3
}

define dso_local double @func11(double, double) local_unnamed_addr #0 {
; CHECK-LABEL: func11:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fadd.d %s0, %s0, %s1
  %3 = fadd double %0, %1
  ret double %3
}
