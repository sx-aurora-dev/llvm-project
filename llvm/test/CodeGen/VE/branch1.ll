; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define signext i8 @func1(i8 signext, i8 signext) {
; CHECK-LABEL: func1:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    brle.w %s0, %s1, .LBB{{[0-9]+}}_1
  %3 = icmp sgt i8 %0, %1
  br i1 %3, label %4, label %7

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  %6 = trunc i32 %5 to i8
  br label %7

; <label>:7:                                      ; preds = %2, %4
  %8 = phi i8 [ %6, %4 ], [ 0, %2 ]
  ret i8 %8
}

declare i32 @ret(i32)

define i32 @func2(i16 signext, i16 signext) {
; CHECK-LABEL: func2:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    brle.w %s0, %s1, .LBB{{[0-9]+}}_1
  %3 = icmp sgt i16 %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define i32 @func3(i32, i32) {
; CHECK-LABEL: func3:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    brle.w %s0, %s1, .LBB{{[0-9]+}}_1
  %3 = icmp sgt i32 %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define i32 @func4(i64, i64) {
; CHECK-LABEL: func4:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    brle.l %s0, %s1, .LBB{{[0-9]+}}_1
  %3 = icmp sgt i64 %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define i32 @func5(i8 zeroext, i8 zeroext) {
; CHECK-LABEL: func5:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    cmpu.w %s34, %s1, %s0
; CHECK-NEXT:    brle.w 0, %s34, .LBB{{[0-9]+}}_1
  %3 = icmp ugt i8 %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define i32 @func6(i16 zeroext, i16 zeroext) {
; CHECK-LABEL: func6:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    cmpu.w %s34, %s1, %s0
; CHECK-NEXT:    brle.w 0, %s34, .LBB{{[0-9]+}}_1
  %3 = icmp ugt i16 %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define i32 @func7(i32, i32) {
; CHECK-LABEL: func7:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    cmpu.w %s34, %s1, %s0
; CHECK-NEXT:    brle.w 0, %s34, .LBB{{[0-9]+}}_1
  %3 = icmp ugt i32 %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define i32 @func8(float, float) {
; CHECK-LABEL: func8:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    brlenan.s %s0, %s1, .LBB{{[0-9]+}}_1
  %3 = fcmp ogt float %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define i32 @func9(double, double) {
; CHECK-LABEL: func9:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    brlenan.d %s0, %s1, .LBB{{[0-9]+}}_1
  %3 = fcmp ogt double %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define i32 @func10(double, double) {
; CHECK-LABEL: func10:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    lea.sl %s34, 1075052544
; CHECK-NEXT:    brlenan.d %s0, %s34, .LBB{{[0-9]+}}_1
  %3 = fcmp ogt double %0, 5.000000e+00
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define i32 @func11(fp128, fp128) {
; CHECK-LABEL:  func11:
; CHECK:        .LBB{{[0-9]+}}_5:
; CHECK-NEXT:   fcmp.q %s34, %s2, %s0
; CHECK-NEXT:   brlenan.d 0, %s34, .LBB{{[0-9]+}}_1
  %3 = fcmp ogt fp128 %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}


; Function Attrs: nounwind
define i32 @func12(i128, i128) {
; CHECK-LABEL: func12:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmps.l %s35, %s1, %s3
; CHECK-NEXT:    or %s36, 0, %s34
; CHECK-NEXT:    cmov.l.le %s36, (63)0, %s35
; CHECK-NEXT:    cmpu.l %s37, %s0, %s2
; CHECK-NEXT:    cmov.l.le %s34, (63)0, %s37
; CHECK-NEXT:    cmov.l.eq %s36, %s34, %s35
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK-NEXT:    brne.w %s36, %s0, .LBB{{[0-9]+}}_2
  %3 = icmp sgt i128 %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

; Function Attrs: nounwind
define i32 @func13(i128, i128) {
; CHECK-LABEL: func13:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:    cmps.l %s34, %s1, %s3
; CHECK-NEXT:    or %s35, 0, (0)1
; CHECK-NEXT:    cmpu.l %s36, %s1, %s3
; CHECK-NEXT:    or %s37, 0, %s35
; CHECK-NEXT:    cmov.l.le %s37, (63)0, %s36
; CHECK-NEXT:    cmpu.l %s36, %s0, %s2
; CHECK-NEXT:    cmov.l.le %s35, (63)0, %s36
; CHECK-NEXT:    cmov.l.eq %s37, %s35, %s34
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK-NEXT:    brne.w %s37, %s0, .LBB{{[0-9]+}}_2
  %3 = icmp ugt i128 %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}
