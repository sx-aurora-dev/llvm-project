; RUN: opt -passes=indvars < %s | opt -passes='loop-simplify,print<loop-dependence>' -disable-output 2>&1 | FileCheck %s

; void test(int64_t x, int64_t y, int64_t z, int64_t A[x][y][z]) {
;   for (int64_t k = 0; k < x - 2; ++k)
;     for (int64_t i = 1; i < y; ++i)
;       for (int64_t j = 0; j < z; ++j)
;         A[k+2][i-1][0] = A[k][i][0];
; }

; CHECK: Loop: for.body: Is vectorizable with VF: 2
; CHECK: Loop: for.body3: Is vectorizable for any factor
; CHECK: Loop: for.body6: Is vectorizable for any factor

; Explanation: We want to check that we're squashing
; the first dimension (the j-loop) and so, we're
; falling back to 2-dimensional loop check.

define void @test(i64 %x, i64 %y, i64 %z, i64* %A) {
entry:
  %sub = sub nsw i64 %x, 2
  %cmp6 = icmp slt i64 0, %sub
  br i1 %cmp6, label %for.body, label %for.end18

for.body:                                         ; preds = %entry, %for.inc16
  %k.07 = phi i64 [ %inc17, %for.inc16 ], [ 0, %entry ]
  %cmp23 = icmp slt i64 1, %y
  br i1 %cmp23, label %for.body3, label %for.inc16

for.body3:                                        ; preds = %for.body, %for.inc13
  %i.04 = phi i64 [ %inc14, %for.inc13 ], [ 1, %for.body ]
  %cmp51 = icmp slt i64 0, %z
  br i1 %cmp51, label %for.body6, label %for.inc13

for.body6:                                        ; preds = %for.body3, %for.body6
  %j.02 = phi i64 [ %inc, %for.body6 ], [ 0, %for.body3 ]
  %0 = mul nuw i64 %y, %z
  %1 = mul nsw i64 %k.07, %0
  %arrayidx = getelementptr inbounds i64, i64* %A, i64 %1
  %2 = mul nsw i64 %i.04, %z
  %arrayidx7 = getelementptr inbounds i64, i64* %arrayidx, i64 %2
  %arrayidx8 = getelementptr inbounds i64, i64* %arrayidx7, i64 0
  %3 = load i64, i64* %arrayidx8, align 8
  %add = add nsw i64 %k.07, 2
  %4 = mul nuw i64 %y, %z
  %5 = mul nsw i64 %add, %4
  %arrayidx9 = getelementptr inbounds i64, i64* %A, i64 %5
  %sub10 = sub nsw i64 %i.04, 1
  %6 = mul nsw i64 %sub10, %z
  %arrayidx11 = getelementptr inbounds i64, i64* %arrayidx9, i64 %6
  %arrayidx12 = getelementptr inbounds i64, i64* %arrayidx11, i64 0
  store i64 %3, i64* %arrayidx12, align 8
  %inc = add nsw i64 %j.02, 1
  %cmp5 = icmp slt i64 %inc, %z
  br i1 %cmp5, label %for.body6, label %for.inc13

for.inc13:                                        ; preds = %for.body3, %for.body6
  %inc14 = add nsw i64 %i.04, 1
  %cmp2 = icmp slt i64 %inc14, %y
  br i1 %cmp2, label %for.body3, label %for.inc16

for.inc16:                                        ; preds = %for.body, %for.inc13
  %inc17 = add nsw i64 %k.07, 1
  %cmp = icmp slt i64 %inc17, %sub
  br i1 %cmp, label %for.body, label %for.end18

for.end18:                                        ; preds = %for.inc16, %entry
  ret void
}
