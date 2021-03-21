; RUN: opt "-passes=noelle-transformer,verify<loops>,verify<domtree>" -noelle-transformer-apply=loop-distribution -S < %s 2>&1 | opt -dce -S 2>&1 | FileCheck %s
; RUN: opt "-passes=noelle-transformer,verify<loops>,verify<domtree>" -noelle-transformer-apply=loop-distribution -loop-dist-api-granularity=1 -S < %s 2>&1 | opt -dce -S 2>&1 | FileCheck %s
; RUN: opt "-passes=noelle-transformer,verify<loops>,verify<domtree>" -noelle-transformer-apply=loop-distribution -loop-dist-api-granularity=2 -S < %s 2>&1 | opt -dce -S 2>&1 | FileCheck %s

; Distributing this loop to avoid the dependence cycle would require to
; reorder S1 and S2 to form the two partitions: {S2} | {S1, S3}.  This is
; something that LoopDistribute can't achieve because LoopAccessAnalysis
; does not allow reordering memory operations.
; We want to test that we can achieve that.

;   for (i = 0; i < n; i++) {
;     S1: d = D[i];
;     S2: A[i + 1] = A[i] * B[i];    <--- We want to remove this SCC
;     S3: C[i] = d * E[i];
;   }

; Note something important here. %loadA, store i32 %mulA
; form a cycle but they're NOT an SCC. The reason is that they're not maximal
; and an SCC is maximal by definition. We don't want to do that!!

; In this specific case, if you don't stub %mulA, it will be considered outside
; of the SCC, but it depends on it, so you won't be able to remove the SCC
; from the loop and you won't do the distribution.

define void @f(i32* noalias %a,
               i32* noalias %b,
               i32* noalias %c,
               i32* noalias %d,
               i32* noalias %e) {
entry:
  br label %for.body

; CHECK: %loadA.ldist = load i32, i32* %arrayidxA.ldist, align 4
; CHECK: %loadB.ldist = load i32, i32* %arrayidxB.ldist, align 4
; CHECK: %mulA.ldist = mul i32 %loadB.ldist, %loadA.ldist
; CHECK: store i32 %mulA.ldist, i32* %arrayidxA_plus_4.ldist, align 4
; CHECK: br i1 %exitcond.ldist, label %entry.split, label %for.body.ldist

; CHECK-NOT: %loadC.ldist
; CHECK-NOT: %loadD.ldist
; CHECK-NOT: %loadE.ldist

; CHECK: %loadD =
; CHECK: %loadE =
; CHECK: %mulC =

; CHECK-NOT: %loadA =
; CHECK-NOT: %loadB =

for.body:                                         ; preds = %for.body, %entry
  %ind = phi i64 [ 0, %entry ], [ %add, %for.body ]

  %arrayidxD = getelementptr inbounds i32, i32* %d, i64 %ind
  %loadD = load i32, i32* %arrayidxD, align 4

  %arrayidxA = getelementptr inbounds i32, i32* %a, i64 %ind
  %loadA = load i32, i32* %arrayidxA, align 4, !scc !0

  %arrayidxB = getelementptr inbounds i32, i32* %b, i64 %ind
  %loadB = load i32, i32* %arrayidxB, align 4

  %mulA = mul i32 %loadB, %loadA, !scc !0

  %add = add nuw nsw i64 %ind, 1
  %arrayidxA_plus_4 = getelementptr inbounds i32, i32* %a, i64 %add

  store i32 %mulA, i32* %arrayidxA_plus_4, align 4, !scc !0

  %arrayidxC = getelementptr inbounds i32, i32* %c, i64 %ind

  %arrayidxE = getelementptr inbounds i32, i32* %e, i64 %ind
  %loadE = load i32, i32* %arrayidxE, align 4

  %mulC = mul i32 %loadD, %loadE

  store i32 %mulC, i32* %arrayidxC, align 4

  %exitcond = icmp eq i64 %add, 20
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}

!0 = !{}