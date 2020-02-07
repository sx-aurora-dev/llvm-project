//===----------------------------------------------------------------------===//
// Vector Instruction Patterns
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
          (v512i32 (vld_vIsl 8, $addr, (LEA32zzi 256)))>;

def : Pat<(v512f32 (load I64:$addr)),
          (v512f32 (vld_vIsl 8, $addr, (LEA32zzi 256)))>;

// multiclass load_for_vector_length<int length> {
//   def : Pat<(!cast<ValueType>("v" # !cast<string>(length) # "i32")
//               (load I64:$addr)),
//             (vldlsx_vIsl 4, $addr, (LEA32zzi length))>;
//   def : Pat<(!cast<ValueType>("v" # !cast<string>(length) # "f32")
//               (load I64:$addr)),
//             (vldu_vIsl 4, $addr, (LEA32zzi length))>;
//   def : Pat<(!cast<ValueType>("v" # !cast<string>(length) # "f64")
//               (load I64:$addr)),
//             (vld_vIsl 8, $addr, (LEA32zzi length))>;
//   def : Pat<(!cast<ValueType>("v" # !cast<string>(length) # "i64")
//               (load I64:$addr)),
//             (vld_vIsl 8, $addr, (LEA32zzi length))>;
// }

// defm : load_for_vector_length<256>;
// defm : load_for_vector_length<128>;
// defm : load_for_vector_length<64>;
// defm : load_for_vector_length<32>;
// defm : load_for_vector_length<16>;
// defm : load_for_vector_length<8>;
// defm : load_for_vector_length<4>;
// defm : load_for_vector_length<2>;

// multiclass store_for_vector_length<int length> {
//   def : Pat<(store !cast<ValueType>("v" # !cast<string>(length) # "i32"):$vx,
//                    I64:$addr),
// 	      (vstl_vIsl !cast<ValueType>("v" # !cast<string>(length) # "i32"):$vx,
//                     4, $addr, (LEA32zzi length))>;
//   def : Pat<(store !cast<ValueType>("v" # !cast<string>(length) # "f32"):$vx,
//                    I64:$addr),
// 	      (vstu_vIsl !cast<ValueType>("v" # !cast<string>(length) # "f32"):$vx,
//                     4, $addr, (LEA32zzi length))>;
//   def : Pat<(store !cast<ValueType>("v" # !cast<string>(length) # "i64"):$vx,
//                    I64:$addr),
//             (vst_vIsl !cast<ValueType>("v" # !cast<string>(length) # "i64"):$vx,
//                     8, $addr, (LEA32zzi length))>;
//   def : Pat<(store !cast<ValueType>("v" # !cast<string>(length) # "f64"):$vx,
//                    I64:$addr),
//             (vst_vIsl !cast<ValueType>("v" # !cast<string>(length) # "f64"):$vx,
//                     8, $addr, (LEA32zzi length))>;
// }

// defm : store_for_vector_length<256>;
// defm : store_for_vector_length<128>;
// defm : store_for_vector_length<64>;
// defm : store_for_vector_length<32>;
// defm : store_for_vector_length<16>;
// defm : store_for_vector_length<8>;
// defm : store_for_vector_length<4>;
// defm : store_for_vector_length<2>;

// Load for
// v256i1, v512i1

def : Pat<(v256i1 (load I64:$addr)),
          (v256i1 (lvm_mmIs (lvm_mmIs (lvm_mmIs (lvm_mmIs (v256i1 (IMPLICIT_DEF)), 
                      0, (LDSri $addr, 0)),
                      1, (LDSri $addr, 8)),
                      2, (LDSri $addr, 16)),
                      3, (LDSri $addr, 24)))>;

def : Pat<(v512i1 (load I64:$addr)),
          (v512i1 (lvm_MMIs (lvm_MMIs (lvm_MMIs (lvm_MMIs
                  (lvm_MMIs (lvm_MMIs (lvm_MMIs (lvm_MMIs (v512i1 (IMPLICIT_DEF)), 
                      0, (LDSri $addr, 0)),
                      1, (LDSri $addr, 8)),
                      2, (LDSri $addr, 16)),
                      3, (LDSri $addr, 24)),
                      4, (LDSri $addr, 32)),
                      5, (LDSri $addr, 40)),
                      6, (LDSri $addr, 48)),
                      7, (LDSri $addr, 56)))>;

