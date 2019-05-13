; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define i32 @i() {
; CHECK-LABEL: i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, -2147483648
; CHECK-NEXT:    or %s11, 0, %s9
  ret i32 -2147483648
}

define i32 @ui() {
; CHECK-LABEL: ui:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, -2147483648
; CHECK-NEXT:    or %s11, 0, %s9
  ret i32 -2147483648
}

define i64 @ll() {
; CHECK-LABEL: ll:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, -2147483648
; CHECK-NEXT:    or %s11, 0, %s9
  ret i64 -2147483648
}

define i64 @ull() {
; CHECK-LABEL: ull:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, -2147483648
; CHECK-NEXT:    and %s0, %s34, (32)0
; CHECK-NEXT:    or %s11, 0, %s9
  ret i64 2147483648
}

define signext i8 @d2c(double) {
; CHECK-LABEL: d2c:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.w.d.sx.rz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptosi double %0 to i8
  ret i8 %2
}

define zeroext i8 @d2uc(double) {
; CHECK-LABEL: d2uc:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.w.d.sx.rz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptoui double %0 to i8
  ret i8 %2
}

define signext i16 @d2s(double) {
; CHECK-LABEL: d2s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.w.d.sx.rz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptosi double %0 to i16
  ret i16 %2
}

define zeroext i16 @d2us(double) {
; CHECK-LABEL: d2us:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.w.d.sx.rz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptoui double %0 to i16
  ret i16 %2
}

define i32 @d2i(double) {
; CHECK-LABEL: d2i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.w.d.sx.rz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptosi double %0 to i32
  ret i32 %2
}

define i32 @d2ui(double) {
; CHECK-LABEL: d2ui:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.l.d.rz %s34, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s34, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptoui double %0 to i32
  ret i32 %2
}

define i64 @d2ll(double) {
; CHECK-LABEL: d2ll:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.l.d.rz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptosi double %0 to i64
  ret i64 %2
}

define i64 @d2ull(double) {
; CHECK-LABEL: d2ull:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, .LCPI11_0@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s34, .LCPI11_0@hi(%s34)
; CHECK-NEXT:    ld %s34, (,%s34)
; CHECK-NEXT:    fcmp.d %s35, %s0, %s34
; CHECK-NEXT:    fsub.d %s34, %s0, %s34
; CHECK-NEXT:    cvt.l.d.rz %s34, %s34
; CHECK-NEXT:    lea %s36, 0
; CHECK-NEXT:    and %s36, %s36, (32)0
; CHECK-NEXT:    lea.sl %s36, -2147483648(%s36)
; CHECK-NEXT:    xor %s34, %s34, %s36
; CHECK-NEXT:    cvt.l.d.rz %s36, %s0
; CHECK-NEXT:    cmov.d.lt %s34, %s36, %s35
; CHECK-NEXT:    or %s0, 0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptoui double %0 to i64
  ret i64 %2
}

define float @d2f(double) {
; CHECK-LABEL: d2f:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.s.d %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptrunc double %0 to float
  ret float %2
}

define double @d2d(double returned) {
; CHECK-LABEL: d2d:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret double %0
}

define fp128 @d2q(double) {
; CHECK-LABEL: d2q:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.q.d %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fpext double %0 to fp128
  ret fp128 %2
}

define signext i8 @q2c(fp128) {
; CHECK-LABEL: q2c:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.q %s34, %s0
; CHECK-NEXT:    cvt.w.d.sx.rz %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptosi fp128 %0 to i8
  ret i8 %2
}

define zeroext i8 @q2uc(fp128) {
; CHECK-LABEL: q2uc:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.q %s34, %s0
; CHECK-NEXT:    cvt.w.d.sx.rz %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptoui fp128 %0 to i8
  ret i8 %2
}

define signext i16 @q2s(fp128) {
; CHECK-LABEL: q2s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.q %s34, %s0
; CHECK-NEXT:    cvt.w.d.sx.rz %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptosi fp128 %0 to i16
  ret i16 %2
}

define zeroext i16 @q2us(fp128) {
; CHECK-LABEL: q2us:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.q %s34, %s0
; CHECK-NEXT:    cvt.w.d.sx.rz %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptoui fp128 %0 to i16
  ret i16 %2
}

define i32 @q2i(fp128) {
; CHECK-LABEL: q2i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.q %s34, %s0
; CHECK-NEXT:    cvt.w.d.sx.rz %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptosi fp128 %0 to i32
  ret i32 %2
}

