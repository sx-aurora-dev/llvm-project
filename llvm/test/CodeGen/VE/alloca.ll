; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

@buf = external global i8*, align 8

declare void @user(i8*)

; Function Attrs: nounwind
define void @alloc(i64 %n) {
; CHECK-LABEL: test:
; CHECK:       .LBB0_2:
; CHECK-NEXT:    lea %s0, 15(%s0)
; CHECK-NEXT:    and %s0, -16, %s0
; CHECK-NEXT:    lea %s0, __llvm_grow_stack@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __llvm_grow_stack@hi(%s0)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    lea %s1, 240(%s11)
; CHECK-NEXT:    lea %s0, buf@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, buf@hi(%s0)
; CHECK-NEXT:    ld %s0, (,%s0)
; CHECK-NEXT:    lea %s0, memcpy@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, memcpy@hi(%s0)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %a = alloca i8, i64 %n, align 8
  %d = load i8*, i8** @buf, align 8
  call void @user(i8* %a)
  ret void
}

; Function Attrs: nounwind
define void @alloc_aligned(i64 %n) {
; CHECK-LABEL: test:
; CHECK:       .LBB0_2:
; CHECK-NEXT:    lea %s0, 15(%s0)
; CHECK-NEXT:    and %s0, -16, %s0
; CHECK-NEXT:    lea %s0, __llvm_grow_stack_align@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __llvm_grow_stack_align@hi(%s0)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    lea %s1, 240(%s11)
; CHECK-NEXT:    lea %s0, buf@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, buf@hi(%s0)
; CHECK-NEXT:    ld %s0, (,%s0)
; CHECK-NEXT:    lea %s0, memcpy@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, memcpy@hi(%s0)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %a = alloca i8, i64 %n, align 512
  call void @user(i8* %a)
  ret void
}
