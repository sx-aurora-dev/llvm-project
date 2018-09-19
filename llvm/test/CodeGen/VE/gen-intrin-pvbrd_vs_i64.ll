; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @pvbrd_vs_i64(i32* %pvx, i64 %sy, i32 %n) {
; CHECK-LABEL: pvbrd_vs_i64
; CHECK: .LBB0_2
; CHECK: 	pvbrd %v0,%s1
entry:
  %cmp13 = icmp sgt i32 %n, 0
  br i1 %cmp13, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry, %for.body
  %pvx.addr.015 = phi i32* [ %add.ptr, %for.body ], [ %pvx, %entry ]
  %i.014 = phi i32 [ %add, %for.body ], [ 0, %entry ]
  %sub = sub nsw i32 %n, %i.014
  %cmp1 = icmp slt i32 %sub, 512
  %0 = ashr i32 %sub, 1
  %conv3 = select i1 %cmp1, i32 %0, i32 256
  tail call void @llvm.ve.lvl(i32 %conv3)
  %1 = tail call <256 x double> @llvm.ve.pvbrd.vs.i64(i64 %sy)
  %2 = bitcast i32* %pvx.addr.015 to i8*
  tail call void @llvm.ve.vst.vss(<256 x double> %1, i64 8, i8* %2)
  %add.ptr = getelementptr inbounds i32, i32* %pvx.addr.015, i64 512
  %add = add nuw nsw i32 %i.014, 512
  %cmp = icmp slt i32 %add, %n
  br i1 %cmp, label %for.body, label %for.cond.cleanup
}

; Function Attrs: nounwind
declare void @llvm.ve.lvl(i32)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.pvbrd.vs.i64(i64)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vst.vss(<256 x double>, i64, i8*)

