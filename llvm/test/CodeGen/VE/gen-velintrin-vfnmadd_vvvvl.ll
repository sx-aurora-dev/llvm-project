; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @vfnmadd_vvvvl(double*, double*, double*, double*, i32) {
; CHECK: vfnmad.d %v0,%v0,%v1,%v2
  %6 = icmp sgt i32 %4, 0
  br i1 %6, label %8, label %7

7:                                                ; preds = %8, %5
  ret void

8:                                                ; preds = %5, %8
  %9 = phi double* [ %25, %8 ], [ %0, %5 ]
  %10 = phi double* [ %26, %8 ], [ %1, %5 ]
  %11 = phi double* [ %27, %8 ], [ %2, %5 ]
  %12 = phi double* [ %28, %8 ], [ %3, %5 ]
  %13 = phi i32 [ %29, %8 ], [ 0, %5 ]
  %14 = sub nsw i32 %4, %13
  %15 = icmp slt i32 %14, 256
  %16 = select i1 %15, i32 %14, i32 256
  %17 = bitcast double* %10 to i8*
  %18 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %17, i32 %16)
  %19 = bitcast double* %11 to i8*
  %20 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %19, i32 %16)
  %21 = bitcast double* %12 to i8*
  %22 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %21, i32 %16)
  %23 = tail call <256 x double> @llvm.ve.vl.vfnmadd.vvvvl(<256 x double> %18, <256 x double> %20, <256 x double> %22, i32 %16)
  %24 = bitcast double* %9 to i8*
  tail call void @llvm.ve.vl.vst.vssl(<256 x double> %23, i64 8, i8* %24, i32 %16)
  %25 = getelementptr inbounds double, double* %9, i64 256
  %26 = getelementptr inbounds double, double* %10, i64 256
  %27 = getelementptr inbounds double, double* %11, i64 256
  %28 = getelementptr inbounds double, double* %12, i64 256
  %29 = add nuw nsw i32 %13, 256
  %30 = icmp slt i32 %29, %4
  br i1 %30, label %8, label %7
}

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vld.vssl(i64, i8*, i32)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vfnmadd.vvvvl(<256 x double>, <256 x double>, <256 x double>, i32)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vl.vst.vssl(<256 x double>, i64, i8*, i32)

