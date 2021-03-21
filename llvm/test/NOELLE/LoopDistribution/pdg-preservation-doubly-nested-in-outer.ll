; RUN: opt "-passes=noelle-transformer,verify<loops>,verify<domtree>,print<pdg>" -noelle-transformer-apply=loop-distribution -disable-output < %s 2>&1 | FileCheck %s
; RUN: opt "-passes=noelle-transformer,verify<loops>,verify<domtree>,print<pdg>" -noelle-transformer-apply=loop-distribution -loop-dist-api-granularity=1 -disable-output < %s 2>&1 | FileCheck %s

; Preserving doubly-nested-in-outer.ll
; These are the edges we get from PDGAnalysis, if we don't preserve. We should have the exact same edges
; Note that for we don't check granularity=2 because it's not really our responsibility to know
; what happens if we don't preserve.

; CHECK-NOT: {{.*}} ---->
; CHECK-DAG: @foo(  %arrayidxB  ) ----> @foo(  %loadB  )  [RAW (must)]
; CHECK-DAG: @foo :: %D ----> @foo(  %arrayidxD  )  [RAW (must)]
; CHECK-DAG: @foo(  br i1 %inner.cond, label %inner.body, label %outer.latch  ) ----> @foo(  %j  )  [CTRL]
; CHECK-DAG: @foo :: %B ----> @foo(  %arrayidxB  )  [RAW (must)]
; CHECK-DAG: @foo(  br i1 %inner.cond, label %inner.body, label %outer.latch  ) ----> @foo(  %arrayidxE  )  [CTRL]
; CHECK-DAG: @foo(  %arrayidxA.ldist  ) ----> @foo(  %loadA.ldist  )  [RAW (must)]
; CHECK-DAG: @foo :: %A ----> @foo(  %arrayidxA_plus_1  )  [RAW (must)]
; CHECK-DAG: @foo(  br i1 %outer.cond.ldist, label %inner.ph.ldist, label %entry.split  ) ----> @foo(  br label %outer.header.ldist  )  [CTRL]
; CHECK-DAG: @foo :: %C ----> @foo(  %arrayidxC  )  [RAW (must)]
; CHECK-DAG: @foo(  %j  ) ----> @foo(  %inner.cond  )  [RAW (must)]
; CHECK-DAG: @foo :: %A ----> @foo(  %arrayidxA  )  [RAW (must)]
; CHECK-DAG: @foo(  br i1 %outer.cond, label %inner.ph, label %exit  ) ----> @foo(  br i1 %outer.cond, label %inner.ph, label %exit  )  [CTRL]
; CHECK-DAG: @foo :: %m ----> @foo(  %inner.cond  )  [RAW (must)]
; CHECK-DAG: @foo(  %loadA.ldist  ) ----> @foo(  store %arrayidxA_plus_1.ldist  )  [WAR (must) from memory ]
; CHECK-DAG: @foo(  %arrayidxD  ) ----> @foo(  %loadD  )  [RAW (must)]
; CHECK-DAG: @foo(  %outer.cond  ) ----> @foo(  br i1 %outer.cond, label %inner.ph, label %exit  )  [RAW (must)]
; CHECK-DAG: @foo(  %i  ) ----> @foo(  %arrayidxC  )  [RAW (must)]
; CHECK-DAG: @foo(  %i  ) ----> @foo(  %i.next  )  [RAW (must)]
; CHECK-DAG: @foo(  br i1 %inner.cond, label %inner.body, label %outer.latch  ) ----> @foo(  br label %inner.header  )  [CTRL]
; CHECK-DAG: @foo :: %n ----> @foo(  %outer.cond  )  [RAW (must)]
; CHECK-DAG: @foo(  %i  ) ----> @foo(  %add  )  [RAW (must)]
; CHECK-DAG: @foo(  %j.next  ) ----> @foo(  %j  )  [RAW (must)]
; CHECK-DAG: @foo(  %i  ) ----> @foo(  %arrayidxE  )  [RAW (must)]
; CHECK-DAG: @foo(  %i  ) ----> @foo(  %arrayidxB  )  [RAW (must)]
; CHECK-DAG: @foo(  br i1 %outer.cond.ldist, label %inner.ph.ldist, label %entry.split  ) ----> @foo(  %inner.cond.ldist  )  [CTRL]
; CHECK-DAG: @foo(  %i  ) ----> @foo(  %arrayidxA  )  [RAW (must)]
; CHECK-DAG: @foo(  %i  ) ----> @foo(  %arrayidxD  )  [RAW (must)]
; CHECK-DAG: @foo(  br i1 %outer.cond.ldist, label %inner.ph.ldist, label %entry.split  ) ----> @foo(  %arrayidxB.ldist  )  [CTRL]
; CHECK-DAG: @foo(  %i  ) ----> @foo(  %outer.cond  )  [RAW (must)]
; CHECK-DAG: @foo(  %loadE  ) ----> @foo(  %mulC  )  [RAW (must)]
; CHECK-DAG: @foo :: %E ----> @foo(  %arrayidxE  )  [RAW (must)]
; CHECK-DAG: @foo(  %arrayidxE  ) ----> @foo(  %loadE  )  [RAW (must)]
; CHECK-DAG: @foo(  br i1 %outer.cond, label %inner.ph, label %exit  ) ----> @foo(  %loadB  )  [CTRL]
; CHECK-DAG: @foo(  %j  ) ----> @foo(  %j.next  )  [RAW (must)]
; CHECK-DAG: @foo(  %inner.cond  ) ----> @foo(  br i1 %inner.cond, label %inner.body, label %outer.latch  )  [RAW (must)]
; CHECK-DAG: @foo(  %loadD  ) ----> @foo(  %mulC  )  [RAW (must)]
; CHECK-DAG: @foo(  %mulC  ) ----> @foo(  store %arrayidxC  )  [RAW (must)]
; CHECK-DAG: @foo(  %arrayidxC  ) ----> @foo(  store %arrayidxC  )  [RAW (must)]
; CHECK-DAG: @foo(  br i1 %inner.cond, label %inner.body, label %outer.latch  ) ----> @foo(  %loadE  )  [CTRL]
; CHECK-DAG: @foo(  %add  ) ----> @foo(  %arrayidxA_plus_1  )  [RAW (must)]
; CHECK-DAG: @foo(  %i.next  ) ----> @foo(  %i  )  [RAW (must)]
; CHECK-DAG: @foo(  br i1 %inner.cond, label %inner.body, label %outer.latch  ) ----> @foo(  store %arrayidxC  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %outer.cond, label %inner.ph, label %exit  ) ----> @foo(  %i  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %outer.cond, label %inner.ph, label %exit  ) ----> @foo(  %outer.cond  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %outer.cond, label %inner.ph, label %exit  ) ----> @foo(  br label %inner.header  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %inner.cond, label %inner.body, label %outer.latch  ) ----> @foo(  %inner.cond  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %outer.cond, label %inner.ph, label %exit  ) ----> @foo(  %arrayidxA_plus_1  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %inner.cond, label %inner.body, label %outer.latch  ) ----> @foo(  br i1 %inner.cond, label %inner.body, label %outer.latch  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %outer.cond, label %inner.ph, label %exit  ) ----> @foo(  br i1 %inner.cond, label %inner.body, label %outer.latch  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %outer.cond, label %inner.ph, label %exit  ) ----> @foo(  %j  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %outer.cond, label %inner.ph, label %exit  ) ----> @foo(  %inner.cond  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %inner.cond, label %inner.body, label %outer.latch  ) ----> @foo(  %arrayidxD  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %inner.cond, label %inner.body, label %outer.latch  ) ----> @foo(  %loadD  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %inner.cond, label %inner.body, label %outer.latch  ) ----> @foo(  %mulC  )  [CTRL]
; CHECK-DAG: @foo(  %outer.cond.ldist  ) ----> @foo(  br i1 %outer.cond.ldist, label %inner.ph.ldist, label %entry.split  )  [RAW (must)]
; CHECK-DAG: @foo(  br i1 %inner.cond, label %inner.body, label %outer.latch  ) ----> @foo(  %arrayidxC  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %inner.cond, label %inner.body, label %outer.latch  ) ----> @foo(  %j.next  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %outer.cond, label %inner.ph, label %exit  ) ----> @foo(  %arrayidxA  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %outer.cond, label %inner.ph, label %exit  ) ----> @foo(  %arrayidxB  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %outer.cond, label %inner.ph, label %exit  ) ----> @foo(  %add  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %outer.cond, label %inner.ph, label %exit  ) ----> @foo(  %i.next  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %outer.cond, label %inner.ph, label %exit  ) ----> @foo(  br label %outer.header  )  [CTRL]
; CHECK-DAG: @foo(  %i.next.ldist  ) ----> @foo(  %i.ldist  )  [RAW (must)]
; CHECK-DAG: @foo(  br i1 %outer.cond.ldist, label %inner.ph.ldist, label %entry.split  ) ----> @foo(  %i.ldist  )  [CTRL]
; CHECK-DAG: @foo(  %i.ldist  ) ----> @foo(  %i.next.ldist  )  [RAW (must)]
; CHECK-DAG: @foo(  %i.ldist  ) ----> @foo(  %add.ldist  )  [RAW (must)]
; CHECK-DAG: @foo(  %i.ldist  ) ----> @foo(  %arrayidxB.ldist  )  [RAW (must)]
; CHECK-DAG: @foo(  %i.ldist  ) ----> @foo(  %arrayidxA.ldist  )  [RAW (must)]
; CHECK-DAG: @foo(  %i.ldist  ) ----> @foo(  %outer.cond.ldist  )  [RAW (must)]
; CHECK-DAG: @foo :: %n ----> @foo(  %outer.cond.ldist  )  [RAW (must)]
; CHECK-DAG: @foo(  br i1 %outer.cond.ldist, label %inner.ph.ldist, label %entry.split  ) ----> @foo(  %outer.cond.ldist  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %outer.cond.ldist, label %inner.ph.ldist, label %entry.split  ) ----> @foo(  br i1 %outer.cond.ldist, label %inner.ph.ldist, label %entry.split  )  [CTRL]

