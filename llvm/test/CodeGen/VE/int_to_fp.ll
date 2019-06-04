; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define float @c2f(i8 signext %a) {
; CHECK-LABEL: c2f
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.s.w %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = sitofp i8 %a to float
  ret float %conv
}

; Function Attrs: norecurse nounwind readnone
define float @s2f(i16 signext %a) {
; CHECK-LABEL: s2f
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.s.w %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = sitofp i16 %a to float
  ret float %conv
}

; Function Attrs: norecurse nounwind readnone
define float @i2f(i32 %a) {
; CHECK-LABEL: i2f
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.s.w %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = sitofp i32 %a to float
  ret float %conv
}

; Function Attrs: norecurse nounwind readnone
define float @l2f(i64 %a) {
; CHECK-LABEL: l2f
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.l %s34, %s0
; CHECK-NEXT:  cvt.s.d %s0, %s34
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = sitofp i64 %a to float
  ret float %conv
}

; Function Attrs: norecurse nounwind readnone
define float @i1282f(i128) {
; CHECK-LABEL: i1282f
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:    lea %s34, __floattisf@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __floattisf@hi(%s34)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sitofp i128 %0 to float
  ret float %2
}

; Function Attrs: norecurse nounwind readnone
define float @uc2f(i8 zeroext %a) {
; CHECK-LABEL: uc2f
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.s.w %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = uitofp i8 %a to float
  ret float %conv
}

; Function Attrs: norecurse nounwind readnone
define float @us2f(i16 zeroext %a) {
; CHECK-LABEL: us2f
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.s.w %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = uitofp i16 %a to float
  ret float %conv
}

; Function Attrs: norecurse nounwind readnone
define float @ui2f(i32 %a) {
; CHECK-LABEL: ui2f
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  adds.w.zx %s34, %s0, (0)1
; CHECK-NEXT:  cvt.d.l %s34, %s34
; CHECK-NEXT:  cvt.s.d %s0, %s34
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = uitofp i32 %a to float
  ret float %conv
}

; Function Attrs: norecurse nounwind readnone
define float @ul2f(i64 %a) {
; CHECK-LABEL: ul2f
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  or %s34, 0, (0)1
; CHECK-NEXT:  cmps.l %s35, %s0, %s34
; CHECK-NEXT:  cvt.d.l %s34, %s0
; CHECK-NEXT:  cvt.s.d %s34, %s34
; CHECK-NEXT:  srl %s36, %s0, 1
; CHECK-NEXT:  and %s37, 1, %s0
; CHECK-NEXT:  or %s36, %s37, %s36
; CHECK-NEXT:  cvt.d.l %s36, %s36
; CHECK-NEXT:  cvt.s.d %s36, %s36
; CHECK-NEXT:  fadd.s %s36, %s36, %s36
; CHECK-NEXT:  cmov.l.lt %s34, %s36, %s35
; CHECK-NEXT:  or %s0, 0, %s34
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = uitofp i64 %a to float
  ret float %conv
}

; Function Attrs: norecurse nounwind readnone
define float @ui1282f(i128) {
; CHECK-LABEL: ui1282f
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:    lea %s34, __floatuntisf@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __floatuntisf@hi(%s34)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = uitofp i128 %0 to float
  ret float %2
}

; Function Attrs: norecurse nounwind readnone
define double @c2d(i8 signext %a) {
; CHECK-LABEL: c2d
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.w %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = sitofp i8 %a to double
  ret double %conv
}

; Function Attrs: norecurse nounwind readnone
define double @s2d(i16 signext %a) {
; CHECK-LABEL: s2d
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.w %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = sitofp i16 %a to double
  ret double %conv
}

; Function Attrs: norecurse nounwind readnone
define double @i2d(i32 %a) {
; CHECK-LABEL: i2d
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.w %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = sitofp i32 %a to double
  ret double %conv
}

; Function Attrs: norecurse nounwind readnone
define double @l2d(i64 %a) {
; CHECK-LABEL: l2d
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.l %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = sitofp i64 %a to double
  ret double %conv
}

; Function Attrs: norecurse nounwind readnone
define double @i1282d(i128) {
; CHECK-LABEL: i1282d
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:    lea %s34, __floattidf@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __floattidf@hi(%s34)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sitofp i128 %0 to double
  ret double %2
}

; Function Attrs: norecurse nounwind readnone
define double @uc2d(i8 zeroext %a) {
; CHECK-LABEL: uc2d
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.w %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = uitofp i8 %a to double
  ret double %conv
}

; Function Attrs: norecurse nounwind readnone
define double @us2d(i16 zeroext %a) {
; CHECK-LABEL: us2d
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.w %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = uitofp i16 %a to double
  ret double %conv
}

; Function Attrs: norecurse nounwind readnone
define double @ui2d(i32 %a) {
; CHECK-LABEL: ui2d
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  adds.w.zx %s34, %s0, (0)1
; CHECK-NEXT:  cvt.d.l %s0, %s34
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = uitofp i32 %a to double
  ret double %conv
}

