; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @nndm_mmml(i64* nocapture, i64* nocapture readonly, i64* nocapture readonly, i32) {
; CHECK: nndm %vm1,%vm1,%vm2
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
  %27 = tail call <4 x i64> @llvm.ve.vl.nndm.mmml(<4 x i64> %23, <4 x i64> %26, i32 256)
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
declare <4 x i64> @llvm.ve.vl.lvm.mmss(<4 x i64>, i64, i64)

; Function Attrs: nounwind readnone
declare <4 x i64> @llvm.ve.vl.nndm.mmml(<4 x i64>, <4 x i64>, i32)

; Function Attrs: nounwind readnone
declare i64 @llvm.ve.vl.svm.sms(<4 x i64>, i64)

!2 = !{!3, !3, i64 0}
!3 = !{!"long", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
