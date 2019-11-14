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

; Function Attrs: norecurse nounwind readnone
define i128 @func5(i128, i128) {
; CHECK-LABEL: func5:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s2, %s2, (0)1
; CHECK-NEXT:    lea %s34, __ashlti3@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __ashlti3@hi(%s34)
; CHECK-NEXT:    bsic %lr, (,%s12)
  %3 = shl i128 %0, %1
  ret i128 %3
}

define zeroext i8 @func6(i8 zeroext, i8 zeroext) {
; CHECK-LABEL: func6:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s34, %s0, %s1
; CHECK-NEXT:    and %s0, %s34, (56)0
  %3 = zext i8 %0 to i32
  %4 = zext i8 %1 to i32
  %5 = shl i32 %3, %4
  %6 = trunc i32 %5 to i8
  ret i8 %6
}

define zeroext i16 @func7(i16 zeroext, i16 zeroext) {
; CHECK-LABEL: func7:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s34, %s0, %s1
; CHECK-NEXT:    and %s0, %s34, (48)0
  %3 = zext i16 %0 to i32
  %4 = zext i16 %1 to i32
  %5 = shl i32 %3, %4
  %6 = trunc i32 %5 to i16
  ret i16 %6
}

define i32 @func8(i32, i32) {
; CHECK-LABEL: func8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s0, %s0, %s1
  %3 = shl i32 %0, %1
  ret i32 %3
}

define i64 @func9(i64, i64) {
; CHECK-LABEL: func9:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s34, %s1, (0)1
; CHECK-NEXT:    sll %s0, %s0, %s34 
  %3 = shl i64 %0, %1
  ret i64 %3
}

; Function Attrs: norecurse nounwind readnone
define i128 @func10(i128, i128) {
; CHECK-LABEL: func10:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s2, %s2, (0)1
; CHECK-NEXT:    lea %s34, __ashlti3@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __ashlti3@hi(%s34)
; CHECK-NEXT:    bsic %lr, (,%s12)
  %3 = shl i128 %0, %1
  ret i128 %3
}

define signext i8 @func11(i8 signext) {
; CHECK-LABEL: func11:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s34, %s0, 5
; CHECK-NEXT:    sla.w.sx %s34, %s34, 24
; CHECK-NEXT:    sra.w.sx %s0, %s34, 24
  %2 = shl i8 %0, 5
  ret i8 %2
}

define signext i16 @func12(i16 signext) {
; CHECK-LABEL: func12:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s34, %s0, 5
; CHECK-NEXT:    sla.w.sx %s34, %s34, 16
; CHECK-NEXT:    sra.w.sx %s0, %s34, 16
  %2 = shl i16 %0, 5
  ret i16 %2
}

define i32 @func13(i32) {
; CHECK-LABEL: func13:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s0, %s0, 5
  %2 = shl i32 %0, 5
  ret i32 %2
}

define i64 @func14(i64) {
; CHECK-LABEL: func14:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sll %s0, %s0, 5
  %2 = shl i64 %0, 5
  ret i64 %2
}

; Function Attrs: norecurse nounwind readnone
define i128 @func15(i128) {
; CHECK-LABEL: func15:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    srl %s34, %s0, 59
; CHECK-NEXT:    sll %s35, %s1, 5
; CHECK-NEXT:    or %s1, %s35, %s34
; CHECK-NEXT:    sll %s0, %s0, 5
  %2 = shl i128 %0, 5
  ret i128 %2
}

define zeroext i8 @func16(i8 zeroext) {
; CHECK-LABEL: func16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s34, %s0, 5
; CHECK-NEXT:    and %s0, %s34, (56)0
  %2 = shl i8 %0, 5
  ret i8 %2
}

define zeroext i16 @func17(i16 zeroext) {
; CHECK-LABEL: func17:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s34, %s0, 5
; CHECK-NEXT:    and %s0, %s34, (48)0
  %2 = shl i16 %0, 5
  ret i16 %2
}

define i32 @func18(i32) {
; CHECK-LABEL: func18:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s0, %s0, 5
  %2 = shl i32 %0, 5
  ret i32 %2
}

define i64 @func19(i64) {
; CHECK-LABEL: func19:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sll %s0, %s0, 5
  %2 = shl i64 %0, 5
  ret i64 %2
}

; Function Attrs: norecurse nounwind readnone
define i128 @func20(i128) {
; CHECK-LABEL: func20:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    srl %s34, %s0, 59
; CHECK-NEXT:    sll %s35, %s1, 5
; CHECK-NEXT:    or %s1, %s35, %s34
; CHECK-NEXT:    sll %s0, %s0, 5
  %2 = shl i128 %0, 5
  ret i128 %2
}
