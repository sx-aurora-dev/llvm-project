// Conversion operators
// def f32_to_i64 : OutPatFrag<(ops node:$val), (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32)>;
// def i32_to_i64 : OutPatFrag<(ops node:$val), (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32)>;
// def idcast : OutPatFrag<(ops node:$val), (COPY $val)>;


// TODO
// ====
// * fold select/vp.select into patterns to match passthru

// Vector Gather and scatter
multiclass VectorGather<ValueType DataVT, ValueType PtrVT, ValueType MaskVT, string GTPrefix> {
  // w/o mask
  def : Pat<(DataVT (vvp_gather PtrVT:$addr, (MaskVT true_mask), i32:$avl)),
                    (!cast<Instruction>(GTPrefix#"vizl") $addr, 0, 0, $avl)>;
  // with mask
  def : Pat<(DataVT (vvp_gather PtrVT:$addr, MaskVT:$mask, i32:$avl)),
            (!cast<Instruction>(GTPrefix#"vizml") $addr, 0, 0, $mask, $avl)>;
}

defm : VectorGather<v256f64, v256i64, v256i1, "VGT">;
defm : VectorGather<v256i64, v256i64, v256i1, "VGT">;
defm : VectorGather<v256f32, v256i64, v256i1, "VGTU">;
defm : VectorGather<v256i32, v256i64, v256i1, "VGTLZX">;

multiclass VectorScatter<ValueType DataVT, ValueType PtrVT, ValueType MaskVT, string SCPrefix> {
  // w/o mask
  def : Pat<(vvp_scatter DataVT:$data, PtrVT:$addr, (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(SCPrefix#"vizvl") $data, 0, 0, $addr, $avl)>;
  // with mask
  def : Pat<(vvp_scatter DataVT:$data, PtrVT:$addr, MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(SCPrefix#"vizvml") $data, 0, 0, $addr, $mask, $avl)>;
}

defm : VectorScatter<v256f64, v256i64, v256i1, "VSC">;
defm : VectorScatter<v256i64, v256i64, v256i1, "VSC">;
defm : VectorScatter<v256f32, v256i64, v256i1, "VSCU">;
defm : VectorScatter<v256i32, v256i64, v256i1, "VSCL">;

// Vector Load and Store
multiclass VectorLoad<ValueType DataVT, ValueType PtrVT, ValueType MaskVT, SDNode GTWithMask, SDNode LDNoMask> {
  // w/o mask (imm)
  def : Pat<(DataVT (vvp_load PtrVT:$addr, (i64 simm7:$stride), (MaskVT true_mask), i32:$avl)),
                    (!cast<Instruction>(LDNoMask#"irl") (LO7 $stride), $addr, $avl)>;
  // w/o mask
  def : Pat<(DataVT (vvp_load PtrVT:$addr, i64:$stride, (MaskVT true_mask), i32:$avl)),
                    (!cast<Instruction>(LDNoMask#"rrl") $stride, PtrVT:$addr, $avl)>;
  // with mask (imm)
  def : Pat<(DataVT (vvp_load PtrVT:$addr, (i64 simm7:$stride), MaskVT:$mask, i32:$avl)),
            (!cast<Instruction>(GTWithMask#"vizml")
              (VADDULrvml $addr, (VMULULivml (LO7 $stride), (VSEQl $avl), $mask, $avl), $mask, $avl),
              0, 0,
              $mask,
              $avl)>;
  // with mask
  def : Pat<(DataVT (vvp_load PtrVT:$addr, i64:$stride, MaskVT:$mask, i32:$avl)),
            (!cast<Instruction>(GTWithMask#"vizml")
              (VADDULrvml $addr, (VMULULrvml $stride, (VSEQl $avl), $mask, $avl), $mask, $avl),
              0, 0,
              $mask,
              $avl)>;
}

multiclass VectorLoadStore_Packed<ValueType DataVT, ValueType PtrVT, ValueType MaskVT, SDNode LDNoMask, SDNode STNoMask> {
  // w/o mask
  def : Pat<(DataVT (vvp_load PtrVT:$addr, (i64 simm7:$stride), (MaskVT true_mask), i32:$avl)),
                    (!cast<Instruction>(LDNoMask#"irl") (LO7 $stride), $addr, $avl)>;
  def : Pat<(DataVT (vvp_load PtrVT:$addr, i64:$stride, (MaskVT true_mask), i32:$avl)),
                    (!cast<Instruction>(LDNoMask#"rrl") $stride, $addr, $avl)>;

  // masked
  def : Pat<(vvp_store DataVT:$vx, PtrVT:$addr, (i64 simm7:$stride), (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(STNoMask#"irvl") (LO7 $stride), $addr, $vx, $avl)>;
  def : Pat<(vvp_store DataVT:$vx, PtrVT:$addr, i64:$stride, (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(STNoMask#"rrvl") $stride, $addr, $vx, $avl)>;
}


// Load patterns
defm : VectorLoad<v256f64, i64, v256i1, "VGT",    "VLD">;
defm : VectorLoad<v256i64, i64, v256i1, "VGT",    "VLD">;
defm : VectorLoad<v256f32, i64, v256i1, "VGTU",   "VLDU">;
defm : VectorLoad<v256i32, i64, v256i1, "VGTLZX", "VLDLZX">;
// packed load patterns
defm : VectorLoadStore_Packed<v512i32, i64, v512i1, "VLD", "VST">;
defm : VectorLoadStore_Packed<v512f32, i64, v512i1, "VLD", "VST">;

multiclass VectorStore<ValueType DataVT, ValueType PtrVT, ValueType MaskVT, SDNode STWithMask, SDNode STNoMask> {
  // w/o mask
  def : Pat<(vvp_store DataVT:$val, PtrVT:$addr, (i64 simm7:$stride), (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(STNoMask#"irvl") (LO7 $stride), $addr, $val, $avl)>;
  def : Pat<(vvp_store DataVT:$val, PtrVT:$addr, i64:$stride, (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(STNoMask#"rrvl") $stride, $addr, $val, $avl)>;
  // with mask
  def : Pat<(vvp_store DataVT:$val, PtrVT:$addr, (i64 simm7:$stride), MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(STWithMask#"irvml") (LO7 $stride), $addr, $val, $mask, $avl)>;
  def : Pat<(vvp_store DataVT:$val, PtrVT:$addr, i64:$stride, MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(STWithMask#"rrvml") $stride, $addr, $val, $mask, $avl)>;
}

defm : VectorStore<v256f64, i64, v256i1, "VST",  "VST">;
defm : VectorStore<v256i64, i64, v256i1, "VST",  "VST">;
defm : VectorStore<v256f32, i64, v256i1, "VSTU", "VSTU">; 
defm : VectorStore<v256i32, i64, v256i1, "VSTL", "VSTL">; 

// Floating-point arithmetic

multiclass VectorUnaryArith_Base<SDPatternOperator OpNode, ValueType ScalarVT, ValueType DataVT, ValueType MaskVT, string OpBaseName> {
  ///// with vvp_select /////
  // with mask
  def : Pat<(vvp_select (OpNode DataVT:$vx, (MaskVT srcvalue), (i32 srcvalue)),
                        DataVT:$vfalse,
                        MaskVT:$mask,
                        i32:$avl),
            (!cast<Instruction>(OpBaseName#"vml_v") $vx, $mask, $avl, $vfalse)>;

  ///// w/o mask /////
  // w/o mask
  def : Pat<(OpNode DataVT:$vx, (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(OpBaseName#"vl") $vx, $avl)>;

  ///// with mask, no select /////
  def : Pat<(OpNode DataVT:$vx, MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(OpBaseName#"vml") $vx, $mask, $avl)>;
}

// Expand both 64bit and 32 bit variant (256 elements)
multiclass VectorUnaryArith_ShortLong<SDPatternOperator OpNode, ValueType LongScalarVT, ValueType LongDataVT, string LongOpBaseName, ValueType ShortScalarVT, ValueType ShortDataVT, string ShortOpBaseName> {
  defm : VectorUnaryArith_Base<OpNode, LongScalarVT, LongDataVT, v256i1, LongOpBaseName>;
  defm : VectorUnaryArith_Base<OpNode, ShortScalarVT, ShortDataVT, v256i1, ShortOpBaseName>;
}

multiclass VectorBinaryArith_Base<SDPatternOperator OpNode, ValueType ScalarVT, ValueType DataVT, ValueType MaskVT, string OpBaseName> {
  ///// with vvp_select /////
  // with mask, broadcast
  def : Pat<(vvp_select (OpNode (any_broadcast ScalarVT:$sx), DataVT:$vy, (MaskVT srcvalue), (i32 srcvalue)),
                        DataVT:$vfalse,
                        MaskVT:$mask,
                        i32:$avl),
            (!cast<Instruction>(OpBaseName#"rvml_v") ScalarVT:$sx, $vy, $mask, $avl, $vfalse)>;
  // with mask
  def : Pat<(vvp_select (OpNode DataVT:$vx, DataVT:$vy, (MaskVT srcvalue), (i32 srcvalue)),
                        DataVT:$vfalse,
                        MaskVT:$mask,
                        i32:$avl),
            (!cast<Instruction>(OpBaseName#"vvml_v") $vx, $vy, $mask, $avl, $vfalse)>;

  ///// w/o mask /////
  // w/o mask, broadcast
  def : Pat<(OpNode (any_broadcast ScalarVT:$sx), DataVT:$vy, (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(OpBaseName#"rvl") ScalarVT:$sx, $vy, $avl)>;
  // w/o mask
  def : Pat<(OpNode DataVT:$vx, DataVT:$vy, (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(OpBaseName#"vvl") $vx, $vy, $avl)>;

  //// ///// with mask, no select /////
  // with mask, broadcast
  def : Pat<(OpNode (any_broadcast ScalarVT:$sx), DataVT:$vy, MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(OpBaseName#"rvml") ScalarVT:$sx, $vy, $mask, $avl)>;
  // with mask
  def : Pat<(OpNode DataVT:$vx, DataVT:$vy, MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(OpBaseName#"vvml") $vx, $vy, $mask, $avl)>;
}

// standard binary operator (for i64/f64 data)
multiclass VectorBinaryArith<SDPatternOperator OpNode, ValueType ScalarVT, ValueType DataVT, ValueType MaskVT, string OpBaseName>
  : VectorBinaryArith_Base<OpNode, ScalarVT, DataVT, MaskVT, OpBaseName>;

// Expand both 64bit and 32 bit variant (256 elements)
multiclass VectorBinaryArith_ShortLong<SDPatternOperator OpNode, ValueType LongScalarVT, ValueType LongDataVT, string LongOpBaseName, ValueType ShortScalarVT, ValueType ShortDataVT, string ShortOpBaseName> {
  defm : VectorBinaryArith_Base<OpNode, LongScalarVT, LongDataVT, v256i1, LongOpBaseName>;
  defm : VectorBinaryArith_Base<OpNode, ShortScalarVT, ShortDataVT, v256i1, ShortOpBaseName>;
}

multiclass VectorShiftArith<SDPatternOperator OpNode, ValueType ScalarVT, ValueType DataVT, ValueType MaskVT, string OpBaseName, string MaskToken="m"> {
  // w/o mask, broadcast
  def : Pat<(DataVT (OpNode DataVT:$vx, (DataVT (any_broadcast ScalarVT:$sy)), (MaskVT true_mask), i32:$avl)),
            (!cast<Instruction>(OpBaseName#"vrl") DataVT:$vx, ScalarVT:$sy, i32:$avl)>;
  // w/o mask
  def : Pat<(DataVT (OpNode DataVT:$vx, DataVT:$vy, MaskVT:$vm, i32:$avl)),
            (!cast<Instruction>(OpBaseName#"vvml") $vx, $vy, $vm, $avl)>;
  // TODO fold select into op
}

// Expand both 64bit and 32 bit variant (256 elements)
multiclass VectorShiftArith_ShortLong<SDPatternOperator OpNode, ValueType LongScalarVT, ValueType LongDataVT, string LongOpBaseName, ValueType ShortScalarVT, ValueType ShortDataVT, string ShortOpBaseName> {
  defm : VectorShiftArith<OpNode, LongScalarVT, LongDataVT, v256i1, LongOpBaseName>;
  defm : VectorShiftArith<OpNode, ShortScalarVT, ShortDataVT, v256i1, ShortOpBaseName>;
}

multiclass VectorTernaryArith_Base<SDPatternOperator OpNode, ValueType ScalarVT, ValueType DataVT, ValueType MaskVT, string OpBaseName> {
  //// Mask + vvp_select /////
  // with mask, broadcast first
  def : Pat<(vvp_select 
              (OpNode (any_broadcast ScalarVT:$sx), DataVT:$vy, DataVT:$vz, (MaskVT srcvalue), (i32 srcvalue)),
              DataVT:$vfalse,
              MaskVT:$mask,
              i32:$avl),
            (!cast<Instruction>(OpBaseName#"rvvml_v") $sx, $vy, $vz, $mask, $avl, $vfalse)>;
  // with mask, broadcast second
  def : Pat<(vvp_select (OpNode DataVT:$vx, (any_broadcast ScalarVT:$sy), DataVT:$vz, (MaskVT srcvalue), (i32 srcvalue)),
              DataVT:$vfalse,
              MaskVT:$mask,
              i32:$avl),
            (!cast<Instruction>(OpBaseName#"vrvml_v") $vx, $sy, $vz, $mask, $avl, $vfalse)>;
  // with mask
  def : Pat<(vvp_select (OpNode DataVT:$vx, DataVT:$vy, DataVT:$vz, (MaskVT srcvalue), (i32 srcvalue)),
              DataVT:$vfalse,
              MaskVT:$mask,
              i32:$avl),
            (!cast<Instruction>(OpBaseName#"vvvml_v") $vx, $vy, $vz, $mask, $avl, $vfalse)>;

  ///// w/o Mask /////
  // w/o mask, broadcast first
  def : Pat<(OpNode (any_broadcast ScalarVT:$sx), DataVT:$vy, DataVT:$vz, (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(OpBaseName#"rvvl") $sx, $vy, $vz, $avl)>;
  // w/o mask, broadcast second
  def : Pat<(OpNode DataVT:$vx, (any_broadcast ScalarVT:$sy), DataVT:$vz, (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(OpBaseName#"vrvl") $vx, $sy, $vz, $avl)>;
  // w/o mask
  def : Pat<(OpNode DataVT:$vx, DataVT:$vy, DataVT:$vz, (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(OpBaseName#"vvvl") $vx, $vy, $vz, $avl)>;

  ///// Mask /////
  // with mask, broadcast first
  def : Pat<(OpNode (any_broadcast ScalarVT:$sx), DataVT:$vy, DataVT:$vz, MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(OpBaseName#"rvvml") $sx, $vy, $vz, $mask, $avl)>;
  // with mask, broadcast second
  def : Pat<(OpNode DataVT:$vx, (any_broadcast ScalarVT:$sy), DataVT:$vz, MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(OpBaseName#"vrvml") $vx, $sy, $vz, $mask, $avl)>;
  // with mask
  def : Pat<(OpNode DataVT:$vx, DataVT:$vy, DataVT:$vz, MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(OpBaseName#"vvvml") $vx, $vy, $vz, $mask, $avl)>;
}

// Expand both 64bit and 32 bit variant (256 elements)
multiclass VectorTernaryArith_ShortLong<SDPatternOperator OpNode, ValueType LongScalarVT, ValueType LongDataVT, string LongOpBaseName, ValueType ShortScalarVT, ValueType ShortDataVT, string ShortOpBaseName> {
  defm : VectorTernaryArith_Base<OpNode, LongScalarVT, LongDataVT, v256i1, LongOpBaseName>;
  defm : VectorTernaryArith_Base<OpNode, ShortScalarVT, ShortDataVT, v256i1, ShortOpBaseName>;
}


// Integer arithmetic (256 elements)
defm : VectorUnaryArith_ShortLong<vvp_ctpop, i64, v256i64, "VPCNT", i32, v256i32, "PVPCNTLO">;

defm : VectorBinaryArith_ShortLong<c_vv_add, i64, v256i64, "VADDSL", i32, v256i32, "VADDSWSX">;

defm : VectorBinaryArith_ShortLong<vvp_sub,  i64, v256i64, "VSUBSL", i32, v256i32, "VSUBSWSX">;
defm : VectorBinaryArith_ShortLong<c_vv_mul, i64, v256i64, "VMULSL", i32, v256i32, "VMULSWSX">;
defm : VectorBinaryArith_ShortLong<vvp_sdiv, i64, v256i64, "VDIVSL", i32, v256i32, "VDIVSWSX">;
defm : VectorBinaryArith_ShortLong<vvp_udiv, i64, v256i64, "VDIVUL", i32, v256i32, "VDIVUW">;

defm : VectorShiftArith_ShortLong<vvp_srl, i64, v256i64, "VSRL",  i32, v256i32, "PVSRLLO">;
defm : VectorShiftArith_ShortLong<vvp_sra, i64, v256i64, "VSRAL", i32, v256i32, "PVSRALO">;
defm : VectorShiftArith_ShortLong<vvp_shl, i64, v256i64, "VSLL",  i32, v256i32, "PVSLLLO">;

defm : VectorBinaryArith_ShortLong<vvp_and, i64, v256i64, "VAND", i32, v256i32, "PVANDLO">;
defm : VectorBinaryArith_ShortLong<vvp_xor, i64, v256i64, "VXOR", i32, v256i32, "PVXORLO">;
defm : VectorBinaryArith_ShortLong<vvp_or,  i64, v256i64, "VOR",  i32, v256i32, "PVORLO">;

// Floating-point arithmetic (256 elements)
defm : VectorUnaryArith_ShortLong<vvp_fsqrt, f64, v256f64, "VFSQRTD", f32, v256f32, "VFSQRTS">; 
defm : VectorBinaryArith_ShortLong<c_vv_fadd, f64, v256f64, "VFADDD", f32, v256f32, "PVFADDUP">;
defm : VectorBinaryArith_ShortLong<vvp_fsub,  f64, v256f64, "VFSUBD", f32, v256f32, "PVFSUBUP">;
defm : VectorBinaryArith_ShortLong<c_vv_fmul, f64, v256f64, "VFMULD", f32, v256f32, "PVFMULUP">;
defm : VectorBinaryArith_ShortLong<vvp_fdiv,  f64, v256f64, "VFDIVD", f32, v256f32, "VFDIVS">;

defm : VectorBinaryArith_ShortLong<c_vv_fminnum, f64, v256f64, "VFMIND", f32, v256f32, "VFMINS">;
defm : VectorBinaryArith_ShortLong<c_vv_fmaxnum, f64, v256f64, "VFMAXD", f32, v256f32, "VFMAXS">;

defm : VectorTernaryArith_ShortLong<c_vv_ffma, f64, v256f64, "VFMADD", f32, v256f32, "VFMADS">;

// Element-wise select (256 elements)
multiclass VectorSelect<ValueType DataVT> {
    def :Pat<(DataVT (vvp_select DataVT:$vtrue, DataVT:$vfalse, v256i1:$vm, i32:$pivot)),
                     (VMRGvvml_v $vfalse, $vtrue, $vm, $pivot, $vfalse)>;
}

defm : VectorSelect<v256f64>;
defm : VectorSelect<v256i64>;
defm : VectorSelect<v256i32>;
defm : VectorSelect<v256f32>;

///// Comparison (VVP_SETCC) /////

multiclass Set_CC<ValueType MaskVT, ValueType DataVT, string FmkBaseName, string CmpBaseName, SDPatternOperator CCMatcher, SDPatternOperator CCConv, string MaskTag="m"> {
  def : Pat<(MaskVT (vvp_setcc DataVT:$LHS, DataVT:$RHS, CCMatcher:$cond, MaskVT:$vm, i32:$vl)),
                    (!cast<Instruction>(FmkBaseName#"v"#MaskTag#"l") (CCConv $cond), (!cast<Instruction>(CmpBaseName#"vvl") $LHS, $RHS, $vl), $vm, $vl)>;
}

multiclass Set_CC_256<ValueType DataVT, string FmkBaseName, string CmpBaseName, SDPatternOperator CCMatcher, SDPatternOperator CCConv>
  : Set_CC<v256i1, DataVT, FmkBaseName, CmpBaseName, CCMatcher, CCConv, "m">;

// TODO: requires packing
// multiclass Set_CC_512<ValueType DataVT, string CmpBaseName, SDPatternOperator CCMatcher, SDPatternOperator CCConv>
//   : Set_CC<v512i1, DataVT, "VFMKW", CmpBaseName, CCMatcher, CCConv, "m">;

// SETCC (256)
defm : Set_CC_256<v256i64,"VFMKL","VCMPUL",CCUIOp,icond2cc>;
defm : Set_CC_256<v256i64,"VFMKL","VCMPSL",CCSIOp,icond2cc>;
defm : Set_CC_256<v256f64,"VFMKL","VFCMPD",cond,fcond2cc>;

defm : Set_CC_256<v256i32,"VFMKW","VCMPUW",CCUIOp,icond2cc>;
defm : Set_CC_256<v256i32,"VFMKW","VCMPSWZX",CCSIOp,icond2cc>;
defm : Set_CC_256<v256f32,"VFMKS","VFCMPS",cond,fcond2cc>;

// SETCC (packed) // FIXME
// defm : Set_CC_512<v512i32,"PVCMPU",CCUIOp,icond2cc>;
// defm : Set_CC_512<v512i32,"PVCMPS",CCSIOp,icond2cc>;
// defm : Set_CC_512<v512f32,"PVFCMP",cond,fcond2cc>;

///// Conversion /////
// Pseudo instructions for i64 <> fp32 conversion
def VCVTLSvml_v
  : Pseudo<(outs V64:$vx),(ins RDOp:$rd, V64:$vy, VM:$vm, I32:$vl, V64:$vpt),"# pseudo VCVTLS<rd>vml_v">;
    // PseudoInstExpansion<(VCVTLDvml_v RDOp:$rd, V64:$vx, (VCVTDSvml_v V64:$vy, VM:$vm, I32:$vl), $vm, $vl, $vpt)>;

def VCVTSLvml_v
  : Pseudo<(outs V64:$vx), (ins V64:$vy, VM:$vm, I32:$vl, V64:$vpt), "# pseudo VCVTSLvml_v">;
    // PseudoInstExpansion<(VCVTSDvml_v V64:$vx, (VCVTDLvml_v V64:$vy, VM:$vm, I32:$vl), $vm, $vl, $vpt)>;

// x_to_y
multiclass conv_x_to_y<SDPatternOperator MatchOp, ValueType MaskVT, ValueType DestVT, ValueType SrcVT, string ConvBaseName, string MaskToken> {
  ///// Implicit vvp_select /////
  def : Pat<(vvp_select (DestVT (MatchOp SrcVT:$vx, (MaskVT srcvalue), (i32 srcvalue))),
                        DestVT:$vfalse,
                        MaskVT:$vm,
                        i32:$vl),
            (!cast<Instruction>(ConvBaseName#"v"#MaskToken#"l_v") $vx, $vm, $vl, $vfalse)>;

  ///// Masked /////
  def : Pat<(DestVT (MatchOp SrcVT:$vx, MaskVT:$vm, i32:$vl)),
                    (!cast<Instruction>(ConvBaseName#"v"#MaskToken#"l_v") $vx, $vm, $vl, (SrcVT (IMPLICIT_DEF)))>;
}

// x_to_y
multiclass conv_x_to_y_rd<SDPatternOperator MatchOp, ValueType MaskVT, ValueType DestVT, ValueType SrcVT, string ConvBaseName, string MaskToken, RD_VAL RDFlag> {
  ///// Implicit vvp_select /////
  def : Pat<(vvp_select (DestVT (MatchOp SrcVT:$vx, (MaskVT srcvalue), (i32 srcvalue))),
                        DestVT:$vfalse,
                        MaskVT:$vm,
                        i32:$vl),
            (!cast<Instruction>(ConvBaseName#"v"#MaskToken#"l_v") RDFlag, $vx, $vm, $vl, $vfalse)>;

  ///// Masked /////
  def : Pat<(DestVT (MatchOp SrcVT:$vx, MaskVT:$vm, i32:$vl)),
                    (!cast<Instruction>(ConvBaseName#"v"#MaskToken#"l_v") RDFlag, $vx, $vm, $vl, (SrcVT (IMPLICIT_DEF)))>;
}

multiclass both_x_to_y<ValueType MaskVT, ValueType FPVT, string FPTag, string IVT, string ITag, string IExtTag="", RD_VAL RDFlag=RD_NONE, string ConvBaseName="VCVT", string MaskToken="m"> {
 defm : conv_x_to_y<vvp_sint_to_fp, MaskVT, FPVT, IVT, ConvBaseName#FPTag#ITag, MaskToken>;
 defm : conv_x_to_y_rd<vvp_fp_to_sint, MaskVT, IVT, FPVT, ConvBaseName#ITag#FPTag#IExtTag, MaskToken, RDFlag>;
}

// iN <> fpN
defm: both_x_to_y<v256i1, v256f32, "S", v256i32, "W", "SX", RD_RZ>;
defm: both_x_to_y<v256i1, v256f64, "D", v256i64, "L", "", RD_RZ>;
defm: both_x_to_y<v512i1, v512f32, "S", v512i32, "W", "", RD_NONE, "PVCVT">;

// t32 <> t64
defm: both_x_to_y<v256i1, v256f32, "S", v256i64, "L", "", RD_RZ>;
defm: both_x_to_y<v256i1, v256f64, "D", v256i32, "W", "SX", RD_RZ>;

// fpext, fpround (256 only)
defm : conv_x_to_y<vvp_fpround, v256i1, v256f32, v256f64, "VCVTSD", "m">;
defm : conv_x_to_y<vvp_fpext,   v256i1, v256f64, v256f32, "VCVTDS", "m">;

  // CC_INE = 2, // Not Equal
// trunc (256 elements)
def : Pat<(v256i1 (vvp_trunc v256i32:$src, (v256i1 srcvalue), i32:$vl)),
          (v256i1 (PVFMKWLOvl 2, (v256i32 (PVANDLOrvl (EXTRACT_SUBREG (ORim 1, 0), sub_i32), v256i32:$src, i32:$vl)), i32:$vl))>;
def : Pat<(v256i1 (vvp_trunc v256i64:$src, (v256i1 srcvalue), i32:$vl)),
          (v256i1 (VFMKLvl 2, (v256i64 (VANDrvl (ORim 1, 0), v256i64:$src, i32:$vl)), i32:$vl))>;
def : Pat<(v256i32 (vvp_trunc v256i64:$src, (v256i1 srcvalue), (i32 srcvalue))),
          (COPY_TO_REGCLASS $src, V64)>;

///// ARITHMETIC /////
// Integer arithmetic (512 elements)
defm : VectorBinaryArith_Base<c_vv_add, i64, v512i32, v512i1, "PVADDU">; 
defm : VectorBinaryArith_Base<vvp_sub,  i64, v512i32, v512i1, "PVSUBU">;
// defm : VectorBinaryArith_Base<vvp_mul,  i64, v512i32, "vmulsl">; // no packed mul
// defm : VectorBinaryArith_Base<vvp_sdiv, i64, v512i32, "vdivsl">; // no packed sdiv
// defm : VectorBinaryArith_Base<vvp_udiv, i64, v512i32, "vdivul">; // no packed udiv
defm : VectorShiftArith<vvp_srl, i64, v512i32, v512i1, "PVSRL">;
defm : VectorShiftArith<vvp_sra, i64, v512i32, v512i1, "PVSRA">;
defm : VectorShiftArith<vvp_shl, i64, v512i32, v512i1, "PVSLL">;


// Floating-point arithmetic (512 elements)
defm : VectorBinaryArith_Base<c_vv_fadd,    i64, v512f32, v512i1, "PVFADD">;
defm : VectorBinaryArith_Base<c_vv_fmul,    i64, v512f32, v512i1, "PVFMUL">;
defm : VectorBinaryArith_Base<vvp_fsub,     i64, v512f32, v512i1, "PVFSUB">;
defm : VectorBinaryArith_Base<c_vv_fminnum, i64, v512f32, v512i1, "PVFMIN">;
defm : VectorBinaryArith_Base<c_vv_fmaxnum, i64, v512f32, v512i1, "PVFMAX">;

defm : VectorTernaryArith_Base<c_vv_ffma, i64, v512f32, v512i1, "PVFMAD">;

// Integer extension (256 elements) //
// vNi32 to vNi64
multiclass IExtend32<string NodeExtToken, string ExtToken> {
  def : Pat<(v256i64 (!cast<SDPatternOperator>("vvp_"#NodeExtToken#"ext") v256i32:$vx, v256i1:$vm, i32:$vl)),
            (!cast<Instruction>("VADDSW"#ExtToken#"Xivml") 0, $vx, $vm, $vl)>;
}
defm : IExtend32<"z", "Z">;
defm : IExtend32<"s", "S">;

// vNi1 to vNiT
multiclass IExtend_Mask<ValueType ResVT, string NodeExtToken, string ExtToken, int TrueVal> {
def : Pat<(ResVT (!cast<SDPatternOperator>("vvp_"#NodeExtToken#"ext") v256i1:$vm, (v256i1 srcvalue), i32:$vl)),
          (VMRGivml 0, (VBRDil TrueVal, $vl), $vm, $vl)>;
}
multiclass IExtend_Mask_ForRes<ValueType ResVT> {
  defm: IExtend_Mask<ResVT, "z", "Z", 1>;
  defm: IExtend_Mask<ResVT, "s", "S", -1>;
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

multiclass Reduce_Sequenced<ValueType VectorVT, RegisterClass ResRC, ValueType ResVT, string VPOp, string VEInst, string FPToken, SDPatternOperator neutral_elem> {
  // ordered & unmasked
  def : Pat <(ResVT (!cast<SDPatternOperator>("vvp_reduce_seq_"#VPOp) (ResVT neutral_elem), VectorVT:$vx, (v256i1 true_mask), i32:$vl)),
             (COPY_TO_REGCLASS (!cast<Instruction>("LVSvi") (!cast<Instruction>(VEInst#FPToken#"vil") $vx, 0, $vl), 0), ResRC)>;
  def : Pat <(ResVT (!cast<SDPatternOperator>("vvp_reduce_seq_"#VPOp) ResVT:$sy, VectorVT:$vx, (v256i1 true_mask), i32:$vl)),
             (COPY_TO_REGCLASS (!cast<Instruction>("LVSvi") (!cast<Instruction>(VEInst#FPToken#"vrl") $vx, $sy, $vl), 0), ResRC)>;
  
  // ordered & masked
  def : Pat <(ResVT (!cast<SDPatternOperator>("vvp_reduce_seq_"#VPOp) ResVT:$sy, VectorVT:$vx, v256i1:$vm, i32:$vl)),
             (COPY_TO_REGCLASS (!cast<Instruction>("LVSvi")
                 (!cast<Instruction>(VEInst#FPToken#"vrl")
                     (VMRGivml 0, $vx, $vm, $vl),
                     $sy,
                     $vl
                 ),
                 0
             ), ResRC)>;
}

multiclass Reduce_Unordered<ValueType VectorVT, RegisterClass ResRC, ValueType ResVT, string VPOp, string VEInst, string FPToken> {
 // unordered
 def : Pat <(ResVT (!cast<SDPatternOperator>("vvp_reduce_"#VPOp) VectorVT:$vx, v256i1:$vm, i32:$vl)),
            (COPY_TO_REGCLASS (!cast<Instruction>("LVSvi") (!cast<Instruction>(VEInst#FPToken#"vml") $vx, $vm, $vl), 0), ResRC)>;
}

multiclass Reduce_Unordered_Sequenced<ValueType VectorVT, RegisterClass ResRC, ValueType ResVT, string VPOp, string IterVEInst, string ReorderVEInst, string FPToken, SDPatternOperator neutral_elem> {
 defm: Reduce_Sequenced<VectorVT, ResRC, ResVT, "fadd", "VFIA", FPToken, neutral_elem>;
 defm: Reduce_Unordered<VectorVT, ResRC, ResVT, "fadd", "VFSUM", FPToken>;
}

multiclass Reduce_Unordered_Sequenced_v256<string VPOp, string IterVEInst, string ReorderVEInst, SDPatternOperator lo_neutral, SDPatternOperator neutral_elem> {
  defm: Reduce_Unordered_Sequenced<v256f64,I64,f64,VPOp, IterVEInst, ReorderVEInst, "D",neutral_elem>;
  defm: Reduce_Unordered_Sequenced<v256f32,I64,f32,VPOp, IterVEInst, ReorderVEInst, "S",lo_neutral>;
}


multiclass Reduce_FMinMax<ValueType VectorVT, RegisterClass ResRC, ValueType ResVT, string FPToken> {
  defm: Reduce_Unordered<VectorVT,ResRC,ResVT,"fmax","VFRMAX",FPToken>;
  defm: Reduce_Unordered<VectorVT,ResRC,ResVT,"fmin","VFRMIN",FPToken>;
}

/// reduce FADD,FMUL {
defm: Reduce_Unordered_Sequenced_v256<"fadd","VFIA","VFSUM",fplozero,fpzero>;
defm: Reduce_Sequenced<v256f64, I64, f64, "fmul", "VFIM", "D", fpone>;
defm: Reduce_Sequenced<v256f32, I64, f32, "fmul", "VFIM", "S", fpone>;

defm: Reduce_FMinMax<v256f64,I64,f64,"DFST">;
defm: Reduce_FMinMax<v256f32,I64,f32,"SFST">;
/// reduce } FMIN/FMAX


/// reduce AND/OR/XOR/ADD {
multiclass Reduce_GenericInt<ValueType VectorVT, ValueType ResRC, ValueType ResVT, string VVPRedOp, string RedInstName> {
  // unmasked
  def : Pat <(ResVT (!cast<SDPatternOperator>("vvp_reduce_"#VVPRedOp) VectorVT:$vx, (v256i1 true_mask), i32:$vl)),
             (COPY_TO_REGCLASS (!cast<Instruction>("LVSvi") (!cast<Instruction>(RedInstName#"vl") $vx, $vl), 0), ResRC)>;

  // masked
  def : Pat <(ResVT (!cast<SDPatternOperator>("vvp_reduce_"#VVPRedOp) VectorVT:$vx, v256i1:$vm, i32:$vl)),
             (COPY_TO_REGCLASS (!cast<Instruction>("LVSvi") (!cast<Instruction>(RedInstName#"vml") $vx, $vm, $vl), 0), ResRC)>;
}

multiclass IntReduce_ShortLong<ValueType VectorVT, RegisterClass ResRC, ValueType ResVT, string SumSuffix, string MinMaxSuffix> {
  defm: Reduce_GenericInt<VectorVT, ResRC, ResVT, "or",  "VROR">;
  defm: Reduce_GenericInt<VectorVT, ResRC, ResVT, "and", "VRAND">;
  defm: Reduce_GenericInt<VectorVT, ResRC, ResVT, "xor", "VRXOR">;
  defm: Reduce_GenericInt<VectorVT, ResRC, ResVT, "add", "VSUM"#SumSuffix>;
  defm: Reduce_GenericInt<VectorVT, ResRC, ResVT, "smax", "VRMAX"#MinMaxSuffix>;
}

defm: IntReduce_ShortLong<v256i64, I64, i64, "L","SLFST">;
defm: IntReduce_ShortLong<v256i32, I32, i32, "WSX","SWFSTSX">;
/// } reduce AND/OR/XOR/ADD
