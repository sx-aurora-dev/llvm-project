; RUN: opt -passes=indvars < %s | opt -passes='loop-simplify,print<loop-dependence>' -disable-output 2>&1 | FileCheck %s

; extern int A[30][10];
;
; void test() {
;   for (int i = 0; i < 29; ++i) {
;     for (int j = 0; j < 8; ++j) {
;       A[i][j] = A[i+1][j+2];
;     }
;   }
; }

; CHECK: Loop: for.body: Is vectorizable for any factor
; CHECK: Loop: for.body3: Is vectorizable for any factor

@A = external dso_local global [30 x [10 x i32]], align 16

define void @test() {
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.inc11
  %i.02 = phi i32 [ 0, %entry ], [ %inc12, %for.inc11 ]
  br label %for.body3

for.body3:                                        ; preds = %for.body, %for.body3
  %j.01 = phi i32 [ 0, %for.body ], [ %inc, %for.body3 ]
  %add = add nsw i32 %i.02, 1
  %idxprom = sext i32 %add to i64
  %arrayidx = getelementptr inbounds [30 x [10 x i32]], [30 x [10 x i32]]* @A, i64 0, i64 %idxprom
  %add4 = add nsw i32 %j.01, 2
  %idxprom5 = sext i32 %add4 to i64
  %arrayidx6 = getelementptr inbounds [10 x i32], [10 x i32]* %arrayidx, i64 0, i64 %idxprom5
  %0 = load i32, i32* %arrayidx6, align 4
  %idxprom7 = sext i32 %i.02 to i64
  %arrayidx8 = getelementptr inbounds [30 x [10 x i32]], [30 x [10 x i32]]* @A, i64 0, i64 %idxprom7
  %idxprom9 = sext i32 %j.01 to i64
  %arrayidx10 = getelementptr inbounds [10 x i32], [10 x i32]* %arrayidx8, i64 0, i64 %idxprom9
  store i32 %0, i32* %arrayidx10, align 4
  %inc = add nsw i32 %j.01, 1
  %cmp2 = icmp slt i32 %inc, 8
  br i1 %cmp2, label %for.body3, label %for.inc11

for.inc11:                                        ; preds = %for.body3
  %inc12 = add nsw i32 %i.02, 1
  %cmp = icmp slt i32 %inc12, 29
  br i1 %cmp, label %for.body, label %for.end13

for.end13:                                        ; preds = %for.inc11
  ret void
}
