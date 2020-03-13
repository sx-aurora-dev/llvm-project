; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=velintrin | FileCheck %s
; ModuleID = 'gen/tests/vmaxswsx_vsvmvl.c'
source_filename = "gen/tests/vmaxswsx_vsvmvl.c"
target datalayout = "e-m:e-i64:64-n32:64-S64-v64:64:64-v128:64:64-v256:64:64-v512:64:64-v1024:64:64-v2048:64:64-v4096:64:64-v8192:64:64-v16384:64:64"
target triple = "ve"

; Function Attrs: nounwind
define dso_local void @vmaxswsx_vsvmvl(i32*, i32, i32*, i32*, i32*, i32) local_unnamed_addr #0 {
; CHECK: vmaxs.w.sx %v2,%s1,%v0,%vm1
  %7 = icmp sgt i32 %5, 0
  br i1 %7, label %9, label %8

8:                                                ; preds = %9, %6
  ret void

9:                                                ; preds = %6, %9
  %10 = phi i32* [ %27, %9 ], [ %0, %6 ]
  %11 = phi i32* [ %28, %9 ], [ %2, %6 ]
  %12 = phi i32* [ %29, %9 ], [ %3, %6 ]
  %13 = phi i32* [ %30, %9 ], [ %4, %6 ]
  %14 = phi i32 [ %31, %9 ], [ 0, %6 ]
  %15 = sub nsw i32 %5, %14
  %16 = icmp slt i32 %15, 256
  %17 = select i1 %16, i32 %15, i32 256
  %18 = bitcast i32* %11 to i8*
  %19 = tail call <256 x double> @llvm.ve.vl.vldlsx.vssl(i64 4, i8* %18, i32 %17)
  %20 = bitcast i32* %12 to i8*
  %21 = tail call <256 x double> @llvm.ve.vl.vldlzx.vssl(i64 4, i8* %20, i32 %17)
  %22 = tail call <4 x i64> @llvm.ve.vl.vfmkwgt.mvl(<256 x double> %21, i32 %17)
  %23 = bitcast i32* %13 to i8*
  %24 = tail call <256 x double> @llvm.ve.vl.vldlsx.vssl(i64 4, i8* %23, i32 %17)
  %25 = bitcast i32* %10 to i8*
  %26 = tail call <256 x double> @llvm.ve.vl.vmaxswsx.vsvmvl(i32 %1, <256 x double> %19, <4 x i64> %22, <256 x double> %24, i32 %17)
  tail call void @llvm.ve.vl.vstl.vssl(<256 x double> %26, i64 4, i8* %25, i32 %17)
  %27 = getelementptr inbounds i32, i32* %10, i64 256
  %28 = getelementptr inbounds i32, i32* %11, i64 256
  %29 = getelementptr inbounds i32, i32* %12, i64 256
  %30 = getelementptr inbounds i32, i32* %13, i64 256
  %31 = add nuw nsw i32 %14, 256
  %32 = icmp slt i32 %31, %5
  br i1 %32, label %9, label %8
}

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vldlsx.vssl(i64, i8*, i32) #1

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vldlzx.vssl(i64, i8*, i32) #1

; Function Attrs: nounwind readnone
declare <4 x i64> @llvm.ve.vl.vfmkwgt.mvl(<256 x double>, i32) #2

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vmaxswsx.vsvmvl(i32, <256 x double>, <4 x i64>, <256 x double>, i32) #2

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
