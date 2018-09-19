; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @vfmsbd_vvvv(double* %pvx, double* %pvy, double* %pvz, double* %pvw, i32 %n) {
; CHECK-LABEL: vfmsbd_vvvv
; CHECK: .LBB0_2
; CHECK: 	vfmsb.d %v0,%v0,%v1,%v2
entry:
  %cmp21 = icmp sgt i32 %n, 0
  br i1 %cmp21, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry, %for.body
  %pvx.addr.026 = phi double* [ %add.ptr, %for.body ], [ %pvx, %entry ]
  %pvy.addr.025 = phi double* [ %add.ptr3, %for.body ], [ %pvy, %entry ]
  %pvz.addr.024 = phi double* [ %add.ptr4, %for.body ], [ %pvz, %entry ]
  %pvw.addr.023 = phi double* [ %add.ptr5, %for.body ], [ %pvw, %entry ]
  %i.022 = phi i32 [ %add, %for.body ], [ 0, %entry ]
  %sub = sub nsw i32 %n, %i.022
  %cmp1 = icmp slt i32 %sub, 256
  %spec.select = select i1 %cmp1, i32 %sub, i32 256
  tail call void @llvm.ve.lvl(i32 %spec.select)
  %0 = bitcast double* %pvy.addr.025 to i8*
  %1 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %0)
  %2 = bitcast double* %pvz.addr.024 to i8*
  %3 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %2)
  %4 = bitcast double* %pvw.addr.023 to i8*
  %5 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %4)
  %6 = tail call <256 x double> @llvm.ve.vfmsbd.vvvv(<256 x double> %1, <256 x double> %3, <256 x double> %5)
  %7 = bitcast double* %pvx.addr.026 to i8*
  tail call void @llvm.ve.vst.vss(<256 x double> %6, i64 8, i8* %7)
  %add.ptr = getelementptr inbounds double, double* %pvx.addr.026, i64 256
  %add.ptr3 = getelementptr inbounds double, double* %pvy.addr.025, i64 256
  %add.ptr4 = getelementptr inbounds double, double* %pvz.addr.024, i64 256
  %add.ptr5 = getelementptr inbounds double, double* %pvw.addr.023, i64 256
  %add = add nuw nsw i32 %i.022, 256
  %cmp = icmp slt i32 %add, %n
  br i1 %cmp, label %for.body, label %for.cond.cleanup
}

; Function Attrs: nounwind
declare void @llvm.ve.lvl(i32)

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vld.vss(i64, i8*)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vfmsbd.vvvv(<256 x double>, <256 x double>, <256 x double>)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vst.vss(<256 x double>, i64, i8*)

