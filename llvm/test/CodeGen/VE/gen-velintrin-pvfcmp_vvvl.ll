; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @pvfcmp_vvvl(float*, float*, float*, i32) {
; CHECK: pvfcmp %v0,%v0,%v1
  %5 = icmp sgt i32 %3, 0
  br i1 %5, label %7, label %6

6:                                                ; preds = %7, %4
  ret void

7:                                                ; preds = %4, %7
  %8 = phi float* [ %22, %7 ], [ %0, %4 ]
  %9 = phi float* [ %23, %7 ], [ %1, %4 ]
  %10 = phi float* [ %24, %7 ], [ %2, %4 ]
  %11 = phi i32 [ %25, %7 ], [ 0, %4 ]
  %12 = sub nsw i32 %3, %11
  %13 = icmp slt i32 %12, 512
  %14 = ashr i32 %12, 1
  %15 = select i1 %13, i32 %14, i32 256
  %16 = bitcast float* %9 to i8*
  %17 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %16, i32 %15)
  %18 = bitcast float* %10 to i8*
  %19 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %18, i32 %15)
  %20 = tail call <256 x double> @llvm.ve.vl.pvfcmp.vvvl(<256 x double> %17, <256 x double> %19, i32 %15)
  %21 = bitcast float* %8 to i8*
  tail call void @llvm.ve.vl.vst.vssl(<256 x double> %20, i64 8, i8* %21, i32 %15)
  %22 = getelementptr inbounds float, float* %8, i64 512
  %23 = getelementptr inbounds float, float* %9, i64 512
  %24 = getelementptr inbounds float, float* %10, i64 512
  %25 = add nuw nsw i32 %11, 512
  %26 = icmp slt i32 %25, %3
  br i1 %26, label %7, label %6
}

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vld.vssl(i64, i8*, i32)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.pvfcmp.vvvl(<256 x double>, <256 x double>, i32)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vl.vst.vssl(<256 x double>, i64, i8*, i32)

