; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @vmrg_vvvmvl(i64*, i64*, i64*, i32*, i64*, i32) {
; CHECK: vmrg %v2,%v0,%v1,%vm1
  %7 = icmp sgt i32 %5, 0
  br i1 %7, label %8, label %10

8:                                                ; preds = %6
  %9 = bitcast i64* %4 to i8*
  br label %11

10:                                               ; preds = %11, %6
  ret void

11:                                               ; preds = %8, %11
  %12 = phi i64* [ %0, %8 ], [ %30, %11 ]
  %13 = phi i64* [ %1, %8 ], [ %31, %11 ]
  %14 = phi i64* [ %2, %8 ], [ %32, %11 ]
  %15 = phi i32* [ %3, %8 ], [ %33, %11 ]
  %16 = phi i32 [ 0, %8 ], [ %34, %11 ]
  %17 = sub nsw i32 %5, %16
  %18 = icmp slt i32 %17, 256
  %19 = select i1 %18, i32 %17, i32 256
  %20 = bitcast i64* %13 to i8*
  %21 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %20, i32 %19)
  %22 = bitcast i64* %14 to i8*
  %23 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %22, i32 %19)
  %24 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %9, i32 %19)
  %25 = bitcast i32* %15 to i8*
  %26 = tail call <256 x double> @llvm.ve.vl.vldlzx.vssl(i64 4, i8* %25, i32 %19)
  %27 = tail call <4 x i64> @llvm.ve.vl.vfmkwgt.mvl(<256 x double> %26, i32 %19)
  %28 = tail call <256 x double> @llvm.ve.vl.vmrg.vvvmvl(<256 x double> %21, <256 x double> %23, <4 x i64> %27, <256 x double> %24, i32 %19)
  %29 = bitcast i64* %12 to i8*
  tail call void @llvm.ve.vl.vst.vssl(<256 x double> %28, i64 8, i8* %29, i32 %19)
  %30 = getelementptr inbounds i64, i64* %12, i64 256
  %31 = getelementptr inbounds i64, i64* %13, i64 256
  %32 = getelementptr inbounds i64, i64* %14, i64 256
  %33 = getelementptr inbounds i32, i32* %15, i64 256
  %34 = add nuw nsw i32 %16, 256
  %35 = icmp slt i32 %34, %5
  br i1 %35, label %11, label %10
}

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vld.vssl(i64, i8*, i32)

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vldlzx.vssl(i64, i8*, i32)

; Function Attrs: nounwind readnone
declare <4 x i64> @llvm.ve.vl.vfmkwgt.mvl(<256 x double>, i32)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vmrg.vvvmvl(<256 x double>, <256 x double>, <4 x i64>, <256 x double>, i32)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vl.vst.vssl(<256 x double>, i64, i8*, i32)

