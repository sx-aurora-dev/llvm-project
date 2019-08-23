; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @vbrd_vs_f64(double* %pvx, double %sy, i32 %n) {
; CHECK-LABEL: vbrd_vs_f64
; CHECK: .LBB0_2
; CHECK: 	vbrd %v0,%s1
entry:
  %cmp12 = icmp sgt i32 %n, 0
  br i1 %cmp12, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry, %for.body
  %pvx.addr.014 = phi double* [ %add.ptr, %for.body ], [ %pvx, %entry ]
  %i.013 = phi i32 [ %add, %for.body ], [ 0, %entry ]
  %sub = sub nsw i32 %n, %i.013
  %cmp1 = icmp slt i32 %sub, 256
  %spec.select = select i1 %cmp1, i32 %sub, i32 256
  tail call void @llvm.ve.lvl(i32 %spec.select)
  %0 = tail call <256 x double> @llvm.ve.vbrd.vs.f64(double %sy)
  %1 = bitcast double* %pvx.addr.014 to i8*
  tail call void @llvm.ve.vst.vss(<256 x double> %0, i64 8, i8* %1)
  %add.ptr = getelementptr inbounds double, double* %pvx.addr.014, i64 256
  %add = add nuw nsw i32 %i.013, 256
  %cmp = icmp slt i32 %add, %n
  br i1 %cmp, label %for.body, label %for.cond.cleanup
}

; Function Attrs: nounwind
declare void @llvm.ve.lvl(i32)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vbrd.vs.f64(double)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vst.vss(<256 x double>, i64, i8*)

