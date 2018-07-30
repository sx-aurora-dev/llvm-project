; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; ModuleID = 'src/ticket152.c'
source_filename = "src/ticket152.c"
target datalayout = "e-m:e-i64:64-n32:64-S64-v16384:64:64"
target triple = "ve"

; Function Attrs: norecurse nounwind readnone
define dso_local i32 @callee(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i8 signext, i16 signext, fp128) local_unnamed_addr #0 {
; CHECK-LABEL: callee:
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  lea %s34,272(,%s9)
; CHECK-NEXT:  or %s34, 8, %s34
; CHECK-NEXT:  ld %s34, (,%s34)
; CHECK-NEXT:  ld %s35, 272(,%s9)
; CHECK-NEXT:  ldl.sx %s36, 264(,%s9)
; CHECK-NEXT:  ldl.sx %s37, 256(,%s9)
; CHECK-NEXT:  ldl.sx %s38, 248(,%s9)
; CHECK-NEXT:  ldl.sx %s39, 240(,%s9)
; CHECK-NEXT:  adds.w.sx %s40, %s1, %s0
; CHECK-NEXT:  adds.w.sx %s40, %s40, %s2
; CHECK-NEXT:  adds.w.sx %s40, %s40, %s3
; CHECK-NEXT:  adds.w.sx %s40, %s40, %s4
; CHECK-NEXT:  adds.w.sx %s40, %s40, %s5
; CHECK-NEXT:  adds.w.sx %s40, %s40, %s6
; CHECK-NEXT:  adds.w.sx %s40, %s40, %s7
; CHECK-NEXT:  adds.w.sx %s39, %s40, %s39
; CHECK-NEXT:  adds.w.sx %s38, %s39, %s38
; CHECK-NEXT:  adds.w.sx %s37, %s38, %s37
; CHECK-NEXT:  adds.w.sx %s36, %s37, %s36
; CHECK-NEXT:  cvt.d.q %s34, %s34
; CHECK-NEXT:  cvt.w.d.sx.rz %s34, %s34
; CHECK-NEXT:  adds.w.sx %s0, %s36, %s34
; CHECK-NEXT:  or %s11, 0, %s9
  %14 = add nsw i32 %1, %0
  %15 = add nsw i32 %14, %2
  %16 = add nsw i32 %15, %3
  %17 = add nsw i32 %16, %4
  %18 = add nsw i32 %17, %5
  %19 = add nsw i32 %18, %6
  %20 = add nsw i32 %19, %7
  %21 = add nsw i32 %20, %8
  %22 = add nsw i32 %21, %9
  %23 = sext i8 %10 to i32
  %24 = add nsw i32 %22, %23
  %25 = sext i16 %11 to i32
  %26 = add nsw i32 %24, %25
  %27 = fptosi fp128 %12 to i32
  %28 = add nsw i32 %26, %27
  ret i32 %28
}

; Function Attrs: nounwind
define dso_local i32 @caller2() local_unnamed_addr #1 {
; CHECK-LABEL: caller2:
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  or %s34, 10, (0)1
; CHECK-NEXT:  stl %s34, 248(,%s11)
; CHECK-NEXT:  or %s34, 9, (0)1
; CHECK-NEXT:  lea %s35, %lo(callee2)
; CHECK-NEXT:  and %s35, %s35, (32)0
; CHECK-NEXT:  lea.sl %s12, %hi(callee2)(%s35)
; CHECK-NEXT:  or %s0, 1, (0)1
; CHECK-NEXT:  or %s1, 2, (0)1
; CHECK-NEXT:  or %s2, 3, (0)1
; CHECK-NEXT:  or %s3, 4, (0)1
; CHECK-NEXT:  or %s4, 5, (0)1
; CHECK-NEXT:  or %s5, 6, (0)1
; CHECK-NEXT:  or %s6, 7, (0)1
; CHECK-NEXT:  or %s7, 8, (0)1
; CHECK-NEXT:  stl %s34, 240(,%s11)
; CHECK-NEXT:  bsic %lr, (,%s12)
; CHECK-NEXT:  or %s11, 0, %s9
  %1 = tail call i32 @callee2(i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10) #3
  ret i32 %1
}

declare dso_local i32 @callee2(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32) local_unnamed_addr #2

