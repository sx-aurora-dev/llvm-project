; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=+velintrin | FileCheck %s
; ModuleID = 'gen/tests/andm_mmm.c'
source_filename = "gen/tests/andm_mmm.c"
target datalayout = "e-m:e-i64:64-n32:64-S64-v64:64:64-v128:64:64-v256:64:64-v512:64:64-v1024:64:64-v2048:64:64-v4096:64:64-v8192:64:64-v16384:64:64"
target triple = "ve"

; Function Attrs: nounwind
define dso_local void @andm_mmm(i64* nocapture, i64* nocapture readonly, i64* nocapture readonly, i32) local_unnamed_addr #0 {
; CHECK: andm %vm1,%vm1,%vm2
  %5 = load i64, i64* %1, align 8, !tbaa !2
  %6 = tail call <4 x i64> @llvm.ve.vl.lvm.mmss(<4 x i64> undef, i64 0, i64 %5)
  %7 = load i64, i64* %2, align 8, !tbaa !2
  %8 = tail call <4 x i64> @llvm.ve.vl.lvm.mmss(<4 x i64> undef, i64 0, i64 %7)
  %9 = getelementptr inbounds i64, i64* %1, i64 1
  %10 = load i64, i64* %9, align 8, !tbaa !2
  %11 = tail call <4 x i64> @llvm.ve.vl.lvm.mmss(<4 x i64> %6, i64 1, i64 %10)
  %12 = getelementptr inbounds i64, i64* %2, i64 1
  %13 = load i64, i64* %12, align 8, !tbaa !2
  %14 = tail call <4 x i64> @llvm.ve.vl.lvm.mmss(<4 x i64> %8, i64 1, i64 %13)
  %15 = getelementptr inbounds i64, i64* %1, i64 2
  %16 = load i64, i64* %15, align 8, !tbaa !2
  %17 = tail call <4 x i64> @llvm.ve.vl.lvm.mmss(<4 x i64> %11, i64 2, i64 %16)
  %18 = getelementptr inbounds i64, i64* %2, i64 2
  %19 = load i64, i64* %18, align 8, !tbaa !2
  %20 = tail call <4 x i64> @llvm.ve.vl.lvm.mmss(<4 x i64> %14, i64 2, i64 %19)
  %21 = getelementptr inbounds i64, i64* %1, i64 3
  %22 = load i64, i64* %21, align 8, !tbaa !2
  %23 = tail call <4 x i64> @llvm.ve.vl.lvm.mmss(<4 x i64> %17, i64 3, i64 %22)
  %24 = getelementptr inbounds i64, i64* %2, i64 3
  %25 = load i64, i64* %24, align 8, !tbaa !2
  %26 = tail call <4 x i64> @llvm.ve.vl.lvm.mmss(<4 x i64> %20, i64 3, i64 %25)
  %27 = tail call <4 x i64> @llvm.ve.vl.andm.mmm(<4 x i64> %23, <4 x i64> %26)
  %28 = tail call i64 @llvm.ve.vl.svm.sms(<4 x i64> %27, i64 0)
  store i64 %28, i64* %0, align 8, !tbaa !2
  %29 = tail call i64 @llvm.ve.vl.svm.sms(<4 x i64> %27, i64 1)
  %30 = getelementptr inbounds i64, i64* %0, i64 1
  store i64 %29, i64* %30, align 8, !tbaa !2
  %31 = tail call i64 @llvm.ve.vl.svm.sms(<4 x i64> %27, i64 2)
  %32 = getelementptr inbounds i64, i64* %0, i64 2
  store i64 %31, i64* %32, align 8, !tbaa !2
  %33 = tail call i64 @llvm.ve.vl.svm.sms(<4 x i64> %27, i64 3)
  %34 = getelementptr inbounds i64, i64* %0, i64 3
  store i64 %33, i64* %34, align 8, !tbaa !2
  ret void
}

; Function Attrs: nounwind readnone
declare <4 x i64> @llvm.ve.vl.lvm.mmss(<4 x i64>, i64, i64) #1

; Function Attrs: nounwind readnone
declare <4 x i64> @llvm.ve.vl.andm.mmm(<4 x i64>, <4 x i64>) #1

; Function Attrs: nounwind readnone
declare i64 @llvm.ve.vl.svm.sms(<4 x i64>, i64) #1

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 9.0.0 (git@socsv218.svp.cl.nec.co.jp:ve-llvm/clang.git 166ce7eaa48ef1c8891ad1012b2f5819d7674e19) (llvm/llvm.git 538e6ca3317a129b1e492a725935d84bb0a64c7f)"}
!2 = !{!3, !3, i64 0}
!3 = !{!"long", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
