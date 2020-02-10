// The backend translates VP and regular vector operations into vvp_* nodes
// This file defines the isel patterns
// The vvp_nodes are defined in..

include "VVPInstrInfo.td"


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

multiclass VectorBinaryArith<SDPatternOperator OpNode, ValueType DataVT, ValueType ScalarVT, ValueType MaskVT, string OpBaseName, string MaskToken="m"> {
  // w/o mask, broadcast
  def : Pat<(OpNode (DataVT (any_broadcast ScalarVT:$sx)), DataVT:$vy, (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(OpBaseName#"_vsvl") $sx, $vy, $avl)>;
  // w/o mask
  def : Pat<(OpNode DataVT:$vx, DataVT:$vy, (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(OpBaseName#"_vvvl") $vx, $vy, $avl)>;

  // with mask, broadcast
  def : Pat<(OpNode (DataVT (any_broadcast ScalarVT:$sx)), DataVT:$vy, MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(OpBaseName#"_vsv"#MaskToken#"vl") $sx, $vy, $mask, (DataVT (IMPLICIT_DEF)), $avl)>;
  // with mask
  def : Pat<(OpNode DataVT:$vx, DataVT:$vy, MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(OpBaseName#"_vvv"#MaskToken#"vl") $vx, $vy, $mask, (DataVT (IMPLICIT_DEF)), $avl)>;
  // TODO fold select into op
  // TODO commutative operators
}

// Expand both 64bit and 32 bit variant (256 elements)
multiclass VectorBinaryArith_ShortLong<SDPatternOperator OpNode, ValueType LongDataVT, ValueType LongScalarVT, string LongOpBaseName, ValueType ShortDataVT, ValueType ShortScalarVT, string ShortOpBaseName> {
  defm : VectorBinaryArith<OpNode, LongDataVT, LongScalarVT, v256i1, LongOpBaseName>;
  defm : VectorBinaryArith<OpNode, ShortDataVT, ShortScalarVT, v256i1, ShortOpBaseName>;
}

multiclass VectorShiftArith<SDPatternOperator OpNode, ValueType DataVT, ValueType ScalarVT, ValueType MaskVT, string OpBaseName, string MaskToken="m"> {
  // w/o mask, broadcast
  def : Pat<(DataVT (OpNode DataVT:$vx, (DataVT (any_broadcast ScalarVT:$sy)), (MaskVT true_mask), i32:$avl)),
            (!cast<Instruction>(OpBaseName#"_vvsl") $vx, $sy, $avl)>;
  // w/o mask
  def : Pat<(DataVT (OpNode DataVT:$vx, DataVT:$vy, MaskVT:$vm, i32:$avl)),
            (!cast<Instruction>(OpBaseName#"_vvv"#MaskToken#"vl") $vx, $vy, $vm, (DataVT (IMPLICIT_DEF)), $avl)>;
  // TODO fold select into op
}

// Expand both 64bit and 32 bit variant (256 elements)
multiclass VectorShiftArith_ShortLong<SDPatternOperator OpNode, ValueType LongDataVT, ValueType LongScalarVT, string LongOpBaseName, ValueType ShortDataVT, ValueType ShortScalarVT, string ShortOpBaseName> {
  defm : VectorShiftArith<OpNode, LongDataVT, LongScalarVT, v256i1, LongOpBaseName>;
  defm : VectorShiftArith<OpNode, ShortDataVT, ShortScalarVT, v256i1, ShortOpBaseName>;
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

defm : VectorShiftArith_ShortLong<vvp_srl, v256i64, i64, "vsrl", v256i32, i64, "pvsrllo">;
defm : VectorShiftArith_ShortLong<vvp_sra, v256i64, i64, "vsral", v256i32, i64, "pvsralo">;
defm : VectorShiftArith_ShortLong<vvp_shl, v256i64, i64, "vslal", v256i32, i64, "pvslalo">;

// Floating-point arithmetic (256 elements)
defm : VectorBinaryArith_ShortLong<c_vv_fadd, v256f64, f64, "vfaddd", v256f32, f32, "vfadds">;
defm : VectorBinaryArith_ShortLong<vvp_fsub, v256f64, f64, "vfsubd", v256f32, f32, "vfsubs">;
defm : VectorBinaryArith_ShortLong<c_vv_fmul, v256f64, f64, "vfmuld", v256f32, f32, "vfmuls">;
defm : VectorBinaryArith_ShortLong<vvp_fdiv, v256f64, f64, "vfdivd", v256f32, f32, "vfdivs">;

defm : VectorTernaryArith_ShortLong<c_vv_ffma, v256f64, f64, "vfmadd", v256f32, f32, "vfmads">;

// Integer arithmetic (512 elements)
defm : VectorBinaryArith<c_vv_add, v512i32, i64, v512i1, "pvaddu", "M">; 
defm : VectorBinaryArith<vvp_sub, v512i32, i64, v512i1, "pvsubu", "M">;
// defm : VectorBinaryArith<vvp_mul, v512i32, i64, "vmulsl", "M">; // no packed mul
// defm : VectorBinaryArith<vvp_sdiv, v512i32, i64, "vdivsl", "M">; // no packed sdiv
// defm : VectorBinaryArith<vvp_udiv, v512i32, i64, "vdivul", "M">; // no packed udiv
defm : VectorShiftArith<vvp_srl, v512i32, i64, v512i1, "pvsrl", "M">;
defm : VectorShiftArith<vvp_sra, v512i32, i64, v512i1, "pvsra", "M">;
defm : VectorShiftArith<vvp_shl, v512i32, i64, v512i1, "pvsll", "M">;


// Floating-point arithmetic (512 elements)
defm : VectorBinaryArith<c_vv_fadd, v512f32, i64, v512i1, "pvfadd", "M">;
defm : VectorBinaryArith<c_vv_fmul, v512f32, i64, v512i1, "pvfmul", "M">;
defm : VectorBinaryArith<vvp_fsub, v512f32, i64, v512i1, "pvfsub", "M">;

defm : VectorTernaryArith<c_vv_ffma, v512f32, i64, v512i1, "pvfmad", "M">;
