; RUN: llc -relocation-model=pic < %s -mtriple=ve-unknown-unknown | FileCheck %s

@dst = internal unnamed_addr global i32 0, align 4
@src = internal unnamed_addr global i1 false, align 4
@.str = private unnamed_addr constant [3 x i8] c"%d\00", align 1

define void @func() {
; CHECK-LABEL: func:
; CHECK:       .LBB0_2:
; CHECK-NEXT:  lea %s15, _GLOBAL_OFFSET_TABLE_@pc_lo(-24)
; CHECK-NEXT:  and %s15, %s15, (32)0
; CHECK-NEXT:  sic %s16
; CHECK-NEXT:  lea.sl %s15, _GLOBAL_OFFSET_TABLE_@pc_hi(%s16, %s15)
; CHECK-NEXT:  lea %s34, src@gotoff_lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, src@gotoff_hi(%s34)
; CHECK-NEXT:  adds.l %s34, %s15, %s34
; CHECK-NEXT:  ld1b.zx %s34, (,%s34)
; CHECK-NEXT:  or %s35, 0, (0)1
; CHECK-NEXT:  lea %s36, 100
; CHECK-NEXT:  cmov.w.ne %s35, %s36, %s34
; CHECK-NEXT:  lea %s34, dst@gotoff_lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, dst@gotoff_hi(%s34)
; CHECK-NEXT:  adds.l %s34, %s15, %s34
; CHECK-NEXT:  stl %s35, (,%s34)

  %1 = load i1, i1* @src, align 4
  %2 = select i1 %1, i32 100, i32 0
  store i32 %2, i32* @dst, align 4, !tbaa !3
  ret void
}

; Function Attrs: nounwind
define i32 @main() {
  store i1 true, i1* @src, align 4
  tail call void @func()
  %1 = load i32, i32* @dst, align 4, !tbaa !3
  %2 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i64 0, i64 0), i32 %1)
  ret i32 0
}

declare i32 @printf(i8* nocapture readonly, ...)

!2 = !{!"clang version 8.0.0 (git@socsv218.svp.cl.nec.co.jp:ve-llvm/clang.git 3b98372866ea8dd6c83dd461fdd1bff7ac3658ba) (llvm/llvm.git 6fe73ad9979f8f32a171413308a96c1d7c3b6a18)"}
!3 = !{!4, !4, i64 0}
!4 = !{!"int", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
