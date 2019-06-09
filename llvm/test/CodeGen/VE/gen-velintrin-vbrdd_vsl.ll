; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind writeonly
define void @vbrdd_vsl(double*, double, i32) {
; CHECK: vbrd %v0,%s1
  %4 = icmp sgt i32 %2, 0
  br i1 %4, label %6, label %5

5:                                                ; preds = %6, %3
  ret void

6:                                                ; preds = %3, %6
  %7 = phi double* [ %14, %6 ], [ %0, %3 ]
  %8 = phi i32 [ %15, %6 ], [ 0, %3 ]
  %9 = sub nsw i32 %2, %8
  %10 = icmp slt i32 %9, 256
  %11 = select i1 %10, i32 %9, i32 256
  %12 = tail call <256 x double> @llvm.ve.vl.vbrdd.vsl(double %1, i32 %11)
  %13 = bitcast double* %7 to i8*
  tail call void @llvm.ve.vl.vst.vssl(<256 x double> %12, i64 8, i8* %13, i32 %11)
  %14 = getelementptr inbounds double, double* %7, i64 256
  %15 = add nuw nsw i32 %8, 256
  %16 = icmp slt i32 %15, %2
  br i1 %16, label %6, label %5
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vbrdd.vsl(double, i32)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vl.vst.vssl(<256 x double>, i64, i8*, i32)