define i32 @q2ui(fp128) {
; CHECK-LABEL: q2ui:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.q %s34, %s0
; CHECK-NEXT:    cvt.l.d.rz %s34, %s34
; CHECK-NEXT:    adds.w.sx %s0, %s34, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptoui fp128 %0 to i32
  ret i32 %2
}

define i64 @q2ll(fp128) {
; CHECK-LABEL: q2ll:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.q %s34, %s0
; CHECK-NEXT:    cvt.l.d.rz %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptosi fp128 %0 to i64
  ret i64 %2
}

define i64 @q2ull(fp128) {
; CHECK-LABEL: q2ull:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, .LCPI22_0@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s34, .LCPI22_0@hi(%s34)
; CHECK-NEXT:    ld %s36, 8(,%s34)
; CHECK-NEXT:    ld %s37, (,%s34)
; CHECK-NEXT:    fcmp.q %s35, %s0, %s36
; CHECK-NEXT:    fsub.q %s36, %s0, %s36
; CHECK-NEXT:    cvt.d.q %s34, %s36
; CHECK-NEXT:    cvt.l.d.rz %s34, %s34
; CHECK-NEXT:    lea %s36, 0
; CHECK-NEXT:    and %s36, %s36, (32)0
; CHECK-NEXT:    lea.sl %s36, -2147483648(%s36)
; CHECK-NEXT:    xor %s34, %s34, %s36
; CHECK-NEXT:    cvt.d.q %s36, %s0
; CHECK-NEXT:    cvt.l.d.rz %s36, %s36
; CHECK-NEXT:    cmov.d.lt %s34, %s36, %s35
; CHECK-NEXT:    or %s0, 0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptoui fp128 %0 to i64
  ret i64 %2
}

define float @q2f(fp128) {
; CHECK-LABEL: q2f:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.s.q %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptrunc fp128 %0 to float
  ret float %2
}

define double @q2d(fp128) {
; CHECK-LABEL: q2d:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.q %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptrunc fp128 %0 to double
  ret double %2
}

define fp128 @q2q(fp128 returned) {
; CHECK-LABEL: q2q:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret fp128 %0
}

define signext i8 @f2c(float) {
; CHECK-LABEL: f2c:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.w.s.sx.rz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptosi float %0 to i8
  ret i8 %2
}

define zeroext i8 @f2uc(float) {
; CHECK-LABEL: f2uc:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.w.s.sx.rz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptoui float %0 to i8
  ret i8 %2
}

define signext i16 @f2s(float) {
; CHECK-LABEL: f2s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.w.s.sx.rz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptosi float %0 to i16
  ret i16 %2
}

define zeroext i16 @f2us(float) {
; CHECK-LABEL: f2us:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.w.s.sx.rz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptoui float %0 to i16
  ret i16 %2
}

define i32 @f2i(float) {
; CHECK-LABEL: f2i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.w.s.sx.rz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptosi float %0 to i32
  ret i32 %2
}

define i32 @f2ui(float) {
; CHECK-LABEL: f2ui:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.s %s34, %s0
; CHECK-NEXT:    cvt.l.d.rz %s34, %s34
; CHECK-NEXT:    adds.w.sx %s0, %s34, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptoui float %0 to i32
  ret i32 %2
}

define i64 @f2ll(float) {
; CHECK-LABEL: f2ll:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.s %s34, %s0
; CHECK-NEXT:    cvt.l.d.rz %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptosi float %0 to i64
  ret i64 %2
}

define i64 @f2ull(float) {
; CHECK-LABEL: f2ull:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, .LCPI33_0@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s34, .LCPI33_0@hi(%s34)
; CHECK-NEXT:    ldu %s34, (,%s34)
; CHECK-NEXT:    fcmp.s %s35, %s0, %s34
; CHECK-NEXT:    fsub.s %s34, %s0, %s34
; CHECK-NEXT:    cvt.d.s %s34, %s34
; CHECK-NEXT:    cvt.l.d.rz %s34, %s34
; CHECK-NEXT:    lea %s36, 0
; CHECK-NEXT:    and %s36, %s36, (32)0
; CHECK-NEXT:    lea.sl %s36, -2147483648(%s36)
; CHECK-NEXT:    xor %s34, %s34, %s36
; CHECK-NEXT:    cvt.d.s %s36, %s0
; CHECK-NEXT:    cvt.l.d.rz %s36, %s36
; CHECK-NEXT:    cmov.s.lt %s34, %s36, %s35
; CHECK-NEXT:    or %s0, 0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptoui float %0 to i64
  ret i64 %2
}

