; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=+velintrin | FileCheck %s
; ModuleID = 'gen/tests/vsfa_vvssmvl.c'
source_filename = "gen/tests/vsfa_vvssmvl.c"
target datalayout = "e-m:e-i64:64-n32:64-S64-v64:64:64-v128:64:64-v256:64:64-v512:64:64-v1024:64:64-v2048:64:64-v4096:64:64-v8192:64:64-v16384:64:64"
target triple = "ve"

; Function Attrs: nounwind
define dso_local void @vsfa_vvssmvl(i64*, i64*, i64, i64, i32*, i64*, i32) local_unnamed_addr #0 {
; CHECK: vsfa %v2,%v0,%s2,%s3,%vm1
  %8 = icmp sgt i32 %6, 0
  br i1 %8, label %10, label %9

9:                                                ; preds = %10, %7
  ret void

10:                                               ; preds = %7, %10
  %11 = phi i64* [ %28, %10 ], [ %0, %7 ]
  %12 = phi i64* [ %29, %10 ], [ %1, %7 ]
  %13 = phi i32* [ %30, %10 ], [ %4, %7 ]
  %14 = phi i64* [ %31, %10 ], [ %5, %7 ]
  %15 = phi i32 [ %32, %10 ], [ 0, %7 ]
  %16 = sub nsw i32 %6, %15
  %17 = icmp slt i32 %16, 256
  %18 = select i1 %17, i32 %16, i32 256
  %19 = bitcast i64* %12 to i8*
  %20 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %19, i32 %18)
  %21 = bitcast i32* %13 to i8*
  %22 = tail call <256 x double> @llvm.ve.vl.vldlzx.vssl(i64 4, i8* %21, i32 %18)
  %23 = tail call <4 x i64> @llvm.ve.vl.vfmkwgt.mvl(<256 x double> %22, i32 %18)
  %24 = bitcast i64* %14 to i8*
  %25 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %24, i32 %18)
  %26 = bitcast i64* %11 to i8*
  %27 = tail call <256 x double> @llvm.ve.vl.vsfa.vvssmvl(<256 x double> %20, i64 %2, i64 %3, <4 x i64> %23, <256 x double> %25, i32 %18)
  tail call void @llvm.ve.vl.vst.vssl(<256 x double> %27, i64 8, i8* %26, i32 %18)
  %28 = getelementptr inbounds i64, i64* %11, i64 256
  %29 = getelementptr inbounds i64, i64* %12, i64 256
  %30 = getelementptr inbounds i32, i32* %13, i64 256
  %31 = getelementptr inbounds i64, i64* %14, i64 256
  %32 = add nuw nsw i32 %15, 256
  %33 = icmp slt i32 %32, %6
  br i1 %33, label %10, label %9
}

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vld.vssl(i64, i8*, i32) #1

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vldlzx.vssl(i64, i8*, i32) #1

; Function Attrs: nounwind readnone
declare <4 x i64> @llvm.ve.vl.vfmkwgt.mvl(<256 x double>, i32) #2

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vsfa.vvssmvl(<256 x double>, i64, i64, <4 x i64>, <256 x double>, i32) #2

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
