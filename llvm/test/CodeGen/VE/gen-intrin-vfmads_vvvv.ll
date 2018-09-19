; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @vfmads_vvvv(float* %pvx, float* %pvy, float* %pvz, float* %pvw, i32 %n) {
; CHECK-LABEL: vfmads_vvvv
; CHECK: .LBB0_2
; CHECK: 	vfmad.s %v0,%v0,%v1,%v2
entry:
  %cmp21 = icmp sgt i32 %n, 0
  br i1 %cmp21, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry, %for.body
  %pvx.addr.026 = phi float* [ %add.ptr, %for.body ], [ %pvx, %entry ]
  %pvy.addr.025 = phi float* [ %add.ptr3, %for.body ], [ %pvy, %entry ]
  %pvz.addr.024 = phi float* [ %add.ptr4, %for.body ], [ %pvz, %entry ]
  %pvw.addr.023 = phi float* [ %add.ptr5, %for.body ], [ %pvw, %entry ]
  %i.022 = phi i32 [ %add, %for.body ], [ 0, %entry ]
  %sub = sub nsw i32 %n, %i.022
  %cmp1 = icmp slt i32 %sub, 256
  %spec.select = select i1 %cmp1, i32 %sub, i32 256
  tail call void @llvm.ve.lvl(i32 %spec.select)
  %0 = bitcast float* %pvy.addr.025 to i8*
  %1 = tail call <256 x double> @llvm.ve.vldu.vss(i64 4, i8* %0)
  %2 = bitcast float* %pvz.addr.024 to i8*
  %3 = tail call <256 x double> @llvm.ve.vldu.vss(i64 4, i8* %2)
  %4 = bitcast float* %pvw.addr.023 to i8*
  %5 = tail call <256 x double> @llvm.ve.vldu.vss(i64 4, i8* %4)
  %6 = tail call <256 x double> @llvm.ve.vfmads.vvvv(<256 x double> %1, <256 x double> %3, <256 x double> %5)
  %7 = bitcast float* %pvx.addr.026 to i8*
  tail call void @llvm.ve.vstu.vss(<256 x double> %6, i64 4, i8* %7)
  %add.ptr = getelementptr inbounds float, float* %pvx.addr.026, i64 256
  %add.ptr3 = getelementptr inbounds float, float* %pvy.addr.025, i64 256
  %add.ptr4 = getelementptr inbounds float, float* %pvz.addr.024, i64 256
  %add.ptr5 = getelementptr inbounds float, float* %pvw.addr.023, i64 256
  %add = add nuw nsw i32 %i.022, 256
  %cmp = icmp slt i32 %add, %n
  br i1 %cmp, label %for.body, label %for.cond.cleanup
}

; Function Attrs: nounwind
declare void @llvm.ve.lvl(i32)

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vldu.vss(i64, i8*)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vfmads.vvvv(<256 x double>, <256 x double>, <256 x double>)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vstu.vss(<256 x double>, i64, i8*)

