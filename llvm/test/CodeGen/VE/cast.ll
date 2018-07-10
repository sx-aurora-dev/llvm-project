; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define i32 @i() #0 {
; CHECK-LABEL: i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, -2147483648
; CHECK-NEXT:    or %s11, 0, %s9
  ret i32 -2147483648
}

define i32 @ui() #0 {
; CHECK-LABEL: ui:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, -2147483648
; CHECK-NEXT:    or %s11, 0, %s9
  ret i32 -2147483648
}

define i64 @ll() #0 {
; CHECK-LABEL: ll:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, -2147483648
; CHECK-NEXT:    or %s11, 0, %s9
  ret i64 -2147483648
}

define i64 @ull() #0 {
; CHECK-LABEL: ull:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, -2147483648
; CHECK-NEXT:    and %s0, %s34, (32)0
; CHECK-NEXT:    or %s11, 0, %s9
  ret i64 2147483648
}

define signext i8 @d2c(double) #0 {
; CHECK-LABEL: d2c:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.w.d.sx.rz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptosi double %0 to i8
  ret i8 %2
}

define zeroext i8 @d2uc(double) #0 {
; CHECK-LABEL: d2uc:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.l.d.rz %s34, %s0
; CHECK-NEXT:    and %s0, %s34, (32)0
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptoui double %0 to i8
  ret i8 %2
}

define signext i16 @d2s(double) #0 {
; CHECK-LABEL: d2s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.w.d.sx.rz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptosi double %0 to i16
  ret i16 %2
}

define zeroext i16 @d2us(double) #0 {
; CHECK-LABEL: d2us:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.l.d.rz %s34, %s0
; CHECK-NEXT:    and %s0, %s34, (32)0
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptoui double %0 to i16
  ret i16 %2
}

define i32 @d2i(double) #0 {
; CHECK-LABEL: d2i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.w.d.sx.rz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptosi double %0 to i32
  ret i32 %2
}

define i32 @d2ui(double) #0 {
; CHECK-LABEL: d2ui:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.l.d.rz %s34, %s0
; CHECK-NEXT:    and %s0, %s34, (32)0
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptoui double %0 to i32
  ret i32 %2
}

define i64 @d2ll(double) #0 {
; CHECK-LABEL: d2ll:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.l.d.rz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptosi double %0 to i64
  ret i64 %2
}

define i64 @d2ull(double) #0 {
; CHECK-LABEL: d2ull:
; CHECK:       .LBB{{[0-9]+}}_2:
  %2 = fptoui double %0 to i64
  ret i64 %2
}

define float @d2f(double) #0 {
; CHECK-LABEL: d2f:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.s.d %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptrunc double %0 to float
  ret float %2
}

define double @d2d(double returned) #0 {
; CHECK-LABEL: d2d:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret double %0
}

define signext i8 @f2c(float) #0 {
; CHECK-LABEL: f2c:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.w.s.sx.rz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptosi float %0 to i8
  ret i8 %2
}

define zeroext i8 @f2uc(float) #0 {
; CHECK-LABEL: f2uc:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.s %s34, %s0
; CHECK-NEXT:    cvt.l.d.rz %s34, %s34
; CHECK-NEXT:    and %s0, %s34, (32)0
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptoui float %0 to i8
  ret i8 %2
}

define signext i16 @f2s(float) #0 {
; CHECK-LABEL: f2s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.w.s.sx.rz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptosi float %0 to i16
  ret i16 %2
}

define zeroext i16 @f2us(float) #0 {
; CHECK-LABEL: f2us:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.s %s34, %s0
; CHECK-NEXT:    cvt.l.d.rz %s34, %s34
; CHECK-NEXT:    and %s0, %s34, (32)0
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptoui float %0 to i16
  ret i16 %2
}

define i32 @f2i(float) #0 {
; CHECK-LABEL: f2i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.w.s.sx.rz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptosi float %0 to i32
  ret i32 %2
}

define i32 @f2ui(float) #0 {
; CHECK-LABEL: f2ui:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.s %s34, %s0
; CHECK-NEXT:    cvt.l.d.rz %s34, %s34
; CHECK-NEXT:    and %s0, %s34, (32)0
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptoui float %0 to i32
  ret i32 %2
}

define i64 @f2ll(float) #0 {
; CHECK-LABEL: f2ll:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.s %s34, %s0
; CHECK-NEXT:    cvt.l.d.rz %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptosi float %0 to i64
  ret i64 %2
}

define i64 @f2ull(float) #0 {
; CHECK-LABEL: f2ull:
; CHECK:       .LBB{{[0-9]+}}_2:
  %2 = fptoui float %0 to i64
  ret i64 %2
}

define float @f2f(float returned) #0 {
; CHECK-LABEL: f2f:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret float %0
}

