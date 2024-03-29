; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; REQUIRES: aarch64-registered-target
; RUN: opt -passes='lower-matrix-intrinsics' -mtriple=arm64-apple-iphoneos -S < %s | FileCheck %s

define <1 x i32> @dotproduct_i32_v8(<8 x i32> %a, <8 x i32> %b) {
; CHECK-LABEL: @dotproduct_i32_v8(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = mul <8 x i32> [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> [[TMP0]])
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <1 x i32> poison, i32 [[TMP1]], i64 0
; CHECK-NEXT:    ret <1 x i32> [[TMP2]]
;
entry:
  %c = tail call <1 x i32> @llvm.matrix.multiply.v1i32.v8i32.v8i32(<8 x i32> %a, <8 x i32> %b, i32 1, i32 8, i32 1)
  ret <1 x i32> %c
}

declare <1 x i32> @llvm.matrix.multiply.v1i32.v8i32.v8i32(<8 x i32>, <8 x i32>, i32, i32, i32)

declare void @use(<1 x i32>)

define <1 x i32> @dotproduct_i32_v8_result_used_by_inst(<8 x i32> %a, <8 x i32> %b) {
; CHECK-LABEL: @dotproduct_i32_v8_result_used_by_inst(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = mul <8 x i32> [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> [[TMP0]])
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <1 x i32> poison, i32 [[TMP1]], i64 0
; CHECK-NEXT:    call void @use(<1 x i32> [[TMP2]])
; CHECK-NEXT:    ret <1 x i32> [[TMP2]]
;
entry:
  %c = tail call <1 x i32> @llvm.matrix.multiply.v1i32.v8i32.v8i32(<8 x i32> %a, <8 x i32> %b, i32 1, i32 8, i32 1)
  call void @use(<1 x i32> %c)
  ret <1 x i32> %c
}


define <1 x i32> @dotproduct_i32_v8_constvector(<8 x i32> %a) {
; CHECK-LABEL: @dotproduct_i32_v8_constvector(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = mul <8 x i32> [[A:%.*]], <i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8>
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> [[TMP0]])
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <1 x i32> poison, i32 [[TMP1]], i64 0
; CHECK-NEXT:    ret <1 x i32> [[TMP2]]
;
entry:
  %c = tail call <1 x i32> @llvm.matrix.multiply.v1i32.v8i32.v8i32(<8 x i32> %a, <8 x i32> <i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8>, i32 1, i32 8, i32 1)
  ret <1 x i32> %c
}

define <1 x i32> @add_feeding_dotproduct_i32_v8_1(<8 x i32> %a, <8 x i32> %b, <8 x i32> %c) {
; CHECK-LABEL: @add_feeding_dotproduct_i32_v8_1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SPLIT:%.*]] = shufflevector <8 x i32> [[A:%.*]], <8 x i32> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    [[SPLIT1:%.*]] = shufflevector <8 x i32> [[B:%.*]], <8 x i32> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    [[TMP0:%.*]] = add <8 x i32> [[SPLIT]], [[SPLIT1]]
; CHECK-NEXT:    [[TMP1:%.*]] = mul <8 x i32> [[TMP0]], [[C:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> [[TMP1]])
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <1 x i32> poison, i32 [[TMP2]], i64 0
; CHECK-NEXT:    ret <1 x i32> [[TMP3]]
;
entry:
  %add = add <8 x i32> %a, %b
  %res = tail call <1 x i32> @llvm.matrix.multiply.v1i32.v8i32.v8i32(<8 x i32> %add, <8 x i32> %c, i32 1, i32 8, i32 1)
  ret <1 x i32> %res
}

define <1 x i32> @add_feeding_dotproduct_i32_v8_2(<8 x i32> %a, <8 x i32> %b, <8 x i32> %c) {
; CHECK-LABEL: @add_feeding_dotproduct_i32_v8_2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SPLIT:%.*]] = shufflevector <8 x i32> [[A:%.*]], <8 x i32> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    [[SPLIT1:%.*]] = shufflevector <8 x i32> [[B:%.*]], <8 x i32> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    [[TMP0:%.*]] = add <8 x i32> [[SPLIT]], [[SPLIT1]]
; CHECK-NEXT:    [[TMP1:%.*]] = mul <8 x i32> [[C:%.*]], [[TMP0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> [[TMP1]])
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <1 x i32> poison, i32 [[TMP2]], i64 0
; CHECK-NEXT:    ret <1 x i32> [[TMP3]]
;
entry:
  %add = add <8 x i32> %a, %b
  %res = tail call <1 x i32> @llvm.matrix.multiply.v1i32.v8i32.v8i32(<8 x i32> %c, <8 x i32> %add, i32 1, i32 8, i32 1)
  ret <1 x i32> %res
}

