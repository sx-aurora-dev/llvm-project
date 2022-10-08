; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define signext i8 @func1(i8 signext %a, i8 signext %b) {
; CHECK-LABEL: func1:
; CHECK:       .LBB{{[0-9]+}}_5: # %entry
; CHECK-NEXT:    brle.w %s0, %s1, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %on.true
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(, %s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    br.l.t .LBB{{[0-9]+}}_3
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK-NEXT:  .LBB{{[0-9]+}}_3: # %join
; CHECK-NEXT:    sll %s0, %s0, 56
; CHECK-NEXT:    sra.l %s0, %s0, 56
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %cmp = icmp sgt i8 %a, %b
  br i1 %cmp, label %on.true, label %join

on.true:
  %ret.val = tail call i32 @ret(i32 2)
  %r8 = trunc i32 %ret.val to i8
  br label %join

join:
  %r = phi i8 [ %r8, %on.true ], [ 0, %entry ]
  ret i8 %r
}

declare signext i32 @ret(i32)

define signext i32 @func2(i16 signext %a, i16 signext %b) {
; CHECK-LABEL: func2:
; CHECK:       .LBB{{[0-9]+}}_5: # %entry
; CHECK-NEXT:    brle.w %s0, %s1, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %on.true
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(, %s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    br.l.t .LBB{{[0-9]+}}_3
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK-NEXT:  .LBB{{[0-9]+}}_3: # %join
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %cmp = icmp sgt i16 %a, %b
  br i1 %cmp, label %on.true, label %join

on.true:
  %ret.val = tail call i32 @ret(i32 2)
  br label %join

join:
  %r = phi i32 [ %ret.val, %on.true ], [ 0, %entry ]
  ret i32 %r
}

define signext i32 @func3(i32 %a, i32 %b) {
; CHECK-LABEL: func3:
; CHECK:       .LBB{{[0-9]+}}_5: # %entry
; CHECK-NEXT:    brle.w %s0, %s1, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %on.true
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(, %s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    br.l.t .LBB{{[0-9]+}}_3
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK-NEXT:  .LBB{{[0-9]+}}_3: # %join
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %cmp = icmp sgt i32 %a, %b
  br i1 %cmp, label %on.true, label %join

on.true:
  %ret.val = tail call i32 @ret(i32 2)
  br label %join

join:
  %r = phi i32 [ %ret.val, %on.true ], [ 0, %entry ]
  ret i32 %r
}

define signext i32 @func4(i64 %a, i64 %b) {
; CHECK-LABEL: func4:
; CHECK:       .LBB{{[0-9]+}}_5: # %entry
; CHECK-NEXT:    brle.l %s0, %s1, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %on.true
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(, %s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    br.l.t .LBB{{[0-9]+}}_3
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK-NEXT:  .LBB{{[0-9]+}}_3: # %join
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %cmp = icmp sgt i64 %a, %b
  br i1 %cmp, label %on.true, label %join

on.true:
  %ret.val = tail call i32 @ret(i32 2)
  br label %join

join:
  %r = phi i32 [ %ret.val, %on.true ], [ 0, %entry ]
  ret i32 %r
}

define signext i32 @func5(i8 zeroext %a, i8 zeroext %b) {
; CHECK-LABEL: func5:
; CHECK:       .LBB{{[0-9]+}}_5: # %entry
; CHECK-NEXT:    cmpu.w %s0, %s1, %s0
; CHECK-NEXT:    brle.w 0, %s0, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %on.true
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(, %s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    br.l.t .LBB{{[0-9]+}}_3
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK-NEXT:  .LBB{{[0-9]+}}_3: # %join
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %cmp = icmp ugt i8 %a, %b
  br i1 %cmp, label %on.true, label %join

on.true:
  %ret.val = tail call i32 @ret(i32 2)
  br label %join

join:
  %r = phi i32 [ %ret.val, %on.true ], [ 0, %entry ]
  ret i32 %r
}

define signext i32 @func6(i16 zeroext %a, i16 zeroext %b) {
; CHECK-LABEL: func6:
; CHECK:       .LBB{{[0-9]+}}_5: # %entry
; CHECK-NEXT:    cmpu.w %s0, %s1, %s0
; CHECK-NEXT:    brle.w 0, %s0, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %on.true
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(, %s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    br.l.t .LBB{{[0-9]+}}_3
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK-NEXT:  .LBB{{[0-9]+}}_3: # %join
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %cmp = icmp ugt i16 %a, %b
  br i1 %cmp, label %on.true, label %join

on.true:
  %ret.val = tail call i32 @ret(i32 2)
  br label %join

join:
  %r = phi i32 [ %ret.val, %on.true ], [ 0, %entry ]
  ret i32 %r
}

define signext i32 @func7(i32 %a, i32 %b) {
; CHECK-LABEL: func7:
; CHECK:       .LBB{{[0-9]+}}_5: # %entry
; CHECK-NEXT:    cmpu.w %s0, %s1, %s0
; CHECK-NEXT:    brle.w 0, %s0, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %on.true
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(, %s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    br.l.t .LBB{{[0-9]+}}_3
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK-NEXT:  .LBB{{[0-9]+}}_3: # %join
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %cmp = icmp ugt i32 %a, %b
  br i1 %cmp, label %on.true, label %join

on.true:
  %ret.val = tail call i32 @ret(i32 2)
  br label %join

join:
  %r = phi i32 [ %ret.val, %on.true ], [ 0, %entry ]
  ret i32 %r
}

define signext i32 @func8(float %a, float %b) {
; CHECK-LABEL: func8:
; CHECK:       .LBB{{[0-9]+}}_5: # %entry
; CHECK-NEXT:    brlenan.s %s0, %s1, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %on.true
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(, %s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    br.l.t .LBB{{[0-9]+}}_3
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK-NEXT:  .LBB{{[0-9]+}}_3: # %join
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %cmp = fcmp ogt float %a, %b
  br i1 %cmp, label %on.true, label %join

on.true:
  %ret.val = tail call i32 @ret(i32 2)
  br label %join

join:
  %r = phi i32 [ %ret.val, %on.true ], [ 0, %entry ]
  ret i32 %r
}

define signext i32 @func9(double %a, double %b) {
; CHECK-LABEL: func9:
; CHECK:       .LBB{{[0-9]+}}_5: # %entry
; CHECK-NEXT:    brlenan.d %s0, %s1, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %on.true
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(, %s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    br.l.t .LBB{{[0-9]+}}_3
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK-NEXT:  .LBB{{[0-9]+}}_3: # %join
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %cmp = fcmp ogt double %a, %b
  br i1 %cmp, label %on.true, label %join

on.true:
  %ret.val = tail call i32 @ret(i32 2)
  br label %join

join:
  %r = phi i32 [ %ret.val, %on.true ], [ 0, %entry ]
  ret i32 %r
}

define signext i32 @func10(double %a, double %b) {
; CHECK-LABEL: func10:
; CHECK:       .LBB{{[0-9]+}}_5: # %entry
; CHECK-NEXT:    lea.sl %s1, 1075052544
; CHECK-NEXT:    brlenan.d %s0, %s1, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %on.true
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(, %s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    br.l.t .LBB{{[0-9]+}}_3
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK-NEXT:  .LBB{{[0-9]+}}_3: # %join
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %cmp = fcmp ogt double %a, 5.000000e+00
  br i1 %cmp, label %on.true, label %join

on.true:
  %ret.val = tail call i32 @ret(i32 2)
  br label %join

join:
  %r = phi i32 [ %ret.val, %on.true ], [ 0, %entry ]
  ret i32 %r
}

define signext i32 @func11(fp128, fp128) {
; CHECK-LABEL: func11:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    fcmp.q %s0, %s2, %s0
; CHECK-NEXT:    brlenan.d 0, %s0, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(, %s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    br.l.t .LBB{{[0-9]+}}_3
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK-NEXT:  .LBB{{[0-9]+}}_3:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
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
define signext i32 @func12(i128, i128) {
; CHECK-LABEL: func12:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    cmpu.l %s4, %s1, %s3
; CHECK-NEXT:    cmps.l %s1, %s3, %s1
; CHECK-NEXT:    xor %s1, -1, %s1
; CHECK-NEXT:    srl %s1, %s1, 63
; CHECK-NEXT:    cmpu.l %s0, %s2, %s0
; CHECK-NEXT:    xor %s0, -1, %s0
; CHECK-NEXT:    srl %s0, %s0, 63
; CHECK-NEXT:    cmov.l.eq %s1, %s0, %s4
; CHECK-NEXT:    brne.w 0, %s1, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(, %s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    br.l.t .LBB{{[0-9]+}}_3
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK-NEXT:  .LBB{{[0-9]+}}_3:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
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
define signext i32 @func13(i128, i128) {
; CHECK-LABEL: func13:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:    cmpu.l %s4, %s1, %s3
; CHECK-NEXT:    cmpu.l %s1, %s3, %s1
; CHECK-NEXT:    xor %s1, -1, %s1
; CHECK-NEXT:    srl %s1, %s1, 63
; CHECK-NEXT:    cmpu.l %s0, %s2, %s0
; CHECK-NEXT:    xor %s0, -1, %s0
; CHECK-NEXT:    srl %s0, %s0, 63
; CHECK-NEXT:    cmov.l.eq %s1, %s0, %s4
; CHECK-NEXT:    brne.w 0, %s1, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    lea %s0, ret@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, ret@hi(, %s0)
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    br.l.t .LBB{{[0-9]+}}_3
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK-NEXT:  .LBB{{[0-9]+}}_3:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = icmp ugt i128 %0, %1
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @ret(i32 2)
  br label %6

; <label>:6:                                      ; preds = %2, %4
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}
