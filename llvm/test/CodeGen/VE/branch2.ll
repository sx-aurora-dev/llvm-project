; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define i32 @func1(i32, i32) {
; CHECK-LABEL: func1:
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

declare i32 @ret(i32)

define i32 @func2(i32, i32) {
; CHECK-LABEL: func2:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    brlt.w %s0, %s1, .LBB{{[0-9]+}}_1
  %3 = icmp sge i32 %0, %1
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
; CHECK-NEXT:    brge.w %s0, %s1, .LBB{{[0-9]+}}_1
  %3 = icmp slt i32 %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define i32 @func4(i32, i32) {
; CHECK-LABEL: func4:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    brgt.w %s0, %s1, .LBB{{[0-9]+}}_1
  %3 = icmp sle i32 %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define i32 @func5(i32, i32) {
; CHECK-LABEL: func5:
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

define i32 @func6(i32, i32) {
; CHECK-LABEL: func6:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    cmpu.w %s34, %s1, %s0
; CHECK-NEXT:    brlt.w 0, %s34, .LBB{{[0-9]+}}_1
  %3 = icmp uge i32 %0, %1
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
; CHECK-NEXT:    brge.w 0, %s34, .LBB{{[0-9]+}}_1
  %3 = icmp ult i32 %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define i32 @func8(i32, i32) {
; CHECK-LABEL: func8:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    cmpu.w %s34, %s1, %s0
; CHECK-NEXT:    brgt.w 0, %s34, .LBB{{[0-9]+}}_1
  %3 = icmp ule i32 %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define i32 @func9(i32, i32) {
; CHECK-LABEL: func9:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    brne.w %s0, %s1, .LBB{{[0-9]+}}_1
  %3 = icmp eq i32 %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define i32 @func10(i32, i32) {
; CHECK-LABEL: func10:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    breq.w %s0, %s1, .LBB{{[0-9]+}}_1
  %3 = icmp ne i32 %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define i32 @func11(float, float) {
; CHECK-LABEL: func11:
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

define i32 @func12(float, float) {
; CHECK-LABEL: func12:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    brltnan.s %s0, %s1, .LBB{{[0-9]+}}_1
  %3 = fcmp oge float %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define i32 @func13(float, float) {
; CHECK-LABEL: func13:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    brgenan.s %s0, %s1, .LBB{{[0-9]+}}_1
  %3 = fcmp olt float %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define i32 @func14(float, float) {
; CHECK-LABEL: func14:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    brgtnan.s %s0, %s1, .LBB{{[0-9]+}}_1
  %3 = fcmp ole float %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define i32 @func15(float, float) {
; CHECK-LABEL: func15:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    brnan.s %s0, %s1, .LBB{{[0-9]+}}_1
  %3 = fcmp ord float %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define i32 @func16(float, float) {
; CHECK-LABEL: func16:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    brle.s %s0, %s1, .LBB{{[0-9]+}}_1
  %3 = fcmp ugt float %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define i32 @func17(float, float) {
; CHECK-LABEL: func17:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    brlt.s %s0, %s1, .LBB{{[0-9]+}}_1
  %3 = fcmp uge float %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define i32 @func18(float, float) {
; CHECK-LABEL: func18:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    brge.s %s0, %s1, .LBB{{[0-9]+}}_1
  %3 = fcmp ult float %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define i32 @func19(float, float) {
; CHECK-LABEL: func19:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    brgt.s %s0, %s1, .LBB{{[0-9]+}}_1
  %3 = fcmp ule float %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define i32 @func20(float, float) {
; CHECK-LABEL: func20:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    brnenan.s %s0, %s1, .LBB{{[0-9]+}}_1
  %3 = fcmp oeq float %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define i32 @func21(float, float) {
; CHECK-LABEL: func21:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    breqnan.s %s0, %s1, .LBB{{[0-9]+}}_1
  %3 = fcmp one float %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define i32 @func22(float, float) {
; CHECK-LABEL: func22:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    breq.s %s0, %s1, .LBB{{[0-9]+}}_2
  %3 = fcmp ueq float %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define i32 @func23(float, float) {
; CHECK-LABEL: func23:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    breq.s %s0, %s1, .LBB{{[0-9]+}}_1
  %3 = fcmp une float %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define i32 @func24(float, float) {
; CHECK-LABEL: func24:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    brnan.s %s0, %s1, .LBB{{[0-9]+}}_2
  %3 = fcmp uno float %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define i32 @func25(float, float) {
; CHECK-LABEL: func25:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK-NEXT:    or %s34, 1, (0)1
; CHECK-NEXT:    brne.w %s34, %s0, .LBB{{[0-9]+}}_2
  %3 = fcmp false float %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

define i32 @func26(float, float) {
; CHECK-LABEL: func26:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK-NEXT:    brne.w %s0, %s0, .LBB{{[0-9]+}}_2
  %3 = fcmp true float %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}
