; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=velintrin | FileCheck %s
; ModuleID = 'gen/tests/vbrdl_vsmvl.c'
source_filename = "gen/tests/vbrdl_vsmvl.c"
target datalayout = "e-m:e-i64:64-n32:64-S64-v64:64:64-v128:64:64-v256:64:64-v512:64:64-v1024:64:64-v2048:64:64-v4096:64:64-v8192:64:64-v16384:64:64"
target triple = "ve"

; Function Attrs: nounwind
define dso_local void @vbrdl_vsmvl(i64*, i64, i32*, i64*, i32) local_unnamed_addr #0 {
; CHECK: vbrd %v1,%s1,%vm1
  %6 = icmp sgt i32 %4, 0
  br i1 %6, label %8, label %7

7:                                                ; preds = %8, %5
  ret void

8:                                                ; preds = %5, %8
  %9 = phi i64* [ %23, %8 ], [ %0, %5 ]
  %10 = phi i32* [ %24, %8 ], [ %2, %5 ]
  %11 = phi i64* [ %25, %8 ], [ %3, %5 ]
  %12 = phi i32 [ %26, %8 ], [ 0, %5 ]
  %13 = sub nsw i32 %4, %12
  %14 = icmp slt i32 %13, 256
  %15 = select i1 %14, i32 %13, i32 256
  %16 = bitcast i32* %10 to i8*
  %17 = tail call <256 x double> @llvm.ve.vl.vldlzx.vssl(i64 4, i8* %16, i32 %15)
  %18 = tail call <4 x i64> @llvm.ve.vl.vfmkwgt.mvl(<256 x double> %17, i32 %15)
  %19 = bitcast i64* %11 to i8*
  %20 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %19, i32 %15)
  %21 = bitcast i64* %9 to i8*
  %22 = tail call <256 x double> @llvm.ve.vl.vbrdl.vsmvl(i64 %1, <4 x i64> %18, <256 x double> %20, i32 %15)
  tail call void @llvm.ve.vl.vst.vssl(<256 x double> %22, i64 8, i8* %21, i32 %15)
  %23 = getelementptr inbounds i64, i64* %9, i64 256
  %24 = getelementptr inbounds i32, i32* %10, i64 256
  %25 = getelementptr inbounds i64, i64* %11, i64 256
  %26 = add nuw nsw i32 %12, 256
  %27 = icmp slt i32 %26, %4
  br i1 %27, label %8, label %7
}

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vldlzx.vssl(i64, i8*, i32) #1

; Function Attrs: nounwind readnone
declare <4 x i64> @llvm.ve.vl.vfmkwgt.mvl(<256 x double>, i32) #2

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vld.vssl(i64, i8*, i32) #1

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vbrdl.vsmvl(i64, <4 x i64>, <256 x double>, i32) #2

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