define float @f2f(float returned) {
; CHECK-LABEL: f2f:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret float %0
}

define double @f2d(float) {
; CHECK-LABEL: f2d:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.s %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fpext float %0 to double
  ret double %2
}

define fp128 @f2q(float) {
; CHECK-LABEL: f2q:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.q.s %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fpext float %0 to fp128
  ret fp128 %2
}

define signext i8 @ll2c(i64) {
; CHECK-LABEL: ll2c:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sll %s34, %s0, 56
; CHECK-NEXT:    sra.l %s0, %s34, 56
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i64 %0 to i8
  ret i8 %2
}

define zeroext i8 @ll2uc(i64) {
; CHECK-LABEL: ll2uc:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (56)0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i64 %0 to i8
  ret i8 %2
}

define signext i16 @ll2s(i64) {
; CHECK-LABEL: ll2s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sll %s34, %s0, 48
; CHECK-NEXT:    sra.l %s0, %s34, 48
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i64 %0 to i16
  ret i16 %2
}

define zeroext i16 @ll2us(i64) {
; CHECK-LABEL: ll2us:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (48)0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i64 %0 to i16
  ret i16 %2
}

define i32 @ll2i(i64) {
; CHECK-LABEL: ll2i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i64 %0 to i32
  ret i32 %2
}

define i32 @ll2ui(i64) {
; CHECK-LABEL: ll2ui:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT TODO:    and %s0, %s0, (32)0
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i64 %0 to i32
  ret i32 %2
}

define i64 @ll2ll(i64 returned) {
; CHECK-LABEL: ll2ll:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret i64 %0
}

define i64 @ll2ull(i64 returned) {
; CHECK-LABEL: ll2ull:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret i64 %0
}

define float @ll2f(i64) {
; CHECK-LABEL: ll2f:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.l %s34, %s0
; CHECK-NEXT:    cvt.s.d %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sitofp i64 %0 to float
  ret float %2
}

define double @ll2d(i64) {
; CHECK-LABEL: ll2d:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.l %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sitofp i64 %0 to double
  ret double %2
}

define fp128 @ll2q(i64) {
; CHECK-LABEL: ll2q:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.l %s34, %s0
; CHECK-NEXT:    cvt.q.d %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sitofp i64 %0 to fp128
  ret fp128 %2
}

define signext i8 @ull2c(i64) {
; CHECK-LABEL: ull2c:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sll %s34, %s0, 56
; CHECK-NEXT:    sra.l %s0, %s34, 56
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i64 %0 to i8
  ret i8 %2
}

define zeroext i8 @ull2uc(i64) {
; CHECK-LABEL: ull2uc:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (56)0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i64 %0 to i8
  ret i8 %2
}

define signext i16 @ull2s(i64) {
; CHECK-LABEL: ull2s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sll %s34, %s0, 48
; CHECK-NEXT:    sra.l %s0, %s34, 48
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i64 %0 to i16
  ret i16 %2
}

define zeroext i16 @ull2us(i64) {
; CHECK-LABEL: ull2us:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (48)0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i64 %0 to i16
  ret i16 %2
}

define i32 @ull2i(i64) {
; CHECK-LABEL: ull2i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i64 %0 to i32
  ret i32 %2
}

define i32 @ull2ui(i64) {
; CHECK-LABEL: ull2ui:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT TODO:    and %s0, %s0, (32)0
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i64 %0 to i32
  ret i32 %2
}

define i64 @ull2ll(i64 returned) {
; CHECK-LABEL: ull2ll:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret i64 %0
}

define i64 @ull2ull(i64 returned) {
; CHECK-LABEL: ull2ull:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret i64 %0
}

define float @ull2f(i64) {
; CHECK-LABEL: ull2f:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmps.l %s35, %s0, %s34
; CHECK-NEXT:    cvt.d.l %s34, %s0
; CHECK-NEXT:    cvt.s.d %s34, %s34
; CHECK-NEXT:    srl %s36, %s0, 1
; CHECK-NEXT:    and %s37, 1, %s0
; CHECK-NEXT:    or %s36, %s37, %s36
; CHECK-NEXT:    cvt.d.l %s36, %s36
; CHECK-NEXT:    cvt.s.d %s36, %s36
; CHECK-NEXT:    fadd.s %s36, %s36, %s36
; CHECK-NEXT:    cmov.l.lt %s34, %s36, %s35
; CHECK-NEXT:    or %s0, 0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = uitofp i64 %0 to float
  ret float %2
}

