; RUN: opt -aa-pipeline=basic-aa "-passes=print<pdg>" -S < %s 2>&1 | FileCheck %s

; CHECK-NOT: from memory

; void foo(int* p, int* restrict q) {
;   *p = *q;
; }

define void @foo(i32* %p, i32* noalias %q) {
entry:
  %0 = load i32, i32* %q, align 4
  store i32 %0, i32* %p, align 4
  ret void
}