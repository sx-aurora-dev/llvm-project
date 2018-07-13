; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s
; ModuleID = 'gen/tests/nndm_MMM.c'
source_filename = "gen/tests/nndm_MMM.c"
target datalayout = "e-m:e-i64:64-n32:64-S64-v16384:64:64"
target triple = "ve"

; Function Attrs: nounwind
define dso_local void @nndm_MMM(i64* nocapture %px, i64* nocapture readonly %py, i64* nocapture readonly %pz, i32 %n) local_unnamed_addr #0 {
; CHECK-LABEL: nndm_MMM
; CHECK: .LBB0_2
; CHECK: 	nndm %vm2,%vm2,%vm4
; CHECK: 	nndm %vm3,%vm3,%vm5
entry:
  %0 = load i64, i64* %py, align 8, !tbaa !2
  %1 = tail call <8 x i64> @llvm.ve.lvm.MMss(<8 x i64> undef, i64 0, i64 %0)
  %2 = load i64, i64* %pz, align 8, !tbaa !2
  %3 = tail call <8 x i64> @llvm.ve.lvm.MMss(<8 x i64> undef, i64 0, i64 %2)
  %arrayidx2 = getelementptr inbounds i64, i64* %py, i64 1
  %4 = load i64, i64* %arrayidx2, align 8, !tbaa !2
  %5 = tail call <8 x i64> @llvm.ve.lvm.MMss(<8 x i64> %1, i64 1, i64 %4)
  %arrayidx3 = getelementptr inbounds i64, i64* %pz, i64 1
  %6 = load i64, i64* %arrayidx3, align 8, !tbaa !2
  %7 = tail call <8 x i64> @llvm.ve.lvm.MMss(<8 x i64> %3, i64 1, i64 %6)
  %arrayidx4 = getelementptr inbounds i64, i64* %py, i64 2
  %8 = load i64, i64* %arrayidx4, align 8, !tbaa !2
  %9 = tail call <8 x i64> @llvm.ve.lvm.MMss(<8 x i64> %5, i64 2, i64 %8)
  %arrayidx5 = getelementptr inbounds i64, i64* %pz, i64 2
  %10 = load i64, i64* %arrayidx5, align 8, !tbaa !2
  %11 = tail call <8 x i64> @llvm.ve.lvm.MMss(<8 x i64> %7, i64 2, i64 %10)
  %arrayidx6 = getelementptr inbounds i64, i64* %py, i64 3
  %12 = load i64, i64* %arrayidx6, align 8, !tbaa !2
  %13 = tail call <8 x i64> @llvm.ve.lvm.MMss(<8 x i64> %9, i64 3, i64 %12)
  %arrayidx7 = getelementptr inbounds i64, i64* %pz, i64 3
  %14 = load i64, i64* %arrayidx7, align 8, !tbaa !2
  %15 = tail call <8 x i64> @llvm.ve.lvm.MMss(<8 x i64> %11, i64 3, i64 %14)
  %arrayidx8 = getelementptr inbounds i64, i64* %py, i64 4
  %16 = load i64, i64* %arrayidx8, align 8, !tbaa !2
  %17 = tail call <8 x i64> @llvm.ve.lvm.MMss(<8 x i64> %13, i64 4, i64 %16)
  %arrayidx9 = getelementptr inbounds i64, i64* %pz, i64 4
  %18 = load i64, i64* %arrayidx9, align 8, !tbaa !2
  %19 = tail call <8 x i64> @llvm.ve.lvm.MMss(<8 x i64> %15, i64 4, i64 %18)
  %arrayidx10 = getelementptr inbounds i64, i64* %py, i64 5
  %20 = load i64, i64* %arrayidx10, align 8, !tbaa !2
  %21 = tail call <8 x i64> @llvm.ve.lvm.MMss(<8 x i64> %17, i64 5, i64 %20)
  %arrayidx11 = getelementptr inbounds i64, i64* %pz, i64 5
  %22 = load i64, i64* %arrayidx11, align 8, !tbaa !2
  %23 = tail call <8 x i64> @llvm.ve.lvm.MMss(<8 x i64> %19, i64 5, i64 %22)
  %arrayidx12 = getelementptr inbounds i64, i64* %py, i64 6
  %24 = load i64, i64* %arrayidx12, align 8, !tbaa !2
  %25 = tail call <8 x i64> @llvm.ve.lvm.MMss(<8 x i64> %21, i64 6, i64 %24)
  %arrayidx13 = getelementptr inbounds i64, i64* %pz, i64 6
  %26 = load i64, i64* %arrayidx13, align 8, !tbaa !2
  %27 = tail call <8 x i64> @llvm.ve.lvm.MMss(<8 x i64> %23, i64 6, i64 %26)
  %arrayidx14 = getelementptr inbounds i64, i64* %py, i64 7
  %28 = load i64, i64* %arrayidx14, align 8, !tbaa !2
  %29 = tail call <8 x i64> @llvm.ve.lvm.MMss(<8 x i64> %25, i64 7, i64 %28)
  %arrayidx15 = getelementptr inbounds i64, i64* %pz, i64 7
  %30 = load i64, i64* %arrayidx15, align 8, !tbaa !2
  %31 = tail call <8 x i64> @llvm.ve.lvm.MMss(<8 x i64> %27, i64 7, i64 %30)
  %32 = tail call <8 x i64> @llvm.ve.nndm.MMM(<8 x i64> %29, <8 x i64> %31)
  %33 = tail call i64 @llvm.ve.svm.sMs(<8 x i64> %32, i64 0)
  store i64 %33, i64* %px, align 8, !tbaa !2
  %34 = tail call i64 @llvm.ve.svm.sMs(<8 x i64> %32, i64 1)
  %arrayidx17 = getelementptr inbounds i64, i64* %px, i64 1
  store i64 %34, i64* %arrayidx17, align 8, !tbaa !2
  %35 = tail call i64 @llvm.ve.svm.sMs(<8 x i64> %32, i64 2)
  %arrayidx18 = getelementptr inbounds i64, i64* %px, i64 2
  store i64 %35, i64* %arrayidx18, align 8, !tbaa !2
  %36 = tail call i64 @llvm.ve.svm.sMs(<8 x i64> %32, i64 3)
  %arrayidx19 = getelementptr inbounds i64, i64* %px, i64 3
  store i64 %36, i64* %arrayidx19, align 8, !tbaa !2
  %37 = tail call i64 @llvm.ve.svm.sMs(<8 x i64> %32, i64 4)
  %arrayidx20 = getelementptr inbounds i64, i64* %px, i64 4
  store i64 %37, i64* %arrayidx20, align 8, !tbaa !2
  %38 = tail call i64 @llvm.ve.svm.sMs(<8 x i64> %32, i64 5)
  %arrayidx21 = getelementptr inbounds i64, i64* %px, i64 5
  store i64 %38, i64* %arrayidx21, align 8, !tbaa !2
  %39 = tail call i64 @llvm.ve.svm.sMs(<8 x i64> %32, i64 6)
  %arrayidx22 = getelementptr inbounds i64, i64* %px, i64 6
  store i64 %39, i64* %arrayidx22, align 8, !tbaa !2
  %40 = tail call i64 @llvm.ve.svm.sMs(<8 x i64> %32, i64 7)
  %arrayidx23 = getelementptr inbounds i64, i64* %px, i64 7
  store i64 %40, i64* %arrayidx23, align 8, !tbaa !2
  ret void
}

; Function Attrs: nounwind readnone
declare <8 x i64> @llvm.ve.lvm.MMss(<8 x i64>, i64, i64) #1

; Function Attrs: nounwind readnone
declare <8 x i64> @llvm.ve.nndm.MMM(<8 x i64>, <8 x i64>) #1

; Function Attrs: nounwind readnone
declare i64 @llvm.ve.svm.sMs(<8 x i64>, i64) #1

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