define double @ull2d(i64) {
; CHECK-LABEL: ull2d:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    srl %s34, %s0, 32
; CHECK-NEXT:    lea %s35, 0
; CHECK-NEXT:    lea %s36, .LCPI57_0@lo
; CHECK-NEXT:    and %s36, %s36, (32)0
; CHECK-NEXT:    lea.sl %s36, .LCPI57_0@hi(%s36)
; CHECK-NEXT:    ld %s36, (,%s36)
; CHECK-NEXT:    and %s35, %s35, (32)0
; CHECK-NEXT:    lea.sl %s37, 1160773632(%s35)
; CHECK-NEXT:    or %s34, %s34, %s37
; CHECK-NEXT:    fsub.d %s34, %s34, %s36
; CHECK-NEXT:    lea %s36, -1
; CHECK-NEXT:    and %s36, %s36, (32)0
; CHECK-NEXT:    and %s36, %s0, %s36
; CHECK-NEXT:    lea.sl %s35, 1127219200(%s35)
; CHECK-NEXT:    or %s35, %s36, %s35
; CHECK-NEXT:    fadd.d %s0, %s35, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = uitofp i64 %0 to double
  ret double %2
}

define fp128 @ull2q(i64) {
; CHECK-LABEL: ull2q:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    srl %s34, %s0, 61
; CHECK-NEXT:    and %s34, 4, %s34
; CHECK-NEXT:    lea %s35, .LCPI58_0@lo
; CHECK-NEXT:    and %s35, %s35, (32)0
; CHECK-NEXT:    lea.sl %s35, .LCPI58_0@hi(%s35)
; CHECK-NEXT:    adds.l %s34, %s35, %s34
; CHECK-NEXT:    ldu %s34, (,%s34)
; CHECK-NEXT:    cvt.q.s %s34, %s34
; CHECK-NEXT:    cvt.d.l %s36, %s0
; CHECK-NEXT:    cvt.q.d %s36, %s36
; CHECK-NEXT:    fadd.q %s0, %s36, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = uitofp i64 %0 to fp128
  ret fp128 %2
}

define signext i8 @i2c(i32) {
; CHECK-LABEL: i2c:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s34, %s0, 24
; CHECK-NEXT:    sra.w.sx %s0, %s34, 24
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i32 %0 to i8
  ret i8 %2
}

define zeroext i8 @i2uc(i32) {
; CHECK-LABEL: i2uc:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (56)0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i32 %0 to i8
  ret i8 %2
}

define signext i16 @i2s(i32) {
; CHECK-LABEL: i2s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s34, %s0, 16
; CHECK-NEXT:    sra.w.sx %s0, %s34, 16
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i32 %0 to i16
  ret i16 %2
}

define zeroext i16 @i2us(i32) {
; CHECK-LABEL: i2us:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (48)0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i32 %0 to i16
  ret i16 %2
}

define i32 @i2i(i32 returned) {
; CHECK-LABEL: i2i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret i32 %0
}

define i32 @i2ui(i32 returned) {
; CHECK-LABEL: i2ui:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret i32 %0
}

define i64 @i2ll(i32) {
; CHECK-LABEL: i2ll:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i32 %0 to i64
  ret i64 %2
}

define i64 @i2ull(i32) {
; CHECK-LABEL: i2ull:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i32 %0 to i64
  ret i64 %2
}

define float @i2f(i32) {
; CHECK-LABEL: i2f:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.s.w %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sitofp i32 %0 to float
  ret float %2
}

define double @i2d(i32) {
; CHECK-LABEL: i2d:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.w %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sitofp i32 %0 to double
  ret double %2
}

define fp128 @i2q(i32) {
; CHECK-LABEL: i2q:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.w %s34, %s0
; CHECK-NEXT:    cvt.q.d %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sitofp i32 %0 to fp128
  ret fp128 %2
}

define signext i8 @ui2c(i32) {
; CHECK-LABEL: ui2c:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s34, %s0, 24
; CHECK-NEXT:    sra.w.sx %s0, %s34, 24
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i32 %0 to i8
  ret i8 %2
}

