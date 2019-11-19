; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s
; ModuleID = 'gen/tests/vsubsl_vsvl.c'
source_filename = "gen/tests/vsubsl_vsvl.c"
target datalayout = "e-m:e-i64:64-n32:64-S64-v64:64:64-v128:64:64-v256:64:64-v512:64:64-v1024:64:64-v2048:64:64-v4096:64:64-v8192:64:64-v16384:64:64"
target triple = "ve"

; Function Attrs: nounwind
define dso_local void @vsubsl_vsvl(i64*, i64, i64*, i32) local_unnamed_addr #0 {
; CHECK: vsubs.l %v0,%s1,%v0
  %5 = icmp sgt i32 %3, 0
  br i1 %5, label %7, label %6

6:                                                ; preds = %7, %4
  ret void

7:                                                ; preds = %4, %7
  %8 = phi i64* [ %18, %7 ], [ %0, %4 ]
  %9 = phi i64* [ %19, %7 ], [ %2, %4 ]
  %10 = phi i32 [ %20, %7 ], [ 0, %4 ]
  %11 = sub nsw i32 %3, %10
  %12 = icmp slt i32 %11, 256
  %13 = select i1 %12, i32 %11, i32 256
  %14 = bitcast i64* %9 to i8*
  %15 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %14, i32 %13)
  %16 = tail call <256 x double> @llvm.ve.vl.vsubsl.vsvl(i64 %1, <256 x double> %15, i32 %13)
  %17 = bitcast i64* %8 to i8*
  tail call void @llvm.ve.vl.vst.vssl(<256 x double> %16, i64 8, i8* %17, i32 %13)
  %18 = getelementptr inbounds i64, i64* %8, i64 256
  %19 = getelementptr inbounds i64, i64* %9, i64 256
  %20 = add nuw nsw i32 %10, 256
  %21 = icmp slt i32 %20, %3
  br i1 %21, label %7, label %6
}

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vld.vssl(i64, i8*, i32) #1

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vsubsl.vsvl(i64, <256 x double>, i32) #2

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vl.vst.vssl(<256 x double>, i64, i8*, i32) #3

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind writeonly }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 9.0.0 (git@socsv218.svp.cl.nec.co.jp:ve-llvm/clang.git 166ce7eaa48ef1c8891ad1012b2f5819d7674e19) (llvm/llvm.git 538e6ca3317a129b1e492a725935d84bb0a64c7f)"}