define <1 x i32> @sub_feeding_dotproduct_i32_v8_1(<8 x i32> %a, <8 x i32> %b, <8 x i32> %c) {
; CHECK-LABEL: @sub_feeding_dotproduct_i32_v8_1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SPLIT:%.*]] = shufflevector <8 x i32> [[A:%.*]], <8 x i32> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    [[SPLIT1:%.*]] = shufflevector <8 x i32> [[B:%.*]], <8 x i32> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    [[TMP0:%.*]] = sub <8 x i32> [[SPLIT]], [[SPLIT1]]
; CHECK-NEXT:    [[TMP1:%.*]] = mul <8 x i32> [[TMP0]], [[C:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> [[TMP1]])
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <1 x i32> poison, i32 [[TMP2]], i64 0
; CHECK-NEXT:    ret <1 x i32> [[TMP3]]
;
entry:
  %sub = sub <8 x i32> %a, %b
  %res = tail call <1 x i32> @llvm.matrix.multiply.v1i32.v8i32.v8i32(<8 x i32> %sub, <8 x i32> %c, i32 1, i32 8, i32 1)
  ret <1 x i32> %res
}

define <1 x i32> @sub_feeding_dotproduct_i32_v8_2(<8 x i32> %a, <8 x i32> %b, <8 x i32> %c) {
; CHECK-LABEL: @sub_feeding_dotproduct_i32_v8_2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SPLIT:%.*]] = shufflevector <8 x i32> [[A:%.*]], <8 x i32> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    [[SPLIT1:%.*]] = shufflevector <8 x i32> [[B:%.*]], <8 x i32> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    [[TMP0:%.*]] = sub <8 x i32> [[SPLIT]], [[SPLIT1]]
; CHECK-NEXT:    [[TMP1:%.*]] = mul <8 x i32> [[C:%.*]], [[TMP0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> [[TMP1]])
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <1 x i32> poison, i32 [[TMP2]], i64 0
; CHECK-NEXT:    ret <1 x i32> [[TMP3]]
;
entry:
  %sub = sub <8 x i32> %a, %b
  %res = tail call <1 x i32> @llvm.matrix.multiply.v1i32.v8i32.v8i32(<8 x i32> %c, <8 x i32> %sub, i32 1, i32 8, i32 1)
  ret <1 x i32> %res
}

define <1 x i32> @add_chain_feeding_dotproduct_i32_v8_1(<8 x i32> %a, <8 x i32> %b, <8 x i32> %c, <8 x i32> %d) {
; CHECK-LABEL: @add_chain_feeding_dotproduct_i32_v8_1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SPLIT:%.*]] = shufflevector <8 x i32> [[A:%.*]], <8 x i32> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    [[SPLIT1:%.*]] = shufflevector <8 x i32> [[B:%.*]], <8 x i32> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    [[TMP0:%.*]] = add <8 x i32> [[SPLIT]], [[SPLIT1]]
; CHECK-NEXT:    [[SPLIT2:%.*]] = shufflevector <8 x i32> [[C:%.*]], <8 x i32> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    [[TMP1:%.*]] = add <8 x i32> [[TMP0]], [[SPLIT2]]
; CHECK-NEXT:    [[TMP2:%.*]] = mul <8 x i32> [[TMP1]], [[D:%.*]]
; CHECK-NEXT:    [[TMP3:%.*]] = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> [[TMP2]])
; CHECK-NEXT:    [[TMP4:%.*]] = insertelement <1 x i32> poison, i32 [[TMP3]], i64 0
; CHECK-NEXT:    ret <1 x i32> [[TMP4]]
;
entry:
  %add.1 = add <8 x i32> %a, %b
  %add.2 = add <8 x i32> %add.1, %c
  %res = tail call <1 x i32> @llvm.matrix.multiply.v1i32.v8i32.v8i32(<8 x i32> %add.2, <8 x i32> %d, i32 1, i32 8, i32 1)
  ret <1 x i32> %res
}

