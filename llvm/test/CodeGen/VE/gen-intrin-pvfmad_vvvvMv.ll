; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @pvfmad_vvvvMv(float* %pvx, float* %pvy, float* %pvz, float* %pvw, i32* %pvm, float* nocapture readnone %pvd, i32 %n) {
; CHECK-LABEL: pvfmad_vvvvMv
; CHECK: .LBB0_2
; CHECK: 	pvfmad %v4,%v0,%v1,%v2,%vm2
entry:
  %cmp28 = icmp sgt i32 %n, 0
  br i1 %cmp28, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry, %for.body
  %pvx.addr.034 = phi float* [ %add.ptr, %for.body ], [ %pvx, %entry ]
  %pvy.addr.033 = phi float* [ %add.ptr4, %for.body ], [ %pvy, %entry ]
  %pvz.addr.032 = phi float* [ %add.ptr5, %for.body ], [ %pvz, %entry ]
  %pvw.addr.031 = phi float* [ %add.ptr6, %for.body ], [ %pvw, %entry ]
  %pvm.addr.030 = phi i32* [ %add.ptr7, %for.body ], [ %pvm, %entry ]
  %i.029 = phi i32 [ %add, %for.body ], [ 0, %entry ]
  %sub = sub nsw i32 %n, %i.029
  %cmp1 = icmp slt i32 %sub, 512
  %0 = ashr i32 %sub, 1
  %conv3 = select i1 %cmp1, i32 %0, i32 256
  tail call void @llvm.ve.lvl(i32 %conv3)
  %1 = bitcast float* %pvy.addr.033 to i8*
  %2 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %1)
  %3 = bitcast float* %pvz.addr.032 to i8*
  %4 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %3)
  %5 = bitcast float* %pvw.addr.031 to i8*
  %6 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %5)
  %7 = bitcast i32* %pvm.addr.030 to i8*
  %8 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %7)
  %9 = tail call <8 x i64> @llvm.ve.pvfmkw.Mcv(i32 7, <256 x double> %8)
  %10 = bitcast float* %pvx.addr.034 to i8*
  %11 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %10)
  %12 = tail call <256 x double> @llvm.ve.pvfmad.vvvvMv(<256 x double> %2, <256 x double> %4, <256 x double> %6, <8 x i64> %9, <256 x double> %11)
  tail call void @llvm.ve.vst.vss(<256 x double> %12, i64 8, i8* %10)
  %add.ptr = getelementptr inbounds float, float* %pvx.addr.034, i64 512
  %add.ptr4 = getelementptr inbounds float, float* %pvy.addr.033, i64 512
  %add.ptr5 = getelementptr inbounds float, float* %pvz.addr.032, i64 512
  %add.ptr6 = getelementptr inbounds float, float* %pvw.addr.031, i64 512
  %add.ptr7 = getelementptr inbounds i32, i32* %pvm.addr.030, i64 512
  %add = add nuw nsw i32 %i.029, 512
  %cmp = icmp slt i32 %add, %n
  br i1 %cmp, label %for.body, label %for.cond.cleanup
}

; Function Attrs: nounwind
declare void @llvm.ve.lvl(i32)

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vld.vss(i64, i8*)

; Function Attrs: nounwind readnone
declare <8 x i64> @llvm.ve.pvfmkw.Mcv(i32, <256 x double>)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.pvfmad.vvvvMv(<256 x double>, <256 x double>, <256 x double>, <8 x i64>, <256 x double>)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vst.vss(<256 x double>, i64, i8*)

