; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @vfnmads_vvsvmvl(float*, float*, float, float*, i32*, float*, i32) {
; CHECK: vfnmad.s %v3,%v0,%s2,%v1,%vm1
  %8 = icmp sgt i32 %6, 0
  br i1 %8, label %10, label %9

9:                                                ; preds = %10, %7
  ret void

10:                                               ; preds = %7, %10
  %11 = phi float* [ %31, %10 ], [ %0, %7 ]
  %12 = phi float* [ %32, %10 ], [ %1, %7 ]
  %13 = phi float* [ %33, %10 ], [ %3, %7 ]
  %14 = phi i32* [ %34, %10 ], [ %4, %7 ]
  %15 = phi float* [ %35, %10 ], [ %5, %7 ]
  %16 = phi i32 [ %36, %10 ], [ 0, %7 ]
  %17 = sub nsw i32 %6, %16
  %18 = icmp slt i32 %17, 256
  %19 = select i1 %18, i32 %17, i32 256
  %20 = bitcast float* %12 to i8*
  %21 = tail call <256 x double> @llvm.ve.vl.vldu.vssl(i64 4, i8* %20, i32 %19)
  %22 = bitcast float* %13 to i8*
  %23 = tail call <256 x double> @llvm.ve.vl.vldu.vssl(i64 4, i8* %22, i32 %19)
  %24 = bitcast i32* %14 to i8*
  %25 = tail call <256 x double> @llvm.ve.vl.vldlzx.vssl(i64 4, i8* %24, i32 %19)
  %26 = tail call <4 x i64> @llvm.ve.vl.vfmkwgt.mvl(<256 x double> %25, i32 %19)
  %27 = bitcast float* %15 to i8*
  %28 = tail call <256 x double> @llvm.ve.vl.vldu.vssl(i64 4, i8* %27, i32 %19)
  %29 = bitcast float* %11 to i8*
  %30 = tail call <256 x double> @llvm.ve.vl.vfnmads.vvsvmvl(<256 x double> %21, float %2, <256 x double> %23, <4 x i64> %26, <256 x double> %28, i32 %19)
  tail call void @llvm.ve.vl.vstu.vssl(<256 x double> %30, i64 4, i8* %29, i32 %19)
  %31 = getelementptr inbounds float, float* %11, i64 256
  %32 = getelementptr inbounds float, float* %12, i64 256
  %33 = getelementptr inbounds float, float* %13, i64 256
  %34 = getelementptr inbounds i32, i32* %14, i64 256
  %35 = getelementptr inbounds float, float* %15, i64 256
  %36 = add nuw nsw i32 %16, 256
  %37 = icmp slt i32 %36, %6
  br i1 %37, label %10, label %9
}

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vldu.vssl(i64, i8*, i32)

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vldlzx.vssl(i64, i8*, i32)

; Function Attrs: nounwind readnone
declare <4 x i64> @llvm.ve.vl.vfmkwgt.mvl(<256 x double>, i32)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vfnmads.vvsvmvl(<256 x double>, float, <256 x double>, <4 x i64>, <256 x double>, i32)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vl.vstu.vssl(<256 x double>, i64, i8*, i32)

