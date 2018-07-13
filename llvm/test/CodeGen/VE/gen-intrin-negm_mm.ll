; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s
; ModuleID = 'gen/tests/negm_mm.c'
source_filename = "gen/tests/negm_mm.c"
target datalayout = "e-m:e-i64:64-n32:64-S64-v16384:64:64"
target triple = "ve"

; Function Attrs: nounwind
define dso_local void @negm_mm(i64* nocapture %px, i64* nocapture readonly %py, i64* nocapture readnone %pz, i32 %n) local_unnamed_addr #0 {
; CHECK-LABEL: negm_mm
; CHECK: .LBB0_2
; CHECK: 	negm %vm1,%vm1
entry:
  %0 = load i64, i64* %py, align 8, !tbaa !2
  %1 = tail call <4 x i64> @llvm.ve.lvm.mmss(<4 x i64> undef, i64 0, i64 %0)
  %arrayidx2 = getelementptr inbounds i64, i64* %py, i64 1
  %2 = load i64, i64* %arrayidx2, align 8, !tbaa !2
  %3 = tail call <4 x i64> @llvm.ve.lvm.mmss(<4 x i64> %1, i64 1, i64 %2)
  %arrayidx4 = getelementptr inbounds i64, i64* %py, i64 2
  %4 = load i64, i64* %arrayidx4, align 8, !tbaa !2
  %5 = tail call <4 x i64> @llvm.ve.lvm.mmss(<4 x i64> %3, i64 2, i64 %4)
  %arrayidx6 = getelementptr inbounds i64, i64* %py, i64 3
  %6 = load i64, i64* %arrayidx6, align 8, !tbaa !2
  %7 = tail call <4 x i64> @llvm.ve.lvm.mmss(<4 x i64> %5, i64 3, i64 %6)
  %8 = tail call <4 x i64> @llvm.ve.negm.mm(<4 x i64> %7)
  %9 = tail call i64 @llvm.ve.svm.sms(<4 x i64> %8, i64 0)
  store i64 %9, i64* %px, align 8, !tbaa !2
  %10 = tail call i64 @llvm.ve.svm.sms(<4 x i64> %8, i64 1)
  %arrayidx9 = getelementptr inbounds i64, i64* %px, i64 1
  store i64 %10, i64* %arrayidx9, align 8, !tbaa !2
  %11 = tail call i64 @llvm.ve.svm.sms(<4 x i64> %8, i64 2)
  %arrayidx10 = getelementptr inbounds i64, i64* %px, i64 2
  store i64 %11, i64* %arrayidx10, align 8, !tbaa !2
  %12 = tail call i64 @llvm.ve.svm.sms(<4 x i64> %8, i64 3)
  %arrayidx11 = getelementptr inbounds i64, i64* %px, i64 3
  store i64 %12, i64* %arrayidx11, align 8, !tbaa !2
  ret void
}

; Function Attrs: nounwind readnone
declare <4 x i64> @llvm.ve.lvm.mmss(<4 x i64>, i64, i64) #1

; Function Attrs: nounwind readnone
declare <4 x i64> @llvm.ve.negm.mm(<4 x i64>) #1

; Function Attrs: nounwind readnone
declare i64 @llvm.ve.svm.sms(<4 x i64>, i64) #1

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 7.0.0 (git@socsv218.svp.cl.nec.co.jp:ve-llvm/clang.git 75fd1a3a6a07de8889d08fb9dd1eb1c0940e62a5) (llvm/llvm.git 882a992d251d96ec3ff0729ba24e71b2e10b6eda)"}
!2 = !{!3, !3, i64 0}
!3 = !{!"long", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
