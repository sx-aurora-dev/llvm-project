; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @vfsubd_vvvl(double*, double*, double*, i32) {
; CHECK: vfsub.d %v0,%v0,%v1
  %5 = icmp sgt i32 %3, 0
  br i1 %5, label %7, label %6

6:                                                ; preds = %7, %4
  ret void

7:                                                ; preds = %4, %7
  %8 = phi double* [ %21, %7 ], [ %0, %4 ]
  %9 = phi double* [ %22, %7 ], [ %1, %4 ]
  %10 = phi double* [ %23, %7 ], [ %2, %4 ]
  %11 = phi i32 [ %24, %7 ], [ 0, %4 ]
  %12 = sub nsw i32 %3, %11
  %13 = icmp slt i32 %12, 256
  %14 = select i1 %13, i32 %12, i32 256
  %15 = bitcast double* %9 to i8*
  %16 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %15, i32 %14)
  %17 = bitcast double* %10 to i8*
  %18 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %17, i32 %14)
  %19 = tail call <256 x double> @llvm.ve.vl.vfsubd.vvvl(<256 x double> %16, <256 x double> %18, i32 %14)
  %20 = bitcast double* %8 to i8*
  tail call void @llvm.ve.vl.vst.vssl(<256 x double> %19, i64 8, i8* %20, i32 %14)
  %21 = getelementptr inbounds double, double* %8, i64 256
  %22 = getelementptr inbounds double, double* %9, i64 256
  %23 = getelementptr inbounds double, double* %10, i64 256
  %24 = add nuw nsw i32 %11, 256
  %25 = icmp slt i32 %24, %3
  br i1 %25, label %7, label %6
}

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vld.vssl(i64, i8*, i32)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vfsubd.vvvl(<256 x double>, <256 x double>, i32)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vl.vst.vssl(<256 x double>, i64, i8*, i32)

