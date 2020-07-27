; RUN: opt -passes='require<loop-dependence>' -disable-output  < %s 2>&1 | FileCheck %s

; void test(int64_t x, int64_t y, int64_t z, int64_t A[x][y][z]) {
;   for (int64_t k = 0; k < x; ++k) {
;       for (int64_t i = 0; i < y; ++i) {
;           for (int64_t j = 0; j < z; ++j) {
;               A[k][i+2][j] = A[k][i][j];
;           }
;       }
;       for (int64_t i = 0; i < y; ++i) {
;           for (int64_t j = 0; j < z; ++j) {
;               A[k][i+2][j] = A[k][i][j];
;           }
;       }
;   }
; }

; CHECK: Loop: for.body: Is NOT vectorizable
; CHECK: Loop: for.body3: Is vectorizable with VF: 2
; CHECK: Loop: for.body18: Is vectorizable with VF: 2

; Explanation: The two i-loops can be vectorized,
; although they are in an imperfect loop nest. This
; is because the "imperfectness" is not inside them.

define void @test(i64 %x, i64 %y, i64 %z, i64* %A) {
entry:
  %cmp9 = icmp sgt i64 %x, 0
  br i1 %cmp9, label %for.body, label %for.end38

for.body:                                         ; preds = %entry, %for.inc36
  %k.010 = phi i64 [ %inc37, %for.inc36 ], [ 0, %entry ]
  %cmp23 = icmp sgt i64 %y, 0
  br i1 %cmp23, label %for.body3, label %for.end14

for.body3:                                        ; preds = %for.body, %for.inc12
  %i.04 = phi i64 [ %inc13, %for.inc12 ], [ 0, %for.body ]
  %cmp51 = icmp sgt i64 %z, 0
  br i1 %cmp51, label %for.body6, label %for.inc12

for.body6:                                        ; preds = %for.body3, %for.body6
  %j.02 = phi i64 [ %inc, %for.body6 ], [ 0, %for.body3 ]
  %0 = mul nuw i64 %y, %z
  %1 = mul nsw i64 %k.010, %0
  %arrayidx = getelementptr inbounds i64, i64* %A, i64 %1
  %2 = mul nsw i64 %i.04, %z
  %arrayidx7 = getelementptr inbounds i64, i64* %arrayidx, i64 %2
  %arrayidx8 = getelementptr inbounds i64, i64* %arrayidx7, i64 %j.02
  %3 = load i64, i64* %arrayidx8, align 8
  %4 = mul nuw i64 %y, %z
  %5 = mul nsw i64 %k.010, %4
  %arrayidx9 = getelementptr inbounds i64, i64* %A, i64 %5
  %add = add nuw nsw i64 %i.04, 2
  %6 = mul nsw i64 %add, %z
  %arrayidx10 = getelementptr inbounds i64, i64* %arrayidx9, i64 %6
  %arrayidx11 = getelementptr inbounds i64, i64* %arrayidx10, i64 %j.02
  store i64 %3, i64* %arrayidx11, align 8
  %inc = add nuw nsw i64 %j.02, 1
  %cmp5 = icmp slt i64 %inc, %z
  br i1 %cmp5, label %for.body6, label %for.inc12

for.inc12:                                        ; preds = %for.body3, %for.body6
  %inc13 = add nuw nsw i64 %i.04, 1
  %cmp2 = icmp slt i64 %inc13, %y
  br i1 %cmp2, label %for.body3, label %for.end14

for.end14:                                        ; preds = %for.inc12, %for.body
  %cmp177 = icmp sgt i64 %y, 0
  br i1 %cmp177, label %for.body18, label %for.inc36

for.body18:                                       ; preds = %for.end14, %for.inc33
  %i15.08 = phi i64 [ %inc34, %for.inc33 ], [ 0, %for.end14 ]
  %cmp215 = icmp sgt i64 %z, 0
  br i1 %cmp215, label %for.body22, label %for.inc33

for.body22:                                       ; preds = %for.body18, %for.body22
  %j19.06 = phi i64 [ %inc31, %for.body22 ], [ 0, %for.body18 ]
  %7 = mul nuw i64 %y, %z
  %8 = mul nsw i64 %k.010, %7
  %arrayidx23 = getelementptr inbounds i64, i64* %A, i64 %8
  %9 = mul nsw i64 %i15.08, %z
  %arrayidx24 = getelementptr inbounds i64, i64* %arrayidx23, i64 %9
  %arrayidx25 = getelementptr inbounds i64, i64* %arrayidx24, i64 %j19.06
  %10 = load i64, i64* %arrayidx25, align 8
  %11 = mul nuw i64 %y, %z
  %12 = mul nsw i64 %k.010, %11
  %arrayidx26 = getelementptr inbounds i64, i64* %A, i64 %12
  %add27 = add nuw nsw i64 %i15.08, 2
  %13 = mul nsw i64 %add27, %z
  %arrayidx28 = getelementptr inbounds i64, i64* %arrayidx26, i64 %13
  %arrayidx29 = getelementptr inbounds i64, i64* %arrayidx28, i64 %j19.06
  store i64 %10, i64* %arrayidx29, align 8
  %inc31 = add nuw nsw i64 %j19.06, 1
  %cmp21 = icmp slt i64 %inc31, %z
  br i1 %cmp21, label %for.body22, label %for.inc33

for.inc33:                                        ; preds = %for.body18, %for.body22
  %inc34 = add nuw nsw i64 %i15.08, 1
  %cmp17 = icmp slt i64 %inc34, %y
  br i1 %cmp17, label %for.body18, label %for.inc36

for.inc36:                                        ; preds = %for.end14, %for.inc33
  %inc37 = add nuw nsw i64 %k.010, 1
  %cmp = icmp slt i64 %inc37, %x
  br i1 %cmp, label %for.body, label %for.end38

for.end38:                                        ; preds = %for.inc36, %entry
  ret void
}
