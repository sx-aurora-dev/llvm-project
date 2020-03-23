// The backend translates VP and regular vector operations into vvp_* nodes
// This file defines the isel patterns
// The vvp_nodes are defined in..

include "VVPInstrInfo.td"

// Conversion operators
// def f32_to_i64 : OutPatFrag<(ops node:$val), (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32)>;
// def i32_to_i64 : OutPatFrag<(ops node:$val), (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32)>;
// def idcast : OutPatFrag<(ops node:$val), (COPY $val)>;


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

multiclass VectorLoadStore_Packed<ValueType DataVT, ValueType PtrVt, ValueType MaskVT, int immStride, SDNode LDNoMask, SDNode STNoMask> {
  // w/o mask
  def : Pat<(DataVT (vvp_load PtrVt:$addr, (MaskVT true_mask), i32:$avl)),
                    (LDNoMask immStride, $addr, $avl)>;
  // FIXME
  // def : Pat<(vvp_store PtrVt:$addr, DataVT:$vx, (MaskVT true_mask), i32:$avl),
  //           (STNoMask $vx, immStride, $addr, $avl)>;
}


// Load patterns
defm : VectorLoad<v256f64, i64, v256i1, 8, vgt_vvssml, vld_vIsl>;
defm : VectorLoad<v256i64, i64, v256i1, 8, vgt_vvssml, vld_vIsl>;
defm : VectorLoad<v256f32, i64, v256i1, 4, vgtu_vvssml, vldu_vIsl>;
defm : VectorLoad<v256i32, i64, v256i1, 4, vgtlzx_vvssml, vldlzx_vIsl>;
// packed load patterns
defm : VectorLoadStore_Packed<v512i32, i64, v512i1, 8, vld_vIsl, vst_vIsl>;
defm : VectorLoadStore_Packed<v512f32, i64, v512i1, 8, vld_vIsl, vst_vIsl>;

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