; CHECK-DAG: @foo(  br i1 %outer.cond.ldist, label %inner.ph.ldist, label %entry.split  ) ----> @foo(  br label %inner.header.ldist  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %outer.cond.ldist, label %inner.ph.ldist, label %entry.split  ) ----> @foo(  %j.ldist  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %outer.cond.ldist, label %inner.ph.ldist, label %entry.split  ) ----> @foo(  br i1 %inner.cond.ldist, label %inner.body.ldist, label %outer.latch.ldist  )  [CTRL]

; CHECK-DAG: @foo(  br i1 %outer.cond.ldist, label %inner.ph.ldist, label %entry.split  ) ----> @foo(  %arrayidxA.ldist  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %outer.cond.ldist, label %inner.ph.ldist, label %entry.split  ) ----> @foo(  %loadA.ldist  )  [CTRL]
; CHECK-DAG: @foo(  %loadA.ldist  ) ----> @foo(  %mulA.ldist  )  [RAW (must)]
; CHECK-DAG: @foo(  br i1 %outer.cond.ldist, label %inner.ph.ldist, label %entry.split  ) ----> @foo(  %loadB.ldist  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %outer.cond.ldist, label %inner.ph.ldist, label %entry.split  ) ----> @foo(  %mulA.ldist  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %outer.cond.ldist, label %inner.ph.ldist, label %entry.split  ) ----> @foo(  %add.ldist  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %outer.cond.ldist, label %inner.ph.ldist, label %entry.split  ) ----> @foo(  %arrayidxA_plus_1.ldist  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %outer.cond.ldist, label %inner.ph.ldist, label %entry.split  ) ----> @foo(  store %arrayidxA_plus_1.ldist  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %outer.cond.ldist, label %inner.ph.ldist, label %entry.split  ) ----> @foo(  %i.next.ldist  )  [CTRL]
; CHECK-DAG: @foo(  %j.next.ldist  ) ----> @foo(  %j.ldist  )  [RAW (must)]
; CHECK-DAG: @foo(  br i1 %inner.cond.ldist, label %inner.body.ldist, label %outer.latch.ldist  ) ----> @foo(  %j.ldist  )  [CTRL]
; CHECK-DAG: @foo(  %j.ldist  ) ----> @foo(  %j.next.ldist  )  [RAW (must)]
; CHECK-DAG: @foo(  %j.ldist  ) ----> @foo(  %inner.cond.ldist  )  [RAW (must)]
; CHECK-DAG: @foo(  br i1 %inner.cond.ldist, label %inner.body.ldist, label %outer.latch.ldist  ) ----> @foo(  %inner.cond.ldist  )  [CTRL]
; CHECK-DAG: @foo :: %m ----> @foo(  %inner.cond.ldist  )  [RAW (must)]
; CHECK-DAG: @foo(  %inner.cond.ldist  ) ----> @foo(  br i1 %inner.cond.ldist, label %inner.body.ldist, label %outer.latch.ldist  )  [RAW (must)]
; CHECK-DAG: @foo(  br i1 %inner.cond.ldist, label %inner.body.ldist, label %outer.latch.ldist  ) ----> @foo(  br i1 %inner.cond.ldist, label %inner.body.ldist, label %outer.latch.ldist  )  [CTRL]

