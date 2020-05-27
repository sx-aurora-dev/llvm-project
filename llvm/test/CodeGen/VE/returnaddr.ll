; RUN: llc < %s -mtriple=ve-- | FileCheck %s

define i8* @h() nounwind readnone optsize {
; CHECK-LABEL: h:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld %s0, (, %s9)
; CHECK-NEXT:    ld %s0, (, %s0)
; CHECK-NEXT:    ld %s0, 8(, %s0)
; CHECK-NEXT:    or %s11, 0, %s9
entry:
	%ret = tail call i8* @llvm.returnaddress(i32 2)
	ret i8* %ret
}

declare i8* @llvm.returnaddress(i32) nounwind readnone

define i8* @g() nounwind readnone optsize {
; CHECK-LABEL: g:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld %s0, (, %s9)
; CHECK-NEXT:    ld %s0, 8(, %s0)
; CHECK-NEXT:    or %s11, 0, %s9
entry:
	%ret = tail call i8* @llvm.returnaddress(i32 1)
	ret i8* %ret
}

define i8* @f() nounwind readnone optsize {
; CHECK-LABEL: f:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld %s0, 8(, %s9)
; CHECK-NEXT:    or %s11, 0, %s9
entry:
	%ret = tail call i8* @llvm.returnaddress(i32 0)
	ret i8* %ret
}
