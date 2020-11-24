//===-- VEInstrPatternsVec.td - VEC_-type SDNodes and isel for VE Target --===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file describes the VEC_* prefixed intermediate SDNodes and their
// isel patterns.
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Instruction format superclass
//===----------------------------------------------------------------------===//

multiclass vbrd_elem32<ValueType v32, ValueType s32, SDPatternOperator ImmOp, SDNodeXForm ImmCast, int SubRegIdx> {
  // VBRDil
  def : Pat<(v32 (vec_broadcast (s32 ImmOp:$sy), i32:$vl)),
            (VBRDil (ImmCast $sy), i32:$vl)>;

  // VBRDrl
  def : Pat<(v32 (vec_broadcast s32:$sy, i32:$vl)),
            (VBRDrl
              (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, SubRegIdx),
              i32:$vl)>;
}

defm : vbrd_elem32<v256f32, f32, simm7fp, LO7FP, sub_f32>;
defm : vbrd_elem32<v256i32, i32, simm7, LO7, sub_i32>;

multiclass vbrd_elem64<ValueType v64, ValueType s64, SDPatternOperator ImmOp, SDNodeXForm ImmCast> {
  // VBRDil
  def : Pat<(v64 (vec_broadcast (s64 ImmOp:$sy), i32:$vl)),
            (VBRDil (ImmCast $sy), i32:$vl)>;

  // VBRDrl
  def : Pat<(v64 (vec_broadcast s64:$sy, i32:$vl)),
            (VBRDrl s64:$sy, i32:$vl)>;
}

defm : vbrd_elem64<v256f64, f64, simm7fp, LO7FP>;
defm : vbrd_elem64<v256i64, i64, simm7, LO7>;

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
// Vector Instruction Patterns for non vectorize subtarget which supports
// intrinsics and v256f64 vector regisetr only.
//===----------------------------------------------------------------------===//

// Boardcast for vector mask register.
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

//===----------------------------------------------------------------------===//
// Vector Instruction Patterns for vectorize subtarget which is being
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

def : Pat<(v512i32 (load I64:$addr)),
          (v512i32 (VLDirl 8, $addr,
                           (EXTRACT_SUBREG (LEAzii 0, 0, 256), sub_i32)))>;
def : Pat<(v512f32 (load I64:$addr)),
          (v512f32 (VLDirl 8, $addr,
                           (EXTRACT_SUBREG (LEAzii 0, 0, 256), sub_i32)))>;

