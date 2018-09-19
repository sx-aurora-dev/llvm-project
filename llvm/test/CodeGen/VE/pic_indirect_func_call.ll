; RUN: llc -relocation-model=pic < %s -mtriple=ve-unknown-unknown | FileCheck %s

@ptr = external global void (...)*, align 8

define void @func() {
; CHECK-LABEL: func:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s15, _GLOBAL_OFFSET_TABLE_@pc_lo(-24)
; CHECK-NEXT:  and %s15, %s15, (32)0
; CHECK-NEXT:  sic %s16
; CHECK-NEXT:  lea.sl %s15, _GLOBAL_OFFSET_TABLE_@pc_hi(%s16, %s15)
; CHECK-NEXT:  lea %s34, function@got_lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, function@got_hi(%s34)
; CHECK-NEXT:  adds.l %s34, %s15, %s34
; CHECK-NEXT:  ld %s34, (,%s34)
; CHECK-NEXT:  lea %s35, ptr@got_lo
; CHECK-NEXT:  and %s35, %s35, (32)0
; CHECK-NEXT:  lea.sl %s35, ptr@got_hi(%s35)
; CHECK-NEXT:  adds.l %s35, %s15, %s35
; CHECK-NEXT:  ld %s35, (,%s35)
; CHECK-NEXT:  st %s34, (,%s35)
; CHECK-NEXT:  or %s12, 0, %s34
; CHECK-NEXT:  bsic %lr, (,%s12)

  store void (...)* @function, void (...)** @ptr, align 8
  %1 = load void (...)*, void (...)** @ptr, align 8
  %2 = bitcast void (...)* %1 to void ()*
  call void %2()
  ret void
}

declare void @function(...)

!2 = !{!"clang version 8.0.0 (git@socsv218.svp.cl.nec.co.jp:ve-llvm/clang.git 3b98372866ea8dd6c83dd461fdd1bff7ac3658ba) (llvm/llvm.git 6fe73ad9979f8f32a171413308a96c1d7c3b6a18)"}
