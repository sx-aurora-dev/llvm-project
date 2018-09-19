; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define i64 @remi64(i64, i64) {
; CHECK-LABEL: remi64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divs.l %s34, %s0, %s1
; CHECK-NEXT:    muls.l %s34, %s34, %s1
; CHECK-NEXT:    subs.l %s0, %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = srem i64 %0, %1
  ret i64 %3
}

; Function Attrs: norecurse nounwind readnone
define i32 @remi32(i32, i32) {
; CHECK-LABEL: remi32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divs.w.sx %s34, %s0, %s1
; CHECK-NEXT:    muls.w.sx %s34, %s34, %s1
; CHECK-NEXT:    subs.w.sx %s0, %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = srem i32 %0, %1
  ret i32 %3
}

; Function Attrs: norecurse nounwind readnone
define i64 @remu64(i64, i64) {
; CHECK-LABEL: remu64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divu.l %s34, %s0, %s1
; CHECK-NEXT:    muls.l %s34, %s34, %s1
; CHECK-NEXT:    subs.l %s0, %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = urem i64 %0, %1
  ret i64 %3
}

; Function Attrs: norecurse nounwind readnone
define i32 @remu32(i32, i32) {
; CHECK-LABEL: remu32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divu.w %s34, %s0, %s1
; CHECK-NEXT:    muls.w.sx %s34, %s34, %s1
; CHECK-NEXT:    subs.w.sx %s0, %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = urem i32 %0, %1
  ret i32 %3
}

; Function Attrs: norecurse nounwind readnone
define signext i16 @remi16(i16 signext, i16 signext) {
; CHECK-LABEL: remi16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divs.w.sx %s34, %s0, %s1
; CHECK-NEXT:    muls.w.sx %s34, %s34, %s1
; CHECK-NEXT:    subs.w.sx %s34, %s0, %s34
; CHECK-NEXT:    sla.w.sx %s34, %s34, 16
; CHECK-NEXT:    sra.w.sx %s0, %s34, 16
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = sext i16 %0 to i32
  %4 = sext i16 %1 to i32
  %5 = srem i32 %3, %4
  %6 = trunc i32 %5 to i16
  ret i16 %6
}

; Function Attrs: norecurse nounwind readnone
define zeroext i16 @remu16(i16 zeroext, i16 zeroext) {
; CHECK-LABEL: remu16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divu.w %s34, %s0, %s1
; CHECK-NEXT:    muls.w.sx %s34, %s34, %s1
; CHECK-NEXT:    subs.w.sx %s0, %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = urem i16 %0, %1
  ret i16 %3
}

; Function Attrs: norecurse nounwind readnone
define signext i8 @remi8(i8 signext, i8 signext) {
; CHECK-LABEL: remi8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divs.w.sx %s34, %s0, %s1
; CHECK-NEXT:    muls.w.sx %s34, %s34, %s1
; CHECK-NEXT:    subs.w.sx %s34, %s0, %s34
; CHECK-NEXT:    sla.w.sx %s34, %s34, 24
; CHECK-NEXT:    sra.w.sx %s0, %s34, 24
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = sext i8 %0 to i32
  %4 = sext i8 %1 to i32
  %5 = srem i32 %3, %4
  %6 = trunc i32 %5 to i8
  ret i8 %6
}

; Function Attrs: norecurse nounwind readnone
define zeroext i8 @remu8(i8 zeroext, i8 zeroext) {
; CHECK-LABEL: remu8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divu.w %s34, %s0, %s1
; CHECK-NEXT:    muls.w.sx %s34, %s34, %s1
; CHECK-NEXT:    subs.w.sx %s0, %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = urem i8 %0, %1
  ret i8 %3
}

; Function Attrs: norecurse nounwind readnone
define i64 @remi64ri(i64, i64) {
; CHECK-LABEL: remi64ri:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s34, 3, (0)1
; CHECK-NEXT:    divs.l %s34, %s0, %s34
; CHECK-NEXT:    muls.l %s34, 3, %s34
; CHECK-NEXT:    subs.l %s0, %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = srem i64 %0, 3
  ret i64 %3
}

; Function Attrs: norecurse nounwind readnone
define i32 @remi32ri(i32, i32) {
; CHECK-LABEL: remi32ri:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s34, %s0, (0)1
; CHECK-NEXT:    lea %s35, 1431655766
; CHECK-NEXT:    muls.l %s34, %s34, %s35
; CHECK-NEXT:    srl %s35, %s34, 63
; CHECK-NEXT:    adds.w.sx %s35, %s35, (0)1
; CHECK-NEXT:    srl %s34, %s34, 32
; CHECK-NEXT:    adds.w.sx %s34, %s34, (0)1
; CHECK-NEXT:    adds.w.sx %s34, %s34, %s35
; CHECK-NEXT:    muls.w.sx %s34, 3, %s34
; CHECK-NEXT:    subs.w.sx %s0, %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = srem i32 %0, 3
  ret i32 %3
}

; Function Attrs: norecurse nounwind readnone
define i64 @remu64ri(i64, i64) {
; CHECK-LABEL: remu64ri:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s34, 3, (0)1
; CHECK-NEXT:    divu.l %s34, %s0, %s34
; CHECK-NEXT:    muls.l %s34, 3, %s34
; CHECK-NEXT:    subs.l %s0, %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = urem i64 %0, 3
  ret i64 %3
}

; Function Attrs: norecurse nounwind readnone
define i32 @remu32ri(i32, i32) {
; CHECK-LABEL: remu32ri:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.zx %s34, %s0, (0)1
; CHECK-NEXT:    lea %s35, -1431655765
; CHECK-NEXT:    and %s35, %s35, (32)0
; CHECK-NEXT:    muls.l %s34, %s34, %s35
; CHECK-NEXT:    srl %s34, %s34, 33
; CHECK-NEXT:    adds.w.sx %s34, %s34, (0)1
; CHECK-NEXT:    muls.w.sx %s34, 3, %s34
; CHECK-NEXT:    subs.w.sx %s0, %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = urem i32 %0, 3
  ret i32 %3
}

; Function Attrs: norecurse nounwind readnone
define i64 @remi64li(i64, i64) {
; CHECK-LABEL: remi64li:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divs.l %s34, 3, %s1
; CHECK-NEXT:    muls.l %s34, %s34, %s1
; CHECK-NEXT:    subs.l %s0, 3, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = srem i64 3, %1
  ret i64 %3
}

; Function Attrs: norecurse nounwind readnone
define i32 @remi32li(i32, i32) {
; CHECK-LABEL: remi32li:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divs.w.sx %s34, 3, %s1
; CHECK-NEXT:    muls.w.sx %s34, %s34, %s1
; CHECK-NEXT:    subs.w.sx %s0, 3, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = srem i32 3, %1
  ret i32 %3
}

; Function Attrs: norecurse nounwind readnone
define i64 @remu64li(i64, i64) {
; CHECK-LABEL: remu64li:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divu.l %s34, 3, %s1
; CHECK-NEXT:    muls.l %s34, %s34, %s1
; CHECK-NEXT:    subs.l %s0, 3, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = urem i64 3, %1
  ret i64 %3
}

; Function Attrs: norecurse nounwind readnone
define i32 @remu32li(i32, i32) {
; CHECK-LABEL: remu32li:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divu.w %s34, 3, %s1
; CHECK-NEXT:    muls.w.sx %s34, %s34, %s1
; CHECK-NEXT:    subs.w.sx %s0, 3, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = urem i32 3, %1
  ret i32 %3
}

