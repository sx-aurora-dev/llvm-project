; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind writeonly
define void @pvbrd_vsl(i32*, i64, i32) {
; CHECK: pvbrd %v0,%s1
  %4 = icmp sgt i32 %2, 0
  br i1 %4, label %6, label %5

5:                                                ; preds = %6, %3
  ret void

6:                                                ; preds = %3, %6
  %7 = phi i32* [ %15, %6 ], [ %0, %3 ]
  %8 = phi i32 [ %16, %6 ], [ 0, %3 ]
  %9 = sub nsw i32 %2, %8
  %10 = icmp slt i32 %9, 512
  %11 = ashr i32 %9, 1
  %12 = select i1 %10, i32 %11, i32 256
  %13 = tail call <256 x double> @llvm.ve.vl.pvbrd.vsl(i64 %1, i32 %12)
  %14 = bitcast i32* %7 to i8*
  tail call void @llvm.ve.vl.vst.vssl(<256 x double> %13, i64 8, i8* %14, i32 %12)
  %15 = getelementptr inbounds i32, i32* %7, i64 512
  %16 = add nuw nsw i32 %8, 512
  %17 = icmp slt i32 %16, %2
  br i1 %17, label %6, label %5
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.pvbrd.vsl(i64, i32)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vl.vst.vssl(<256 x double>, i64, i8*, i32)

