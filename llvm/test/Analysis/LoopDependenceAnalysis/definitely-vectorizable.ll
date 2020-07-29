; RUN: opt -passes='require<loop-dependence>' -disable-output  < %s 2>&1 | FileCheck %s

; void test(int64_t x, int64_t y, int64_t z, int64_t A[x][y][z]) {
;   for (int64_t i = 0; i < x; ++i) {
;     for (int64_t j = 0; j < y; ++j) {
;         A[i+1][j-1][0] = A[i][j][1];
;     }
;   }
; }

; CHECK: Loop: for.body: Is vectorizable for any factor

; Explanation: Notice that the final index is a constant 1 in
; the one access and a constant 0 in the other. Thus (assuming
; that the indexes are within bounds), those never alias.

define dso_local void @test(i64 %x, i64 %y, i64 %z, i64* %A) #0 {
entry:
  %cmp3 = icmp sgt i64 %x, 0
  br i1 %cmp3, label %for.body, label %for.end11

for.body:                                         ; preds = %entry, %for.inc9
  %i.04 = phi i64 [ %inc10, %for.inc9 ], [ 0, %entry ]
  %cmp21 = icmp sgt i64 %y, 0
  br i1 %cmp21, label %for.body3, label %for.inc9

for.body3:                                        ; preds = %for.body, %for.body3
  %j.02 = phi i64 [ %inc, %for.body3 ], [ 0, %for.body ]
  %0 = mul nuw i64 %y, %z
  %1 = mul nsw i64 %i.04, %0
  %arrayidx = getelementptr inbounds i64, i64* %A, i64 1
  %2 = mul nsw i64 %j.02, %z
  %arrayidx4 = getelementptr inbounds i64, i64* %arrayidx, i64 %1
  %arrayidx5 = getelementptr inbounds i64, i64* %arrayidx4, i64 %2
  %3 = load i64, i64* %arrayidx5, align 8
  %add = add nuw nsw i64 %i.04, 1
  %4 = mul nuw i64 %y, %z
  %5 = mul nsw i64 %add, %4
  %arrayidx6 = getelementptr inbounds i64, i64* %A, i64 %5
  %sub = add nsw i64 %j.02, -1
  %6 = mul nsw i64 %sub, %z
  %arrayidx7 = getelementptr inbounds i64, i64* %arrayidx6, i64 %6
  store i64 %3, i64* %arrayidx7, align 8
  %inc = add nuw nsw i64 %j.02, 1
  %cmp2 = icmp slt i64 %inc, %y
  br i1 %cmp2, label %for.body3, label %for.inc9

for.inc9:                                         ; preds = %for.body, %for.body3
  %inc10 = add nuw nsw i64 %i.04, 1
  %cmp = icmp slt i64 %inc10, %x
  br i1 %cmp, label %for.body, label %for.end11

for.end11:                                        ; preds = %for.inc9, %entry
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 2}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"clang version 11.0.0 (https://github.com/baziotis/llvm-project 238170455f4df61278d2dc971f3873738e25282e)"}
