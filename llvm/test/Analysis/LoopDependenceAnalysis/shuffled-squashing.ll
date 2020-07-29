; RUN: opt -passes='require<loop-dependence>' -disable-output  < %s 2>&1 | FileCheck %s

; void test(int64_t x, int64_t y, int64_t z, int64_t A[x][y][z]) {
;   for (int64_t k = 0; k < x; ++k) {
;       for (int64_t i = 0; i < y; ++i) {
;           for (int64_t j = 0; j < z; ++j) {
;               A[j-1][k+3][0] = A[j][k][0];
;           }
;       }
;   }
; }

; CHECK: Loop: for.body: Is vectorizable with VF: 3

; Explanation: We check that squashing and shuffling
; work together. See separate test cases for each
; of these.

define void @test(i64 %x, i64 %y, i64 %z, i64* %A) {
entry:
  %cmp6 = icmp sgt i64 %x, 0
  br i1 %cmp6, label %for.body, label %for.end17

for.body:                                         ; preds = %entry, %for.inc15
  %k.07 = phi i64 [ %inc16, %for.inc15 ], [ 0, %entry ]
  %cmp23 = icmp sgt i64 %y, 0
  br i1 %cmp23, label %for.body3, label %for.inc15

for.body3:                                        ; preds = %for.body, %for.inc12
  %i.04 = phi i64 [ %inc13, %for.inc12 ], [ 0, %for.body ]
  %cmp51 = icmp sgt i64 %z, 0
  br i1 %cmp51, label %for.body6, label %for.inc12

for.body6:                                        ; preds = %for.body3, %for.body6
  %j.02 = phi i64 [ %inc, %for.body6 ], [ 0, %for.body3 ]
  %0 = mul nuw i64 %y, %z
  %1 = mul nsw i64 %j.02, %0
  %arrayidx = getelementptr inbounds i64, i64* %A, i64 %1
  %2 = mul nsw i64 %k.07, %z
  %arrayidx7 = getelementptr inbounds i64, i64* %arrayidx, i64 %2
  %3 = load i64, i64* %arrayidx7, align 8
  %sub = add nsw i64 %j.02, -1
  %4 = mul nuw i64 %y, %z
  %5 = mul nsw i64 %sub, %4
  %arrayidx9 = getelementptr inbounds i64, i64* %A, i64 %5
  %add = add nuw nsw i64 %k.07, 3
  %6 = mul nsw i64 %add, %z
  %arrayidx10 = getelementptr inbounds i64, i64* %arrayidx9, i64 %6
  store i64 %3, i64* %arrayidx10, align 8
  %inc = add nuw nsw i64 %j.02, 1
  %cmp5 = icmp slt i64 %inc, %z
  br i1 %cmp5, label %for.body6, label %for.inc12

for.inc12:                                        ; preds = %for.body3, %for.body6
  %inc13 = add nuw nsw i64 %i.04, 1
  %cmp2 = icmp slt i64 %inc13, %y
  br i1 %cmp2, label %for.body3, label %for.inc15

for.inc15:                                        ; preds = %for.body, %for.inc12
  %inc16 = add nuw nsw i64 %k.07, 1
  %cmp = icmp slt i64 %inc16, %x
  br i1 %cmp, label %for.body, label %for.end17

for.end17:                                        ; preds = %for.inc15, %entry
  ret void
}