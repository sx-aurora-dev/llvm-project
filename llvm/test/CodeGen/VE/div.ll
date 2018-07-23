; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define dso_local double @divf64(double, double) local_unnamed_addr #0 {
; CHECK-LABEL: divf64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fdiv.d %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = fdiv double %0, %1
  ret double %3
}

; Function Attrs: norecurse nounwind readnone
define dso_local float @divf32(float, float) local_unnamed_addr #0 {
; CHECK-LABEL: divf32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fdiv.s %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = fdiv float %0, %1
  ret float %3
}

; Function Attrs: norecurse nounwind readnone
define dso_local i64 @divi64(i64, i64) local_unnamed_addr #0 {
; CHECK-LABEL: divi64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divs.l %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = sdiv i64 %0, %1
  ret i64 %3
}

; Function Attrs: norecurse nounwind readnone
define dso_local i32 @divi32(i32, i32) local_unnamed_addr #0 {
; CHECK-LABEL: divi32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divs.w.sx %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = sdiv i32 %0, %1
  ret i32 %3
}

; Function Attrs: norecurse nounwind readnone
define dso_local i64 @divu64(i64, i64) local_unnamed_addr #0 {
; CHECK-LABEL: divu64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divu.l %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = udiv i64 %0, %1
  ret i64 %3
}

; Function Attrs: norecurse nounwind readnone
define dso_local i32 @divu32(i32, i32) local_unnamed_addr #0 {
; CHECK-LABEL: divu32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divu.w %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = udiv i32 %0, %1
  ret i32 %3
}

; Function Attrs: norecurse nounwind readnone
define dso_local signext i16 @divi16(i16 signext, i16 signext) local_unnamed_addr #0 {
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
define dso_local zeroext i16 @divu16(i16 zeroext, i16 zeroext) local_unnamed_addr #0 {
; CHECK-LABEL: divu16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divu.w %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = udiv i16 %0, %1
  ret i16 %3
}

; Function Attrs: norecurse nounwind readnone
define dso_local signext i8 @divi8(i8 signext, i8 signext) local_unnamed_addr #0 {
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
define dso_local zeroext i8 @divu8(i8 zeroext, i8 zeroext) local_unnamed_addr #0 {
; CHECK-LABEL: divu8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divu.w %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = udiv i8 %0, %1
  ret i8 %3
}

; Function Attrs: norecurse nounwind readnone
define dso_local double @divf64ri(double, double) local_unnamed_addr #0 {
; CHECK-LABEL: divf64ri:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s34, %hi(.LCPI{{[0-9]+}}_0)
; CHECK-NEXT:    ld %s34, %lo(.LCPI{{[0-9]+}}_0)(,%s34)
; CHECK-NEXT:    fdiv.d %s0, %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = fdiv double %0, 1.200000e+00
  ret double %3
}

; Function Attrs: norecurse nounwind readnone
define dso_local float @divf32ri(float, float) local_unnamed_addr #0 {
; CHECK-LABEL: divf32ri:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s34, %hi(.LCPI{{[0-9]+}}_0)
; CHECK-NEXT:    ldu %s34, %lo(.LCPI{{[0-9]+}}_0)(,%s34)
; CHECK-NEXT:    fdiv.s %s0, %s0, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = fdiv float %0, 0x3FF3333340000000
  ret float %3
}

; Function Attrs: norecurse nounwind readnone
define dso_local i64 @divi64ri(i64, i64) local_unnamed_addr #0 {
; CHECK-LABEL: divi64ri:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divs.l %s0, 3, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = sdiv i64 %0, 3
  ret i64 %3
}

; Function Attrs: norecurse nounwind readnone
define dso_local i32 @divi32ri(i32, i32) local_unnamed_addr #0 {
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

; Function Attrs: norecurse nounwind readnone
define dso_local i64 @divu64ri(i64, i64) local_unnamed_addr #0 {
; CHECK-LABEL: divu64ri:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    divu.l %s0, 3, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = udiv i64 %0, 3
  ret i64 %3
}

; Function Attrs: norecurse nounwind readnone
define dso_local i32 @divu32ri(i32, i32) local_unnamed_addr #0 {
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
define dso_local double @divf64li(double, double) local_unnamed_addr #0 {
; CHECK-LABEL: divf64li:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s34, %hi(.LCPI{{[0-9]+}}_0)
; CHECK-NEXT:    ld %s34, %lo(.LCPI{{[0-9]+}}_0)(,%s34)
; CHECK-NEXT:    fdiv.d %s0, %s34, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = fdiv double 1.200000e+00, %1
  ret double %3
}

; Function Attrs: norecurse nounwind readnone
define dso_local float @divf32li(float, float) local_unnamed_addr #0 {
; CHECK-LABEL: divf32li:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s34, %hi(.LCPI{{[0-9]+}}_0)
; CHECK-NEXT:    ldu %s34, %lo(.LCPI{{[0-9]+}}_0)(,%s34)
; CHECK-NEXT:    fdiv.s %s0, %s34, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = fdiv float 0x3FF3333340000000, %1
  ret float %3
}

; Function Attrs: norecurse nounwind readnone
define dso_local i64 @divi64li(i64, i64) local_unnamed_addr #0 {
; CHECK-LABEL: divi64li:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s34, 3, (0)1
; CHECK-NEXT:    divs.l %s0, %s34, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = sdiv i64 3, %1
  ret i64 %3
}

; Function Attrs: norecurse nounwind readnone
define dso_local i32 @divi32li(i32, i32) local_unnamed_addr #0 {
; CHECK-LABEL: divi32li:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s34, 3, (0)1
; CHECK-NEXT:    divs.w.sx %s0, %s34, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = sdiv i32 3, %1
  ret i32 %3
}

; Function Attrs: norecurse nounwind readnone
define dso_local i64 @divu64li(i64, i64) local_unnamed_addr #0 {
; CHECK-LABEL: divu64li:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s34, 3, (0)1
; CHECK-NEXT:    divu.l %s0, %s34, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = udiv i64 3, %1
  ret i64 %3
}

; Function Attrs: norecurse nounwind readnone
define dso_local i32 @divu32li(i32, i32) local_unnamed_addr #0 {
; CHECK-LABEL: divu32li:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s34, 3, (0)1
; CHECK-NEXT:    divu.w %s0, %s34, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = udiv i32 3, %1
  ret i32 %3
}

attributes #0 = { norecurse nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 7.0.0 (https://github.com/llvm-mirror/clang.git 94c1203774d203ef69c0c9429c11efb086946b05) (https://github.com/llvm-mirror/llvm.git 5bd6dc5702ce7c482070ddd2a99a69167483cd7f)"}