define double @f2d(float) #0 {
; CHECK-LABEL: f2d:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.s %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fpext float %0 to double
  ret double %2
}

define signext i8 @ll2c(i64) #0 {
; CHECK-LABEL: ll2c:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sll %s34, %s0, 56
; CHECK-NEXT:    sra.l %s0, %s34, 56
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i64 %0 to i8
  ret i8 %2
}

define zeroext i8 @ll2uc(i64) #0 {
; CHECK-LABEL: ll2uc:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (56)0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i64 %0 to i8
  ret i8 %2
}

define signext i16 @ll2s(i64) #0 {
; CHECK-LABEL: ll2s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sll %s34, %s0, 48
; CHECK-NEXT:    sra.l %s0, %s34, 48
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i64 %0 to i16
  ret i16 %2
}

define zeroext i16 @ll2us(i64) #0 {
; CHECK-LABEL: ll2us:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (48)0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i64 %0 to i16
  ret i16 %2
}

define i32 @ll2i(i64) #0 {
; CHECK-LABEL: ll2i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i64 %0 to i32
  ret i32 %2
}

define i32 @ll2ui(i64) #0 {
; CHECK-LABEL: ll2ui:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT TODO:    and %s0, %s0, (32)0
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i64 %0 to i32
  ret i32 %2
}

define i64 @ll2ll(i64 returned) #0 {
; CHECK-LABEL: ll2ll:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret i64 %0
}

define i64 @ll2ull(i64 returned) #0 {
; CHECK-LABEL: ll2ull:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret i64 %0
}

define float @ll2f(i64) #0 {
; CHECK-LABEL: ll2f:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.l %s34, %s0
; CHECK-NEXT:    cvt.s.d %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sitofp i64 %0 to float
  ret float %2
}

define double @ll2d(i64) #0 {
; CHECK-LABEL: ll2d:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.l %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sitofp i64 %0 to double
  ret double %2
}

define signext i8 @ull2c(i64) #0 {
; CHECK-LABEL: ull2c:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sll %s34, %s0, 56
; CHECK-NEXT:    sra.l %s0, %s34, 56
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i64 %0 to i8
  ret i8 %2
}

define zeroext i8 @ull2uc(i64) #0 {
; CHECK-LABEL: ull2uc:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (56)0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i64 %0 to i8
  ret i8 %2
}

define signext i16 @ull2s(i64) #0 {
; CHECK-LABEL: ull2s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sll %s34, %s0, 48
; CHECK-NEXT:    sra.l %s0, %s34, 48
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i64 %0 to i16
  ret i16 %2
}

define zeroext i16 @ull2us(i64) #0 {
; CHECK-LABEL: ull2us:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (48)0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i64 %0 to i16
  ret i16 %2
}

define i32 @ull2i(i64) #0 {
; CHECK-LABEL: ull2i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i64 %0 to i32
  ret i32 %2
}

define i32 @ull2ui(i64) #0 {
; CHECK-LABEL: ull2ui:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT TODO:    and %s0, %s0, (32)0
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i64 %0 to i32
  ret i32 %2
}

define i64 @ull2ll(i64 returned) #0 {
; CHECK-LABEL: ull2ll:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret i64 %0
}

define i64 @ull2ull(i64 returned) #0 {
; CHECK-LABEL: ull2ull:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret i64 %0
}

define float @ull2f(i64) #0 {
; CHECK-LABEL: ull2f:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.l %s34, %s0
; CHECK-NEXT:    cvt.s.d %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = uitofp i64 %0 to float
  ret float %2
}

define double @ull2d(i64) #0 {
; CHECK-LABEL: ull2d:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.l %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = uitofp i64 %0 to double
  ret double %2
}

define signext i8 @i2c(i32) #0 {
; CHECK-LABEL: i2c:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s34, %s0, 24
; CHECK-NEXT:    sra.w.sx %s0, %s34, 24
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i32 %0 to i8
  ret i8 %2
}

define zeroext i8 @i2uc(i32) #0 {
; CHECK-LABEL: i2uc:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (56)0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i32 %0 to i8
  ret i8 %2
}

define signext i16 @i2s(i32) #0 {
; CHECK-LABEL: i2s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s34, %s0, 16
; CHECK-NEXT:    sra.w.sx %s0, %s34, 16
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i32 %0 to i16
  ret i16 %2
}

define zeroext i16 @i2us(i32) #0 {
; CHECK-LABEL: i2us:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (48)0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i32 %0 to i16
  ret i16 %2
}

define i32 @i2i(i32 returned) #0 {
; CHECK-LABEL: i2i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret i32 %0
}

define i32 @i2ui(i32 returned) #0 {
; CHECK-LABEL: i2ui:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret i32 %0
}

define i64 @i2ll(i32) #0 {
; CHECK-LABEL: i2ll:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i32 %0 to i64
  ret i64 %2
}