multiclass load_for_vector_length<int length> {
  def : Pat<(!cast<ValueType>("v" # !cast<string>(length) # "i32")
              (load I64:$addr)),
            (!cast<ValueType>("v" # !cast<string>(length) # "i32")
              (VLDLSXirl 4, $addr,
                         (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32)))>;
  def : Pat<(!cast<ValueType>("v" # !cast<string>(length) # "f32")
              (load I64:$addr)),
            (!cast<ValueType>("v" # !cast<string>(length) # "f32")
              (VLDUirl 4, $addr,
                       (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32)))>;
  def : Pat<(!cast<ValueType>("v" # !cast<string>(length) # "f64")
              (load I64:$addr)),
            (!cast<ValueType>("v" # !cast<string>(length) # "f64")
              (VLDirl 8, $addr,
                      (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32)))>;
  def : Pat<(!cast<ValueType>("v" # !cast<string>(length) # "i64")
              (load I64:$addr)),
            (!cast<ValueType>("v" # !cast<string>(length) # "i64")
              (VLDirl 8, $addr,
                      (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32)))>;
}

defm : load_for_vector_length<256>;
defm : load_for_vector_length<128>;
defm : load_for_vector_length<64>;
defm : load_for_vector_length<32>;
defm : load_for_vector_length<16>;
defm : load_for_vector_length<8>;
defm : load_for_vector_length<4>;
defm : load_for_vector_length<2>;

multiclass store_for_vector_length<int length> {
  def : Pat<(store !cast<ValueType>("v" # !cast<string>(length) # "i32"):$vx,
                   I64:$addr),
            (VSTLirvl 4, $addr,
                      !cast<ValueType>("v" # !cast<string>(length) #"i32"):$vx,
                      (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(store !cast<ValueType>("v" # !cast<string>(length) # "f32"):$vx,
                   I64:$addr),
            (VSTUirvl 4, $addr,
                      !cast<ValueType>("v" # !cast<string>(length) #"f32"):$vx,
                      (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(store !cast<ValueType>("v" # !cast<string>(length) # "i64"):$vx,
                   I64:$addr),
            (VSTirvl 8, $addr,
                     !cast<ValueType>("v" # !cast<string>(length) # "i64"):$vx,
                     (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(store !cast<ValueType>("v" # !cast<string>(length) # "f64"):$vx,
                   I64:$addr),
            (VSTirvl 8, $addr,
                     !cast<ValueType>("v" # !cast<string>(length) # "f64"):$vx,
                     (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
}

defm : store_for_vector_length<256>;
defm : store_for_vector_length<128>;
defm : store_for_vector_length<64>;
defm : store_for_vector_length<32>;
defm : store_for_vector_length<16>;
defm : store_for_vector_length<8>;
defm : store_for_vector_length<4>;
defm : store_for_vector_length<2>;

// Load/store for mask register using stack/symbol is implemented in custom
// lower.  Only load/store for mask registers using frame index is implemented
// here.

// Load for
// v256i1, v512i1

def : Pat<(v256i1 (load ADDRrii:$addr)),
          (LDVMrii ADDRrii:$addr)>;
def : Pat<(v512i1 (load ADDRrii:$addr)),
          (LDVM512rii ADDRrii:$addr)>;

// Store for
// v256i1, v512i1

def : Pat<(store v256i1:$vx, ADDRrii:$addr),
          (STVMrii ADDRrii:$addr, $vx)>;
def : Pat<(store v512i1:$vx, ADDRrii:$addr),
          (STVM512rii ADDRrii:$addr, $vx)>;

multiclass ext_for_vector_length<int length, ValueType vi32, ValueType vi64,
                                 ValueType vi1> {
  def : Pat<(vi64 (sext vi32:$vx)),
            (VADDSWSXivl 0, $vx,
                         (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(vi64 (zext vi32:$vx)),
            (VADDSWZXivl 0, $vx,
                         (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
}

let Predicates = [IsVectorizeSubTarget] in {
  defm : ext_for_vector_length<256, v256i32, v256i64, v256i1>;
  defm : ext_for_vector_length<128, v128i32, v128i64, v128i1>;
  defm : ext_for_vector_length<64, v64i32, v64i64, v64i1>;
  defm : ext_for_vector_length<32, v32i32, v32i64, v32i1>;
  defm : ext_for_vector_length<16, v16i32, v16i64, v16i1>;
  defm : ext_for_vector_length<8, v8i32, v8i64, v8i1>;
  defm : ext_for_vector_length<4, v4i32, v4i64, v4i1>;
  defm : ext_for_vector_length<2, v2i32, v2i64, v2i1>;
}

// Bitconvert for vector registers

// First data of v512i32/v512f32 places higher bits.

def: Pat<(v512i32 (scalar_to_vector i32:$val)),
         (LSVir 0, (SLLri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32),
                          32))>;
def: Pat<(v512f32 (scalar_to_vector f32:$val)),
         (LSVir 0, (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32))>;

multiclass s2v_for_vector_length<int length, ValueType vi32, ValueType vi64,
                                 ValueType vf32, ValueType vf64> {
  def: Pat<(vi32 (scalar_to_vector i32:$val)),
           (LSVir 0, (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32))>;
  def: Pat<(vi64 (scalar_to_vector i64:$val)),
           (LSVir 0, $val)>;
  def: Pat<(vf32 (scalar_to_vector f32:$val)),
           (LSVir 0, (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32))>;
  def: Pat<(vf64 (scalar_to_vector f64:$val)),
           (LSVir 0, (COPY_TO_REGCLASS $val, I64))>;
}

let Predicates = [IsVectorizeSubTarget] in {
  defm : s2v_for_vector_length<256, v256i32, v256i64, v256f32, v256f64>;
  defm : s2v_for_vector_length<128, v128i32, v128i64, v128f32, v128f64>;
  defm : s2v_for_vector_length<64, v64i32, v64i64, v64f32, v64f64>;
  defm : s2v_for_vector_length<32, v32i32, v32i64, v32f32, v32f64>;
  defm : s2v_for_vector_length<16, v16i32, v16i64, v16f32, v16f64>;
  defm : s2v_for_vector_length<8, v8i32, v8i64, v8f32, v8f64>;
  defm : s2v_for_vector_length<4, v4i32, v4i64, v4f32, v4f64>;
  defm : s2v_for_vector_length<2, v2i32, v2i64, v2f32, v2f64>;
}

// Series of INSERT_VECOR_ELT for all VE vector types,
// v512i32 and v512f32 is expanded by LowerINSERT_VECTOR_ELT().

multiclass ive_for_vector_length<int length, ValueType vi32, ValueType vi64,
                                 ValueType vf32, ValueType vf64> {
  def: Pat<(vi32 (insertelt vi32:$vec, i32:$val, uimm7:$idx)),
           (LSVir_v (LO7 $idx),
                    (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32),
                    $vec)>;
  def: Pat<(vi32 (insertelt vi32:$vec, i32:$val, i64:$idx)),
           (LSVrr_v (EXTRACT_SUBREG $idx, sub_i32),
                    (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32),
                    $vec)>;
}

let Predicates = [IsVectorizeSubTarget] in {
  defm : ive_for_vector_length<256, v256i32, v256i64, v256f32, v256f64>;
  defm : ive_for_vector_length<128, v128i32, v128i64, v128f32, v128f64>;
  defm : ive_for_vector_length<64, v64i32, v64i64, v64f32, v64f64>;
  defm : ive_for_vector_length<32, v32i32, v32i64, v32f32, v32f64>;
  defm : ive_for_vector_length<16, v16i32, v16i64, v16f32, v16f64>;
  defm : ive_for_vector_length<8, v8i32, v8i64, v8f32, v8f64>;
  defm : ive_for_vector_length<4, v4i32, v4i64, v4f32, v4f64>;
  defm : ive_for_vector_length<2, v2i32, v2i64, v2f32, v2f64>;
}

// Series of EXTRACT_VECOR_ELT for all VE vector types,
// v512i32 and v512f32 is expanded by LowerEXTRACT_VECTOR_ELT().

multiclass eve_for_vector_length<int length, ValueType vi32, ValueType vi64,
                                 ValueType vf32, ValueType vf64> {
  def: Pat<(i32 (extractelt vi32:$vec, uimm7:$idx)),
           (EXTRACT_SUBREG (LVSvi vi32:$vec, (LO7 $idx)), sub_i32)>;
}

let Predicates = [IsVectorizeSubTarget] in {
  defm : eve_for_vector_length<256, v256i32, v256i64, v256f32, v256f64>;
  defm : eve_for_vector_length<128, v128i32, v128i64, v128f32, v128f64>;
  defm : eve_for_vector_length<64, v64i32, v64i64, v64f32, v64f64>;
  defm : eve_for_vector_length<32, v32i32, v32i64, v32f32, v32f64>;
  defm : eve_for_vector_length<16, v16i32, v16i64, v16f32, v16f64>;
  defm : eve_for_vector_length<8, v8i32, v8i64, v8f32, v8f64>;
  defm : eve_for_vector_length<4, v4i32, v4i64, v4f32, v4f64>;
  defm : eve_for_vector_length<2, v2i32, v2i64, v2f32, v2f64>;
}

// Broadcast

let Predicates = [IsVectorizeSubTarget] in {
  def: Pat<(v512i32 (vec_broadcast i32:$val, (i32 512))),
           (PVBRDrl
              (ORrr
                (SLLri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32), 32),
                (ANDrm (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32),
                       !add(32, 64))),
              (EXTRACT_SUBREG (LEAzii 0, 0, 256), sub_i32))>;
  def: Pat<(v512f32 (vec_broadcast f32:$val, (i32 512))),
           (PVBRDrl
              (ORrr
                (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32),
                (SRLri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32),
                       32)),
              (EXTRACT_SUBREG (LEAzii 0, 0, 256), sub_i32))>;
}

multiclass vbrd_for_vector_length<int length, ValueType vi32, ValueType vi64,
                                  ValueType vf32, ValueType vf64> {
  def : Pat<(vi32 (vec_broadcast i32:$val, (i32 length))),
            (VBRDLrl $val,
                     (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(vf32 (vec_broadcast f32:$val, (i32 length))),
            (VBRDUrl $val,
                     (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(vi64 (vec_broadcast i64:$val, (i32 length))),
            (VBRDrl $val,
                    (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(vf64 (vec_broadcast f64:$val, (i32 length))),
            (VBRDrl $val,
                    (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
}

let Predicates = [IsVectorizeSubTarget] in {
  defm : vbrd_for_vector_length<256, v256i32, v256i64, v256f32, v256f64>;
  defm : vbrd_for_vector_length<128, v128i32, v128i64, v128f32, v128f64>;
  defm : vbrd_for_vector_length<64, v64i32, v64i64, v64f32, v64f64>;
  defm : vbrd_for_vector_length<32, v32i32, v32i64, v32f32, v32f64>;
  defm : vbrd_for_vector_length<16, v16i32, v16i64, v16f32, v16f64>;
  defm : vbrd_for_vector_length<8, v8i32, v8i64, v8f32, v8f64>;
  defm : vbrd_for_vector_length<4, v4i32, v4i64, v4f32, v4f64>;
  defm : vbrd_for_vector_length<2, v2i32, v2i64, v2f32, v2f64>;
}

// Sequence

multiclass vseq_for_vector_length<int length, ValueType vi32, ValueType vi64> {
    def : Pat<(vi32 (vec_seq (i32 1))),
                (PVSEQLOl (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
}

let Predicates = [IsVectorizeSubTarget] in {
  defm : vseq_for_vector_length<256, v256i32, v256i64>;
  defm : vseq_for_vector_length<128, v128i32, v128i64>;
  defm : vseq_for_vector_length<64, v64i32, v64i64>;
  defm : vseq_for_vector_length<32, v32i32, v32i64>;
  defm : vseq_for_vector_length<16, v16i32, v16i64>;
  defm : vseq_for_vector_length<8, v8i32, v8i64>;
  defm : vseq_for_vector_length<4, v4i32, v4i64>;
  defm : vseq_for_vector_length<2, v2i32, v2i64>;
}

// Double-Precision Arithmetic
//
// fadd, fsub, fmul, and fdiv for all floating point vector types.

let Predicates = [IsVectorizeSubTarget] in {
  def : Pat<(fadd (vec_broadcast f32:$val, (i32 512)), v512f32:$vz),
            (PVFADDrvl
              (ORrr
                (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32),
                (SRLri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32),
                       32)),
              $vz, (EXTRACT_SUBREG (LEAzii 0, 0, 256), sub_i32))>;
  def : Pat<(fsub (vec_broadcast f32:$val, (i32 512)), v512f32:$vz),
            (PVFSUBrvl
              (ORrr
                (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32),
                (SRLri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32),
                       32)),
              $vz, (EXTRACT_SUBREG (LEAzii 0, 0, 256), sub_i32))>;
  def : Pat<(fmul (vec_broadcast f32:$val, (i32 512)), v512f32:$vz),
            (PVFMULrvl
              (ORrr
                (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32),
                (SRLri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32),
                       32)),
              $vz, (EXTRACT_SUBREG (LEAzii 0, 0, 256), sub_i32))>;
}

multiclass farith_for_vector_length<int length, ValueType vf32,
                                    ValueType vf64> {
  def : Pat<(fadd vf32:$vy, vf32:$vz),
            (VFADDSvvl vf32:$vy, vf32:$vz,
                       (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(fadd vf64:$vy, vf64:$vz),
            (VFADDDvvl vf64:$vy, vf64:$vz,
                       (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(fadd (vf32 (vec_broadcast f32:$sy, (i32 length))), vf32:$vz),
            (VFADDSrvl f32:$sy, vf32:$vz,
                       (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(fadd (vf64 (vec_broadcast f64:$sy, (i32 length))), vf64:$vz),
            (VFADDDrvl f64:$sy, vf64:$vz,
                       (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(fsub vf32:$vy, vf32:$vz),
            (VFSUBSvvl vf32:$vy, vf32:$vz,
                       (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(fsub vf64:$vy, vf64:$vz),
            (VFSUBDvvl vf64:$vy, vf64:$vz,
                       (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(fsub (vf32 (vec_broadcast f32:$sy, (i32 length))), vf32:$vz),
            (VFSUBSrvl f32:$sy, vf32:$vz,
                       (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(fsub (vf64 (vec_broadcast f64:$sy, (i32 length))), vf64:$vz),
            (VFSUBDrvl f64:$sy, vf64:$vz,
                       (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(fmul vf32:$vy, vf32:$vz),
            (VFMULSvvl vf32:$vy, vf32:$vz,
                         (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(fmul vf64:$vy, vf64:$vz),
            (VFMULDvvl vf64:$vy, vf64:$vz,
                         (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(fmul (vf32 (vec_broadcast f32:$sy, (i32 length))), vf32:$vz),
            (VFMULSrvl f32:$sy, vf32:$vz,
                         (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(fmul (vf64 (vec_broadcast f64:$sy, (i32 length))), vf64:$vz),
            (VFMULDrvl f64:$sy, vf64:$vz,
                         (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(fdiv vf32:$vy, vf32:$vz),
            (VFDIVSvvl vf32:$vy, vf32:$vz,
                         (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(fdiv vf64:$vy, vf64:$vz),
            (VFDIVDvvl vf64:$vy, vf64:$vz,
                         (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(fdiv (vf32 (vec_broadcast f32:$sy, (i32 length))), vf32:$vz),
            (VFDIVSrvl f32:$sy, vf32:$vz,
                         (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(fdiv (vf64 (vec_broadcast f64:$sy, (i32 length))), vf64:$vz),
            (VFDIVDrvl f64:$sy, vf64:$vz,
                         (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
}

let Predicates = [IsVectorizeSubTarget] in {
  defm : farith_for_vector_length<256, v256f32, v256f64>;
  defm : farith_for_vector_length<128, v128f32, v128f64>;
  defm : farith_for_vector_length<64, v64f32, v64f64>;
  defm : farith_for_vector_length<32, v32f32, v32f64>;
  defm : farith_for_vector_length<16, v16f32, v16f64>;
  defm : farith_for_vector_length<8, v8f32, v8f64>;
  defm : farith_for_vector_length<4, v4f32, v4f64>;
  defm : farith_for_vector_length<2, v2f32, v2f64>;
}

// fneg for all floating point vector types.


// fma for all floating point vector types.

let Predicates = [IsVectorizeSubTarget] in {
  def : Pat<(fma (v512f32 (vec_broadcast f32:$sy, (i32 512))),
                 v512f32:$vw, v512f32:$vy),
            (PVFMADvrvl v512f32:$vy,
                      (ORrr
                (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_f32),
                (SRLri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_f32), 32)),
                      v512f32:$vw,
                      (EXTRACT_SUBREG (LEAzii 0, 0, 256), sub_i32))>;
  def : Pat<(fma v512f32:$vw, (v512f32 (vec_broadcast f32:$sy, (i32 512))),
                 v512f32:$vy),
            (PVFMADvrvl v512f32:$vy,
                      (ORrr
                (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_f32),
                (SRLri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_f32), 32)),
                      v512f32:$vw,
                      (EXTRACT_SUBREG (LEAzii 0, 0, 256), sub_i32))>;
  def : Pat<(fma v512f32:$vz, v512f32:$vw,
                 (v512f32 (vec_broadcast f32:$sy, (i32 512)))),
            (PVFMADrvvl (ORrr
                (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_f32),
                (SRLri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_f32), 32)),
                     v512f32:$vz, v512f32:$vw,
                     (EXTRACT_SUBREG (LEAzii 0, 0, 256), sub_i32))>;
}

multiclass fma_for_vector_length<int length, ValueType vf32, ValueType vf64> {
  def : Pat<(fma (vf64 (vec_broadcast f64:$sy, (i32 length))),
                 vf64:$vw, vf64:$vy),
            (VFMADDvrvl vf64:$vy, f64:$sy, vf64:$vw,
                        (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(fma vf64:$vw, (vf64 (vec_broadcast f64:$sy, (i32 length))),
                 vf64:$vy),
            (VFMADDvrvl vf64:$vy, f64:$sy, vf64:$vw,
                        (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(fma vf64:$vz, vf64:$vw,
                 (vf64 (vec_broadcast f64:$sy, (i32 length)))),
            (VFMADDrvvl f64:$sy, vf64:$vz, vf64:$vw,
                        (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(fma vf64:$vz, vf64:$vw, vf64:$vy),
            (VFMADDvvvl vf64:$vy, vf64:$vz, vf64:$vw,
                        (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(fma (vf32 (vec_broadcast f32:$sy, (i32 length))),
                 vf32:$vw, vf32:$vy),
            (VFMADSvrvl vf32:$vy, f32:$sy, vf32:$vw,
                        (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(fma vf32:$vw, (vf32 (vec_broadcast f32:$sy, (i32 length))),
                 vf32:$vy),
            (VFMADSvrvl vf32:$vy, f32:$sy, vf32:$vw,
                        (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(fma vf32:$vz, vf32:$vw,
                 (vf32 (vec_broadcast f32:$sy, (i32 length)))),
            (VFMADSrvvl f32:$sy, vf32:$vz, vf32:$vw,
                        (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(fma vf32:$vz, vf32:$vw, vf32:$vy),
            (VFMADSvvvl vf32:$vy, vf32:$vz, vf32:$vw,
                        (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
}

let Predicates = [IsVectorizeSubTarget] in {
  defm : fma_for_vector_length<256, v256f32, v256f64>;
  defm : fma_for_vector_length<128, v128f32, v128f64>;
  defm : fma_for_vector_length<64, v64f32, v64f64>;
  defm : fma_for_vector_length<32, v32f32, v32f64>;
  defm : fma_for_vector_length<16, v16f32, v16f64>;
  defm : fma_for_vector_length<8, v8f32, v8f64>;
  defm : fma_for_vector_length<4, v4f32, v4f64>;
  defm : fma_for_vector_length<2, v2f32, v2f64>;
}

// Integer Arithmetic
//
// add and sub for v512i32
// add, sub, mul, sdiv, and udiv for other integer vector types.

let Predicates = [IsVectorizeSubTarget] in {
  def : Pat<(add (vec_broadcast i32:$val, (i32 512)), v512i32:$vz),
            (PVADDSrvl
              (ORrr
                (SLLri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32), 32),
                (ANDrm (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32),
                       !add(32, 64))),
              v512i32:$vz, (EXTRACT_SUBREG (LEAzii 0, 0, 256), sub_i32))>;
  def : Pat<(sub (vec_broadcast i32:$val, (i32 512)), v512i32:$vz),
            (PVSUBSrvl
              (ORrr
                (SLLri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32), 32),
                (ANDrm (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32),
                       !add(32, 64))),
              v512i32:$vz, (EXTRACT_SUBREG (LEAzii 0, 0, 256), sub_i32))>;
}

multiclass arith_for_vector_length<int length, ValueType vi32, ValueType vi64> {
  def : Pat<(add vi32:$vy, vi32:$vz),
            (VADDSWSXvvl vi32:$vy, vi32:$vz,
                         (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(add vi64:$vy, vi64:$vz),
            (VADDSLvvl vi64:$vy, vi64:$vz,
                       (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(add (vi32 (vec_broadcast i32:$sy, (i32 length))), vi32:$vz),
            (VADDSWSXrvl i32:$sy, vi32:$vz,
                         (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(add (vi64 (vec_broadcast i64:$sy, (i32 length))), vi64:$vz),
            (VADDSLrvl i64:$sy, vi64:$vz,
                       (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(sub vi32:$vy, vi32:$vz),
            (VSUBSWSXvvl vi32:$vy, vi32:$vz,
                         (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(sub vi64:$vy, vi64:$vz),
            (VSUBSLvvl vi64:$vy, vi64:$vz,
                       (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(sub (vi32 (vec_broadcast i32:$sy, (i32 length))), vi32:$vz),
            (VSUBSWSXrvl i32:$sy, vi32:$vz,
                         (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(sub (vi64 (vec_broadcast i64:$sy, (i32 length))), vi64:$vz),
            (VSUBSLrvl i64:$sy, vi64:$vz,
                       (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(mul vi32:$vy, vi32:$vz),
            (VMULSWSXvvl vi32:$vy, vi32:$vz,
                         (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(mul vi64:$vy, vi64:$vz),
            (VMULSLvvl vi64:$vy, vi64:$vz,
                       (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(mul (vi32 (vec_broadcast i32:$sy, (i32 length))), vi32:$vz),
            (VMULSWSXrvl i32:$sy, vi32:$vz,
                         (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(mul (vi64 (vec_broadcast i64:$sy, (i32 length))), vi64:$vz),
            (VMULSLrvl i64:$sy, vi64:$vz,
                       (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(sdiv vi32:$vy, vi32:$vz),
            (VDIVSWSXvvl vi32:$vy, vi32:$vz,
                         (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(sdiv vi64:$vy, vi64:$vz),
            (VDIVSLvvl vi64:$vy, vi64:$vz,
                       (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(sdiv (vi32 (vec_broadcast i32:$sy, (i32 length))), vi32:$vz),
            (VDIVSWSXrvl i32:$sy, vi32:$vz,
                         (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(sdiv (vi64 (vec_broadcast i64:$sy, (i32 length))), vi64:$vz),
            (VDIVSLrvl i64:$sy, vi64:$vz,
                       (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(udiv vi32:$vy, vi32:$vz),
            (VDIVUWvvl vi32:$vy, vi32:$vz,
                       (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(udiv vi64:$vy, vi64:$vz),
            (VDIVULvvl vi64:$vy, vi64:$vz,
                       (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(udiv (vi32 (vec_broadcast i32:$sy, (i32 length))), vi32:$vz),
            (VDIVUWrvl i32:$sy, vi32:$vz,
                       (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(udiv (vi64 (vec_broadcast i64:$sy, (i32 length))), vi64:$vz),
            (VDIVULrvl i64:$sy, vi64:$vz,
                       (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
}

let Predicates = [IsVectorizeSubTarget] in {
  defm : arith_for_vector_length<256, v256i32, v256i64>;
  defm : arith_for_vector_length<128, v128i32, v128i64>;
  defm : arith_for_vector_length<64, v64i32, v64i64>;
  defm : arith_for_vector_length<32, v32i32, v32i64>;
  defm : arith_for_vector_length<16, v16i32, v16i64>;
  defm : arith_for_vector_length<8, v8i32, v8i64>;
  defm : arith_for_vector_length<4, v4i32, v4i64>;
  defm : arith_for_vector_length<2, v2i32, v2i64>;
}

// Logic

multiclass logic_for_vector_length<int length, ValueType vi32, ValueType vi64> {
  def : Pat<(and vi32:$vx, vi32:$vy),
            (PVANDLOvvl vi32:$vx, vi32:$vy,
                          (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
}

let Predicates = [IsVectorizeSubTarget] in {
  defm : logic_for_vector_length<256, v256i32, v256i64>;
  defm : logic_for_vector_length<128, v128i32, v128i64>;
  defm : logic_for_vector_length<64, v64i32, v64i64>;
  defm : logic_for_vector_length<32, v32i32, v32i64>;
  defm : logic_for_vector_length<16, v16i32, v16i64>;
  defm : logic_for_vector_length<8, v8i32, v8i64>;
  defm : logic_for_vector_length<4, v4i32, v4i64>;
  defm : logic_for_vector_length<2, v2i32, v2i64>;
}

// Shifts
//
// shl, srl, and sra for v512i32
// shl, srl, and sra for other integer vector types.

let Predicates = [IsVectorizeSubTarget] in {
  def : Pat<(shl v512i32:$vx, (v512i32 (vec_broadcast i32:$sy, (i32 512)))),
            (PVSLLvrl v512i32:$vx,
                     (ORrr
                (SLLri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_i32), 32),
                (ANDrm (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_i32),
                       !add(32, 64))),
                     (EXTRACT_SUBREG (LEAzii 0, 0, 256), sub_i32))>;
  def : Pat<(srl v512i32:$vx, (v512i32 (vec_broadcast i32:$sy, (i32 512)))),
            (PVSRLvrl v512i32:$vx,
                     (ORrr
                (SLLri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_i32), 32),
                (ANDrm (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_i32),
                       !add(32, 64))),
                     (EXTRACT_SUBREG (LEAzii 0, 0, 256), sub_i32))>;
  def : Pat<(sra v512i32:$vx, (v512i32 (vec_broadcast i32:$sy, (i32 512)))),
            (PVSRAvrl v512i32:$vx,
                     (ORrr
                (SLLri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_i32), 32),
                (ANDrm (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_i32),
                       !add(32, 64))),
                     (EXTRACT_SUBREG (LEAzii 0, 0, 256), sub_i32))>;
}

multiclass shift_for_vector_length<int length, ValueType vi32, ValueType vi64> {
  def : Pat<(shl vi64:$vx, (vi64 (vec_broadcast i64:$sy, (i32 length)))),
            (VSLALvrl vi64:$vx, i64:$sy,
                      (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(srl vi64:$vx, (vi64 (vec_broadcast i64:$sy, (i32 length)))),
            (VSRLvrl vi64:$vx, i64:$sy,
                     (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(sra vi64:$vx, (vi64 (vec_broadcast i64:$sy, (i32 length)))),
            (VSRALvrl vi64:$vx, i64:$sy,
                      (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(shl vi32:$vx, (vi32 (vec_broadcast i32:$sy, (i32 length)))),
            (PVSLALOvrl vi32:$vx,
                        $sy,
                        (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(srl vi32:$vx, (vi32 (vec_broadcast i32:$sy, (i32 length)))),
            (PVSRLLOvrl vi32:$vx,
                        $sy,
                        (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
  def : Pat<(sra vi32:$vx, (vi32 (vec_broadcast i32:$sy, (i32 length)))),
            (PVSRALOvrl vi32:$vx,
                        $sy,
                        (EXTRACT_SUBREG (LEAzii 0, 0, length), sub_i32))>;
}

let Predicates = [IsVectorizeSubTarget] in {
  defm : shift_for_vector_length<256, v256i32, v256i64>;
  defm : shift_for_vector_length<128, v128i32, v128i64>;
  defm : shift_for_vector_length<64, v64i32, v64i64>;
  defm : shift_for_vector_length<32, v32i32, v32i64>;
  defm : shift_for_vector_length<16, v16i32, v16i64>;
  defm : shift_for_vector_length<8, v8i32, v8i64>;
  defm : shift_for_vector_length<4, v4i32, v4i64>;
  defm : shift_for_vector_length<2, v2i32, v2i64>;
}
