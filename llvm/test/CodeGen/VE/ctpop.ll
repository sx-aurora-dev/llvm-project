; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define i128 @func0(i128) {
; CHECK-LABEL: func0:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    pcnt %s34, %s1
; CHECK-NEXT:    pcnt %s35, %s0
; CHECK-NEXT:    adds.l %s0, %s35, %s34
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i128 @llvm.ctpop.i128(i128 %0)
  ret i128 %2
}

declare i128 @llvm.ctpop.i128(i128)

define i64 @func1(i64) {
; CHECK-LABEL: func1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    pcnt %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i64 @llvm.ctpop.i64(i64 %0), !range !2
  ret i64 %2
}

declare i64 @llvm.ctpop.i64(i64)

define i32 @func2(i32) {
; CHECK-LABEL: func2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    and %s34, %s0, (32)0
; CHECK-NEXT:    pcnt %s0, %s34
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i32 @llvm.ctpop.i32(i32 %0), !range !3
  ret i32 %2
}

declare i32 @llvm.ctpop.i32(i32)

define i16 @func3(i16) {
; CHECK-LABEL: func3:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s34, %s0, (48)0
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    pcnt %s0, %s34
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i16 @llvm.ctpop.i16(i16 %0), !range !4
  ret i16 %2
}

declare i16 @llvm.ctpop.i16(i16)

define i8 @func4(i8) {
; CHECK-LABEL: func4:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s34, %s0, (56)0
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    pcnt %s0, %s34
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i8 @llvm.ctpop.i8(i8 %0), !range !5
  ret i8 %2
}

declare i8 @llvm.ctpop.i8(i8)

!2 = !{i64 0, i64 65}
!3 = !{i32 0, i32 33}
!4 = !{i16 0, i16 17}
!5 = !{i8 0, i8 9}
