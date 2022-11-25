; RUN: opt -indvars < %s | opt -passes='loop-simplify,print<loop-dependence>' -disable-output 2>&1 | FileCheck %s

; void test(int64_t x, int64_t y, int64_t z, int A[z][y][x]) {
;   for (int64_t k = 0; k < z - 2; ++k) {
;     for (int64_t i = 1; i < y; ++i) {
;       for (int64_t j = 0; j < x; ++j) {
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
  %sub = sub nsw i64 %z, 2
  %cmp6 = icmp slt i64 0, %sub
  br i1 %cmp6, label %for.body, label %for.end18

for.body:                                         ; preds = %entry, %for.inc16
  %k.07 = phi i64 [ %inc17, %for.inc16 ], [ 0, %entry ]
  %cmp23 = icmp slt i64 1, %y
  br i1 %cmp23, label %for.body3, label %for.inc16

for.body3:                                        ; preds = %for.body, %for.inc13
  %i.04 = phi i64 [ %inc14, %for.inc13 ], [ 1, %for.body ]
  %cmp51 = icmp slt i64 0, %x
  br i1 %cmp51, label %for.body6, label %for.inc13

for.body6:                                        ; preds = %for.body3, %for.body6
  %j.02 = phi i64 [ %inc, %for.body6 ], [ 0, %for.body3 ]
  %0 = mul nuw i64 %y, %x
  %1 = mul nsw i64 %k.07, %0
  %arrayidx = getelementptr inbounds i32, i32* %A, i64 %1
  %2 = mul nsw i64 %i.04, %x
  %arrayidx7 = getelementptr inbounds i32, i32* %arrayidx, i64 %2
  %arrayidx8 = getelementptr inbounds i32, i32* %arrayidx7, i64 %j.02
  %3 = load i32, i32* %arrayidx8, align 4
  %add = add nsw i64 %k.07, 2
  %4 = mul nuw i64 %y, %x
  %5 = mul nsw i64 %add, %4
  %arrayidx9 = getelementptr inbounds i32, i32* %A, i64 %5
  %sub10 = sub nsw i64 %i.04, 1
  %6 = mul nsw i64 %sub10, %x
  %arrayidx11 = getelementptr inbounds i32, i32* %arrayidx9, i64 %6
  %arrayidx12 = getelementptr inbounds i32, i32* %arrayidx11, i64 %j.02
  store i32 %3, i32* %arrayidx12, align 4
  %inc = add nsw i64 %j.02, 1
  %cmp5 = icmp slt i64 %inc, %x
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
