; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @vsfa_vvssmvl(i64*, i64*, i64, i64, i32*, i64*, i32) {
; CHECK: vsfa %v2,%v0,%s2,%s3,%vm1
  %8 = icmp sgt i32 %6, 0
  br i1 %8, label %10, label %9

9:                                                ; preds = %10, %7
  ret void

10:                                               ; preds = %7, %10
  %11 = phi i64* [ %28, %10 ], [ %0, %7 ]
  %12 = phi i64* [ %29, %10 ], [ %1, %7 ]
  %13 = phi i32* [ %30, %10 ], [ %4, %7 ]
  %14 = phi i64* [ %31, %10 ], [ %5, %7 ]
  %15 = phi i32 [ %32, %10 ], [ 0, %7 ]
  %16 = sub nsw i32 %6, %15
  %17 = icmp slt i32 %16, 256
  %18 = select i1 %17, i32 %16, i32 256
  %19 = bitcast i64* %12 to i8*
  %20 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %19, i32 %18)
  %21 = bitcast i32* %13 to i8*
  %22 = tail call <256 x double> @llvm.ve.vl.vldlzx.vssl(i64 4, i8* %21, i32 %18)
  %23 = tail call <4 x i64> @llvm.ve.vl.vfmkwgt.mvl(<256 x double> %22, i32 %18)
  %24 = bitcast i64* %14 to i8*
  %25 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %24, i32 %18)
  %26 = bitcast i64* %11 to i8*
  %27 = tail call <256 x double> @llvm.ve.vl.vsfa.vvssmvl(<256 x double> %20, i64 %2, i64 %3, <4 x i64> %23, <256 x double> %25, i32 %18)
  tail call void @llvm.ve.vl.vst.vssl(<256 x double> %27, i64 8, i8* %26, i32 %18)
  %28 = getelementptr inbounds i64, i64* %11, i64 256
  %29 = getelementptr inbounds i64, i64* %12, i64 256
  %30 = getelementptr inbounds i32, i32* %13, i64 256
  %31 = getelementptr inbounds i64, i64* %14, i64 256
  %32 = add nuw nsw i32 %15, 256
  %33 = icmp slt i32 %32, %6
  br i1 %33, label %10, label %9
}

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vld.vssl(i64, i8*, i32)

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vldlzx.vssl(i64, i8*, i32)

; Function Attrs: nounwind readnone
declare <4 x i64> @llvm.ve.vl.vfmkwgt.mvl(<256 x double>, i32)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vsfa.vvssmvl(<256 x double>, i64, i64, <4 x i64>, <256 x double>, i32)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vl.vst.vssl(<256 x double>, i64, i8*, i32)

