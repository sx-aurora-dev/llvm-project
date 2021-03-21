; RUN: opt -aa-pipeline=basic-aa "-passes=noelle-transformer,verify<loops>,verify<domtree>" -noelle-transformer-apply=loop-distribution < %s 2>&1 \
; RUN: | opt -simplifycfg -dce -S 2>&1 | FileCheck %s
; RUN: opt -aa-pipeline=basic-aa "-passes=noelle-transformer,verify<loops>,verify<domtree>" -noelle-transformer-apply=loop-distribution -loop-dist-api-granularity=1 < %s 2>&1 \
; RUN: | opt -simplifycfg -dce -S 2>&1 | FileCheck %s
; RUN: opt -aa-pipeline=basic-aa "-passes=noelle-transformer,verify<loops>,verify<domtree>" -noelle-transformer-apply=loop-distribution -loop-dist-api-granularity=2 < %s 2>&1 \
; RUN: | opt -simplifycfg -dce -S 2>&1 | FileCheck %s


; We will distribute the cycle in the middle.

; Here, we want to make sure that although noelle-transformer takes all the control-flow with it,
; -simplifycfg can trivially remove unneeded branches / blocks.

;   for (i = 0; i < x; i++) {
;     C[i] = D[i] * E[i];
;-----------------------------
;     A[i + 1] = A[i] * B[i];
;-----------------------------
;     if (F[i])
;        G[i] = H[i] * J[i];
;   }

; CHECK: for.body.ldist:
; CHECK-NOT: %mulC.ldist

; CHECK: %loadA.ldist =
; CHECK: store i32 %mulA.ldist

; Assert that -simplifycfg removed them
; CHECK-NOT: if.then.ldist:
; CHECK-NOT: if.end.ldist:

; CHECK: for.body:
; CHECK-NOT: store i32 %mulA,
; CHECK: %mulG

target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"

define void @f(i32* noalias %a,
               i32* noalias %b,
               i32* noalias %c,
               i32* noalias %d,
               i32* noalias %e,
               i32* noalias %g,
               i32* noalias %h,
               i32* noalias %j,
               i64 %x) {
entry:
  br label %for.body



for.body:                                         ; preds = %for.body, %entry
  %ind = phi i64 [ 0, %entry ], [ %add, %if.end ]

  %arrayidxD = getelementptr inbounds i32, i32* %d, i64 %ind
  %loadD = load i32, i32* %arrayidxD, align 4

  %arrayidxE = getelementptr inbounds i32, i32* %e, i64 %ind
  %loadE = load i32, i32* %arrayidxE, align 4

  %mulC = mul i32 %loadD, %loadE

  %arrayidxC = getelementptr inbounds i32, i32* %c, i64 %ind
  store i32 %mulC, i32* %arrayidxC, align 4


  %arrayidxA = getelementptr inbounds i32, i32* %a, i64 %ind
  %loadA = load i32, i32* %arrayidxA, align 4, !scc !0

  %arrayidxB = getelementptr inbounds i32, i32* %b, i64 %ind
  %loadB = load i32, i32* %arrayidxB, align 4

  %mulA = mul i32 %loadB, %loadA, !scc !0

  %add = add nuw nsw i64 %ind, 1
  %arrayidxA_plus_4 = getelementptr inbounds i32, i32* %a, i64 %add
  store i32 %mulA, i32* %arrayidxA_plus_4, align 4, !scc !0

  %if.cond = icmp eq i64 %ind, %x
  br i1 %if.cond, label %if.then, label %if.end

if.then:
  %arrayidxH = getelementptr inbounds i32, i32* %h, i64 %ind
  %loadH = load i32, i32* %arrayidxH, align 4

  %arrayidxJ = getelementptr inbounds i32, i32* %j, i64 %ind
  %loadJ = load i32, i32* %arrayidxJ, align 4

  %mulG = mul i32 %loadH, %loadJ

  %arrayidxG = getelementptr inbounds i32, i32* %g, i64 %ind
  store i32 %mulG, i32* %arrayidxG, align 4
  br label %if.end

if.end:
  %exitcond = icmp eq i64 %add, 20
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}

!0 = !{}