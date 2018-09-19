; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @pvbrd_vsMv_i64(i32* %pvx, i64 %sy, i32* %pvm, i32* nocapture readnone %pvd, i32 %n) {
; CHECK-LABEL: pvbrd_vsMv_i64
; CHECK: .LBB0_2
; CHECK: 	pvbrd %v1,%s1,%vm2
entry:
  %cmp19 = icmp sgt i32 %n, 0
  br i1 %cmp19, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry, %for.body
  %pvx.addr.022 = phi i32* [ %add.ptr, %for.body ], [ %pvx, %entry ]
  %pvm.addr.021 = phi i32* [ %add.ptr4, %for.body ], [ %pvm, %entry ]
  %i.020 = phi i32 [ %add, %for.body ], [ 0, %entry ]
  %sub = sub nsw i32 %n, %i.020
  %cmp1 = icmp slt i32 %sub, 512
  %0 = ashr i32 %sub, 1
  %conv3 = select i1 %cmp1, i32 %0, i32 256
  tail call void @llvm.ve.lvl(i32 %conv3)
  %1 = bitcast i32* %pvm.addr.021 to i8*
  %2 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %1)
  %3 = tail call <8 x i64> @llvm.ve.pvfmkw.Mcv(i32 7, <256 x double> %2)
  %4 = bitcast i32* %pvx.addr.022 to i8*
  %5 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %4)
  %6 = tail call <256 x double> @llvm.ve.pvbrd.vsMv.i64(i64 %sy, <8 x i64> %3, <256 x double> %5)
  tail call void @llvm.ve.vst.vss(<256 x double> %6, i64 8, i8* %4)
  %add.ptr = getelementptr inbounds i32, i32* %pvx.addr.022, i64 512
  %add.ptr4 = getelementptr inbounds i32, i32* %pvm.addr.021, i64 512
  %add = add nuw nsw i32 %i.020, 512
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
declare <256 x double> @llvm.ve.pvbrd.vsMv.i64(i64, <8 x i64>, <256 x double>)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vst.vss(<256 x double>, i64, i8*)

