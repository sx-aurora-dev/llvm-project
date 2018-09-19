; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define signext i8 @func1(i8 signext, i8 signext) {
; CHECK-LABEL: func1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s34, %s0, %s1
; CHECK-NEXT:    sla.w.sx %s34, %s34, 24
; CHECK-NEXT:    sra.w.sx %s0, %s34, 24
  %3 = sext i8 %0 to i32
  %4 = sext i8 %1 to i32
  %5 = shl i32 %3, %4
  %6 = trunc i32 %5 to i8
  ret i8 %6
}

define signext i16 @func2(i16 signext, i16 signext) {
; CHECK-LABEL: func2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s34, %s0, %s1
; CHECK-NEXT:    sla.w.sx %s34, %s34, 16
; CHECK-NEXT:    sra.w.sx %s0, %s34, 16
  %3 = sext i16 %0 to i32
  %4 = sext i16 %1 to i32
  %5 = shl i32 %3, %4
  %6 = trunc i32 %5 to i16
  ret i16 %6
}

define i32 @func3(i32, i32) {
; CHECK-LABEL: func3:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s0, %s0, %s1
  %3 = shl i32 %0, %1
  ret i32 %3
}

define i64 @func4(i64, i64) {
; CHECK-LABEL: func4:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s34, %s1, (0)1
; CHECK-NEXT:    sll %s0, %s0, %s34
  %3 = shl i64 %0, %1
  ret i64 %3
}

define zeroext i8 @func5(i8 zeroext, i8 zeroext) {
; CHECK-LABEL: func5:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s34, %s0, %s1
; CHECK-NEXT:    and %s0, %s34, (56)0
  %3 = zext i8 %0 to i32
  %4 = zext i8 %1 to i32
  %5 = shl i32 %3, %4
  %6 = trunc i32 %5 to i8
  ret i8 %6
}

define zeroext i16 @func6(i16 zeroext, i16 zeroext) {
; CHECK-LABEL: func6:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s34, %s0, %s1
; CHECK-NEXT:    and %s0, %s34, (48)0
  %3 = zext i16 %0 to i32
  %4 = zext i16 %1 to i32
  %5 = shl i32 %3, %4
  %6 = trunc i32 %5 to i16
  ret i16 %6
}

define i32 @func7(i32, i32) {
; CHECK-LABEL: func7:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s0, %s0, %s1
  %3 = shl i32 %0, %1
  ret i32 %3
}

define i64 @func8(i64, i64) {
; CHECK-LABEL: func8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s34, %s1, (0)1
; CHECK-NEXT:    sll %s0, %s0, %s34 
  %3 = shl i64 %0, %1
  ret i64 %3
}

define signext i8 @func9(i8 signext) {
; CHECK-LABEL: func9:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s34, %s0, 5
; CHECK-NEXT:    sla.w.sx %s34, %s34, 24
; CHECK-NEXT:    sra.w.sx %s0, %s34, 24
  %2 = shl i8 %0, 5
  ret i8 %2
}

define signext i16 @func10(i16 signext) {
; CHECK-LABEL: func10:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s34, %s0, 5
; CHECK-NEXT:    sla.w.sx %s34, %s34, 16
; CHECK-NEXT:    sra.w.sx %s0, %s34, 16
  %2 = shl i16 %0, 5
  ret i16 %2
}

define i32 @func11(i32) {
; CHECK-LABEL: func11:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s0, %s0, 5
  %2 = shl i32 %0, 5
  ret i32 %2
}

define i64 @func12(i64) {
; CHECK-LABEL: func12:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sll %s0, %s0, 5
  %2 = shl i64 %0, 5
  ret i64 %2
}

define zeroext i8 @func13(i8 zeroext) {
; CHECK-LABEL: func13:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s34, %s0, 5
; CHECK-NEXT:    and %s0, %s34, (56)0
  %2 = shl i8 %0, 5
  ret i8 %2
}

define zeroext i16 @func14(i16 zeroext) {
; CHECK-LABEL: func14:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s34, %s0, 5
; CHECK-NEXT:    and %s0, %s34, (48)0
  %2 = shl i16 %0, 5
  ret i16 %2
}

define i32 @func15(i32) {
; CHECK-LABEL: func15:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s0, %s0, 5
  %2 = shl i32 %0, 5
  ret i32 %2
}

define i64 @func16(i64) {
; CHECK-LABEL: func16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sll %s0, %s0, 5
  %2 = shl i64 %0, 5
  ret i64 %2
}
