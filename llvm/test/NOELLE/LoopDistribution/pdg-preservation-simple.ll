; RUN: opt "-passes=noelle-transformer,verify<loops>,verify<domtree>,print<pdg>" -noelle-transformer-apply=loop-distribution -disable-output < %s 2>&1 | FileCheck %s
; RUN: opt "-passes=noelle-transformer,verify<loops>,verify<domtree>,print<pdg>" -noelle-transformer-apply=loop-distribution -loop-dist-api-granularity=1 -disable-output < %s 2>&1 | FileCheck %s

; Preserving simple.ll
; These are the edges we get from PDGAnalysis, if we don't preserve. We should have the exact same edges
; Note that for we don't check granularity=2 because it's not really our responsibility to know
; what happens if we don't preserve.

; CHECK-NOT: {{.*}} ---->
; CHECK-DAG: @foo :: %p ----> @foo(  %p_i  )  [RAW (must)]
; CHECK-DAG: @foo(  %i.ldist  ) ----> @foo(  %i.next.ldist  )  [RAW (must)]
; CHECK-DAG: @foo(  %cond.ldist  ) ----> @foo(  br i1 %cond.ldist, label %while.body.ldist, label %entry.split  )  [RAW (must)]
; CHECK-DAG: @foo(  %p_i  ) ----> @foo(  store %p_i  )  [RAW (must)]
; CHECK-DAG: @foo(  %j.ldist  ) ----> @foo(  %j.next.ldist  )  [RAW (must)]
; CHECK-DAG: @foo :: %len ----> @foo(  %cond.ldist  )  [RAW (must)]
; CHECK-DAG: @foo :: %len ----> @foo(  %cond  )  [RAW (must)]
; CHECK-DAG: @foo(  %i.ldist  ) ----> @foo(  %cond.ldist  )  [RAW (must)]
; CHECK-DAG: @foo(  br i1 %cond, label %while.body, label %while.end  ) ----> @foo(  %cond  )  [CTRL]
; CHECK-DAG: @foo(  %dummy.ldist  ) ----> @foo(  %j.next.ldist  )  [RAW (must)]
; CHECK-DAG: @foo(  br i1 %cond.ldist, label %while.body.ldist, label %entry.split  ) ----> @foo(  br label %while.cond.ldist  )  [CTRL]
; CHECK-DAG: @foo(  %i.next.ldist  ) ----> @foo(  %i.ldist  )  [RAW (must)]
; CHECK-DAG: @foo(  %j.next.ldist  ) ----> @foo(  %j.ldist  )  [RAW (must)]
; CHECK-DAG: @foo(  %i  ) ----> @foo(  %cond  )  [RAW (must)]
; CHECK-DAG: @foo(  %i  ) ----> @foo(  %i.next  )  [RAW (must)]
; CHECK-DAG: @foo(  %cond  ) ----> @foo(  br i1 %cond, label %while.body, label %while.end  )  [RAW (must)]
; CHECK-DAG: @foo(  br i1 %cond.ldist, label %while.body.ldist, label %entry.split  ) ----> @foo(  %cond.ldist  )  [CTRL]
; CHECK-DAG: @foo(  %dummy  ) ----> @foo(  ret i64 %dummy  )  [RAW (must)]
; CHECK-DAG: @foo(  %i.next  ) ----> @foo(  store %p_i  )  [RAW (must)]
; CHECK-DAG: @foo(  %i.next  ) ----> @foo(  %p_i  )  [RAW (must)]
; CHECK-DAG: @foo(  %i.next  ) ----> @foo(  %i  )  [RAW (must)]
; CHECK-DAG: @foo(  br i1 %cond.ldist, label %while.body.ldist, label %entry.split  ) ----> @foo(  %i.ldist  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %cond, label %while.body, label %while.end  ) ----> @foo(  %i.next  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %cond.ldist, label %while.body.ldist, label %entry.split  ) ----> @foo(  %j.ldist  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %cond.ldist, label %while.body.ldist, label %entry.split  ) ----> @foo(  %dummy.ldist  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %cond.ldist, label %while.body.ldist, label %entry.split  ) ----> @foo(  br i1 %cond.ldist, label %while.body.ldist, label %entry.split  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %cond.ldist, label %while.body.ldist, label %entry.split  ) ----> @foo(  %i.next.ldist  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %cond.ldist, label %while.body.ldist, label %entry.split  ) ----> @foo(  %j.next.ldist  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %cond, label %while.body, label %while.end  ) ----> @foo(  %i  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %cond, label %while.body, label %while.end  ) ----> @foo(  %dummy  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %cond, label %while.body, label %while.end  ) ----> @foo(  br i1 %cond, label %while.body, label %while.end  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %cond, label %while.body, label %while.end  ) ----> @foo(  %p_i  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %cond, label %while.body, label %while.end  ) ----> @foo(  store %p_i  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %cond, label %while.body, label %while.end  ) ----> @foo(  br label %while.cond  )  [CTRL]
; CHECK-NOT: {{.*}} ---->

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
