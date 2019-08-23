; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @pvsubu_vsvMv(i32* %pvx, i64 %sy, i32* %pvz, i32* %pvm, i32* nocapture readnone %pvd, i32 %n) {
; CHECK-LABEL: pvsubu_vsvMv
; CHECK: .LBB0_2
; CHECK: 	pvsubu %v2,%s1,%v0,%vm2
entry:
  %cmp22 = icmp sgt i32 %n, 0
  br i1 %cmp22, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry, %for.body
  %pvx.addr.026 = phi i32* [ %add.ptr, %for.body ], [ %pvx, %entry ]
  %pvz.addr.025 = phi i32* [ %add.ptr4, %for.body ], [ %pvz, %entry ]
  %pvm.addr.024 = phi i32* [ %add.ptr5, %for.body ], [ %pvm, %entry ]
  %i.023 = phi i32 [ %add, %for.body ], [ 0, %entry ]
  %sub = sub nsw i32 %n, %i.023
  %cmp1 = icmp slt i32 %sub, 512
  %0 = ashr i32 %sub, 1
  %conv3 = select i1 %cmp1, i32 %0, i32 256
  tail call void @llvm.ve.lvl(i32 %conv3)
  %1 = bitcast i32* %pvz.addr.025 to i8*
  %2 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %1)
  %3 = bitcast i32* %pvm.addr.024 to i8*
  %4 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %3)
  %5 = tail call <8 x i64> @llvm.ve.pvfmkw.Mcv(i32 7, <256 x double> %4)
  %6 = bitcast i32* %pvx.addr.026 to i8*
  %7 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %6)
  %8 = tail call <256 x double> @llvm.ve.pvsubu.vsvMv(i64 %sy, <256 x double> %2, <8 x i64> %5, <256 x double> %7)
  tail call void @llvm.ve.vst.vss(<256 x double> %8, i64 8, i8* %6)
  %add.ptr = getelementptr inbounds i32, i32* %pvx.addr.026, i64 512
  %add.ptr4 = getelementptr inbounds i32, i32* %pvz.addr.025, i64 512
  %add.ptr5 = getelementptr inbounds i32, i32* %pvm.addr.024, i64 512
  %add = add nuw nsw i32 %i.023, 512
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
declare <256 x double> @llvm.ve.pvsubu.vsvMv(i64, <256 x double>, <8 x i64>, <256 x double>)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vst.vss(<256 x double>, i64, i8*)