// Store for v256i1, v512i1 are implemented in 2 ways.  These STVM/STVM512
// pseudo instruction is used for frameindex related load/store instructions.
// Custom Lowering is used for other load/store instructions.

def : Pat<(store v256i1:$vx, ADDRri:$addr),
          (STVMri ADDRri:$addr, $vx)>;

def : Pat<(store v512i1:$vx, ADDRri:$addr),
          (STVM512ri ADDRri:$addr, $vx)>;

multiclass ext_for_vector_length<int length, ValueType vi32, ValueType vi64,
                                 ValueType vi1> {
  def : Pat<(vi64 (sext vi32:$vx)),
            (vaddswsx_vIvl 0, $vx, (LEA32zzi length))>;
  def : Pat<(vi64 (zext vi32:$vx)),
            (vaddswzx_vIvl 0, $vx, (LEA32zzi length))>;
}

defm : ext_for_vector_length<256, v256i32, v256i64, v256i1>;
defm : ext_for_vector_length<128, v128i32, v128i64, v128i1>;
defm : ext_for_vector_length<64, v64i32, v64i64, v64i1>;
defm : ext_for_vector_length<32, v32i32, v32i64, v32i1>;
defm : ext_for_vector_length<16, v16i32, v16i64, v16i1>;
defm : ext_for_vector_length<8, v8i32, v8i64, v8i1>;
defm : ext_for_vector_length<4, v4i32, v4i64, v4i1>;
defm : ext_for_vector_length<2, v2i32, v2i64, v2i1>;

// Bitconvert for vector registers

def: Pat<(v512i32 (scalar_to_vector i32:$val)),
         (v512i32 (lsv_vvss (v512i32 (IMPLICIT_DEF)), 0,
                        (SLLri
                           (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32),
                           32)))>;
def: Pat<(v512f32 (scalar_to_vector f32:$val)),
         (v512f32 (lsv_vvss (v512f32 (IMPLICIT_DEF)), 0,
                        (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32)))>;

multiclass s2v_for_vector_length<int length, ValueType vi32, ValueType vi64,
                                 ValueType vf32, ValueType vf64> {
  def: Pat<(vi32 (scalar_to_vector i32:$val)),
           (lsv_vvss (vi32 (IMPLICIT_DEF)), 0,
                 (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32))>;
  def: Pat<(vi64 (scalar_to_vector i64:$val)),
           (lsv_vvss (vi64 (IMPLICIT_DEF)), 0, $val)>;
  def: Pat<(vf32 (scalar_to_vector f32:$val)),
           (lsv_vvss (vf32 (IMPLICIT_DEF)), 0,
                 (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32))>;
  def: Pat<(vf64 (scalar_to_vector f64:$val)),
           (lsv_vvss (vf64 (IMPLICIT_DEF)), 0,
                 (COPY_TO_REGCLASS $val, I64))>;
}

defm : s2v_for_vector_length<256, v256i32, v256i64, v256f32, v256f64>;
defm : s2v_for_vector_length<128, v128i32, v128i64, v128f32, v128f64>;
defm : s2v_for_vector_length<64, v64i32, v64i64, v64f32, v64f64>;
defm : s2v_for_vector_length<32, v32i32, v32i64, v32f32, v32f64>;
defm : s2v_for_vector_length<16, v16i32, v16i64, v16f32, v16f64>;
defm : s2v_for_vector_length<8, v8i32, v8i64, v8f32, v8f64>;
defm : s2v_for_vector_length<4, v4i32, v4i64, v4f32, v4f64>;
defm : s2v_for_vector_length<2, v2i32, v2i64, v2f32, v2f64>;

// Series of INSERT_VECOR_ELT for all VE vector types,
// v512i32 and v512f32 is expanded by LowerINSERT_VECTOR_ELT().

multiclass ive_for_vector_length<int length, ValueType vi32, ValueType vi64,
                                 ValueType vf32, ValueType vf64> {
  def: Pat<(vi32 (insertelt vi32:$vec, i32:$val, uimm7:$idx)),
           (lsv_vvss vi32:$vec, imm:$idx,
                 (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32))>;
  def: Pat<(vi32 (insertelt vi32:$vec, i32:$val, i64:$idx)),
           (lsv_vvss vi32:$vec,
                 (EXTRACT_SUBREG $idx, sub_i32),
                 (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32))>;
}

