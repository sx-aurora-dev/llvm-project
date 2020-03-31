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
          (v512i32 (vld_vIsl 8, $addr, (LEA32zii 0, 0, 256)))>;

def : Pat<(v512f32 (load I64:$addr)),
          (v512f32 (vld_vIsl 8, $addr, (LEA32zii 0, 0, 256)))>;

// Mask Insert & Extract
multiclass insert_extract_mask<ValueType MaskVT, string MaskToken> {
  // extract at imm
  def : Pat<(i64 (vm_extract MaskVT:$vm, uimm7:$idx)),
                 (!cast<Instruction>("svm_s"#MaskToken#"I") MaskVT:$vm, uimm7:$idx)>;
  // extract at sx
  def : Pat<(i64 (vm_extract MaskVT:$vm, i64:$idx)),
                 (!cast<Instruction>("svm_s"#MaskToken#"s") MaskVT:$vm, i64:$idx)>;
 
  // insert at imm
  def : Pat<(MaskVT (vm_insert MaskVT:$vm, uimm7:$idx, i64:$sy)),
                    (!cast<Instruction>("lvm_"#MaskToken#MaskToken#"Is") MaskVT:$vm, uimm7:$idx, i64:$sy)>;
  // insert at sx
  def : Pat<(MaskVT (vm_insert MaskVT:$vm, i64:$idx, i64:$sy)),
                    (!cast<Instruction>("lvm_"#MaskToken#MaskToken#"ss") MaskVT:$vm, i64:$idx, i64:$sy)>;
}

defm: insert_extract_mask<v256i1, "m">;
defm: insert_extract_mask<v512i1, "M">;

// Mask Load & Store

def : Pat<(v256i1 (load I64:$addr)),
          (v256i1 (lvm_mmIs (lvm_mmIs (lvm_mmIs (lvm_mmIs (v256i1 (IMPLICIT_DEF)), 
                      0, (LDrii $addr, 0, 0)),
                      1, (LDrii $addr, 0, 8)),
                      2, (LDrii $addr, 0, 16)),
                      3, (LDrii $addr, 0, 24)))>;

def : Pat<(v512i1 (load I64:$addr)),
          (v512i1 (lvm_MMIs (lvm_MMIs (lvm_MMIs (lvm_MMIs
                  (lvm_MMIs (lvm_MMIs (lvm_MMIs (lvm_MMIs (v512i1 (IMPLICIT_DEF)), 
                      0, (LDrii $addr, 0, 0)),
                      1, (LDrii $addr, 0, 8)),
                      2, (LDrii $addr, 0, 16)),
                      3, (LDrii $addr, 0, 24)),
                      4, (LDrii $addr, 0, 32)),
                      5, (LDrii $addr, 0, 40)),
                      6, (LDrii $addr, 0, 48)),
                      7, (LDrii $addr, 0, 56)))>;

// Store for v256i1, v512i1 are implemented in 2 ways.  These STVM/STVM512
// pseudo instruction is used for frameindex related load/store instructions.
// Custom Lowering is used for other load/store instructions.

def : Pat<(store v256i1:$vx, ADDRrii:$addr),
          (STVMrii ADDRrii:$addr, $vx)>;

def : Pat<(store v512i1:$vx, ADDRrii:$addr),
          (STVM512rii ADDRrii:$addr, $vx)>;

// Insert & Extract Vector Element

// Series of INSERT_VECTOR_ELT for all VE vector types,
// v512i32 and v512f32 is expanded by LowerINSERT_VECTOR_ELT().

multiclass ive_eve_64<ValueType VecVT, ValueType ElemVT> {
  def: Pat<(VecVT (insertelt VecVT:$vx, ElemVT:$val, uimm7:$idx)),
            (lsv_vvIs VecVT:$vx, imm:$idx, $val)>;
  def: Pat<(VecVT (insertelt VecVT:$vx, ElemVT:$val, I64:$sy)),
            (lsv_vvss VecVT:$vx, $sy, $val)>;
  def: Pat<(ElemVT (extractelt VecVT:$vx, uimm7:$idx)),
            (lvsl_svI VecVT:$vx, imm:$idx)>;
  def: Pat<(ElemVT (extractelt VecVT:$vx, I64:$sy)),
            (lvsl_svI VecVT:$vx, $sy)>;
}

defm: ive_eve_64<v256f64, f64>;
defm: ive_eve_64<v256i64, i64>;

multiclass ive_eve_32<ValueType VecVT, ValueType ElemVT, SubRegIndex SubRegIdx> {
  def: Pat<(VecVT (insertelt VecVT:$vec, ElemVT:$val, uimm7:$idx)),
           (lsv_vvIs VecVT:$vec,
                     imm:$idx,
                     (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, SubRegIdx))>;
  def: Pat<(VecVT (insertelt VecVT:$vec, ElemVT:$val, I64:$sy)),
           (lsv_vvIs VecVT:$vec,
                     $sy,
                     (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, SubRegIdx))>;

  def: Pat<(ElemVT (extractelt VecVT:$vec, uimm7:$idx)),
           (EXTRACT_SUBREG (lvsl_svI VecVT:$vec, imm:$idx), SubRegIdx)>;
  def: Pat<(ElemVT (extractelt VecVT:$vec, I64:$sy)),
           (EXTRACT_SUBREG (lvsl_svI VecVT:$vec, $sy), SubRegIdx)>;
}

defm: ive_eve_32<v256f32, f32, sub_f32>;
defm: ive_eve_32<v256i32, i32, sub_i32>;

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

// Element shift (VMV)
multiclass VMV_Patterns<ValueType VecVT> {
  // folded select
  def : Pat<(VecVT (vvp_select (vec_vmv VecVT:$v, i32:$amount, (v256i1 srcvalue), (i32 srcvalue)),
                               VecVT:$vpt,
                               v256i1:$mask,
                               i32:$pivot)),
            (vmv_vsvmvl $amount, $v, $mask, $vpt, $pivot)>;
  // standard VMV
  def : Pat<(VecVT (vec_vmv VecVT:$v, i32:$amount, v256i1:$mask, i32:$avl)),
            (vmv_vsvmvl $amount, $v, $mask, (VecVT (IMPLICIT_DEF)), $avl)>;
}
defm: VMV_Patterns<v256i32>;
defm: VMV_Patterns<v256f32>;
defm: VMV_Patterns<v256i64>;

def : Pat<(v256f32 (vec_vmv v256f32:$v, i32:$amount, v256i1:$mask, i32:$avl)),
          (vmv_vsvmvl $amount, $v, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i32 (vec_vmv v256i32:$v, i32:$amount, v256i1:$mask, i32:$avl)),
          (vmv_vsvmvl $amount, $v, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;

// Vector mask popcnt
def : Pat<(i64 (vec_popcount v256i1:$mask, i32:$avl)),
          (pcvm_sml $mask, $avl)>;

// Packing (type based)
def : Pat<(v512i32 (vec_pack v256i32:$vlo, v256i32:$vhi, i32:$avl)),
          (vshf_vvvIl $vlo, $vhi, 3, $avl)>;
def : Pat<(v512f32 (vec_pack v256f32:$vlo, v256f32:$vhi, i32:$avl)),
          (vshf_vvvIl $vlo, $vhi, 2, $avl)>;

// Swapping
multiclass Unpack_Swap<ValueType PackVT> {
  def : Pat<(PackVT (vec_swap PackVT:$vp, i32:$avl)),
            (vshf_vvvIl $vp, $vp, 8, $avl)>; // exchange hi and lo

  // no-op unpacks
  def : Pat<(v256i32 (vec_unpack_lo PackVT:$vp, (i32 srcvalue))),
            (COPY_TO_REGCLASS $vp, V64)>;
  def : Pat<(v256f32 (vec_unpack_hi PackVT:$vp, (i32 srcvalue))),
            (COPY_TO_REGCLASS $vp, V64)>;

  // shuffle unpacks
  def : Pat<(v256f32 (vec_unpack_lo PackVT:$vp, i32:$avl)),
            (vshf_vvvIl $vp, $vp, 15, $avl)>; // always pick lo
  def : Pat<(v256i32 (vec_unpack_hi PackVT:$vp, i32:$avl)),
            (vshf_vvvIl $vp, $vp, 0, $avl)>; // always pick hi
}

defm: Unpack_Swap<v512i32>;
defm: Unpack_Swap<v512f32>;


// Casts
def : Pat<(v256i64 (sext_inreg V64:$src, v256i32)),
          (COPY_TO_REGCLASS (vaddswsx_vsvl (i32 0), $src, (i32 256)), V64)>;
def : Pat<(v256i64 (sext v256i32:$src)),
          (COPY_TO_REGCLASS (vaddswsx_vsvl (i32 0), $src, (i32 256)), V64)>;
def : Pat<(v256i64 (zext v256i32:$src)),
          (COPY_TO_REGCLASS (vaddswzx_vsvl (i32 0), $src, (i32 256)), V64)>;

// bitconvert
multiclass NoopConv<ValueType AVT, ValueType BVT, RegisterClass RT=V64> {
  def : Pat<(AVT (bitconvert BVT:$src)), (COPY_TO_REGCLASS $src, RT)>;
  def : Pat<(BVT (bitconvert AVT:$src)), (COPY_TO_REGCLASS $src, RT)>;
}

defm : NoopConv<v512i32,v512f32>;
defm : NoopConv<v256i64,v256f64>;
defm : NoopConv<v4i1,v256i1,VM>;
defm : NoopConv<v8i1,v512i1,VM512>;

// actual conversions
def : Pat<(v256i32 (bitconvert v256f32:$src)),
          (vsral_vvIl (COPY_TO_REGCLASS $src, V64), 32, (i32 256))>;
def : Pat<(v256f32 (bitconvert v256i32:$src)),
          (vslal_vvIl (COPY_TO_REGCLASS $src, V64), 32, (i32 256))>;
