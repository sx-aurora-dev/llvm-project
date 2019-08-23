; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @pvsll_vvvMv(i32* %pvx, i32* %pvz, i32* %pvy, i32* %pvm, i32* nocapture readnone %pvd, i32 %n) {
; CHECK-LABEL: pvsll_vvvMv
; CHECK: .LBB0_2
; CHECK: 	pvsll %v3,%v0,%v1,%vm2
entry:
  %cmp25 = icmp sgt i32 %n, 0
  br i1 %cmp25, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry, %for.body
  %pvx.addr.030 = phi i32* [ %add.ptr, %for.body ], [ %pvx, %entry ]
  %pvz.addr.029 = phi i32* [ %add.ptr4, %for.body ], [ %pvz, %entry ]
  %pvy.addr.028 = phi i32* [ %add.ptr5, %for.body ], [ %pvy, %entry ]
  %pvm.addr.027 = phi i32* [ %add.ptr6, %for.body ], [ %pvm, %entry ]
  %i.026 = phi i32 [ %add, %for.body ], [ 0, %entry ]
  %sub = sub nsw i32 %n, %i.026
  %cmp1 = icmp slt i32 %sub, 512
  %0 = ashr i32 %sub, 1
  %conv3 = select i1 %cmp1, i32 %0, i32 256
  tail call void @llvm.ve.lvl(i32 %conv3)
  %1 = bitcast i32* %pvz.addr.029 to i8*
  %2 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %1)
  %3 = bitcast i32* %pvy.addr.028 to i8*
  %4 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %3)
  %5 = bitcast i32* %pvm.addr.027 to i8*
  %6 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %5)
  %7 = tail call <8 x i64> @llvm.ve.pvfmkw.Mcv(i32 7, <256 x double> %6)
  %8 = bitcast i32* %pvx.addr.030 to i8*
  %9 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %8)
  %10 = tail call <256 x double> @llvm.ve.pvsll.vvvMv(<256 x double> %2, <256 x double> %4, <8 x i64> %7, <256 x double> %9)
  tail call void @llvm.ve.vst.vss(<256 x double> %10, i64 8, i8* %8)
  %add.ptr = getelementptr inbounds i32, i32* %pvx.addr.030, i64 512
  %add.ptr4 = getelementptr inbounds i32, i32* %pvz.addr.029, i64 512
  %add.ptr5 = getelementptr inbounds i32, i32* %pvy.addr.028, i64 512
  %add.ptr6 = getelementptr inbounds i32, i32* %pvm.addr.027, i64 512
  %add = add nuw nsw i32 %i.026, 512
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
declare <256 x double> @llvm.ve.pvsll.vvvMv(<256 x double>, <256 x double>, <8 x i64>, <256 x double>)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vst.vss(<256 x double>, i64, i8*)