defm : ive_for_vector_length<256, v256i32, v256i64, v256f32, v256f64>;
defm : ive_for_vector_length<128, v128i32, v128i64, v128f32, v128f64>;
defm : ive_for_vector_length<64, v64i32, v64i64, v64f32, v64f64>;
defm : ive_for_vector_length<32, v32i32, v32i64, v32f32, v32f64>;
defm : ive_for_vector_length<16, v16i32, v16i64, v16f32, v16f64>;
defm : ive_for_vector_length<8, v8i32, v8i64, v8f32, v8f64>;
defm : ive_for_vector_length<4, v4i32, v4i64, v4f32, v4f64>;
defm : ive_for_vector_length<2, v2i32, v2i64, v2f32, v2f64>;

// Series of EXTRACT_VECOR_ELT for all VE vector types,
// v512i32 and v512f32 is expanded by LowerEXTRACT_VECTOR_ELT().

multiclass eve_for_vector_length<int length, ValueType vi32, ValueType vi64,
                                 ValueType vf32, ValueType vf64> {
  def: Pat<(i32 (extractelt vi32:$vec, uimm7:$idx)),
           (EXTRACT_SUBREG (lvsl_svs vi32:$vec, imm:$idx), sub_i32)>;
}

defm : eve_for_vector_length<256, v256i32, v256i64, v256f32, v256f64>;
defm : eve_for_vector_length<128, v128i32, v128i64, v128f32, v128f64>;
defm : eve_for_vector_length<64, v64i32, v64i64, v64f32, v64f64>;
defm : eve_for_vector_length<32, v32i32, v32i64, v32f32, v32f64>;
defm : eve_for_vector_length<16, v16i32, v16i64, v16f32, v16f64>;
defm : eve_for_vector_length<8, v8i32, v8i64, v8f32, v8f64>;
defm : eve_for_vector_length<4, v4i32, v4i64, v4f32, v4f64>;
defm : eve_for_vector_length<2, v2i32, v2i64, v2f32, v2f64>;

// Broadcast

def: Pat<(v512i32 (vec_broadcast i64:$val, i32:$vl)),
         (pvbrd_vsl $val, $vl)>;
def: Pat<(v512f32 (vec_broadcast i64:$val, i32:$vl)),
         (pvbrd_vsl $val, $vl)>;

multiclass vbrd_for_vector_length<int length, ValueType vi32, ValueType vi64,
                                  ValueType vf32, ValueType vf64> {
  def : Pat<(vi32 (vec_broadcast i32:$sy, i32:$vl)),
            (vbrdl_vsl i32:$sy, i32:$vl)>;
  def : Pat<(vf32 (vec_broadcast f32:$sy, i32:$vl)),
            (vbrdu_vsl f32:$sy, i32:$vl)>;
  def : Pat<(vi64 (vec_broadcast i64:$sy, i32:$vl)),
            (vbrd_vsl i64:$sy, i32:$vl)>;
  def : Pat<(vf64 (vec_broadcast f64:$sy, i32:$vl)),
            (vbrd_vsl f64:$sy, i32:$vl)>;
}

defm : vbrd_for_vector_length<256, v256i32, v256i64, v256f32, v256f64>;
// defm : vbrd_for_vector_length<128, v128i32, v128i64, v128f32, v128f64>;
// defm : vbrd_for_vector_length<64, v64i32, v64i64, v64f32, v64f64>;
// defm : vbrd_for_vector_length<32, v32i32, v32i64, v32f32, v32f64>;
// defm : vbrd_for_vector_length<16, v16i32, v16i64, v16f32, v16f64>;
// defm : vbrd_for_vector_length<8, v8i32, v8i64, v8f32, v8f64>;
// defm : vbrd_for_vector_length<4, v4i32, v4i64, v4f32, v4f64>;
// defm : vbrd_for_vector_length<2, v2i32, v2i64, v2f32, v2f64>;

// element extraction and insertion
def : Pat<(extractelt v256f64:$vx, i64:$sy),
          (lvsl_svs v256f64:$vx, (EXTRACT_SUBREG i64:$sy, sub_i32))>;
// def : Pat<(insertelt v256f64:$vx, i32:$sy, f64:$sz), // FIXME does not build
//           (lsv_vvss v256f64:$vx, i32:$sy, f64:$sz)>;
