; RUN: llc < %s -mtriple=ve-- | FileCheck %s

define i8* @test1() nounwind {
entry:
; CHECK-LABEL: test1
; CHECK:         or %s0, 0, %s9
; CHECK:         or %s11, 0, %s9
  %ret = tail call i8* @llvm.frameaddress(i32 0)
  ret i8* %ret
}

define i8* @test2() nounwind {
entry:
; CHECK-LABEL: test2
; CHECK:         ld %s0, (, %s9)
; CHECK-NEXT:    ld %s0, (, %s0)
; CHECK:         or %s11, 0, %s9
  %ret = tail call i8* @llvm.frameaddress(i32 2)
  ret i8* %ret
}

declare i8* @llvm.frameaddress(i32) nounwind readnone
