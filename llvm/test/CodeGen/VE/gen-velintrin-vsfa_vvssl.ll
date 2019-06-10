; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @vsfa_vvssl(i64*, i64*, i64, i64, i32) {
; CHECK: vsfa %v0,%v0,%s2,%s3
  %6 = icmp sgt i32 %4, 0
  br i1 %6, label %8, label %7

7:                                                ; preds = %8, %5
  ret void

8:                                                ; preds = %5, %8
  %9 = phi i64* [ %19, %8 ], [ %0, %5 ]
  %10 = phi i64* [ %20, %8 ], [ %1, %5 ]
  %11 = phi i32 [ %21, %8 ], [ 0, %5 ]
  %12 = sub nsw i32 %4, %11
  %13 = icmp slt i32 %12, 256
  %14 = select i1 %13, i32 %12, i32 256
  %15 = bitcast i64* %10 to i8*
  %16 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %15, i32 %14)
  %17 = tail call <256 x double> @llvm.ve.vl.vsfa.vvssl(<256 x double> %16, i64 %2, i64 %3, i32 %14)
  %18 = bitcast i64* %9 to i8*
  tail call void @llvm.ve.vl.vst.vssl(<256 x double> %17, i64 8, i8* %18, i32 %14)
  %19 = getelementptr inbounds i64, i64* %9, i64 256
  %20 = getelementptr inbounds i64, i64* %10, i64 256
  %21 = add nuw nsw i32 %11, 256
  %22 = icmp slt i32 %21, %4
  br i1 %22, label %8, label %7
}

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vld.vssl(i64, i8*, i32)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vsfa.vvssl(<256 x double>, i64, i64, i32)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vl.vst.vssl(<256 x double>, i64, i8*, i32)

