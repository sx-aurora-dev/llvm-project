; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s
; ModuleID = 'gen/tests/vdivswzx_vIvmvl.c'
source_filename = "gen/tests/vdivswzx_vIvmvl.c"
target datalayout = "e-m:e-i64:64-n32:64-S64-v64:64:64-v128:64:64-v256:64:64-v512:64:64-v1024:64:64-v2048:64:64-v4096:64:64-v8192:64:64-v16384:64:64"
target triple = "ve"

; Function Attrs: nounwind
define dso_local void @vdivswzx_vIvmvl(i32*, i32*, i32*, i32*, i32) local_unnamed_addr #0 {
; CHECK: vdivs.w.zx %v2,3,%v0,%vm1
  %6 = icmp sgt i32 %4, 0
  br i1 %6, label %8, label %7

7:                                                ; preds = %8, %5
  ret void

8:                                                ; preds = %5, %8
  %9 = phi i32* [ %26, %8 ], [ %0, %5 ]
  %10 = phi i32* [ %27, %8 ], [ %1, %5 ]
  %11 = phi i32* [ %28, %8 ], [ %2, %5 ]
  %12 = phi i32* [ %29, %8 ], [ %3, %5 ]
  %13 = phi i32 [ %30, %8 ], [ 0, %5 ]
  %14 = sub nsw i32 %4, %13
  %15 = icmp slt i32 %14, 256
  %16 = select i1 %15, i32 %14, i32 256
  %17 = bitcast i32* %10 to i8*
  %18 = tail call <256 x double> @llvm.ve.vl.vldlsx.vssl(i64 4, i8* %17, i32 %16)
  %19 = bitcast i32* %11 to i8*
  %20 = tail call <256 x double> @llvm.ve.vl.vldlzx.vssl(i64 4, i8* %19, i32 %16)
  %21 = tail call <4 x i64> @llvm.ve.vl.vfmkwgt.mvl(<256 x double> %20, i32 %16)
  %22 = bitcast i32* %12 to i8*
  %23 = tail call <256 x double> @llvm.ve.vl.vldlsx.vssl(i64 4, i8* %22, i32 %16)
  %24 = bitcast i32* %9 to i8*
  %25 = tail call <256 x double> @llvm.ve.vl.vdivswzx.vsvmvl(i32 3, <256 x double> %18, <4 x i64> %21, <256 x double> %23, i32 %16)
  tail call void @llvm.ve.vl.vstl.vssl(<256 x double> %25, i64 4, i8* %24, i32 %16)
  %26 = getelementptr inbounds i32, i32* %9, i64 256
  %27 = getelementptr inbounds i32, i32* %10, i64 256
  %28 = getelementptr inbounds i32, i32* %11, i64 256
  %29 = getelementptr inbounds i32, i32* %12, i64 256
  %30 = add nuw nsw i32 %13, 256
  %31 = icmp slt i32 %30, %4
  br i1 %31, label %8, label %7
}

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vldlsx.vssl(i64, i8*, i32) #1

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vldlzx.vssl(i64, i8*, i32) #1

; Function Attrs: nounwind readnone
declare <4 x i64> @llvm.ve.vl.vfmkwgt.mvl(<256 x double>, i32) #2

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vdivswzx.vsvmvl(i32, <256 x double>, <4 x i64>, <256 x double>, i32) #2

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vl.vstl.vssl(<256 x double>, i64, i8*, i32) #3

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind writeonly }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 9.0.0 (git@socsv218.svp.cl.nec.co.jp:ve-llvm/clang.git 166ce7eaa48ef1c8891ad1012b2f5819d7674e19) (llvm/llvm.git 538e6ca3317a129b1e492a725935d84bb0a64c7f)"}
