; RUN: opt -passes=indvars < %s | opt -passes='loop-simplify,print<loop-dependence>' -disable-output 2>&1 | FileCheck %s

; void test(int64_t n, int64_t m, int64_t A[n][m]) {
;   for (int64_t i = 0; i < n - 2; ++i) {
;     for (int64_t j = 1; j < m; ++j)
;       A[i+2][j-1] = A[i][j];
;     for (int64_t j = 1; j < m; ++j)
;       A[i+2][j-1] = A[i][j];
;   }
; }

; CHECK: Loop: for.body: Is vectorizable with VF: 2
; CHECK: Loop: for.body3: Is vectorizable for any factor
; CHECK: Loop: for.body11: Is vectorizable for any factor

define void @test(i64 %n, i64 %m, i64* %A) {
entry:
  %sub = sub nsw i64 %n, 2
  %cmp5 = icmp slt i64 0, %sub
  br i1 %cmp5, label %for.body, label %for.end23

for.body:                                         ; preds = %entry, %for.inc21
  %i.06 = phi i64 [ %inc22, %for.inc21 ], [ 0, %entry ]
  %cmp21 = icmp slt i64 1, %m
  br i1 %cmp21, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.body, %for.body3
  %j.02 = phi i64 [ %inc, %for.body3 ], [ 1, %for.body ]
  %0 = mul nsw i64 %i.06, %m
  %arrayidx = getelementptr inbounds i64, i64* %A, i64 %0
  %arrayidx4 = getelementptr inbounds i64, i64* %arrayidx, i64 %j.02
  %1 = load i64, i64* %arrayidx4, align 8
  %add = add nsw i64 %i.06, 2
  %2 = mul nsw i64 %add, %m
  %arrayidx5 = getelementptr inbounds i64, i64* %A, i64 %2
  %sub6 = sub nsw i64 %j.02, 1
  %arrayidx7 = getelementptr inbounds i64, i64* %arrayidx5, i64 %sub6
  store i64 %1, i64* %arrayidx7, align 8
  %inc = add nsw i64 %j.02, 1
  %cmp2 = icmp slt i64 %inc, %m
  br i1 %cmp2, label %for.body3, label %for.end

for.end:                                          ; preds = %for.body3, %for.body
  %cmp103 = icmp slt i64 1, %m
  br i1 %cmp103, label %for.body11, label %for.inc21

for.body11:                                       ; preds = %for.end, %for.body11
  %j8.04 = phi i64 [ %inc19, %for.body11 ], [ 1, %for.end ]
  %3 = mul nsw i64 %i.06, %m
  %arrayidx12 = getelementptr inbounds i64, i64* %A, i64 %3
  %arrayidx13 = getelementptr inbounds i64, i64* %arrayidx12, i64 %j8.04
  %4 = load i64, i64* %arrayidx13, align 8
  %add14 = add nsw i64 %i.06, 2
  %5 = mul nsw i64 %add14, %m
  %arrayidx15 = getelementptr inbounds i64, i64* %A, i64 %5
  %sub16 = sub nsw i64 %j8.04, 1
  %arrayidx17 = getelementptr inbounds i64, i64* %arrayidx15, i64 %sub16
  store i64 %4, i64* %arrayidx17, align 8
  %inc19 = add nsw i64 %j8.04, 1
  %cmp10 = icmp slt i64 %inc19, %m
  br i1 %cmp10, label %for.body11, label %for.inc21

for.inc21:                                        ; preds = %for.end, %for.body11
  %inc22 = add nsw i64 %i.06, 1
  %cmp = icmp slt i64 %inc22, %sub
  br i1 %cmp, label %for.body, label %for.end23

for.end23:                                        ; preds = %for.inc21, %entry
  ret void
}
