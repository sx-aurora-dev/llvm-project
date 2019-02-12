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

// Load and store for
// v256i32, v256i64, v512i32, v256f32, v256f64, v512f32.

def : Pat<(v512i32 (load ADDRri:$addr)),
          (v512i32 (VLDir 8, (LEAasx ADDRri:$addr),
                          (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;

def : Pat<(v512f32 (load ADDRri:$addr)),
          (v512f32 (VLDir 8, (LEAasx ADDRri:$addr),
                          (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;

multiclass load_for_vector_length<int length> {
  def : Pat<(!cast<ValueType>("v" # !cast<string>(length) # "i32")
              (load ADDRri:$addr)),
            (VLDLsxir 4, (LEAasx ADDRri:$addr),
                         (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(!cast<ValueType>("v" # !cast<string>(length) # "f32")
              (load ADDRri:$addr)),
            (VLDUir 4, (LEAasx ADDRri:$addr),
                       (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(!cast<ValueType>("v" # !cast<string>(length) # "f64")
              (load ADDRri:$addr)),
            (VLDir 8, (LEAasx ADDRri:$addr),
                      (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(!cast<ValueType>("v" # !cast<string>(length) # "i64")
              (load ADDRri:$addr)),
            (VLDir 8, (LEAasx ADDRri:$addr),
                      (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(!cast<ValueType>("v" # !cast<string>(length) # "i64")
              (!cast<PatFrag>("extloadv" # !cast<string>(length) # "i32")
                 ADDRri:$addr)),
            (VLDLzxir 4, (LEAasx ADDRri:$addr),
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(!cast<ValueType>("v" # !cast<string>(length) # "i64")
              (!cast<PatFrag>("sextloadv" # !cast<string>(length) # "i32")
                 ADDRri:$addr)),
            (VLDLsxir 4, (LEAasx ADDRri:$addr),
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(!cast<ValueType>("v" # !cast<string>(length) # "i64")
              (!cast<PatFrag>("zextloadv" # !cast<string>(length) # "i32")
                 ADDRri:$addr)),
            (VLDLzxir 4, (LEAasx ADDRri:$addr),
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
}

defm : load_for_vector_length<256>;
defm : load_for_vector_length<8>;
defm : load_for_vector_length<4>;
defm : load_for_vector_length<2>;

def : Pat<(store v512i32:$vx, ADDRri:$addr),
          (VSTir v512i32:$vx, 8, (LEAasx ADDRri:$addr),
                 (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;

def : Pat<(store v512f32:$vx, ADDRri:$addr),
          (VSTir v512f32:$vx, 8, (LEAasx ADDRri:$addr),
                 (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;

multiclass store_for_vector_length<int length> {
  def : Pat<(store !cast<ValueType>("v" # !cast<string>(length) # "i32"):$vx,
                   ADDRri:$addr),
            (VSTLir !cast<ValueType>("v" # !cast<string>(length) # "i32"):$vx,
                    4, (LEAasx ADDRri:$addr),
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(store !cast<ValueType>("v" # !cast<string>(length) # "f32"):$vx,
                   ADDRri:$addr),
            (VSTUir !cast<ValueType>("v" # !cast<string>(length) # "f32"):$vx,
                    4, (LEAasx ADDRri:$addr),
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(store !cast<ValueType>("v" # !cast<string>(length) # "f64"):$vx,
                   ADDRri:$addr),
            (VSTir !cast<ValueType>("v" # !cast<string>(length) # "f64"):$vx,
                    8, (LEAasx ADDRri:$addr),
                   (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(store !cast<ValueType>("v" # !cast<string>(length) # "i64"):$vx,
                   ADDRri:$addr),
            (VSTir !cast<ValueType>("v" # !cast<string>(length) # "i64"):$vx,
                    8, (LEAasx ADDRri:$addr),
                   (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(!cast<PatFrag>("truncstorev" # !cast<string>(length) # "i32")
               !cast<ValueType>("v" # !cast<string>(length) # "i64"):$vx,
               ADDRri:$addr),
            (VSTLir $vx, 4, (LEAasx ADDRri:$addr),
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;

}

defm : store_for_vector_length<256>;
defm : store_for_vector_length<8>;
defm : store_for_vector_length<4>;
defm : store_for_vector_length<2>;

// Format Conversions

// sint -> floating-point

def : Pat<(v512f32 (sint_to_fp v512i32:$vx)),
          (VFLTpv $vx, (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;

multiclass ifconv_for_vector_length<int length, ValueType vi32, ValueType vi64,
                                   ValueType vf32, ValueType vf64> {
  def : Pat<(vf64 (sint_to_fp vi64:$vx)),
            (VFLTXv $vx, (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(vf64 (sint_to_fp vi32:$vx)),
            (VFLTdv $vx, (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(vf32 (sint_to_fp vi32:$vx)),
            (VFLTsv $vx, (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
}

defm : ifconv_for_vector_length<256, v256i32, v256i64, v256f32, v256f64>;
defm : ifconv_for_vector_length<8, v8i32, v8i64, v8f32, v8f64>;
defm : ifconv_for_vector_length<4, v4i32, v4i64, v4f32, v4f64>;
defm : ifconv_for_vector_length<2, v2i32, v2i64, v2f32, v2f64>;

// sext and zext

multiclass ext_for_vector_length<int length, ValueType vi32, ValueType vi64> {
  def : Pat<(vi64 (sext vi32:$vx)),
            (VADSwsxi 0, $vx, (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(vi64 (zext vi32:$vx)),
            (VADSwzxi 0, $vx, (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
}

defm : ext_for_vector_length<256, v256i32, v256i64>;
defm : ext_for_vector_length<8, v8i32, v8i64>;
defm : ext_for_vector_length<4, v4i32, v4i64>;
// FIXME: it is not possible to use following pattern.
// defm : ext_for_vector_length<2, v2i32, v2i64>;

// Bitconvert for mask registers between
// v256i64 and v256f64.

def : Pat<(v256f64 (bitconvert v256i64:$vi)),
          (COPY_TO_REGCLASS $vi, V64)>;

def : Pat<(v256i64 (bitconvert v256f64:$vf)),
          (COPY_TO_REGCLASS $vf, V64)>;

// Bitconvert for mask registers between
// v4i64 or v8i64 and v256i1 or v512i1 respectively

def : Pat<(v256i1 (bitconvert v4i64:$v)),
          (v256i1 (V2VM (COPY_TO_REGCLASS $v, V64)))>;

def : Pat<(v4i64 (bitconvert v256i1:$vm)),
          (v4i64 (COPY_TO_REGCLASS (VM2V $vm), V64))>;

def : Pat<(v512i1 (bitconvert v8i64:$v)),
          (v512i1 (V2VMP (COPY_TO_REGCLASS $v, V64)))>;

def : Pat<(v8i64 (bitconvert v512i1:$vmp)),
          (v8i64 (COPY_TO_REGCLASS (VMP2V $vmp), V64))>;

// Series of SCALAR_TO_VECTOR for all VE vector types,
//   v512i32, v512f32
//   v256i32, v256i64, v256f32, v256f64,
//   v8i32, v8i64, v8f32, v8f64,
//   v4i32, v4i64, v4f32, v4f64,
//   v2i32, v2i64, v2f32, v2f64,
//
// NOTE: Need to use sub_f32 for v512i32 since v512i32 uses
//       upper 32 bits (0..31) first.

def: Pat<(v512i32 (scalar_to_vector i32:$val)),
         (v512i32 (LSVi (v512i32 (IMPLICIT_DEF)), 0,
                        (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32)))>;
def: Pat<(v512f32 (scalar_to_vector f32:$val)),
         (v512f32 (LSVi (v512f32 (IMPLICIT_DEF)), 0,
                        (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32)))>;

multiclass s2v_for_vector_length<int length, ValueType vi32, ValueType vi64,
                                 ValueType vf32, ValueType vf64> {
  def: Pat<(vi32 (scalar_to_vector i32:$val)),
           (LSVi (vi32 (IMPLICIT_DEF)), 0,
                 (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32))>;
  def: Pat<(vi64 (scalar_to_vector i64:$val)),
           (LSVi (vi64 (IMPLICIT_DEF)), 0, $val)>;
  def: Pat<(vf32 (scalar_to_vector f32:$val)),
           (LSVi (vf32 (IMPLICIT_DEF)), 0,
                 (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32))>;
  def: Pat<(vf64 (scalar_to_vector f64:$val)),
           (LSVi (vf64 (IMPLICIT_DEF)), 0,
                 (COPY_TO_REGCLASS $val, I64))>;
}

defm : s2v_for_vector_length<256, v256i32, v256i64, v256f32, v256f64>;
defm : s2v_for_vector_length<8, v8i32, v8i64, v8f32, v8f64>;
defm : s2v_for_vector_length<4, v4i32, v4i64, v4f32, v4f64>;
defm : s2v_for_vector_length<2, v2i32, v2i64, v2f32, v2f64>;

// Series of INSERT_VECOR_ELT for all VE vector types,
// v256i32, v256i64, v256f32, v256f64.
// v512i32 and v512f32 is expanded by LowerINSERT_VECTOR_ELT().

def: Pat<(v256i32 (insertelt v256i32:$vec, i32:$val, uimm7:$idx)),
         (v256i32 (LSVi v256i32:$vec, imm:$idx,
                        (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32)))>;
def: Pat<(v256i32 (insertelt v256i32:$vec, i32:$val, i64:$idx)),
         (v256i32 (LSVr v256i32:$vec,
                        (EXTRACT_SUBREG $idx, sub_i32),
                        (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32)))>;

def: Pat<(v256f32 (insertelt v256f32:$vec, f32:$val, uimm7:$idx)),
         (v256f32 (LSVi v256f32:$vec, imm:$idx,
                        (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32)))>;
def: Pat<(v256f32 (insertelt v256f32:$vec, f32:$val, i64:$idx)),
         (v256f32 (LSVr v256f32:$vec,
                        (EXTRACT_SUBREG $idx, sub_f32),
                        (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32)))>;

def: Pat<(v256f64 (insertelt v256f64:$vec, f64:$val, uimm7:$idx)),
         (v256f64 (LSVi v256f64:$vec, imm:$idx,
                        (COPY_TO_REGCLASS $val, I64)))>;
def: Pat<(v256f64 (insertelt v256f64:$vec, f64:$val, i64:$idx)),
         (v256f64 (LSVr v256f64:$vec,
                        (EXTRACT_SUBREG $idx, sub_i32),
                        (COPY_TO_REGCLASS $val, I64)))>;

def: Pat<(v256i64 (insertelt v256i64:$vec, i64:$val, uimm7:$idx)),
         (v256i64 (LSVi v256i64:$vec, imm:$idx, $val))>;
def: Pat<(v256i64 (insertelt v256i64:$vec, i64:$val, i64:$idx)),
         (v256i64 (LSVr v256i64:$vec,
                        (EXTRACT_SUBREG $idx, sub_i32), $val))>;

// Series of EXTRACT_VECOR_ELT for all VE vector types,
// v256i32, v256i64, v256f32, v256f64.
// v512i32 and v512f32 is expanded by LowerEXTRACT_VECTOR_ELT().

def: Pat<(i32 (extractelt v256i32:$vec, uimm7:$idx)),
         (EXTRACT_SUBREG (LVSi v256i32:$vec, imm:$idx), sub_i32)>;
def: Pat<(i32 (extractelt v256i32:$vec, i64:$idx)),
         (EXTRACT_SUBREG (LVSr v256i32:$vec, $idx), sub_i32)>;

def: Pat<(f32 (extractelt v256f32:$vec, uimm7:$idx)),
         (EXTRACT_SUBREG (LVSi v256f32:$vec, imm:$idx), sub_f32)>;
def: Pat<(f32 (extractelt v256f32:$vec, i64:$idx)),
         (EXTRACT_SUBREG (LVSr v256f32:$vec, $idx), sub_f32)>;

def: Pat<(f64 (extractelt v256f64:$vec, uimm7:$idx)),
         (LVSi v256f64:$vec, imm:$idx)>;
def: Pat<(f64 (extractelt v256f64:$vec, i64:$idx)),
         (LVSr v256f64:$vec, $idx)>;

def: Pat<(i64 (extractelt v256i64:$vec, uimm7:$idx)),
         (LVSi v256i64:$vec, imm:$idx)>;
def: Pat<(i64 (extractelt v256i64:$vec, i64:$idx)),
         (LVSr v256i64:$vec, $idx)>;

// Custom ISDs
// VEISD::VEC_SEQ - represents a vector sequence where the operand is the stride
// VEISD::VEC_BROADCAST - represents a vector splat of a scalar value into all vector lanes.

def vec_seq         : SDNode<"VEISD::VEC_SEQ",       SDTypeProfile<1, 1, [SDTCisVec<0>, SDTCisInt<1>]>>;
def vec_broadcast   : SDNode<"VEISD::VEC_BROADCAST", SDTypeProfile<1, 1, [SDTCisVec<0>]>>;

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

// Shuffle
// TODO

// Scatter
def : Pat<(vec_scatter v256i64:$vx, v256i64:$vy),
          (VSCv v256i64:$vx, v256i64:$vy,
                (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
def : Pat<(vec_scatter v256f64:$vx, v256i64:$vy),
          (VSCv v256f64:$vx, v256i64:$vy,
                (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;

// Gather
def : Pat<(v256i64 (vec_gather v256i64:$vy)),
          (VGTv v256i64:$vy,
                (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
def : Pat<(v256f64 (vec_gather v256i64:$vy)),
          (VGTv v256i64:$vy,
                (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;

// LVL
def : Pat<(vec_lvl i32:$sy), (LVL i32:$sy)>;

// Broadcast
def : Pat<(v256f64 (scalar_to_vector f64:$sy)),
          (VBRDf64r f64:$sy, (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;

def : Pat<(v256i64 (vec_broadcast i64:$sy)),
          (VBRDr i64:$sy, (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
def : Pat<(v256f64 (vec_broadcast f64:$sy)),
          (VBRDf64r f64:$sy, (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
def : Pat<(v256i32 (vec_broadcast i32:$sy)),
          (VBRDi32r i32:$sy, (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
def : Pat<(v256f32 (vec_broadcast f32:$sy)),
          (VBRDf32r f32:$sy, (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
// def : Pat<(v512f32 (vec_broadcast f32:$sy)),
//           (VBRDpr f32:$sy, (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
def : Pat<(v512i32 (vec_broadcast i64:$sy)),
          (VBRDpr i64:$sy, (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;

// Condition Code
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

// (VFMKv (i32 uimm6:$cc), v256f64:$vz)

// def : Pat<(i32 (setcc i64:$LHS, i64:$RHS, CCSIOp:$cond)),
//           (EXTRACT_SUBREG
//               (CMOVLrm0 )>;
//
// def : Pat<(setcc v256i64:$vx, v256i64:$vy, $cc),
//           (VFMKv (i32 uimm6:( $cc)), v256f64:$vz)>;

// Vector Select

def : Pat<(v256f64 (vselect v256i1:$m, v256f64:$vy, v256f64:$vz)),
          (v256f64 (VMRGvm v256f64:$vz, v256f64:$vy, v256i1:$m,
                           (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;
def : Pat<(v512f32 (vselect v512i1:$m, v512f32:$vy, v512f32:$vz)),
          (VMRGpvm v512f32:$vz, v512f32:$vy, v512i1:$m,
                   (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;

// Sequence

def : Pat<(v256i32 (vec_seq (i32 1))), (VSEQlv 256)>;
def : Pat<(v512i32 (vec_seq (i32 1))), (VSEQpv 256)>;
def : Pat<(v256i64 (vec_seq (i64 1))), (VSEQv 256)>;

// Double-Precision Arithmetic
//
// fadd, fsub, fmul, and fdiv for
//   v512f32,
//   v256f32, v256f64,
//   v8f32, v8f64,
//   v4f32, v4f64,
//   v2f32, v2f64,

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

def : Pat<(fadd (vec_broadcast i64:$sy), v512f32:$vz),
          (VFADpr i64:$sy, v512f32:$vz,
                  (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
def : Pat<(fsub (vec_broadcast i64:$sy), v512f32:$vz),
          (VFSBpr i64:$sy, v512f32:$vz,
                  (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
def : Pat<(fmul (vec_broadcast i64:$sy), v512f32:$vz),
          (VFMPpr i64:$sy, v512f32:$vz,
                  (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
def : Pat<(fdiv (v512f32 (vec_broadcast i64:$sy)), v512f32:$vz),
          (VFDVpr i64:$sy, v512f32:$vz,
                  (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;

multiclass farith_for_vector_length<int length, ValueType vf32,
                                    ValueType vf64> {
  def : Pat<(fadd vf32:$vy, vf32:$vz),
            (VFADsv vf32:$vy, vf32:$vz,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(fadd vf64:$vy, vf64:$vz),
            (VFADdv vf64:$vy, vf64:$vz,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(fadd (vf32 (vec_broadcast f32:$sy)), vf32:$vz),
            (VFADsr f32:$sy, vf32:$vz,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(fadd (vf64 (vec_broadcast f64:$sy)), vf64:$vz),
            (VFADdr f64:$sy, vf64:$vz,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(fsub vf32:$vy, vf32:$vz),
            (VFSBsv vf32:$vy, vf32:$vz,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(fsub vf64:$vy, vf64:$vz),
            (VFSBdv vf64:$vy, vf64:$vz,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(fsub (vf32 (vec_broadcast f32:$sy)), vf32:$vz),
            (VFSBsr f32:$sy, vf32:$vz,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(fsub (vf64 (vec_broadcast f64:$sy)), vf64:$vz),
            (VFSBdr f64:$sy, vf64:$vz,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(fmul vf32:$vy, vf32:$vz),
            (VFMPsv vf32:$vy, vf32:$vz,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(fmul vf64:$vy, vf64:$vz),
            (VFMPdv vf64:$vy, vf64:$vz,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(fmul (vf32 (vec_broadcast f32:$sy)), vf32:$vz),
            (VFMPsr f32:$sy, vf32:$vz,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(fmul (vf64 (vec_broadcast f64:$sy)), vf64:$vz),
            (VFMPdr f64:$sy, vf64:$vz,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(fdiv vf32:$vy, vf32:$vz),
            (VFDVsv vf32:$vy, vf32:$vz,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(fdiv vf64:$vy, vf64:$vz),
            (VFDVdv vf64:$vy, vf64:$vz,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(fdiv (vf32 (vec_broadcast f32:$sy)), vf32:$vz),
            (VFDVsr f32:$sy, vf32:$vz,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(fdiv (vf64 (vec_broadcast f64:$sy)), vf64:$vz),
            (VFDVdr f64:$sy, vf64:$vz,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
}

defm : farith_for_vector_length<256, v256f32, v256f64>;
defm : farith_for_vector_length<8, v8f32, v8f64>;
defm : farith_for_vector_length<4, v4f32, v4f64>;
defm : farith_for_vector_length<2, v2f32, v2f64>;

// fneg for
//   v512f32,
//   v256f32, v256f64,
//   v8f32, v8f64,
//   v4f32, v4f64,
//   v2f32, v2f64,

def : Pat<(fneg v512f32:$vz),
          (VFSBpi 0, v512f32:$vz,
                  (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;

multiclass fneg_for_vector_length<int length, ValueType vf32, ValueType vf64> {
  def : Pat<(fneg vf32:$vz),
            (VFSBsi 0, vf32:$vz,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(fneg vf64:$vz),
            (VFSBdi 0, vf64:$vz,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
}

defm : fneg_for_vector_length<256, v256f32, v256f64>;
defm : fneg_for_vector_length<8, v8f32, v8f64>;
defm : fneg_for_vector_length<4, v4f32, v4f64>;
defm : fneg_for_vector_length<2, v2f32, v2f64>;

// fma for
//   v512f32,
//   v256f64

def : Pat<(fma v256f64:$vz, v256f64:$vw, (v256f64 (fneg v256f64:$vy))),
          (VFMSBdv v256f64:$vy, v256f64:$vz, v256f64:$vw,
                   (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;

def : Pat<(fma (v256f64 (vec_broadcast f64:$sy)), v256f64:$vw, v256f64:$vy),
          (VFMADdr2 v256f64:$vy, f64:$sy, v256f64:$vw,
                    (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
def : Pat<(fma v256f64:$vw, (v256f64 (vec_broadcast f64:$sy)), v256f64:$vy),
          (VFMADdr2 v256f64:$vy, f64:$sy, v256f64:$vw,
                    (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
def : Pat<(fma v256f64:$vz, v256f64:$vw, (v256f64 (vec_broadcast f64:$sy))),
          (VFMADdr f64:$sy, v256f64:$vz, v256f64:$vw,
                   (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
def : Pat<(fma v256f64:$vz, v256f64:$vw, v256f64:$vy),
          (VFMADdv v256f64:$vy, v256f64:$vz, v256f64:$vw,
                   (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;

// Packed Single-Precision Arithmetic

def : Pat<(fma v512f32:$vz, v512f32:$vw, (v512f32 (fneg v512f32:$vy))),
          (VFMSBpv v512f32:$vy, v512f32:$vz, v512f32:$vw,
                   (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;

def : Pat<(fma (v256f32 (vec_broadcast i64:$sy)), v256f32:$vw, v256f32:$vy),
          (VFMADpr2 v256f32:$vy, i64:$sy, v256f32:$vw,
                    (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
def : Pat<(fma v256f32:$vw, (v256f32 (vec_broadcast i64:$sy)), v256f32:$vy),
          (VFMADpr2 v256f32:$vy, i64:$sy, v256f32:$vw,
                    (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
def : Pat<(fma v256f32:$vz, v256f32:$vw, (v256f32 (vec_broadcast i64:$sy))),
          (VFMADpr i64:$sy, v256f32:$vz, v256f32:$vw,
                   (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
def : Pat<(fma v256f32:$vz, v256f32:$vw, v256f32:$vy),
          (VFMADpv v256f32:$vy, v256f32:$vz, v256f32:$vw,
                   (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;

// Integer Arithmetic
//
// add and sub for v512i32
// add, sub, mul, sdiv, and udiv for
//   v256i32, v256i64
//   v8i32, v8i64
//   v4i32, v4i64
//   v2i32, v2i64

def : Pat<(add v512i32:$vy, v512i32:$vz),
          (VADSpv v512i32:$vy, v512i32:$vz,
                  (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
def : Pat<(sub v512i32:$vy, v512i32:$vz),
          (VSBSpv v512i32:$vy, v512i32:$vz,
                  (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;

multiclass arith_for_vector_length<int length, ValueType vi32, ValueType vi64> {
  def : Pat<(add vi32:$vy, vi32:$vz),
            (VADSwsxv vi32:$vy, vi32:$vz,
                      (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(add vi64:$vy, vi64:$vz),
            (VADXlv vi64:$vy, vi64:$vz,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(sub vi32:$vy, vi32:$vz),
            (VSBSwsxv vi32:$vy, vi32:$vz,
                      (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(sub vi64:$vy, vi64:$vz),
            (VSBXlv vi64:$vy, vi64:$vz,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(mul vi32:$vy, vi32:$vz),
            (VMPSwsxv vi32:$vy, vi32:$vz,
                      (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(mul vi64:$vy, vi64:$vz),
            (VMPXlv vi64:$vy, vi64:$vz,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(sdiv vi32:$vy, vi32:$vz),
            (VDVSwsxv vi32:$vy, vi32:$vz,
                      (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(sdiv vi64:$vy, vi64:$vz),
            (VDVXlv vi64:$vy, vi64:$vz,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(udiv vi32:$vy, vi32:$vz),
            (VDIVwv vi32:$vy, vi32:$vz,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(udiv vi64:$vy, vi64:$vz),
            (VDIVlv vi64:$vy, vi64:$vz,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
}

defm : arith_for_vector_length<256, v256i32, v256i64>;
defm : arith_for_vector_length<8, v8i32, v8i64>;
defm : arith_for_vector_length<4, v4i32, v4i64>;
defm : arith_for_vector_length<2, v2i32, v2i64>;

// Logic
//
// and, or, and xor for v512i32
// and, or, and xor for
//   v256i32, v256i64
//   v8i32, v8i64
//   v4i32, v4i64
//   v2i32, v2i64

def : Pat<(and v512i32:$vx, v512i32:$vy),
          (VANDpv v512i32:$vx, v512i32:$vy,
                 (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
def : Pat<(or  v512i32:$vx, v512i32:$vy),
          (VORpv v512i32:$vx, v512i32:$vy,
                (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
def : Pat<(xor v512i32:$vx, v512i32:$vy),
          (VXORpv v512i32:$vx, v512i32:$vy,
                 (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;

multiclass logic_for_vector_length<int length, ValueType vi32, ValueType vi64> {
  def : Pat<(and vi64:$vx, vi64:$vy),
            (VANDv vi64:$vx, vi64:$vy,
                   (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(or  vi64:$vx, vi64:$vy),
            (VORv vi64:$vx, vi64:$vy,
                  (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(xor vi64:$vx, vi64:$vy),
            (VXORv vi64:$vx, vi64:$vy,
                   (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(and vi32:$vx, vi32:$vy),
            (VANDlv vi32:$vx, vi32:$vy,
                   (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(or  vi32:$vx, vi32:$vy),
            (VORlv vi32:$vx, vi32:$vy,
                  (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(xor vi32:$vx, vi32:$vy),
            (VXORlv vi32:$vx, vi32:$vy,
                   (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
}

defm : logic_for_vector_length<256, v256i32, v256i64>;
defm : logic_for_vector_length<8, v8i32, v8i64>;
defm : logic_for_vector_length<4, v4i32, v4i64>;
defm : logic_for_vector_length<2, v2i32, v2i64>;

// Shifts
//
// shl, srl, and sra for v512i32
// shl, srl, and sra for
//   v256i32, v256i64
//   v8i32, v8i64
//   v4i32, v4i64
//   v2i32, v2i64

def : Pat<(shl v512i32:$vx, (v512i32 (vec_broadcast i64:$sy))),
          (VSLLpr2 v512i32:$vx, i64:$sy,
                   (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
def : Pat<(srl v512i32:$vx, (v512i32 (vec_broadcast i64:$sy))),
          (VSRLpr2 v512i32:$vx, i64:$sy,
                   (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
def : Pat<(sra v512i32:$vx, (v512i32 (vec_broadcast i64:$sy))),
          (VSRApr2 v512i32:$vx, i64:$sy,
                   (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;

def : Pat<(shl v512i32:$vx, v512i32:$vy),
          (VSLLpv v512i32:$vx, v512i32:$vy,
                  (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
def : Pat<(srl v512i32:$vx, v512i32:$vy),
          (VSRLpv v512i32:$vx, v512i32:$vy,
                  (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
def : Pat<(sra v512i32:$vx, v512i32:$vy),
          (VSRApv v512i32:$vx, v512i32:$vy,
                  (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;

multiclass shift_for_vector_length<int length, ValueType vi32, ValueType vi64> {
  def : Pat<(shl vi64:$vx, (vi64 (vec_broadcast i64:$sy))),
            (VSLAXr2 vi64:$vx, i64:$sy,
                     (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(srl vi64:$vx, (vi64 (vec_broadcast i64:$sy))),
            (VSRLr2 vi64:$vx, i64:$sy,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(sra vi64:$vx, (vi64 (vec_broadcast i64:$sy))),
            (VSRAXr2 vi64:$vx, i64:$sy,
                     (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(shl vi64:$vx, vi64:$vy),
            (VSLAXv vi64:$vx, vi64:$vy,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(srl vi64:$vx, vi64:$vy),
            (VSRLv vi64:$vx, vi64:$vy,
                   (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(sra vi64:$vx, vi64:$vy),
            (VSRAXv vi64:$vx, vi64:$vy,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(shl vi32:$vx, (vi32 (vec_broadcast i64:$sy))),
            (VSLAlr2 vi32:$vx, i64:$sy,
                     (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(srl vi32:$vx, (vi32 (vec_broadcast i64:$sy))),
            (VSRLlr2 vi32:$vx, i64:$sy,
                     (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(sra vi32:$vx, (vi32 (vec_broadcast i64:$sy))),
            (VSRAlr2 vi32:$vx, i64:$sy,
                     (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(shl vi32:$vx, vi32:$vy),
            (VSLAlv vi32:$vx, vi32:$vy,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(srl vi32:$vx, vi32:$vy),
            (VSRLlv vi32:$vx, vi32:$vy,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(sra vi32:$vx, vi32:$vy),
            (VSRAlv vi32:$vx, vi32:$vy,
                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
}

defm : shift_for_vector_length<256, v256i32, v256i64>;
defm : shift_for_vector_length<8, v8i32, v8i64>;
defm : shift_for_vector_length<4, v4i32, v4i64>;
defm : shift_for_vector_length<2, v2i32, v2i64>;
