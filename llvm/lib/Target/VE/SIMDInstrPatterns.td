//===-- VEInstrPatternsSIMD.td - VE SIMD patterns ----------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file describes the SIMD (fixed length) style vector intermediate
// SDNodes and their isel patterns.
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Vector Instruction Patterns
//===----------------------------------------------------------------------===//

// Custom ISDs
// VEISD::VEC_SEQ - A vector sequence with a stride.
// VEISD::VEC_BROADCAST - A vector splat of a scalar value into all vector
//                        lanes.

def vec_seq : SDNode<"VEISD::VEC_SEQ",
                     SDTypeProfile<1, 1, [SDTCisVec<0>, SDTCisInt<1>]>>;

//===----------------------------------------------------------------------===//
// Vector broadcast for vector mask registers.
//===----------------------------------------------------------------------===//

// Boardcast for vector mask register.
let Predicates = [IsSimdSubTarget] in {
  def : Pat<(v256i1 (vec_broadcast (i32 0), (i32 256))),
            (LVMim_m 3, 0,
            (LVMim_m 2, 0,
            (LVMim_m 1, 0,
            (LVMim 0, 0))))>;
  def : Pat<(v512i1 (vec_broadcast (i32 0), (i32 512))),
            (LVMyim_y 7, 0,
            (LVMyim_y 6, 0,
            (LVMyim_y 5, 0,
            (LVMyim_y 4, 0,
            (LVMyim_y 3, 0,
            (LVMyim_y 2, 0,
            (LVMyim_y 1, 0,
            (LVMyim 0, 0))))))))>;
}

//===----------------------------------------------------------------------===//
// Fixed length vector instruction patterns for simd subtarget which is being
// implemented experimatally.
//===----------------------------------------------------------------------===//

// Pattern Matchings for Generic Vector Instructions

// Pattern Fragments for sextload/zextload/truncstore of vector types

def extloadv256i32 : PatFrag<(ops node:$ptr), (extload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v256i32;
}]>;
def sextloadv256i32 : PatFrag<(ops node:$ptr), (sextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v256i32;
}]>;
def zextloadv256i32 : PatFrag<(ops node:$ptr), (zextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v256i32;
}]>;
def extloadv128i32 : PatFrag<(ops node:$ptr), (extload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v128i32;
}]>;
def sextloadv128i32 : PatFrag<(ops node:$ptr), (sextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v128i32;
}]>;
def zextloadv128i32 : PatFrag<(ops node:$ptr), (zextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v128i32;
}]>;
def extloadv64i32 : PatFrag<(ops node:$ptr), (extload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v64i32;
}]>;
def sextloadv64i32 : PatFrag<(ops node:$ptr), (sextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v64i32;
}]>;
def zextloadv64i32 : PatFrag<(ops node:$ptr), (zextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v64i32;
}]>;
def extloadv32i32 : PatFrag<(ops node:$ptr), (extload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v32i32;
}]>;
def sextloadv32i32 : PatFrag<(ops node:$ptr), (sextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v32i32;
}]>;
def zextloadv32i32 : PatFrag<(ops node:$ptr), (zextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v32i32;
}]>;
def extloadv16i32 : PatFrag<(ops node:$ptr), (extload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v16i32;
}]>;
def sextloadv16i32 : PatFrag<(ops node:$ptr), (sextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v16i32;
}]>;
def zextloadv16i32 : PatFrag<(ops node:$ptr), (zextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v16i32;
}]>;
def extloadv8i32 : PatFrag<(ops node:$ptr), (extload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v8i32;
}]>;
def sextloadv8i32 : PatFrag<(ops node:$ptr), (sextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v8i32;
}]>;
def zextloadv8i32 : PatFrag<(ops node:$ptr), (zextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v8i32;
}]>;
def extloadv4i32 : PatFrag<(ops node:$ptr), (extload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v4i32;
}]>;
def sextloadv4i32 : PatFrag<(ops node:$ptr), (sextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v4i32;
}]>;
def zextloadv4i32 : PatFrag<(ops node:$ptr), (zextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v4i32;
}]>;
def extloadv2i32 : PatFrag<(ops node:$ptr), (extload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v2i32;
}]>;
def sextloadv2i32 : PatFrag<(ops node:$ptr), (sextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v2i32;
}]>;
def zextloadv2i32 : PatFrag<(ops node:$ptr), (zextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v2i32;
}]>;
def truncstorev256i32 : PatFrag<(ops node:$val, node:$ptr),
                                (truncstore node:$val, node:$ptr), [{
  return cast<StoreSDNode>(N)->getMemoryVT() == MVT::v256i32;
}]>;
def truncstorev128i32 : PatFrag<(ops node:$val, node:$ptr),
                              (truncstore node:$val, node:$ptr), [{
  return cast<StoreSDNode>(N)->getMemoryVT() == MVT::v128i32;
}]>;
def truncstorev64i32 : PatFrag<(ops node:$val, node:$ptr),
                              (truncstore node:$val, node:$ptr), [{
  return cast<StoreSDNode>(N)->getMemoryVT() == MVT::v64i32;
}]>;
def truncstorev32i32 : PatFrag<(ops node:$val, node:$ptr),
                              (truncstore node:$val, node:$ptr), [{
  return cast<StoreSDNode>(N)->getMemoryVT() == MVT::v32i32;
}]>;
def truncstorev16i32 : PatFrag<(ops node:$val, node:$ptr),
                              (truncstore node:$val, node:$ptr), [{
  return cast<StoreSDNode>(N)->getMemoryVT() == MVT::v16i32;
}]>;
def truncstorev8i32 : PatFrag<(ops node:$val, node:$ptr),
                              (truncstore node:$val, node:$ptr), [{
  return cast<StoreSDNode>(N)->getMemoryVT() == MVT::v8i32;
}]>;
def truncstorev4i32 : PatFrag<(ops node:$val, node:$ptr),
                              (truncstore node:$val, node:$ptr), [{
  return cast<StoreSDNode>(N)->getMemoryVT() == MVT::v4i32;
}]>;
def truncstorev2i32 : PatFrag<(ops node:$val, node:$ptr),
                              (truncstore node:$val, node:$ptr), [{
  return cast<StoreSDNode>(N)->getMemoryVT() == MVT::v2i32;
}]>;

// Load and store for all vector types
// v2i32, v2i64, v2f32, v2f64, v4i32, v4i64, v4f32, v4f64,
// v8i32, v8i64, v8f32, v8f64, v16i32, v16i64, v16f32, v16f64,
// v32i32, v32i64, v32f32, v32f64, v64i32, v64i64, v64f32, v64f64,
// v128i32, v128i64, v128f32, v128f64, v256i32, v256i64, v256f32, v256f64,
// v512i32, v512f32.

let Predicates = [IsSimdSubTarget] in {
  def : Pat<(v512i32 (load I64:$addr)),
            (v512i32 (VLDirl 8, $addr, 256))>;
  def : Pat<(v512f32 (load I64:$addr)),
            (v512f32 (VLDirl 8, $addr, 256))>;
}