; Function Attrs: norecurse nounwind readnone
define double @ul2d(i64 %a) {
; CHECK-LABEL: ul2d
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  srl %s34, %s0, 32
; CHECK-NEXT:  lea.sl %s35, 1160773632
; CHECK-NEXT:  or %s34, %s34, %s35
; CHECK-NEXT:  lea %s35, 1048576
; CHECK-NEXT:  lea.sl %s35, -986710016(%s35)
; CHECK-NEXT:  fadd.d %s34, %s34, %s35
; CHECK-NEXT:  lea %s35, -1
; CHECK-NEXT:  and %s35, %s35, (32)0
; CHECK-NEXT:  and %s35, %s0, %s35
; CHECK-NEXT:  lea.sl %s36, 1127219200
; CHECK-NEXT:  or %s35, %s35, %s36
; CHECK-NEXT:  fadd.d %s0, %s35, %s34
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = uitofp i64 %a to double
  ret double %conv
}

; Function Attrs: norecurse nounwind readnone
define double @ui1282d(i128) {
; CHECK-LABEL: ui1282d
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:    lea %s34, __floatuntidf@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __floatuntidf@hi(%s34)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = uitofp i128 %0 to double
  ret double %2
}

; Function Attrs: norecurse nounwind readnone
define fp128 @c2q(i8 signext %a) {
; CHECK-LABEL: c2q
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.w %s34, %s0
; CHECK-NEXT:  cvt.q.d %s0, %s34
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = sitofp i8 %a to fp128
  ret fp128 %conv
}

; Function Attrs: norecurse nounwind readnone
define fp128 @s2q(i16 signext %a) {
; CHECK-LABEL: s2q
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.w %s34, %s0
; CHECK-NEXT:  cvt.q.d %s0, %s34
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = sitofp i16 %a to fp128
  ret fp128 %conv
}

; Function Attrs: norecurse nounwind readnone
define fp128 @i2q(i32 %a) {
; CHECK-LABEL: i2q
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.w %s34, %s0
; CHECK-NEXT:  cvt.q.d %s0, %s34
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = sitofp i32 %a to fp128
  ret fp128 %conv
}

; Function Attrs: norecurse nounwind readnone
define fp128 @l2q(i64 %a) {
; CHECK-LABEL: l2q
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.l %s34, %s0
; CHECK-NEXT:  cvt.q.d %s0, %s34
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = sitofp i64 %a to fp128
  ret fp128 %conv
}

; Function Attrs: norecurse nounwind readnone
define fp128 @i1282q(i128) {
; CHECK-LABEL: i1282q
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:    lea %s34, __floattitf@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __floattitf@hi(%s34)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = sitofp i128 %0 to fp128
  ret fp128 %2
}

; Function Attrs: norecurse nounwind readnone
define fp128 @uc2q(i8 zeroext %a) {
; CHECK-LABEL: uc2q
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.w %s34, %s0
; CHECK-NEXT:  cvt.q.d %s0, %s34
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = uitofp i8 %a to fp128
  ret fp128 %conv
}

; Function Attrs: norecurse nounwind readnone
define fp128 @us2q(i16 zeroext %a) {
; CHECK-LABEL: us2q
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.w %s34, %s0
; CHECK-NEXT:  cvt.q.d %s0, %s34
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = uitofp i16 %a to fp128
  ret fp128 %conv
}

; Function Attrs: norecurse nounwind readnone
define fp128 @ui2q(i32 %a) {
; CHECK-LABEL: ui2q
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  adds.w.zx %s34, %s0, (0)1
; CHECK-NEXT:  cvt.d.l %s34, %s34
; CHECK-NEXT:  cvt.q.d %s0, %s34
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = uitofp i32 %a to fp128
  ret fp128 %conv
}

; Function Attrs: norecurse nounwind readnone
define fp128 @ul2q(i64 %a) {
; CHECK-LABEL: ul2q
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  srl %s34, %s0, 61
; CHECK-NEXT:  and %s34, 4, %s34
; CHECK-NEXT:  lea %s35, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:  and %s35, %s35, (32)0
; CHECK-NEXT:  lea.sl %s35, .LCPI{{[0-9]+}}_0@hi(%s35)
; CHECK-NEXT:  adds.l %s34, %s35, %s34
; CHECK-NEXT:  ldu %s34, (,%s34)
; CHECK-NEXT:  cvt.q.s %s34, %s34
; CHECK-NEXT:  cvt.d.l %s36, %s0
; CHECK-NEXT:  cvt.q.d %s36, %s36
; CHECK-NEXT:  fadd.q %s0, %s36, %s34
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = uitofp i64 %a to fp128
  ret fp128 %conv
}

; Function Attrs: norecurse nounwind readnone
define fp128 @ui1282q(i128) {
; CHECK-LABEL: ui1282q
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:    lea %s34, __floatuntitf@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __floatuntitf@hi(%s34)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = uitofp i128 %0 to fp128
  ret fp128 %2
}

