; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define dso_local signext i8 @func1(i8 signext, i8 signext) local_unnamed_addr #0 {
; CHECK-LABEL: func1:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    brle.w %s0, %s1, .LBB{{[0-9]+}}_1
  %3 = icmp sgt i8 %0, %1
  br i1 %3, label %4, label %7

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2) #2
  %6 = trunc i32 %5 to i8
  br label %7

; <label>:7:                                      ; preds = %2, %4
  %8 = phi i8 [ %6, %4 ], [ 0, %2 ]
  ret i8 %8
}

declare dso_local i32 @ret(i32) local_unnamed_addr #1

define dso_local i32 @func2(i16 signext, i16 signext) local_unnamed_addr #0 {
; CHECK-LABEL: func2:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    brle.w %s0, %s1, .LBB{{[0-9]+}}_1
  %3 = icmp sgt i16 %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2) #2
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define dso_local i32 @func3(i32, i32) local_unnamed_addr #0 {
; CHECK-LABEL: func3:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    brle.w %s0, %s1, .LBB{{[0-9]+}}_1
  %3 = icmp sgt i32 %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2) #2
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define dso_local i32 @func4(i64, i64) local_unnamed_addr #0 {
; CHECK-LABEL: func4:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    brle.l %s0, %s1, .LBB{{[0-9]+}}_1
  %3 = icmp sgt i64 %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2) #2
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define dso_local i32 @func5(i8 zeroext, i8 zeroext) local_unnamed_addr #0 {
; CHECK-LABEL: func5:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    cmpu.w %s34, %s1, %s0
; CHECK-NEXT:    brle.w 0, %s34, .LBB{{[0-9]+}}_1
  %3 = icmp ugt i8 %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2) #2
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define dso_local i32 @func6(i16 zeroext, i16 zeroext) local_unnamed_addr #0 {
; CHECK-LABEL: func6:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    cmpu.w %s34, %s1, %s0
; CHECK-NEXT:    brle.w 0, %s34, .LBB{{[0-9]+}}_1
  %3 = icmp ugt i16 %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2) #2
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define dso_local i32 @func7(i32, i32) local_unnamed_addr #0 {
; CHECK-LABEL: func7:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    cmpu.w %s34, %s1, %s0
; CHECK-NEXT:    brle.w 0, %s34, .LBB{{[0-9]+}}_1
  %3 = icmp ugt i32 %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2) #2
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define dso_local i32 @func8(float, float) local_unnamed_addr #0 {
; CHECK-LABEL: func8:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    brlenan.s %s0, %s1, .LBB{{[0-9]+}}_1
  %3 = fcmp ogt float %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2) #2
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define dso_local i32 @func9(double, double) local_unnamed_addr #0 {
; CHECK-LABEL: func9:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    brlenan.d %s0, %s1, .LBB{{[0-9]+}}_1
  %3 = fcmp ogt double %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2) #2
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define dso_local i32 @func10(double, double) local_unnamed_addr #0 {
; CHECK-LABEL: func10:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    lea.sl %s34, %hi(.LCPI{{[0-9]+}}_0)
; CHECK-NEXT:    ld %s34, %lo(.LCPI{{[0-9]+}}_0)(,%s34)
; CHECK-NEXT:    brlenan.d %s0, %s34, .LBB{{[0-9]+}}_1
  %3 = fcmp ogt double %0, 5.000000e+00
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2) #2
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}