define zeroext i8 @ui2uc(i32) {
; CHECK-LABEL: ui2uc:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (56)0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i32 %0 to i8
  ret i8 %2
}

define signext i16 @ui2s(i32) {
; CHECK-LABEL: ui2s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s34, %s0, 16
; CHECK-NEXT:    sra.w.sx %s0, %s34, 16
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i32 %0 to i16
  ret i16 %2
}

define zeroext i16 @ui2us(i32) {
; CHECK-LABEL: ui2us:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (48)0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i32 %0 to i16
  ret i16 %2
}

define i32 @ui2i(i32 returned) {
; CHECK-LABEL: ui2i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret i32 %0
}

define i32 @ui2ui(i32 returned) {
; CHECK-LABEL: ui2ui:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret i32 %0
}

define i64 @ui2ll(i32) {
; CHECK-LABEL: ui2ll:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i32 %0 to i64
  ret i64 %2
}

define i64 @ui2ull(i32) {
; CHECK-LABEL: ui2ull:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i32 %0 to i64
  ret i64 %2
}

define float @ui2f(i32) {
; CHECK-LABEL: ui2f:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.zx %s34, %s0, (0)1
; CHECK-NEXT:    cvt.d.l %s34, %s34
; CHECK-NEXT:    cvt.s.d %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = uitofp i32 %0 to float
  ret float %2
}

define double @ui2d(i32) {
; CHECK-LABEL: ui2d:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.zx %s34, %s0, (0)1
; CHECK-NEXT:    cvt.d.l %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = uitofp i32 %0 to double
  ret double %2
}

define fp128 @ui2q(i32) {
; CHECK-LABEL: ui2q:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.zx %s34, %s0, (0)1
; CHECK-NEXT:    cvt.d.l %s34, %s34
; CHECK-NEXT:    cvt.q.d %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = uitofp i32 %0 to fp128
  ret fp128 %2
}

define signext i8 @s2c(i16 signext) {
; CHECK-LABEL: s2c:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s34, %s0, 24
; CHECK-NEXT:    sra.w.sx %s0, %s34, 24
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i16 %0 to i8
  ret i8 %2
}

define zeroext i8 @s2uc(i16 signext) {
; CHECK-LABEL: s2uc:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (56)0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i16 %0 to i8
  ret i8 %2
}

define signext i16 @s2s(i16 returned signext) {
; CHECK-LABEL: s2s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret i16 %0
}

define zeroext i16 @s2us(i16 returned signext) {
; CHECK-LABEL: s2us:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (48)0
; CHECK-NEXT:    or %s11, 0, %s9
  ret i16 %0
}

define i32 @s2i(i16 signext) {
; CHECK-LABEL: s2i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i16 %0 to i32
  ret i32 %2
}

define i32 @s2ui(i16 signext) {
; CHECK-LABEL: s2ui:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT TODO:    and %s0, %s0, (32)0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i16 %0 to i32
  ret i32 %2
}

define i64 @s2ll(i16 signext) {
; CHECK-LABEL: s2ll:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i16 %0 to i64
  ret i64 %2
}

define i64 @s2ull(i16 signext) {
; CHECK-LABEL: s2ull:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i16 %0 to i64
  ret i64 %2
}

define float @s2f(i16 signext) {
; CHECK-LABEL: s2f:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.s.w %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sitofp i16 %0 to float
  ret float %2
}

define double @s2d(i16 signext) {
; CHECK-LABEL: s2d:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.w %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sitofp i16 %0 to double
  ret double %2
}

define fp128 @s2q(i16 signext) {
; CHECK-LABEL: s2q:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.w %s34, %s0
; CHECK-NEXT:    cvt.q.d %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sitofp i16 %0 to fp128
  ret fp128 %2
}

define signext i8 @us2c(i16 zeroext) {
; CHECK-LABEL: us2c:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s34, %s0, 24
; CHECK-NEXT:    sra.w.sx %s0, %s34, 24
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i16 %0 to i8
  ret i8 %2
}

define zeroext i8 @us2uc(i16 zeroext) {
; CHECK-LABEL: us2uc:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (56)0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i16 %0 to i8
  ret i8 %2
}

define signext i16 @us2s(i16 returned zeroext) {
; CHECK-LABEL: us2s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s34, %s0, 16
; CHECK-NEXT:    sra.w.sx %s0, %s34, 16
; CHECK-NEXT:    or %s11, 0, %s9
  ret i16 %0
}

