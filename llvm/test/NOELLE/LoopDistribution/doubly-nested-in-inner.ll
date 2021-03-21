; RUN: opt -aa-pipeline=basic-aa "-passes=noelle-transformer,verify<loops>,verify<domtree>,dce" -noelle-transformer-apply=loop-distribution -S < %s 2>&1 \
; RUN: | FileCheck %s
; RUN: opt -aa-pipeline=basic-aa "-passes=noelle-transformer,verify<loops>,verify<domtree>,dce" -noelle-transformer-apply=loop-distribution -loop-dist-api-granularity=1 -S < %s 2>&1 \
; RUN: | FileCheck %s
; RUN: opt -aa-pipeline=basic-aa "-passes=noelle-transformer,verify<loops>,verify<domtree>,dce" -noelle-transformer-apply=loop-distribution -loop-dist-api-granularity=2 -S < %s 2>&1 \
; RUN: | FileCheck %s

; Distribute the SCC to a new loop inside the outer loop and above the original innermost

; void foo(int64_t* restrict A,
;          int64_t* restrict B,
;          int64_t* restrict C,
;          int64_t* restrict D,
;          int64_t* restrict E,
;          int64_t n, int64_t m)
; {
;   for (int64_t i = 0; i < n; i++) {
;     for (int64_t j = 0; j < m; ++j) {
;       C[i] = D[i] * E[i];
;     ----------------------------
;       A[j + 1] = A[j] * B[j];
;     ----------------------------
;     }
;   }
; }

; Check that nothing weird happened to the outer loop
; CHECK: entry:
; CHECK-NOT: entry.split.ldist:

; CHECK: %mulA.ldist
; CHECK-NOT: %mulC.ldist

; CHECK-NOT: %mulA = 
; CHECK: %mulC =

define void @foo(i64* noalias %A,
                 i64* noalias %B,
                 i64* noalias %C,
                 i64* noalias %D,
                 i64* noalias %E,
                 i64 %n,
                 i64 %m) {
entry:
  br label %outer.header

outer.header:                                         ; preds = %outer.latch, %entry
  %i = phi i64 [ 0, %entry ], [ %i.next, %outer.latch ]
  %outer.cond = icmp slt i64 %i, %n
  br i1 %outer.cond, label %inner.ph, label %exit

inner.ph:                              ; preds = %outer.header
  br label %inner.header

inner.header:                                        ; preds = %inner.ph, %inner.body
  %j = phi i64 [ %j.next, %inner.body ], [ 0, %inner.ph ]
  %inner.cond = icmp slt i64 %j, %m
  br i1 %inner.cond, label %inner.body, label %outer.latch

inner.body:                                        ; preds = %inner.header
  %arrayidxD = getelementptr inbounds i64, i64* %D, i64 %i
  %loadD = load i64, i64* %arrayidxD, align 8
  %arrayidxE = getelementptr inbounds i64, i64* %E, i64 %i
  %loadE = load i64, i64* %arrayidxE, align 8
  %mulC = mul nsw i64 %loadD, %loadE
  %arrayidx5 = getelementptr inbounds i64, i64* %C, i64 %i
  store i64 %mulC, i64* %arrayidx5, align 8
  %arrayidxA = getelementptr inbounds i64, i64* %A, i64 %j
  %loadA = load i64, i64* %arrayidxA, align 8, !scc !0
  %arrayidxB = getelementptr inbounds i64, i64* %B, i64 %j
  %loadB = load i64, i64* %arrayidxB, align 8
  %mulA = mul nsw i64 %loadA, %loadB, !scc !0
  %add = add nsw i64 %j, 1
  %arrayidxA_plus_1 = getelementptr inbounds i64, i64* %A, i64 %add
  store i64 %mulA, i64* %arrayidxA_plus_1, align 8, !scc !0
  %j.next = add nsw i64 %j, 1
  br label %inner.header

outer.latch:                                        ; preds = %inner.header
  %i.next = add nsw i64 %i, 1
  br label %outer.header

exit:                                        ; preds = %outer.header
  ret void
}

!0 = !{}