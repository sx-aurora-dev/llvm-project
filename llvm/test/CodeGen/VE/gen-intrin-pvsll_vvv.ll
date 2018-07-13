; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s
; ModuleID = 'gen/tests/pvsll_vvv.c'
source_filename = "gen/tests/pvsll_vvv.c"
target datalayout = "e-m:e-i64:64-n32:64-S64-v16384:64:64"
target triple = "ve"

; Function Attrs: nounwind
define dso_local void @pvsll_vvv(i32* %pvx, i32* %pvz, i32* %pvy, i32 %n) local_unnamed_addr #0 {
; CHECK-LABEL: pvsll_vvv
; CHECK: .LBB0_2
; CHECK: 	pvsll %v0,%v0,%v1
entry:
  %cmp19 = icmp sgt i32 %n, 0
  br i1 %cmp19, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry, %for.body
  %pvx.addr.023 = phi i32* [ %add.ptr, %for.body ], [ %pvx, %entry ]
  %pvz.addr.022 = phi i32* [ %add.ptr4, %for.body ], [ %pvz, %entry ]
  %pvy.addr.021 = phi i32* [ %add.ptr5, %for.body ], [ %pvy, %entry ]
  %i.020 = phi i32 [ %add, %for.body ], [ 0, %entry ]
  %sub = sub nsw i32 %n, %i.020
  %cmp1 = icmp slt i32 %sub, 512
  %0 = ashr i32 %sub, 1
  %conv3 = select i1 %cmp1, i32 %0, i32 256
  tail call void @llvm.ve.lvl(i32 %conv3)
  %1 = bitcast i32* %pvz.addr.022 to i8*
  %2 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %1)
  %3 = bitcast i32* %pvy.addr.021 to i8*
  %4 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %3)
  %5 = tail call <256 x double> @llvm.ve.pvsll.vvv(<256 x double> %2, <256 x double> %4)
  %6 = bitcast i32* %pvx.addr.023 to i8*
  tail call void @llvm.ve.vst.vss(<256 x double> %5, i64 8, i8* %6)
  %add.ptr = getelementptr inbounds i32, i32* %pvx.addr.023, i64 512
  %add.ptr4 = getelementptr inbounds i32, i32* %pvz.addr.022, i64 512
  %add.ptr5 = getelementptr inbounds i32, i32* %pvy.addr.021, i64 512
  %add = add nuw nsw i32 %i.020, 512
  %cmp = icmp slt i32 %add, %n
  br i1 %cmp, label %for.body, label %for.cond.cleanup
}

; Function Attrs: nounwind
declare void @llvm.ve.lvl(i32) #1

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vld.vss(i64, i8*) #2

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.pvsll.vvv(<256 x double>, <256 x double>) #3

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vst.vss(<256 x double>, i64, i8*) #4

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind readonly }
attributes #3 = { nounwind readnone }
attributes #4 = { nounwind writeonly }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 7.0.0 (git@socsv218.svp.cl.nec.co.jp:ve-llvm/clang.git 75fd1a3a6a07de8889d08fb9dd1eb1c0940e62a5) (llvm/llvm.git 882a992d251d96ec3ff0729ba24e71b2e10b6eda)"}