define zeroext i16 @us2us(i16 returned zeroext) {
; CHECK-LABEL: us2us:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret i16 %0
}

define i32 @us2i(i16 zeroext) {
; CHECK-LABEL: us2i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i16 %0 to i32
  ret i32 %2
}

define i32 @us2ui(i16 zeroext) {
; CHECK-LABEL: us2ui:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i16 %0 to i32
  ret i32 %2
}

define i64 @us2ll(i16 zeroext) {
; CHECK-LABEL: us2ll:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i16 %0 to i64
  ret i64 %2
}

define i64 @us2ull(i16 zeroext) {
; CHECK-LABEL: us2ull:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i16 %0 to i64
  ret i64 %2
}

define float @us2f(i16 zeroext) {
; CHECK-LABEL: us2f:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.s.w %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = uitofp i16 %0 to float
  ret float %2
}

define double @us2d(i16 zeroext) {
; CHECK-LABEL: us2d:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.w %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = uitofp i16 %0 to double
  ret double %2
}

define fp128 @us2q(i16 zeroext) {
; CHECK-LABEL: us2q:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.w %s34, %s0
; CHECK-NEXT:    cvt.q.d %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = uitofp i16 %0 to fp128
  ret fp128 %2
}

define signext i8 @c2c(i8 returned signext) {
; CHECK-LABEL: c2c:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret i8 %0
}

define zeroext i8 @c2uc(i8 returned signext) {
; CHECK-LABEL: c2uc:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (56)0
; CHECK-NEXT:    or %s11, 0, %s9
  ret i8 %0
}

define signext i16 @c2s(i8 signext) {
; CHECK-LABEL: c2s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i8 %0 to i16
  ret i16 %2
}

define zeroext i16 @c2us(i8 signext) {
; CHECK-LABEL: c2us:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (48)0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i8 %0 to i16
  ret i16 %2
}

define i32 @c2i(i8 signext) {
; CHECK-LABEL: c2i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i8 %0 to i32
  ret i32 %2
}

define i32 @c2ui(i8 signext) {
; CHECK-LABEL: c2ui:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i8 %0 to i32
  ret i32 %2
}

define i64 @c2ll(i8 signext) {
; CHECK-LABEL: c2ll:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i8 %0 to i64
  ret i64 %2
}

define i64 @c2ull(i8 signext) {
; CHECK-LABEL: c2ull:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i8 %0 to i64
  ret i64 %2
}

define float @c2f(i8 signext) {
; CHECK-LABEL: c2f:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.s.w %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sitofp i8 %0 to float
  ret float %2
}

define double @c2d(i8 signext) {
; CHECK-LABEL: c2d:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.w %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sitofp i8 %0 to double
  ret double %2
}

define fp128 @c2q(i8 signext) {
; CHECK-LABEL: c2q:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.w %s34, %s0
; CHECK-NEXT:    cvt.q.d %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sitofp i8 %0 to fp128
  ret fp128 %2
}

define signext i8 @uc2c(i8 returned zeroext) {
; CHECK-LABEL: uc2c:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s34, %s0, 24
; CHECK-NEXT:    sra.w.sx %s0, %s34, 24
; CHECK-NEXT:    or %s11, 0, %s9
  ret i8 %0
}

define zeroext i8 @uc2uc(i8 returned zeroext) {
; CHECK-LABEL: uc2uc:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret i8 %0
}

define signext i16 @uc2s(i8 zeroext) {
; CHECK-LABEL: uc2s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i8 %0 to i16
  ret i16 %2
}

define zeroext i16 @uc2us(i8 zeroext) {
; CHECK-LABEL: uc2us:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i8 %0 to i16
  ret i16 %2
}

define i32 @uc2i(i8 zeroext) {
; CHECK-LABEL: uc2i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i8 %0 to i32
  ret i32 %2
}

define i32 @uc2ui(i8 zeroext) {
; CHECK-LABEL: uc2ui:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i8 %0 to i32
  ret i32 %2
}

define i64 @uc2ll(i8 zeroext) {
; CHECK-LABEL: uc2ll:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i8 %0 to i64
  ret i64 %2
}

define i64 @uc2ull(i8 zeroext) {
; CHECK-LABEL: uc2ull:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i8 %0 to i64
  ret i64 %2
}

define float @uc2f(i8 zeroext) {
; CHECK-LABEL: uc2f:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.s.w %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = uitofp i8 %0 to float
  ret float %2
}