define <1 x i32> @add_chain_feeding_dotproduct_i32_v8_2(<8 x i32> %a, <8 x i32> %b, <8 x i32> %c, <8 x i32> %d) {
; CHECK-LABEL: @add_chain_feeding_dotproduct_i32_v8_2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SPLIT:%.*]] = shufflevector <8 x i32> [[A:%.*]], <8 x i32> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    [[SPLIT1:%.*]] = shufflevector <8 x i32> [[B:%.*]], <8 x i32> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    [[TMP0:%.*]] = add <8 x i32> [[SPLIT]], [[SPLIT1]]
; CHECK-NEXT:    [[SPLIT2:%.*]] = shufflevector <8 x i32> [[C:%.*]], <8 x i32> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    [[TMP1:%.*]] = add <8 x i32> [[TMP0]], [[SPLIT2]]
; CHECK-NEXT:    [[TMP2:%.*]] = mul <8 x i32> [[D:%.*]], [[TMP1]]
; CHECK-NEXT:    [[TMP3:%.*]] = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> [[TMP2]])
; CHECK-NEXT:    [[TMP4:%.*]] = insertelement <1 x i32> poison, i32 [[TMP3]], i64 0
; CHECK-NEXT:    ret <1 x i32> [[TMP4]]
;
entry:
  %add.1 = add <8 x i32> %a, %b
  %add.2 = add <8 x i32> %add.1, %c
  %res = tail call <1 x i32> @llvm.matrix.multiply.v1i32.v8i32.v8i32(<8 x i32> %d, <8 x i32> %add.2, i32 1, i32 8, i32 1)
  ret <1 x i32> %res
}

