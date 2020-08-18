; RUN: opt -passes='print<loop-dependence>' -disable-output  < %s 2>&1 | FileCheck %s

; void test(int64_t x, int64_t y, int64_t z, int64_t w, int A[w][z][y][x]) {
;   for (int64_t l = 0; l < w; ++l) {
;     for (int64_t k = 0; k < z; ++k) {
;       for (int64_t i = 0; i < y; ++i) {
;         for (int64_t j = 0; j < x; ++j) {
;           A[k+1][l-2][j+2][i] = A[k][l][j][i];
;         }
;       }
;     }
;   }
; }

; CHECK: for.body: Is vectorizable with VF: 2
; CHECK: for.body3: Is vectorizable for any factor
; CHECK: for.body6: Is vectorizable for any factor
; CHECK: for.body9: Is vectorizable for any factor

define void @test(i64 %x, i64 %y, i64 %z, i64 %w, i32* %A) {
entry:
  %cmp7 = icmp sgt i64 %w, 0
  br i1 %cmp7, label %for.body, label %for.end26

for.body:                                         ; preds = %entry, %for.inc24
  %l.08 = phi i64 [ %inc25, %for.inc24 ], [ 0, %entry ]
  %cmp25 = icmp sgt i64 %z, 0
  br i1 %cmp25, label %for.body3, label %for.inc24

for.body3:                                        ; preds = %for.body, %for.inc21
  %k.06 = phi i64 [ %inc22, %for.inc21 ], [ 0, %for.body ]
  %cmp53 = icmp sgt i64 %y, 0
  br i1 %cmp53, label %for.body6, label %for.inc21

for.body6:                                        ; preds = %for.body3, %for.inc18
  %i.04 = phi i64 [ %inc19, %for.inc18 ], [ 0, %for.body3 ]
  %cmp81 = icmp sgt i64 %x, 0
  br i1 %cmp81, label %for.body9, label %for.inc18

for.body9:                                        ; preds = %for.body6, %for.body9
  %j.02 = phi i64 [ %inc, %for.body9 ], [ 0, %for.body6 ]
  %0 = mul nuw i64 %z, %y
  %1 = mul nuw i64 %0, %x
  %2 = mul nsw i64 %k.06, %1
  %arrayidx = getelementptr inbounds i32, i32* %A, i64 %i.04
  %3 = mul nuw i64 %y, %x
  %4 = mul nsw i64 %l.08, %3
  %arrayidx10 = getelementptr inbounds i32, i32* %arrayidx, i64 %2
  %5 = mul nsw i64 %j.02, %x
  %arrayidx11 = getelementptr inbounds i32, i32* %arrayidx10, i64 %4
  %arrayidx12 = getelementptr inbounds i32, i32* %arrayidx11, i64 %5
  %6 = load i32, i32* %arrayidx12, align 4
  %add = add nuw nsw i64 %k.06, 1
  %7 = mul nuw i64 %z, %y
  %8 = mul nuw i64 %7, %x
  %9 = mul nsw i64 %add, %8
  %arrayidx13 = getelementptr inbounds i32, i32* %A, i64 %i.04
  %sub = add nsw i64 %l.08, -2
  %10 = mul nuw i64 %y, %x
  %11 = mul nsw i64 %sub, %10
  %arrayidx14 = getelementptr inbounds i32, i32* %arrayidx13, i64 %9
  %add15 = add nuw nsw i64 %j.02, 2
  %12 = mul nsw i64 %add15, %x
  %arrayidx16 = getelementptr inbounds i32, i32* %arrayidx14, i64 %11
  %arrayidx17 = getelementptr inbounds i32, i32* %arrayidx16, i64 %12
  store i32 %6, i32* %arrayidx17, align 4
  %inc = add nuw nsw i64 %j.02, 1
  %cmp8 = icmp slt i64 %inc, %x
  br i1 %cmp8, label %for.body9, label %for.inc18

for.inc18:                                        ; preds = %for.body6, %for.body9
  %inc19 = add nuw nsw i64 %i.04, 1
  %cmp5 = icmp slt i64 %inc19, %y
  br i1 %cmp5, label %for.body6, label %for.inc21

for.inc21:                                        ; preds = %for.body3, %for.inc18
  %inc22 = add nuw nsw i64 %k.06, 1
  %cmp2 = icmp slt i64 %inc22, %z
  br i1 %cmp2, label %for.body3, label %for.inc24

for.inc24:                                        ; preds = %for.body, %for.inc21
  %inc25 = add nuw nsw i64 %l.08, 1
  %cmp = icmp slt i64 %inc25, %w
  br i1 %cmp, label %for.body, label %for.end26

for.end26:                                        ; preds = %for.inc24, %entry
  ret void
}
