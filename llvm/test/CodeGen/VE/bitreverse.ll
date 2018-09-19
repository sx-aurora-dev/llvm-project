; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define i64 @func1(i64) {
; CHECK-LABEL: func1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    brv %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i64 @llvm.bitreverse.i64(i64 %0)
  ret i64 %2
}

declare i64 @llvm.bitreverse.i64(i64)

define i32 @func2(i32) {
; CHECK-LABEL: func2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    brv %s34, %s0
; CHECK-NEXT:    srl %s0, %s34, 32
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i32 @llvm.bitreverse.i32(i32 %0)
  ret i32 %2
}

declare i32 @llvm.bitreverse.i32(i32)

define signext i16 @func3(i16 signext) {
; CHECK-LABEL: func3:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    brv %s34, %s0
; CHECK-NEXT:    srl %s34, %s34, 32
; CHECK-NEXT:    sra.w.sx %s0, %s34, 16
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i16 @llvm.bitreverse.i16(i16 %0)
  ret i16 %2
}

declare i16 @llvm.bitreverse.i16(i16)

define signext i8 @func4(i8 signext) {
; CHECK-LABEL: func4:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    brv %s34, %s0
; CHECK-NEXT:    srl %s34, %s34, 32
; CHECK-NEXT:    sra.w.sx %s0, %s34, 24
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i8 @llvm.bitreverse.i8(i8 %0)
  ret i8 %2
}

declare i8 @llvm.bitreverse.i8(i8)

define i64 @func5(i64) {
; CHECK-LABEL: func5:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    brv %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i64 @llvm.bitreverse.i64(i64 %0)
  ret i64 %2
}

define i32 @func6(i32) {
; CHECK-LABEL: func6:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    brv %s34, %s0
; CHECK-NEXT:    srl %s0, %s34, 32
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
  %2 = tail call i32 @llvm.bitreverse.i32(i32 %0)
  ret i32 %2
}

define zeroext i16 @func7(i16 zeroext) {
; CHECK-LABEL: func7:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    brv %s34, %s0
; CHECK-NEXT:    srl %s34, %s34, 32
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    srl %s0, %s34, 16
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i16 @llvm.bitreverse.i16(i16 %0)
  ret i16 %2
}

define zeroext i8 @func8(i8 zeroext) {
; CHECK-LABEL: func8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    brv %s34, %s0
; CHECK-NEXT:    srl %s34, %s34, 32
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    srl %s0, %s34, 24
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = tail call i8 @llvm.bitreverse.i8(i8 %0)
  ret i8 %2
}

