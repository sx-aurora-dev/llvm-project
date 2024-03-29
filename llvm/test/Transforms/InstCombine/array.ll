; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 3
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

define void @test(ptr %ptr, i32 %a, i32 %b) {
; CHECK-LABEL: define void @test(
; CHECK-SAME: ptr [[PTR:%.*]], i32 [[A:%.*]], i32 [[B:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = sext i32 [[A]] to i64
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr i32, ptr [[PTR]], i64 [[TMP0]]
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr i8, ptr [[TMP1]], i64 40
; CHECK-NEXT:    store i32 [[B]], ptr [[GEP]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %add = add nsw i32 %a, 10
  %idx = sext i32 %add to i64
  %gep = getelementptr inbounds i32, ptr %ptr, i64 %idx
  store i32 %b, ptr %gep
  ret void
}

define  i32 @test_add_res_moreoneuse(ptr %ptr, i32 %a, i32 %b) {
; CHECK-LABEL: define i32 @test_add_res_moreoneuse(
; CHECK-SAME: ptr [[PTR:%.*]], i32 [[A:%.*]], i32 [[B:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[A]], 5
; CHECK-NEXT:    [[IDX:%.*]] = sext i32 [[ADD]] to i64
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds i32, ptr [[PTR]], i64 [[IDX]]
; CHECK-NEXT:    store i32 [[B]], ptr [[GEP]], align 4
; CHECK-NEXT:    ret i32 [[ADD]]
;
entry:
  %add = add nsw i32 %a, 5
  %idx = sext i32 %add to i64
  %gep = getelementptr inbounds i32, ptr %ptr, i64 %idx
  store i32 %b, ptr %gep
  ret i32 %add
}

define void @test_addop_nonsw_flag(ptr %ptr, i32 %a, i32 %b) {
; CHECK-LABEL: define void @test_addop_nonsw_flag(
; CHECK-SAME: ptr [[PTR:%.*]], i32 [[A:%.*]], i32 [[B:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[A]], 10
; CHECK-NEXT:    [[IDX:%.*]] = sext i32 [[ADD]] to i64
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds i32, ptr [[PTR]], i64 [[IDX]]
; CHECK-NEXT:    store i32 [[B]], ptr [[GEP]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %add = add i32 %a, 10
  %idx = sext i32 %add to i64
  %gep = getelementptr inbounds i32, ptr %ptr, i64 %idx
  store i32 %b, ptr %gep
  ret void
}

define void @test_add_op2_not_constant(ptr %ptr, i32 %a, i32 %b) {
; CHECK-LABEL: define void @test_add_op2_not_constant(
; CHECK-SAME: ptr [[PTR:%.*]], i32 [[A:%.*]], i32 [[B:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[A]], [[B]]
; CHECK-NEXT:    [[IDX:%.*]] = sext i32 [[ADD]] to i64
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds i32, ptr [[PTR]], i64 [[IDX]]
; CHECK-NEXT:    store i32 [[B]], ptr [[GEP]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %add = add i32 %a, %b
  %idx = sext i32 %add to i64
  %gep = getelementptr inbounds i32, ptr %ptr, i64 %idx
  store i32 %b, ptr %gep
  ret void
}

define void @test_zext_nneg(ptr %ptr, i32 %a, i32 %b) {
; CHECK-LABEL: define void @test_zext_nneg(
; CHECK-SAME: ptr [[PTR:%.*]], i32 [[A:%.*]], i32 [[B:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = sext i32 [[A]] to i64
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr i32, ptr [[PTR]], i64 [[TMP0]]
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr i8, ptr [[TMP1]], i64 40
; CHECK-NEXT:    store i32 [[B]], ptr [[GEP]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %add = add nsw i32 %a, 10
  %idx = zext nneg i32 %add to i64
  %gep = getelementptr inbounds i32, ptr %ptr, i64 %idx
  store i32 %b, ptr %gep
  ret void
}

define void @test_zext_missing_nneg(ptr %ptr, i32 %a, i32 %b) {
; CHECK-LABEL: define void @test_zext_missing_nneg(
; CHECK-SAME: ptr [[PTR:%.*]], i32 [[A:%.*]], i32 [[B:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[A]], 10
; CHECK-NEXT:    [[IDX:%.*]] = zext i32 [[ADD]] to i64
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds i32, ptr [[PTR]], i64 [[IDX]]
; CHECK-NEXT:    store i32 [[B]], ptr [[GEP]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %add = add nsw i32 %a, 10
  %idx = zext i32 %add to i64
  %gep = getelementptr inbounds i32, ptr %ptr, i64 %idx
  store i32 %b, ptr %gep
  ret void
}
