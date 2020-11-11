; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=+packed | FileCheck %s
; ModuleID = 'gen/tests/negm_MM.c'
source_filename = "gen/tests/negm_MM.c"
target datalayout = "e-m:e-i64:64-n32:64-S128-v64:64:64-v128:64:64-v256:64:64-v512:64:64-v1024:64:64-v2048:64:64-v4096:64:64-v8192:64:64-v16384:64:64"
target triple = "ve-unknown-linux-gnu"

; Function Attrs: nofree nounwind
define dso_local void @negm_MM(i64* nocapture %0, i64* nocapture readonly %1, i64* nocapture readnone %2, i32 signext %3) local_unnamed_addr #0 {
; CHECK: negm %vm2, %vm2
; CHECK: negm %vm3, %vm3
  %5 = load i64, i64* %1, align 8, !tbaa !2
  %6 = tail call <512 x i1> @llvm.ve.vl.lvm.MMss(<512 x i1> undef, i64 0, i64 %5)
  %7 = getelementptr inbounds i64, i64* %1, i64 1
  %8 = load i64, i64* %7, align 8, !tbaa !2
  %9 = tail call <512 x i1> @llvm.ve.vl.lvm.MMss(<512 x i1> %6, i64 1, i64 %8)
  %10 = getelementptr inbounds i64, i64* %1, i64 2
  %11 = load i64, i64* %10, align 8, !tbaa !2
  %12 = tail call <512 x i1> @llvm.ve.vl.lvm.MMss(<512 x i1> %9, i64 2, i64 %11)
  %13 = getelementptr inbounds i64, i64* %1, i64 3
  %14 = load i64, i64* %13, align 8, !tbaa !2
  %15 = tail call <512 x i1> @llvm.ve.vl.lvm.MMss(<512 x i1> %12, i64 3, i64 %14)
  %16 = getelementptr inbounds i64, i64* %1, i64 4
  %17 = load i64, i64* %16, align 8, !tbaa !2
  %18 = tail call <512 x i1> @llvm.ve.vl.lvm.MMss(<512 x i1> %15, i64 4, i64 %17)
  %19 = getelementptr inbounds i64, i64* %1, i64 5
  %20 = load i64, i64* %19, align 8, !tbaa !2
  %21 = tail call <512 x i1> @llvm.ve.vl.lvm.MMss(<512 x i1> %18, i64 5, i64 %20)
  %22 = getelementptr inbounds i64, i64* %1, i64 6
  %23 = load i64, i64* %22, align 8, !tbaa !2
  %24 = tail call <512 x i1> @llvm.ve.vl.lvm.MMss(<512 x i1> %21, i64 6, i64 %23)
  %25 = getelementptr inbounds i64, i64* %1, i64 7
  %26 = load i64, i64* %25, align 8, !tbaa !2
  %27 = tail call <512 x i1> @llvm.ve.vl.lvm.MMss(<512 x i1> %24, i64 7, i64 %26)
  %28 = tail call <512 x i1> @llvm.ve.vl.negm.MM(<512 x i1> %27)
  %29 = tail call i64 @llvm.ve.vl.svm.sMs(<512 x i1> %28, i64 0)
  store i64 %29, i64* %0, align 8, !tbaa !2
  %30 = tail call i64 @llvm.ve.vl.svm.sMs(<512 x i1> %28, i64 1)
  %31 = getelementptr inbounds i64, i64* %0, i64 1
  store i64 %30, i64* %31, align 8, !tbaa !2
  %32 = tail call i64 @llvm.ve.vl.svm.sMs(<512 x i1> %28, i64 2)
  %33 = getelementptr inbounds i64, i64* %0, i64 2
  store i64 %32, i64* %33, align 8, !tbaa !2
  %34 = tail call i64 @llvm.ve.vl.svm.sMs(<512 x i1> %28, i64 3)
  %35 = getelementptr inbounds i64, i64* %0, i64 3
  store i64 %34, i64* %35, align 8, !tbaa !2
  %36 = tail call i64 @llvm.ve.vl.svm.sMs(<512 x i1> %28, i64 4)
  %37 = getelementptr inbounds i64, i64* %0, i64 4
  store i64 %36, i64* %37, align 8, !tbaa !2
  %38 = tail call i64 @llvm.ve.vl.svm.sMs(<512 x i1> %28, i64 5)
  %39 = getelementptr inbounds i64, i64* %0, i64 5
  store i64 %38, i64* %39, align 8, !tbaa !2
  %40 = tail call i64 @llvm.ve.vl.svm.sMs(<512 x i1> %28, i64 6)
  %41 = getelementptr inbounds i64, i64* %0, i64 6
  store i64 %40, i64* %41, align 8, !tbaa !2
  %42 = tail call i64 @llvm.ve.vl.svm.sMs(<512 x i1> %28, i64 7)
  %43 = getelementptr inbounds i64, i64* %0, i64 7
  store i64 %42, i64* %43, align 8, !tbaa !2
  ret void
}

; Function Attrs: nounwind readnone
declare <512 x i1> @llvm.ve.vl.lvm.MMss(<512 x i1>, i64, i64) #1

; Function Attrs: nounwind readnone
declare <512 x i1> @llvm.ve.vl.negm.MM(<512 x i1>) #1

; Function Attrs: nounwind readnone
declare i64 @llvm.ve.vl.svm.sMs(<512 x i1>, i64) #1

attributes #0 = { nofree nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="-vec" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (git@socsv218.svp.cl.nec.co.jp:ve-llvm/llvm-project.git ea1e45464a3c0492368cbabae9242628b03e399d)"}
!2 = !{!3, !3, i64 0}
!3 = !{!"long", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