multiclass VectorBinaryArith_Base<SDPatternOperator OpNode, ValueType ScalarVT, ValueType DataVT, ValueType MaskVT, string OpBaseName, string MaskToken> {
  // w/o mask, broadcast
  def : Pat<(OpNode (DataVT (any_broadcast ScalarVT:$sx)), DataVT:$vy, (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(OpBaseName#"_vsvl") ScalarVT:$sx, $vy, $avl)>;
  // w/o mask
  def : Pat<(OpNode DataVT:$vx, DataVT:$vy, (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(OpBaseName#"_vvvl") $vx, $vy, $avl)>;

  // with mask, broadcast
  def : Pat<(OpNode (DataVT (any_broadcast ScalarVT:$sx)), DataVT:$vy, MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(OpBaseName#"_vsv"#MaskToken#"vl") ScalarVT:$sx, $vy, $mask, (DataVT (IMPLICIT_DEF)), $avl)>;
  // with mask
  def : Pat<(OpNode DataVT:$vx, DataVT:$vy, MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(OpBaseName#"_vvv"#MaskToken#"vl") $vx, $vy, $mask, (DataVT (IMPLICIT_DEF)), $avl)>;
  // TODO fold select into op
  // TODO commutative operators
}

// standard binary operator (for i64/f64 data)
multiclass VectorBinaryArith<SDPatternOperator OpNode, ValueType ScalarVT, ValueType DataVT, ValueType MaskVT, string OpBaseName, string MaskToken="m">
  : VectorBinaryArith_Base<OpNode, ScalarVT, DataVT, MaskVT, OpBaseName, MaskToken>;

// Expand both 64bit and 32 bit variant (256 elements)
multiclass VectorBinaryArith_ShortLong<SDPatternOperator OpNode, ValueType LongScalarVT, ValueType LongDataVT, string LongOpBaseName, ValueType ShortScalarVT, ValueType ShortDataVT, string ShortOpBaseName> {
  defm : VectorBinaryArith_Base<OpNode, LongScalarVT, LongDataVT, v256i1, LongOpBaseName, "m">;
  defm : VectorBinaryArith_Base<OpNode, ShortScalarVT, ShortDataVT, v256i1, ShortOpBaseName, "m">;
}

multiclass VectorShiftArith<SDPatternOperator OpNode, ValueType ScalarVT, ValueType DataVT, ValueType MaskVT, string OpBaseName, string MaskToken="m"> {
  // w/o mask, broadcast
  def : Pat<(DataVT (OpNode DataVT:$vx, (DataVT (any_broadcast ScalarVT:$sy)), (MaskVT true_mask), i32:$avl)),
            (!cast<Instruction>(OpBaseName#"_vvsl") $vx, ScalarVT:$sy, $avl)>;
  // w/o mask
  def : Pat<(DataVT (OpNode DataVT:$vx, DataVT:$vy, MaskVT:$vm, i32:$avl)),
            (!cast<Instruction>(OpBaseName#"_vvv"#MaskToken#"vl") $vx, $vy, $vm, (DataVT (IMPLICIT_DEF)), $avl)>;
  // TODO fold select into op
}

// Expand both 64bit and 32 bit variant (256 elements)
multiclass VectorShiftArith_ShortLong<SDPatternOperator OpNode, ValueType LongScalarVT, ValueType LongDataVT, string LongOpBaseName, ValueType ShortScalarVT, ValueType ShortDataVT, string ShortOpBaseName> {
  defm : VectorShiftArith<OpNode, LongScalarVT, LongDataVT, v256i1, LongOpBaseName>;
  defm : VectorShiftArith<OpNode, ShortScalarVT, ShortDataVT, v256i1, ShortOpBaseName>;
}

multiclass VectorTernaryArith_Base<SDPatternOperator OpNode, ValueType ScalarVT, ValueType DataVT, ValueType MaskVT, string OpBaseName, string MaskToken="m"> {
  // w/o mask, broadcast first
  def : Pat<(OpNode (DataVT (any_broadcast ScalarVT:$sx)), DataVT:$vy, DataVT:$vz, (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(OpBaseName#"_vsvvl") ScalarVT:$sx, $vy, $vz, $avl)>;
  // w/o mask, broadcast second
  def : Pat<(OpNode DataVT:$vx, (DataVT (any_broadcast ScalarVT:$sy)), DataVT:$vz, (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(OpBaseName#"_vvsvl") $vx, ScalarVT:$sy, $vz, $avl)>;
  // w/o mask
  def : Pat<(OpNode DataVT:$vx, DataVT:$vy, DataVT:$vz, (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(OpBaseName#"_vvvvl") $vx, $vy, $vz, $avl)>;

  // with mask, broadcast first
  def : Pat<(OpNode (DataVT (any_broadcast ScalarVT:$sx)), DataVT:$vy, DataVT:$vz, MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(OpBaseName#"_vsvv"#MaskToken#"vl") ScalarVT:$sx, $vy, $vz, $mask, (DataVT (IMPLICIT_DEF)), $avl)>;
  // with mask, broadcast second
  def : Pat<(OpNode DataVT:$vx, (DataVT (any_broadcast ScalarVT:$sy)), DataVT:$vz, MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(OpBaseName#"_vvsv"#MaskToken#"vl") $vx, ScalarVT:$sy, $vz, $mask, (DataVT (IMPLICIT_DEF)), $avl)>;
  // with mask
  def : Pat<(OpNode DataVT:$vx, DataVT:$vy, DataVT:$vz, MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(OpBaseName#"_vvvv"#MaskToken#"vl") $vx, $vy, $vz, $mask, (DataVT (IMPLICIT_DEF)), $avl)>;
  // TODO fold select
  // TODO commutativity
}

// Expand both 64bit and 32 bit variant (256 elements)
multiclass VectorTernaryArith_ShortLong<SDPatternOperator OpNode, ValueType LongScalarVT, ValueType LongDataVT, string LongOpBaseName, ValueType ShortScalarVT, ValueType ShortDataVT, string ShortOpBaseName> {
  defm : VectorTernaryArith_Base<OpNode, LongScalarVT, LongDataVT, v256i1, LongOpBaseName>;
  defm : VectorTernaryArith_Base<OpNode, ShortScalarVT, ShortDataVT, v256i1, ShortOpBaseName>;
}


// Integer arithmetic (256 elements)
defm : VectorBinaryArith_ShortLong<c_vv_add, i64, v256i64, "vaddsl", i32, v256i32, "vaddswsx">;
defm : VectorBinaryArith_ShortLong<vvp_sub,  i64, v256i64, "vsubsl", i32, v256i32, "vsubswsx">;
defm : VectorBinaryArith_ShortLong<c_vv_mul, i64, v256i64, "vmulsl", i32, v256i32, "vmulswsx">;
defm : VectorBinaryArith_ShortLong<vvp_sdiv, i64, v256i64, "vdivsl", i32, v256i32, "vdivswsx">;
defm : VectorBinaryArith_ShortLong<vvp_udiv, i64, v256i64, "vdivul", i32, v256i32, "vdivuw">;

defm : VectorShiftArith_ShortLong<vvp_srl, i64, v256i64, "vsrl",  i64, v256i32, "pvsrllo">;
defm : VectorShiftArith_ShortLong<vvp_sra, i64, v256i64, "vsral", i64, v256i32, "pvsralo">;
defm : VectorShiftArith_ShortLong<vvp_shl, i64, v256i64, "vsll",  i64, v256i32, "pvslllo">;

defm : VectorBinaryArith_ShortLong<vvp_and, i64, v256i64, "vand", i64, v256i32, "pvandlo">;
defm : VectorBinaryArith_ShortLong<vvp_xor, i64, v256i64, "vxor", i64, v256i32, "pvxorlo">;
defm : VectorBinaryArith_ShortLong<vvp_or,  i64, v256i64, "vor",  i64, v256i32, "pvorlo">;

// Floating-point arithmetic (256 elements)
defm : VectorBinaryArith_ShortLong<c_vv_fadd, f64, v256f64, "vfaddd", f32, v256f32, "vfadds">;
defm : VectorBinaryArith_ShortLong<vvp_fsub,  f64, v256f64, "vfsubd", f32, v256f32, "vfsubs">;
defm : VectorBinaryArith_ShortLong<c_vv_fmul, f64, v256f64, "vfmuld", f32, v256f32, "vfmuls">;
defm : VectorBinaryArith_ShortLong<vvp_fdiv,  f64, v256f64, "vfdivd", f32, v256f32, "vfdivs">;

defm : VectorBinaryArith_ShortLong<c_vv_fminnum, f64, v256f64, "vfmind", f32, v256f32, "vfmins">;
defm : VectorBinaryArith_ShortLong<c_vv_fmaxnum, f64, v256f64, "vfmaxd", f32, v256f32, "vfmaxs">;

defm : VectorTernaryArith_ShortLong<c_vv_ffma, f64, v256f64, "vfmadd", f32, v256f32, "vfmads">;

// Element-wise select (256 elements)
multiclass VectorSelect<ValueType DataVT> {
    def :Pat<(DataVT (vvp_select v256i1:$vm, DataVT:$vtrue, DataVT:$vfalse, i32:$vl)),
                     (vmrg_vvvml $vtrue, $vfalse, $vm, $vl)>;
}

defm : VectorSelect<v256f64>;
defm : VectorSelect<v256i64>;
defm : VectorSelect<v256i32>;
defm : VectorSelect<v256f32>;

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
// Pseudo instructions for i64 <> fp32 conversion
def vcvtls_vvmvl : Instruction,
PseudoInstExpansion<(vcvtldrz_vvmvl (vcvtds_vvmvl v256f32:$vy, v256i1:$vm, (v256i64 (IMPLICIT_DEF)), i32:$vl), $vm, $vpt, $vl)> {
  let Namespace="VE";
  let isPseudo = 1;
  dag OutOperandList = (outs V64:$vx);
  dag InOperandList = (ins V64:$vy, VM:$vm, V64:$vpt, I32:$vl);
  let AsmString   = ";";
}

def vcvtsl_vvmvl : Instruction,
PseudoInstExpansion<(vcvtsd_vvmvl (vcvtdl_vvmvl v256i64:$vy, v256i1:$vm, (v256i64 (IMPLICIT_DEF)), i32:$vl), $vm, $vpt, $vl)> {
  let Namespace="VE";
  let isPseudo = 1;
  dag OutOperandList = (outs V64:$vx);
  dag InOperandList = (ins V64:$vy, VM:$vm, V64:$vpt, I32:$vl);
  let AsmString   = ";";
}

// x_to_y
multiclass conv_x_to_y<SDPatternOperator MatchOp, ValueType MaskVT, ValueType DestVT, ValueType SrcVT, string ConvBaseName, string MaskToken> {
  def : Pat<(DestVT (MatchOp SrcVT:$vx, MaskVT:$vm, i32:$vl)),
                    (!cast<Instruction>(ConvBaseName#"_vv"#MaskToken#"vl") $vx, $vm, (DestVT (IMPLICIT_DEF)), $vl)>;
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

// t32 <> t64
defm: both_x_to_y<v256i1, v256f32, "s", v256i64, "l">;
defm: both_x_to_y<v256i1, v256f64, "d", v256i32, "w", "zx">;

// fpext, fpround (256 only)
defm : conv_x_to_y<vvp_fpround, v256i1, v256f32, v256f64, "vcvtsd", "m">;
defm : conv_x_to_y<vvp_fpext,   v256i1, v256f64, v256f32, "vcvtds", "m">;


///// ARITHMETIC /////
// Integer arithmetic (512 elements)
defm : VectorBinaryArith_Base<c_vv_add, i64, v512i32, v512i1, "pvaddu", "M">; 
defm : VectorBinaryArith_Base<vvp_sub,  i64, v512i32, v512i1, "pvsubu", "M">;
// defm : VectorBinaryArith_Base<vvp_mul,  i64, v512i32, "vmulsl", "M">; // no packed mul
// defm : VectorBinaryArith_Base<vvp_sdiv, i64, v512i32, "vdivsl", "M">; // no packed sdiv
// defm : VectorBinaryArith_Base<vvp_udiv, i64, v512i32, "vdivul", "M">; // no packed udiv
defm : VectorShiftArith<vvp_srl, i64, v512i32, v512i1, "pvsrl", "M">;
defm : VectorShiftArith<vvp_sra, i64, v512i32, v512i1, "pvsra", "M">;
defm : VectorShiftArith<vvp_shl, i64, v512i32, v512i1, "pvsll", "M">;


// Floating-point arithmetic (512 elements)
defm : VectorBinaryArith_Base<c_vv_fadd,    i64, v512f32, v512i1, "pvfadd", "M">;
defm : VectorBinaryArith_Base<c_vv_fmul,    i64, v512f32, v512i1, "pvfmul", "M">;
defm : VectorBinaryArith_Base<vvp_fsub,     i64, v512f32, v512i1, "pvfsub", "M">;
defm : VectorBinaryArith_Base<c_vv_fminnum, i64, v512f32, v512i1, "pvfmin", "M">;
defm : VectorBinaryArith_Base<c_vv_fmaxnum, i64, v512f32, v512i1, "pvfmax", "M">;

defm : VectorTernaryArith_Base<c_vv_ffma, i64, v512f32, v512i1, "pvfmad", "M">;

// Integer extension (256 elements) //
// vNi32 to vNi64
multiclass IExtend32<string ExtToken> {
  def : Pat<(v256i64 (!cast<SDPatternOperator>("vvp_"#ExtToken#"ext") v256i32:$vx, v256i1:$vm, i32:$vl)),
            (!cast<Instruction>("vaddsw"#ExtToken#"x_vIvmvl") 0, $vx, $vm, (v256i32 (IMPLICIT_DEF)), $vl)>;
}
defm : IExtend32<"z">;
defm : IExtend32<"s">;

// vNi1 to vNiT
multiclass IExtend_Mask<ValueType ResVT, string ExtToken, int TrueVal> {
def : Pat<(ResVT (!cast<SDPatternOperator>("vvp_"#ExtToken#"ext") v256i1:$vm, (v256i1 srcvalue), i32:$vl)),
          (vmrg_vIvml TrueVal, (vbrd_vIl 0, $vl), $vm, $vl)>;
}
multiclass IExtend_Mask_ForRes<ValueType ResVT> {
  defm: IExtend_Mask<ResVT, "z", 1>;
  defm: IExtend_Mask<ResVT, "s", -1>;
}
defm: IExtend_Mask_ForRes<v256i32>;
defm: IExtend_Mask_ForRes<v256i64>;

// Integer extension (512 elements) //
// TODO


///// Reductions (256 elements) /////
// TODO
// case VE::vfsumd_vvl: return 2;
// case VE::vfsumd_vvml: return 3;
// case VE::vfsums_vvl: return 2;
// case VE::vfsums_vvml: return 3;

def : Pat <(f64 (vvp_reduce_fadd v256f64:$vx, v256i1:$vm, i32:$vl)),
           (lvsl_svI (vfsumd_vvml $vx, $vm, $vl), 0)>;
def : Pat <(f32 (vvp_reduce_fadd v256f32:$vx, v256i1:$vm, i32:$vl)),
           (lvss_svI (vfsums_vvml $vx, $vm ,$vl), 0)>;

def : Pat <(f64 (vvp_reduce_strict_fadd f64:$sy, v256f64:$vx, (v256i1 true_mask), i32:$vl)),
           (lvsl_svI (vfiad_vvsl $vx, $sy, $vl), 0)>;
def : Pat <(f32 (vvp_reduce_strict_fadd f32:$sy, v256f32:$vx, (v256i1 true_mask), i32:$vl)),
           (lvss_svI (vfias_vvsl $vx, $sy, $vl), 0)>;

// case VE::vfiad_vsl: return 2;
// case VE::vfiad_vIl: return 2;
