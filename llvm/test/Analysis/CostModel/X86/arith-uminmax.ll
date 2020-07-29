; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -cost-model -analyze -mattr=+sse2 | FileCheck %s -check-prefixes=CHECK,SSE,SSE2
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -cost-model -analyze -mattr=+ssse3 | FileCheck %s -check-prefixes=CHECK,SSE,SSSE3
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -cost-model -analyze -mattr=+sse4.2 | FileCheck %s -check-prefixes=CHECK,SSE,SSE42
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -cost-model -analyze -mattr=+avx | FileCheck %s -check-prefixes=CHECK,AVX,AVX1
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -cost-model -analyze -mattr=+avx2 | FileCheck %s -check-prefixes=CHECK,AVX,AVX2
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -cost-model -analyze -mattr=+avx512f | FileCheck %s -check-prefixes=CHECK,AVX512,AVX512F
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -cost-model -analyze -mattr=+avx512vl,+avx512dq | FileCheck %s -check-prefixes=CHECK,AVX512,AVX512DQ
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -cost-model -analyze -mattr=+avx512vl,+avx512bw | FileCheck %s -check-prefixes=CHECK,AVX512,AVX512BW

declare i64        @llvm.umax.i64(i64, i64)
declare <2 x i64>  @llvm.umax.v2i64(<2 x i64>, <2 x i64>)
declare <4 x i64>  @llvm.umax.v4i64(<4 x i64>, <4 x i64>)
declare <8 x i64>  @llvm.umax.v8i64(<8 x i64>, <8 x i64>)

declare i32        @llvm.umax.i32(i32, i32)
declare <4 x i32>  @llvm.umax.v4i32(<4 x i32>, <4 x i32>)
declare <8 x i32>  @llvm.umax.v8i32(<8 x i32>, <8 x i32>)
declare <16 x i32> @llvm.umax.v16i32(<16 x i32>, <16 x i32>)

declare i16        @llvm.umax.i16(i16, i16)
declare <8 x i16>  @llvm.umax.v8i16(<8 x i16>, <8 x i16>)
declare <16 x i16> @llvm.umax.v16i16(<16 x i16>, <16 x i16>)
declare <32 x i16> @llvm.umax.v32i16(<32 x i16>, <32 x i16>)

declare i8         @llvm.umax.i8(i8,  i8)
declare <16 x i8>  @llvm.umax.v16i8(<16 x i8>, <16 x i8>)
declare <32 x i8>  @llvm.umax.v32i8(<32 x i8>, <32 x i8>)
declare <64 x i8>  @llvm.umax.v64i8(<64 x i8>, <64 x i8>)

