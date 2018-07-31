; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; ModuleID = 'src/int_to_fp.c'
source_filename = "src/int_to_fp.c"
target datalayout = "e-m:e-i64:64-n32:64-S64-v16384:64:64"
target triple = "ve"

; Function Attrs: norecurse nounwind readnone
define dso_local float @c2f(i8 signext %a) local_unnamed_addr #0 {
; CHECK-LABEL: c2f
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.s.w %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = sitofp i8 %a to float
  ret float %conv
}

; Function Attrs: norecurse nounwind readnone
define dso_local float @s2f(i16 signext %a) local_unnamed_addr #0 {
; CHECK-LABEL: s2f
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.s.w %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = sitofp i16 %a to float
  ret float %conv
}

; Function Attrs: norecurse nounwind readnone
define dso_local float @i2f(i32 %a) local_unnamed_addr #0 {
; CHECK-LABEL: i2f
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.s.w %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = sitofp i32 %a to float
  ret float %conv
}

; Function Attrs: norecurse nounwind readnone
define dso_local float @l2f(i64 %a) local_unnamed_addr #0 {
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
define dso_local float @uc2f(i8 zeroext %a) local_unnamed_addr #0 {
; CHECK-LABEL: uc2f
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.s.w %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = uitofp i8 %a to float
  ret float %conv
}

; Function Attrs: norecurse nounwind readnone
define dso_local float @us2f(i16 zeroext %a) local_unnamed_addr #0 {
; CHECK-LABEL: us2f
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.s.w %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = uitofp i16 %a to float
  ret float %conv
}

; Function Attrs: norecurse nounwind readnone
define dso_local float @ui2f(i32 %a) local_unnamed_addr #0 {
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
define dso_local float @ul2f(i64 %a) local_unnamed_addr #0 {
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
define dso_local double @c2d(i8 signext %a) local_unnamed_addr #0 {
; CHECK-LABEL: c2d
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.w %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = sitofp i8 %a to double
  ret double %conv
}

; Function Attrs: norecurse nounwind readnone
define dso_local double @s2d(i16 signext %a) local_unnamed_addr #0 {
; CHECK-LABEL: s2d
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.w %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = sitofp i16 %a to double
  ret double %conv
}

; Function Attrs: norecurse nounwind readnone
define dso_local double @i2d(i32 %a) local_unnamed_addr #0 {
; CHECK-LABEL: i2d
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.w %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = sitofp i32 %a to double
  ret double %conv
}

; Function Attrs: norecurse nounwind readnone
define dso_local double @l2d(i64 %a) local_unnamed_addr #0 {
; CHECK-LABEL: l2d
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.l %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = sitofp i64 %a to double
  ret double %conv
}

; Function Attrs: norecurse nounwind readnone
define dso_local double @uc2d(i8 zeroext %a) local_unnamed_addr #0 {
; CHECK-LABEL: uc2d
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.w %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = uitofp i8 %a to double
  ret double %conv
}

; Function Attrs: norecurse nounwind readnone
define dso_local double @us2d(i16 zeroext %a) local_unnamed_addr #0 {
; CHECK-LABEL: us2d
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  cvt.d.w %s0, %s0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = uitofp i16 %a to double
  ret double %conv
}

; Function Attrs: norecurse nounwind readnone
define dso_local double @ui2d(i32 %a) local_unnamed_addr #0 {
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
define dso_local double @ul2d(i64 %a) local_unnamed_addr #0 {
; CHECK-LABEL: ul2d
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  srl %s34, %s0, 32
; CHECK-NEXT:  lea %s35, 0
; CHECK-NEXT:  lea.sl %s36, %hi(.LCPI15_0)
; CHECK-NEXT:  ld %s36, %lo(.LCPI15_0)(,%s36)
; CHECK-NEXT:  and %s35, %s35, (32)0
; CHECK-NEXT:  lea.sl %s37, 1160773632(%s35)
; CHECK-NEXT:  or %s34, %s34, %s37
; CHECK-NEXT:  fsub.d %s34, %s34, %s36
; CHECK-NEXT:  lea %s36, -1
; CHECK-NEXT:  and %s36, %s36, (32)0
; CHECK-NEXT:  and %s36, %s0, %s36
; CHECK-NEXT:  lea.sl %s35, 1127219200(%s35)
; CHECK-NEXT:  or %s35, %s36, %s35
; CHECK-NEXT:  fadd.d %s0, %s35, %s34
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %conv = uitofp i64 %a to double
  ret double %conv
}

; Function Attrs: norecurse nounwind readnone
define dso_local fp128 @c2q(i8 signext %a) local_unnamed_addr #0 {
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
define dso_local fp128 @s2q(i16 signext %a) local_unnamed_addr #0 {
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
define dso_local fp128 @i2q(i32 %a) local_unnamed_addr #0 {
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
define dso_local fp128 @l2q(i64 %a) local_unnamed_addr #0 {
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
define dso_local fp128 @uc2q(i8 zeroext %a) local_unnamed_addr #0 {
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
define dso_local fp128 @us2q(i16 zeroext %a) local_unnamed_addr #0 {
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
define dso_local fp128 @ui2q(i32 %a) local_unnamed_addr #0 {
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
define dso_local fp128 @ul2q(i64 %a) local_unnamed_addr #0 {
; CHECK-LABEL: ul2q
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  srl %s34, %s0, 61
; CHECK-NEXT:  and %s34, 4, %s34
; CHECK-NEXT:  lea %s35, %lo(.LCPI23_0)
; CHECK-NEXT:  and %s35, %s35, (32)0
; CHECK-NEXT:  lea.sl %s35, %hi(.LCPI23_0)(%s35)
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

attributes #0 = { norecurse nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 7.0.0 (https://github.com/llvm-mirror/clang.git d326119e3a71593369edd97e642577b570bf7c32) (https://github.com/llvm-mirror/llvm.git 76da0cf6ceaa4105ea016d070327f8167f05d1eb)"}