define <1 x i64> @dotproduct_i64_v8(<8 x i64> %a, <8 x i64> %b) {
; CHECK-LABEL: @dotproduct_i64_v8(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SPLIT:%.*]] = shufflevector <8 x i64> [[A:%.*]], <8 x i64> poison, <1 x i32> zeroinitializer
; CHECK-NEXT:    [[SPLIT1:%.*]] = shufflevector <8 x i64> [[A]], <8 x i64> poison, <1 x i32> <i32 1>
; CHECK-NEXT:    [[SPLIT2:%.*]] = shufflevector <8 x i64> [[A]], <8 x i64> poison, <1 x i32> <i32 2>
; CHECK-NEXT:    [[SPLIT3:%.*]] = shufflevector <8 x i64> [[A]], <8 x i64> poison, <1 x i32> <i32 3>
; CHECK-NEXT:    [[SPLIT4:%.*]] = shufflevector <8 x i64> [[A]], <8 x i64> poison, <1 x i32> <i32 4>
; CHECK-NEXT:    [[SPLIT5:%.*]] = shufflevector <8 x i64> [[A]], <8 x i64> poison, <1 x i32> <i32 5>
; CHECK-NEXT:    [[SPLIT6:%.*]] = shufflevector <8 x i64> [[A]], <8 x i64> poison, <1 x i32> <i32 6>
; CHECK-NEXT:    [[SPLIT7:%.*]] = shufflevector <8 x i64> [[A]], <8 x i64> poison, <1 x i32> <i32 7>
; CHECK-NEXT:    [[SPLIT8:%.*]] = shufflevector <8 x i64> [[B:%.*]], <8 x i64> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    [[BLOCK:%.*]] = shufflevector <1 x i64> [[SPLIT]], <1 x i64> poison, <1 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP0:%.*]] = extractelement <8 x i64> [[SPLIT8]], i64 0
; CHECK-NEXT:    [[SPLAT_SPLATINSERT:%.*]] = insertelement <1 x i64> poison, i64 [[TMP0]], i64 0
; CHECK-NEXT:    [[SPLAT_SPLAT:%.*]] = shufflevector <1 x i64> [[SPLAT_SPLATINSERT]], <1 x i64> poison, <1 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP1:%.*]] = mul <1 x i64> [[BLOCK]], [[SPLAT_SPLAT]]
; CHECK-NEXT:    [[BLOCK9:%.*]] = shufflevector <1 x i64> [[SPLIT1]], <1 x i64> poison, <1 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP2:%.*]] = extractelement <8 x i64> [[SPLIT8]], i64 1
; CHECK-NEXT:    [[SPLAT_SPLATINSERT10:%.*]] = insertelement <1 x i64> poison, i64 [[TMP2]], i64 0
; CHECK-NEXT:    [[SPLAT_SPLAT11:%.*]] = shufflevector <1 x i64> [[SPLAT_SPLATINSERT10]], <1 x i64> poison, <1 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP3:%.*]] = mul <1 x i64> [[BLOCK9]], [[SPLAT_SPLAT11]]
; CHECK-NEXT:    [[TMP4:%.*]] = add <1 x i64> [[TMP1]], [[TMP3]]
; CHECK-NEXT:    [[BLOCK12:%.*]] = shufflevector <1 x i64> [[SPLIT2]], <1 x i64> poison, <1 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP5:%.*]] = extractelement <8 x i64> [[SPLIT8]], i64 2
; CHECK-NEXT:    [[SPLAT_SPLATINSERT13:%.*]] = insertelement <1 x i64> poison, i64 [[TMP5]], i64 0
; CHECK-NEXT:    [[SPLAT_SPLAT14:%.*]] = shufflevector <1 x i64> [[SPLAT_SPLATINSERT13]], <1 x i64> poison, <1 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP6:%.*]] = mul <1 x i64> [[BLOCK12]], [[SPLAT_SPLAT14]]
; CHECK-NEXT:    [[TMP7:%.*]] = add <1 x i64> [[TMP4]], [[TMP6]]
; CHECK-NEXT:    [[BLOCK15:%.*]] = shufflevector <1 x i64> [[SPLIT3]], <1 x i64> poison, <1 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP8:%.*]] = extractelement <8 x i64> [[SPLIT8]], i64 3
; CHECK-NEXT:    [[SPLAT_SPLATINSERT16:%.*]] = insertelement <1 x i64> poison, i64 [[TMP8]], i64 0
; CHECK-NEXT:    [[SPLAT_SPLAT17:%.*]] = shufflevector <1 x i64> [[SPLAT_SPLATINSERT16]], <1 x i64> poison, <1 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP9:%.*]] = mul <1 x i64> [[BLOCK15]], [[SPLAT_SPLAT17]]
; CHECK-NEXT:    [[TMP10:%.*]] = add <1 x i64> [[TMP7]], [[TMP9]]
; CHECK-NEXT:    [[BLOCK18:%.*]] = shufflevector <1 x i64> [[SPLIT4]], <1 x i64> poison, <1 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP11:%.*]] = extractelement <8 x i64> [[SPLIT8]], i64 4
; CHECK-NEXT:    [[SPLAT_SPLATINSERT19:%.*]] = insertelement <1 x i64> poison, i64 [[TMP11]], i64 0
; CHECK-NEXT:    [[SPLAT_SPLAT20:%.*]] = shufflevector <1 x i64> [[SPLAT_SPLATINSERT19]], <1 x i64> poison, <1 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP12:%.*]] = mul <1 x i64> [[BLOCK18]], [[SPLAT_SPLAT20]]
; CHECK-NEXT:    [[TMP13:%.*]] = add <1 x i64> [[TMP10]], [[TMP12]]
; CHECK-NEXT:    [[BLOCK21:%.*]] = shufflevector <1 x i64> [[SPLIT5]], <1 x i64> poison, <1 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP14:%.*]] = extractelement <8 x i64> [[SPLIT8]], i64 5
; CHECK-NEXT:    [[SPLAT_SPLATINSERT22:%.*]] = insertelement <1 x i64> poison, i64 [[TMP14]], i64 0
; CHECK-NEXT:    [[SPLAT_SPLAT23:%.*]] = shufflevector <1 x i64> [[SPLAT_SPLATINSERT22]], <1 x i64> poison, <1 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP15:%.*]] = mul <1 x i64> [[BLOCK21]], [[SPLAT_SPLAT23]]
; CHECK-NEXT:    [[TMP16:%.*]] = add <1 x i64> [[TMP13]], [[TMP15]]
; CHECK-NEXT:    [[BLOCK24:%.*]] = shufflevector <1 x i64> [[SPLIT6]], <1 x i64> poison, <1 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP17:%.*]] = extractelement <8 x i64> [[SPLIT8]], i64 6
; CHECK-NEXT:    [[SPLAT_SPLATINSERT25:%.*]] = insertelement <1 x i64> poison, i64 [[TMP17]], i64 0
; CHECK-NEXT:    [[SPLAT_SPLAT26:%.*]] = shufflevector <1 x i64> [[SPLAT_SPLATINSERT25]], <1 x i64> poison, <1 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP18:%.*]] = mul <1 x i64> [[BLOCK24]], [[SPLAT_SPLAT26]]
; CHECK-NEXT:    [[TMP19:%.*]] = add <1 x i64> [[TMP16]], [[TMP18]]
; CHECK-NEXT:    [[BLOCK27:%.*]] = shufflevector <1 x i64> [[SPLIT7]], <1 x i64> poison, <1 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP20:%.*]] = extractelement <8 x i64> [[SPLIT8]], i64 7
; CHECK-NEXT:    [[SPLAT_SPLATINSERT28:%.*]] = insertelement <1 x i64> poison, i64 [[TMP20]], i64 0
; CHECK-NEXT:    [[SPLAT_SPLAT29:%.*]] = shufflevector <1 x i64> [[SPLAT_SPLATINSERT28]], <1 x i64> poison, <1 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP21:%.*]] = mul <1 x i64> [[BLOCK27]], [[SPLAT_SPLAT29]]
; CHECK-NEXT:    [[TMP22:%.*]] = add <1 x i64> [[TMP19]], [[TMP21]]
; CHECK-NEXT:    [[TMP23:%.*]] = shufflevector <1 x i64> [[TMP22]], <1 x i64> poison, <1 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP24:%.*]] = shufflevector <1 x i64> poison, <1 x i64> [[TMP23]], <1 x i32> <i32 1>
; CHECK-NEXT:    ret <1 x i64> [[TMP24]]
;
entry:
  %c = tail call <1 x i64> @llvm.matrix.multiply.v1i64.v8i64.v8i64(<8 x i64> %a, <8 x i64> %b, i32 1, i32 8, i32 1)
  ret <1 x i64> %c
}

