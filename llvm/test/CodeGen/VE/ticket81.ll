; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define void @vfdivsA_vvv(float* %pvx, float* %pvy, float* %pvz, i32 %n) #0 {
; CHECK-LABEL: vfdivsA_vvv:
; CHECK:       mins.w.zx %s38, %s37, %s35
; CHECK-NEXT:  lvl %s38
; CHECK-NEXT:  vldu %v0,4,%s1
; CHECK-NEXT:  vldu %v1,4,%s2
; CHECK-NEXT:  vrcp.s %v2,%v1
;   llc may build "or %s38, 0, %s36" instruction here wrongly, so check it here.
; CHECK-NEXT:  vfnmsb.s %v3,%s36,%v1,%v2
entry:
  %cmp18 = icmp sgt i32 %n, 0
  br i1 %cmp18, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry, %for.body
  %pvx.addr.022 = phi float* [ %add.ptr, %for.body ], [ %pvx, %entry ]
  %pvy.addr.021 = phi float* [ %add.ptr3, %for.body ], [ %pvy, %entry ]
  %pvz.addr.020 = phi float* [ %add.ptr4, %for.body ], [ %pvz, %entry ]
  %i.019 = phi i32 [ %add, %for.body ], [ 0, %entry ]
  %sub = sub nsw i32 %n, %i.019
  %cmp1 = icmp slt i32 %sub, 256
  %spec.select = select i1 %cmp1, i32 %sub, i32 256
  tail call void @llvm.ve.lvl(i32 %spec.select)
  %0 = bitcast float* %pvy.addr.021 to i8*
  %1 = tail call <256 x double> @llvm.ve.vldu.vss(i64 4, i8* %0)
  %2 = bitcast float* %pvz.addr.020 to i8*
  %3 = tail call <256 x double> @llvm.ve.vldu.vss(i64 4, i8* %2)
  %4 = tail call <256 x double> @llvm.ve.vfdivsA.vvv(<256 x double> %1, <256 x double> %3)
  %5 = bitcast float* %pvx.addr.022 to i8*
  tail call void @llvm.ve.vstu.vss(<256 x double> %4, i64 4, i8* %5)
  %add.ptr = getelementptr inbounds float, float* %pvx.addr.022, i64 256
  %add.ptr3 = getelementptr inbounds float, float* %pvy.addr.021, i64 256
  %add.ptr4 = getelementptr inbounds float, float* %pvz.addr.020, i64 256
  %add = add nuw nsw i32 %i.019, 256
  %cmp = icmp slt i32 %add, %n
  br i1 %cmp, label %for.body, label %for.cond.cleanup
}

; Function Attrs: nounwind
declare void @llvm.ve.lvl(i32) #1

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vldu.vss(i64, i8*) #2

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vfdivsA.vvv(<256 x double>, <256 x double>) #3

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vstu.vss(<256 x double>, i64, i8*) #4
