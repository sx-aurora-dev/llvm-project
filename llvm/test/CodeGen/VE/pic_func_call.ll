; RUN: llc -relocation-model=pic < %s -mtriple=ve-unknown-unknown | FileCheck %s

define void @func() {
; CHECK-LABEL: func:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s12, function@plt_lo(-24)
; CHECK-NEXT:  and %s12, %s12, (32)0
; CHECK-NEXT:  sic %s16
; CHECK-NEXT:  lea.sl %s12, function@plt_hi(%s16, %s12)
; CHECK-NEXT:  bsic %lr, (,%s12)

  call void bitcast (void (...)* @function to void ()*)()
  ret void
}

declare void @function(...)

!2 = !{!"clang version 8.0.0 (git@socsv218.svp.cl.nec.co.jp:ve-llvm/clang.git 3b98372866ea8dd6c83dd461fdd1bff7ac3658ba) (llvm/llvm.git 6fe73ad9979f8f32a171413308a96c1d7c3b6a18)"}
