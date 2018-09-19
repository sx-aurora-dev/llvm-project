; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @vdivul_vsv(i64* %pvx, i64 %sy, i64* %pvz, i32 %n) {
; CHECK-LABEL: vdivul_vsv
; CHECK: .LBB0_2
; CHECK: 	vdivu.l %v0,%s1,%v0
entry:
  %cmp15 = icmp sgt i32 %n, 0
  br i1 %cmp15, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry, %for.body
  %pvx.addr.018 = phi i64* [ %add.ptr, %for.body ], [ %pvx, %entry ]
  %pvz.addr.017 = phi i64* [ %add.ptr3, %for.body ], [ %pvz, %entry ]
  %i.016 = phi i32 [ %add, %for.body ], [ 0, %entry ]
  %sub = sub nsw i32 %n, %i.016
  %cmp1 = icmp slt i32 %sub, 256
  %spec.select = select i1 %cmp1, i32 %sub, i32 256
  tail call void @llvm.ve.lvl(i32 %spec.select)
  %0 = bitcast i64* %pvz.addr.017 to i8*
  %1 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %0)
  %2 = tail call <256 x double> @llvm.ve.vdivul.vsv(i64 %sy, <256 x double> %1)
  %3 = bitcast i64* %pvx.addr.018 to i8*
  tail call void @llvm.ve.vst.vss(<256 x double> %2, i64 8, i8* %3)
  %add.ptr = getelementptr inbounds i64, i64* %pvx.addr.018, i64 256
  %add.ptr3 = getelementptr inbounds i64, i64* %pvz.addr.017, i64 256
  %add = add nuw nsw i32 %i.016, 256
  %cmp = icmp slt i32 %add, %n
  br i1 %cmp, label %for.body, label %for.cond.cleanup
}

; Function Attrs: nounwind
declare void @llvm.ve.lvl(i32)

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vld.vss(i64, i8*)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vdivul.vsv(i64, <256 x double>)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vst.vss(<256 x double>, i64, i8*)

