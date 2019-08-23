; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @pvfmsb_vvvv(float* %pvx, float* %pvy, float* %pvz, float* %pvw, i32 %n) {
; CHECK-LABEL: pvfmsb_vvvv
; CHECK: .LBB0_2
; CHECK: 	pvfmsb %v0,%v0,%v1,%v2
entry:
  %cmp22 = icmp sgt i32 %n, 0
  br i1 %cmp22, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry, %for.body
  %pvx.addr.027 = phi float* [ %add.ptr, %for.body ], [ %pvx, %entry ]
  %pvy.addr.026 = phi float* [ %add.ptr4, %for.body ], [ %pvy, %entry ]
  %pvz.addr.025 = phi float* [ %add.ptr5, %for.body ], [ %pvz, %entry ]
  %pvw.addr.024 = phi float* [ %add.ptr6, %for.body ], [ %pvw, %entry ]
  %i.023 = phi i32 [ %add, %for.body ], [ 0, %entry ]
  %sub = sub nsw i32 %n, %i.023
  %cmp1 = icmp slt i32 %sub, 512
  %0 = ashr i32 %sub, 1
  %conv3 = select i1 %cmp1, i32 %0, i32 256
  tail call void @llvm.ve.lvl(i32 %conv3)
  %1 = bitcast float* %pvy.addr.026 to i8*
  %2 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %1)
  %3 = bitcast float* %pvz.addr.025 to i8*
  %4 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %3)
  %5 = bitcast float* %pvw.addr.024 to i8*
  %6 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %5)
  %7 = tail call <256 x double> @llvm.ve.pvfmsb.vvvv(<256 x double> %2, <256 x double> %4, <256 x double> %6)
  %8 = bitcast float* %pvx.addr.027 to i8*
  tail call void @llvm.ve.vst.vss(<256 x double> %7, i64 8, i8* %8)
  %add.ptr = getelementptr inbounds float, float* %pvx.addr.027, i64 512
  %add.ptr4 = getelementptr inbounds float, float* %pvy.addr.026, i64 512
  %add.ptr5 = getelementptr inbounds float, float* %pvz.addr.025, i64 512
  %add.ptr6 = getelementptr inbounds float, float* %pvw.addr.024, i64 512
  %add = add nuw nsw i32 %i.023, 512
  %cmp = icmp slt i32 %add, %n
  br i1 %cmp, label %for.body, label %for.cond.cleanup
}

; Function Attrs: nounwind
declare void @llvm.ve.lvl(i32)

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vld.vss(i64, i8*)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.pvfmsb.vvvv(<256 x double>, <256 x double>, <256 x double>)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vst.vss(<256 x double>, i64, i8*)

