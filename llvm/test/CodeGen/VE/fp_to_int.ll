; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define signext i8 @f2c(float %a) {
; CHECK-LABEL: f2c
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.w.s.sx.rz %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptosi float %a to i8
  ret i8 %conv
}

; Function Attrs: norecurse nounwind readnone
define signext i16 @f2s(float %a) {
; CHECK-LABEL: f2s
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.w.s.sx.rz %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptosi float %a to i16
  ret i16 %conv
}

; Function Attrs: norecurse nounwind readnone
define i32 @f2i(float %a) {
; CHECK-LABEL: f2i
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.w.s.sx.rz %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptosi float %a to i32
  ret i32 %conv
}

; Function Attrs: norecurse nounwind readnone
define i64 @f2l(float %a) {
; CHECK-LABEL: f2l
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.s %s34, %s0
; CHECK-NEXT:  cvt.l.d.rz %s0, %s34
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptosi float %a to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind readnone
define i128 @f2i128(float) {
; CHECK-LABEL: f2i128
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:    lea %s34, __fixsfti@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __fixsfti@hi(%s34)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptosi float %0 to i128
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define zeroext i8 @f2uc(float %a) {
; CHECK-LABEL: f2uc
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.w.s.sx.rz %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptoui float %a to i8
  ret i8 %conv
}

; Function Attrs: norecurse nounwind readnone
define zeroext i16 @f2us(float %a) {
; CHECK-LABEL: f2us
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.w.s.sx.rz %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptoui float %a to i16
  ret i16 %conv
}

; Function Attrs: norecurse nounwind readnone
define i32 @f2ui(float %a) {
; CHECK-LABEL: f2ui
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.s %s34, %s0
; CHECK-NEXT:  cvt.l.d.rz %s34, %s34
; CHECK-NEXT:  adds.w.sx %s0, %s34, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptoui float %a to i32
  ret i32 %conv
}

; Function Attrs: norecurse nounwind readnone
define i64 @f2ul(float %a) {
; CHECK-LABEL: f2ul
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  lea %s34, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, .LCPI{{[0-9]+}}_0@hi(%s34)
; CHECK-NEXT:  ldu %s34, (,%s34)
; CHECK-NEXT:  fcmp.s %s35, %s0, %s34
; CHECK-NEXT:  fsub.s %s34, %s0, %s34
; CHECK-NEXT:  cvt.d.s %s34, %s34
; CHECK-NEXT:  cvt.l.d.rz %s34, %s34
; CHECK-NEXT:  lea %s36, 0
; CHECK-NEXT:  and %s36, %s36, (32)0
; CHECK-NEXT:  lea.sl %s36, -2147483648(%s36)
; CHECK-NEXT:  xor %s34, %s34, %s36
; CHECK-NEXT:  cvt.d.s %s36, %s0
; CHECK-NEXT:  cvt.l.d.rz %s36, %s36
; CHECK-NEXT:  cmov.s.lt %s34, %s36, %s35
; CHECK-NEXT:  or %s0, 0, %s34
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptoui float %a to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind readnone
define i128 @f2ui128(float) {
; CHECK-LABEL: f2ui128
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:    lea %s34, __fixunssfti@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __fixunssfti@hi(%s34)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptoui float %0 to i128
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define signext i8 @d2c(double %a) {
; CHECK-LABEL: d2c
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.w.d.sx.rz %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptosi double %a to i8
  ret i8 %conv
}

; Function Attrs: norecurse nounwind readnone
define signext i16 @d2s(double %a) {
; CHECK-LABEL: d2s
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.w.d.sx.rz %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptosi double %a to i16
  ret i16 %conv
}

; Function Attrs: norecurse nounwind readnone
define i32 @d2i(double %a) {
; CHECK-LABEL: d2i
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.w.d.sx.rz %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptosi double %a to i32
  ret i32 %conv
}

; Function Attrs: norecurse nounwind readnone
define i64 @d2l(double %a) {
; CHECK-LABEL: d2l
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.l.d.rz %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptosi double %a to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind readnone
define i128 @d2i128(double) {
; CHECK-LABEL: d2i128
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:    lea %s34, __fixdfti@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __fixdfti@hi(%s34)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptosi double %0 to i128
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define zeroext i8 @d2uc(double %a) {
; CHECK-LABEL: d2uc
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.w.d.sx.rz %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptoui double %a to i8
  ret i8 %conv
}

; Function Attrs: norecurse nounwind readnone
define zeroext i16 @d2us(double %a) {
; CHECK-LABEL: d2us
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.w.d.sx.rz %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptoui double %a to i16
  ret i16 %conv
}

; Function Attrs: norecurse nounwind readnone
define i32 @d2ui(double %a) {
; CHECK-LABEL: d2ui
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.l.d.rz %s34, %s0
; CHECK-NEXT:  adds.w.sx %s0, %s34, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptoui double %a to i32
  ret i32 %conv
}

; Function Attrs: norecurse nounwind readnone
define i64 @d2ul(double %a) {
; CHECK-LABEL: d2ul
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  lea %s34, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, .LCPI{{[0-9]+}}_0@hi(%s34)
; CHECK-NEXT:  ld %s34, (,%s34)
; CHECK-NEXT:  fcmp.d %s35, %s0, %s34
; CHECK-NEXT:  fsub.d %s34, %s0, %s34
; CHECK-NEXT:  cvt.l.d.rz %s34, %s34
; CHECK-NEXT:  lea %s36, 0
; CHECK-NEXT:  and %s36, %s36, (32)0
; CHECK-NEXT:  lea.sl %s36, -2147483648(%s36)
; CHECK-NEXT:  xor %s34, %s34, %s36
; CHECK-NEXT:  cvt.l.d.rz %s36, %s0
; CHECK-NEXT:  cmov.d.lt %s34, %s36, %s35
; CHECK-NEXT:  or %s0, 0, %s34
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptoui double %a to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind readnone
define i128 @d2ui128(double) {
; CHECK-LABEL: d2ui128
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:    lea %s34, __fixunsdfti@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __fixunsdfti@hi(%s34)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptoui double %0 to i128
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define signext i8 @q2c(fp128 %a) {
; CHECK-LABEL: q2c
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.q %s34, %s0
; CHECK-NEXT:  cvt.w.d.sx.rz %s0, %s34
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptosi fp128 %a to i8
  ret i8 %conv
}

; Function Attrs: norecurse nounwind readnone
define signext i16 @q2s(fp128 %a) {
; CHECK-LABEL: q2s
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.q %s34, %s0
; CHECK-NEXT:  cvt.w.d.sx.rz %s0, %s34
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptosi fp128 %a to i16
  ret i16 %conv
}

; Function Attrs: norecurse nounwind readnone
define i32 @q2i(fp128 %a) {
; CHECK-LABEL: q2i
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.q %s34, %s0
; CHECK-NEXT:  cvt.w.d.sx.rz %s0, %s34
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptosi fp128 %a to i32
  ret i32 %conv
}

; Function Attrs: norecurse nounwind readnone
define i64 @q2l(fp128 %a) {
; CHECK-LABEL: q2l
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.q %s34, %s0
; CHECK-NEXT:  cvt.l.d.rz %s0, %s34
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptosi fp128 %a to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind readnone
define i128 @q2i128(fp128) {
; CHECK-LABEL: q2i128
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:    lea %s34, __fixtfti@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __fixtfti@hi(%s34)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptosi fp128 %0 to i128
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define zeroext i8 @q2uc(fp128 %a) {
; CHECK-LABEL: q2uc
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.q %s34, %s0
; CHECK-NEXT:  cvt.w.d.sx.rz %s0, %s34
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptoui fp128 %a to i8
  ret i8 %conv
}

; Function Attrs: norecurse nounwind readnone
define zeroext i16 @q2us(fp128 %a) {
; CHECK-LABEL: q2us
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.q %s34, %s0
; CHECK-NEXT:  cvt.w.d.sx.rz %s0, %s34
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptoui fp128 %a to i16
  ret i16 %conv
}

; Function Attrs: norecurse nounwind readnone
define i32 @q2ui(fp128 %a) {
; CHECK-LABEL: q2ui
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.q %s34, %s0
; CHECK-NEXT:  cvt.l.d.rz %s34, %s34
; CHECK-NEXT:  adds.w.sx %s0, %s34, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptoui fp128 %a to i32
  ret i32 %conv
}

; Function Attrs: norecurse nounwind readnone
define i64 @q2ul(fp128 %a) {
; CHECK-LABEL: q2ul
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  lea %s34, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, .LCPI{{[0-9]+}}_0@hi(%s34)
; CHECK-NEXT:  ld %s36, 8(,%s34)
; CHECK-NEXT:  ld %s37, (,%s34)
; CHECK-NEXT:  fcmp.q %s35, %s0, %s36
; CHECK-NEXT:  fsub.q %s36, %s0, %s36
; CHECK-NEXT:  cvt.d.q %s34, %s36
; CHECK-NEXT:  cvt.l.d.rz %s34, %s34
; CHECK-NEXT:  lea %s36, 0
; CHECK-NEXT:  and %s36, %s36, (32)0
; CHECK-NEXT:  lea.sl %s36, -2147483648(%s36)
; CHECK-NEXT:  xor %s34, %s34, %s36
; CHECK-NEXT:  cvt.d.q %s36, %s0
; CHECK-NEXT:  cvt.l.d.rz %s36, %s36
; CHECK-NEXT:  cmov.d.lt %s34, %s36, %s35
; CHECK-NEXT:  or %s0, 0, %s34
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptoui fp128 %a to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind readnone
define i128 @q2ui128(fp128) {
; CHECK-LABEL: q2ui128
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:    lea %s34, __fixunstfti@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __fixunstfti@hi(%s34)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = fptoui fp128 %0 to i128
  ret i128 %2
}

