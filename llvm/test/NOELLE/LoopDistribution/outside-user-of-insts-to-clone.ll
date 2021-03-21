; RUN: opt "-passes=noelle-transformer,verify<loops>,verify<domtree>,print<pdg>" -noelle-transformer-apply=loop-distribution -S < %s 2>&1 | FileCheck %s
; RUN: opt "-passes=noelle-transformer,verify<loops>,verify<domtree>,print<pdg>" -noelle-transformer-apply=loop-distribution -loop-dist-api-granularity=1 -S < %s 2>&1 | FileCheck %s
; RUN: opt "-passes=noelle-transformer,verify<loops>,verify<domtree>,print<pdg>" -noelle-transformer-apply=loop-distribution -loop-dist-api-granularity=2 -S < %s 2>&1 | FileCheck %s

; This is the same as simple.ll but there's an instruction %dummy that:
; a) The SCC depends (which implies that we have to bring it in the new loop)
; b) It's not the in the SCC
; c) Is used outside

; We want to test that ret will use %dummy and not %dummy.ldist. The original loop
; post-dominates the new loop so when it comes to register users, they can keep
; using the old registers. We want to verify that there is no dependence edge in the PDG either.

; CHECK: %dummy.ldist
; CHECK: %dummy =
; CHECK-NOT: ret i64 %dummy.ldist

; CHECK-NOT: @foo(  %dummy.ldist  ) ----> @foo(  ret i64 %dummy  )

define i64 @foo(i64* %p, i64 %len) {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %i = phi i64 [ 0, %entry ], [ %i.next, %while.body ]
  ;-------------------------------------------------------------
  %j = phi i64 [ 0, %entry ], [ %j.next, %while.body ], !scc !0
  ;-------------------------------------------------------------
  %dummy = add i64 1, 2
  %cond = icmp slt i64 %i, %len
  br i1 %cond, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %i.next = add nsw i64 %i, 1
  ;-------------------------------------------------------------
  %j.next = add nsw i64 %j, %dummy, !scc !0
  ;-------------------------------------------------------------
  %p_i = getelementptr inbounds i64, i64* %p, i64 %i.next
  store i64 %i.next, i64* %p_i, align 8
  br label %while.cond

while.end:                                        ; preds = %while.cond
  ret i64 %dummy
}

!0 = !{}
