; RUN: opt -passes='require<loop-dependence>' -disable-output  < %s 2>&1 | FileCheck %s

; void test(int64_t x, int64_t y, int64_t A[x][y]) {
;     for (int64_t i = 0; i < x; ++i) {
;         for (int64_t j = 0; j < y; ++j) {
;             A[i][j] = A[i+2][j];
;         }
;     }
; }

; CHECK: Loop: for.body: Is vectorizable with VF: 2

; Explanation: We want to check that we can handle
; (soundly) anti-dependences. Notice here that we
; read from a cell that will be written in a later
; iteration. Still, the read has to happen before the
; write, which effectively _reflects_ the dependence
; vector about the origin and it's like we had
; a statement like: A[i+1][j] = A[i][j]. Which we
; can vectorize with max VF = 2.

define void @test(i64 %x, i64 %y, i64* %A) {
entry:
  %cmp3 = icmp sgt i64 %x, 0
  br i1 %cmp3, label %for.body, label %for.end9

for.body:                                         ; preds = %entry, %for.inc7
  %i.04 = phi i64 [ %inc8, %for.inc7 ], [ 0, %entry ]
  %cmp21 = icmp sgt i64 %y, 0
  br i1 %cmp21, label %for.body3, label %for.inc7

for.body3:                                        ; preds = %for.body, %for.body3
  %j.02 = phi i64 [ %inc, %for.body3 ], [ 0, %for.body ]
  %add = add nuw nsw i64 %i.04, 2
  %0 = mul nsw i64 %add, %y
  %arrayidx = getelementptr inbounds i64, i64* %A, i64 %0
  %arrayidx4 = getelementptr inbounds i64, i64* %arrayidx, i64 %j.02
  %1 = load i64, i64* %arrayidx4, align 8
  %2 = mul nsw i64 %i.04, %y
  %arrayidx5 = getelementptr inbounds i64, i64* %A, i64 %2
  %arrayidx6 = getelementptr inbounds i64, i64* %arrayidx5, i64 %j.02
  store i64 %1, i64* %arrayidx6, align 8
  %inc = add nuw nsw i64 %j.02, 1
  %cmp2 = icmp slt i64 %inc, %y
  br i1 %cmp2, label %for.body3, label %for.inc7

for.inc7:                                         ; preds = %for.body, %for.body3
  %inc8 = add nuw nsw i64 %i.04, 1
  %cmp = icmp slt i64 %inc8, %x
  br i1 %cmp, label %for.body, label %for.end9

for.end9:                                         ; preds = %for.inc7, %entry
  ret void
}
