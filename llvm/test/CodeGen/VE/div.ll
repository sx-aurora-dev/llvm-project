; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define double @divf64(double, double) {
; CHECK-LABEL: divf64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fdiv.d %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = fdiv double %0, %1
  ret double %3
}

; Function Attrs: norecurse nounwind readnone
define float @divf32(float, float) {
; CHECK-LABEL: divf32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fdiv.s %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = fdiv float %0, %1
  ret float %3
}

define i128 @divi128(i128, i128) {
; CHECK-LABEL: divi128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, __divti3@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __divti3@hi(%s34)
; CHECK-NEXT:    bsic %lr, (,%s12)
  %3 = sdiv i128 %0, %1
  ret i128 %3
}

; Function Attrs: norecurse nounwind readnone
define i64 @divi64(i64, i64) {
; CHECK-LABEL: divi64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divs.l %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = sdiv i64 %0, %1
  ret i64 %3
}

; Function Attrs: norecurse nounwind readnone
define i32 @divi32(i32, i32) {
; CHECK-LABEL: divi32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divs.w.sx %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = sdiv i32 %0, %1
  ret i32 %3
}

define i128 @divu128(i128, i128) {
; CHECK-LABEL: divu128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, __udivti3@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __udivti3@hi(%s34)
; CHECK-NEXT:    bsic %lr, (,%s12)
  %3 = udiv i128 %0, %1
  ret i128 %3
}

; Function Attrs: norecurse nounwind readnone
define i64 @divu64(i64, i64) {
; CHECK-LABEL: divu64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divu.l %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = udiv i64 %0, %1
  ret i64 %3
}

; Function Attrs: norecurse nounwind readnone
define i32 @divu32(i32, i32) {
; CHECK-LABEL: divu32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divu.w %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = udiv i32 %0, %1
  ret i32 %3
}

; Function Attrs: norecurse nounwind readnone
define signext i16 @divi16(i16 signext, i16 signext) {
; CHECK-LABEL: divi16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divs.w.sx %s34, %s0, %s1
; CHECK-NEXT:    sla.w.sx %s34, %s34, 16
; CHECK-NEXT:    sra.w.sx %s0, %s34, 16
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = sext i16 %0 to i32
  %4 = sext i16 %1 to i32
  %5 = sdiv i32 %3, %4
  %6 = trunc i32 %5 to i16
  ret i16 %6
}

; Function Attrs: norecurse nounwind readnone
define zeroext i16 @divu16(i16 zeroext, i16 zeroext) {
; CHECK-LABEL: divu16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divu.w %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = udiv i16 %0, %1
  ret i16 %3
}

; Function Attrs: norecurse nounwind readnone
define signext i8 @divi8(i8 signext, i8 signext) {
; CHECK-LABEL: divi8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divs.w.sx %s34, %s0, %s1
; CHECK-NEXT:    sla.w.sx %s34, %s34, 24
; CHECK-NEXT:    sra.w.sx %s0, %s34, 24
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = sext i8 %0 to i32
  %4 = sext i8 %1 to i32
  %5 = sdiv i32 %3, %4
  %6 = trunc i32 %5 to i8
  ret i8 %6
}

; Function Attrs: norecurse nounwind readnone
define zeroext i8 @divu8(i8 zeroext, i8 zeroext) {
; CHECK-LABEL: divu8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divu.w %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = udiv i8 %0, %1
  ret i8 %3
}

; Function Attrs: norecurse nounwind readnone
define double @divf64ri(double, double) {
; CHECK-LABEL: divf64ri:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, 858993459
; CHECK-NEXT:    lea.sl %s34, 1072902963(%s34)
; CHECK-NEXT:    fdiv.d %s0, %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = fdiv double %0, 1.200000e+00
  ret double %3
}

; Function Attrs: norecurse nounwind readnone
define float @divf32ri(float, float) {
; CHECK-LABEL: divf32ri:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s34, 1067030938
; CHECK-NEXT:    or %s34, 0, %s34
; CHECK-NEXT:    fdiv.s %s0, %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = fdiv float %0, 0x3FF3333340000000
  ret float %3
}