declare <1 x i64> @llvm.matrix.multiply.v1i64.v8i64.v8i64(<8 x i64>, <8 x i64>, i32, i32, i32)

define <1 x i32> @intrinsic_column_major_load_dot_product_i32_v8(ptr %lhs_address, ptr %rhs_address) {
; CHECK-LABEL: @intrinsic_column_major_load_dot_product_i32_v8(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[COL_LOAD:%.*]] = load <8 x i32>, ptr [[RHS_ADDRESS:%.*]], align 4
; CHECK-NEXT:    [[TMP0:%.*]] = load <8 x i32>, ptr [[LHS_ADDRESS:%.*]], align 32
; CHECK-NEXT:    [[TMP1:%.*]] = mul <8 x i32> [[TMP0]], [[COL_LOAD]]
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> [[TMP1]])
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <1 x i32> poison, i32 [[TMP2]], i64 0
; CHECK-NEXT:    ret <1 x i32> [[TMP3]]
;
entry:
  %lhs = tail call <8 x i32> @llvm.matrix.column.major.load.v8i32.i64(ptr nonnull align 4 %lhs_address, i64 1, i1 false, i32 1, i32 8)
  %rhs = tail call <8 x i32> @llvm.matrix.column.major.load.v8i32.i64(ptr nonnull align 4 %rhs_address, i64 8, i1 false, i32 8, i32 1)
  %result = tail call <1 x i32> @llvm.matrix.multiply.v1i32.v8i32.v8i32(<8 x i32> %lhs, <8 x i32> %rhs, i32 1, i32 8, i32 1)
  ret <1 x i32> %result
}

