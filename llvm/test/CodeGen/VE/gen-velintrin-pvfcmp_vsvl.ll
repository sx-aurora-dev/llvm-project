; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @pvfcmp_vsvl(float*, i64, float*, i32) {
; CHECK: pvfcmp %v0,%s1,%v0
  %5 = icmp sgt i32 %3, 0
  br i1 %5, label %7, label %6

6:                                                ; preds = %7, %4
  ret void

7:                                                ; preds = %4, %7
  %8 = phi float* [ %19, %7 ], [ %0, %4 ]
  %9 = phi float* [ %20, %7 ], [ %2, %4 ]
  %10 = phi i32 [ %21, %7 ], [ 0, %4 ]
  %11 = sub nsw i32 %3, %10
  %12 = icmp slt i32 %11, 512
  %13 = ashr i32 %11, 1
  %14 = select i1 %12, i32 %13, i32 256
  %15 = bitcast float* %9 to i8*
  %16 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %15, i32 %14)
  %17 = tail call <256 x double> @llvm.ve.vl.pvfcmp.vsvl(i64 %1, <256 x double> %16, i32 %14)
  %18 = bitcast float* %8 to i8*
  tail call void @llvm.ve.vl.vst.vssl(<256 x double> %17, i64 8, i8* %18, i32 %14)
  %19 = getelementptr inbounds float, float* %8, i64 512
  %20 = getelementptr inbounds float, float* %9, i64 512
  %21 = add nuw nsw i32 %10, 512
  %22 = icmp slt i32 %21, %3
  br i1 %22, label %7, label %6
}

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vld.vssl(i64, i8*, i32)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.pvfcmp.vsvl(i64, <256 x double>, i32)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vl.vst.vssl(<256 x double>, i64, i8*, i32)

