; RUN: opt -aa-pipeline=basic-aa "-passes=noelle-transformer,verify<loops>,verify<domtree>,dce,loop-deletion,simplifycfg" -noelle-transformer-apply=loop-distribution -S < %s 2>&1 \
; RUN: | FileCheck %s
; RUN: opt -aa-pipeline=basic-aa "-passes=noelle-transformer,verify<loops>,verify<domtree>,dce,loop-deletion,simplifycfg" -noelle-transformer-apply=loop-distribution -loop-dist-api-granularity=1 -S < %s 2>&1 | FileCheck %s
; RUN: opt -aa-pipeline=basic-aa "-passes=noelle-transformer,verify<loops>,verify<domtree>,dce,loop-deletion,simplifycfg" -noelle-transformer-apply=loop-distribution -loop-dist-api-granularity=2 -S < %s 2>&1 | FileCheck %s

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
;     }
;------------------------------------
;     A[i + 1] = A[i] * B[i];
;------------------------------------
;   }
; }

; We want to test that:
; a) The SCC above will be distributed
; b) Although LoopDistribution will leave a lot of unused code behind, this
;    code will be removed by further passes (whose job is better suited in
;    actually removing useless code)
;    Specifically, we expect LoopDistribution to leave two artifacts:
;    1) The cycle will be distributed to a new top-level loop above, but
;       it will take with it the j-loop, which in the new loop however
;       will be empty. loop-deletion should be able to remove that.
;    2) In the original loop, although the important parts of the cycle
;       (e.g., the store to A[i+1]) will be removed, a lot of unused instructions
;       will be left (e.g., array indexes, loads etc.). DCE should be able to remove
;       those.

; First, check that the SCC has been copied to the new loop
; CHECK: outer.header.ldist:
; CHECK: store i64 %mulA.ldist

; Next, check that the j-loop has been deleted from the new loop
; CHECK-NOT: %j.ldist

; Now, check that no hindering code (i.e., which can't be removed e.g., by DCE) has been copied.
; Specifically, the store to C
; CHECK-NOT: store i64 %mulC.ldist

; Check that the original loop exists and has the store to C
; CHECK: outer.header:
; CHECK: store i64 %mulC,

; Now, check that the original code has no leftovers
; CHECK: outer.latch:
; CHECK-NEXT:   %i.next =
; CHECK-NEXT:   br

; Actually check that most of the code has been removed

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
  %arrayidxC = getelementptr inbounds i64, i64* %C, i64 %i
  store i64 %mulC, i64* %arrayidxC, align 8
  %j.next = add nsw i64 %j, 1
  br label %inner.header

outer.latch:                                          ; preds = %inner.header
  %arrayidxA = getelementptr inbounds i64, i64* %A, i64 %i
  %loadA = load i64, i64* %arrayidxA, align 8, !scc !0
  %arrayidxB = getelementptr inbounds i64, i64* %B, i64 %i
  %loadB = load i64, i64* %arrayidxB, align 8
  %mulA = mul nsw i64 %loadA, %loadB, !scc !0
  %add = add nsw i64 %i, 1
  %arrayidxA_plus_1 = getelementptr inbounds i64, i64* %A, i64 %add
  store i64 %mulA, i64* %arrayidxA_plus_1, align 8, !scc !0
  %i.next = add nsw i64 %i, 1
  br label %outer.header

exit:                                        ; preds = %outer.header
  ret void
}

!0 = !{}