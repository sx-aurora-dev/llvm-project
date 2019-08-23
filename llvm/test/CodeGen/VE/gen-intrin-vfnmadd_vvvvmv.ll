; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define void @vfnmadd_vvvvmv(double* %pvx, double* %pvy, double* %pvz, double* %pvw, i32* %pvm, double* nocapture readnone %pvd, i32 %n) {
; CHECK-LABEL: vfnmadd_vvvvmv
; CHECK: .LBB0_2
; CHECK: 	vfnmad.d %v4,%v0,%v1,%v2,%vm1
entry:
  %cmp27 = icmp sgt i32 %n, 0
  br i1 %cmp27, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry, %for.body
  %pvx.addr.033 = phi double* [ %add.ptr, %for.body ], [ %pvx, %entry ]
  %pvy.addr.032 = phi double* [ %add.ptr3, %for.body ], [ %pvy, %entry ]
  %pvz.addr.031 = phi double* [ %add.ptr4, %for.body ], [ %pvz, %entry ]
  %pvw.addr.030 = phi double* [ %add.ptr5, %for.body ], [ %pvw, %entry ]
  %pvm.addr.029 = phi i32* [ %add.ptr6, %for.body ], [ %pvm, %entry ]
  %i.028 = phi i32 [ %add, %for.body ], [ 0, %entry ]
  %sub = sub nsw i32 %n, %i.028
  %cmp1 = icmp slt i32 %sub, 256
  %spec.select = select i1 %cmp1, i32 %sub, i32 256
  tail call void @llvm.ve.lvl(i32 %spec.select)
  %0 = bitcast double* %pvy.addr.032 to i8*
  %1 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %0)
  %2 = bitcast double* %pvz.addr.031 to i8*
  %3 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %2)
  %4 = bitcast double* %pvw.addr.030 to i8*
  %5 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %4)
  %6 = bitcast i32* %pvm.addr.029 to i8*
  %7 = tail call <256 x double> @llvm.ve.vldlzx.vss(i64 4, i8* %6)
  %8 = tail call <4 x i64> @llvm.ve.vfmkw.mcv(i32 7, <256 x double> %7)
  %9 = bitcast double* %pvx.addr.033 to i8*
  %10 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %9)
  %11 = tail call <256 x double> @llvm.ve.vfnmadd.vvvvmv(<256 x double> %1, <256 x double> %3, <256 x double> %5, <4 x i64> %8, <256 x double> %10)
  tail call void @llvm.ve.vst.vss(<256 x double> %11, i64 8, i8* %9)
  %add.ptr = getelementptr inbounds double, double* %pvx.addr.033, i64 256
  %add.ptr3 = getelementptr inbounds double, double* %pvy.addr.032, i64 256
  %add.ptr4 = getelementptr inbounds double, double* %pvz.addr.031, i64 256
  %add.ptr5 = getelementptr inbounds double, double* %pvw.addr.030, i64 256
  %add.ptr6 = getelementptr inbounds i32, i32* %pvm.addr.029, i64 256
  %add = add nuw nsw i32 %i.028, 256
  %cmp = icmp slt i32 %add, %n
  br i1 %cmp, label %for.body, label %for.cond.cleanup
}

; Function Attrs: nounwind
declare void @llvm.ve.lvl(i32)

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vld.vss(i64, i8*)

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vldlzx.vss(i64, i8*)

; Function Attrs: nounwind readnone
declare <4 x i64> @llvm.ve.vfmkw.mcv(i32, <256 x double>)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vfnmadd.vvvvmv(<256 x double>, <256 x double>, <256 x double>, <4 x i64>, <256 x double>)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vst.vss(<256 x double>, i64, i8*)

