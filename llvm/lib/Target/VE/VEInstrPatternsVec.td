//===----------------------------------------------------------------------===//
// Vector Instruction Patterns for non vectorize subtarget which supports
// intrinsics and v256f64 vector regisetr only.
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Vector Instruction Patterns for vectorize subtarget which is being
// implemented experimatally.
//===----------------------------------------------------------------------===//

// Pattern Matchings for Generic Vector Instructions

// Mask Insert & Extract
multiclass insert_extract_mask<ValueType MaskVT, string MaskToken> {
  // extract at imm
  def : Pat<(i64 (vm_extract MaskVT:$vm, uimm7:$idx)),
                 (!cast<Instruction>("SVM"#MaskToken#"i") MaskVT:$vm, (LO7 $idx))>;
  // extract at sx
  def : Pat<(i64 (vm_extract MaskVT:$vm, i64:$idx)),
                 (!cast<Instruction>("SVM"#MaskToken#"r") MaskVT:$vm, i64:$idx)>;
 
  // insert at imm
  def : Pat<(MaskVT (vm_insert MaskVT:$vm, uimm7:$idx, i64:$sy)),
                    (!cast<Instruction>("LVMir_"#MaskToken) (LO7 $idx), i64:$sy, MaskVT:$vm)>;
  // insert at sx
  def : Pat<(MaskVT (vm_insert MaskVT:$vm, i64:$idx, i64:$sy)),
                    (!cast<Instruction>("LVMrr_"#MaskToken) i64:$idx, i64:$sy, MaskVT:$vm)>;
  // TODO mimm encoding for $sy
}

defm: insert_extract_mask<v256i1, "m">;
// defm: insert_extract_mask<v512i1, "y">; // TODO: implement! SVMyr not available

// Mask Load & Store

// Store for v256i1, v512i1 are implemented in 2 ways.  These STVM/STVM512
// pseudo instruction is used for frameindex related load/store instructions.
// Custom Lowering is used for other load/store instructions.

def : Pat<(v256i1 (load ADDRrii:$addr)),
          (LDVMrii ADDRrii:$addr)>;

def : Pat<(v512i1 (load ADDRrii:$addr)),
          (LDVM512rii ADDRrii:$addr)>;

def : Pat<(store v256i1:$vx, ADDRrii:$addr),
          (STVMrii ADDRrii:$addr, $vx)>;

def : Pat<(store v512i1:$vx, ADDRrii:$addr),
          (STVM512rii ADDRrii:$addr, $vx)>;


// Mask arithmetic
multiclass MaskArith<ValueType MaskVT, string MaskTag="mmm"> {
  def : Pat<(MaskVT (and MaskVT:$ma, MaskVT:$mb)), (!cast<Instruction>("ANDM"#MaskTag#MaskTag) $ma, $mb)>;
  def : Pat<(MaskVT (or  MaskVT:$ma, MaskVT:$mb)), (!cast<Instruction>("ORM"#MaskTag#MaskTag)  $ma, $mb)>;
  def : Pat<(MaskVT (xor MaskVT:$ma, MaskVT:$mb)), (!cast<Instruction>("XORM"#MaskTag#MaskTag) $ma, $mb)>;
}

defm: MaskArith<v256i1,"m">;

// split pattern (unpack splice, pack)
class SplitPat<ValueType PackedVT, ValueType RegularVT, SDNode N, Instruction VEOp, SubRegIndex subreg_lo, SubRegIndex subreg_hi>
  : Pat<(PackedVT (N PackedVT:$A, PackedVT:$B)),
        (PackedVT
          (INSERT_SUBREG
            (INSERT_SUBREG
              (PackedVT (IMPLICIT_DEF)),
              (VEOp (EXTRACT_SUBREG $A, subreg_hi), (EXTRACT_SUBREG $B, subreg_hi)),
              subreg_hi),
            (VEOp (EXTRACT_SUBREG $A, subreg_lo), (EXTRACT_SUBREG $B, subreg_lo)),
            subreg_lo))>;

// mask unpacking
class SplitMaskPat<SDNode N, Instruction VEMaskOp> : SplitPat<v512i1, v256i1, N, VEMaskOp, sub_vm_even, sub_vm_odd>;

def: SplitMaskPat<and, ANDMmm>;
def: SplitMaskPat<or,   ORMmm>;
def: SplitMaskPat<xor, XORMmm>;

// Insert & Extract Vector Element

// Series of INSERT_VECTOR_ELT for all VE vector types,
// v512i32 and v512f32 is expanded by LowerINSERT_VECTOR_ELT().

multiclass ive_eve_64<ValueType VecVT, ValueType ElemVT> {
  def: Pat<(VecVT (insertelt VecVT:$vx, ElemVT:$val, uimm7:$idx)),
            (LSVir_v (ULO7 $idx), $val, $vx)>;
  def: Pat<(VecVT (insertelt VecVT:$vx, ElemVT:$val, I64:$sy)),
            (LSVrr_v $sy, $val, $vx)>;
  def: Pat<(ElemVT (extractelt VecVT:$vx, uimm7:$idx)),
            (LVSvi VecVT:$vx, (ULO7 $idx))>;
  def: Pat<(ElemVT (extractelt VecVT:$vx, I64:$sy)),
            (LVSvr VecVT:$vx, $sy)>;
}

defm: ive_eve_64<v256f64, f64>;
defm: ive_eve_64<v256i64, i64>;

multiclass ive_eve_32<ValueType VecVT, ValueType ElemVT, SubRegIndex SubRegIdx> {
  def: Pat<(VecVT (insertelt VecVT:$vec, ElemVT:$val, uimm7:$idx)),
           (LSVir_v  imm:$idx,
                     (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, SubRegIdx),
                     VecVT:$vec)>;
  def: Pat<(VecVT (insertelt VecVT:$vec, ElemVT:$val, I64:$sy)),
           (LSVrr_v $sy,
                     (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, SubRegIdx),
                     VecVT:$vec)>;

  def: Pat<(ElemVT (extractelt VecVT:$vec, uimm7:$idx)),
           (EXTRACT_SUBREG (LVSvi VecVT:$vec, imm:$idx), SubRegIdx)>;
  def: Pat<(ElemVT (extractelt VecVT:$vec, I64:$sy)),
           (EXTRACT_SUBREG (LVSvr VecVT:$vec, $sy), SubRegIdx)>;
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
         (PVBRDrl $val, $vl)>;
def: Pat<(v512f32 (vec_broadcast i64:$val, i32:$vl)),
         (PVBRDrl $val, $vl)>;

multiclass vbrd_for_vector_length<int length, ValueType vi32, ValueType vi64,
                                  ValueType vf32, ValueType vf64> {
  def : Pat<(vi32 (vec_broadcast i32:$sy, i32:$vl)),
            (VBRDrl
              (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_i32),
              i32:$vl)>;
  def : Pat<(vf32 (vec_broadcast f32:$sy, i32:$vl)),
            (VBRDrl
              (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_f32),
              i32:$vl)>;
  def : Pat<(vi64 (vec_broadcast i64:$sy, i32:$vl)),
            (VBRDrl i64:$sy, i32:$vl)>;
  def : Pat<(vf64 (vec_broadcast f64:$sy, i32:$vl)),
            (VBRDrl f64:$sy, i32:$vl)>;
}

defm : vbrd_for_vector_length<256, v256i32, v256i64, v256f32, v256f64>;

// Sequence
def: Pat<(v512i32 (vec_seq i32:$vl)),
         (PVSEQl $vl)>;
def: Pat<(v256i64 (vec_seq i32:$vl)),
         (VSEQl $vl)>;
def: Pat<(v256i32 (vec_seq i32:$vl)),
         (PVSEQLOl $vl)>;
def: Pat<(v256f32 (vec_seq i32:$vl)),
         (PVSEQUPl $vl)>;

// Element shift (VMV)
multiclass VMV_Patterns<ValueType VecVT> {
  // folded select
  def : Pat<(VecVT (vvp_select (vec_vmv VecVT:$v, i32:$amount, (v256i1 srcvalue), (i32 srcvalue)),
                               VecVT:$vpt,
                               v256i1:$mask,
                               i32:$pivot)),
            (VMVrvml_v (COPY_TO_REGCLASS $amount, I64), $v, $mask, $pivot, $vpt)>;
  // standard VMV
  def : Pat<(VecVT (vec_vmv VecVT:$v, i32:$amount, v256i1:$mask, i32:$avl)),
            (VMVrvml (COPY_TO_REGCLASS $amount, I64), $v, $mask, $avl)>;
}
defm: VMV_Patterns<v256i32>;
defm: VMV_Patterns<v256f32>;
defm: VMV_Patterns<v256i64>;
defm: VMV_Patterns<v256f64>;

// Vector mask popcnt
def : Pat<(i64 (vec_popcount v256i1:$mask, i32:$avl)),
          (PCVMml $mask, $avl)>;

// Packing (type based)
def : Pat<(v512i32 (vec_pack v256i32:$vlo, v256i32:$vhi, i32:$avl)),
          (VSHFvvil $vlo, $vhi, 3, $avl)>;
def : Pat<(v512f32 (vec_pack v256f32:$vlo, v256f32:$vhi, i32:$avl)),
          (VSHFvvil $vlo, $vhi, 2, $avl)>;
def : Pat<(v512i1 (vec_pack v256i1:$vlo, v256i1:$vhi, (i32 srcvalue))),
          (INSERT_SUBREG (INSERT_SUBREG
                         (v512i1 (IMPLICIT_DEF)),
                         $vlo, sub_vm_even),
                         $vhi, sub_vm_odd)>;

// Swapping
multiclass Unpack_Swap<ValueType PackVT> {
  def : Pat<(PackVT (vec_swap PackVT:$vp, i32:$avl)),
            (VSHFvvil $vp, $vp, 8, $avl)>; // exchange hi and lo

  // no-op unpacks
  def : Pat<(v256i32 (vec_unpack_lo PackVT:$vp, (i32 srcvalue))),
            (COPY_TO_REGCLASS $vp, V64)>;
  def : Pat<(v256f32 (vec_unpack_hi PackVT:$vp, (i32 srcvalue))),
            (COPY_TO_REGCLASS $vp, V64)>;

  // shuffle unpacks
  def : Pat<(v256f32 (vec_unpack_lo PackVT:$vp, i32:$avl)),
            (VSHFvvil $vp, $vp, 15, $avl)>; // always pick lo
  def : Pat<(v256i32 (vec_unpack_hi PackVT:$vp, i32:$avl)),
            (VSHFvvil $vp, $vp, 0, $avl)>; // always pick hi
}

// mask unpacking
def : Pat<(v256i1 (vec_unpack_lo v512i1:$vm, (i32 srcvalue))),
          (EXTRACT_SUBREG $vm, sub_vm_even)>;
def : Pat<(v256i1 (vec_unpack_hi v512i1:$vm, (i32 srcvalue))),
          (EXTRACT_SUBREG $vm, sub_vm_odd)>;

defm: Unpack_Swap<v512i32>;
defm: Unpack_Swap<v512f32>;

// TODO: optimized pattern
//      t17: i32 = truncate t2
//        t25: i64 = VEISD::REPL_I32 t17
//      t26: v512i32 = VEISD::VEC_BROADCAST t25, Constant:i32<256>
//    t27: v512i1 = VEISD::VEC_TOMASK t26, Constant:i32<512>

// VFMKLvl (CCOp, VR, VL)
def : Pat<(vec_tomask v256i64:$vx, i32:$avl),
          (VFMKLvl CC_INE, $vx, $avl)>;
def : Pat<(vec_tomask v256f64:$vx, i32:$avl),
          (VFMKLvl CC_INE, $vx, $avl)>;
def : Pat<(vec_tomask v256i32:$vx, i32:$avl),
          (PVFMKWLOvl CC_INE, $vx, $avl)>;
def : Pat<(vec_tomask v256f32:$vx, i32:$avl),
          (PVFMKWUPvl CC_NE, $vx, $avl)>;

// Casts
// def : Pat<(v256i64 (sext_inreg V64:$src, v256i32)),
//           (COPY_TO_REGCLASS (vaddswsx_vsvl (i32 0), $src, (lea_i32 256)), V64)>;
// def : Pat<(v256i64 (sext v256i32:$src)),
//           (COPY_TO_REGCLASS (vaddswsx_vsvl (i32 0), $src, (lea_i32 256)), V64)>;
// def : Pat<(v256i64 (zext v256i32:$src)),
//           (COPY_TO_REGCLASS (vaddswzx_vsvl (i32 0), $src, (lea_i32 256)), V64)>;
def : Pat<(v256i64 (anyext v256i32:$src)),
          (COPY_TO_REGCLASS $src, V64)>; // TODO INSERT_SUBREG

// bitconvert
multiclass NoopConv<ValueType AVT, ValueType BVT, RegisterClass RT=V64> {
  def : Pat<(AVT (bitconvert BVT:$src)), (COPY_TO_REGCLASS $src, RT)>;
  def : Pat<(BVT (bitconvert AVT:$src)), (COPY_TO_REGCLASS $src, RT)>;
}

defm : NoopConv<v512i32,v256i64>;
defm : NoopConv<v512f32,v256i64>;
defm : NoopConv<v512i32,v256f64>;
defm : NoopConv<v512f32,v256f64>;

defm : NoopConv<v512i32,v512f32>;
defm : NoopConv<v256i64,v256f64>;
defm : NoopConv<v4i1,v256i1,VM>;
defm : NoopConv<v8i1,v512i1,VM512>;

// actual conversions
def : Pat<(v256i32 (bitconvert v256f32:$src)),
          (VSRALvil (COPY_TO_REGCLASS $src, V64), 32, 256)>;
def : Pat<(v256f32 (bitconvert v256i32:$src)),
          (VSLALvil (COPY_TO_REGCLASS $src, V64), 32, 256)>;
