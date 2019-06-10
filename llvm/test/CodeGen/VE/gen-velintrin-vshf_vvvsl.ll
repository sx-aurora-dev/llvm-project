; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @vshf_vvvsl(i64*, i64*, i64*, i64, i32) {
; CHECK: vshf %v0,%v0,%v1,%s3
  %6 = icmp sgt i32 %4, 0
  br i1 %6, label %8, label %7

7:                                                ; preds = %8, %5
  ret void

8:                                                ; preds = %5, %8
  %9 = phi i64* [ %22, %8 ], [ %0, %5 ]
  %10 = phi i64* [ %23, %8 ], [ %1, %5 ]
  %11 = phi i64* [ %24, %8 ], [ %2, %5 ]
  %12 = phi i32 [ %25, %8 ], [ 0, %5 ]
  %13 = sub nsw i32 %4, %12
  %14 = icmp slt i32 %13, 256
  %15 = select i1 %14, i32 %13, i32 256
  %16 = bitcast i64* %10 to i8*
  %17 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %16, i32 %15)
  %18 = bitcast i64* %11 to i8*
  %19 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %18, i32 %15)
  %20 = tail call <256 x double> @llvm.ve.vl.vshf.vvvsl(<256 x double> %17, <256 x double> %19, i64 %3, i32 %15)
  %21 = bitcast i64* %9 to i8*
  tail call void @llvm.ve.vl.vst.vssl(<256 x double> %20, i64 8, i8* %21, i32 %15)
  %22 = getelementptr inbounds i64, i64* %9, i64 256
  %23 = getelementptr inbounds i64, i64* %10, i64 256
  %24 = getelementptr inbounds i64, i64* %11, i64 256
  %25 = add nuw nsw i32 %12, 256
  %26 = icmp slt i32 %25, %4
  br i1 %26, label %8, label %7
}

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vld.vssl(i64, i8*, i32)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vshf.vvvsl(<256 x double>, <256 x double>, i64, i32)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vl.vst.vssl(<256 x double>, i64, i8*, i32)

