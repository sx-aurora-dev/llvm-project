; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=+velintrin | FileCheck %s
; ModuleID = 'gen/tests/pvbrd_vsMvl.c'
source_filename = "gen/tests/pvbrd_vsMvl.c"
target datalayout = "e-m:e-i64:64-n32:64-S64-v64:64:64-v128:64:64-v256:64:64-v512:64:64-v1024:64:64-v2048:64:64-v4096:64:64-v8192:64:64-v16384:64:64"
target triple = "ve"

; Function Attrs: nounwind
define dso_local void @pvbrd_vsMvl(i32*, i64, i32*, i32*, i32) local_unnamed_addr #0 {
; CHECK: pvbrd %v1,%s1,%vm2
  %6 = icmp sgt i32 %4, 0
  br i1 %6, label %8, label %7

7:                                                ; preds = %8, %5
  ret void

8:                                                ; preds = %5, %8
  %9 = phi i32* [ %24, %8 ], [ %0, %5 ]
  %10 = phi i32* [ %25, %8 ], [ %2, %5 ]
  %11 = phi i32* [ %26, %8 ], [ %3, %5 ]
  %12 = phi i32 [ %27, %8 ], [ 0, %5 ]
  %13 = sub nsw i32 %4, %12
  %14 = icmp slt i32 %13, 512
  %15 = ashr i32 %13, 1
  %16 = select i1 %14, i32 %15, i32 256
  %17 = bitcast i32* %10 to i8*
  %18 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %17, i32 %16)
  %19 = tail call <8 x i64> @llvm.ve.vl.pvfmkwgt.Mvl(<256 x double> %18, i32 %16)
  %20 = bitcast i32* %11 to i8*
  %21 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %20, i32 %16)
  %22 = bitcast i32* %9 to i8*
  %23 = tail call <256 x double> @llvm.ve.vl.pvbrd.vsMvl(i64 %1, <8 x i64> %19, <256 x double> %21, i32 %16)
  tail call void @llvm.ve.vl.vst.vssl(<256 x double> %23, i64 8, i8* %22, i32 %16)
  %24 = getelementptr inbounds i32, i32* %9, i64 512
  %25 = getelementptr inbounds i32, i32* %10, i64 512
  %26 = getelementptr inbounds i32, i32* %11, i64 512
  %27 = add nuw nsw i32 %12, 512
  %28 = icmp slt i32 %27, %4
  br i1 %28, label %8, label %7
}

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vld.vssl(i64, i8*, i32) #1

; Function Attrs: nounwind readnone
declare <8 x i64> @llvm.ve.vl.pvfmkwgt.Mvl(<256 x double>, i32) #2

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.pvbrd.vsMvl(i64, <8 x i64>, <256 x double>, i32) #2

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
