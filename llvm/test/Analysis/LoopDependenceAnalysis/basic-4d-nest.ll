; RUN: opt -indvars < %s | opt -passes='loop-simplify,print<loop-dependence>' -disable-output 2>&1 | FileCheck %s

; void test(int64_t x, int64_t y, int64_t z, int64_t w, int A[w][z][y][x]) {
;   for (int64_t l = 2; l < z; ++l)
;     for (int64_t k = 0; k < w - 1; ++k)
;       for (int64_t i = 0; i < x; ++i)
;         for (int64_t j = 0; j < y - 2; ++j)
;           A[k+1][l-2][j+2][i] = A[k][l][j][i];
; }

; CHECK: for.body: Is vectorizable with VF: 2
; CHECK: for.body3: Is vectorizable for any factor
; CHECK: for.body6: Is vectorizable for any factor
; CHECK: for.body10: Is vectorizable for any factor

define void @test(i64 %x, i64 %y, i64 %z, i64 %w, i32* %A) {
entry:
  %cmp7 = icmp slt i64 2, %z
  br i1 %cmp7, label %for.body, label %for.end28

for.body:                                         ; preds = %entry, %for.inc26
  %l.08 = phi i64 [ %inc27, %for.inc26 ], [ 2, %entry ]
  %sub = sub nsw i64 %w, 1
  %cmp25 = icmp slt i64 0, %sub
  br i1 %cmp25, label %for.body3, label %for.inc26

for.body3:                                        ; preds = %for.body, %for.inc23
  %k.06 = phi i64 [ %inc24, %for.inc23 ], [ 0, %for.body ]
  %cmp53 = icmp slt i64 0, %x
  br i1 %cmp53, label %for.body6, label %for.inc23

for.body6:                                        ; preds = %for.body3, %for.inc20
  %i.04 = phi i64 [ %inc21, %for.inc20 ], [ 0, %for.body3 ]
  %sub8 = sub nsw i64 %y, 2
  %cmp91 = icmp slt i64 0, %sub8
  br i1 %cmp91, label %for.body10, label %for.inc20

for.body10:                                       ; preds = %for.body6, %for.body10
  %j.02 = phi i64 [ %inc, %for.body10 ], [ 0, %for.body6 ]
  %0 = mul nuw i64 %z, %y
  %1 = mul nuw i64 %0, %x
  %2 = mul nsw i64 %k.06, %1
  %arrayidx = getelementptr inbounds i32, i32* %A, i64 %2
  %3 = mul nuw i64 %y, %x
  %4 = mul nsw i64 %l.08, %3
  %arrayidx11 = getelementptr inbounds i32, i32* %arrayidx, i64 %4
  %5 = mul nsw i64 %j.02, %x
  %arrayidx12 = getelementptr inbounds i32, i32* %arrayidx11, i64 %5
  %arrayidx13 = getelementptr inbounds i32, i32* %arrayidx12, i64 %i.04
  %6 = load i32, i32* %arrayidx13, align 4
  %add = add nsw i64 %k.06, 1
  %7 = mul nuw i64 %z, %y
  %8 = mul nuw i64 %7, %x
  %9 = mul nsw i64 %add, %8
  %arrayidx14 = getelementptr inbounds i32, i32* %A, i64 %9
  %sub15 = sub nsw i64 %l.08, 2
  %10 = mul nuw i64 %y, %x
  %11 = mul nsw i64 %sub15, %10
  %arrayidx16 = getelementptr inbounds i32, i32* %arrayidx14, i64 %11
  %add17 = add nsw i64 %j.02, 2
  %12 = mul nsw i64 %add17, %x
  %arrayidx18 = getelementptr inbounds i32, i32* %arrayidx16, i64 %12
  %arrayidx19 = getelementptr inbounds i32, i32* %arrayidx18, i64 %i.04
  store i32 %6, i32* %arrayidx19, align 4
  %inc = add nsw i64 %j.02, 1
  %cmp9 = icmp slt i64 %inc, %sub8
  br i1 %cmp9, label %for.body10, label %for.inc20

for.inc20:                                        ; preds = %for.body6, %for.body10
  %inc21 = add nsw i64 %i.04, 1
  %cmp5 = icmp slt i64 %inc21, %x
  br i1 %cmp5, label %for.body6, label %for.inc23

for.inc23:                                        ; preds = %for.body3, %for.inc20
  %inc24 = add nsw i64 %k.06, 1
  %cmp2 = icmp slt i64 %inc24, %sub
  br i1 %cmp2, label %for.body3, label %for.inc26

for.inc26:                                        ; preds = %for.body, %for.inc23
  %inc27 = add nsw i64 %l.08, 1
  %cmp = icmp slt i64 %inc27, %z
  br i1 %cmp, label %for.body, label %for.end28

for.end28:                                        ; preds = %for.inc26, %entry
  ret void
}