define double @uc2d(i8 zeroext) {
; CHECK-LABEL: uc2d:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.w %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = uitofp i8 %0 to double
  ret double %2
}

define fp128 @uc2q(i8 zeroext) {
; CHECK-LABEL: uc2q:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.w %s34, %s0
; CHECK-NEXT:    cvt.q.d %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = uitofp i8 %0 to fp128
  ret fp128 %2
}

; Function Attrs: norecurse nounwind readnone
define i128 @i128() {
; CHECK-LABEL: i128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, -2147483648
; CHECK-NEXT:    or %s1, -1, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  ret i128 -2147483648
}

; Function Attrs: norecurse nounwind readnone
define i128 @ui128() {
; CHECK-LABEL: ui128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, -2147483648
; CHECK-NEXT:    or %s1, -1, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  ret i128 -2147483648
}

; Function Attrs: norecurse nounwind readnone
define signext i8 @i1282c(i128) {
; CHECK-LABEL: i1282c:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sll %s34, %s0, 56
; CHECK-NEXT:    sra.l %s0, %s34, 56
; CHECK-NEXT:                                          # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i128 %0 to i8
  ret i8 %2
}

; Function Attrs: norecurse nounwind readnone
define signext i8 @ui1282c(i128) {
; CHECK-LABEL: ui1282c:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sll %s34, %s0, 56
; CHECK-NEXT:    sra.l %s0, %s34, 56
; CHECK-NEXT:                                          # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i128 %0 to i8
  ret i8 %2
}

; Function Attrs: norecurse nounwind readnone
define zeroext i8 @i1282uc(i128) {
; CHECK-LABEL: i1282uc:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (56)0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i128 %0 to i8
  ret i8 %2
}

; Function Attrs: norecurse nounwind readnone
define zeroext i8 @ui1282uc(i128) {
; CHECK-LABEL: ui1282uc:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (56)0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i128 %0 to i8
  ret i8 %2
}

; Function Attrs: norecurse nounwind readnone
define signext i16 @i1282s(i128) {
; CHECK-LABEL: i1282s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sll %s34, %s0, 48
; CHECK-NEXT:    sra.l %s0, %s34, 48
; CHECK-NEXT:                                          # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i128 %0 to i16
  ret i16 %2
}

; Function Attrs: norecurse nounwind readnone
define signext i16 @ui1282s(i128) {
; CHECK-LABEL: ui1282s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sll %s34, %s0, 48
; CHECK-NEXT:    sra.l %s0, %s34, 48
; CHECK-NEXT:                                          # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i128 %0 to i16
  ret i16 %2
}

; Function Attrs: norecurse nounwind readnone
define zeroext i16 @i1282us(i128) {
; CHECK-LABEL: i1282us:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (48)0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i128 %0 to i16
  ret i16 %2
}

; Function Attrs: norecurse nounwind readnone
define zeroext i16 @ui1282us(i128) {
; CHECK-LABEL: ui1282us:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (48)0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i128 %0 to i16
  ret i16 %2
}

; Function Attrs: norecurse nounwind readnone
define i32 @i1282i(i128) {
; CHECK-LABEL: i1282i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i128 %0 to i32
  ret i32 %2
}

; Function Attrs: norecurse nounwind readnone
define i32 @ui1282i(i128) {
; CHECK-LABEL: ui1282i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i128 %0 to i32
  ret i32 %2
}

; Function Attrs: norecurse nounwind readnone
define i32 @i1282ui(i128) {
; CHECK-LABEL: i1282ui:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i128 %0 to i32
  ret i32 %2
}

; Function Attrs: norecurse nounwind readnone
define i32 @ui1282ui(i128) {
; CHECK-LABEL: ui1282ui:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i128 %0 to i32
  ret i32 %2
}

; Function Attrs: norecurse nounwind readnone
define i64 @i1282ll(i128) {
; CHECK-LABEL: i1282ll:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i128 %0 to i64
  ret i64 %2
}

; Function Attrs: norecurse nounwind readnone
define i64 @ui1282ll(i128) {
; CHECK-LABEL: ui1282ll:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i128 %0 to i64
  ret i64 %2
}

; Function Attrs: norecurse nounwind readnone
define i64 @i1282ull(i128) {
; CHECK-LABEL: i1282ull:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i128 %0 to i64
  ret i64 %2
}