define i64 @i2ull(i32) #0 {
; CHECK-LABEL: i2ull:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i32 %0 to i64
  ret i64 %2
}

define float @i2f(i32) #0 {
; CHECK-LABEL: i2f:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.s.w %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sitofp i32 %0 to float
  ret float %2
}

define double @i2d(i32) #0 {
; CHECK-LABEL: i2d:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.w %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sitofp i32 %0 to double
  ret double %2
}

define signext i8 @ui2c(i32) #0 {
; CHECK-LABEL: ui2c:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s34, %s0, 24
; CHECK-NEXT:    sra.w.sx %s0, %s34, 24
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i32 %0 to i8
  ret i8 %2
}

define zeroext i8 @ui2uc(i32) #0 {
; CHECK-LABEL: ui2uc:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (56)0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i32 %0 to i8
  ret i8 %2
}

define signext i16 @ui2s(i32) #0 {
; CHECK-LABEL: ui2s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s34, %s0, 16
; CHECK-NEXT:    sra.w.sx %s0, %s34, 16
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i32 %0 to i16
  ret i16 %2
}

define zeroext i16 @ui2us(i32) #0 {
; CHECK-LABEL: ui2us:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (48)0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i32 %0 to i16
  ret i16 %2
}

define i32 @ui2i(i32 returned) #0 {
; CHECK-LABEL: ui2i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret i32 %0
}

define i32 @ui2ui(i32 returned) #0 {
; CHECK-LABEL: ui2ui:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret i32 %0
}

define i64 @ui2ll(i32) #0 {
; CHECK-LABEL: ui2ll:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i32 %0 to i64
  ret i64 %2
}

define i64 @ui2ull(i32) #0 {
; CHECK-LABEL: ui2ull:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i32 %0 to i64
  ret i64 %2
}

define float @ui2f(i32) #0 {
; CHECK-LABEL: ui2f:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    and %s34, %s0, (32)0
; CHECK-NEXT:    cvt.d.l %s34, %s34
; CHECK-NEXT:    cvt.s.d %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = uitofp i32 %0 to float
  ret float %2
}

define double @ui2d(i32) #0 {
; CHECK-LABEL: ui2d:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    and %s34, %s0, (32)0
; CHECK-NEXT:    cvt.d.l %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = uitofp i32 %0 to double
  ret double %2
}

define signext i8 @s2c(i16 signext) #0 {
; CHECK-LABEL: s2c:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s34, %s0, 24
; CHECK-NEXT:    sra.w.sx %s0, %s34, 24
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i16 %0 to i8
  ret i8 %2
}

define zeroext i8 @s2uc(i16 signext) #0 {
; CHECK-LABEL: s2uc:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (56)0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i16 %0 to i8
  ret i8 %2
}

define signext i16 @s2s(i16 returned signext) #0 {
; CHECK-LABEL: s2s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret i16 %0
}

define zeroext i16 @s2us(i16 returned signext) #0 {
; CHECK-LABEL: s2us:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (48)0
; CHECK-NEXT:    or %s11, 0, %s9
  ret i16 %0
}

define i32 @s2i(i16 signext) #0 {
; CHECK-LABEL: s2i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i16 %0 to i32
  ret i32 %2
}

define i32 @s2ui(i16 signext) #0 {
; CHECK-LABEL: s2ui:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT TODO:    and %s0, %s0, (32)0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i16 %0 to i32
  ret i32 %2
}

define i64 @s2ll(i16 signext) #0 {
; CHECK-LABEL: s2ll:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i16 %0 to i64
  ret i64 %2
}

define i64 @s2ull(i16 signext) #0 {
; CHECK-LABEL: s2ull:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i16 %0 to i64
  ret i64 %2
}

define float @s2f(i16 signext) #0 {
; CHECK-LABEL: s2f:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.s.w %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sitofp i16 %0 to float
  ret float %2
}

define double @s2d(i16 signext) #0 {
; CHECK-LABEL: s2d:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.w %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sitofp i16 %0 to double
  ret double %2
}

define signext i8 @us2c(i16 zeroext) #0 {
; CHECK-LABEL: us2c:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s34, %s0, 24
; CHECK-NEXT:    sra.w.sx %s0, %s34, 24
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i16 %0 to i8
  ret i8 %2
}

define zeroext i8 @us2uc(i16 zeroext) #0 {
; CHECK-LABEL: us2uc:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (56)0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = trunc i16 %0 to i8
  ret i8 %2
}

define signext i16 @us2s(i16 returned zeroext) #0 {
; CHECK-LABEL: us2s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s34, %s0, 16
; CHECK-NEXT:    sra.w.sx %s0, %s34, 16
; CHECK-NEXT:    or %s11, 0, %s9
  ret i16 %0
}

