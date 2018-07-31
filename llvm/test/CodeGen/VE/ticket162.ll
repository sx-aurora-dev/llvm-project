; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; ModuleID = 'src/ticket162.c'
source_filename = "src/ticket162.c"
target datalayout = "e-m:e-i64:64-n32:64-S64-v16384:64:64"
target triple = "ve"

; Function Attrs: nounwind readonly
define dso_local i64 @test(float* readonly, i64) local_unnamed_addr #0 {
; CHECK-LABEL: test:
; CHECK:       .LBB0_2:
; CHECK-NEXT:    sll %s34, %s1, 2
; CHECK-NEXT:    adds.l %s34, %s0, %s34
; CHECK-NEXT:    ldu %s35, (,%s0)
; CHECK-NEXT:    ldl.zx %s34, (,%s34)
; CHECK-NEXT:    or %s0, %s35, %s34
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = bitcast float* %0 to i8*
  %4 = getelementptr inbounds float, float* %0, i64 %1
  %5 = bitcast float* %4 to i8*
  %6 = tail call i64 @llvm.ve.pack.f32p(i8* %3, i8* %5)
  ret i64 %6
}

; Function Attrs: nounwind readonly
declare i64 @llvm.ve.pack.f32p(i8*, i8*) #1

attributes #0 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 7.0.0 (https://github.com/llvm-mirror/clang.git d326119e3a71593369edd97e642577b570bf7c32) (https://github.com/llvm-mirror/llvm.git 829abd1ed2f74dd10970ac11b6832b8f2e0689c2)"}
