; RUN: opt -indvars < %s 2>&1 | opt -passes='loop-simplify,print<loop-dependence>' -disable-output 2>&1 | FileCheck %s

; void test(int64_t n, int64_t m, int64_t A[n][m]) {
;   for (int64_t i = 0; i < n - 1; ++i) {
;     for (int64_t j = 1; j < m; ++j) {
;       A[i+1][j-1] = A[i][j];
;     }
;   }
; }

; CHECK: Loop: for.body: Is NOT vectorizable
; CHECK: Loop: for.body3: Is vectorizable for any factor

; Explanation: We have direction vector (<, >) with outer distance
; being 1, so we can't vectorize.

define void @test(i64 %n, i64 %m, i64* %A) {
entry:
  %sub = sub nsw i64 %n, 1
  %cmp3 = icmp slt i64 0, %sub
  br i1 %cmp3, label %for.body, label %for.end10

for.body:                                         ; preds = %entry, %for.inc8
  %i.04 = phi i64 [ %inc9, %for.inc8 ], [ 0, %entry ]
  %cmp21 = icmp slt i64 1, %m
  br i1 %cmp21, label %for.body3, label %for.inc8

for.body3:                                        ; preds = %for.body, %for.body3
  %j.02 = phi i64 [ %inc, %for.body3 ], [ 1, %for.body ]
  %0 = mul nsw i64 %i.04, %m
  %arrayidx = getelementptr inbounds i64, i64* %A, i64 %0
  %arrayidx4 = getelementptr inbounds i64, i64* %arrayidx, i64 %j.02
  %1 = load i64, i64* %arrayidx4, align 8
  %add = add nsw i64 %i.04, 1
  %2 = mul nsw i64 %add, %m
  %arrayidx5 = getelementptr inbounds i64, i64* %A, i64 %2
  %sub6 = sub nsw i64 %j.02, 1
  %arrayidx7 = getelementptr inbounds i64, i64* %arrayidx5, i64 %sub6
  store i64 %1, i64* %arrayidx7, align 8
  %inc = add nsw i64 %j.02, 1
  %cmp2 = icmp slt i64 %inc, %m
  br i1 %cmp2, label %for.body3, label %for.inc8

for.inc8:                                         ; preds = %for.body, %for.body3
  %inc9 = add nsw i64 %i.04, 1
  %cmp = icmp slt i64 %inc9, %sub
  br i1 %cmp, label %for.body, label %for.end10

for.end10:                                        ; preds = %for.inc8, %entry
  ret void
}