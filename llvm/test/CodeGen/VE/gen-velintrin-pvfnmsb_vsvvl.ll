; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @pvfnmsb_vsvvl(float*, i64, float*, float*, i32) {
; CHECK: pvfnmsb %v0,%s1,%v0,%v1
  %6 = icmp sgt i32 %4, 0
  br i1 %6, label %8, label %7

7:                                                ; preds = %8, %5
  ret void

8:                                                ; preds = %5, %8
  %9 = phi float* [ %23, %8 ], [ %0, %5 ]
  %10 = phi float* [ %24, %8 ], [ %2, %5 ]
  %11 = phi float* [ %25, %8 ], [ %3, %5 ]
  %12 = phi i32 [ %26, %8 ], [ 0, %5 ]
  %13 = sub nsw i32 %4, %12
  %14 = icmp slt i32 %13, 512
  %15 = ashr i32 %13, 1
  %16 = select i1 %14, i32 %15, i32 256
  %17 = bitcast float* %10 to i8*
  %18 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %17, i32 %16)
  %19 = bitcast float* %11 to i8*
  %20 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %19, i32 %16)
  %21 = tail call <256 x double> @llvm.ve.vl.pvfnmsb.vsvvl(i64 %1, <256 x double> %18, <256 x double> %20, i32 %16)
  %22 = bitcast float* %9 to i8*
  tail call void @llvm.ve.vl.vst.vssl(<256 x double> %21, i64 8, i8* %22, i32 %16)
  %23 = getelementptr inbounds float, float* %9, i64 512
  %24 = getelementptr inbounds float, float* %10, i64 512
  %25 = getelementptr inbounds float, float* %11, i64 512
  %26 = add nuw nsw i32 %12, 512
  %27 = icmp slt i32 %26, %4
  br i1 %27, label %8, label %7
}

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vld.vssl(i64, i8*, i32)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.pvfnmsb.vsvvl(i64, <256 x double>, <256 x double>, i32)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vl.vst.vssl(<256 x double>, i64, i8*, i32)

