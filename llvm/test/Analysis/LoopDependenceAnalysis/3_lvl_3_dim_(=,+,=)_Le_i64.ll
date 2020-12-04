; RUN: opt -indvars < %s 2>&1 | opt -passes='loop-simplify,print<loop-dependence>' -disable-output 2>&1 | FileCheck %s

; void test(int64_t x, int64_t y, int64_t z, int64_t A[x][y][z]) {
;   for (int64_t k = 0; k < x; ++k)
;     for (int64_t i = 0; i < y - 2; ++i)
;       for (int64_t j = 0; j < z; ++j)
;         A[k][i+2][j] = A[k][i][j];
; }

; CHECK: Loop: for.body3: Is vectorizable with VF: 2
; CHECK: Loop: for.body6: Is vectorizable for any factor

; Explanation: Eventually, we want to be able to vectorize
; the outermost loop (k-loop i.e. for.body), but for now, we want
; to make sure that we can vectorize the middle-loop
; (i-loop i.e. for.body3) although it is in a 3-level
; loop-nest and the accesses are 3-dimensional.

; Function Attrs: noinline nounwind uwtable
define dso_local void @test(i64 %x, i64 %y, i64 %z, i64* %A) #0 {
entry:
  %cmp6 = icmp slt i64 0, %x
  br i1 %cmp6, label %for.body, label %for.end17

for.body:                                         ; preds = %entry, %for.inc15
  %k.07 = phi i64 [ %inc16, %for.inc15 ], [ 0, %entry ]
  %sub = sub nsw i64 %y, 2
  %cmp23 = icmp slt i64 0, %sub
  br i1 %cmp23, label %for.body3, label %for.inc15

for.body3:                                        ; preds = %for.body, %for.inc12
  %i.04 = phi i64 [ %inc13, %for.inc12 ], [ 0, %for.body ]
  %cmp51 = icmp slt i64 0, %z
  br i1 %cmp51, label %for.body6, label %for.inc12

for.body6:                                        ; preds = %for.body3, %for.body6
  %j.02 = phi i64 [ %inc, %for.body6 ], [ 0, %for.body3 ]
  %0 = mul nuw i64 %y, %z
  %1 = mul nsw i64 %k.07, %0
  %arrayidx = getelementptr inbounds i64, i64* %A, i64 %1
  %2 = mul nsw i64 %i.04, %z
  %arrayidx7 = getelementptr inbounds i64, i64* %arrayidx, i64 %2
  %arrayidx8 = getelementptr inbounds i64, i64* %arrayidx7, i64 %j.02
  %3 = load i64, i64* %arrayidx8, align 8
  %4 = mul nuw i64 %y, %z
  %5 = mul nsw i64 %k.07, %4
  %arrayidx9 = getelementptr inbounds i64, i64* %A, i64 %5
  %add = add nsw i64 %i.04, 2
  %6 = mul nsw i64 %add, %z
  %arrayidx10 = getelementptr inbounds i64, i64* %arrayidx9, i64 %6
  %arrayidx11 = getelementptr inbounds i64, i64* %arrayidx10, i64 %j.02
  store i64 %3, i64* %arrayidx11, align 8
  %inc = add nsw i64 %j.02, 1
  %cmp5 = icmp slt i64 %inc, %z
  br i1 %cmp5, label %for.body6, label %for.inc12

for.inc12:                                        ; preds = %for.body3, %for.body6
  %inc13 = add nsw i64 %i.04, 1
  %cmp2 = icmp slt i64 %inc13, %sub
  br i1 %cmp2, label %for.body3, label %for.inc15

for.inc15:                                        ; preds = %for.body, %for.inc12
  %inc16 = add nsw i64 %k.07, 1
  %cmp = icmp slt i64 %inc16, %x
  br i1 %cmp, label %for.body, label %for.end17

for.end17:                                        ; preds = %for.inc15, %entry
  ret void
}