; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @negm_MM(i64* nocapture %px, i64* nocapture readonly %py, i64* nocapture readnone %pz, i32 %n) {
; CHECK-LABEL: negm_MM
; CHECK: .LBB0_2
; CHECK: 	negm %vm2,%vm2
; CHECK: 	negm %vm3,%vm3
entry:
  %0 = load i64, i64* %py, align 8, !tbaa !2
  %1 = tail call <8 x i64> @llvm.ve.lvm.MMss(<8 x i64> undef, i64 0, i64 %0)
  %arrayidx2 = getelementptr inbounds i64, i64* %py, i64 1
  %2 = load i64, i64* %arrayidx2, align 8, !tbaa !2
  %3 = tail call <8 x i64> @llvm.ve.lvm.MMss(<8 x i64> %1, i64 1, i64 %2)
  %arrayidx4 = getelementptr inbounds i64, i64* %py, i64 2
  %4 = load i64, i64* %arrayidx4, align 8, !tbaa !2
  %5 = tail call <8 x i64> @llvm.ve.lvm.MMss(<8 x i64> %3, i64 2, i64 %4)
  %arrayidx6 = getelementptr inbounds i64, i64* %py, i64 3
  %6 = load i64, i64* %arrayidx6, align 8, !tbaa !2
  %7 = tail call <8 x i64> @llvm.ve.lvm.MMss(<8 x i64> %5, i64 3, i64 %6)
  %arrayidx8 = getelementptr inbounds i64, i64* %py, i64 4
  %8 = load i64, i64* %arrayidx8, align 8, !tbaa !2
  %9 = tail call <8 x i64> @llvm.ve.lvm.MMss(<8 x i64> %7, i64 4, i64 %8)
  %arrayidx10 = getelementptr inbounds i64, i64* %py, i64 5
  %10 = load i64, i64* %arrayidx10, align 8, !tbaa !2
  %11 = tail call <8 x i64> @llvm.ve.lvm.MMss(<8 x i64> %9, i64 5, i64 %10)
  %arrayidx12 = getelementptr inbounds i64, i64* %py, i64 6
  %12 = load i64, i64* %arrayidx12, align 8, !tbaa !2
  %13 = tail call <8 x i64> @llvm.ve.lvm.MMss(<8 x i64> %11, i64 6, i64 %12)
  %arrayidx14 = getelementptr inbounds i64, i64* %py, i64 7
  %14 = load i64, i64* %arrayidx14, align 8, !tbaa !2
  %15 = tail call <8 x i64> @llvm.ve.lvm.MMss(<8 x i64> %13, i64 7, i64 %14)
  %16 = tail call <8 x i64> @llvm.ve.negm.MM(<8 x i64> %15)
  %17 = tail call i64 @llvm.ve.svm.sMs(<8 x i64> %16, i64 0)
  store i64 %17, i64* %px, align 8, !tbaa !2
  %18 = tail call i64 @llvm.ve.svm.sMs(<8 x i64> %16, i64 1)
  %arrayidx17 = getelementptr inbounds i64, i64* %px, i64 1
  store i64 %18, i64* %arrayidx17, align 8, !tbaa !2
  %19 = tail call i64 @llvm.ve.svm.sMs(<8 x i64> %16, i64 2)
  %arrayidx18 = getelementptr inbounds i64, i64* %px, i64 2
  store i64 %19, i64* %arrayidx18, align 8, !tbaa !2
  %20 = tail call i64 @llvm.ve.svm.sMs(<8 x i64> %16, i64 3)
  %arrayidx19 = getelementptr inbounds i64, i64* %px, i64 3
  store i64 %20, i64* %arrayidx19, align 8, !tbaa !2
  %21 = tail call i64 @llvm.ve.svm.sMs(<8 x i64> %16, i64 4)
  %arrayidx20 = getelementptr inbounds i64, i64* %px, i64 4
  store i64 %21, i64* %arrayidx20, align 8, !tbaa !2
  %22 = tail call i64 @llvm.ve.svm.sMs(<8 x i64> %16, i64 5)
  %arrayidx21 = getelementptr inbounds i64, i64* %px, i64 5
  store i64 %22, i64* %arrayidx21, align 8, !tbaa !2
  %23 = tail call i64 @llvm.ve.svm.sMs(<8 x i64> %16, i64 6)
  %arrayidx22 = getelementptr inbounds i64, i64* %px, i64 6
  store i64 %23, i64* %arrayidx22, align 8, !tbaa !2
  %24 = tail call i64 @llvm.ve.svm.sMs(<8 x i64> %16, i64 7)
  %arrayidx23 = getelementptr inbounds i64, i64* %px, i64 7
  store i64 %24, i64* %arrayidx23, align 8, !tbaa !2
  ret void
}

; Function Attrs: nounwind readnone
declare <8 x i64> @llvm.ve.lvm.MMss(<8 x i64>, i64, i64)

; Function Attrs: nounwind readnone
declare <8 x i64> @llvm.ve.negm.MM(<8 x i64>)

; Function Attrs: nounwind readnone
declare i64 @llvm.ve.svm.sMs(<8 x i64>, i64)

!2 = !{!3, !3, i64 0}
!3 = !{!"long", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
