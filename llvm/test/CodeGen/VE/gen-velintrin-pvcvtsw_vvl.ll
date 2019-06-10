; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @pvcvtsw_vvl(float*, i32*, i32) {
; CHECK: pvcvt.s.w %v0,%v0
  %4 = icmp sgt i32 %2, 0
  br i1 %4, label %6, label %5

5:                                                ; preds = %6, %3
  ret void

6:                                                ; preds = %3, %6
  %7 = phi float* [ %18, %6 ], [ %0, %3 ]
  %8 = phi i32* [ %19, %6 ], [ %1, %3 ]
  %9 = phi i32 [ %20, %6 ], [ 0, %3 ]
  %10 = sub nsw i32 %2, %9
  %11 = icmp slt i32 %10, 512
  %12 = ashr i32 %10, 1
  %13 = select i1 %11, i32 %12, i32 256
  %14 = bitcast i32* %8 to i8*
  %15 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %14, i32 %13)
  %16 = tail call <256 x double> @llvm.ve.vl.pvcvtsw.vvl(<256 x double> %15, i32 %13)
  %17 = bitcast float* %7 to i8*
  tail call void @llvm.ve.vl.vst.vssl(<256 x double> %16, i64 8, i8* %17, i32 %13)
  %18 = getelementptr inbounds float, float* %7, i64 512
  %19 = getelementptr inbounds i32, i32* %8, i64 512
  %20 = add nuw nsw i32 %9, 512
  %21 = icmp slt i32 %20, %2
  br i1 %21, label %6, label %5
}

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vld.vssl(i64, i8*, i32)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.pvcvtsw.vvl(<256 x double>, i32)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vl.vst.vssl(<256 x double>, i64, i8*, i32)

