; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=+packed | FileCheck %s
; ModuleID = 'gen/tests/andm_MMM.c'
source_filename = "gen/tests/andm_MMM.c"
target datalayout = "e-m:e-i64:64-n32:64-S128-v64:64:64-v128:64:64-v256:64:64-v512:64:64-v1024:64:64-v2048:64:64-v4096:64:64-v8192:64:64-v16384:64:64"
target triple = "ve-unknown-linux-gnu"

; Function Attrs: nofree nounwind
define dso_local void @andm_MMM(i64* nocapture %0, i64* nocapture readonly %1, i64* nocapture readonly %2, i32 signext %3) local_unnamed_addr #0 {
; CHECK: andm %vm2, %vm2, %vm4
; CHECK: andm %vm3, %vm3, %vm5
  %5 = load i64, i64* %1, align 8, !tbaa !2
  %6 = tail call <512 x i1> @llvm.ve.vl.lvm.MMss(<512 x i1> undef, i64 0, i64 %5)
  %7 = load i64, i64* %2, align 8, !tbaa !2
  %8 = tail call <512 x i1> @llvm.ve.vl.lvm.MMss(<512 x i1> undef, i64 0, i64 %7)
  %9 = getelementptr inbounds i64, i64* %1, i64 1
  %10 = load i64, i64* %9, align 8, !tbaa !2
  %11 = tail call <512 x i1> @llvm.ve.vl.lvm.MMss(<512 x i1> %6, i64 1, i64 %10)
  %12 = getelementptr inbounds i64, i64* %2, i64 1
  %13 = load i64, i64* %12, align 8, !tbaa !2
  %14 = tail call <512 x i1> @llvm.ve.vl.lvm.MMss(<512 x i1> %8, i64 1, i64 %13)
  %15 = getelementptr inbounds i64, i64* %1, i64 2
  %16 = load i64, i64* %15, align 8, !tbaa !2
  %17 = tail call <512 x i1> @llvm.ve.vl.lvm.MMss(<512 x i1> %11, i64 2, i64 %16)
  %18 = getelementptr inbounds i64, i64* %2, i64 2
  %19 = load i64, i64* %18, align 8, !tbaa !2
  %20 = tail call <512 x i1> @llvm.ve.vl.lvm.MMss(<512 x i1> %14, i64 2, i64 %19)
  %21 = getelementptr inbounds i64, i64* %1, i64 3
  %22 = load i64, i64* %21, align 8, !tbaa !2
  %23 = tail call <512 x i1> @llvm.ve.vl.lvm.MMss(<512 x i1> %17, i64 3, i64 %22)
  %24 = getelementptr inbounds i64, i64* %2, i64 3
  %25 = load i64, i64* %24, align 8, !tbaa !2
  %26 = tail call <512 x i1> @llvm.ve.vl.lvm.MMss(<512 x i1> %20, i64 3, i64 %25)
  %27 = getelementptr inbounds i64, i64* %1, i64 4
  %28 = load i64, i64* %27, align 8, !tbaa !2
  %29 = tail call <512 x i1> @llvm.ve.vl.lvm.MMss(<512 x i1> %23, i64 4, i64 %28)
  %30 = getelementptr inbounds i64, i64* %2, i64 4
  %31 = load i64, i64* %30, align 8, !tbaa !2
  %32 = tail call <512 x i1> @llvm.ve.vl.lvm.MMss(<512 x i1> %26, i64 4, i64 %31)
  %33 = getelementptr inbounds i64, i64* %1, i64 5
  %34 = load i64, i64* %33, align 8, !tbaa !2
  %35 = tail call <512 x i1> @llvm.ve.vl.lvm.MMss(<512 x i1> %29, i64 5, i64 %34)
  %36 = getelementptr inbounds i64, i64* %2, i64 5
  %37 = load i64, i64* %36, align 8, !tbaa !2
  %38 = tail call <512 x i1> @llvm.ve.vl.lvm.MMss(<512 x i1> %32, i64 5, i64 %37)
  %39 = getelementptr inbounds i64, i64* %1, i64 6
  %40 = load i64, i64* %39, align 8, !tbaa !2
  %41 = tail call <512 x i1> @llvm.ve.vl.lvm.MMss(<512 x i1> %35, i64 6, i64 %40)
  %42 = getelementptr inbounds i64, i64* %2, i64 6
  %43 = load i64, i64* %42, align 8, !tbaa !2
  %44 = tail call <512 x i1> @llvm.ve.vl.lvm.MMss(<512 x i1> %38, i64 6, i64 %43)
  %45 = getelementptr inbounds i64, i64* %1, i64 7
  %46 = load i64, i64* %45, align 8, !tbaa !2
  %47 = tail call <512 x i1> @llvm.ve.vl.lvm.MMss(<512 x i1> %41, i64 7, i64 %46)
  %48 = getelementptr inbounds i64, i64* %2, i64 7
  %49 = load i64, i64* %48, align 8, !tbaa !2
  %50 = tail call <512 x i1> @llvm.ve.vl.lvm.MMss(<512 x i1> %44, i64 7, i64 %49)
  %51 = tail call <512 x i1> @llvm.ve.vl.andm.MMM(<512 x i1> %47, <512 x i1> %50)
  %52 = tail call i64 @llvm.ve.vl.svm.sMs(<512 x i1> %51, i64 0)
  store i64 %52, i64* %0, align 8, !tbaa !2
  %53 = tail call i64 @llvm.ve.vl.svm.sMs(<512 x i1> %51, i64 1)
  %54 = getelementptr inbounds i64, i64* %0, i64 1
  store i64 %53, i64* %54, align 8, !tbaa !2
  %55 = tail call i64 @llvm.ve.vl.svm.sMs(<512 x i1> %51, i64 2)
  %56 = getelementptr inbounds i64, i64* %0, i64 2
  store i64 %55, i64* %56, align 8, !tbaa !2
  %57 = tail call i64 @llvm.ve.vl.svm.sMs(<512 x i1> %51, i64 3)
  %58 = getelementptr inbounds i64, i64* %0, i64 3
  store i64 %57, i64* %58, align 8, !tbaa !2
  %59 = tail call i64 @llvm.ve.vl.svm.sMs(<512 x i1> %51, i64 4)
  %60 = getelementptr inbounds i64, i64* %0, i64 4
  store i64 %59, i64* %60, align 8, !tbaa !2
  %61 = tail call i64 @llvm.ve.vl.svm.sMs(<512 x i1> %51, i64 5)
  %62 = getelementptr inbounds i64, i64* %0, i64 5
  store i64 %61, i64* %62, align 8, !tbaa !2
  %63 = tail call i64 @llvm.ve.vl.svm.sMs(<512 x i1> %51, i64 6)
  %64 = getelementptr inbounds i64, i64* %0, i64 6
  store i64 %63, i64* %64, align 8, !tbaa !2
  %65 = tail call i64 @llvm.ve.vl.svm.sMs(<512 x i1> %51, i64 7)
  %66 = getelementptr inbounds i64, i64* %0, i64 7
  store i64 %65, i64* %66, align 8, !tbaa !2
  ret void
}

; Function Attrs: nounwind readnone
declare <512 x i1> @llvm.ve.vl.lvm.MMss(<512 x i1>, i64, i64) #1

; Function Attrs: nounwind readnone
declare <512 x i1> @llvm.ve.vl.andm.MMM(<512 x i1>, <512 x i1>) #1

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
