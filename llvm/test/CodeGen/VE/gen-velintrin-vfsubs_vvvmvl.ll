; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @vfsubs_vvvmvl(float*, float*, float*, i32*, float*, i32) {
; CHECK: vfsub.s %v3,%v0,%v1,%vm1
  %7 = icmp sgt i32 %5, 0
  br i1 %7, label %9, label %8

8:                                                ; preds = %9, %6
  ret void

9:                                                ; preds = %6, %9
  %10 = phi float* [ %30, %9 ], [ %0, %6 ]
  %11 = phi float* [ %31, %9 ], [ %1, %6 ]
  %12 = phi float* [ %32, %9 ], [ %2, %6 ]
  %13 = phi i32* [ %33, %9 ], [ %3, %6 ]
  %14 = phi float* [ %34, %9 ], [ %4, %6 ]
  %15 = phi i32 [ %35, %9 ], [ 0, %6 ]
  %16 = sub nsw i32 %5, %15
  %17 = icmp slt i32 %16, 256
  %18 = select i1 %17, i32 %16, i32 256
  %19 = bitcast float* %11 to i8*
  %20 = tail call <256 x double> @llvm.ve.vl.vldu.vssl(i64 4, i8* %19, i32 %18)
  %21 = bitcast float* %12 to i8*
  %22 = tail call <256 x double> @llvm.ve.vl.vldu.vssl(i64 4, i8* %21, i32 %18)
  %23 = bitcast i32* %13 to i8*
  %24 = tail call <256 x double> @llvm.ve.vl.vldlzx.vssl(i64 4, i8* %23, i32 %18)
  %25 = tail call <4 x i64> @llvm.ve.vl.vfmkwgt.mvl(<256 x double> %24, i32 %18)
  %26 = bitcast float* %14 to i8*
  %27 = tail call <256 x double> @llvm.ve.vl.vldu.vssl(i64 4, i8* %26, i32 %18)
  %28 = bitcast float* %10 to i8*
  %29 = tail call <256 x double> @llvm.ve.vl.vfsubs.vvvmvl(<256 x double> %20, <256 x double> %22, <4 x i64> %25, <256 x double> %27, i32 %18)
  tail call void @llvm.ve.vl.vstu.vssl(<256 x double> %29, i64 4, i8* %28, i32 %18)
  %30 = getelementptr inbounds float, float* %10, i64 256
  %31 = getelementptr inbounds float, float* %11, i64 256
  %32 = getelementptr inbounds float, float* %12, i64 256
  %33 = getelementptr inbounds i32, i32* %13, i64 256
  %34 = getelementptr inbounds float, float* %14, i64 256
  %35 = add nuw nsw i32 %15, 256
  %36 = icmp slt i32 %35, %5
  br i1 %36, label %9, label %8
}

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vldu.vssl(i64, i8*, i32)

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vldlzx.vssl(i64, i8*, i32)

; Function Attrs: nounwind readnone
declare <4 x i64> @llvm.ve.vl.vfmkwgt.mvl(<256 x double>, i32)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vfsubs.vvvmvl(<256 x double>, <256 x double>, <4 x i64>, <256 x double>, i32)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vl.vstu.vssl(<256 x double>, i64, i8*, i32)