multiclass simd_load<int length> {
  defvar vi32 = !cast<ValueType>("v" # !cast<string>(length) # "i32");
  defvar vi64 = !cast<ValueType>("v" # !cast<string>(length) # "i64");
  defvar vf32 = !cast<ValueType>("v" # !cast<string>(length) # "f32");
  defvar vf64 = !cast<ValueType>("v" # !cast<string>(length) # "f64");

  // Load patterns.
  def : Pat<(vi32 (load I64:$addr)),
            (vi32 (VLDLSXirl 4, $addr, (VLEN length)))>;
  def : Pat<(vf32 (load I64:$addr)),
            (vf32 (VLDUirl 4, $addr, (VLEN length)))>;
  def : Pat<(vf64 (load I64:$addr)),
            (vf64 (VLDirl 8, $addr, (VLEN length)))>;
  def : Pat<(vi64 (load I64:$addr)),
            (vi64 (VLDirl 8, $addr, (VLEN length)))>;

  defvar extload = !cast<PatFrag>("extloadv" # !cast<string>(length) # "i32");
  defvar sextload = !cast<PatFrag>("sextloadv" # !cast<string>(length) # "i32");
  defvar zextload = !cast<PatFrag>("zextloadv" # !cast<string>(length) # "i32");

  // *ExtLoad patterns.
  def : Pat<(vi64 (extload I64:$addr)),
            (vi64 (VLDLZXirl 4, $addr, (VLEN length)))>;
  def : Pat<(vi64 (sextload I64:$addr)),
            (vi64 (VLDLSXirl 4, $addr, (VLEN length)))>;
  def : Pat<(vi64 (zextload I64:$addr)),
            (vi64 (VLDLZXirl 4, $addr, (VLEN length)))>;
}

let Predicates = [IsSimdSubTarget] in {
  defm : simd_load<256>;
  defm : simd_load<128>;
  defm : simd_load<64>;
  defm : simd_load<32>;
  defm : simd_load<16>;
  defm : simd_load<8>;
  defm : simd_load<4>;
  defm : simd_load<2>;
}

let Predicates = [IsSimdSubTarget] in {
  def : Pat<(store v512i32:$vx, I64:$addr),
            (VSTirvl 8, $addr, $vx, 256)>;
  def : Pat<(store v512f32:$vx, I64:$addr),
            (VSTirvl 8, $addr, $vx, 256)>;
}

multiclass simd_store<int length> {
  defvar vi32 = !cast<ValueType>("v" # !cast<string>(length) # "i32");
  defvar vi64 = !cast<ValueType>("v" # !cast<string>(length) # "i64");
  defvar vf32 = !cast<ValueType>("v" # !cast<string>(length) # "f32");
  defvar vf64 = !cast<ValueType>("v" # !cast<string>(length) # "f64");

  // Load patterns.
  def : Pat<(store vi32:$vx, I64:$addr),
            (VSTLirvl 4, $addr, $vx, (VLEN length))>;
  def : Pat<(store vf32:$vx, I64:$addr),
            (VSTUirvl 4, $addr, $vx, (VLEN length))>;
  def : Pat<(store vi64:$vx, I64:$addr),
            (VSTirvl 8, $addr, $vx, (VLEN length))>;
  def : Pat<(store vf64:$vx, I64:$addr),
            (VSTirvl 8, $addr, $vx, (VLEN length))>;

  defvar truncstore =
      !cast<PatFrag>("truncstorev" # !cast<string>(length) # "i32");

  // TruncStore patterns.
  def : Pat<(truncstore vi64:$vx, I64:$addr),
            (VSTLirvl 4, $addr, $vx, (VLEN length))>;
}

let Predicates = [IsSimdSubTarget] in {
  defm : simd_store<256>;
  defm : simd_store<128>;
  defm : simd_store<64>;
  defm : simd_store<32>;
  defm : simd_store<16>;
  defm : simd_store<8>;
  defm : simd_store<4>;
  defm : simd_store<2>;
}

// Load/store for mask register using stack/symbol is implemented in custom
// lower.  Only load/store for mask registers using frame index is implemented
// here.

// Load for
// v256i1, v512i1

let Predicates = [IsSimdSubTarget] in {
  def : Pat<(v256i1 (load ADDRrii:$addr)),
            (LDVMrii ADDRrii:$addr)>;
  def : Pat<(v512i1 (load ADDRrii:$addr)),
            (LDVM512rii ADDRrii:$addr)>;
}

// Store for
// v256i1, v512i1

let Predicates = [IsSimdSubTarget] in {
  def : Pat<(store v256i1:$vx, ADDRrii:$addr),
            (STVMrii ADDRrii:$addr, $vx)>;
  def : Pat<(store v512i1:$vx, ADDRrii:$addr),
            (STVM512rii ADDRrii:$addr, $vx)>;
}

// Format Conversions

// sint -> floating-point

let Predicates = [IsSimdSubTarget] in {
  def : Pat<(v512f32 (sint_to_fp v512i32:$vx)),
            (PVCVTSWvl $vx, (VLEN 256))>;
}

multiclass simd_i2f<int length> {
  defvar vi32 = !cast<ValueType>("v" # !cast<string>(length) # "i32");
  defvar vi64 = !cast<ValueType>("v" # !cast<string>(length) # "i64");
  defvar vf32 = !cast<ValueType>("v" # !cast<string>(length) # "f32");
  defvar vf64 = !cast<ValueType>("v" # !cast<string>(length) # "f64");

  def : Pat<(vf64 (sint_to_fp vi64:$vx)),
            (VCVTDLvl $vx, (VLEN length))>;
  def : Pat<(vf64 (sint_to_fp vi32:$vx)),
            (VCVTDWvl $vx, (VLEN length))>;
  def : Pat<(vf32 (sint_to_fp vi64:$vx)),
            (VCVTSDvl (VCVTDWvl $vx, (VLEN length)), (VLEN length))>;
  def : Pat<(vf32 (sint_to_fp vi32:$vx)),
            (VCVTSWvl $vx, (VLEN length))>;
}

let Predicates = [IsSimdSubTarget] in {
  defm : simd_i2f<256>;
  defm : simd_i2f<128>;
  defm : simd_i2f<64>;
  defm : simd_i2f<32>;
  defm : simd_i2f<16>;
  defm : simd_i2f<8>;
  defm : simd_i2f<4>;
  defm : simd_i2f<2>;
}

// floating-point -> sint

let Predicates = [IsSimdSubTarget] in {
  def : Pat<(v512i32 (fp_to_sint v512f32:$val)),
            (PVCVTWSvl RD_RZ, $val, (VLEN 256))>;
}

multiclass simd_f2i<int length> {
  defvar vi32 = !cast<ValueType>("v" # !cast<string>(length) # "i32");
  defvar vi64 = !cast<ValueType>("v" # !cast<string>(length) # "i64");
  defvar vf32 = !cast<ValueType>("v" # !cast<string>(length) # "f32");
  defvar vf64 = !cast<ValueType>("v" # !cast<string>(length) # "f64");

  def : Pat<(vi64 (fp_to_sint vf64:$val)),
            (vi64 (VCVTLDvl RD_RZ, $val, (VLEN length)))>;
  def : Pat<(vi64 (fp_to_sint vf32:$val)),
            (vi64 (VCVTLDvl RD_RZ,
                            (VCVTDSvl $val, (VLEN length)),
                            (VLEN length)))>;
  def : Pat<(vi32 (fp_to_sint vf64:$val)),
            (vi32 (VCVTWDZXvl RD_RZ, $val, (VLEN length)))>;
  def : Pat<(vi32 (fp_to_sint vf32:$val)),
            (vi32 (VCVTWSZXvl RD_RZ, $val, (VLEN length)))>;
}

let Predicates = [IsSimdSubTarget] in {
  defm : simd_f2i<256>;
  defm : simd_f2i<128>;
  defm : simd_f2i<64>;
  defm : simd_f2i<32>;
  defm : simd_f2i<16>;
  defm : simd_f2i<8>;
  defm : simd_f2i<4>;
  defm : simd_f2i<2>;
}

// fpround and fpextend for vector types.

multiclass simd_f2f<int length> {
  defvar vf32 = !cast<ValueType>("v" # !cast<string>(length) # "f32");
  defvar vf64 = !cast<ValueType>("v" # !cast<string>(length) # "f64");

  def : Pat<(vf32 (fpround vf64:$val)),
            (vf32 (VCVTSDvl $val, (VLEN length)))>;
  def : Pat<(vf64 (fpextend vf32:$val)),
            (vf64 (VCVTDSvl $val, (VLEN length)))>;
}

let Predicates = [IsSimdSubTarget] in {
  defm : simd_f2f<256>;
  defm : simd_f2f<128>;
  defm : simd_f2f<64>;
  defm : simd_f2f<32>;
  defm : simd_f2f<16>;
  defm : simd_f2f<8>;
  defm : simd_f2f<4>;
  defm : simd_f2f<2>;
}

// sext and zext

let Predicates = [IsSimdSubTarget] in {
  def : Pat<(v512i32 (anyext v512i1:$vm)),
            (PVBRDiml_v -1, $vm, (VLEN 256), (PVBRDil 0, (VLEN 256)))>;
  def : Pat<(v512i32 (sext v512i1:$vm)),
            (PVBRDiml_v -1, $vm, (VLEN 256), (PVBRDil 0, (VLEN 256)))>;
  def : Pat<(v512i32 (zext v512i1:$vm)),
            (PVBRDrml_v (i64 0x100000001), $vm, (VLEN 256),
                (PVBRDil 0, (VLEN 256)))>;
/* FIXME: This pattern may be better result.
  def : Pat<(v512i32 (anyext v512i1:$vm)),
            (VMRGWivml 0, (PVBRDil -1, (VLEN 256)), $vm, (VLEN 256))>;
*/
}

multiclass simd_ext<int length> {
  defvar vi1 = !cast<ValueType>("v" # !cast<string>(length) # "i1");
  defvar vi32 = !cast<ValueType>("v" # !cast<string>(length) # "i32");
  defvar vi64 = !cast<ValueType>("v" # !cast<string>(length) # "i64");

  def : Pat<(vi64 (anyext vi32:$vx)),
            (VADDSWSXivl 0, $vx, (VLEN length))>;
  def : Pat<(vi64 (sext vi32:$vx)),
            (VADDSWSXivl 0, $vx, (VLEN length))>;
  def : Pat<(vi64 (zext vi32:$vx)),
            (VADDSWZXivl 0, $vx, (VLEN length))>;
  def : Pat<(vi64 (anyext vi1:$vm)),
            (VBRDiml_v -1, $vm, (VLEN length), (VBRDil 0, (VLEN length)))>;
  def : Pat<(vi64 (sext vi1:$vm)),
            (VBRDiml_v -1, $vm, (VLEN length), (VBRDil 0, (VLEN length)))>;
  def : Pat<(vi64 (zext vi1:$vm)),
            (VBRDiml_v 1, $vm, (VLEN length), (VBRDil 0, (VLEN length)))>;
  def : Pat<(vi32 (anyext vi1:$vm)),
            (VBRDLiml_v -1, $vm, (VLEN length), (VBRDLil 0, (VLEN length)))>;
  def : Pat<(vi32 (sext vi1:$vm)),
            (VBRDLiml_v -1, $vm, (VLEN length), (VBRDLil 0, (VLEN length)))>;
  def : Pat<(vi32 (zext vi1:$vm)),
            (VBRDLiml_v 1, $vm, (VLEN length), (VBRDLil 0, (VLEN length)))>;
/* FIXME: This pattern may be better result.
  def : Pat<(vi32 (anyext vi1:$vm)),
            (VMRGim 0, (VBRDLil 1, (VLEN length)), $vm, (VLEN length))>;
*/
}

let Predicates = [IsSimdSubTarget] in {
  defm : simd_ext<256>;
  defm : simd_ext<128>;
  defm : simd_ext<64>;
  defm : simd_ext<32>;
  defm : simd_ext<16>;
  defm : simd_ext<8>;
  defm : simd_ext<4>;
  defm : simd_ext<2>;
}

// Bitconvert for vector registers

let Predicates = [IsSimdSubTarget] in {
  def : Pat<(v512i32 (bitconvert v512f32:$vr)),
            (COPY_TO_REGCLASS $vr, V64)>;
  def : Pat<(v512i32 (bitconvert v256f64:$vr)),
            (COPY_TO_REGCLASS $vr, V64)>;
  def : Pat<(v512i32 (bitconvert v256i64:$vr)),
            (COPY_TO_REGCLASS $vr, V64)>;
  def : Pat<(v512f32 (bitconvert v512i32:$vr)),
            (COPY_TO_REGCLASS $vr, V64)>;
  def : Pat<(v512f32 (bitconvert v256f64:$vr)),
            (COPY_TO_REGCLASS $vr, V64)>;
  def : Pat<(v512f32 (bitconvert v256i64:$vr)),
            (COPY_TO_REGCLASS $vr, V64)>;
}

multiclass simd_bitconv<int length> {
  defvar vi32 = !cast<ValueType>("v" # !cast<string>(length) # "i32");
  defvar vi64 = !cast<ValueType>("v" # !cast<string>(length) # "i64");
  defvar vf32 = !cast<ValueType>("v" # !cast<string>(length) # "f32");
  defvar vf64 = !cast<ValueType>("v" # !cast<string>(length) # "f64");

  def : Pat<(vf64 (bitconvert vi64:$vi)),
            (COPY_TO_REGCLASS $vi, V64)>;
  def : Pat<(vi64 (bitconvert vf64:$vf)),
            (COPY_TO_REGCLASS $vf, V64)>;
  def : Pat<(vf32 (bitconvert vi32:$vi)),
            (vf32 (VSLLvil $vi, 32, (VLEN length)))>;
  def : Pat<(vi32 (bitconvert vf32:$vi)),
            (vi32 (VSRLvil $vi, 32, (VLEN length)))>;
}

let Predicates = [IsSimdSubTarget] in {
  defm : simd_bitconv<256>;
  defm : simd_bitconv<128>;
  defm : simd_bitconv<64>;
  defm : simd_bitconv<32>;
  defm : simd_bitconv<16>;
  defm : simd_bitconv<8>;
  defm : simd_bitconv<4>;
  defm : simd_bitconv<2>;
}

// Bitconvert from i64 to v2i32/v2f32

/*
let Predicates = [IsSimdSubTarget] in {
  def : Pat<(v2i32 (bitconvert i64:$v)),
            (LSVi (LSVi (v2i32 (IMPLICIT_DEF)), 0, (ANDrm0 $v, 32)),
                  1, (SRLri $v, 32))>;
  def : Pat<(v2f32 (bitconvert i64:$v)),
            (LSVi (LSVi (v2i32 (IMPLICIT_DEF)), 0, (SLLri $v, 32)),
                  1, (ANDrm1 $v, 32))>;
}
*/

// Bitconvert for mask registers between
// v4i64 or v8i64 and v256i1 or v512i1 respectively

/*
let Predicates = [IsSimdSubTarget] in {
  def : Pat<(v256i1 (bitconvert v4i64:$v)),
            (v256i1 (V2VM (COPY_TO_REGCLASS $v, V64)))>;

  def : Pat<(v4i64 (bitconvert v256i1:$vm)),
            (v4i64 (COPY_TO_REGCLASS (v4i64 (VM2V $vm)), V64))>;

  def : Pat<(v512i1 (bitconvert v8i64:$v)),
            (v512i1 (V2VMP (COPY_TO_REGCLASS $v, V64)))>;

  def : Pat<(v8i64 (bitconvert v512i1:$vmp)),
            (v8i64 (COPY_TO_REGCLASS (v8i64 (VMP2V $vmp)), V64))>;
}
*/

// Series of SCALAR_TO_VECTOR for all VE vector types,
//
// NOTE: Need to shift i32 for v512i32 since v512i32 uses
//       upper 32 bits (0..31) first.

let Predicates = [IsSimdSubTarget] in {
  def: Pat<(v512i32 (scalar_to_vector i32:$val)),
           (LSVir 0, (SLLri (i2l $val), 32))>;
  def: Pat<(v512f32 (scalar_to_vector f32:$val)),
           (LSVir 0, (f2l $val))>;
}

multiclass simd_s2v<int length> {
  defvar vi32 = !cast<ValueType>("v" # !cast<string>(length) # "i32");
  defvar vi64 = !cast<ValueType>("v" # !cast<string>(length) # "i64");
  defvar vf32 = !cast<ValueType>("v" # !cast<string>(length) # "f32");
  defvar vf64 = !cast<ValueType>("v" # !cast<string>(length) # "f64");

  def: Pat<(vi32 (scalar_to_vector i32:$val)),
           (LSVir 0, (i2l $val))>;
  def: Pat<(vi64 (scalar_to_vector i64:$val)),
           (LSVir 0, $val)>;
  def: Pat<(vf32 (scalar_to_vector f32:$val)),
           (LSVir 0, (f2l $val))>;
  def: Pat<(vf64 (scalar_to_vector f64:$val)),
           (LSVir 0, (COPY_TO_REGCLASS $val, I64))>;
}

let Predicates = [IsSimdSubTarget] in {
  defm : simd_s2v<256>;
  defm : simd_s2v<128>;
  defm : simd_s2v<64>;
  defm : simd_s2v<32>;
  defm : simd_s2v<16>;
  defm : simd_s2v<8>;
  defm : simd_s2v<4>;
  defm : simd_s2v<2>;
}

// Series of INSERT_VECOR_ELT for all VE vector types,
// v512i32 and v512f32 is expanded by LowerINSERT_VECTOR_ELT().

multiclass simd_ive<int length> {
  defvar vi32 = !cast<ValueType>("v" # !cast<string>(length) # "i32");
  defvar vi64 = !cast<ValueType>("v" # !cast<string>(length) # "i64");
  defvar vf32 = !cast<ValueType>("v" # !cast<string>(length) # "f32");
  defvar vf64 = !cast<ValueType>("v" # !cast<string>(length) # "f64");

  def: Pat<(vi32 (insertelt vi32:$vec, i32:$val, uimm7:$idx)),
           (LSVir_v (LO7 $idx), (i2l $val), $vec)>;
  def: Pat<(vi32 (insertelt vi32:$vec, i32:$val, i64:$idx)),
           (LSVrr_v $idx, (i2l $val), $vec)>;
  def: Pat<(vi64 (insertelt vi64:$vec, i64:$val, uimm7:$idx)),
           (LSVir_v (LO7 $idx), $val, $vec)>;
  def: Pat<(vi64 (insertelt vi64:$vec, i64:$val, i64:$idx)),
           (LSVrr_v $idx, $val, $vec)>;
  def: Pat<(vf32 (insertelt vf32:$vec, f32:$val, uimm7:$idx)),
           (LSVir_v (LO7 $idx), (f2l $val), $vec)>;
  def: Pat<(vf32 (insertelt vf32:$vec, f32:$val, i64:$idx)),
           (LSVrr_v $idx, (f2l $val), $vec)>;
  def: Pat<(vf64 (insertelt vf64:$vec, f64:$val, uimm7:$idx)),
           (LSVir_v (LO7 $idx), $val, $vec)>;
  def: Pat<(vf64 (insertelt vf64:$vec, f64:$val, i64:$idx)),
           (LSVrr_v $idx, $val, $vec)>;
}

let Predicates = [IsSimdSubTarget] in {
  defm : simd_ive<256>;
  defm : simd_ive<128>;
  defm : simd_ive<64>;
  defm : simd_ive<32>;
  defm : simd_ive<16>;
  defm : simd_ive<8>;
  defm : simd_ive<4>;
  defm : simd_ive<2>;
}

// Series of EXTRACT_VECOR_ELT for all VE vector types,
// v512i32 and v512f32 is expanded by LowerEXTRACT_VECTOR_ELT().

multiclass simd_eve<int length> {
  defvar vi32 = !cast<ValueType>("v" # !cast<string>(length) # "i32");
  defvar vi64 = !cast<ValueType>("v" # !cast<string>(length) # "i64");
  defvar vf32 = !cast<ValueType>("v" # !cast<string>(length) # "f32");
  defvar vf64 = !cast<ValueType>("v" # !cast<string>(length) # "f64");

  def: Pat<(i32 (extractelt vi32:$vec, uimm7:$idx)),
           (l2i (LVSvi vi32:$vec, (LO7 $idx)))>;
  def: Pat<(i32 (extractelt vi32:$vec, i64:$idx)),
           (l2i (LVSvr vi32:$vec, $idx))>;
  def: Pat<(i64 (extractelt vi64:$vec, uimm7:$idx)),
           (LVSvi vi64:$vec, (LO7 $idx))>;
  def: Pat<(i64 (extractelt vi64:$vec, i64:$idx)),
           (LVSvr vi64:$vec, $idx)>;
  def: Pat<(f32 (extractelt vf32:$vec, uimm7:$idx)),
           (l2f (LVSvi vf32:$vec, (LO7 $idx)))>;
  def: Pat<(f32 (extractelt vf32:$vec, i64:$idx)),
           (l2f (LVSvr vf32:$vec, $idx))>;
  def: Pat<(f64 (extractelt vf64:$vec, uimm7:$idx)),
           (LVSvi vf64:$vec, (LO7 $idx))>;
  def: Pat<(f64 (extractelt vf64:$vec, i64:$idx)),
           (LVSvr vf64:$vec, $idx)>;
}

let Predicates = [IsSimdSubTarget] in {
  defm : simd_eve<256>;
  defm : simd_eve<128>;
  defm : simd_eve<64>;
  defm : simd_eve<32>;
  defm : simd_eve<16>;
  defm : simd_eve<8>;
  defm : simd_eve<4>;
  defm : simd_eve<2>;
}

/*
def vec_scatter   : SDNode<"VEISD::VEC_SCATTER", SDTypeProfile<0, 2, [SDTCisVec<0>, SDTCisVec<1>]>, [SDNPHasChain, SDNPMayStore, SDNPMemOperand]>;
def vec_gather   : SDNode<"VEISD::VEC_GATHER", SDTypeProfile<1, 1, [SDTCisVec<0>, SDTCisVec<1>]>, [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;

def vec_lvl   : SDNode<"VEISD::VEC_LVL", SDTypeProfile<0, 1, []>, [SDNPHasChain]>;

def vec_rotate   : SDNode<"VEISD::VEC_VMV", SDTypeProfile<1, 2, []>>;
def : Pat<(v256f64 (vec_rotate i32:$sy, v256f64:$vz)),
          (VMVr i32:$sy, v256f64:$vz,
                (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
def : Pat<(v256f64 (vec_rotate (i32 simm7:$I), v256f64:$vz)),
          (VMVi (i32 simm7:$I), v256f64:$vz,
                (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
*/

// Shuffle
// TODO

// Scatter
/*
let Predicates = [IsSimdSubTarget] in {
  def : Pat<(vec_scatter v256i64:$vx, v256i64:$vy),
            (VSCv v256i64:$vx, v256i64:$vy,
                  (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
  def : Pat<(vec_scatter v256f64:$vx, v256i64:$vy),
            (VSCv v256f64:$vx, v256i64:$vy,
                  (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
}
*/

//// Gather
/*
let Predicates = [IsSimdSubTarget] in {
  def : Pat<(v256i64 (vec_gather v256i64:$vy)),
            (VGTv v256i64:$vy,
                  (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
  def : Pat<(v256f64 (vec_gather v256i64:$vy)),
            (VGTv v256i64:$vy,
                  (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
}
*/

// LVL
/*
def : Pat<(vec_lvl i32:$sy), (LVL i32:$sy)>;
*/

// Broadcast

let Predicates = [IsSimdSubTarget] in {
  def: Pat<(v512i32 (vec_broadcast i32:$val, (i32 512))),
           (PVBRDrl
              (ORrr (SLLri (i2l $val), 32), (ANDrm (i2l $val), !add(32, 64))),
              (VLEN 256))>;
  def: Pat<(v512f32 (vec_broadcast f32:$val, (i32 512))),
           (PVBRDrl
              (ORrr (f2l $val), (SRLri (f2l $val), 32)),
              (VLEN 256))>;
}

multiclass simd_vbrd<int length> {
  defvar vi32 = !cast<ValueType>("v" # !cast<string>(length) # "i32");
  defvar vi64 = !cast<ValueType>("v" # !cast<string>(length) # "i64");
  defvar vf32 = !cast<ValueType>("v" # !cast<string>(length) # "f32");
  defvar vf64 = !cast<ValueType>("v" # !cast<string>(length) # "f64");

  def : Pat<(vi32 (vec_broadcast i32:$val, (i32 length))),
            (VBRDLrl $val, (VLEN length))>;
  def : Pat<(vf32 (vec_broadcast f32:$val, (i32 length))),
            (VBRDUrl $val, (VLEN length))>;
  def : Pat<(vi64 (vec_broadcast i64:$val, (i32 length))),
            (VBRDrl $val, (VLEN length))>;
  def : Pat<(vf64 (vec_broadcast f64:$val, (i32 length))),
            (VBRDrl $val, (VLEN length))>;
}

let Predicates = [IsSimdSubTarget] in {
  defm : simd_vbrd<256>;
  defm : simd_vbrd<128>;
  defm : simd_vbrd<64>;
  defm : simd_vbrd<32>;
  defm : simd_vbrd<16>;
  defm : simd_vbrd<8>;
  defm : simd_vbrd<4>;
  defm : simd_vbrd<2>;
}

// Condition Code
/*
let Predicates = [IsSimdSubTarget] in {
  def : Pat<(v512i1 (setcc v512f32:$l, v512f32:$r, cond:$cond)),
            (INSERT_SUBREG (INSERT_SUBREG (v512i1 (IMPLICIT_DEF)),
                (VFMFsv (fcond2cc $cond),
                        (VFCPpv $l, $r, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                        (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                sub_vm_even),
                (VFMFlv (fcond2cc $cond),
                        (VFCPpv $l, $r, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                        (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                sub_vm_odd)>;
  def : Pat<(v512i1 (setcc v512i32:$l, v512i32:$r, CCSIOp:$cond)),
            (INSERT_SUBREG (INSERT_SUBREG (v512i1 (IMPLICIT_DEF)),
                (VFMSuv (icond2cc $cond),
                        (VCPSpv $l, $r, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                        (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                sub_vm_even),
                (VFMSv  (icond2cc $cond),
                        (VCPSpv $l, $r, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                        (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                sub_vm_odd)>;
  def : Pat<(v512i1 (setcc v512i32:$l, v512i32:$r, CCUIOp:$cond)),
            (INSERT_SUBREG (INSERT_SUBREG (v512i1 (IMPLICIT_DEF)),
                (VFMSuv (icond2cc $cond),
                        (VCMPpv $l, $r, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                        (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                sub_vm_even),
                (VFMSv  (icond2cc $cond),
                        (VCMPpv $l, $r, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                        (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                sub_vm_odd)>;
  def : Pat<(v512i32 (setcc v512f32:$l, v512f32:$r, cond:$cond)),
            (v512i32 (VMRGpim 0, (v512i32 (VBRDi -1,
                        (COPY_TO_REGCLASS (LEAzzi 256), VLS))),
            (INSERT_SUBREG (INSERT_SUBREG (v512i1 (IMPLICIT_DEF)),
                (VFMFsv (fcond2cc $cond),
                        (VFCPpv $l, $r, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                        (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                sub_vm_even),
                (VFMFlv (fcond2cc $cond),
                        (VFCPpv $l, $r, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                        (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                sub_vm_odd),
                              (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;
  def : Pat<(v512i32 (setcc v512i32:$l, v512i32:$r, CCSIOp:$cond)),
            (v512i32 (VMRGpim 0, (v512i32 (VBRDi -1,
                        (COPY_TO_REGCLASS (LEAzzi 256), VLS))),
            (INSERT_SUBREG (INSERT_SUBREG (v512i1 (IMPLICIT_DEF)),
                (VFMSuv (icond2cc $cond),
                        (VCPSpv $l, $r, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                        (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                sub_vm_even),
                (VFMSv  (icond2cc $cond),
                        (VCPSpv $l, $r, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                        (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                sub_vm_odd),
                              (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;
  def : Pat<(v512i32 (setcc v512i32:$l, v512i32:$r, CCUIOp:$cond)),
            (v512i32 (VMRGpim 0, (v512i32 (VBRDi -1,
                        (COPY_TO_REGCLASS (LEAzzi 256), VLS))),
            (INSERT_SUBREG (INSERT_SUBREG (v512i1 (IMPLICIT_DEF)),
                (VFMSuv (icond2cc $cond),
                        (VCMPpv $l, $r, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                        (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                sub_vm_even),
                (VFMSv  (icond2cc $cond),
                        (VCMPpv $l, $r, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                        (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                sub_vm_odd),
                              (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;
}

multiclass simd_setcc<int length, ValueType vi32, ValueType vi64,
                                   ValueType vf32, ValueType vf64,
                                   ValueType vi1> {
  def : Pat<(vi1 (setcc vf64:$l, vf64:$r, cond:$cond)),
            (vi1 (VFMFdv (fcond2cc $cond),
                    (VFCPdv $l, $r, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
                    (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
  def : Pat<(vi1 (setcc vi64:$l, vi64:$r, CCSIOp:$cond)),
            (vi1 (VFMSv  (icond2cc $cond),
                    (VCPXlv $l, $r, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
                    (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
  def : Pat<(vi1 (setcc vi64:$l, vi64:$r, CCUIOp:$cond)),
            (vi1 (VFMSv  (icond2cc $cond),
                    (VCMPlv $l, $r, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
                    (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
  def : Pat<(vi64 (setcc vf64:$l, vf64:$r, cond:$cond)),
            (vi64 (VMRGim 0, (vi64 (VBRDi 1,
                      (COPY_TO_REGCLASS (LEAzzi length), VLS))),
            (vi1 (VFMFdv (fcond2cc $cond),
                    (VFCPdv $l, $r, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))),
                    (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
  def : Pat<(vi64 (setcc vi64:$l, vi64:$r, CCSIOp:$cond)),
            (vi64 (VMRGim 0, (vi64 (VBRDi 1,
                      (COPY_TO_REGCLASS (LEAzzi length), VLS))),
            (vi1 (VFMSv  (icond2cc $cond),
                    (VCPXlv $l, $r, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))),
                    (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
  def : Pat<(vi64 (setcc vi64:$l, vi64:$r, CCUIOp:$cond)),
            (vi64 (VMRGim 0, (vi64 (VBRDi 1,
                      (COPY_TO_REGCLASS (LEAzzi length), VLS))),
            (vi1 (VFMSv  (icond2cc $cond),
                    (VCMPlv $l, $r, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))),
                    (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
  def : Pat<(vi1 (setcc vf32:$l, vf32:$r, cond:$cond)),
            (vi1 (VFMFsv (fcond2cc $cond),
                    (VFCPsv $l, $r, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
                    (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
  def : Pat<(vi1 (setcc vi32:$l, vi32:$r, CCSIOp:$cond)),
            (vi1 (VFMSv  (icond2cc $cond),
                    (VCPSwsxv $l, $r, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
                    (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
  def : Pat<(vi1 (setcc vi32:$l, vi32:$r, CCUIOp:$cond)),
            (vi1 (VFMSv  (icond2cc $cond),
                    (VCMPwv $l, $r, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
                    (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
  def : Pat<(vi32 (setcc vf32:$l, vf32:$r, cond:$cond)),
            (vi32 (VMRGim 0, (vi32 (VBRDi 1,
                      (COPY_TO_REGCLASS (LEAzzi length), VLS))),
            (vi1 (VFMFsv (fcond2cc $cond),
                    (VFCPsv $l, $r, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))),
                    (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
  def : Pat<(vi32 (setcc vi32:$l, vi32:$r, CCSIOp:$cond)),
            (vi32 (VMRGim 0, (vi32 (VBRDi 1,
                      (COPY_TO_REGCLASS (LEAzzi length), VLS))),
            (vi1 (VFMSv  (icond2cc $cond),
                    (VCPSwsxv $l, $r, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))),
                    (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
  def : Pat<(vi32 (setcc vi32:$l, vi32:$r, CCUIOp:$cond)),
            (vi32 (VMRGim 0, (vi32 (VBRDi 1,
                      (COPY_TO_REGCLASS (LEAzzi length), VLS))),
            (vi1 (VFMSv  (icond2cc $cond),
                    (VCMPwv $l, $r, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))),
                    (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
}

let Predicates = [IsSimdSubTarget] in {
  defm : simd_setcc<256, v256i32, v256i64, v256f32, v256f64, v256i1>;
  defm : simd_setcc<128, v128i32, v128i64, v128f32, v128f64, v128i1>;
  defm : simd_setcc<64, v64i32, v64i64, v64f32, v64f64, v64i1>;
  defm : simd_setcc<32, v32i32, v32i64, v32f32, v32f64, v32i1>;
  defm : simd_setcc<16, v16i32, v16i64, v16f32, v16f64, v16i1>;
  defm : simd_setcc<8, v8i32, v8i64, v8f32, v8f64, v8i1>;
  defm : simd_setcc<4, v4i32, v4i64, v4f32, v4f64, v4i1>;
  defm : simd_setcc<2, v2i32, v2i64, v2f32, v2f64, v2i1>;
}

let Predicates = [IsSimdSubTarget] in {
  def : Pat<(setcc v256i64:$vx, v256i64:$vy, CCSIOp:$cond),
            (v256i1 (VFMKv (icond2cc $cond),
                           (VCMPlv v256i64:$vx, v256i64:$vy,
                                    (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                           (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;

  def : Pat<(setcc v256f64:$vx, v256f64:$vy, CCSIOp:$cond),
            (v256i1 (VFMKv (fcond2cc $cond),
                           (VCMPwv v256f64:$vx, v256f64:$vy,
                                   (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                           (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;
}
*/

// Vector Select
/*
let Predicates = [IsSimdSubTarget] in {
  def : Pat<(v512f32 (vselect v512i1:$m, v512f32:$vy, v512f32:$vz)),
            (v512f32 (VMRGpvm v512f32:$vz, v512f32:$vy, v512i1:$m,
                              (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;
  def : Pat<(v512i32 (vselect v512i1:$m, v512i32:$vy, v512i32:$vz)),
            (v512i32 (VMRGpvm v512i32:$vz, v512i32:$vy, v512i1:$m,
                              (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;
}

multiclass simv_vsel<int length, ValueType vi32, ValueType vi64, ValueType vf32,
                     ValueType vf64, ValueType vi1> {
  def : Pat<(vf64 (vselect vi1:$m, vf64:$vy, vf64:$vz)),
            (vf64 (VMRGvm vf64:$vz, vf64:$vy, vi1:$m,
                          (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;
  def : Pat<(vi64 (vselect vi1:$m, vi64:$vy, vi64:$vz)),
            (vi64 (VMRGvm vi64:$vz, vi64:$vy, vi1:$m,
                          (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;
  def : Pat<(vf32 (vselect vi1:$m, vf32:$vy, vf32:$vz)),
            (vf32 (VMRGvm vf32:$vz, vf32:$vy, vi1:$m,
                          (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;
  def : Pat<(vi32 (vselect vi1:$m, vi32:$vy, vi32:$vz)),
            (vi32 (VMRGvm vi32:$vz, vi32:$vy, vi1:$m,
                          (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;
}

let Predicates = [IsSimdSubTarget] in {
  defm : simv_vsel<256, v256i32, v256i64, v256f32, v256f64, v256i1>;
  defm : simv_vsel<128, v128i32, v128i64, v128f32, v128f64, v128i1>;
  defm : simv_vsel<64, v64i32, v64i64, v64f32, v64f64, v64i1>;
  defm : simv_vsel<32, v32i32, v32i64, v32f32, v32f64, v32i1>;
  defm : simv_vsel<16, v16i32, v16i64, v16f32, v16f64, v16i1>;
  defm : simv_vsel<8, v8i32, v8i64, v8f32, v8f64, v8i1>;
  defm : simv_vsel<4, v4i32, v4i64, v4f32, v4f64, v4i1>;
  defm : simv_vsel<2, v2i32, v2i64, v2f32, v2f64, v2i1>;
}
*/

// Select
/*
let Predicates = [IsSimdSubTarget] in {
  def : Pat<(v512f32 (select i32:$pred, v512f32:$t, v512f32:$f)),
            (v512f32 (VMRGpvm v512f32:$f, v512f32:$t,
                     (INSERT_SUBREG (INSERT_SUBREG (v512i1 (IMPLICIT_DEF)),
                (VFMSv CC_INE,
                  (VBRDi32r i32:$pred, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                  (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                sub_vm_even),
                (VFMSv CC_INE,
                  (VBRDi32r i32:$pred, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                  (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                sub_vm_odd),
                     (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;
  def : Pat<(v512i32 (select i32:$pred, v512i32:$t, v512i32:$f)),
            (v512i32 (VMRGpvm v512i32:$f, v512i32:$t,
                     (INSERT_SUBREG (INSERT_SUBREG (v512i1 (IMPLICIT_DEF)),
                (VFMSv CC_INE,
                  (VBRDi32r i32:$pred, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                  (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                sub_vm_even),
                (VFMSv CC_INE,
                  (VBRDi32r i32:$pred, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                  (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
                sub_vm_odd),
                     (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;
}

multiclass simd_sel<int length, ValueType vi32, ValueType vi64, ValueType vf32,
                    ValueType vf64, ValueType vi1> {
  def : Pat<(vi64 (select i32:$pred, vi64:$t, vi64:$f)),
            (vi64 (VMRGvm vi64:$f, vi64:$t,
                     (vi1 (VFMSv CC_INE,
                  (VBRDi32r i32:$pred, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
                  (COPY_TO_REGCLASS (LEAzzi length), VLS))),
                     (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
  def : Pat<(vi32 (select i32:$pred, vi32:$t, vi32:$f)),
            (vi32 (VMRGvm vi32:$f, vi32:$t,
                     (vi1 (VFMSv CC_INE,
                  (VBRDi32r i32:$pred, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
                  (COPY_TO_REGCLASS (LEAzzi length), VLS))),
                     (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
  def : Pat<(vf64 (select i32:$pred, vf64:$t, vf64:$f)),
            (vf64 (VMRGvm vf64:$f, vf64:$t,
                     (vi1 (VFMSv CC_INE,
                  (VBRDi32r i32:$pred, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
                  (COPY_TO_REGCLASS (LEAzzi length), VLS))),
                     (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
  def : Pat<(vf32 (select i32:$pred, vf32:$t, vf32:$f)),
            (vf32 (VMRGvm vf32:$f, vf32:$t,
                     (vi1 (VFMSv CC_INE,
                  (VBRDi32r i32:$pred, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
                  (COPY_TO_REGCLASS (LEAzzi length), VLS))),
                     (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
}

let Predicates = [IsSimdSubTarget] in {
  defm : simd_sel<256, v256i32, v256i64, v256f32, v256f64, v256i1>;
  defm : simd_sel<128, v128i32, v128i64, v128f32, v128f64, v128i1>;
  defm : simd_sel<64, v64i32, v64i64, v64f32, v64f64, v64i1>;
  defm : simd_sel<32, v32i32, v32i64, v32f32, v32f64, v32i1>;
  defm : simd_sel<16, v16i32, v16i64, v16f32, v16f64, v16i1>;
  defm : simd_sel<8, v8i32, v8i64, v8f32, v8f64, v8i1>;
  defm : simd_sel<4, v4i32, v4i64, v4f32, v4f64, v4i1>;
  defm : simd_sel<2, v2i32, v2i64, v2f32, v2f64, v2i1>;
}
*/

// Sequence
let Predicates = [IsSimdSubTarget] in {
  def : Pat<(v512i32 (vec_seq (i32 1))), (PVSEQl (VLEN 256))>;
}

multiclass simd_vseq<int length> {
  defvar vi32 = !cast<ValueType>("v" # !cast<string>(length) # "i32");
  defvar vi64 = !cast<ValueType>("v" # !cast<string>(length) # "i64");

  def : Pat<(vi32 (vec_seq (i32 1))),
            (PVSEQLOl (VLEN length))>;
  def : Pat<(vi64 (vec_seq (i64 1))),
            (VSEQl (VLEN length))>;
}

let Predicates = [IsSimdSubTarget] in {
  defm : simd_vseq<256>;
  defm : simd_vseq<128>;
  defm : simd_vseq<64>;
  defm : simd_vseq<32>;
  defm : simd_vseq<16>;
  defm : simd_vseq<8>;
  defm : simd_vseq<4>;
  defm : simd_vseq<2>;
}

// Double-Precision Arithmetic
//
// fadd, fsub, fmul, and fdiv for all floating point vector types.
/*
let Predicates = [IsSimdSubTarget] in {
  def : Pat<(fadd v512f32:$vy, v512f32:$vz),
            (VFADpv v512f32:$vy, v512f32:$vz,
                    (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
  def : Pat<(fsub v512f32:$vy, v512f32:$vz),
            (VFSBpv v512f32:$vy, v512f32:$vz,
                    (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
  def : Pat<(fmul v512f32:$vy, v512f32:$vz),
            (VFMPpv v512f32:$vy, v512f32:$vz,
                    (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
  def : Pat<(fdiv v512f32:$vy, v512f32:$vz),
            (VFDVpv v512f32:$vy, v512f32:$vz,
                    (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
}
*/
let Predicates = [IsSimdSubTarget] in {
  def : Pat<(fadd (vec_broadcast f32:$val, (i32 512)), v512f32:$vz),
            (PVFADDrvl
              (ORrr (f2l $val), (SRLri (f2l $val), 32)),
              $vz, (VLEN 256))>;
  def : Pat<(fsub (vec_broadcast f32:$val, (i32 512)), v512f32:$vz),
            (PVFSUBrvl
              (ORrr (f2l $val), (SRLri (f2l $val), 32)),
              $vz, (VLEN 256))>;
  def : Pat<(fmul (vec_broadcast f32:$val, (i32 512)), v512f32:$vz),
            (PVFMULrvl
              (ORrr (f2l $val), (SRLri (f2l $val), 32)),
              $vz, (VLEN 256))>;
/*
  def : Pat<(fdiv (vec_broadcast f32:$val), v512f32:$vz),
            (VFDVpr
              (ORrr (f2l $val), (SRLri (f2l $val), 32)),
              v512f32:$vz, (LEA32zzi 256))>;
*/
}

multiclass simd_farith<int length, ValueType vf32, ValueType vf64> {
  def : Pat<(fadd vf32:$vy, vf32:$vz),
            (VFADDSvvl vf32:$vy, vf32:$vz, (VLEN length))>;
  def : Pat<(fadd vf64:$vy, vf64:$vz),
            (VFADDDvvl vf64:$vy, vf64:$vz, (VLEN length))>;
  def : Pat<(fadd (vf32 (vec_broadcast f32:$sy, (i32 length))), vf32:$vz),
            (VFADDSrvl f32:$sy, vf32:$vz, (VLEN length))>;
  def : Pat<(fadd (vf64 (vec_broadcast f64:$sy, (i32 length))), vf64:$vz),
            (VFADDDrvl f64:$sy, vf64:$vz, (VLEN length))>;
  def : Pat<(fsub vf32:$vy, vf32:$vz),
            (VFSUBSvvl vf32:$vy, vf32:$vz, (VLEN length))>;
  def : Pat<(fsub vf64:$vy, vf64:$vz),
            (VFSUBDvvl vf64:$vy, vf64:$vz, (VLEN length))>;
  def : Pat<(fsub (vf32 (vec_broadcast f32:$sy, (i32 length))), vf32:$vz),
            (VFSUBSrvl f32:$sy, vf32:$vz, (VLEN length))>;
  def : Pat<(fsub (vf64 (vec_broadcast f64:$sy, (i32 length))), vf64:$vz),
            (VFSUBDrvl f64:$sy, vf64:$vz, (VLEN length))>;
  def : Pat<(fmul vf32:$vy, vf32:$vz),
            (VFMULSvvl vf32:$vy, vf32:$vz, (VLEN length))>;
  def : Pat<(fmul vf64:$vy, vf64:$vz),
            (VFMULDvvl vf64:$vy, vf64:$vz, (VLEN length))>;
  def : Pat<(fmul (vf32 (vec_broadcast f32:$sy, (i32 length))), vf32:$vz),
            (VFMULSrvl f32:$sy, vf32:$vz, (VLEN length))>;
  def : Pat<(fmul (vf64 (vec_broadcast f64:$sy, (i32 length))), vf64:$vz),
            (VFMULDrvl f64:$sy, vf64:$vz, (VLEN length))>;
  def : Pat<(fdiv vf32:$vy, vf32:$vz),
            (VFDIVSvvl vf32:$vy, vf32:$vz, (VLEN length))>;
  def : Pat<(fdiv vf64:$vy, vf64:$vz),
            (VFDIVDvvl vf64:$vy, vf64:$vz, (VLEN length))>;
  def : Pat<(fdiv (vf32 (vec_broadcast f32:$sy, (i32 length))), vf32:$vz),
            (VFDIVSrvl f32:$sy, vf32:$vz, (VLEN length))>;
  def : Pat<(fdiv (vf64 (vec_broadcast f64:$sy, (i32 length))), vf64:$vz),
            (VFDIVDrvl f64:$sy, vf64:$vz, (VLEN length))>;
}

let Predicates = [IsSimdSubTarget] in {
  defm : simd_farith<256, v256f32, v256f64>;
  defm : simd_farith<128, v128f32, v128f64>;
  defm : simd_farith<64, v64f32, v64f64>;
  defm : simd_farith<32, v32f32, v32f64>;
  defm : simd_farith<16, v16f32, v16f64>;
  defm : simd_farith<8, v8f32, v8f64>;
  defm : simd_farith<4, v4f32, v4f64>;
  defm : simd_farith<2, v2f32, v2f64>;
}

// fneg for all floating point vector types.
/*
let Predicates = [IsSimdSubTarget] in {
  def : Pat<(fneg v512f32:$vz),
            (VFSBpi 0, v512f32:$vz,
                    (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
}

multiclass simd_fneg<int length, ValueType vf32, ValueType vf64> {
  def : Pat<(fneg vf32:$vz),
            (VFSBsi 0, vf32:$vz,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(fneg vf64:$vz),
            (VFSBdi 0, vf64:$vz,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
}

let Predicates = [IsSimdSubTarget] in {
  defm : simd_fneg<256, v256f32, v256f64>;
  defm : simd_fneg<128, v128f32, v128f64>;
  defm : simd_fneg<64, v64f32, v64f64>;
  defm : simd_fneg<32, v32f32, v32f64>;
  defm : simd_fneg<16, v16f32, v16f64>;
  defm : simd_fneg<8, v8f32, v8f64>;
  defm : simd_fneg<4, v4f32, v4f64>;
  defm : simd_fneg<2, v2f32, v2f64>;
}
*/

// fma for all floating point vector types.
let Predicates = [IsSimdSubTarget] in {
  def : Pat<(fma v512f32:$vz, v512f32:$vw, (v512f32 (fneg v512f32:$vy))),
            (PVFMSBvvvl v512f32:$vy, v512f32:$vz, v512f32:$vw, (VLEN 256))>;
  def : Pat<(fma (v512f32 (vec_broadcast f32:$sy, (i32 512))),
                 v512f32:$vw, v512f32:$vy),
            (PVFMADvrvl v512f32:$vy, (ORrr (f2l $sy), (SRLri (f2l $sy), 32)),
                        v512f32:$vw,
                        (VLEN 256))>;
  def : Pat<(fma v512f32:$vw, (v512f32 (vec_broadcast f32:$sy, (i32 512))),
                 v512f32:$vy),
            (PVFMADvrvl v512f32:$vy, (ORrr (f2l $sy), (SRLri (f2l $sy), 32)),
                        v512f32:$vw,
                        (VLEN 256))>;
  def : Pat<(fma v512f32:$vz, v512f32:$vw,
                 (v512f32 (vec_broadcast f32:$sy, (i32 512)))),
            (PVFMADrvvl (ORrr (f2l $sy), (SRLri (f2l $sy), 32)),
                        v512f32:$vz, v512f32:$vw,
                        (VLEN 256))>;
  def : Pat<(fma v512f32:$vz, v512f32:$vw, v512f32:$vy),
            (PVFMADvvvl v512f32:$vy, v512f32:$vz, v512f32:$vw, (VLEN 256))>;
}

multiclass simd_fma<int length, ValueType vf32, ValueType vf64> {
/*
  def : Pat<(fma vf64:$vz, vf64:$vw, (vf64 (fneg vf64:$vy))),
            (VFMSBdv vf64:$vy, vf64:$vz, vf64:$vw,
                     (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
*/
  def : Pat<(fma (vf64 (vec_broadcast f64:$sy, (i32 length))),
                 vf64:$vw, vf64:$vy),
            (VFMADDvrvl vf64:$vy, f64:$sy, vf64:$vw, (VLEN length))>;
  def : Pat<(fma vf64:$vw, (vf64 (vec_broadcast f64:$sy, (i32 length))),
                 vf64:$vy),
            (VFMADDvrvl vf64:$vy, f64:$sy, vf64:$vw, (VLEN length))>;
  def : Pat<(fma vf64:$vz, vf64:$vw,
                 (vf64 (vec_broadcast f64:$sy, (i32 length)))),
            (VFMADDrvvl f64:$sy, vf64:$vz, vf64:$vw, (VLEN length))>;
  def : Pat<(fma vf64:$vz, vf64:$vw, vf64:$vy),
            (VFMADDvvvl vf64:$vy, vf64:$vz, vf64:$vw, (VLEN length))>;
/*
  def : Pat<(fma vf32:$vz, vf32:$vw, (vf32 (fneg vf32:$vy))),
            (VFMSBsv vf32:$vy, vf32:$vz, vf32:$vw,
                     (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
*/
  def : Pat<(fma (vf32 (vec_broadcast f32:$sy, (i32 length))),
                 vf32:$vw, vf32:$vy),
            (VFMADSvrvl vf32:$vy, f32:$sy, vf32:$vw, (VLEN length))>;
  def : Pat<(fma vf32:$vw, (vf32 (vec_broadcast f32:$sy, (i32 length))),
                 vf32:$vy),
            (VFMADSvrvl vf32:$vy, f32:$sy, vf32:$vw, (VLEN length))>;
  def : Pat<(fma vf32:$vz, vf32:$vw,
                 (vf32 (vec_broadcast f32:$sy, (i32 length)))),
            (VFMADSrvvl f32:$sy, vf32:$vz, vf32:$vw, (VLEN length))>;
  def : Pat<(fma vf32:$vz, vf32:$vw, vf32:$vy),
            (VFMADSvvvl vf32:$vy, vf32:$vz, vf32:$vw, (VLEN length))>;
}

let Predicates = [IsSimdSubTarget] in {
  defm : simd_fma<256, v256f32, v256f64>;
  defm : simd_fma<128, v128f32, v128f64>;
  defm : simd_fma<64, v64f32, v64f64>;
  defm : simd_fma<32, v32f32, v32f64>;
  defm : simd_fma<16, v16f32, v16f64>;
  defm : simd_fma<8, v8f32, v8f64>;
  defm : simd_fma<4, v4f32, v4f64>;
  defm : simd_fma<2, v2f32, v2f64>;
}

// Integer Arithmetic
//
// add and sub for v512i32
// add, sub, mul, sdiv, and udiv for other integer vector types.

let Predicates = [IsSimdSubTarget] in {
/*
  def : Pat<(add v512i32:$vy, v512i32:$vz),
            (VADSpv v512i32:$vy, v512i32:$vz,
                    (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
  def : Pat<(sub v512i32:$vy, v512i32:$vz),
            (VSBSpv v512i32:$vy, v512i32:$vz,
                    (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
*/
  def : Pat<(add (vec_broadcast i32:$val, (i32 512)), v512i32:$vz),
            (PVADDSrvl
              (ORrr (SLLri (i2l $val), 32), (ANDrm (i2l $val), !add(32, 64))),
              v512i32:$vz, (VLEN 256))>;
  def : Pat<(sub (vec_broadcast i32:$val, (i32 512)), v512i32:$vz),
            (PVSUBSrvl
              (ORrr (SLLri (i2l $val), 32), (ANDrm (i2l $val), !add(32, 64))),
              v512i32:$vz, (VLEN 256))>;
}

multiclass simd_arith<int length, ValueType vi32, ValueType vi64> {
  def : Pat<(add vi32:$vy, vi32:$vz),
            (VADDSWSXvvl vi32:$vy, vi32:$vz, (VLEN length))>;
  def : Pat<(add vi64:$vy, vi64:$vz),
            (VADDSLvvl vi64:$vy, vi64:$vz, (VLEN length))>;
  def : Pat<(add (vi32 (vec_broadcast i32:$sy, (i32 length))), vi32:$vz),
            (VADDSWSXrvl i32:$sy, vi32:$vz, (VLEN length))>;
  def : Pat<(add (vi64 (vec_broadcast i64:$sy, (i32 length))), vi64:$vz),
            (VADDSLrvl i64:$sy, vi64:$vz, (VLEN length))>;
  def : Pat<(sub vi32:$vy, vi32:$vz),
            (VSUBSWSXvvl vi32:$vy, vi32:$vz, (VLEN length))>;
  def : Pat<(sub vi64:$vy, vi64:$vz),
            (VSUBSLvvl vi64:$vy, vi64:$vz, (VLEN length))>;
  def : Pat<(sub (vi32 (vec_broadcast i32:$sy, (i32 length))), vi32:$vz),
            (VSUBSWSXrvl i32:$sy, vi32:$vz, (VLEN length))>;
  def : Pat<(sub (vi64 (vec_broadcast i64:$sy, (i32 length))), vi64:$vz),
            (VSUBSLrvl i64:$sy, vi64:$vz, (VLEN length))>;
  def : Pat<(mul vi32:$vy, vi32:$vz),
            (VMULSWSXvvl vi32:$vy, vi32:$vz, (VLEN length))>;
  def : Pat<(mul vi64:$vy, vi64:$vz),
            (VMULSLvvl vi64:$vy, vi64:$vz, (VLEN length))>;
  def : Pat<(mul (vi32 (vec_broadcast i32:$sy, (i32 length))), vi32:$vz),
            (VMULSWSXrvl i32:$sy, vi32:$vz, (VLEN length))>;
  def : Pat<(mul (vi64 (vec_broadcast i64:$sy, (i32 length))), vi64:$vz),
            (VMULSLrvl i64:$sy, vi64:$vz, (VLEN length))>;
  def : Pat<(sdiv vi32:$vy, vi32:$vz),
            (VDIVSWSXvvl vi32:$vy, vi32:$vz, (VLEN length))>;
  def : Pat<(sdiv vi64:$vy, vi64:$vz),
            (VDIVSLvvl vi64:$vy, vi64:$vz, (VLEN length))>;
  def : Pat<(sdiv (vi32 (vec_broadcast i32:$sy, (i32 length))), vi32:$vz),
            (VDIVSWSXrvl i32:$sy, vi32:$vz, (VLEN length))>;
  def : Pat<(sdiv (vi64 (vec_broadcast i64:$sy, (i32 length))), vi64:$vz),
            (VDIVSLrvl i64:$sy, vi64:$vz, (VLEN length))>;
  def : Pat<(udiv vi32:$vy, vi32:$vz),
            (VDIVUWvvl vi32:$vy, vi32:$vz, (VLEN length))>;
  def : Pat<(udiv vi64:$vy, vi64:$vz),
            (VDIVULvvl vi64:$vy, vi64:$vz, (VLEN length))>;
  def : Pat<(udiv (vi32 (vec_broadcast i32:$sy, (i32 length))), vi32:$vz),
            (VDIVUWrvl i32:$sy, vi32:$vz, (VLEN length))>;
  def : Pat<(udiv (vi64 (vec_broadcast i64:$sy, (i32 length))), vi64:$vz),
            (VDIVULrvl i64:$sy, vi64:$vz, (VLEN length))>;
}

let Predicates = [IsSimdSubTarget] in {
  defm : simd_arith<256, v256i32, v256i64>;
  defm : simd_arith<128, v128i32, v128i64>;
  defm : simd_arith<64, v64i32, v64i64>;
  defm : simd_arith<32, v32i32, v32i64>;
  defm : simd_arith<16, v16i32, v16i64>;
  defm : simd_arith<8, v8i32, v8i64>;
  defm : simd_arith<4, v4i32, v4i64>;
  defm : simd_arith<2, v2i32, v2i64>;
}

// Logic
//
// and, or, and xor for v512i32
// and, or, and xor for other integer vector types.

/*
let Predicates = [IsSimdSubTarget] in {
  def : Pat<(and v512i32:$vx, v512i32:$vy),
            (VANDpv v512i32:$vx, v512i32:$vy,
                   (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
  def : Pat<(or  v512i32:$vx, v512i32:$vy),
            (VORpv v512i32:$vx, v512i32:$vy,
                  (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
  def : Pat<(xor v512i32:$vx, v512i32:$vy),
            (VXORpv v512i32:$vx, v512i32:$vy,
                   (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
}
*/

multiclass simg_logic<int length, ValueType vi32, ValueType vi64> {
/*
  def : Pat<(and vi64:$vx, vi64:$vy),
            (VANDv vi64:$vx, vi64:$vy,
                   (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(or  vi64:$vx, vi64:$vy),
            (VORv vi64:$vx, vi64:$vy,
                  (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(xor vi64:$vx, vi64:$vy),
            (VXORv vi64:$vx, vi64:$vy,
                   (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
*/
  def : Pat<(and vi32:$vx, vi32:$vy),
            (PVANDLOvvl vi32:$vx, vi32:$vy, (VLEN length))>;
/*
  def : Pat<(or  vi32:$vx, vi32:$vy),
            (VORlv vi32:$vx, vi32:$vy,
                  (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(xor vi32:$vx, vi32:$vy),
            (VXORlv vi32:$vx, vi32:$vy,
                   (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
*/
}

let Predicates = [IsSimdSubTarget] in {
  defm : simg_logic<256, v256i32, v256i64>;
  defm : simg_logic<128, v128i32, v128i64>;
  defm : simg_logic<64, v64i32, v64i64>;
  defm : simg_logic<32, v32i32, v32i64>;
  defm : simg_logic<16, v16i32, v16i64>;
  defm : simg_logic<8, v8i32, v8i64>;
  defm : simg_logic<4, v4i32, v4i64>;
  defm : simg_logic<2, v2i32, v2i64>;
}

// Shifts
//
// shl, srl, and sra for v512i32
// shl, srl, and sra for other integer vector types.

let Predicates = [IsSimdSubTarget] in {
  def : Pat<(shl v512i32:$vx, (v512i32 (vec_broadcast i32:$sy, (i32 512)))),
            (PVSLLvrl v512i32:$vx,
                     (ORrr (SLLri (i2l $sy), 32),
                           (ANDrm (i2l $sy), !add(32, 64))),
                     (VLEN 256))>;
  def : Pat<(srl v512i32:$vx, (v512i32 (vec_broadcast i32:$sy, (i32 512)))),
            (PVSRLvrl v512i32:$vx,
                     (ORrr (SLLri (i2l $sy), 32),
                           (ANDrm (i2l $sy), !add(32, 64))),
                     (VLEN 256))>;
  def : Pat<(sra v512i32:$vx, (v512i32 (vec_broadcast i32:$sy, (i32 512)))),
            (PVSRAvrl v512i32:$vx,
                     (ORrr (SLLri (i2l $sy), 32),
                           (ANDrm (i2l $sy), !add(32, 64))),
                     (VLEN 256))>;
}

/*
let Predicates = [IsSimdSubTarget] in {
  def : Pat<(shl v512i32:$vx, v512i32:$vy),
            (VSLLpv v512i32:$vx, v512i32:$vy,
                    (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
  def : Pat<(srl v512i32:$vx, v512i32:$vy),
            (VSRLpv v512i32:$vx, v512i32:$vy,
                    (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
  def : Pat<(sra v512i32:$vx, v512i32:$vy),
            (VSRApv v512i32:$vx, v512i32:$vy,
                    (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
}
*/

multiclass simd_shift<int length, ValueType vi32, ValueType vi64> {
  def : Pat<(shl vi64:$vx, (vi64 (vec_broadcast i64:$sy, (i32 length)))),
            (VSLALvrl vi64:$vx, i64:$sy,
                      (VLEN length))>;
  def : Pat<(srl vi64:$vx, (vi64 (vec_broadcast i64:$sy, (i32 length)))),
            (VSRLvrl vi64:$vx, i64:$sy,
                     (VLEN length))>;
  def : Pat<(sra vi64:$vx, (vi64 (vec_broadcast i64:$sy, (i32 length)))),
            (VSRALvrl vi64:$vx, i64:$sy,
                      (VLEN length))>;
/*
  def : Pat<(shl vi64:$vx, vi64:$vy),
            (VSLAXv vi64:$vx, vi64:$vy,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(srl vi64:$vx, vi64:$vy),
            (VSRLv vi64:$vx, vi64:$vy,
                   (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(sra vi64:$vx, vi64:$vy),
            (VSRAXv vi64:$vx, vi64:$vy,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
*/
  def : Pat<(shl vi32:$vx, (vi32 (vec_broadcast i32:$sy, (i32 length)))),
            (PVSLALOvrl vi32:$vx, $sy, (VLEN length))>;
  def : Pat<(srl vi32:$vx, (vi32 (vec_broadcast i32:$sy, (i32 length)))),
            (PVSRLLOvrl vi32:$vx, $sy, (VLEN length))>;
  def : Pat<(sra vi32:$vx, (vi32 (vec_broadcast i32:$sy, (i32 length)))),
            (PVSRALOvrl vi32:$vx, $sy, (VLEN length))>;
/*
  def : Pat<(shl vi32:$vx, vi32:$vy),
            (VSLAlv vi32:$vx, vi32:$vy,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(srl vi32:$vx, vi32:$vy),
            (VSRLlv vi32:$vx, vi32:$vy,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(sra vi32:$vx, vi32:$vy),
            (VSRAlv vi32:$vx, vi32:$vy,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
*/
}

let Predicates = [IsSimdSubTarget] in {
  defm : simd_shift<256, v256i32, v256i64>;
  defm : simd_shift<128, v128i32, v128i64>;
  defm : simd_shift<64, v64i32, v64i64>;
  defm : simd_shift<32, v32i32, v32i64>;
  defm : simd_shift<16, v16i32, v16i64>;
  defm : simd_shift<8, v8i32, v8i64>;
  defm : simd_shift<4, v4i32, v4i64>;
  defm : simd_shift<2, v2i32, v2i64>;
}

// Truncate
//
// trunc from vXi64 to vXi32.
/*
multiclass simd_trunc<int length, ValueType vi32, ValueType vi64> {
  def : Pat<(vi32 (trunc vi64:$val)),
            (VANDli0 32, $val, (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
}

let Predicates = [IsSimdSubTarget] in {
  defm : simd_trunc<256, v256i32, v256i64>;
  defm : simd_trunc<128, v128i32, v128i64>;
  defm : simd_trunc<64, v64i32, v64i64>;
  defm : simd_trunc<32, v32i32, v32i64>;
  defm : simd_trunc<16, v16i32, v16i64>;
  defm : simd_trunc<8, v8i32, v8i64>;
  defm : simd_trunc<4, v4i32, v4i64>;
  defm : simd_trunc<2, v2i32, v2i64>;
}
*/
