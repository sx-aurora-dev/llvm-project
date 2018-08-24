; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; ModuleID = 'src/fp_to_int.c'
source_filename = "src/fp_to_int.c"
target datalayout = "e-m:e-i64:64-n32:64-S64-v16384:64:64"
target triple = "ve"

; Function Attrs: norecurse nounwind readnone
define dso_local signext i8 @f2c(float %a) local_unnamed_addr #0 {
; CHECK-LABEL: f2c
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.w.s.sx.rz %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptosi float %a to i8
  ret i8 %conv
}

; Function Attrs: norecurse nounwind readnone
define dso_local signext i16 @f2s(float %a) local_unnamed_addr #0 {
; CHECK-LABEL: f2s
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.w.s.sx.rz %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptosi float %a to i16
  ret i16 %conv
}

; Function Attrs: norecurse nounwind readnone
define dso_local i32 @f2i(float %a) local_unnamed_addr #0 {
; CHECK-LABEL: f2i
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.w.s.sx.rz %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptosi float %a to i32
  ret i32 %conv
}

; Function Attrs: norecurse nounwind readnone
define dso_local i64 @f2l(float %a) local_unnamed_addr #0 {
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
define dso_local zeroext i8 @f2uc(float %a) local_unnamed_addr #0 {
; CHECK-LABEL: f2uc
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.w.s.sx.rz %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptoui float %a to i8
  ret i8 %conv
}

; Function Attrs: norecurse nounwind readnone
define dso_local zeroext i16 @f2us(float %a) local_unnamed_addr #0 {
; CHECK-LABEL: f2us
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.w.s.sx.rz %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptoui float %a to i16
  ret i16 %conv
}

; Function Attrs: norecurse nounwind readnone
define dso_local i32 @f2ui(float %a) local_unnamed_addr #0 {
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
define dso_local i64 @f2ul(float %a) local_unnamed_addr #0 {
; CHECK-LABEL: f2ul
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  lea.sl %s34, %hi(.LCPI7_0)
; CHECK-NEXT:  ldu %s34, %lo(.LCPI7_0)(,%s34)
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
define dso_local signext i8 @d2c(double %a) local_unnamed_addr #0 {
; CHECK-LABEL: d2c
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.w.d.sx.rz %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptosi double %a to i8
  ret i8 %conv
}

; Function Attrs: norecurse nounwind readnone
define dso_local signext i16 @d2s(double %a) local_unnamed_addr #0 {
; CHECK-LABEL: d2s
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.w.d.sx.rz %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptosi double %a to i16
  ret i16 %conv
}

; Function Attrs: norecurse nounwind readnone
define dso_local i32 @d2i(double %a) local_unnamed_addr #0 {
; CHECK-LABEL: d2i
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.w.d.sx.rz %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptosi double %a to i32
  ret i32 %conv
}

; Function Attrs: norecurse nounwind readnone
define dso_local i64 @d2l(double %a) local_unnamed_addr #0 {
; CHECK-LABEL: d2l
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.l.d.rz %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptosi double %a to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind readnone
define dso_local zeroext i8 @d2uc(double %a) local_unnamed_addr #0 {
; CHECK-LABEL: d2uc
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.w.d.sx.rz %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptoui double %a to i8
  ret i8 %conv
}

; Function Attrs: norecurse nounwind readnone
define dso_local zeroext i16 @d2us(double %a) local_unnamed_addr #0 {
; CHECK-LABEL: d2us
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.w.d.sx.rz %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptoui double %a to i16
  ret i16 %conv
}

; Function Attrs: norecurse nounwind readnone
define dso_local i32 @d2ui(double %a) local_unnamed_addr #0 {
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
define dso_local i64 @d2ul(double %a) local_unnamed_addr #0 {
; CHECK-LABEL: d2ul
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  lea.sl %s34, %hi(.LCPI15_0)
; CHECK-NEXT:  ld %s34, %lo(.LCPI15_0)(,%s34)
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
define dso_local signext i8 @q2c(fp128 %a) local_unnamed_addr #0 {
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
define dso_local signext i16 @q2s(fp128 %a) local_unnamed_addr #0 {
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
define dso_local i32 @q2i(fp128 %a) local_unnamed_addr #0 {
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
define dso_local i64 @q2l(fp128 %a) local_unnamed_addr #0 {
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
define dso_local zeroext i8 @q2uc(fp128 %a) local_unnamed_addr #0 {
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
define dso_local zeroext i16 @q2us(fp128 %a) local_unnamed_addr #0 {
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
define dso_local i32 @q2ui(fp128 %a) local_unnamed_addr #0 {
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
define dso_local i64 @q2ul(fp128 %a) local_unnamed_addr #0 {
; CHECK-LABEL: q2ul
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  lea %s34, %lo(.LCPI23_0)
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, %hi(.LCPI23_0)(%s34)
; CHECK-NEXT:  ld %s34, 8(,%s34)
; CHECK-NEXT:  lea.sl %s36, %hi(.LCPI23_0)
; CHECK-NEXT:  ld %s35, %lo(.LCPI23_0)(,%s36)
; CHECK-NEXT:  fcmp.q %s36, %s0, %s34
; CHECK-NEXT:  fsub.q %s34, %s0, %s34
; CHECK-NEXT:  cvt.d.q %s34, %s34
; CHECK-NEXT:  cvt.l.d.rz %s34, %s34
; CHECK-NEXT:  lea %s35, 0
; CHECK-NEXT:  and %s35, %s35, (32)0
; CHECK-NEXT:  lea.sl %s35, -2147483648(%s35)
; CHECK-NEXT:  xor %s34, %s34, %s35
; CHECK-NEXT:  cvt.d.q %s35, %s0
; CHECK-NEXT:  cvt.l.d.rz %s35, %s35
; CHECK-NEXT:  cmov.d.lt %s34, %s35, %s36
; CHECK-NEXT:  or %s0, 0, %s34
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = fptoui fp128 %a to i64
  ret i64 %conv
}

attributes #0 = { norecurse nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 7.0.0 (https://github.com/llvm-mirror/clang.git d326119e3a71593369edd97e642577b570bf7c32) (https://github.com/llvm-mirror/llvm.git 76da0cf6ceaa4105ea016d070327f8167f05d1eb)"}
