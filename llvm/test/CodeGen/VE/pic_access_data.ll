; RUN: llc -relocation-model=pic < %s -mtriple=ve-unknown-unknown | FileCheck %s

@dst = external global i32, align 4
@ptr = external global i32*, align 8
@src = external global i32, align 4

define i32 @func() {
; CHECK-LABEL: func:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s15, _GLOBAL_OFFSET_TABLE_@pc_lo(-24)
; CHECK-NEXT:  and %s15, %s15, (32)0
; CHECK-NEXT:  sic %s16
; CHECK-NEXT:  lea.sl %s15, _GLOBAL_OFFSET_TABLE_@pc_hi(%s16, %s15)
; CHECK-NEXT:  lea %s34, dst@got_lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, dst@got_hi(%s34)
; CHECK-NEXT:  adds.l %s34, %s15, %s34
; CHECK-NEXT:  ld %s34, (,%s34)
; CHECK-NEXT:  lea %s35, ptr@got_lo
; CHECK-NEXT:  and %s35, %s35, (32)0
; CHECK-NEXT:  lea.sl %s35, ptr@got_hi(%s35)
; CHECK-NEXT:  lea %s36, src@got_lo
; CHECK-NEXT:  and %s36, %s36, (32)0
; CHECK-NEXT:  lea.sl %s36, src@got_hi(%s36)
; CHECK-NEXT:  adds.l %s36, %s15, %s36
; CHECK-NEXT:  ld %s36, (,%s36)
; CHECK-NEXT:  adds.l %s35, %s15, %s35
; CHECK-NEXT:  ld %s35, (,%s35)
; CHECK-NEXT:  ldl.sx %s36, (,%s36)
; CHECK-NEXT:  st %s34, (,%s35)
; CHECK-NEXT:  or %s0, 1, (0)1
; CHECK-NEXT:  stl %s36, (,%s34)
; CHECK-NEXT:  or %s11, 0, %s9

  store i32* @dst, i32** @ptr, align 8, !tbaa !3
  %1 = load i32, i32* @src, align 4, !tbaa !7
  store i32 %1, i32* @dst, align 4, !tbaa !7
  ret i32 1
}

!2 = !{!"clang version 8.0.0 (git@socsv218.svp.cl.nec.co.jp:ve-llvm/clang.git 3b98372866ea8dd6c83dd461fdd1bff7ac3658ba) (llvm/llvm.git 6fe73ad9979f8f32a171413308a96c1d7c3b6a18)"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
!7 = !{!8, !8, i64 0}
!8 = !{!"int", !5, i64 0}
