; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s
; ModuleID = 'gen/tests/pvfcmp_vvvMv.c'
source_filename = "gen/tests/pvfcmp_vvvMv.c"
target datalayout = "e-m:e-i64:64-n32:64-S64-v16384:64:64"
target triple = "ve"

; Function Attrs: nounwind
define dso_local void @pvfcmp_vvvMv(float* %pvx, float* %pvy, float* %pvz, i32* %pvm, float* nocapture readnone %pvd, i32 %n) local_unnamed_addr #0 {
; CHECK-LABEL: pvfcmp_vvvMv
; CHECK: .LBB0_2
; CHECK: 	pvfcmp %v3,%v0,%v1,%vm2
entry:
  %cmp25 = icmp sgt i32 %n, 0
  br i1 %cmp25, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry, %for.body
  %pvx.addr.030 = phi float* [ %add.ptr, %for.body ], [ %pvx, %entry ]
  %pvy.addr.029 = phi float* [ %add.ptr4, %for.body ], [ %pvy, %entry ]
  %pvz.addr.028 = phi float* [ %add.ptr5, %for.body ], [ %pvz, %entry ]
  %pvm.addr.027 = phi i32* [ %add.ptr6, %for.body ], [ %pvm, %entry ]
  %i.026 = phi i32 [ %add, %for.body ], [ 0, %entry ]
  %sub = sub nsw i32 %n, %i.026
  %cmp1 = icmp slt i32 %sub, 512
  %0 = ashr i32 %sub, 1
  %conv3 = select i1 %cmp1, i32 %0, i32 256
  tail call void @llvm.ve.lvl(i32 %conv3)
  %1 = bitcast float* %pvy.addr.029 to i8*
  %2 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %1)
  %3 = bitcast float* %pvz.addr.028 to i8*
  %4 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %3)
  %5 = bitcast i32* %pvm.addr.027 to i8*
  %6 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %5)
  %7 = tail call <8 x i64> @llvm.ve.pvfmkw.Mcv(i32 1, <256 x double> %6)
  %8 = bitcast float* %pvx.addr.030 to i8*
  %9 = tail call <256 x double> @llvm.ve.vld.vss(i64 8, i8* %8)
  %10 = tail call <256 x double> @llvm.ve.pvfcmp.vvvMv(<256 x double> %2, <256 x double> %4, <8 x i64> %7, <256 x double> %9)
  tail call void @llvm.ve.vst.vss(<256 x double> %10, i64 8, i8* %8)
  %add.ptr = getelementptr inbounds float, float* %pvx.addr.030, i64 512
  %add.ptr4 = getelementptr inbounds float, float* %pvy.addr.029, i64 512
  %add.ptr5 = getelementptr inbounds float, float* %pvz.addr.028, i64 512
  %add.ptr6 = getelementptr inbounds i32, i32* %pvm.addr.027, i64 512
  %add = add nuw nsw i32 %i.026, 512
  %cmp = icmp slt i32 %add, %n
  br i1 %cmp, label %for.body, label %for.cond.cleanup
}

; Function Attrs: nounwind
declare void @llvm.ve.lvl(i32) #1

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vld.vss(i64, i8*) #2

; Function Attrs: nounwind readnone
declare <8 x i64> @llvm.ve.pvfmkw.Mcv(i32, <256 x double>) #3

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.pvfcmp.vvvMv(<256 x double>, <256 x double>, <8 x i64>, <256 x double>) #3

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
