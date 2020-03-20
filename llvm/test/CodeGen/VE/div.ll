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
; CHECK-NEXT:    lea %s4, __divti3@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s12, __divti3@hi(, %s4)
; CHECK-NEXT:    bsic %s10, (, %s12)
  %3 = sdiv i128 %0, %1
  ret i128 %3
}

; Function Attrs: norecurse nounwind readnone
define i64 @divi64(i64 %a, i64 %b) {
; CHECK-LABEL: divi64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divs.l %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = sdiv i64 %a, %b
  ret i64 %r
}

; Function Attrs: norecurse nounwind readnone
define i32 @divi32(i32 %a, i32 %b) {
; CHECK-LABEL: divi32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divs.w.sx %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = sdiv i32 %a, %b
  ret i32 %r
}

define i128 @divu128(i128, i128) {
; CHECK-LABEL: divu128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s4, __udivti3@lo
; CHECK-NEXT:    and %s4, %s4, (32)0
; CHECK-NEXT:    lea.sl %s12, __udivti3@hi(, %s4)
; CHECK-NEXT:    bsic %s10, (, %s12)
  %3 = udiv i128 %0, %1
  ret i128 %3
}

; Function Attrs: norecurse nounwind readnone
define i64 @divu64(i64 %a, i64 %b) {
; CHECK-LABEL: divu64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divu.l %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = udiv i64 %a, %b
  ret i64 %r
}

; Function Attrs: norecurse nounwind readnone
; Function Attrs: norecurse nounwind readnone
define i32 @divu32(i32 %a, i32 %b) {
; CHECK-LABEL: divu32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divu.w %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = udiv i32 %a, %b
  ret i32 %r
}

; Function Attrs: norecurse nounwind readnone
define signext i16 @divi16(i16 signext %a, i16 signext %b) {
; CHECK-LABEL: divi16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divs.w.sx %s0, %s0, %s1
; CHECK-NEXT:    sla.w.sx %s0, %s0, 16
; CHECK-NEXT:    sra.w.sx %s0, %s0, 16
; CHECK-NEXT:    or %s11, 0, %s9
  %a32 = sext i16 %a to i32
  %b32 = sext i16 %b to i32
  %r32 = sdiv i32 %a32, %b32
  %r = trunc i32 %r32 to i16
  ret i16 %r
}

; Function Attrs: norecurse nounwind readnone
; Function Attrs: norecurse nounwind readnone
define zeroext i16 @divu16(i16 zeroext %a, i16 zeroext %b) {
; CHECK-LABEL: divu16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divu.w %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = udiv i16 %a, %b
  ret i16 %r
}

; Function Attrs: norecurse nounwind readnone
define signext i8 @divi8(i8 signext %a, i8 signext %b) {
; CHECK-LABEL: divi8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divs.w.sx %s0, %s0, %s1
; CHECK-NEXT:    sla.w.sx %s0, %s0, 24
; CHECK-NEXT:    sra.w.sx %s0, %s0, 24
; CHECK-NEXT:    or %s11, 0, %s9
  %a32 = sext i8 %a to i32
  %b32 = sext i8 %b to i32
  %r32 = sdiv i32 %a32, %b32
  %r = trunc i32 %r32 to i8
  ret i8 %r
}

; Function Attrs: norecurse nounwind readnone
define zeroext i8 @divu8(i8 zeroext %a, i8 zeroext %b) {
; CHECK-LABEL: divu8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divu.w %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = udiv i8 %a, %b
  ret i8 %r
}

; Function Attrs: norecurse nounwind readnone
define double @divf64ri(double, double) {
; CHECK-LABEL: divf64ri:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 858993459
; CHECK-NEXT:    lea.sl %s1, 1072902963(, %s1)
; CHECK-NEXT:    fdiv.d %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = fdiv double %0, 1.200000e+00
  ret double %3
}

; Function Attrs: norecurse nounwind readnone
define float @divf32ri(float, float) {
; CHECK-LABEL: divf32ri:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s1, 1067030938
; CHECK-NEXT:    or %s1, 0, %s1
; CHECK-NEXT:    fdiv.s %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = fdiv float %0, 0x3FF3333340000000
  ret float %3
}

