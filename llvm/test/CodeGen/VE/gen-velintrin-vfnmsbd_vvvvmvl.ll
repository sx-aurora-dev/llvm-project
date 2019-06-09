; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @vfnmsbd_vvvvmvl(double*, double*, double*, double*, i32*, double*, i32) {
; CHECK: vfnmsb.d %v4,%v0,%v1,%v2,%vm1
  %8 = icmp sgt i32 %6, 0
  br i1 %8, label %10, label %9

9:                                                ; preds = %10, %7
  ret void

10:                                               ; preds = %7, %10
  %11 = phi double* [ %34, %10 ], [ %0, %7 ]
  %12 = phi double* [ %35, %10 ], [ %1, %7 ]
  %13 = phi double* [ %36, %10 ], [ %2, %7 ]
  %14 = phi double* [ %37, %10 ], [ %3, %7 ]
  %15 = phi i32* [ %38, %10 ], [ %4, %7 ]
  %16 = phi double* [ %39, %10 ], [ %5, %7 ]
  %17 = phi i32 [ %40, %10 ], [ 0, %7 ]
  %18 = sub nsw i32 %6, %17
  %19 = icmp slt i32 %18, 256
  %20 = select i1 %19, i32 %18, i32 256
  %21 = bitcast double* %12 to i8*
  %22 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %21, i32 %20)
  %23 = bitcast double* %13 to i8*
  %24 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %23, i32 %20)
  %25 = bitcast double* %14 to i8*
  %26 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %25, i32 %20)
  %27 = bitcast i32* %15 to i8*
  %28 = tail call <256 x double> @llvm.ve.vl.vldlzx.vssl(i64 4, i8* %27, i32 %20)
  %29 = tail call <4 x i64> @llvm.ve.vl.vfmkwgt.mvl(<256 x double> %28, i32 %20)
  %30 = bitcast double* %16 to i8*
  %31 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %30, i32 %20)
  %32 = bitcast double* %11 to i8*
  %33 = tail call <256 x double> @llvm.ve.vl.vfnmsbd.vvvvmvl(<256 x double> %22, <256 x double> %24, <256 x double> %26, <4 x i64> %29, <256 x double> %31, i32 %20)
  tail call void @llvm.ve.vl.vst.vssl(<256 x double> %33, i64 8, i8* %32, i32 %20)
  %34 = getelementptr inbounds double, double* %11, i64 256
  %35 = getelementptr inbounds double, double* %12, i64 256
  %36 = getelementptr inbounds double, double* %13, i64 256
  %37 = getelementptr inbounds double, double* %14, i64 256
  %38 = getelementptr inbounds i32, i32* %15, i64 256
  %39 = getelementptr inbounds double, double* %16, i64 256
  %40 = add nuw nsw i32 %17, 256
  %41 = icmp slt i32 %40, %6
  br i1 %41, label %10, label %9
}

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vld.vssl(i64, i8*, i32)

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vldlzx.vssl(i64, i8*, i32)

; Function Attrs: nounwind readnone
declare <4 x i64> @llvm.ve.vl.vfmkwgt.mvl(<256 x double>, i32)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vfnmsbd.vvvvmvl(<256 x double>, <256 x double>, <256 x double>, <4 x i64>, <256 x double>, i32)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vl.vst.vssl(<256 x double>, i64, i8*, i32)