; CHECK-DAG: @foo(  br i1 %inner.cond.ldist, label %inner.body.ldist, label %outer.latch.ldist  ) ----> @foo(  %j.next.ldist  )  [CTRL]
; CHECK-DAG: @foo(  br i1 %inner.cond.ldist, label %inner.body.ldist, label %outer.latch.ldist  ) ----> @foo(  br label %inner.header.ldist  )  [CTRL]
; CHECK-DAG: @foo :: %A ----> @foo(  %arrayidxA.ldist  )  [RAW (must)]
; CHECK-DAG: @foo(  store %arrayidxA_plus_1.ldist  ) ----> @foo(  %loadA.ldist  )  [RAW (must) from memory ]
; CHECK-DAG: @foo :: %B ----> @foo(  %arrayidxB.ldist  )  [RAW (must)]
; CHECK-DAG: @foo(  %arrayidxB.ldist  ) ----> @foo(  %loadB.ldist  )  [RAW (must)]
; CHECK-DAG: @foo(  %loadB.ldist  ) ----> @foo(  %mulA.ldist  )  [RAW (must)]
; CHECK-DAG: @foo(  %mulA.ldist  ) ----> @foo(  store %arrayidxA_plus_1.ldist  )  [RAW (must)]
; CHECK-DAG: @foo(  %add.ldist  ) ----> @foo(  %arrayidxA_plus_1.ldist  )  [RAW (must)]
; CHECK-DAG: @foo :: %A ----> @foo(  %arrayidxA_plus_1.ldist  )  [RAW (must)]
; CHECK-DAG: @foo(  %arrayidxA_plus_1.ldist  ) ----> @foo(  store %arrayidxA_plus_1.ldist  )  [RAW (must)]
; CHECK-NOT: {{.*}} ---->

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