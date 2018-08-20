; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s
; ModuleID = 'intrin-pfchvr.c'
source_filename = "intrin-pfchvr.c"
target datalayout = "e-m:e-i64:64-n32:64-S64-v16384:64:64"
target triple = "ve"

; Function Attrs: nounwind
define dso_local void @test(i64 %offset, float* %p) local_unnamed_addr #0 {
; CHECK-LABEL: test
; CHECK: .LBB0_2
; CHECK:        pfchv %s0,%s1
entry:
  %0 = bitcast float* %p to i8*
  tail call void @llvm.ve.pfchv(i64 %offset, i8* %0)
  ret void
}

; Function Attrs: nounwind
declare void @llvm.ve.pfchv(i64, i8*) #1

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 7.0.0 (git@socsv218.svp.cl.nec.co.jp:ve-llvm/clang.git 493d94f405148cb2f3efa54da506f6829fab7790) (llvm/llvm.git 4ed0e21cfc223e1136a201322e798c1c69d6ffc2)"}
