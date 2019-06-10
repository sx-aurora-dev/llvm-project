; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @vbrdd_vsmvl(double*, double, i32*, double*, i32) {
; CHECK: vbrd %v1,%s1,%vm1
  %6 = icmp sgt i32 %4, 0
  br i1 %6, label %8, label %7

7:                                                ; preds = %8, %5
  ret void

8:                                                ; preds = %5, %8
  %9 = phi double* [ %23, %8 ], [ %0, %5 ]
  %10 = phi i32* [ %24, %8 ], [ %2, %5 ]
  %11 = phi double* [ %25, %8 ], [ %3, %5 ]
  %12 = phi i32 [ %26, %8 ], [ 0, %5 ]
  %13 = sub nsw i32 %4, %12
  %14 = icmp slt i32 %13, 256
  %15 = select i1 %14, i32 %13, i32 256
  %16 = bitcast i32* %10 to i8*
  %17 = tail call <256 x double> @llvm.ve.vl.vldlzx.vssl(i64 4, i8* %16, i32 %15)
  %18 = tail call <4 x i64> @llvm.ve.vl.vfmkwgt.mvl(<256 x double> %17, i32 %15)
  %19 = bitcast double* %11 to i8*
  %20 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %19, i32 %15)
  %21 = bitcast double* %9 to i8*
  %22 = tail call <256 x double> @llvm.ve.vl.vbrdd.vsmvl(double %1, <4 x i64> %18, <256 x double> %20, i32 %15)
  tail call void @llvm.ve.vl.vst.vssl(<256 x double> %22, i64 8, i8* %21, i32 %15)
  %23 = getelementptr inbounds double, double* %9, i64 256
  %24 = getelementptr inbounds i32, i32* %10, i64 256
  %25 = getelementptr inbounds double, double* %11, i64 256
  %26 = add nuw nsw i32 %12, 256
  %27 = icmp slt i32 %26, %4
  br i1 %27, label %8, label %7
}

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vldlzx.vssl(i64, i8*, i32)

; Function Attrs: nounwind readnone
declare <4 x i64> @llvm.ve.vl.vfmkwgt.mvl(<256 x double>, i32)

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vld.vssl(i64, i8*, i32)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vbrdd.vsmvl(double, <4 x i64>, <256 x double>, i32)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vl.vst.vssl(<256 x double>, i64, i8*, i32)

