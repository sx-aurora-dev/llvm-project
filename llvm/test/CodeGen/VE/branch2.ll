; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define i32 @func1(i32, i32) {
; CHECK-LABEL: func1:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    brle.w %s0, %s1, .LBB0_1
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(%s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    br.l .LBB0_3
; CHECK:       .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK:       .LBB{{[0-9]+}}_3:
; CHECK-NEXT:    or %s11, 0, %s9
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
; CHECK-NEXT:    brlt.w %s0, %s1, .LBB1_1
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(%s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    br.l .LBB1_3
; CHECK:       .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK:       .LBB{{[0-9]+}}_3:
; CHECK-NEXT:    or %s11, 0, %s9
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
; CHECK-NEXT:    brge.w %s0, %s1, .LBB2_1
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(%s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    br.l .LBB2_3
; CHECK:       .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK:       .LBB{{[0-9]+}}_3:
; CHECK-NEXT:    or %s11, 0, %s9
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
; CHECK-NEXT:    brgt.w %s0, %s1, .LBB3_1
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(%s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    br.l .LBB3_3
; CHECK:       .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK:       .LBB{{[0-9]+}}_3:
; CHECK-NEXT:    or %s11, 0, %s9
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
; CHECK-NEXT:    cmpu.w %s0, %s1, %s0
; CHECK-NEXT:    brle.w 0, %s0, .LBB4_1
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(%s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    br.l .LBB4_3
; CHECK:       .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK:       .LBB{{[0-9]+}}_3:
; CHECK-NEXT:    or %s11, 0, %s9
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
; CHECK-NEXT:    cmpu.w %s0, %s1, %s0
; CHECK-NEXT:    brlt.w 0, %s0, .LBB5_1
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(%s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    br.l .LBB5_3
; CHECK:       .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK:       .LBB{{[0-9]+}}_3:
; CHECK-NEXT:    or %s11, 0, %s9
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
; CHECK-NEXT:    cmpu.w %s0, %s1, %s0
; CHECK-NEXT:    brge.w 0, %s0, .LBB6_1
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(%s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    br.l .LBB6_3
; CHECK:       .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK:       .LBB{{[0-9]+}}_3:
; CHECK-NEXT:    or %s11, 0, %s9
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
; CHECK-NEXT:    cmpu.w %s0, %s1, %s0
; CHECK-NEXT:    brgt.w 0, %s0, .LBB7_1
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(%s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    br.l .LBB7_3
; CHECK:       .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK:       .LBB{{[0-9]+}}_3:
; CHECK-NEXT:    or %s11, 0, %s9
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
; CHECK-NEXT:    brne.w %s0, %s1, .LBB8_1
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(%s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    br.l .LBB8_3
; CHECK:       .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK:       .LBB{{[0-9]+}}_3:
; CHECK-NEXT:    or %s11, 0, %s9
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
; CHECK-NEXT:    breq.w %s0, %s1, .LBB9_1
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(%s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    br.l .LBB9_3
; CHECK:       .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK:       .LBB{{[0-9]+}}_3:
; CHECK-NEXT:    or %s11, 0, %s9
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
; CHECK-NEXT:    brlenan.s %s0, %s1, .LBB10_1
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(%s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    br.l .LBB10_3
; CHECK:       .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK:       .LBB{{[0-9]+}}_3:
; CHECK-NEXT:    or %s11, 0, %s9
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
; CHECK-NEXT:    brltnan.s %s0, %s1, .LBB11_1
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(%s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    br.l .LBB11_3
; CHECK:       .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK:       .LBB{{[0-9]+}}_3:
; CHECK-NEXT:    or %s11, 0, %s9
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
; CHECK-NEXT:    brgenan.s %s0, %s1, .LBB12_1
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(%s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    br.l .LBB12_3
; CHECK:       .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK:       .LBB{{[0-9]+}}_3:
; CHECK-NEXT:    or %s11, 0, %s9
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
; CHECK-NEXT:    brgtnan.s %s0, %s1, .LBB13_1
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(%s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    br.l .LBB13_3
; CHECK:       .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK:       .LBB{{[0-9]+}}_3:
; CHECK-NEXT:    or %s11, 0, %s9
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
; CHECK-NEXT:    brnan.s %s0, %s1, .LBB14_1
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(%s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK:       .LBB{{[0-9]+}}_3:
; CHECK-NEXT:    or %s11, 0, %s9
; CHECK:       .LBB{{[0-9]+}}_1:
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
; CHECK-NEXT:    brle.s %s0, %s1, .LBB15_1
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(%s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    br.l .LBB15_3
; CHECK:       .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK:       .LBB{{[0-9]+}}_3:
; CHECK-NEXT:    or %s11, 0, %s9
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
; CHECK-NEXT:    brlt.s %s0, %s1, .LBB16_1
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(%s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    br.l .LBB16_3
; CHECK:       .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK:       .LBB{{[0-9]+}}_3:
; CHECK-NEXT:    or %s11, 0, %s9
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
; CHECK-NEXT:    brge.s %s0, %s1, .LBB17_1
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(%s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    br.l .LBB17_3
; CHECK:       .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK:       .LBB{{[0-9]+}}_3:
; CHECK-NEXT:    or %s11, 0, %s9
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
; CHECK-NEXT:    brgt.s %s0, %s1, .LBB18_1
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(%s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    br.l .LBB18_3
; CHECK:       .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK:       .LBB{{[0-9]+}}_3:
; CHECK-NEXT:    or %s11, 0, %s9
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
; CHECK-NEXT:    brnenan.s %s0, %s1, .LBB19_1
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(%s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    br.l .LBB19_3
; CHECK:       .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK:       .LBB{{[0-9]+}}_3:
; CHECK-NEXT:    or %s11, 0, %s9
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
; CHECK-NEXT:    breqnan.s %s0, %s1, .LBB20_1
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(%s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    br.l .LBB20_3
; CHECK:       .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK:       .LBB{{[0-9]+}}_3:
; CHECK-NEXT:    or %s11, 0, %s9
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
; CHECK-NEXT:    breqnan.s %s0, %s1, .LBB21_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK-NEXT:    br.l .LBB21_3
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(%s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK:       .LBB{{[0-9]+}}_3:
; CHECK-NEXT:    or %s11, 0, %s9
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
; CHECK-NEXT:    breq.s %s0, %s1, .LBB22_1
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(%s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    br.l .LBB22_3
; CHECK:       .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK:       .LBB{{[0-9]+}}_3:
; CHECK-NEXT:    or %s11, 0, %s9
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
; CHECK-NEXT:    brnan.s %s0, %s1, .LBB23_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK:       .LBB{{[0-9]+}}_3:
; CHECK-NEXT:    or %s11, 0, %s9
; CHECK:       .LBB{{[0-9]+}}_2:
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
; CHECK-NEXT:    or %s1, 1, (0)1
; CHECK-NEXT:    brne.w %s1, %s0, .LBB24_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(%s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
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
; CHECK-NEXT:    brne.w %s0, %s0, .LBB25_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(%s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = fcmp true float %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}
