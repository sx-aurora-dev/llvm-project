; RUN: opt "-passes=noelle-transformer,verify<loops>,verify<domtree>,print<pdg>" -noelle-transformer-apply=loop-distribution -disable-output < %s 2>&1 | FileCheck %s
; RUN: opt "-passes=noelle-transformer,verify<loops>,verify<domtree>,print<pdg>" -noelle-transformer-apply=loop-distribution -loop-dist-api-granularity=1 -disable-output < %s 2>&1 | FileCheck %s

; Preserving basic-reorder.ll
; These are the edges we get from PDGAnalysis, if we don't preserve. We should have the exact same edges
; Note that for we don't check granularity=2 because it's not really our responsibility to know
; what happens if we don't preserve.

; CHECK-NOT: {{.*}} ---->
; CHECK-DAG: @f(  %add  ) ----> @f(  %arrayidxA_plus_4  )  [RAW (must)]
; CHECK-DAG: @f(  %ind  ) ----> @f(  %add  )  [RAW (must)]
; CHECK-DAG: @f(  %ind  ) ----> @f(  %arrayidxC  )  [RAW (must)]
; CHECK-DAG: @f(  %arrayidxB  ) ----> @f(  %loadB  )  [RAW (must)]
; CHECK-DAG: @f :: %a ----> @f(  %arrayidxA_plus_4  )  [RAW (must)]
; CHECK-DAG: @f(  br i1 %exitcond.ldist, label %entry.split, label %for.body.ldist  ) ----> @f(  %ind.ldist  )  [CTRL]
; CHECK-DAG: @f(  %add  ) ----> @f(  %exitcond  )  [RAW (must)]
; CHECK-DAG: @f(  %ind  ) ----> @f(  %arrayidxD  )  [RAW (must)]
; CHECK-DAG: @f(  %loadE  ) ----> @f(  %mulC  )  [RAW (must)]
; CHECK-DAG: @f :: %a ----> @f(  %arrayidxA  )  [RAW (must)]
; CHECK-DAG: @f(  %exitcond  ) ----> @f(  br i1 %exitcond, label %for.end, label %for.body  )  [RAW (must)]
; CHECK-DAG: @f(  %arrayidxD  ) ----> @f(  %loadD  )  [RAW (must)]
; CHECK-DAG: @f(  %add  ) ----> @f(  %ind  )  [RAW (must)]
; CHECK-DAG: @f :: %b ----> @f(  %arrayidxB  )  [RAW (must)]
; CHECK-DAG: @f :: %e ----> @f(  %arrayidxE  )  [RAW (must)]
; CHECK-DAG: @f(  br i1 %exitcond.ldist, label %entry.split, label %for.body.ldist  ) ----> @f(  %loadA.ldist  )  [CTRL]
; CHECK-DAG: @f(  %ind  ) ----> @f(  %arrayidxE  )  [RAW (must)]
; CHECK-DAG: @f(  %arrayidxA_plus_4.ldist  ) ----> @f(  store %arrayidxA_plus_4.ldist  )  [RAW (must)]
; CHECK-DAG: @f(  %ind  ) ----> @f(  %arrayidxB  )  [RAW (must)]
; CHECK-DAG: @f(  %ind  ) ----> @f(  %arrayidxA  )  [RAW (must)]
; CHECK-DAG: @f(  %mulC  ) ----> @f(  store %arrayidxC  )  [RAW (must)]
; CHECK-DAG: @f :: %d ----> @f(  %arrayidxD  )  [RAW (must)]
; CHECK-DAG: @f(  br i1 %exitcond, label %for.end, label %for.body  ) ----> @f(  %loadD  )  [CTRL]
; CHECK-DAG: @f :: %c ----> @f(  %arrayidxC  )  [RAW (must)]
; CHECK-DAG: @f(  store %arrayidxA_plus_4.ldist  ) ----> @f(  %loadA.ldist  )  [RAW (must) from memory ]
; CHECK-DAG: @f(  %loadD  ) ----> @f(  %mulC  )  [RAW (must)]
; CHECK-DAG: @f(  %arrayidxC  ) ----> @f(  store %arrayidxC  )  [RAW (must)]
; CHECK-DAG: @f(  br i1 %exitcond.ldist, label %entry.split, label %for.body.ldist  ) ----> @f(  %arrayidxA.ldist  )  [CTRL]
; CHECK-DAG: @f(  %arrayidxE  ) ----> @f(  %loadE  )  [RAW (must)]
; CHECK-DAG: @f(  %loadA.ldist  ) ----> @f(  %mulA.ldist  )  [RAW (must)]
; CHECK-DAG: @f(  br i1 %exitcond.ldist, label %entry.split, label %for.body.ldist  ) ----> @f(  %arrayidxB.ldist  )  [CTRL]
; CHECK-DAG: @f(  br i1 %exitcond, label %for.end, label %for.body  ) ----> @f(  %arrayidxA  )  [CTRL]
; CHECK-DAG: @f(  br i1 %exitcond, label %for.end, label %for.body  ) ----> @f(  br i1 %exitcond, label %for.end, label %for.body  )  [CTRL]
; CHECK-DAG: @f(  br i1 %exitcond, label %for.end, label %for.body  ) ----> @f(  %ind  )  [CTRL]
; CHECK-DAG: @f :: %b ----> @f(  %arrayidxB.ldist  )  [RAW (must)]
; CHECK-DAG: @f(  br i1 %exitcond, label %for.end, label %for.body  ) ----> @f(  %arrayidxD  )  [CTRL]
; CHECK-DAG: @f(  br i1 %exitcond, label %for.end, label %for.body  ) ----> @f(  %arrayidxB  )  [CTRL]
; CHECK-DAG: @f(  br i1 %exitcond, label %for.end, label %for.body  ) ----> @f(  %loadB  )  [CTRL]
; CHECK-DAG: @f(  %arrayidxB.ldist  ) ----> @f(  %loadB.ldist  )  [RAW (must)]
; CHECK-DAG: @f(  br i1 %exitcond, label %for.end, label %for.body  ) ----> @f(  %add  )  [CTRL]
; CHECK-DAG: @f(  br i1 %exitcond, label %for.end, label %for.body  ) ----> @f(  %arrayidxA_plus_4  )  [CTRL]
; CHECK-DAG: @f(  br i1 %exitcond, label %for.end, label %for.body  ) ----> @f(  %loadE  )  [CTRL]
; CHECK-DAG: @f(  br i1 %exitcond, label %for.end, label %for.body  ) ----> @f(  %arrayidxC  )  [CTRL]
; CHECK-DAG: @f(  br i1 %exitcond, label %for.end, label %for.body  ) ----> @f(  %arrayidxE  )  [CTRL]
; CHECK-DAG: @f(  br i1 %exitcond, label %for.end, label %for.body  ) ----> @f(  %mulC  )  [CTRL]
; CHECK-DAG: @f(  %ind.ldist  ) ----> @f(  %arrayidxA.ldist  )  [RAW (must)]
; CHECK-DAG: @f(  br i1 %exitcond, label %for.end, label %for.body  ) ----> @f(  store %arrayidxC  )  [CTRL]
; CHECK-DAG: @f(  br i1 %exitcond, label %for.end, label %for.body  ) ----> @f(  %exitcond  )  [CTRL]
; CHECK-DAG: @f(  %add.ldist  ) ----> @f(  %ind.ldist  )  [RAW (must)]
; CHECK-DAG: @f(  %ind.ldist  ) ----> @f(  %add.ldist  )  [RAW (must)]
; CHECK-DAG: @f(  %ind.ldist  ) ----> @f(  %arrayidxB.ldist  )  [RAW (must)]
; CHECK-DAG: @f :: %a ----> @f(  %arrayidxA.ldist  )  [RAW (must)]
; CHECK-DAG: @f(  %arrayidxA.ldist  ) ----> @f(  %loadA.ldist  )  [RAW (must)]
; CHECK-DAG: @f(  %loadA.ldist  ) ----> @f(  store %arrayidxA_plus_4.ldist  )  [WAR (must) from memory ]
; CHECK-DAG: @f(  br i1 %exitcond.ldist, label %entry.split, label %for.body.ldist  ) ----> @f(  %loadB.ldist  )  [CTRL]
; CHECK-DAG: @f(  %loadB.ldist  ) ----> @f(  %mulA.ldist  )  [RAW (must)]
; CHECK-DAG: @f(  br i1 %exitcond.ldist, label %entry.split, label %for.body.ldist  ) ----> @f(  %mulA.ldist  )  [CTRL]
; CHECK-DAG: @f(  %mulA.ldist  ) ----> @f(  store %arrayidxA_plus_4.ldist  )  [RAW (must)]
; CHECK-DAG: @f(  br i1 %exitcond.ldist, label %entry.split, label %for.body.ldist  ) ----> @f(  %add.ldist  )  [CTRL]
; CHECK-DAG: @f(  %add.ldist  ) ----> @f(  %exitcond.ldist  )  [RAW (must)]
; CHECK-DAG: @f(  %add.ldist  ) ----> @f(  %arrayidxA_plus_4.ldist  )  [RAW (must)]
; CHECK-DAG: @f :: %a ----> @f(  %arrayidxA_plus_4.ldist  )  [RAW (must)]
; CHECK-DAG: @f(  br i1 %exitcond.ldist, label %entry.split, label %for.body.ldist  ) ----> @f(  %arrayidxA_plus_4.ldist  )  [CTRL]
; CHECK-DAG: @f(  br i1 %exitcond.ldist, label %entry.split, label %for.body.ldist  ) ----> @f(  store %arrayidxA_plus_4.ldist  )  [CTRL]
; CHECK-DAG: @f(  br i1 %exitcond.ldist, label %entry.split, label %for.body.ldist  ) ----> @f(  %exitcond.ldist  )  [CTRL]
; CHECK-DAG: @f(  %exitcond.ldist  ) ----> @f(  br i1 %exitcond.ldist, label %entry.split, label %for.body.ldist  )  [RAW (must)]
; CHECK-DAG: @f(  br i1 %exitcond.ldist, label %entry.split, label %for.body.ldist  ) ----> @f(  br i1 %exitcond.ldist, label %entry.split, label %for.body.ldist  )  [CTRL]
; CHECK-NOT: {{.*}} ---->

define void @f(i32* noalias %a,
               i32* noalias %b,
               i32* noalias %c,
               i32* noalias %d,
               i32* noalias %e) {
entry:
  br label %for.body

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