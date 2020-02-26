; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s
; ModuleID = 'gen/tests/negm_mm.c'
source_filename = "gen/tests/negm_mm.c"
target datalayout = "e-m:e-i64:64-n32:64-S64-v64:64:64-v128:64:64-v256:64:64-v512:64:64-v1024:64:64-v2048:64:64-v4096:64:64-v8192:64:64-v16384:64:64"
target triple = "ve"

; Function Attrs: nounwind
define dso_local void @negm_mm(i64* nocapture, i64* nocapture readonly, i64* nocapture readnone, i32) local_unnamed_addr #0 {
; CHECK: negm %vm1,%vm1
  %5 = load i64, i64* %1, align 8, !tbaa !2
  %6 = tail call <4 x i64> @llvm.ve.vl.lvm.mmss(<4 x i64> undef, i64 0, i64 %5)
  %7 = getelementptr inbounds i64, i64* %1, i64 1
  %8 = load i64, i64* %7, align 8, !tbaa !2
  %9 = tail call <4 x i64> @llvm.ve.vl.lvm.mmss(<4 x i64> %6, i64 1, i64 %8)
  %10 = getelementptr inbounds i64, i64* %1, i64 2
  %11 = load i64, i64* %10, align 8, !tbaa !2
  %12 = tail call <4 x i64> @llvm.ve.vl.lvm.mmss(<4 x i64> %9, i64 2, i64 %11)
  %13 = getelementptr inbounds i64, i64* %1, i64 3
  %14 = load i64, i64* %13, align 8, !tbaa !2
  %15 = tail call <4 x i64> @llvm.ve.vl.lvm.mmss(<4 x i64> %12, i64 3, i64 %14)
  %16 = tail call <4 x i64> @llvm.ve.vl.negm.mm(<4 x i64> %15)
  %17 = tail call i64 @llvm.ve.vl.svm.sms(<4 x i64> %16, i64 0)
  store i64 %17, i64* %0, align 8, !tbaa !2
  %18 = tail call i64 @llvm.ve.vl.svm.sms(<4 x i64> %16, i64 1)
  %19 = getelementptr inbounds i64, i64* %0, i64 1
  store i64 %18, i64* %19, align 8, !tbaa !2
  %20 = tail call i64 @llvm.ve.vl.svm.sms(<4 x i64> %16, i64 2)
  %21 = getelementptr inbounds i64, i64* %0, i64 2
  store i64 %20, i64* %21, align 8, !tbaa !2
  %22 = tail call i64 @llvm.ve.vl.svm.sms(<4 x i64> %16, i64 3)
  %23 = getelementptr inbounds i64, i64* %0, i64 3
  store i64 %22, i64* %23, align 8, !tbaa !2
  ret void
}

; Function Attrs: nounwind readnone
declare <4 x i64> @llvm.ve.vl.lvm.mmss(<4 x i64>, i64, i64) #1

; Function Attrs: nounwind readnone
declare <4 x i64> @llvm.ve.vl.negm.mm(<4 x i64>) #1

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
