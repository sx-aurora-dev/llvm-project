; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=+packed | FileCheck %s
; ModuleID = 'gen/tests/pvfmsb_vvvvl.c'
source_filename = "gen/tests/pvfmsb_vvvvl.c"
target datalayout = "e-m:e-i64:64-n32:64-S128-v64:64:64-v128:64:64-v256:64:64-v512:64:64-v1024:64:64-v2048:64:64-v4096:64:64-v8192:64:64-v16384:64:64"
target triple = "ve-unknown-linux-gnu"

; Function Attrs: nounwind
define dso_local void @pvfmsb_vvvvl(float* %0, float* %1, float* %2, float* %3, i32 signext %4) local_unnamed_addr #0 {
; CHECK: pvfmsb %v0, %v0, %v1, %v2
  %6 = icmp sgt i32 %4, 0
  br i1 %6, label %8, label %7

7:                                                ; preds = %8, %5
  ret void

8:                                                ; preds = %5, %8
  %9 = phi float* [ %26, %8 ], [ %0, %5 ]
  %10 = phi float* [ %27, %8 ], [ %1, %5 ]
  %11 = phi float* [ %28, %8 ], [ %2, %5 ]
  %12 = phi float* [ %29, %8 ], [ %3, %5 ]
  %13 = phi i32 [ %30, %8 ], [ 0, %5 ]
  %14 = sub nsw i32 %4, %13
  %15 = icmp slt i32 %14, 512
  %16 = ashr i32 %14, 1
  %17 = select i1 %15, i32 %16, i32 256
  %18 = bitcast float* %10 to i8*
  %19 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %18, i32 %17)
  %20 = bitcast float* %11 to i8*
  %21 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %20, i32 %17)
  %22 = bitcast float* %12 to i8*
  %23 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %22, i32 %17)
  %24 = tail call <256 x double> @llvm.ve.vl.pvfmsb.vvvvl(<256 x double> %19, <256 x double> %21, <256 x double> %23, i32 %17)
  %25 = bitcast float* %9 to i8*
  tail call void @llvm.ve.vl.vst.vssl(<256 x double> %24, i64 8, i8* %25, i32 %17)
  %26 = getelementptr inbounds float, float* %9, i64 512
  %27 = getelementptr inbounds float, float* %10, i64 512
  %28 = getelementptr inbounds float, float* %11, i64 512
  %29 = getelementptr inbounds float, float* %12, i64 512
  %30 = add nuw nsw i32 %13, 512
  %31 = icmp slt i32 %30, %4
  br i1 %31, label %8, label %7
}

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vld.vssl(i64, i8*, i32) #1

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.pvfmsb.vvvvl(<256 x double>, <256 x double>, <256 x double>, i32) #2

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
