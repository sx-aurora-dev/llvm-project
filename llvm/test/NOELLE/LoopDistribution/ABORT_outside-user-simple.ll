; RUN: opt "-passes=noelle-transformer,verify<loops>,verify<domtree>" -noelle-transformer-apply=loop-distribution -S < %s 2>&1 | FileCheck %s
; RUN: opt "-passes=noelle-transformer,verify<loops>,verify<domtree>" -noelle-transformer-apply=loop-distribution -loop-dist-api-granularity=1 -S < %s 2>&1 | FileCheck %s  --check-prefixes=CHECK_WITHOUT_TRIVIAL
; RUN: opt "-passes=noelle-transformer,verify<loops>,verify<domtree>" -noelle-transformer-apply=loop-distribution -loop-dist-api-granularity=2 -S < %s 2>&1 | FileCheck %s --check-prefixes=CHECK_WITHOUT_TRIVIAL

; In no granularity level should we distribute the SCC because it's illegal.

; CHECK-NOT: ldist
; CHECK_WITHOUT_TRIVIAL-NOT: ldist

define i64 @foo(i64* %p, i64 %len) {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %i = phi i64 [ 0, %entry ], [ %i.next, %while.body ]
  %j = phi i64 [ 0, %entry ], [ %j.next, %while.body ], !scc !0
  %cond = icmp slt i64 %i, %len
  br i1 %cond, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %i.next = add nsw i64 %i, 1
  %j.next = add nsw i64 %j, 1, !scc !0
  %p_i = getelementptr inbounds i64, i64* %p, i64 %i.next
  store i64 %i.next, i64* %p_i, align 8
  br label %while.cond

while.end:                                        ; preds = %while.cond
  ret i64 %j       ;;;;;; This is the outside user
}

!0 = !{}