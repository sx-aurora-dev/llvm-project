; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define i128 @func0(i128) {
; CHECK-LABEL: func0:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmps.l %s35, %s0, %s34
; CHECK-NEXT:    lea %s36, -1(%s0)
; CHECK-NEXT:    xor %s37, -1, %s0
; CHECK-NEXT:    and %s36, %s37, %s36
; CHECK-NEXT:    pcnt %s36, %s36
; CHECK-NEXT:    lea %s37, -1(%s1)
; CHECK-NEXT:    xor %s38, -1, %s1
; CHECK-NEXT:    and %s37, %s38, %s37
; CHECK-NEXT:    pcnt %s37, %s37
; CHECK-NEXT:    lea %s0, 64(%s37)
; CHECK-NEXT:    cmov.l.ne %s0, %s36, %s35
; CHECK-NEXT:    or %s1, 0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i128 @llvm.cttz.i128(i128 %0, i1 true)
  ret i128 %2
}

declare i128 @llvm.cttz.i128(i128, i1)

define i64 @func1(i64) {
; CHECK-LABEL: func1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, -1(%s0)
; CHECK-NEXT:    xor %s35, -1, %s0
; CHECK-NEXT:    and %s34, %s35, %s34
; CHECK-NEXT:    pcnt %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i64 @llvm.cttz.i64(i64 %0, i1 true), !range !2
  ret i64 %2
}

declare i64 @llvm.cttz.i64(i64, i1)

define i32 @func2(i32) {
; CHECK-LABEL: func2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, -1(%s0)
; CHECK-NEXT:    xor %s35, -1, %s0
; CHECK-NEXT:    and %s34, %s35, %s34
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    pcnt %s0, %s34
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i32 @llvm.cttz.i32(i32 %0, i1 true), !range !3
  ret i32 %2
}

declare i32 @llvm.cttz.i32(i32, i1)

define i16 @func3(i16) {
; CHECK-LABEL: func3:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, -1(%s0)
; CHECK-NEXT:    xor %s35, -1, %s0
; CHECK-NEXT:    and %s34, %s35, %s34
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    pcnt %s0, %s34
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i16 @llvm.cttz.i16(i16 %0, i1 true), !range !4
  ret i16 %2
}

declare i16 @llvm.cttz.i16(i16, i1)

define i8 @func4(i8) {
; CHECK-LABEL: func4:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, -1(%s0)
; CHECK-NEXT:    xor %s35, -1, %s0
; CHECK-NEXT:    and %s34, %s35, %s34
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    pcnt %s0, %s34
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i8 @llvm.cttz.i8(i8 %0, i1 true), !range !5
  ret i8 %2
}

declare i8 @llvm.cttz.i8(i8, i1)

!2 = !{i64 0, i64 65}
!3 = !{i32 0, i32 33}
!4 = !{i16 0, i16 17}
!5 = !{i8 0, i8 16}