define zeroext i16 @us2us(i16 returned zeroext) #0 {
; CHECK-LABEL: us2us:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret i16 %0
}

define i32 @us2i(i16 zeroext) #0 {
; CHECK-LABEL: us2i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i16 %0 to i32
  ret i32 %2
}

define i32 @us2ui(i16 zeroext) #0 {
; CHECK-LABEL: us2ui:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i16 %0 to i32
  ret i32 %2
}

define i64 @us2ll(i16 zeroext) #0 {
; CHECK-LABEL: us2ll:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i16 %0 to i64
  ret i64 %2
}

define i64 @us2ull(i16 zeroext) #0 {
; CHECK-LABEL: us2ull:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i16 %0 to i64
  ret i64 %2
}

define float @us2f(i16 zeroext) #0 {
; CHECK-LABEL: us2f:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    and %s34, %s0, (32)0
; CHECK-NEXT:    cvt.d.l %s34, %s34
; CHECK-NEXT:    cvt.s.d %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = uitofp i16 %0 to float
  ret float %2
}

define double @us2d(i16 zeroext) #0 {
; CHECK-LABEL: us2d:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    and %s34, %s0, (32)0
; CHECK-NEXT:    cvt.d.l %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = uitofp i16 %0 to double
  ret double %2
}

define signext i8 @c2c(i8 returned signext) #0 {
; CHECK-LABEL: c2c:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret i8 %0
}

define zeroext i8 @c2uc(i8 returned signext) #0 {
; CHECK-LABEL: c2uc:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (56)0
; CHECK-NEXT:    or %s11, 0, %s9
  ret i8 %0
}

define signext i16 @c2s(i8 signext) #0 {
; CHECK-LABEL: c2s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i8 %0 to i16
  ret i16 %2
}

define zeroext i16 @c2us(i8 signext) #0 {
; CHECK-LABEL: c2us:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, %s0, (48)0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i8 %0 to i16
  ret i16 %2
}

define i32 @c2i(i8 signext) #0 {
; CHECK-LABEL: c2i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i8 %0 to i32
  ret i32 %2
}

define i32 @c2ui(i8 signext) #0 {
; CHECK-LABEL: c2ui:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i8 %0 to i32
  ret i32 %2
}

define i64 @c2ll(i8 signext) #0 {
; CHECK-LABEL: c2ll:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i8 %0 to i64
  ret i64 %2
}

define i64 @c2ull(i8 signext) #0 {
; CHECK-LABEL: c2ull:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sext i8 %0 to i64
  ret i64 %2
}

define float @c2f(i8 signext) #0 {
; CHECK-LABEL: c2f:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.s.w %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sitofp i8 %0 to float
  ret float %2
}

define double @c2d(i8 signext) #0 {
; CHECK-LABEL: c2d:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.w %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sitofp i8 %0 to double
  ret double %2
}

define signext i8 @uc2c(i8 returned zeroext) #0 {
; CHECK-LABEL: uc2c:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s34, %s0, 24
; CHECK-NEXT:    sra.w.sx %s0, %s34, 24
; CHECK-NEXT:    or %s11, 0, %s9
  ret i8 %0
}

define zeroext i8 @uc2uc(i8 returned zeroext) #0 {
; CHECK-LABEL: uc2uc:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  ret i8 %0
}

define signext i16 @uc2s(i8 zeroext) #0 {
; CHECK-LABEL: uc2s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i8 %0 to i16
  ret i16 %2
}

define zeroext i16 @uc2us(i8 zeroext) #0 {
; CHECK-LABEL: uc2us:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i8 %0 to i16
  ret i16 %2
}

define i32 @uc2i(i8 zeroext) #0 {
; CHECK-LABEL: uc2i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i8 %0 to i32
  ret i32 %2
}

define i32 @uc2ui(i8 zeroext) #0 {
; CHECK-LABEL: uc2ui:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i8 %0 to i32
  ret i32 %2
}

define i64 @uc2ll(i8 zeroext) #0 {
; CHECK-LABEL: uc2ll:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i8 %0 to i64
  ret i64 %2
}

define i64 @uc2ull(i8 zeroext) #0 {
; CHECK-LABEL: uc2ull:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = zext i8 %0 to i64
  ret i64 %2
}

define float @uc2f(i8 zeroext) #0 {
; CHECK-LABEL: uc2f:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    and %s34, %s0, (32)0
; CHECK-NEXT:    cvt.d.l %s34, %s34
; CHECK-NEXT:    cvt.s.d %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = uitofp i8 %0 to float
  ret float %2
}

define double @uc2d(i8 zeroext) #0 {
; CHECK-LABEL: uc2d:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    and %s34, %s0, (32)0
; CHECK-NEXT:    cvt.d.l %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = uitofp i8 %0 to double
  ret double %2
}
