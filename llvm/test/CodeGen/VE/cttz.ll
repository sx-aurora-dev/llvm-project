; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define i128 @func0(i128 %p) {
; CHECK-LABEL: func0:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, -1(, %s0)
; CHECK-NEXT:    nnd %s2, %s0, %s2
; CHECK-NEXT:    pcnt %s3, %s2
; CHECK-NEXT:    lea %s2, -1(, %s1)
; CHECK-NEXT:    nnd %s1, %s1, %s2
; CHECK-NEXT:    pcnt %s1, %s1
; CHECK-NEXT:    lea %s2, 64(, %s1)
; CHECK-NEXT:    cmov.l.ne %s2, %s3, %s0
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i128 @llvm.cttz.i128(i128 %p, i1 true)
  ret i128 %r
}

declare i128 @llvm.cttz.i128(i128, i1)

define i64 @func1(i64 %p) {
; CHECK-LABEL: func1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, -1(, %s0)
; CHECK-NEXT:    nnd %s0, %s0, %s1
; CHECK-NEXT:    pcnt %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i64 @llvm.cttz.i64(i64 %p, i1 true)
  ret i64 %r
}

declare i64 @llvm.cttz.i64(i64, i1)

define i32 @func2(i32 %p) {
; CHECK-LABEL: func2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s1, -1, %s0
; CHECK-NEXT:    xor %s0, -1, %s0
; CHECK-NEXT:    and %s0, %s0, %s1
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    pcnt %s0, %s0
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i32 @llvm.cttz.i32(i32 %p, i1 true)
  ret i32 %r
}

declare i32 @llvm.cttz.i32(i32, i1)

define i16 @func3(i16 %p) {
; CHECK-LABEL: func3:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s1, -1, %s0
; CHECK-NEXT:    xor %s0, -1, %s0
; CHECK-NEXT:    and %s0, %s0, %s1
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    pcnt %s0, %s0
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i16 @llvm.cttz.i16(i16 %p, i1 true)
  ret i16 %r
}

declare i16 @llvm.cttz.i16(i16, i1)

define i8 @func4(i8 %p) {
; CHECK-LABEL: func4:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s1, -1, %s0
; CHECK-NEXT:    xor %s0, -1, %s0
; CHECK-NEXT:    and %s0, %s0, %s1
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    pcnt %s0, %s0
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i8 @llvm.cttz.i8(i8 %p, i1 true)
  ret i8 %r
}

declare i8 @llvm.cttz.i8(i8, i1)