define i32 @umax(i32 %arg) {
; SSE2-LABEL: 'umax'
; SSE2-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I64 = call i64 @llvm.umax.i64(i64 undef, i64 undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %V2I64 = call <2 x i64> @llvm.umax.v2i64(<2 x i64> undef, <2 x i64> undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %V4I64 = call <4 x i64> @llvm.umax.v4i64(<4 x i64> undef, <4 x i64> undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %V8I64 = call <8 x i64> @llvm.umax.v8i64(<8 x i64> undef, <8 x i64> undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I32 = call i32 @llvm.umax.i32(i32 undef, i32 undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 11 for instruction: %V4I32 = call <4 x i32> @llvm.umax.v4i32(<4 x i32> undef, <4 x i32> undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 22 for instruction: %V8I32 = call <8 x i32> @llvm.umax.v8i32(<8 x i32> undef, <8 x i32> undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 44 for instruction: %V16I32 = call <16 x i32> @llvm.umax.v16i32(<16 x i32> undef, <16 x i32> undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I16 = call i16 @llvm.umax.i16(i16 undef, i16 undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %V8I16 = call <8 x i16> @llvm.umax.v8i16(<8 x i16> undef, <8 x i16> undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: %V16I16 = call <16 x i16> @llvm.umax.v16i16(<16 x i16> undef, <16 x i16> undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 64 for instruction: %V32I16 = call <32 x i16> @llvm.umax.v32i16(<32 x i16> undef, <32 x i16> undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I8 = call i8 @llvm.umax.i8(i8 undef, i8 undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 47 for instruction: %V16I8 = call <16 x i8> @llvm.umax.v16i8(<16 x i8> undef, <16 x i8> undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 94 for instruction: %V32I8 = call <32 x i8> @llvm.umax.v32i8(<32 x i8> undef, <32 x i8> undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 188 for instruction: %V64I8 = call <64 x i8> @llvm.umax.v64i8(<64 x i8> undef, <64 x i8> undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; SSSE3-LABEL: 'umax'
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I64 = call i64 @llvm.umax.i64(i64 undef, i64 undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %V2I64 = call <2 x i64> @llvm.umax.v2i64(<2 x i64> undef, <2 x i64> undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %V4I64 = call <4 x i64> @llvm.umax.v4i64(<4 x i64> undef, <4 x i64> undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %V8I64 = call <8 x i64> @llvm.umax.v8i64(<8 x i64> undef, <8 x i64> undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I32 = call i32 @llvm.umax.i32(i32 undef, i32 undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 11 for instruction: %V4I32 = call <4 x i32> @llvm.umax.v4i32(<4 x i32> undef, <4 x i32> undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 22 for instruction: %V8I32 = call <8 x i32> @llvm.umax.v8i32(<8 x i32> undef, <8 x i32> undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 44 for instruction: %V16I32 = call <16 x i32> @llvm.umax.v16i32(<16 x i32> undef, <16 x i32> undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I16 = call i16 @llvm.umax.i16(i16 undef, i16 undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %V8I16 = call <8 x i16> @llvm.umax.v8i16(<8 x i16> undef, <8 x i16> undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: %V16I16 = call <16 x i16> @llvm.umax.v16i16(<16 x i16> undef, <16 x i16> undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 64 for instruction: %V32I16 = call <32 x i16> @llvm.umax.v32i16(<32 x i16> undef, <32 x i16> undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I8 = call i8 @llvm.umax.i8(i8 undef, i8 undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 47 for instruction: %V16I8 = call <16 x i8> @llvm.umax.v16i8(<16 x i8> undef, <16 x i8> undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 94 for instruction: %V32I8 = call <32 x i8> @llvm.umax.v32i8(<32 x i8> undef, <32 x i8> undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 188 for instruction: %V64I8 = call <64 x i8> @llvm.umax.v64i8(<64 x i8> undef, <64 x i8> undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; SSE42-LABEL: 'umax'
; SSE42-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I64 = call i64 @llvm.umax.i64(i64 undef, i64 undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V2I64 = call <2 x i64> @llvm.umax.v2i64(<2 x i64> undef, <2 x i64> undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %V4I64 = call <4 x i64> @llvm.umax.v4i64(<4 x i64> undef, <4 x i64> undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %V8I64 = call <8 x i64> @llvm.umax.v8i64(<8 x i64> undef, <8 x i64> undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I32 = call i32 @llvm.umax.i32(i32 undef, i32 undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %V4I32 = call <4 x i32> @llvm.umax.v4i32(<4 x i32> undef, <4 x i32> undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %V8I32 = call <8 x i32> @llvm.umax.v8i32(<8 x i32> undef, <8 x i32> undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: %V16I32 = call <16 x i32> @llvm.umax.v16i32(<16 x i32> undef, <16 x i32> undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I16 = call i16 @llvm.umax.i16(i16 undef, i16 undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %V8I16 = call <8 x i16> @llvm.umax.v8i16(<8 x i16> undef, <8 x i16> undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: %V16I16 = call <16 x i16> @llvm.umax.v16i16(<16 x i16> undef, <16 x i16> undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 64 for instruction: %V32I16 = call <32 x i16> @llvm.umax.v32i16(<32 x i16> undef, <32 x i16> undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I8 = call i8 @llvm.umax.i8(i8 undef, i8 undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: %V16I8 = call <16 x i8> @llvm.umax.v16i8(<16 x i8> undef, <16 x i8> undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 64 for instruction: %V32I8 = call <32 x i8> @llvm.umax.v32i8(<32 x i8> undef, <32 x i8> undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 128 for instruction: %V64I8 = call <64 x i8> @llvm.umax.v64i8(<64 x i8> undef, <64 x i8> undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; AVX-LABEL: 'umax'
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I64 = call i64 @llvm.umax.i64(i64 undef, i64 undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V2I64 = call <2 x i64> @llvm.umax.v2i64(<2 x i64> undef, <2 x i64> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 9 for instruction: %V4I64 = call <4 x i64> @llvm.umax.v4i64(<4 x i64> undef, <4 x i64> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 18 for instruction: %V8I64 = call <8 x i64> @llvm.umax.v8i64(<8 x i64> undef, <8 x i64> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I32 = call i32 @llvm.umax.i32(i32 undef, i32 undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %V4I32 = call <4 x i32> @llvm.umax.v4i32(<4 x i32> undef, <4 x i32> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 17 for instruction: %V8I32 = call <8 x i32> @llvm.umax.v8i32(<8 x i32> undef, <8 x i32> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 34 for instruction: %V16I32 = call <16 x i32> @llvm.umax.v16i32(<16 x i32> undef, <16 x i32> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I16 = call i16 @llvm.umax.i16(i16 undef, i16 undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %V8I16 = call <8 x i16> @llvm.umax.v8i16(<8 x i16> undef, <8 x i16> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 33 for instruction: %V16I16 = call <16 x i16> @llvm.umax.v16i16(<16 x i16> undef, <16 x i16> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 66 for instruction: %V32I16 = call <32 x i16> @llvm.umax.v32i16(<32 x i16> undef, <32 x i16> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I8 = call i8 @llvm.umax.i8(i8 undef, i8 undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: %V16I8 = call <16 x i8> @llvm.umax.v16i8(<16 x i8> undef, <16 x i8> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 65 for instruction: %V32I8 = call <32 x i8> @llvm.umax.v32i8(<32 x i8> undef, <32 x i8> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 130 for instruction: %V64I8 = call <64 x i8> @llvm.umax.v64i8(<64 x i8> undef, <64 x i8> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; AVX512-LABEL: 'umax'
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I64 = call i64 @llvm.umax.i64(i64 undef, i64 undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V2I64 = call <2 x i64> @llvm.umax.v2i64(<2 x i64> undef, <2 x i64> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 9 for instruction: %V4I64 = call <4 x i64> @llvm.umax.v4i64(<4 x i64> undef, <4 x i64> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 19 for instruction: %V8I64 = call <8 x i64> @llvm.umax.v8i64(<8 x i64> undef, <8 x i64> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I32 = call i32 @llvm.umax.i32(i32 undef, i32 undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %V4I32 = call <4 x i32> @llvm.umax.v4i32(<4 x i32> undef, <4 x i32> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 17 for instruction: %V8I32 = call <8 x i32> @llvm.umax.v8i32(<8 x i32> undef, <8 x i32> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 35 for instruction: %V16I32 = call <16 x i32> @llvm.umax.v16i32(<16 x i32> undef, <16 x i32> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I16 = call i16 @llvm.umax.i16(i16 undef, i16 undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %V8I16 = call <8 x i16> @llvm.umax.v8i16(<8 x i16> undef, <8 x i16> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 33 for instruction: %V16I16 = call <16 x i16> @llvm.umax.v16i16(<16 x i16> undef, <16 x i16> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 67 for instruction: %V32I16 = call <32 x i16> @llvm.umax.v32i16(<32 x i16> undef, <32 x i16> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I8 = call i8 @llvm.umax.i8(i8 undef, i8 undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: %V16I8 = call <16 x i8> @llvm.umax.v16i8(<16 x i8> undef, <16 x i8> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 65 for instruction: %V32I8 = call <32 x i8> @llvm.umax.v32i8(<32 x i8> undef, <32 x i8> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 131 for instruction: %V64I8 = call <64 x i8> @llvm.umax.v64i8(<64 x i8> undef, <64 x i8> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
  %I64 = call i64 @llvm.umax.i64(i64 undef, i64 undef)
  %V2I64 = call <2 x i64> @llvm.umax.v2i64(<2 x i64> undef, <2 x i64> undef)
  %V4I64 = call <4 x i64> @llvm.umax.v4i64(<4 x i64> undef, <4 x i64> undef)
  %V8I64 = call <8 x i64> @llvm.umax.v8i64(<8 x i64> undef, <8 x i64> undef)

  %I32 = call i32 @llvm.umax.i32(i32 undef, i32 undef)
  %V4I32  = call <4 x i32>  @llvm.umax.v4i32(<4 x i32> undef, <4 x i32> undef)
  %V8I32  = call <8 x i32>  @llvm.umax.v8i32(<8 x i32> undef, <8 x i32> undef)
  %V16I32 = call <16 x i32> @llvm.umax.v16i32(<16 x i32> undef, <16 x i32> undef)

  %I16 = call i16 @llvm.umax.i16(i16 undef, i16 undef)
  %V8I16  = call <8 x i16>  @llvm.umax.v8i16(<8 x i16> undef, <8 x i16> undef)
  %V16I16 = call <16 x i16> @llvm.umax.v16i16(<16 x i16> undef, <16 x i16> undef)
  %V32I16 = call <32 x i16> @llvm.umax.v32i16(<32 x i16> undef, <32 x i16> undef)

  %I8 = call i8 @llvm.umax.i8(i8 undef, i8 undef)
  %V16I8 = call <16 x i8> @llvm.umax.v16i8(<16 x i8> undef, <16 x i8> undef)
  %V32I8 = call <32 x i8> @llvm.umax.v32i8(<32 x i8> undef, <32 x i8> undef)
  %V64I8 = call <64 x i8> @llvm.umax.v64i8(<64 x i8> undef, <64 x i8> undef)

  ret i32 undef
}

declare i64        @llvm.umin.i64(i64, i64)
declare <2 x i64>  @llvm.umin.v2i64(<2 x i64>, <2 x i64>)
declare <4 x i64>  @llvm.umin.v4i64(<4 x i64>, <4 x i64>)
declare <8 x i64>  @llvm.umin.v8i64(<8 x i64>, <8 x i64>)

declare i32        @llvm.umin.i32(i32, i32)
declare <4 x i32>  @llvm.umin.v4i32(<4 x i32>, <4 x i32>)
declare <8 x i32>  @llvm.umin.v8i32(<8 x i32>, <8 x i32>)
declare <16 x i32> @llvm.umin.v16i32(<16 x i32>, <16 x i32>)

declare i16        @llvm.umin.i16(i16, i16)
declare <8 x i16>  @llvm.umin.v8i16(<8 x i16>, <8 x i16>)
declare <16 x i16> @llvm.umin.v16i16(<16 x i16>, <16 x i16>)
declare <32 x i16> @llvm.umin.v32i16(<32 x i16>, <32 x i16>)

declare i8         @llvm.umin.i8(i8,  i8)
declare <16 x i8>  @llvm.umin.v16i8(<16 x i8>, <16 x i8>)
declare <32 x i8>  @llvm.umin.v32i8(<32 x i8>, <32 x i8>)
declare <64 x i8>  @llvm.umin.v64i8(<64 x i8>, <64 x i8>)

define i32 @umin(i32 %arg) {
; SSE2-LABEL: 'umin'
; SSE2-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I64 = call i64 @llvm.umin.i64(i64 undef, i64 undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %V2I64 = call <2 x i64> @llvm.umin.v2i64(<2 x i64> undef, <2 x i64> undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %V4I64 = call <4 x i64> @llvm.umin.v4i64(<4 x i64> undef, <4 x i64> undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %V8I64 = call <8 x i64> @llvm.umin.v8i64(<8 x i64> undef, <8 x i64> undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I32 = call i32 @llvm.umin.i32(i32 undef, i32 undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 11 for instruction: %V4I32 = call <4 x i32> @llvm.umin.v4i32(<4 x i32> undef, <4 x i32> undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 22 for instruction: %V8I32 = call <8 x i32> @llvm.umin.v8i32(<8 x i32> undef, <8 x i32> undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 44 for instruction: %V16I32 = call <16 x i32> @llvm.umin.v16i32(<16 x i32> undef, <16 x i32> undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I16 = call i16 @llvm.umin.i16(i16 undef, i16 undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %V8I16 = call <8 x i16> @llvm.umin.v8i16(<8 x i16> undef, <8 x i16> undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: %V16I16 = call <16 x i16> @llvm.umin.v16i16(<16 x i16> undef, <16 x i16> undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 64 for instruction: %V32I16 = call <32 x i16> @llvm.umin.v32i16(<32 x i16> undef, <32 x i16> undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I8 = call i8 @llvm.umin.i8(i8 undef, i8 undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 47 for instruction: %V16I8 = call <16 x i8> @llvm.umin.v16i8(<16 x i8> undef, <16 x i8> undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 94 for instruction: %V32I8 = call <32 x i8> @llvm.umin.v32i8(<32 x i8> undef, <32 x i8> undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 188 for instruction: %V64I8 = call <64 x i8> @llvm.umin.v64i8(<64 x i8> undef, <64 x i8> undef)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; SSSE3-LABEL: 'umin'
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I64 = call i64 @llvm.umin.i64(i64 undef, i64 undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %V2I64 = call <2 x i64> @llvm.umin.v2i64(<2 x i64> undef, <2 x i64> undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %V4I64 = call <4 x i64> @llvm.umin.v4i64(<4 x i64> undef, <4 x i64> undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %V8I64 = call <8 x i64> @llvm.umin.v8i64(<8 x i64> undef, <8 x i64> undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I32 = call i32 @llvm.umin.i32(i32 undef, i32 undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 11 for instruction: %V4I32 = call <4 x i32> @llvm.umin.v4i32(<4 x i32> undef, <4 x i32> undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 22 for instruction: %V8I32 = call <8 x i32> @llvm.umin.v8i32(<8 x i32> undef, <8 x i32> undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 44 for instruction: %V16I32 = call <16 x i32> @llvm.umin.v16i32(<16 x i32> undef, <16 x i32> undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I16 = call i16 @llvm.umin.i16(i16 undef, i16 undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %V8I16 = call <8 x i16> @llvm.umin.v8i16(<8 x i16> undef, <8 x i16> undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: %V16I16 = call <16 x i16> @llvm.umin.v16i16(<16 x i16> undef, <16 x i16> undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 64 for instruction: %V32I16 = call <32 x i16> @llvm.umin.v32i16(<32 x i16> undef, <32 x i16> undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I8 = call i8 @llvm.umin.i8(i8 undef, i8 undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 47 for instruction: %V16I8 = call <16 x i8> @llvm.umin.v16i8(<16 x i8> undef, <16 x i8> undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 94 for instruction: %V32I8 = call <32 x i8> @llvm.umin.v32i8(<32 x i8> undef, <32 x i8> undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 188 for instruction: %V64I8 = call <64 x i8> @llvm.umin.v64i8(<64 x i8> undef, <64 x i8> undef)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; SSE42-LABEL: 'umin'
; SSE42-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I64 = call i64 @llvm.umin.i64(i64 undef, i64 undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V2I64 = call <2 x i64> @llvm.umin.v2i64(<2 x i64> undef, <2 x i64> undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %V4I64 = call <4 x i64> @llvm.umin.v4i64(<4 x i64> undef, <4 x i64> undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %V8I64 = call <8 x i64> @llvm.umin.v8i64(<8 x i64> undef, <8 x i64> undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I32 = call i32 @llvm.umin.i32(i32 undef, i32 undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %V4I32 = call <4 x i32> @llvm.umin.v4i32(<4 x i32> undef, <4 x i32> undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %V8I32 = call <8 x i32> @llvm.umin.v8i32(<8 x i32> undef, <8 x i32> undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: %V16I32 = call <16 x i32> @llvm.umin.v16i32(<16 x i32> undef, <16 x i32> undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I16 = call i16 @llvm.umin.i16(i16 undef, i16 undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %V8I16 = call <8 x i16> @llvm.umin.v8i16(<8 x i16> undef, <8 x i16> undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: %V16I16 = call <16 x i16> @llvm.umin.v16i16(<16 x i16> undef, <16 x i16> undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 64 for instruction: %V32I16 = call <32 x i16> @llvm.umin.v32i16(<32 x i16> undef, <32 x i16> undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I8 = call i8 @llvm.umin.i8(i8 undef, i8 undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: %V16I8 = call <16 x i8> @llvm.umin.v16i8(<16 x i8> undef, <16 x i8> undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 64 for instruction: %V32I8 = call <32 x i8> @llvm.umin.v32i8(<32 x i8> undef, <32 x i8> undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 128 for instruction: %V64I8 = call <64 x i8> @llvm.umin.v64i8(<64 x i8> undef, <64 x i8> undef)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; AVX-LABEL: 'umin'
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I64 = call i64 @llvm.umin.i64(i64 undef, i64 undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V2I64 = call <2 x i64> @llvm.umin.v2i64(<2 x i64> undef, <2 x i64> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 9 for instruction: %V4I64 = call <4 x i64> @llvm.umin.v4i64(<4 x i64> undef, <4 x i64> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 18 for instruction: %V8I64 = call <8 x i64> @llvm.umin.v8i64(<8 x i64> undef, <8 x i64> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I32 = call i32 @llvm.umin.i32(i32 undef, i32 undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %V4I32 = call <4 x i32> @llvm.umin.v4i32(<4 x i32> undef, <4 x i32> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 17 for instruction: %V8I32 = call <8 x i32> @llvm.umin.v8i32(<8 x i32> undef, <8 x i32> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 34 for instruction: %V16I32 = call <16 x i32> @llvm.umin.v16i32(<16 x i32> undef, <16 x i32> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I16 = call i16 @llvm.umin.i16(i16 undef, i16 undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %V8I16 = call <8 x i16> @llvm.umin.v8i16(<8 x i16> undef, <8 x i16> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 33 for instruction: %V16I16 = call <16 x i16> @llvm.umin.v16i16(<16 x i16> undef, <16 x i16> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 66 for instruction: %V32I16 = call <32 x i16> @llvm.umin.v32i16(<32 x i16> undef, <32 x i16> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I8 = call i8 @llvm.umin.i8(i8 undef, i8 undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: %V16I8 = call <16 x i8> @llvm.umin.v16i8(<16 x i8> undef, <16 x i8> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 65 for instruction: %V32I8 = call <32 x i8> @llvm.umin.v32i8(<32 x i8> undef, <32 x i8> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 130 for instruction: %V64I8 = call <64 x i8> @llvm.umin.v64i8(<64 x i8> undef, <64 x i8> undef)
; AVX-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; AVX512-LABEL: 'umin'
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I64 = call i64 @llvm.umin.i64(i64 undef, i64 undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V2I64 = call <2 x i64> @llvm.umin.v2i64(<2 x i64> undef, <2 x i64> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 9 for instruction: %V4I64 = call <4 x i64> @llvm.umin.v4i64(<4 x i64> undef, <4 x i64> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 19 for instruction: %V8I64 = call <8 x i64> @llvm.umin.v8i64(<8 x i64> undef, <8 x i64> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I32 = call i32 @llvm.umin.i32(i32 undef, i32 undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %V4I32 = call <4 x i32> @llvm.umin.v4i32(<4 x i32> undef, <4 x i32> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 17 for instruction: %V8I32 = call <8 x i32> @llvm.umin.v8i32(<8 x i32> undef, <8 x i32> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 35 for instruction: %V16I32 = call <16 x i32> @llvm.umin.v16i32(<16 x i32> undef, <16 x i32> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I16 = call i16 @llvm.umin.i16(i16 undef, i16 undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %V8I16 = call <8 x i16> @llvm.umin.v8i16(<8 x i16> undef, <8 x i16> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 33 for instruction: %V16I16 = call <16 x i16> @llvm.umin.v16i16(<16 x i16> undef, <16 x i16> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 67 for instruction: %V32I16 = call <32 x i16> @llvm.umin.v32i16(<32 x i16> undef, <32 x i16> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I8 = call i8 @llvm.umin.i8(i8 undef, i8 undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: %V16I8 = call <16 x i8> @llvm.umin.v16i8(<16 x i8> undef, <16 x i8> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 65 for instruction: %V32I8 = call <32 x i8> @llvm.umin.v32i8(<32 x i8> undef, <32 x i8> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 131 for instruction: %V64I8 = call <64 x i8> @llvm.umin.v64i8(<64 x i8> undef, <64 x i8> undef)
; AVX512-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
  %I64 = call i64 @llvm.umin.i64(i64 undef, i64 undef)
  %V2I64 = call <2 x i64> @llvm.umin.v2i64(<2 x i64> undef, <2 x i64> undef)
  %V4I64 = call <4 x i64> @llvm.umin.v4i64(<4 x i64> undef, <4 x i64> undef)
  %V8I64 = call <8 x i64> @llvm.umin.v8i64(<8 x i64> undef, <8 x i64> undef)

  %I32 = call i32 @llvm.umin.i32(i32 undef, i32 undef)
  %V4I32  = call <4 x i32>  @llvm.umin.v4i32(<4 x i32> undef, <4 x i32> undef)
  %V8I32  = call <8 x i32>  @llvm.umin.v8i32(<8 x i32> undef, <8 x i32> undef)
  %V16I32 = call <16 x i32> @llvm.umin.v16i32(<16 x i32> undef, <16 x i32> undef)

  %I16 = call i16 @llvm.umin.i16(i16 undef, i16 undef)
  %V8I16  = call <8 x i16>  @llvm.umin.v8i16(<8 x i16> undef, <8 x i16> undef)
  %V16I16 = call <16 x i16> @llvm.umin.v16i16(<16 x i16> undef, <16 x i16> undef)
  %V32I16 = call <32 x i16> @llvm.umin.v32i16(<32 x i16> undef, <32 x i16> undef)

  %I8 = call i8 @llvm.umin.i8(i8 undef, i8 undef)
  %V16I8 = call <16 x i8> @llvm.umin.v16i8(<16 x i8> undef, <16 x i8> undef)
  %V32I8 = call <32 x i8> @llvm.umin.v32i8(<32 x i8> undef, <32 x i8> undef)
  %V64I8 = call <64 x i8> @llvm.umin.v64i8(<64 x i8> undef, <64 x i8> undef)

  ret i32 undef
}