declare <8 x i32> @llvm.matrix.column.major.load.v8i32.i64(ptr nonnull align 4, i64, i1, i32, i32)

; This tests for a case where stride > columns in the load. Does not load all elements in the vector, so we
; shouldn't use special lowering.
define <1 x i32> @intrinsic_column_major_load_dot_product_i32_stride_too_large_1(ptr %lhs_address, ptr %rhs_address) {
; CHECK-LABEL: @intrinsic_column_major_load_dot_product_i32_stride_too_large_1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[COL_LOAD:%.*]] = load <1 x i32>, ptr [[LHS_ADDRESS:%.*]], align 4
; CHECK-NEXT:    [[VEC_GEP:%.*]] = getelementptr i32, ptr [[LHS_ADDRESS]], i64 4
; CHECK-NEXT:    [[COL_LOAD1:%.*]] = load <1 x i32>, ptr [[VEC_GEP]], align 4
; CHECK-NEXT:    [[VEC_GEP2:%.*]] = getelementptr i32, ptr [[LHS_ADDRESS]], i64 8
; CHECK-NEXT:    [[COL_LOAD3:%.*]] = load <1 x i32>, ptr [[VEC_GEP2]], align 4
; CHECK-NEXT:    [[VEC_GEP4:%.*]] = getelementptr i32, ptr [[LHS_ADDRESS]], i64 12
; CHECK-NEXT:    [[COL_LOAD5:%.*]] = load <1 x i32>, ptr [[VEC_GEP4]], align 4
; CHECK-NEXT:    [[TMP0:%.*]] = shufflevector <1 x i32> [[COL_LOAD]], <1 x i32> [[COL_LOAD1]], <2 x i32> <i32 0, i32 1>
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <1 x i32> [[COL_LOAD3]], <1 x i32> [[COL_LOAD5]], <2 x i32> <i32 0, i32 1>
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <2 x i32> [[TMP0]], <2 x i32> [[TMP1]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[COL_LOAD6:%.*]] = load <4 x i32>, ptr [[RHS_ADDRESS:%.*]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = mul <4 x i32> [[TMP2]], [[COL_LOAD6]]
; CHECK-NEXT:    [[TMP4:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[TMP3]])
; CHECK-NEXT:    [[TMP5:%.*]] = insertelement <1 x i32> poison, i32 [[TMP4]], i64 0
; CHECK-NEXT:    ret <1 x i32> [[TMP5]]
;
entry:
  %lhs = tail call <4 x i32> @llvm.matrix.column.major.load.v4i32.i64(ptr nonnull align 4 %lhs_address, i64 4, i1 false, i32 1, i32 4)
  %rhs = tail call <4 x i32> @llvm.matrix.column.major.load.v4i32.i64(ptr nonnull align 4 %rhs_address, i64 4, i1 false, i32 4, i32 1)
  %result = tail call <1 x i32> @llvm.matrix.multiply.v1i32.v4i32.v4i32(<4 x i32> %lhs, <4 x i32> %rhs, i32 1, i32 4, i32 1)
  ret <1 x i32> %result
}

