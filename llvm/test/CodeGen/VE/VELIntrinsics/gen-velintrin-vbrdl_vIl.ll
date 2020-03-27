; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=+velintrin | FileCheck %s
; ModuleID = 'gen/tests/vbrdl_vIl.c'
source_filename = "gen/tests/vbrdl_vIl.c"
target datalayout = "e-m:e-i64:64-n32:64-S64-v64:64:64-v128:64:64-v256:64:64-v512:64:64-v1024:64:64-v2048:64:64-v4096:64:64-v8192:64:64-v16384:64:64"
target triple = "ve"

; Function Attrs: nounwind writeonly
define dso_local void @vbrdl_vIl(i64*, i32) local_unnamed_addr #0 {
; CHECK: vbrd %v0,3
  %3 = icmp sgt i32 %1, 0
  br i1 %3, label %5, label %4

4:                                                ; preds = %5, %2
  ret void

5:                                                ; preds = %2, %5
  %6 = phi i64* [ %13, %5 ], [ %0, %2 ]
  %7 = phi i32 [ %14, %5 ], [ 0, %2 ]
  %8 = sub nsw i32 %1, %7
  %9 = icmp slt i32 %8, 256
  %10 = select i1 %9, i32 %8, i32 256
  %11 = tail call <256 x double> @llvm.ve.vl.vbrdl.vsl(i64 3, i32 %10)
  %12 = bitcast i64* %6 to i8*
  tail call void @llvm.ve.vl.vst.vssl(<256 x double> %11, i64 8, i8* %12, i32 %10)
  %13 = getelementptr inbounds i64, i64* %6, i64 256
  %14 = add nuw nsw i32 %7, 256
  %15 = icmp slt i32 %14, %1
  br i1 %15, label %5, label %4
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vbrdl.vsl(i64, i32) #1

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vl.vst.vssl(<256 x double>, i64, i8*, i32) #2

attributes #0 = { nounwind writeonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind writeonly }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 9.0.0 (git@socsv218.svp.cl.nec.co.jp:ve-llvm/clang.git 166ce7eaa48ef1c8891ad1012b2f5819d7674e19) (llvm/llvm.git 538e6ca3317a129b1e492a725935d84bb0a64c7f)"}
