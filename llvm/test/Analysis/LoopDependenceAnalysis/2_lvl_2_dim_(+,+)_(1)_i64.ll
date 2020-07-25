; RUN: opt -passes='require<loop-dependence>' -disable-output  < %s 2>&1 | FileCheck %s

; void test(int64_t n, int64_t m, int64_t A[n][m]) {
;     for (int64_t i = 0; i < n; ++i) {
;         for (int64_t j = 0; j < m; ++j) {
;             A[i+1][j+1] = A[i][j];
;         }
;     }
; }

; CHECK: Loop: for.body: Is vectorizable for any factor

; Explanation: While the outer distance is 1, the inner distance is also 1
; but more importantly, it is positive. In other words, the direction
; vector is (<, <). So, we can vectorize for any factor

define void @test(i64 %n, i64 %m, i64* %A) {
entry:
  %cmp3 = icmp sgt i64 %n, 0
  br i1 %cmp3, label %for.body, label %for.end10

for.body:                                         ; preds = %entry, %for.inc8
  %i.04 = phi i64 [ %inc9, %for.inc8 ], [ 0, %entry ]
  %cmp21 = icmp sgt i64 %m, 0
  br i1 %cmp21, label %for.body3, label %for.inc8

for.body3:                                        ; preds = %for.body, %for.body3
  %j.02 = phi i64 [ %inc, %for.body3 ], [ 0, %for.body ]
  %0 = mul nsw i64 %i.04, %m
  %arrayidx = getelementptr inbounds i64, i64* %A, i64 %0
  %arrayidx4 = getelementptr inbounds i64, i64* %arrayidx, i64 %j.02
  %1 = load i64, i64* %arrayidx4, align 8
  %add = add nuw nsw i64 %i.04, 1
  %2 = mul nsw i64 %add, %m
  %arrayidx5 = getelementptr inbounds i64, i64* %A, i64 %2
  %add6 = add nuw nsw i64 %j.02, 1
  %arrayidx7 = getelementptr inbounds i64, i64* %arrayidx5, i64 %add6
  store i64 %1, i64* %arrayidx7, align 8
  %inc = add nuw nsw i64 %j.02, 1
  %cmp2 = icmp slt i64 %inc, %m
  br i1 %cmp2, label %for.body3, label %for.inc8

for.inc8:                                         ; preds = %for.body, %for.body3
  %inc9 = add nuw nsw i64 %i.04, 1
  %cmp = icmp slt i64 %inc9, %n
  br i1 %cmp, label %for.body, label %for.end10

for.end10:                                        ; preds = %for.inc8, %entry
  ret void
}