; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=+packed | FileCheck %s
; ModuleID = 'gen/tests/pvaddu_vvvMvl.c'
source_filename = "gen/tests/pvaddu_vvvMvl.c"
target datalayout = "e-m:e-i64:64-n32:64-S128-v64:64:64-v128:64:64-v256:64:64-v512:64:64-v1024:64:64-v2048:64:64-v4096:64:64-v8192:64:64-v16384:64:64"
target triple = "ve-unknown-linux-gnu"

; Function Attrs: nounwind
define dso_local void @pvaddu_vvvMvl(i32* %0, i32* %1, i32* %2, i32* %3, i32* %4, i32 signext %5) local_unnamed_addr #0 {
; CHECK: pvaddu %v3, %v0, %v1, %vm2
  %7 = icmp sgt i32 %5, 0
  br i1 %7, label %9, label %8

8:                                                ; preds = %9, %6
  ret void

9:                                                ; preds = %6, %9
  %10 = phi i32* [ %31, %9 ], [ %0, %6 ]
  %11 = phi i32* [ %32, %9 ], [ %1, %6 ]
  %12 = phi i32* [ %33, %9 ], [ %2, %6 ]
  %13 = phi i32* [ %34, %9 ], [ %3, %6 ]
  %14 = phi i32* [ %35, %9 ], [ %4, %6 ]
  %15 = phi i32 [ %36, %9 ], [ 0, %6 ]
  %16 = sub nsw i32 %5, %15
  %17 = icmp slt i32 %16, 512
  %18 = ashr i32 %16, 1
  %19 = select i1 %17, i32 %18, i32 256
  %20 = bitcast i32* %11 to i8*
  %21 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %20, i32 %19)
  %22 = bitcast i32* %12 to i8*
  %23 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %22, i32 %19)
  %24 = bitcast i32* %13 to i8*
  %25 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %24, i32 %19)
  %26 = tail call <512 x i1> @llvm.ve.vl.pvfmkwgt.Mvl(<256 x double> %25, i32 %19)
  %27 = bitcast i32* %14 to i8*
  %28 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %27, i32 %19)
  %29 = bitcast i32* %10 to i8*
  %30 = tail call <256 x double> @llvm.ve.vl.pvaddu.vvvMvl(<256 x double> %21, <256 x double> %23, <512 x i1> %26, <256 x double> %28, i32 %19)
  tail call void @llvm.ve.vl.vst.vssl(<256 x double> %30, i64 8, i8* %29, i32 %19)
  %31 = getelementptr inbounds i32, i32* %10, i64 512
  %32 = getelementptr inbounds i32, i32* %11, i64 512
  %33 = getelementptr inbounds i32, i32* %12, i64 512
  %34 = getelementptr inbounds i32, i32* %13, i64 512
  %35 = getelementptr inbounds i32, i32* %14, i64 512
  %36 = add nuw nsw i32 %15, 512
  %37 = icmp slt i32 %36, %5
  br i1 %37, label %9, label %8
}

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vld.vssl(i64, i8*, i32) #1

; Function Attrs: nounwind readnone
declare <512 x i1> @llvm.ve.vl.pvfmkwgt.Mvl(<256 x double>, i32) #2

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.pvaddu.vvvMvl(<256 x double>, <256 x double>, <512 x i1>, <256 x double>, i32) #2

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vl.vst.vssl(<256 x double>, i64, i8*, i32) #3

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="-vec" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind writeonly }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (git@socsv218.svp.cl.nec.co.jp:ve-llvm/llvm-project.git ea1e45464a3c0492368cbabae9242628b03e399d)"}
