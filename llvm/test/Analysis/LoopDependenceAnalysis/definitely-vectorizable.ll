; RUN: opt -indvars < %s 2>&1 | opt -passes='loop-simplify,print<loop-dependence>' -disable-output 2>&1 | FileCheck %s

; void test(int64_t x, int64_t y, int64_t z, int64_t A[x][y][z]) {
;   for (int64_t i = 0; i < x; ++i) {
;     for (int64_t j = 0; j < y; ++j) {
;         A[i+1][j-1][0] = A[i][j][1];
;     }
;   }
; }

; CHECK: Loop: for.body: Is vectorizable for any factor
; CHECK: Loop: for.body3: Is vectorizable for any factor

; Explanation: Notice that the final index is a constant 1 in
; the one access and a constant 0 in the other. Thus (assuming
; that the indexes are within bounds), those never alias.

; Currently FAILING because of bounds checking. We don't know if
; z >= 2.

define void @test(i64 %x, i64 %y, i64 %z, i64* %A) {
entry:
  %sub = sub nsw i64 %x, 1
  %cmp3 = icmp slt i64 0, %sub
  br i1 %cmp3, label %for.body, label %for.end12

for.body:                                         ; preds = %entry, %for.inc10
  %i.04 = phi i64 [ %inc11, %for.inc10 ], [ 0, %entry ]
  %cmp21 = icmp slt i64 1, %y
  br i1 %cmp21, label %for.body3, label %for.inc10

for.body3:                                        ; preds = %for.body, %for.body3
  %j.02 = phi i64 [ %inc, %for.body3 ], [ 1, %for.body ]
  %0 = mul nuw i64 %y, %z
  %1 = mul nsw i64 %i.04, %0
  %arrayidx = getelementptr inbounds i64, i64* %A, i64 %1
  %2 = mul nsw i64 %j.02, %z
  %arrayidx4 = getelementptr inbounds i64, i64* %arrayidx, i64 %2
  %arrayidx5 = getelementptr inbounds i64, i64* %arrayidx4, i64 1
  %3 = load i64, i64* %arrayidx5, align 8
  %add = add nsw i64 %i.04, 1
  %4 = mul nuw i64 %y, %z
  %5 = mul nsw i64 %add, %4
  %arrayidx6 = getelementptr inbounds i64, i64* %A, i64 %5
  %sub7 = sub nsw i64 %j.02, 1
  %6 = mul nsw i64 %sub7, %z
  %arrayidx8 = getelementptr inbounds i64, i64* %arrayidx6, i64 %6
  %arrayidx9 = getelementptr inbounds i64, i64* %arrayidx8, i64 0
  store i64 %3, i64* %arrayidx9, align 8
  %inc = add nsw i64 %j.02, 1
  %cmp2 = icmp slt i64 %inc, %y
  br i1 %cmp2, label %for.body3, label %for.inc10

for.inc10:                                        ; preds = %for.body, %for.body3
  %inc11 = add nsw i64 %i.04, 1
  %cmp = icmp slt i64 %inc11, %sub
  br i1 %cmp, label %for.body, label %for.end12

for.end12:                                        ; preds = %for.inc10, %entry
  ret void
}