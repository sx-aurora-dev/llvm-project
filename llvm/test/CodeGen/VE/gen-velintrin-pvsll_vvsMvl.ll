; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s
; ModuleID = 'gen/tests/pvsll_vvsMvl.c'
source_filename = "gen/tests/pvsll_vvsMvl.c"
target datalayout = "e-m:e-i64:64-n32:64-S64-v64:64:64-v128:64:64-v256:64:64-v512:64:64-v1024:64:64-v2048:64:64-v4096:64:64-v8192:64:64-v16384:64:64"
target triple = "ve"

; Function Attrs: nounwind
define dso_local void @pvsll_vvsMvl(i32*, i32*, i64, i32*, i32*, i32) local_unnamed_addr #0 {
; CHECK: pvsll %v2,%v0,%s2,%vm2
  %7 = icmp sgt i32 %5, 0
  br i1 %7, label %9, label %8

8:                                                ; preds = %9, %6
  ret void

9:                                                ; preds = %6, %9
  %10 = phi i32* [ %28, %9 ], [ %0, %6 ]
  %11 = phi i32* [ %29, %9 ], [ %1, %6 ]
  %12 = phi i32* [ %30, %9 ], [ %3, %6 ]
  %13 = phi i32* [ %31, %9 ], [ %4, %6 ]
  %14 = phi i32 [ %32, %9 ], [ 0, %6 ]
  %15 = sub nsw i32 %5, %14
  %16 = icmp slt i32 %15, 512
  %17 = ashr i32 %15, 1
  %18 = select i1 %16, i32 %17, i32 256
  %19 = bitcast i32* %11 to i8*
  %20 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %19, i32 %18)
  %21 = bitcast i32* %12 to i8*
  %22 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %21, i32 %18)
  %23 = tail call <8 x i64> @llvm.ve.vl.pvfmkwgt.Mvl(<256 x double> %22, i32 %18)
  %24 = bitcast i32* %13 to i8*
  %25 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %24, i32 %18)
  %26 = bitcast i32* %10 to i8*
  %27 = tail call <256 x double> @llvm.ve.vl.pvsll.vvsMvl(<256 x double> %20, i64 %2, <8 x i64> %23, <256 x double> %25, i32 %18)
  tail call void @llvm.ve.vl.vst.vssl(<256 x double> %27, i64 8, i8* %26, i32 %18)
  %28 = getelementptr inbounds i32, i32* %10, i64 512
  %29 = getelementptr inbounds i32, i32* %11, i64 512
  %30 = getelementptr inbounds i32, i32* %12, i64 512
  %31 = getelementptr inbounds i32, i32* %13, i64 512
  %32 = add nuw nsw i32 %14, 512
  %33 = icmp slt i32 %32, %5
  br i1 %33, label %9, label %8
}

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vld.vssl(i64, i8*, i32) #1

; Function Attrs: nounwind readnone
declare <8 x i64> @llvm.ve.vl.pvfmkwgt.Mvl(<256 x double>, i32) #2

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.pvsll.vvsMvl(<256 x double>, i64, <8 x i64>, <256 x double>, i32) #2

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
