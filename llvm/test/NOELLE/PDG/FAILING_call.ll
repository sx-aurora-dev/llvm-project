; RUN: opt -aa-pipeline=basic-aa "-passes=print<pdg>" -S < %s 2>&1 | FileCheck %s

; There shouldn't be edges from the call to bar because it is `argmemonly` and `readonly`
; It should be pretty obvious that it neither reads or writes

; CHECK-NOT: @foo(  call @bar()  ) ---->

define void @foo(i64* %a, i64* %b, i64 %n) {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.body, %entry
  %i.0 = phi i64 [ 0, %entry ], [ %inc, %for.body ]
  %cmp = icmp slt i64 %i.0, %n
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %arrayidx = getelementptr inbounds i64, i64* %a, i64 %i.0
  %0 = load i64, i64* %arrayidx, align 8
  %mul = mul nsw i64 2, %0
  %arrayidx1 = getelementptr inbounds i64, i64* %b, i64 %i.0
  store i64 %mul, i64* %arrayidx1, align 8
  %arrayidx2 = getelementptr inbounds i64, i64* %b, i64 %i.0
  %1 = load i64, i64* %arrayidx2, align 8
  call void @bar(i64 %1)
  %inc = add nsw i64 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}

define void @bar(i64) argmemonly readonly {
  ret void
}