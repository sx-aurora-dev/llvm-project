; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s
; ModuleID = 'gen/tests/vmrg_vvvmvl.c'
source_filename = "gen/tests/vmrg_vvvmvl.c"
target datalayout = "e-m:e-i64:64-n32:64-S64-v64:64:64-v128:64:64-v256:64:64-v512:64:64-v1024:64:64-v2048:64:64-v4096:64:64-v8192:64:64-v16384:64:64"
target triple = "ve"

; Function Attrs: nounwind
define dso_local void @vmrg_vvvmvl(i64*, i64*, i64*, i32*, i64*, i32) local_unnamed_addr #0 {
; CHECK: vmrg %v2,%v0,%v1,%vm1
  %7 = icmp sgt i32 %5, 0
  br i1 %7, label %8, label %10

8:                                                ; preds = %6
  %9 = bitcast i64* %4 to i8*
  br label %11

10:                                               ; preds = %11, %6
  ret void

11:                                               ; preds = %8, %11
  %12 = phi i64* [ %0, %8 ], [ %30, %11 ]
  %13 = phi i64* [ %1, %8 ], [ %31, %11 ]
  %14 = phi i64* [ %2, %8 ], [ %32, %11 ]
  %15 = phi i32* [ %3, %8 ], [ %33, %11 ]
  %16 = phi i32 [ 0, %8 ], [ %34, %11 ]
  %17 = sub nsw i32 %5, %16
  %18 = icmp slt i32 %17, 256
  %19 = select i1 %18, i32 %17, i32 256
  %20 = bitcast i64* %13 to i8*
  %21 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %20, i32 %19)
  %22 = bitcast i64* %14 to i8*
  %23 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %22, i32 %19)
  %24 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %9, i32 %19)
  %25 = bitcast i32* %15 to i8*
  %26 = tail call <256 x double> @llvm.ve.vl.vldlzx.vssl(i64 4, i8* %25, i32 %19)
  %27 = tail call <4 x i64> @llvm.ve.vl.vfmkwgt.mvl(<256 x double> %26, i32 %19)
  %28 = tail call <256 x double> @llvm.ve.vl.vmrg.vvvmvl(<256 x double> %21, <256 x double> %23, <4 x i64> %27, <256 x double> %24, i32 %19)
  %29 = bitcast i64* %12 to i8*
  tail call void @llvm.ve.vl.vst.vssl(<256 x double> %28, i64 8, i8* %29, i32 %19)
  %30 = getelementptr inbounds i64, i64* %12, i64 256
  %31 = getelementptr inbounds i64, i64* %13, i64 256
  %32 = getelementptr inbounds i64, i64* %14, i64 256
  %33 = getelementptr inbounds i32, i32* %15, i64 256
  %34 = add nuw nsw i32 %16, 256
  %35 = icmp slt i32 %34, %5
  br i1 %35, label %11, label %10
}

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vld.vssl(i64, i8*, i32) #1

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vldlzx.vssl(i64, i8*, i32) #1

; Function Attrs: nounwind readnone
declare <4 x i64> @llvm.ve.vl.vfmkwgt.mvl(<256 x double>, i32) #2

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vmrg.vvvmvl(<256 x double>, <256 x double>, <4 x i64>, <256 x double>, i32) #2

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vl.vst.vssl(<256 x double>, i64, i8*, i32) #3

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind writeonly }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 9.0.0 (git@socsv218.svp.cl.nec.co.jp:ve-llvm/clang.git c83f0c8a7ae70ca3c57e0ec276ea24620728f2b0) (llvm/llvm.git 9a2e6d1cb1ed394f7fc8848e0a2f1d19cbbe7182)"}
