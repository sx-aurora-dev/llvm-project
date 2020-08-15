; RUN: opt -passes='print<loop-dependence>' -disable-output  < %s 2>&1 | FileCheck %s

; void test(int64_t x, int64_t y, int64_t z, int A[z][y][x]) {
;   for (int64_t k = 0; k < z; ++k) {
;     for (int64_t i = 0; i < y; ++i) {
;       for (int64_t j = 0; j < z; ++j) {
;         A[k+2][i-1][j] = A[k][i][j];
;       }
;     }
;   }
; }

; CHECK: Loop: for.body: Is vectorizable with VF: 2

; Explanation: The vector has a positive 'z' dimension
; (the outermost dimension which is the _first_ entry).
; It is limited by that because vectorizing the z-axis
; means that in any x-y plane, we're going to "grab"
; iterations from a next plane (how far next is
; the z distance). So, no matter how the other two
; directions make the vector look, it's limited
; by the z distance.

define void @test(i64 %x, i64 %y, i64 %z, i32* %A) {
entry:
  %cmp6 = icmp sgt i64 %z, 0
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
  %0 = mul nuw i64 %y, %x
  %1 = mul nsw i64 %k.07, %0
  %arrayidx = getelementptr inbounds i32, i32* %A, i64 %1
  %2 = mul nsw i64 %i.04, %x
  %arrayidx7 = getelementptr inbounds i32, i32* %arrayidx, i64 %2
  %arrayidx8 = getelementptr inbounds i32, i32* %arrayidx7, i64 %j.02
  %3 = load i32, i32* %arrayidx8, align 4
  %add = add nuw nsw i64 %k.07, 2
  %4 = mul nuw i64 %y, %x
  %5 = mul nsw i64 %add, %4
  %arrayidx9 = getelementptr inbounds i32, i32* %A, i64 %5
  %sub = add nsw i64 %i.04, -1
  %6 = mul nsw i64 %sub, %x
  %arrayidx10 = getelementptr inbounds i32, i32* %arrayidx9, i64 %6
  %arrayidx11 = getelementptr inbounds i32, i32* %arrayidx10, i64 %j.02
  store i32 %3, i32* %arrayidx11, align 4
  %inc = add nuw nsw i64 %j.02, 1
  %cmp5 = icmp slt i64 %inc, %z
  br i1 %cmp5, label %for.body6, label %for.inc12

for.inc12:                                        ; preds = %for.body3, %for.body6
  %inc13 = add nuw nsw i64 %i.04, 1
  %cmp2 = icmp slt i64 %inc13, %y
  br i1 %cmp2, label %for.body3, label %for.inc15

for.inc15:                                        ; preds = %for.body, %for.inc12
  %inc16 = add nuw nsw i64 %k.07, 1
  %cmp = icmp slt i64 %inc16, %z
  br i1 %cmp, label %for.body, label %for.end17

for.end17:                                        ; preds = %for.inc15, %entry
  ret void
}