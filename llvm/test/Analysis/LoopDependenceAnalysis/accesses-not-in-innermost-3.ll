; RUN: opt -passes=indvars < %s | opt -passes='loop-simplify,print<loop-dependence>' -disable-output 2>&1 | FileCheck %s

; void test(int64_t x, int64_t y, int64_t A[x][y]) {
;   for (int64_t k = 0; k < y; ++k) {
;     for (int64_t i = 0; i < x - 2; ++i) {
;       int64_t v = A[i][k];
;       int64_t sum = v;
;       for (int64_t j = 0; j < y; ++j)
;         sum += 1;
;       A[i+2][k] = sum;
;     }
;   }
; }

; CHECK: Loop: for.body: Is vectorizable for any factor
; CHECK: Loop: for.body3: Is vectorizable with VF: 2
; CHECK: Loop: for.body7: Is vectorizable for any factor

define void @test(i64 %x, i64 %y, i64* %A) {
entry:
  %cmp7 = icmp slt i64 0, %y
  br i1 %cmp7, label %for.body, label %for.end16

for.body:                                         ; preds = %entry, %for.inc14
  %k.08 = phi i64 [ %inc15, %for.inc14 ], [ 0, %entry ]
  %sub = sub nsw i64 %x, 2
  %cmp24 = icmp slt i64 0, %sub
  br i1 %cmp24, label %for.body3, label %for.inc14

for.body3:                                        ; preds = %for.body, %for.end
  %i.05 = phi i64 [ %inc12, %for.end ], [ 0, %for.body ]
  %0 = mul nsw i64 %i.05, %y
  %arrayidx = getelementptr inbounds i64, i64* %A, i64 %0
  %arrayidx4 = getelementptr inbounds i64, i64* %arrayidx, i64 %k.08
  %1 = load i64, i64* %arrayidx4, align 8
  %cmp61 = icmp slt i64 0, %y
  br i1 %cmp61, label %for.body7, label %for.end

for.body7:                                        ; preds = %for.body3, %for.body7
  %j.03 = phi i64 [ %inc, %for.body7 ], [ 0, %for.body3 ]
  %sum.02 = phi i64 [ %add, %for.body7 ], [ %1, %for.body3 ]
  %add = add nsw i64 %sum.02, 1
  %inc = add nsw i64 %j.03, 1
  %cmp6 = icmp slt i64 %inc, %y
  br i1 %cmp6, label %for.body7, label %for.end

for.end:                                          ; preds = %for.body7, %for.body3
  %sum.0.lcssa = phi i64 [ %1, %for.body3 ], [ %add, %for.body7 ]
  %add8 = add nsw i64 %i.05, 2
  %2 = mul nsw i64 %add8, %y
  %arrayidx9 = getelementptr inbounds i64, i64* %A, i64 %2
  %arrayidx10 = getelementptr inbounds i64, i64* %arrayidx9, i64 %k.08
  store i64 %sum.0.lcssa, i64* %arrayidx10, align 8
  %inc12 = add nsw i64 %i.05, 1
  %cmp2 = icmp slt i64 %inc12, %sub
  br i1 %cmp2, label %for.body3, label %for.inc14

for.inc14:                                        ; preds = %for.body, %for.end
  %inc15 = add nsw i64 %k.08, 1
  %cmp = icmp slt i64 %inc15, %y
  br i1 %cmp, label %for.body, label %for.end16

for.end16:                                        ; preds = %for.inc14, %entry
  ret void
}
