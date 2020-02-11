//===----------------------------------------------------------------------===//
// Vector Instruction Patterns
//===----------------------------------------------------------------------===//

// Pattern Matchings for Generic Vector Instructions

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

// Series of INSERT_VECTOR_ELT for all VE vector types,
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

// Series of EXTRACT_VECOR_ELT for all VE vector types,
// v512i32 and v512f32 is expanded by LowerEXTRACT_VECTOR_ELT().

multiclass eve_for_vector_length<int length, ValueType vi32, ValueType vi64,
                                 ValueType vf32, ValueType vf64> {
  def: Pat<(i64 (extractelt vi64:$vx, uimm7:$idx)),
            (lvsl_svs vi64:$vx, $idx)>;
  def: Pat<(f64 (extractelt vf64:$vx, uimm7:$idx)),
            (lvsl_svs vf64:$vx, $idx)>;
  def: Pat<(i32 (extractelt vi32:$vec, uimm7:$idx)),
           (EXTRACT_SUBREG (lvsl_svs vi32:$vec, imm:$idx), sub_i32)>;
  def: Pat<(f32 (extractelt vf32:$vec, uimm7:$idx)),
           (EXTRACT_SUBREG (lvsl_svs vf32:$vec, imm:$idx), sub_f32)>;
}

defm : eve_for_vector_length<256, v256i32, v256i64, v256f32, v256f64>;

// Narrow

multiclass narrow_dce<ValueType DataVT> {
  def: Pat<(DataVT (vec_narrow DataVT:$vx, (i32 uimm32))),
           (COPY_TO_REGCLASS $vx, V64)>;
}
defm : narrow_dce<v256f64>;
defm : narrow_dce<v256i64>;
defm : narrow_dce<v256f32>;
defm : narrow_dce<v256i32>;
defm : narrow_dce<v512f32>;
defm : narrow_dce<v512i32>;

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


// Sequence
def: Pat<(v512i32 (vec_seq i32:$vl)),
         (pvseq_vl $vl)>;
def: Pat<(v256i64 (vec_seq i32:$vl)),
         (vseq_vl $vl)>;
def: Pat<(v256i32 (vec_seq i32:$vl)),
         (pvseqlo_vl $vl)>;
