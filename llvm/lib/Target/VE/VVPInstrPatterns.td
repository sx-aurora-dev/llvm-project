// The backend translates VP and regular vector operations into vvp_* nodes
// This file defines the isel patterns
// The vvp_nodes are defined in..

include "VVPInstrInfo.td"

// Conversion operators
def f32_to_i64 : OutPatFrag<(ops node:$val), (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32)>;
def i32_to_i64 : OutPatFrag<(ops node:$val), (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32)>;
def idcast : OutPatFrag<(ops node:$val), (COPY $val)>;

// TODO
// ====
// * fold select/vp.select into patterns to match passthru

// Vector Gather and scatter
multiclass VectorGather<ValueType DataVT, ValueType PtrVt, ValueType MaskVT, string GTPrefix> {
  // w/o mask
  def : Pat<(DataVT (vvp_gather PtrVt:$addr, (MaskVT true_mask), i32:$avl)),
                    (!cast<Instruction>(GTPrefix#"_vvssl") $addr, 0, 0, $avl)>;
  // with mask
  def : Pat<(DataVT (vvp_gather PtrVt:$addr, MaskVT:$mask, i32:$avl)),
            (!cast<Instruction>(GTPrefix#"_vvssml") $addr, 0, 0, $mask, $avl)>;
}

defm : VectorGather<v256f64, v256i64, v256i1, "vgt">;
defm : VectorGather<v256i64, v256i64, v256i1, "vgt">;
defm : VectorGather<v256f32, v256i64, v256i1, "vgtu">;
defm : VectorGather<v256i32, v256i64, v256i1, "vgtlzx">;

multiclass VectorScatter<ValueType DataVT, ValueType PtrVt, ValueType MaskVT, string SCPrefix> {
  // w/o mask
  def : Pat<(vvp_scatter DataVT:$data, PtrVt:$addr, (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(SCPrefix#"_vvssl") $data, $addr, 0, 0, $avl)>;
  // with mask
  def : Pat<(vvp_scatter DataVT:$data, PtrVt:$addr, MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(SCPrefix#"_vvssml") $data, $addr, 0, 0, $mask, $avl)>;
}

defm : VectorScatter<v256f64, v256i64, v256i1, "vsc">;
defm : VectorScatter<v256i64, v256i64, v256i1, "vsc">;
defm : VectorScatter<v256f32, v256i64, v256i1, "vscu">;
defm : VectorScatter<v256i32, v256i64, v256i1, "vscl">;

// Vector Load and Store
multiclass VectorLoad<ValueType DataVT, ValueType PtrVt, ValueType MaskVT, int immStride, SDNode GTWithMask, SDNode LDNoMask> {
  // w/o mask
  def : Pat<(DataVT (vvp_load PtrVt:$addr, (MaskVT true_mask), i32:$avl)),
                    (LDNoMask immStride, $addr, $avl)>;
  // with mask
  def : Pat<(DataVT (vvp_load PtrVt:$addr, MaskVT:$mask, i32:$avl)),
            (GTWithMask
              (vaddul_vsvmvl $addr, (vmulul_vIvmvl immStride, (vseq_vl $avl), $mask, (IMPLICIT_DEF), $avl), $mask, (IMPLICIT_DEF), $avl),
              0, 0,
              $mask,
              $avl)>;
}

// Load patterns
defm : VectorLoad<v256f64, i64, v256i1, 8, vgt_vvssml, vld_vIsl>;
defm : VectorLoad<v256i64, i64, v256i1, 8, vgt_vvssml, vld_vIsl>;
defm : VectorLoad<v256f32, i64, v256i1, 4, vgtu_vvssml, vldu_vIsl>;
defm : VectorLoad<v256i32, i64, v256i1, 4, vgtlzx_vvssml, vldlzx_vIsl>;

multiclass VectorStore<ValueType DataVT, ValueType PtrVt, ValueType MaskVT, int immStride, SDNode STWithMask, SDNode STNoMask> {
  // w/o mask
  def : Pat<(vvp_store DataVT:$val, PtrVt:$addr, (MaskVT true_mask), i32:$avl),
            (STNoMask $val, immStride, $addr, $avl)>;
  // with mask
  def : Pat<(vvp_store DataVT:$val, PtrVt:$addr, MaskVT:$mask, i32:$avl),
            (STWithMask $val, immStride, $addr, $mask, $avl)>;
}

defm : VectorStore<v256f64, i64, v256i1, 8, vst_vIsml, vst_vIsl>;
defm : VectorStore<v256i64, i64, v256i1, 8, vst_vIsml, vst_vIsl>;
defm : VectorStore<v256f32, i64, v256i1, 4, vstu_vIsml, vstu_vIsl>; 
defm : VectorStore<v256i32, i64, v256i1, 4, vstl_vIsml, vstl_vIsl>; 

// Floating-point arithmetic

multiclass VectorBinaryArith_Base<SDPatternOperator OpNode, ValueType DataVT, ValueType ScalarVT, ValueType MaskVT, string OpBaseName, SDPatternOperator CastConv, string MaskToken> {
  // w/o mask, broadcast
  def : Pat<(OpNode (DataVT (any_broadcast ScalarVT:$sx)), DataVT:$vy, (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(OpBaseName#"_vsvl") (CastConv ScalarVT:$sx), $vy, $avl)>;
  // w/o mask
  def : Pat<(OpNode DataVT:$vx, DataVT:$vy, (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(OpBaseName#"_vvvl") $vx, $vy, $avl)>;

  // with mask, broadcast
  def : Pat<(OpNode (DataVT (any_broadcast ScalarVT:$sx)), DataVT:$vy, MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(OpBaseName#"_vsv"#MaskToken#"vl") (CastConv ScalarVT:$sx), $vy, $mask, (DataVT (IMPLICIT_DEF)), $avl)>;
  // with mask
  def : Pat<(OpNode DataVT:$vx, DataVT:$vy, MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(OpBaseName#"_vvv"#MaskToken#"vl") $vx, $vy, $mask, (DataVT (IMPLICIT_DEF)), $avl)>;
  // TODO fold select into op
  // TODO commutative operators
}

// standard binary operator (for i64/f64 data)
multiclass VectorBinaryArith<SDPatternOperator OpNode, ValueType DataVT, ValueType ScalarVT, ValueType MaskVT, string OpBaseName, string MaskToken="m">
  : VectorBinaryArith_Base<OpNode, DataVT, ScalarVT, MaskVT, OpBaseName, idcast, MaskToken>;

// Expand both 64bit and 32 bit variant (256 elements)
multiclass VectorBinaryArith_ShortLong<SDPatternOperator OpNode, ValueType LongDataVT, ValueType LongScalarVT, string LongOpBaseName, ValueType ShortDataVT, ValueType ShortScalarVT, string ShortOpBaseName, SDPatternOperator CastConv=idcast> {
  defm : VectorBinaryArith_Base<OpNode, LongDataVT, LongScalarVT, v256i1, LongOpBaseName, idcast, "m">;
  defm : VectorBinaryArith_Base<OpNode, ShortDataVT, ShortScalarVT, v256i1, ShortOpBaseName, CastConv, "m">;
}

multiclass VectorShiftArith<SDPatternOperator OpNode, ValueType DataVT, ValueType ScalarVT, ValueType MaskVT, string OpBaseName, SDPatternOperator ElemConv, string MaskToken="m"> {
  // w/o mask, broadcast
  def : Pat<(DataVT (OpNode DataVT:$vx, (DataVT (any_broadcast ScalarVT:$sy)), (MaskVT true_mask), i32:$avl)),
            (!cast<Instruction>(OpBaseName#"_vvsl") $vx, (ElemConv ScalarVT:$sy), $avl)>;
  // w/o mask
  def : Pat<(DataVT (OpNode DataVT:$vx, DataVT:$vy, MaskVT:$vm, i32:$avl)),
            (!cast<Instruction>(OpBaseName#"_vvv"#MaskToken#"vl") $vx, $vy, $vm, (DataVT (IMPLICIT_DEF)), $avl)>;
  // TODO fold select into op
}

// Expand both 64bit and 32 bit variant (256 elements)
multiclass VectorShiftArith_ShortLong<SDPatternOperator OpNode, ValueType LongDataVT, ValueType LongScalarVT, string LongOpBaseName, ValueType ShortDataVT, ValueType ShortScalarVT, string ShortOpBaseName> {
  defm : VectorShiftArith<OpNode, LongDataVT, LongScalarVT, v256i1, LongOpBaseName, idcast>;
  defm : VectorShiftArith<OpNode, ShortDataVT, ShortScalarVT, v256i1, ShortOpBaseName, i32_to_i64>;
}

multiclass VectorTernaryArith<SDPatternOperator OpNode, ValueType DataVT, ValueType ScalarVT, ValueType MaskVT, string OpBaseName, string MaskToken="m"> {
  // w/o mask, broadcast first
  def : Pat<(OpNode (DataVT (any_broadcast ScalarVT:$sx)), DataVT:$vy, DataVT:$vz, (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(OpBaseName#"_vsvvl") $sx, $vy, $vz, $avl)>;
  // w/o mask, broadcast second
  def : Pat<(OpNode DataVT:$vx, (DataVT (any_broadcast ScalarVT:$sy)), DataVT:$vz, (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(OpBaseName#"_vvsvl") $vx, $sy, $vz, $avl)>;
  // w/o mask
  def : Pat<(OpNode DataVT:$vx, DataVT:$vy, DataVT:$vz, (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(OpBaseName#"_vvvvl") $vx, $vy, $vz, $avl)>;

  // with mask, broadcast first
  def : Pat<(OpNode (DataVT (any_broadcast ScalarVT:$sx)), DataVT:$vy, DataVT:$vz, MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(OpBaseName#"_vsvv"#MaskToken#"vl") $sx, $vy, $vz, $mask, (DataVT (IMPLICIT_DEF)), $avl)>;
  // with mask, broadcast second
  def : Pat<(OpNode DataVT:$vx, (DataVT (any_broadcast ScalarVT:$sy)), DataVT:$vz, MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(OpBaseName#"_vvsv"#MaskToken#"vl") $vx, $sy, $vz, $mask, (DataVT (IMPLICIT_DEF)), $avl)>;
  // with mask
  def : Pat<(OpNode DataVT:$vx, DataVT:$vy, DataVT:$vz, MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(OpBaseName#"_vvvv"#MaskToken#"vl") $vx, $vy, $vz, $mask, (DataVT (IMPLICIT_DEF)), $avl)>;
  // TODO fold select
  // TODO commutativity
}

// Expand both 64bit and 32 bit variant (256 elements)
multiclass VectorTernaryArith_ShortLong<SDPatternOperator OpNode, ValueType LongDataVT, ValueType LongScalarVT, string LongOpBaseName, ValueType ShortDataVT, ValueType ShortScalarVT, string ShortOpBaseName> {
  defm : VectorTernaryArith<OpNode, LongDataVT, LongScalarVT, v256i1, LongOpBaseName>;
  defm : VectorTernaryArith<OpNode, ShortDataVT, ShortScalarVT, v256i1, ShortOpBaseName>;
}


// Integer arithmetic (256 elements)
defm : VectorBinaryArith_ShortLong<c_vv_add, v256i64, i64, "vaddsl", v256i32, i32, "vaddswsx">;
defm : VectorBinaryArith_ShortLong<vvp_sub, v256i64, i64, "vsubsl", v256i32, i32, "vsubswsx">;
defm : VectorBinaryArith_ShortLong<c_vv_mul, v256i64, i64, "vmulsl", v256i32, i32, "vmulswsx">;
defm : VectorBinaryArith_ShortLong<vvp_sdiv, v256i64, i64, "vdivsl", v256i32, i32, "vdivswsx">;
defm : VectorBinaryArith_ShortLong<vvp_udiv, v256i64, i64, "vdivul", v256i32, i32, "vdivuw">;

defm : VectorShiftArith_ShortLong<vvp_srl, v256i64, i64, "vsrl", v256i32, i32, "pvsrllo">;
defm : VectorShiftArith_ShortLong<vvp_sra, v256i64, i64, "vsral", v256i32, i32, "pvsralo">;
defm : VectorShiftArith_ShortLong<vvp_shl, v256i64, i64, "vsll", v256i32, i32, "pvslllo">;

defm : VectorBinaryArith_ShortLong<vvp_and, v256i64, i64, "vand", v256i32, i32, "pvandlo", i32_to_i64>;
defm : VectorBinaryArith_ShortLong<vvp_xor, v256i64, i64, "vxor", v256i32, i32, "pvxorlo", i32_to_i64>;
defm : VectorBinaryArith_ShortLong<vvp_or, v256i64, i64, "vor", v256i32, i32, "pvorlo", i32_to_i64>;

// Floating-point arithmetic (256 elements)
defm : VectorBinaryArith_ShortLong<c_vv_fadd, v256f64, f64, "vfaddd", v256f32, f32, "vfadds">;
defm : VectorBinaryArith_ShortLong<vvp_fsub, v256f64, f64, "vfsubd", v256f32, f32, "vfsubs">;
defm : VectorBinaryArith_ShortLong<c_vv_fmul, v256f64, f64, "vfmuld", v256f32, f32, "vfmuls">;
defm : VectorBinaryArith_ShortLong<vvp_fdiv, v256f64, f64, "vfdivd", v256f32, f32, "vfdivs">;

defm : VectorBinaryArith_ShortLong<c_vv_fminnum, v256f64, f64, "vfmind", v256f32, f32, "vfmins">;
defm : VectorBinaryArith_ShortLong<c_vv_fmaxnum, v256f64, f64, "vfmaxd", v256f32, f32, "vfmaxs">;

defm : VectorTernaryArith_ShortLong<c_vv_ffma, v256f64, f64, "vfmadd", v256f32, f32, "vfmads">;

// Element-wise select (256 elements)
multiclass VectorSelect<ValueType DataVT, ValueType ScalarVT> {
    def :Pat<(DataVT (vvp_select v256i1:$vm, DataVT:$vtrue, DataVT:$vfalse, i32:$vl)),
                     (vmrg_vvvml $vtrue, $vfalse, $vm, $vl)>;
}

defm : VectorSelect<v256f64, f64>;
defm : VectorSelect<v256i64, i64>;
defm : VectorSelect<v256i32, i32>;
defm : VectorSelect<v256f32, f32>;

///// Comparison (VVP_SETCC) /////

multiclass Set_CC<ValueType MaskVT, ValueType DataVT, string FmkBaseName, string CmpBaseName, SDPatternOperator CCMatcher, SDPatternOperator CCConv, string MaskTag="m"> {
  def : Pat<(MaskVT (vvp_setcc DataVT:$LHS, DataVT:$RHS, CCMatcher:$cond, MaskVT:$vm, i32:$vl)),
                    (!cast<Instruction>(FmkBaseName#"_"#MaskTag#"vC"#MaskTag#"l") (!cast<Instruction>(CmpBaseName#"_vvvl") $LHS, $RHS, $vl), (CCConv $cond), $vm, $vl)>;
}

multiclass Set_CC_256<ValueType DataVT, string FmkBaseName, string CmpBaseName, SDPatternOperator CCMatcher, SDPatternOperator CCConv>
  : Set_CC<v256i1, DataVT, FmkBaseName, CmpBaseName, CCMatcher, CCConv, "m">;

multiclass Set_CC_512<ValueType DataVT, string CmpBaseName, SDPatternOperator CCMatcher, SDPatternOperator CCConv>
  : Set_CC<v512i1, DataVT, "pvfmkw", CmpBaseName, CCMatcher, CCConv, "M">;

// SETCC (256)
defm : Set_CC_256<v256i64,"vfmkl","vcmpul",CCUIOp,icond2cc>;
defm : Set_CC_256<v256i64,"vfmkl","vcmpsl",CCSIOp,icond2cc>;
defm : Set_CC_256<v256f64,"vfmkl","vfcmpd",cond,fcond2cc>;

defm : Set_CC_256<v256i32,"vfmkw","vcmpuw",CCUIOp,icond2cc>;
defm : Set_CC_256<v256i32,"vfmkw","vcmpswzx",CCSIOp,icond2cc>;
defm : Set_CC_256<v256f32,"vfmks","vfcmps",cond,fcond2cc>;

// SETCC (packed)
defm : Set_CC_512<v512i32,"pvcmpu",CCUIOp,icond2cc>;
defm : Set_CC_512<v512i32,"pvcmps",CCSIOp,icond2cc>;
defm : Set_CC_512<v512f32,"pvfcmp",cond,fcond2cc>;

///// Conversion /////

// x_to_y
multiclass conv_x_to_y<SDPatternOperator MatchOp, ValueType MaskVT, ValueType DestVT, ValueType SrcVT, string ConvBaseName, string MaskToken> {
  def : Pat<(DestVT (MatchOp SrcVT:$vx, MaskVT:$vm, i32:$vl)),
                    (!cast<Instruction>(ConvBaseName#"_vv"#MaskToken#"vl") $vx,$vm,(DestVT IMPLICIT_DEF),$vl)>;
  // TODO unmasked, add implicit fold with select
}

multiclass both_x_to_y<ValueType MaskVT, ValueType FPVT, string FPTag, string IVT, string ITag, string IExtTag="", string ConvBaseName="vcvt", string MaskToken="m"> {
 defm : conv_x_to_y<vvp_sint_to_fp, MaskVT, FPVT, IVT, ConvBaseName#FPTag#ITag, MaskToken>;
 defm : conv_x_to_y<vvp_fp_to_sint, MaskVT, IVT, FPVT, ConvBaseName#ITag#FPTag#IExtTag, MaskToken>;
}

// iN <> fpN
defm: both_x_to_y<v256i1, v256f32, "s", v256i32, "w", "zx">;
defm: both_x_to_y<v256i1, v256f64, "d", v256i64, "l">;
defm: both_x_to_y<v512i1, v512f32, "s", v512i32, "w", "", "pvcvt", "M">;

// TODO...
// i64 <> f32
// f32 <> i64

// fpext, fpround (256 only)
defm : conv_x_to_y<vvp_fpround, v256i1, v256f32, v256f64, "vcvtsd", "m">;
defm : conv_x_to_y<vvp_fpext, v256i1, v256f64, f256f32, "vcvtds", "m">;


///// ARITHMETIC /////
// Integer arithmetic (512 elements)
defm : VectorBinaryArith<c_vv_add, v512i32, i64, v512i1, "pvaddu", "M">; 
defm : VectorBinaryArith<vvp_sub, v512i32, i64, v512i1, "pvsubu", "M">;
// defm : VectorBinaryArith<vvp_mul, v512i32, i64, "vmulsl", "M">; // no packed mul
// defm : VectorBinaryArith<vvp_sdiv, v512i32, i64, "vdivsl", "M">; // no packed sdiv
// defm : VectorBinaryArith<vvp_udiv, v512i32, i64, "vdivul", "M">; // no packed udiv
defm : VectorShiftArith<vvp_srl, v512i32, i64, v512i1, "pvsrl", idcast, "M">;
defm : VectorShiftArith<vvp_sra, v512i32, i64, v512i1, "pvsra", idcast, "M">;
defm : VectorShiftArith<vvp_shl, v512i32, i64, v512i1, "pvsll", idcast, "M">;


// Floating-point arithmetic (512 elements)
defm : VectorBinaryArith<c_vv_fadd, v512f32, i64, v512i1, "pvfadd", "M">;
defm : VectorBinaryArith<c_vv_fmul, v512f32, i64, v512i1, "pvfmul", "M">;
defm : VectorBinaryArith<vvp_fsub, v512f32, i64, v512i1, "pvfsub", "M">;
defm : VectorBinaryArith<c_vv_fminnum, v512f32, i64, v512i1, "pvfmin", "M">;
defm : VectorBinaryArith<c_vv_fmaxnum, v512f32, i64, v512i1, "pvfmax", "M">;

defm : VectorTernaryArith<c_vv_ffma, v512f32, i64, v512i1, "pvfmad", "M">;
