; RUN: llc -mtriple ve < %s | FileCheck %s
; RUN: llc -mtriple ve -mattr=-vec < %s | FileCheck %s

; Function Attrs: nounwind
define void @func(double*, double*, i32*, i32) {
; CHECK-LABEL: func:
  %5 = icmp sgt i32 %3, 0
  br i1 %5, label %6, label %8

6:                                                ; preds = %4
  %7 = tail call <256 x i1> @llvm.ve.vl.vfmklat.ml(i32 256)
  br label %9

8:                                                ; preds = %9, %4
  ret void

9:                                                ; preds = %9, %6
  %10 = phi double* [ %28, %9 ], [ %0, %6 ]
  %11 = phi double* [ %29, %9 ], [ %1, %6 ]
  %12 = phi i32* [ %30, %9 ], [ %2, %6 ]
  %13 = phi <256 x i1> [ %21, %9 ], [ %7, %6 ]
  %14 = phi i32 [ %31, %9 ], [ 0, %6 ]
  %15 = sub nsw i32 %3, %14
  %16 = icmp slt i32 %15, 256
  %17 = select i1 %16, i32 %15, i32 256
  %18 = bitcast i32* %12 to i8*
  %19 = tail call <256 x double> @llvm.ve.vl.vldlzx.vssl(i64 4, i8* %18, i32 %17)
  %20 = tail call <256 x i1> @llvm.ve.vl.vfmkwgt.mvl(<256 x double> %19, i32 %17)
  %21 = tail call <256 x i1> @llvm.ve.vl.nndm.mmm(<256 x i1> %13, <256 x i1> %20)
  %22 = bitcast double* %10 to i8*
  %23 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %22, i32 %17)
  %24 = bitcast double* %11 to i8*
  %25 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %24, i32 %17)
  %26 = tail call <256 x double> @llvm.ve.vl.vfaddd.vvvmvl(<256 x double> %23, <256 x double> %25, <256 x i1> %21, <256 x double> %23, i32 %17)
  tail call void @llvm.ve.vl.vst.vssl(<256 x double> %26, i64 8, i8* %22, i32 256)
  %27 = sext i32 %17 to i64
  %28 = getelementptr inbounds double, double* %10, i64 %27
  %29 = getelementptr inbounds double, double* %11, i64 %27
  %30 = getelementptr inbounds i32, i32* %12, i64 %27
  %31 = add nuw nsw i32 %14, 1
  %32 = icmp eq i32 %31, %3
  br i1 %32, label %8, label %9
}

; Function Attrs: nounwind readnone
declare <256 x i1> @llvm.ve.vl.vfmklat.ml(i32)

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vldlzx.vssl(i64, i8*, i32)

; Function Attrs: nounwind readnone
declare <256 x i1> @llvm.ve.vl.vfmkwgt.mvl(<256 x double>, i32)

; Function Attrs: nounwind readnone
declare <256 x i1> @llvm.ve.vl.nndm.mmm(<256 x i1>, <256 x i1>)

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vld.vssl(i64, i8*, i32)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vfaddd.vvvmvl(<256 x double>, <256 x double>, <256 x i1>, <256 x double>, i32)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vl.vst.vssl(<256 x double>, i64, i8*, i32)

