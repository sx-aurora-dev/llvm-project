; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @vfdivd_vsvmvl(double*, double, double*, i32*, double*, i32) {
; CHECK: vfdiv.d %v2,%s1,%v0,%vm1
  %7 = icmp sgt i32 %5, 0
  br i1 %7, label %9, label %8

8:                                                ; preds = %9, %6
  ret void

9:                                                ; preds = %6, %9
  %10 = phi double* [ %27, %9 ], [ %0, %6 ]
  %11 = phi double* [ %28, %9 ], [ %2, %6 ]
  %12 = phi i32* [ %29, %9 ], [ %3, %6 ]
  %13 = phi double* [ %30, %9 ], [ %4, %6 ]
  %14 = phi i32 [ %31, %9 ], [ 0, %6 ]
  %15 = sub nsw i32 %5, %14
  %16 = icmp slt i32 %15, 256
  %17 = select i1 %16, i32 %15, i32 256
  %18 = bitcast double* %11 to i8*
  %19 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %18, i32 %17)
  %20 = bitcast i32* %12 to i8*
  %21 = tail call <256 x double> @llvm.ve.vl.vldlzx.vssl(i64 4, i8* %20, i32 %17)
  %22 = tail call <4 x i64> @llvm.ve.vl.vfmkwgt.mvl(<256 x double> %21, i32 %17)
  %23 = bitcast double* %13 to i8*
  %24 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %23, i32 %17)
  %25 = bitcast double* %10 to i8*
  %26 = tail call <256 x double> @llvm.ve.vl.vfdivd.vsvmvl(double %1, <256 x double> %19, <4 x i64> %22, <256 x double> %24, i32 %17)
  tail call void @llvm.ve.vl.vst.vssl(<256 x double> %26, i64 8, i8* %25, i32 %17)
  %27 = getelementptr inbounds double, double* %10, i64 256
  %28 = getelementptr inbounds double, double* %11, i64 256
  %29 = getelementptr inbounds i32, i32* %12, i64 256
  %30 = getelementptr inbounds double, double* %13, i64 256
  %31 = add nuw nsw i32 %14, 256
  %32 = icmp slt i32 %31, %5
  br i1 %32, label %9, label %8
}

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vld.vssl(i64, i8*, i32)

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vldlzx.vssl(i64, i8*, i32)

; Function Attrs: nounwind readnone
declare <4 x i64> @llvm.ve.vl.vfmkwgt.mvl(<256 x double>, i32)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vfdivd.vsvmvl(double, <256 x double>, <4 x i64>, <256 x double>, i32)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vl.vst.vssl(<256 x double>, i64, i8*, i32)