define i128 @divi128ri(i128) {
; CHECK-LABEL: divi128ri:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, __divti3@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, __divti3@hi(, %s2)
; CHECK-NEXT:    or %s2, 3, (0)1
; CHECK-NEXT:    or %s3, 0, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
  %2 = sdiv i128 %0, 3
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define i64 @divi64ri(i64 %a, i64 %b) {
; CHECK-LABEL: divi64ri:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divs.l %s0, %s0, (62)0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = sdiv i64 %a, 3
  ret i64 %r
}

; Function Attrs: norecurse nounwind readnone
define i32 @divi32ri(i32 %a, i32 %b) {
; CHECK-LABEL: divi32ri:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    lea %s1, 1431655766
; CHECK-NEXT:    muls.l %s0, %s0, %s1
; CHECK-NEXT:    srl %s1, %s0, 63
; CHECK-NEXT:    adds.w.sx %s1, %s1, (0)1
; CHECK-NEXT:    srl %s0, %s0, 32
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    adds.w.sx %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = sdiv i32 %a, 3
  ret i32 %r
}

define i128 @divu128ri(i128) {
; CHECK-LABEL: divu128ri:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s2, __udivti3@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s12, __udivti3@hi(, %s2)
; CHECK-NEXT:    or %s2, 3, (0)1
; CHECK-NEXT:    or %s3, 0, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
  %2 = udiv i128 %0, 3
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define i64 @divu64ri(i64 %a, i64 %b) {
; CHECK-LABEL: divu64ri:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divu.l %s0, %s0, (62)0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = udiv i64 %a, 3
  ret i64 %r
}

; Function Attrs: norecurse nounwind readnone
define i32 @divu32ri(i32 %a, i32 %b) {
; CHECK-LABEL: divu32ri:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    lea %s1, -1431655765
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    muls.l %s0, %s0, %s1
; CHECK-NEXT:    srl %s0, %s0, 33
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = udiv i32 %a, 3
  ret i32 %r
}

; Function Attrs: norecurse nounwind readnone
define double @divf64li(double, double) {
; CHECK-LABEL: divf64li:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 858993459
; CHECK-NEXT:    lea.sl %s0, 1072902963(, %s0)
; CHECK-NEXT:    fdiv.d %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = fdiv double 1.200000e+00, %1
  ret double %3
}

; Function Attrs: norecurse nounwind readnone
define float @divf32li(float, float) {
; CHECK-LABEL: divf32li:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s0, 1067030938
; CHECK-NEXT:    or %s0, 0, %s0
; CHECK-NEXT:    fdiv.s %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = fdiv float 0x3FF3333340000000, %1
  ret float %3
}

define i128 @divi128li(i128) {
; CHECK-LABEL: divi128li:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s3, 0, %s1
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    lea %s0, __divti3@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __divti3@hi(, %s0)
; CHECK-NEXT:    or %s0, 3, (0)1
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
  %2 = sdiv i128 3, %0
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define i64 @divi64li(i64 %a, i64 %b) {
; CHECK-LABEL: divi64li:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divs.l %s0, 3, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = sdiv i64 3, %b
  ret i64 %r
}

; Function Attrs: norecurse nounwind readnone
define i32 @divi32li(i32 %a, i32 %b) {
; CHECK-LABEL: divi32li:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divs.w.sx %s0, 3, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = sdiv i32 3, %b
  ret i32 %r
}

define i128 @divu128li(i128) {
; CHECK-LABEL: divu128li:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s3, 0, %s1
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    lea %s0, __udivti3@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __udivti3@hi(, %s0)
; CHECK-NEXT:    or %s0, 3, (0)1
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
  %2 = udiv i128 3, %0
  ret i128 %2
}

; Function Attrs: norecurse nounwind readnone
define i64 @divu64li(i64 %a, i64 %b) {
; CHECK-LABEL: divu64li:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divu.l %s0, 3, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = udiv i64 3, %b
  ret i64 %r
}

; Function Attrs: norecurse nounwind readnone
define i32 @divu32li(i32 %a, i32 %b) {
; CHECK-LABEL: divu32li:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divu.w %s0, 3, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = udiv i32 3, %b
  ret i32 %r
}
