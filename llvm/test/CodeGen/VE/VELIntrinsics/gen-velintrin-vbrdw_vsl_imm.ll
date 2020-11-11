; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=+packed | FileCheck %s
; ModuleID = 'gen/tests/vbrdw_vsl_imm.c'
source_filename = "gen/tests/vbrdw_vsl_imm.c"
target datalayout = "e-m:e-i64:64-n32:64-S128-v64:64:64-v128:64:64-v256:64:64-v512:64:64-v1024:64:64-v2048:64:64-v4096:64:64-v8192:64:64-v16384:64:64"
target triple = "ve-unknown-linux-gnu"

; Function Attrs: nounwind writeonly
define dso_local void @vbrdw_vsl_imm(i32* %0, i32 signext %1) local_unnamed_addr #0 {
; CHECK: vbrdl %v0, 3
  %3 = icmp sgt i32 %1, 0
  br i1 %3, label %5, label %4

4:                                                ; preds = %5, %2
  ret void

5:                                                ; preds = %2, %5
  %6 = phi i32* [ %13, %5 ], [ %0, %2 ]
  %7 = phi i32 [ %14, %5 ], [ 0, %2 ]
  %8 = sub nsw i32 %1, %7
  %9 = icmp slt i32 %8, 256
  %10 = select i1 %9, i32 %8, i32 256
  %11 = tail call <256 x double> @llvm.ve.vl.vbrdw.vsl(i32 3, i32 %10)
  %12 = bitcast i32* %6 to i8*
  tail call void @llvm.ve.vl.vstl.vssl(<256 x double> %11, i64 4, i8* %12, i32 %10)
  %13 = getelementptr inbounds i32, i32* %6, i64 256
  %14 = add nuw nsw i32 %7, 256
  %15 = icmp slt i32 %14, %1
  br i1 %15, label %5, label %4
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vbrdw.vsl(i32, i32) #1

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vl.vstl.vssl(<256 x double>, i64, i8*, i32) #2

attributes #0 = { nounwind writeonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="-vec" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind writeonly }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (git@socsv218.svp.cl.nec.co.jp:ve-llvm/llvm-project.git ea1e45464a3c0492368cbabae9242628b03e399d)"}
