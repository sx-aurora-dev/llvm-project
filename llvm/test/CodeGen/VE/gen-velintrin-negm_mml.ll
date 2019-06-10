; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @negm_mml(i64* nocapture, i64* nocapture readonly, i64* nocapture readnone, i32) {
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
  %16 = tail call <4 x i64> @llvm.ve.vl.negm.mml(<4 x i64> %15, i32 256)
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
declare <4 x i64> @llvm.ve.vl.lvm.mmss(<4 x i64>, i64, i64)

; Function Attrs: nounwind readnone
declare <4 x i64> @llvm.ve.vl.negm.mml(<4 x i64>, i32)

; Function Attrs: nounwind readnone
declare i64 @llvm.ve.vl.svm.sms(<4 x i64>, i64)

!2 = !{!3, !3, i64 0}
!3 = !{!"long", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
