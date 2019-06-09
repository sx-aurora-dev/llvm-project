; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @vmaxswzx_vIvmvl(i32*, i32*, i32*, i32*, i32) {
; CHECK: vmaxs.w.zx %v2,3,%v0,%vm1
  %6 = icmp sgt i32 %4, 0
  br i1 %6, label %8, label %7

7:                                                ; preds = %8, %5
  ret void

8:                                                ; preds = %5, %8
  %9 = phi i32* [ %26, %8 ], [ %0, %5 ]
  %10 = phi i32* [ %27, %8 ], [ %1, %5 ]
  %11 = phi i32* [ %28, %8 ], [ %2, %5 ]
  %12 = phi i32* [ %29, %8 ], [ %3, %5 ]
  %13 = phi i32 [ %30, %8 ], [ 0, %5 ]
  %14 = sub nsw i32 %4, %13
  %15 = icmp slt i32 %14, 256
  %16 = select i1 %15, i32 %14, i32 256
  %17 = bitcast i32* %10 to i8*
  %18 = tail call <256 x double> @llvm.ve.vl.vldlsx.vssl(i64 4, i8* %17, i32 %16)
  %19 = bitcast i32* %11 to i8*
  %20 = tail call <256 x double> @llvm.ve.vl.vldlzx.vssl(i64 4, i8* %19, i32 %16)
  %21 = tail call <4 x i64> @llvm.ve.vl.vfmkwgt.mvl(<256 x double> %20, i32 %16)
  %22 = bitcast i32* %12 to i8*
  %23 = tail call <256 x double> @llvm.ve.vl.vldlsx.vssl(i64 4, i8* %22, i32 %16)
  %24 = bitcast i32* %9 to i8*
  %25 = tail call <256 x double> @llvm.ve.vl.vmaxswzx.vsvmvl(i32 3, <256 x double> %18, <4 x i64> %21, <256 x double> %23, i32 %16)
  tail call void @llvm.ve.vl.vstl.vssl(<256 x double> %25, i64 4, i8* %24, i32 %16)
  %26 = getelementptr inbounds i32, i32* %9, i64 256
  %27 = getelementptr inbounds i32, i32* %10, i64 256
  %28 = getelementptr inbounds i32, i32* %11, i64 256
  %29 = getelementptr inbounds i32, i32* %12, i64 256
  %30 = add nuw nsw i32 %13, 256
  %31 = icmp slt i32 %30, %4
  br i1 %31, label %8, label %7
}

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vldlsx.vssl(i64, i8*, i32)

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vl.vldlzx.vssl(i64, i8*, i32)

; Function Attrs: nounwind readnone
declare <4 x i64> @llvm.ve.vl.vfmkwgt.mvl(<256 x double>, i32)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vmaxswzx.vsvmvl(i32, <256 x double>, <4 x i64>, <256 x double>, i32)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vl.vstl.vssl(<256 x double>, i64, i8*, i32)