declare <4 x i32> @llvm.matrix.column.major.load.v4i32.i64(ptr nonnull align 4, i64, i1, i32, i32)
declare <1 x i32> @llvm.matrix.multiply.v1i32.v4i32.v4i32(<4 x i32>, <4 x i32>, i32, i32, i32)

define <1 x i32> @intrinsic_column_major_load_dot_product_i32_stride_too_large_2(ptr %lhs_address, ptr %rhs_address) {
; CHECK-LABEL: @intrinsic_column_major_load_dot_product_i32_stride_too_large_2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[COL_LOAD:%.*]] = load <1 x i32>, ptr [[LHS_ADDRESS:%.*]], align 4
; CHECK-NEXT:    [[VEC_GEP:%.*]] = getelementptr i32, ptr [[LHS_ADDRESS]], i64 5
; CHECK-NEXT:    [[COL_LOAD1:%.*]] = load <1 x i32>, ptr [[VEC_GEP]], align 4
; CHECK-NEXT:    [[VEC_GEP2:%.*]] = getelementptr i32, ptr [[LHS_ADDRESS]], i64 10
; CHECK-NEXT:    [[COL_LOAD3:%.*]] = load <1 x i32>, ptr [[VEC_GEP2]], align 4
; CHECK-NEXT:    [[VEC_GEP4:%.*]] = getelementptr i32, ptr [[LHS_ADDRESS]], i64 15
; CHECK-NEXT:    [[COL_LOAD5:%.*]] = load <1 x i32>, ptr [[VEC_GEP4]], align 4
; CHECK-NEXT:    [[TMP0:%.*]] = shufflevector <1 x i32> [[COL_LOAD]], <1 x i32> [[COL_LOAD1]], <2 x i32> <i32 0, i32 1>
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <1 x i32> [[COL_LOAD3]], <1 x i32> [[COL_LOAD5]], <2 x i32> <i32 0, i32 1>
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <2 x i32> [[TMP0]], <2 x i32> [[TMP1]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[COL_LOAD6:%.*]] = load <4 x i32>, ptr [[RHS_ADDRESS:%.*]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = mul <4 x i32> [[TMP2]], [[COL_LOAD6]]
; CHECK-NEXT:    [[TMP4:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[TMP3]])
; CHECK-NEXT:    [[TMP5:%.*]] = insertelement <1 x i32> poison, i32 [[TMP4]], i64 0
; CHECK-NEXT:    ret <1 x i32> [[TMP5]]
;
entry:
  %lhs = tail call <4 x i32> @llvm.matrix.column.major.load.v4i32.i64(ptr nonnull align 4 %lhs_address, i64 5, i1 false, i32 1, i32 4)
  %rhs = tail call <4 x i32> @llvm.matrix.column.major.load.v4i32.i64(ptr nonnull align 4 %rhs_address, i64 4, i1 false, i32 4, i32 1)
  %result = tail call <1 x i32> @llvm.matrix.multiply.v1i32.v4i32.v4i32(<4 x i32> %lhs, <4 x i32> %rhs, i32 1, i32 4, i32 1)
  ret <1 x i32> %result
}


define <1 x i16> @LoadInst_dot_product_i16_v6(ptr %lhs_address, ptr %rhs_address) {
; CHECK-LABEL: @LoadInst_dot_product_i16_v6(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LHS:%.*]] = load <6 x i16>, ptr [[LHS_ADDRESS:%.*]], align 16
; CHECK-NEXT:    [[COL_LOAD:%.*]] = load <6 x i16>, ptr [[RHS_ADDRESS:%.*]], align 16
; CHECK-NEXT:    [[TMP0:%.*]] = mul <6 x i16> [[LHS]], [[COL_LOAD]]
; CHECK-NEXT:    [[TMP1:%.*]] = call i16 @llvm.vector.reduce.add.v6i16(<6 x i16> [[TMP0]])
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <1 x i16> poison, i16 [[TMP1]], i64 0
; CHECK-NEXT:    ret <1 x i16> [[TMP2]]
;
entry:
  %lhs = load <6 x i16>, ptr %lhs_address
  %rhs = load <6 x i16>, ptr %rhs_address
  %result = tail call <1 x i16> @llvm.matrix.multiply.v1i16.v6i16.v6i16(<6 x i16> %lhs, <6 x i16> %rhs, i32 1, i32 6, i32 1)
  ret <1 x i16> %result
}

