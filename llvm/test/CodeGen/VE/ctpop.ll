; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define i128 @func0(i128 %p) {
; CHECK-LABEL: func0:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    pcnt %s1, %s1
; CHECK-NEXT:    pcnt %s0, %s0
; CHECK-NEXT:    adds.l %s0, %s0, %s1
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i128 @llvm.ctpop.i128(i128 %p)
  ret i128 %r
}

declare i128 @llvm.ctpop.i128(i128)

define i64 @func1(i64 %p) {
; CHECK-LABEL: func1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    pcnt %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i64 @llvm.ctpop.i64(i64 %p)
  ret i64 %r
}

declare i64 @llvm.ctpop.i64(i64)

define i32 @func2(i32 %p) {
; CHECK-LABEL: func2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    pcnt %s0, %s0
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i32 @llvm.ctpop.i32(i32 %p)
  ret i32 %r
}

declare i32 @llvm.ctpop.i32(i32)

define i16 @func3(i16 %p) {
; CHECK-LABEL: func3:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (48)0
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    pcnt %s0, %s0
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i16 @llvm.ctpop.i16(i16 %p)
  ret i16 %r
}

declare i16 @llvm.ctpop.i16(i16)

define i8 @func4(i8 %p) {
; CHECK-LABEL: func4:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (56)0
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    pcnt %s0, %s0
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i8 @llvm.ctpop.i8(i8 %p)
  ret i8 %r
}

declare i8 @llvm.ctpop.i8(i8)
