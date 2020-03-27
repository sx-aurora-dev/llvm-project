; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define signext i8 @f2c(float %a) {
; CHECK-LABEL: f2c:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.w.s.sx.rz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %conv = fptosi float %a to i8
  ret i8 %conv
}

; Function Attrs: norecurse nounwind readnone
define signext i16 @f2s(float %a) {
; CHECK-LABEL: f2s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.w.s.sx.rz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %conv = fptosi float %a to i16
  ret i16 %conv
}

; Function Attrs: norecurse nounwind readnone
define i32 @f2i(float %a) {
; CHECK-LABEL: f2i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.w.s.sx.rz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %conv = fptosi float %a to i32
  ret i32 %conv
}

; Function Attrs: norecurse nounwind readnone
define i64 @f2l(float %a) {
; CHECK-LABEL: f2l:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.s %s0, %s0
; CHECK-NEXT:    cvt.l.d.rz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %conv = fptosi float %a to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind readnone
define i128 @f2i128(float %a) {
; CHECK-LABEL: f2i128
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:    lea %s1, __fixsfti@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, __fixsfti@hi(, %s1)
; CHECK-NEXT:    bsic %lr, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %conv = fptosi float %a to i128
  ret i128 %conv
}

; Function Attrs: norecurse nounwind readnone
define zeroext i8 @f2uc(float %a) {
; CHECK-LABEL: f2uc:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.w.s.sx.rz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %conv = fptoui float %a to i8
  ret i8 %conv
}

; Function Attrs: norecurse nounwind readnone
define zeroext i16 @f2us(float %a) {
; CHECK-LABEL: f2us:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.w.s.sx.rz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %conv = fptoui float %a to i16
  ret i16 %conv
}

; Function Attrs: norecurse nounwind readnone
define i32 @f2ui(float %a) {
; CHECK-LABEL: f2ui:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.d.s %s0, %s0
; CHECK-NEXT:    cvt.l.d.rz %s0, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %conv = fptoui float %a to i32
  ret i32 %conv
}

; Function Attrs: norecurse nounwind readnone
define i64 @f2ul(float %a) {
; CHECK-LABEL: f2ul:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s1, 1593835520
; CHECK-NEXT:    or %s1, 0, %s1
; CHECK-NEXT:    fcmp.s %s2, %s0, %s1
; CHECK-NEXT:    fsub.s %s1, %s0, %s1
; CHECK-NEXT:    cvt.d.s %s1, %s1
; CHECK-NEXT:    cvt.l.d.rz %s1, %s1
; CHECK-NEXT:    lea.sl %s3, -2147483648
; CHECK-NEXT:    xor %s1, %s1, %s3
; CHECK-NEXT:    cvt.d.s %s0, %s0
; CHECK-NEXT:    cvt.l.d.rz %s0, %s0
; CHECK-NEXT:    cmov.s.lt %s1, %s0, %s2
; CHECK-NEXT:    or %s0, 0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %conv = fptoui float %a to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind readnone
define i128 @f2ui128(float %a) {
; CHECK-LABEL: f2ui128
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:    lea %s1, __fixunssfti@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, __fixunssfti@hi(, %s1)
; CHECK-NEXT:    bsic %lr, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %conv = fptoui float %a to i128
  ret i128 %conv
}

; Function Attrs: norecurse nounwind readnone
define signext i8 @d2c(double %a) {
; CHECK-LABEL: d2c:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.w.d.sx.rz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %conv = fptosi double %a to i8
  ret i8 %conv
}

; Function Attrs: norecurse nounwind readnone
define signext i16 @d2s(double %a) {
; CHECK-LABEL: d2s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.w.d.sx.rz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %conv = fptosi double %a to i16
  ret i16 %conv
}

; Function Attrs: norecurse nounwind readnone
define i32 @d2i(double %a) {
; CHECK-LABEL: d2i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.w.d.sx.rz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %conv = fptosi double %a to i32
  ret i32 %conv
}

; Function Attrs: norecurse nounwind readnone
define i64 @d2l(double %a) {
; CHECK-LABEL: d2l:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.l.d.rz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %conv = fptosi double %a to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind readnone
define i128 @d2i128(double %a) {
; CHECK-LABEL: d2i128
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:    lea %s1, __fixdfti@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, __fixdfti@hi(, %s1)
; CHECK-NEXT:    bsic %lr, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %conv = fptosi double %a to i128
  ret i128 %conv
}

; Function Attrs: norecurse nounwind readnone
define zeroext i8 @d2uc(double %a) {
; CHECK-LABEL: d2uc:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.w.d.sx.rz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %conv = fptoui double %a to i8
  ret i8 %conv
}

; Function Attrs: norecurse nounwind readnone
define zeroext i16 @d2us(double %a) {
; CHECK-LABEL: d2us:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.w.d.sx.rz %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %conv = fptoui double %a to i16
  ret i16 %conv
}

; Function Attrs: norecurse nounwind readnone
define i32 @d2ui(double %a) {
; CHECK-LABEL: d2ui:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cvt.l.d.rz %s0, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %conv = fptoui double %a to i32
  ret i32 %conv
}

; Function Attrs: norecurse nounwind readnone
define i64 @d2ul(double %a) {
; CHECK-LABEL: d2ul:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s1, 1138753536
; CHECK-NEXT:    fcmp.d %s2, %s0, %s1
; CHECK-NEXT:    fsub.d %s1, %s0, %s1
; CHECK-NEXT:    cvt.l.d.rz %s1, %s1
; CHECK-NEXT:    lea.sl %s3, -2147483648
; CHECK-NEXT:    xor %s1, %s1, %s3
; CHECK-NEXT:    cvt.l.d.rz %s0, %s0
; CHECK-NEXT:    cmov.d.lt %s1, %s0, %s2
; CHECK-NEXT:    or %s0, 0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %conv = fptoui double %a to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind readnone
define i128 @d2ui128(double %a) {
; CHECK-LABEL: d2ui128
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:    lea %s1, __fixunsdfti@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s12, __fixunsdfti@hi(, %s1)
; CHECK-NEXT:    bsic %lr, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %conv = fptoui double %a to i128
  ret i128 %conv
}

; Function Attrs: norecurse nounwind readnone
define signext i8 @q2c(fp128 %a) {
; CHECK-LABEL: q2c
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.q %s0, %s0
; CHECK-NEXT:  cvt.w.d.sx.rz %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptosi fp128 %a to i8
  ret i8 %conv
}

; Function Attrs: norecurse nounwind readnone
define signext i16 @q2s(fp128 %a) {
; CHECK-LABEL: q2s
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.q %s0, %s0
; CHECK-NEXT:  cvt.w.d.sx.rz %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptosi fp128 %a to i16
  ret i16 %conv
}

; Function Attrs: norecurse nounwind readnone
define i32 @q2i(fp128 %a) {
; CHECK-LABEL: q2i
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.q %s0, %s0
; CHECK-NEXT:  cvt.w.d.sx.rz %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptosi fp128 %a to i32
  ret i32 %conv
}

; Function Attrs: norecurse nounwind readnone
define i64 @q2l(fp128 %a) {
; CHECK-LABEL: q2l
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.q %s0, %s0
; CHECK-NEXT:  cvt.l.d.rz %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptosi fp128 %a to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind readnone
define i128 @q2i128(fp128 %a) {
; CHECK-LABEL: q2i128
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:    lea %s2, __fixtfti@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, __fixtfti@hi(, %s2)
; CHECK-NEXT:    bsic %lr, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %conv = fptosi fp128 %a to i128
  ret i128 %conv
}

; Function Attrs: norecurse nounwind readnone
define zeroext i8 @q2uc(fp128 %a) {
; CHECK-LABEL: q2uc
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.q %s0, %s0
; CHECK-NEXT:  cvt.w.d.sx.rz %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptoui fp128 %a to i8
  ret i8 %conv
}

; Function Attrs: norecurse nounwind readnone
define zeroext i16 @q2us(fp128 %a) {
; CHECK-LABEL: q2us
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.q %s0, %s0
; CHECK-NEXT:  cvt.w.d.sx.rz %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptoui fp128 %a to i16
  ret i16 %conv
}

; Function Attrs: norecurse nounwind readnone
define i32 @q2ui(fp128 %a) {
; CHECK-LABEL: q2ui
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.q %s0, %s0
; CHECK-NEXT:  cvt.l.d.rz %s0, %s0
; CHECK-NEXT:  adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptoui fp128 %a to i32
  ret i32 %conv
}

; Function Attrs: norecurse nounwind readnone
define i64 @q2ul(fp128 %a) {
; CHECK-LABEL: q2ul
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  lea %s2, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:  and %s2, %s2, (32)0
; CHECK-NEXT:  lea.sl %s2, .LCPI{{[0-9]+}}_0@hi(, %s2)
; CHECK-NEXT:  ld %s4, 8(, %s2)
; CHECK-NEXT:  ld %s5, (, %s2)
; CHECK-NEXT:  fcmp.q %s3, %s0, %s4
; CHECK-NEXT:  fsub.q %s4, %s0, %s4
; CHECK-NEXT:  cvt.d.q %s2, %s4
; CHECK-NEXT:  cvt.l.d.rz %s2, %s2
; CHECK-NEXT:  lea.sl %s4, -2147483648
; CHECK-NEXT:  xor %s2, %s2, %s4
; CHECK-NEXT:  cvt.d.q %s0, %s0
; CHECK-NEXT:  cvt.l.d.rz %s0, %s0
; CHECK-NEXT:  cmov.d.lt %s2, %s0, %s3
; CHECK-NEXT:  or %s0, 0, %s2
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptoui fp128 %a to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind readnone
define i128 @q2ui128(fp128 %a) {
; CHECK-LABEL: q2ui128
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:    lea %s2, __fixunstfti@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, __fixunstfti@hi(, %s2)
; CHECK-NEXT:    bsic %lr, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %conv = fptoui fp128 %a to i128
  ret i128 %conv
}