declare <1 x i16> @llvm.matrix.multiply.v1i16.v6i16.v6i16(<6 x i16>, <6 x i16>, i32, i32, i32)

declare <4 x i32> @llvm.matrix.multiply.v4i32.v4i32.v4i32(<4 x i32>, <4 x i32>, i32 immarg, i32 immarg, i32 immarg)

define <1 x i32> @test_builtin_column_major_variable_stride(ptr %src, <4 x i32> %a, i64 %stride) {
; CHECK-LABEL: @test_builtin_column_major_variable_stride(
; CHECK-NEXT:    [[VEC_START:%.*]] = mul i64 0, [[STRIDE:%.*]]
; CHECK-NEXT:    [[VEC_GEP:%.*]] = getelementptr i32, ptr [[SRC:%.*]], i64 [[VEC_START]]
; CHECK-NEXT:    [[COL_LOAD:%.*]] = load <1 x i32>, ptr [[VEC_GEP]], align 4
; CHECK-NEXT:    [[VEC_START1:%.*]] = mul i64 1, [[STRIDE]]
; CHECK-NEXT:    [[VEC_GEP2:%.*]] = getelementptr i32, ptr [[SRC]], i64 [[VEC_START1]]
; CHECK-NEXT:    [[COL_LOAD3:%.*]] = load <1 x i32>, ptr [[VEC_GEP2]], align 4
; CHECK-NEXT:    [[VEC_START4:%.*]] = mul i64 2, [[STRIDE]]
; CHECK-NEXT:    [[VEC_GEP5:%.*]] = getelementptr i32, ptr [[SRC]], i64 [[VEC_START4]]
; CHECK-NEXT:    [[COL_LOAD6:%.*]] = load <1 x i32>, ptr [[VEC_GEP5]], align 4
; CHECK-NEXT:    [[VEC_START7:%.*]] = mul i64 3, [[STRIDE]]
; CHECK-NEXT:    [[VEC_GEP8:%.*]] = getelementptr i32, ptr [[SRC]], i64 [[VEC_START7]]
; CHECK-NEXT:    [[COL_LOAD9:%.*]] = load <1 x i32>, ptr [[VEC_GEP8]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <1 x i32> [[COL_LOAD]], <1 x i32> [[COL_LOAD3]], <2 x i32> <i32 0, i32 1>
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <1 x i32> [[COL_LOAD6]], <1 x i32> [[COL_LOAD9]], <2 x i32> <i32 0, i32 1>
; CHECK-NEXT:    [[TMP3:%.*]] = shufflevector <2 x i32> [[TMP1]], <2 x i32> [[TMP2]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[TMP4:%.*]] = mul <4 x i32> [[TMP3]], [[A:%.*]]
; CHECK-NEXT:    [[TMP5:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[TMP4]])
; CHECK-NEXT:    [[TMP6:%.*]] = insertelement <1 x i32> poison, i32 [[TMP5]], i64 0
; CHECK-NEXT:    ret <1 x i32> [[TMP6]]
;
  %l = call <4 x i32> @llvm.matrix.column.major.load.v4i32.i64(ptr %src, i64 %stride, i1 false, i32 1, i32 4)
  %r = call <1 x i32> @llvm.matrix.multiply.v1i32.v4i32.v4i32(<4 x i32> %l, <4 x i32> %a, i32 1, i32 4, i32 1)
  ret <1 x i32> %r
}
