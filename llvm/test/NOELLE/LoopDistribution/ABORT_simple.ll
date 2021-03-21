; RUN: opt "-passes=noelle-transformer,verify<loops>,verify<domtree>" -noelle-transformer-apply=loop-distribution -S < %s 2>&1 | FileCheck %s
; RUN: opt "-passes=noelle-transformer,verify<loops>,verify<domtree>" -noelle-transformer-apply=loop-distribution -loop-dist-api-granularity=1 -S < %s 2>&1 | FileCheck %s  --check-prefixes=CHECK_WITHOUT_TRIVIAL
; RUN: opt "-passes=noelle-transformer,verify<loops>,verify<domtree>" -noelle-transformer-apply=loop-distribution -loop-dist-api-granularity=2 -S < %s 2>&1 | FileCheck %s --check-prefixes=CHECK_WITHOUT_TRIVIAL

; void foo(int64_t *p, int64_t len) {
;   int64_t i = 0;
;   int64_t j = 0;
;   while (i < len) {
;     ++i;
;     ++j;  <-- We want to remove this SCC
;   }
; }

; You may also want to check simple.ll

; You can't bring ++j out of the loop alone, you have to bring the `i < len` check, which
; means you also have to bring the `++i` and pretty much, you have to bring the whole
; loop.

; CHECK-NOT:  ldist:
; CHECK_WITHOUT_TRIVIAL: entry.split.ldist:

define void @foo(i64* %p, i64 %len) {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %i = phi i64 [ 0, %entry ], [ %i.next, %while.body ]
  ;-------------------------------------------------------------
  %j = phi i64 [ 0, %entry ], [ %j.next, %while.body ], !scc !0
  ;-------------------------------------------------------------
  %cond = icmp slt i64 %i, %len
  br i1 %cond, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %i.next = add nsw i64 %i, 1
  ;-------------------------------------------------------------
  %j.next = add nsw i64 %j, 1, !scc !0
  ;-------------------------------------------------------------
  br label %while.cond

while.end:                                        ; preds = %while.cond
  ret void
}

!0 = !{}