; Function Attrs: nounwind
define dso_local i32 @caller3() local_unnamed_addr #1 {
; CHECK-LABEL: caller3:
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  or %s34, 10, (0)1
; CHECK-NEXT:  stl %s34, 248(,%s11)
; CHECK-NEXT:  or %s34, 9, (0)1
; CHECK-NEXT:  stl %s34, 240(,%s11)
; CHECK-NEXT:  or %s7, 8, (0)1
; CHECK-NEXT:  stl %s7, 232(,%s11)
; CHECK-NEXT:  or %s6, 7, (0)1
; CHECK-NEXT:  stl %s6, 224(,%s11)
; CHECK-NEXT:  or %s5, 6, (0)1
; CHECK-NEXT:  stl %s5, 216(,%s11)
; CHECK-NEXT:  or %s4, 5, (0)1
; CHECK-NEXT:  stl %s4, 208(,%s11)
; CHECK-NEXT:  or %s2, 3, (0)1
; CHECK-NEXT:  stl %s2, 192(,%s11)
; CHECK-NEXT:  or %s1, 2, (0)1
; CHECK-NEXT:  stl %s1, 184(,%s11)
; CHECK-NEXT:  or %s0, 1, (0)1
; CHECK-NEXT:  stl %s0, 176(,%s11)
; CHECK-NEXT:  lea %s34, %lo(callee3)
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s12, %hi(callee3)(%s34)
; CHECK-NEXT:  lea.sl %s34, %hi(.LCPI2_0)
; CHECK-NEXT:  ld %s3, %lo(.LCPI2_0)(,%s34)
; CHECK-NEXT:  lea %s34, 0
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, 1074790400(%s34)
; CHECK-NEXT:  st %s34, 200(,%s11)
; CHECK-NEXT:  bsic %lr, (,%s12)
; CHECK-NEXT:  or %s11, 0, %s9
  %1 = tail call i32 (i32, ...) @callee3(i32 1, i32 2, i32 3, double 4.000000e+00, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10) #3
  ret i32 %1
}

declare dso_local i32 @callee3(i32, ...) local_unnamed_addr #2

; Function Attrs: nounwind
define dso_local i32 @caller4() local_unnamed_addr #1 {
; CHECK-LABEL: caller4:
; CHECK:       .LBB{{[0-9]+}}_{{[0-9]}}:
; CHECK-NEXT:  or %s34, 10, (0)1
; CHECK-NEXT:  stl %s34, 248(,%s11)
; CHECK-NEXT:  or %s34, 9, (0)1
; CHECK-NEXT:  lea %s35, %lo(callee4)
; CHECK-NEXT:  and %s35, %s35, (32)0
; CHECK-NEXT:  lea.sl %s12, %hi(callee4)(%s35)
; CHECK-NEXT:  lea.sl %s35, %hi(.LCPI3_0)
; CHECK-NEXT:  ld %s3, %lo(.LCPI3_0)(,%s35)
; CHECK-NEXT:  or %s0, 1, (0)1
; CHECK-NEXT:  or %s1, 2, (0)1
; CHECK-NEXT:  or %s2, 3, (0)1
; CHECK-NEXT:  or %s4, 5, (0)1
; CHECK-NEXT:  or %s5, 6, (0)1
; CHECK-NEXT:  or %s6, 7, (0)1
; CHECK-NEXT:  or %s7, 8, (0)1
; CHECK-NEXT:  stl %s34, 240(,%s11)
; CHECK-NEXT:  bsic %lr, (,%s12)
; CHECK-NEXT:  or %s11, 0, %s9
  %1 = tail call i32 bitcast (i32 (...)* @callee4 to i32 (i32, i32, i32, double, i32, i32, i32, i32, i32, i32)*)(i32 1, i32 2, i32 3, double 4.000000e+00, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10) #3
  ret i32 %1
}

declare dso_local i32 @callee4(...) local_unnamed_addr #2

attributes #0 = { norecurse nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 7.0.0 (https://github.com/llvm-mirror/clang.git d326119e3a71593369edd97e642577b570bf7c32) (https://github.com/llvm-mirror/llvm.git 322c96fd93ac73a432d19f3b95b71f6439b0bd14)"}
