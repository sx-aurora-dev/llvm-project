; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=+velintrin | FileCheck %s
; ModuleID = 'gen/tests/pvfmsb_vvvvMvl.c'
source_filename = "gen/tests/pvfmsb_vvvvMvl.c"
target datalayout = "e-m:e-i64:64-n32:64-S64-v64:64:64-v128:64:64-v256:64:64-v512:64:64-v1024:64:64-v2048:64:64-v4096:64:64-v8192:64:64-v16384:64:64"
target triple = "ve"

; Function Attrs: nounwind
define dso_local void @pvfmsb_vvvvMvl(float*, float*, float*, float*, i32*, float*, i32) local_unnamed_addr #0 {
; CHECK: pvfmsb %v4,%v0,%v1,%v2,%vm2
  %8 = icmp sgt i32 %6, 0
  br i1 %8, label %10, label %9

9:                                                ; preds = %10, %7
  ret void

10:                                               ; preds = %7, %10
  %11 = phi float* [ %35, %10 ], [ %0, %7 ]
  %12 = phi float* [ %36, %10 ], [ %1, %7 ]
  %13 = phi float* [ %37, %10 ], [ %2, %7 ]
  %14 = phi float* [ %38, %10 ], [ %3, %7 ]
  %15 = phi i32* [ %39, %10 ], [ %4, %7 ]
  %16 = phi float* [ %40, %10 ], [ %5, %7 ]
  %17 = phi i32 [ %41, %10 ], [ 0, %7 ]
  %18 = sub nsw i32 %6, %17
  %19 = icmp slt i32 %18, 512
  %20 = ashr i32 %18, 1
  %21 = select i1 %19, i32 %20, i32 256
  %22 = bitcast float* %12 to i8*
  %23 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %22, i32 %21)
  %24 = bitcast float* %13 to i8*
  %25 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %24, i32 %21)
  %26 = bitcast float* %14 to i8*
  %27 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %26, i32 %21)
  %28 = bitcast i32* %15 to i8*
  %29 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %28, i32 %21)
  %30 = tail call <8 x i64> @llvm.ve.vl.pvfmkwgt.Mvl(<256 x double> %29, i32 %21)
  %31 = bitcast float* %16 to i8*
  %32 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %31, i32 %21)
  %33 = bitcast float* %11 to i8*
  %34 = tail call <256 x double> @llvm.ve.vl.pvfmsb.vvvvMvl(<256 x double> %23, <256 x double> %25, <256 x double> %27, <8 x i64> %30, <256 x double> %32, i32 %21)
  tail call void @llvm.ve.vl.vst.vssl(<256 x double> %34, i64 8, i8* %33, i32 %21)
  %35 = getelementptr inbounds float, float* %11, i64 512
  %36 = getelementptr inbounds float, float* %12, i64 512
  %37 = getelementptr inbounds float, float* %13, i64 512
  %38 = getelementptr inbounds float, float* %14, i64 512
  %39 = getelementptr inbounds i32, i32* %15, i64 512
  %40 = getelementptr inbounds float, float* %16, i64 512
  %41 = add nuw nsw i32 %17, 512
  %42 = icmp slt i32 %41, %6
  br i1 %42, label %10, label %9
}

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vld.vssl(i64, i8*, i32) #1

; Function Attrs: nounwind readnone
declare <8 x i64> @llvm.ve.vl.pvfmkwgt.Mvl(<256 x double>, i32) #2

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.pvfmsb.vvvvMvl(<256 x double>, <256 x double>, <256 x double>, <8 x i64>, <256 x double>, i32) #2

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