; Function Attrs: norecurse nounwind readnone
define i64 @ui1282ull(i128) {
; CHECK-LABEL: ui1282ull:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i128 %0 to i64
  ret i64 %2
}

; Function Attrs: norecurse nounwind readnone
define i128 @i1282ui128(i128 returned) {
; CHECK-LABEL: i1282ui128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret i128 %0
}

; Function Attrs: norecurse nounwind readnone
define i128 @ui1282i128(i128 returned) {
; CHECK-LABEL: ui1282i128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret i128 %0
}

; Function Attrs: norecurse nounwind readnone
define float @i1282f(i128) {
; CHECK-LABEL: i1282f:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, __floattisf@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __floattisf@hi(%s34)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sitofp i128 %0 to float
  ret float %2
}

; Function Attrs: norecurse nounwind readnone
define float @ui1282f(i128) {
; CHECK-LABEL: ui1282f:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, __floatuntisf@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __floatuntisf@hi(%s34)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = uitofp i128 %0 to float
  ret float %2
}

; Function Attrs: norecurse nounwind readnone
define double @i1282d(i128) {
; CHECK-LABEL: i1282d:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, __floattidf@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __floattidf@hi(%s34)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sitofp i128 %0 to double
  ret double %2
}

; Function Attrs: norecurse nounwind readnone
define double @ui1282d(i128) {
; CHECK-LABEL: ui1282d:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, __floatuntidf@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __floatuntidf@hi(%s34)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = uitofp i128 %0 to double
  ret double %2
}

; Function Attrs: norecurse nounwind readnone
define i128 @d2i128(double) {
; CHECK-LABEL: d2i128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, __fixdfti@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __fixdfti@hi(%s34)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptosi double %0 to i128
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define i128 @d2ui128(double) {
; CHECK-LABEL: d2ui128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, __fixunsdfti@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __fixunsdfti@hi(%s34)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptoui double %0 to i128
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define i128 @f2i128(float) {
; CHECK-LABEL: f2i128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, __fixsfti@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __fixsfti@hi(%s34)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptosi float %0 to i128
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define i128 @f2ui128(float) {
; CHECK-LABEL: f2ui128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, __fixunssfti@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __fixunssfti@hi(%s34)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptoui float %0 to i128
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define i128 @ll2i128(i64) {
; CHECK-LABEL: ll2i128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sra.l %s1, %s0, 63
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i64 %0 to i128
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define i128 @ll2ui128(i64) {
; CHECK-LABEL: ll2ui128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sra.l %s1, %s0, 63
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i64 %0 to i128
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define i128 @ull2i128(i64) {
; CHECK-LABEL: ull2i128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i64 %0 to i128
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define i128 @ull2ui128(i64) {
; CHECK-LABEL: ull2ui128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i64 %0 to i128
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define i128 @i2i128(i32) {
; CHECK-LABEL: i2i128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    sra.l %s1, %s0, 63
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i32 %0 to i128
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define i128 @i2ui128(i32) {
; CHECK-LABEL: i2ui128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    sra.l %s1, %s0, 63
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i32 %0 to i128
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define i128 @ui2i128(i32) {
; CHECK-LABEL: ui2i128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i32 %0 to i128
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define i128 @ui2ui128(i32) {
; CHECK-LABEL: ui2ui128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i32 %0 to i128
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define i128 @s2i128(i16 signext) {
; CHECK-LABEL: s2i128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    sra.l %s1, %s0, 63
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i16 %0 to i128
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define i128 @s2ui128(i16 signext) {
; CHECK-LABEL: s2ui128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    sra.l %s1, %s0, 63
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i16 %0 to i128
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define i128 @us2i128(i16 zeroext) {
; CHECK-LABEL: us2i128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i16 %0 to i128
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define i128 @us2ui128(i16 zeroext) {
; CHECK-LABEL: us2ui128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i16 %0 to i128
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define i128 @c2i128(i8 signext) {
; CHECK-LABEL: c2i128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    sra.l %s1, %s0, 63
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i8 %0 to i128
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define i128 @char2ui128(i8 signext) {
; CHECK-LABEL: char2ui128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    sra.l %s1, %s0, 63
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i8 %0 to i128
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define i128 @uc2i128(i8 zeroext) {
; CHECK-LABEL: uc2i128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i8 %0 to i128
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define i128 @uc2ui128(i8 zeroext) {
; CHECK-LABEL: uc2ui128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i8 %0 to i128
  ret i128 %2
}
