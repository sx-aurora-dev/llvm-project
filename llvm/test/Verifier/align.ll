; RUN: not llvm-as < %s -o /dev/null 2>&1 | FileCheck %s

; CHECK-NOT: Wrong types for attribute: inalloca nest noalias nocapture nonnull readnone readonly byref(i32) byval(i32) preallocated(i32) sret(i32) align 1 dereferenceable(1) dereferenceable_or_null(1)
; CHECK-NOT: @align_int
define void @align_int(i32 align 4 %a) {
  ret void
}

; CHECK: Attribute 'align 4' applied to incompatible type!
; CHECK-NEXT: @align_non_pointer2
define align 4 void @align_non_pointer2(i32 %a) {
  ret void
}
