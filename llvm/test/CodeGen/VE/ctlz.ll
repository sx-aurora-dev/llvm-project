; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define i64 @func1(i64) {
; CHECK-LABEL: func1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i64 @llvm.ctlz.i64(i64 %0, i1 true), !range !2
  ret i64 %2
}

declare i64 @llvm.ctlz.i64(i64, i1)

define i32 @func2(i32) {
; CHECK-LABEL: func2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    sll %s34, %s0, 32
; CHECK-NEXT:    ldz %s0, %s34
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i32 @llvm.ctlz.i32(i32 %0, i1 true), !range !3
  ret i32 %2
}

declare i32 @llvm.ctlz.i32(i32, i1)

define i16 @func3(i16) {
; CHECK-LABEL: func3:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s34, %s0, (48)0
; CHECK-NEXT:    sll %s34, %s34, 32
; CHECK-NEXT:    ldz %s34, %s34
; CHECK-NEXT:    lea %s0, -16(%s34)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i16 @llvm.ctlz.i16(i16 %0, i1 true), !range !4
  ret i16 %2
}

declare i16 @llvm.ctlz.i16(i16, i1)

define i8 @func4(i8) {
; CHECK-LABEL: func4:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s34, %s0, (56)0
; CHECK-NEXT:    sll %s34, %s34, 32
; CHECK-NEXT:    ldz %s34, %s34
; CHECK-NEXT:    lea %s0, -24(%s34)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i8 @llvm.ctlz.i8(i8 %0, i1 true), !range !5
  ret i8 %2
}

declare i8 @llvm.ctlz.i8(i8, i1)

!2 = !{i64 0, i64 65}
!3 = !{i32 0, i32 33}
!4 = !{i16 0, i16 17}
!5 = !{i8 0, i8 9}