define i128 @divi128ri(i128) {
; CHECK-LABEL: divi128ri:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, __divti3@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __divti3@hi(%s34)
; CHECK-NEXT:    or %s2, 3, (0)1
; CHECK-NEXT:    or %s3, 0, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
  %2 = sdiv i128 %0, 3
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define i64 @divi64ri(i64, i64) {
; CHECK-LABEL: divi64ri:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s34, 3, (0)1
; CHECK-NEXT:    divs.l %s0, %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = sdiv i64 %0, 3
  ret i64 %3
}

; Function Attrs: norecurse nounwind readnone
define i32 @divi32ri(i32, i32) {
; CHECK-LABEL: divi32ri:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s34, %s0, (0)1
; CHECK-NEXT:    lea %s35, 1431655766
; CHECK-NEXT:    muls.l %s34, %s34, %s35
; CHECK-NEXT:    srl %s35, %s34, 63
; CHECK-NEXT:    adds.w.sx %s35, %s35, (0)1
; CHECK-NEXT:    srl %s34, %s34, 32
; CHECK-NEXT:    adds.w.sx %s34, %s34, (0)1
; CHECK-NEXT:    adds.w.sx %s0, %s34, %s35
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = sdiv i32 %0, 3
  ret i32 %3
}

define i128 @divu128ri(i128) {
; CHECK-LABEL: divu128ri:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, __udivti3@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __udivti3@hi(%s34)
; CHECK-NEXT:    or %s2, 3, (0)1
; CHECK-NEXT:    or %s3, 0, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
  %2 = udiv i128 %0, 3
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define i64 @divu64ri(i64, i64) {
; CHECK-LABEL: divu64ri:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s34, 3, (0)1
; CHECK-NEXT:    divu.l %s0, %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = udiv i64 %0, 3
  ret i64 %3
}

; Function Attrs: norecurse nounwind readnone
define i32 @divu32ri(i32, i32) {
; CHECK-LABEL: divu32ri:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.zx %s34, %s0, (0)1
; CHECK-NEXT:    lea %s35, -1431655765
; CHECK-NEXT:    and %s35, %s35, (32)0
; CHECK-NEXT:    muls.l %s34, %s34, %s35
; CHECK-NEXT:    srl %s34, %s34, 33
; CHECK-NEXT:    adds.w.sx %s0, %s34, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = udiv i32 %0, 3
  ret i32 %3
}

; Function Attrs: norecurse nounwind readnone
define double @divf64li(double, double) {
; CHECK-LABEL: divf64li:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, 858993459
; CHECK-NEXT:    lea.sl %s34, 1072902963(%s34)
; CHECK-NEXT:    fdiv.d %s0, %s34, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = fdiv double 1.200000e+00, %1
  ret double %3
}

; Function Attrs: norecurse nounwind readnone
define float @divf32li(float, float) {
; CHECK-LABEL: divf32li:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s34, 1067030938
; CHECK-NEXT:    or %s34, 0, %s34
; CHECK-NEXT:    fdiv.s %s0, %s34, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = fdiv float 0x3FF3333340000000, %1
  ret float %3
}

define i128 @divi128li(i128) {
; CHECK-LABEL: divi128li:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s3, 0, %s1
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    lea %s34, __divti3@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __divti3@hi(%s34)
; CHECK-NEXT:    or %s0, 3, (0)1
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
  %2 = sdiv i128 3, %0
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define i64 @divi64li(i64, i64) {
; CHECK-LABEL: divi64li:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divs.l %s0, 3, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = sdiv i64 3, %1
  ret i64 %3
}

; Function Attrs: norecurse nounwind readnone
define i32 @divi32li(i32, i32) {
; CHECK-LABEL: divi32li:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divs.w.sx %s0, 3, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = sdiv i32 3, %1
  ret i32 %3
}

define i128 @divu128li(i128) {
; CHECK-LABEL: divu128li:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s3, 0, %s1
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    lea %s34, __udivti3@lo
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, __udivti3@hi(%s34)
; CHECK-NEXT:    or %s0, 3, (0)1
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    bsic %lr, (,%s12)
  %2 = udiv i128 3, %0
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define i64 @divu64li(i64, i64) {
; CHECK-LABEL: divu64li:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divu.l %s0, 3, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = udiv i64 3, %1
  ret i64 %3
}

; Function Attrs: norecurse nounwind readnone
define i32 @divu32li(i32, i32) {
; CHECK-LABEL: divu32li:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divu.w %s0, 3, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = udiv i32 3, %1
  ret i32 %3
}

