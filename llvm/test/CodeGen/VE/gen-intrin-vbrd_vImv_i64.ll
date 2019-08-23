; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @vbrd_vImv_i64(i64* %pvx, i32* %pvm, i64* nocapture readnone %pvd, i32 %n) {
; CHECK-LABEL: vbrd_vImv_i64
; CHECK: .LBB0_2
; CHECK: 	vbrd %v1,3,%vm1
entry:
  %cmp18 = icmp sgt i32 %n, 0
  br i1 %cmp18, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry, %for.body
  %pvx.addr.021 = phi i64* [ %add.ptr, %for.body ], [ %pvx, %entry ]
  %pvm.addr.020 = phi i32* [ %add.ptr3, %for.body ], [ %pvm, %entry ]
  %i.019 = phi i32 [ %add, %for.body ], [ 0, %entry ]
  %sub = sub nsw i32 %n, %i.019
  %cmp1 = icmp slt i32 %sub, 256
  %spec.select = select i1 %cmp1, i32 %sub, i32 256
  tail call void @llvm.ve.lvl(i32 %spec.select)
  %0 = bitcast i32* %pvm.addr.020 to i8*
  %1 = tail call <256 x double> @llvm.ve.vldlzx.vss(i64 4, i8* %0)
  %2 = tail call <4 x i64> @llvm.ve.vfmkw.mcv(i32 7, <256 x double> %1)
  %3 = bitcast i64* %pvx.addr.021 to i8*
  %4 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %3)
  %5 = tail call <256 x double> @llvm.ve.vbrd.vsmv.i64(i64 3, <4 x i64> %2, <256 x double> %4)
  tail call void @llvm.ve.vst.vss(<256 x double> %5, i64 8, i8* %3)
  %add.ptr = getelementptr inbounds i64, i64* %pvx.addr.021, i64 256
  %add.ptr3 = getelementptr inbounds i32, i32* %pvm.addr.020, i64 256
  %add = add nuw nsw i32 %i.019, 256
  %cmp = icmp slt i32 %add, %n
  br i1 %cmp, label %for.body, label %for.cond.cleanup
}

; Function Attrs: nounwind
declare void @llvm.ve.lvl(i32)

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vldlzx.vss(i64, i8*)

; Function Attrs: nounwind readnone
declare <4 x i64> @llvm.ve.vfmkw.mcv(i32, <256 x double>)

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vld.vss(i64, i8*)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vbrd.vsmv.i64(i64, <4 x i64>, <256 x double>)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vst.vss(<256 x double>, i64, i8*)

