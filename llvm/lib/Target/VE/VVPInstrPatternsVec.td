//===----------- VVPInstrPatternsVec.td - VVP_* SDNode patterns -----------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file describes how VVP_* SDNodes are lowered to machine instructions.
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
//
// VVP SDNode definitions.
//
//===----------------------------------------------------------------------===//

multiclass VectorBinaryArith<
    SDPatternOperator OpNode,
    ValueType ScalarVT, ValueType DataVT, ValueType MaskVT,
    string OpBaseName> {
  // No mask.
  def : Pat<(OpNode
                (any_broadcast ScalarVT:$sx),
                DataVT:$vy, (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(OpBaseName#"rvl")
                ScalarVT:$sx, $vy, $avl)>;
  def : Pat<(OpNode DataVT:$vx, DataVT:$vy, (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(OpBaseName#"vvl")
                $vx, $vy, $avl)>;

  // Mask.
  def : Pat<(OpNode
                (any_broadcast ScalarVT:$sx),
                DataVT:$vy, MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(OpBaseName#"rvml")
                ScalarVT:$sx, $vy, $mask, $avl)>;
  def : Pat<(OpNode DataVT:$vx, DataVT:$vy, MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(OpBaseName#"vvml")
                $vx, $vy, $mask, $avl)>;

  // TODO We do not specify patterns for the immediate variants here. There
  // will be an immediate folding pass that takes care of switching to the
  // immediate variant where applicable.

  // TODO Fold vvp_select into passthru.
}

// Expand both 64bit and 32 bit variant (256 elements)
multiclass VectorBinaryArith_ShortLong<
    SDPatternOperator OpNode,
    ValueType LongScalarVT, ValueType LongDataVT, string LongOpBaseName,
    ValueType ShortScalarVT, ValueType ShortDataVT, string ShortOpBaseName> {
  defm : VectorBinaryArith<OpNode,
                           LongScalarVT, LongDataVT, v256i1,
                           LongOpBaseName>;
  defm : VectorBinaryArith<OpNode,
                           ShortScalarVT, ShortDataVT, v256i1,
                           ShortOpBaseName>;
}


defm : VectorBinaryArith_ShortLong<c_vvp_add,
                                   i64, v256i64, "VADDSL",
                                   i32, v256i32, "VADDSWSX">;
defm : VectorBinaryArith_ShortLong<c_vvp_and,
                                   i64, v256i64, "VAND",
                                   i32, v256i32, "PVANDLO">;

// Vector Gather and scatter
multiclass VectorGather<ValueType DataVT, ValueType PtrVT, ValueType MaskVT, string GTPrefix> {
  // Unmasked.
  def : Pat<(DataVT (vvp_gather PtrVT:$addr, (MaskVT true_mask), i32:$avl)),
                    (!cast<Instruction>(GTPrefix#"vizl") $addr, 0, 0, $avl)>;
  // Masked.
  def : Pat<(DataVT (vvp_gather PtrVT:$addr, MaskVT:$mask, i32:$avl)),
            (!cast<Instruction>(GTPrefix#"vizml") $addr, 0, 0, $mask, $avl)>;
}

defm : VectorGather<v256f64, v256i64, v256i1, "VGT">;
defm : VectorGather<v256i64, v256i64, v256i1, "VGT">;
defm : VectorGather<v256f32, v256i64, v256i1, "VGTU">;
defm : VectorGather<v256i32, v256i64, v256i1, "VGTLZX">;

multiclass VectorScatter<ValueType DataVT, ValueType PtrVT, ValueType MaskVT, string SCPrefix> {
  // Unmasked.
  def : Pat<(vvp_scatter DataVT:$data, PtrVT:$addr, (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(SCPrefix#"vizvl") $data, 0, 0, $addr, $avl)>;
  // Masked.
  def : Pat<(vvp_scatter DataVT:$data, PtrVT:$addr, MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(SCPrefix#"vizvml") $data, 0, 0, $addr, $mask, $avl)>;
}

defm : VectorScatter<v256f64, v256i64, v256i1, "VSC">;
defm : VectorScatter<v256i64, v256i64, v256i1, "VSC">;
defm : VectorScatter<v256f32, v256i64, v256i1, "VSCU">;
defm : VectorScatter<v256i32, v256i64, v256i1, "VSCL">;

// Vector Load and Store
multiclass VectorLoad<ValueType DataVT, ValueType PtrVT, ValueType MaskVT, string GTWithMask, string LDNoMask> {
  // Unmasked (imm stride).
  def : Pat<(DataVT (vvp_load PtrVT:$addr, (i64 simm7:$stride), (MaskVT true_mask), i32:$avl)),
                    (!cast<Instruction>(LDNoMask#"irl") (LO7 $stride), $addr, $avl)>;
  // Unmasked.
  def : Pat<(DataVT (vvp_load PtrVT:$addr, i64:$stride, (MaskVT true_mask), i32:$avl)),
                    (!cast<Instruction>(LDNoMask#"rrl") $stride, PtrVT:$addr, $avl)>;
  // Masked (imm stride).
  def : Pat<(DataVT (vvp_load PtrVT:$addr, (i64 simm7:$stride), MaskVT:$mask, i32:$avl)),
            (!cast<Instruction>(GTWithMask#"vizml")
              (VADDULrvml $addr, (VMULULivml (LO7 $stride), (VSEQl $avl), $mask, $avl), $mask, $avl),
              0, 0,
              $mask,
              $avl)>;
  // Masked.
  def : Pat<(DataVT (vvp_load PtrVT:$addr, i64:$stride, MaskVT:$mask, i32:$avl)),
            (!cast<Instruction>(GTWithMask#"vizml")
              (VADDULrvml $addr, (VMULULrvml $stride, (VSEQl $avl), $mask, $avl), $mask, $avl),
              0, 0,
              $mask,
              $avl)>;
}

multiclass VectorLoadStore_Packed<ValueType DataVT, ValueType PtrVT, ValueType MaskVT, string LDNoMask, SDNode STNoMask> {
  // Unmasked (imm stride).
  def : Pat<(DataVT (vvp_load PtrVT:$addr, (i64 simm7:$stride), (MaskVT true_mask), i32:$avl)),
                    (!cast<Instruction>(LDNoMask#"irl") (LO7 $stride), $addr, $avl)>;
  // Unmasked.
  def : Pat<(DataVT (vvp_load PtrVT:$addr, i64:$stride, (MaskVT true_mask), i32:$avl)),
                    (!cast<Instruction>(LDNoMask#"rrl") $stride, $addr, $avl)>;

  // Masked (imm stride).
  def : Pat<(vvp_store DataVT:$vx, PtrVT:$addr, (i64 simm7:$stride), (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(STNoMask#"irvl") (LO7 $stride), $addr, $vx, $avl)>;
  // Masked.
  def : Pat<(vvp_store DataVT:$vx, PtrVT:$addr, i64:$stride, (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(STNoMask#"rrvl") $stride, $addr, $vx, $avl)>;
}


// Load patterns
// Packed (anomalous mask).
defm : VectorLoad<v512f32, i64, v256i1, "VGT",    "VLD">;
defm : VectorLoad<v512i32, i64, v256i1, "VGT",    "VLD">;

// Regular.
defm : VectorLoad<v256f64, i64, v256i1, "VGT",    "VLD">;
defm : VectorLoad<v256i64, i64, v256i1, "VGT",    "VLD">;
defm : VectorLoad<v256f32, i64, v256i1, "VGTU",   "VLDU">;
defm : VectorLoad<v256i32, i64, v256i1, "VGTLZX", "VLDLZX">;
// packed load patterns
// defm : VectorLoadStore_Packed<v512i32, i64, v512i1, "VLD", "VST">;
// defm : VectorLoadStore_Packed<v512f32, i64, v512i1, "VLD", "VST">;

multiclass VectorStore<ValueType DataVT, ValueType PtrVT, ValueType MaskVT, string STWithMask, string STNoMask> {
  // Unmasked (imm stride).
  def : Pat<(vvp_store DataVT:$val, PtrVT:$addr, (i64 simm7:$stride), (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(STNoMask#"irvl") (LO7 $stride), $addr, $val, $avl)>;
  // Unmasked.
  def : Pat<(vvp_store DataVT:$val, PtrVT:$addr, i64:$stride, (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(STNoMask#"rrvl") $stride, $addr, $val, $avl)>;
  // Masked (imm stride).
  def : Pat<(vvp_store DataVT:$val, PtrVT:$addr, (i64 simm7:$stride), MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(STWithMask#"irvml") (LO7 $stride), $addr, $val, $mask, $avl)>;
  // Masked.
  def : Pat<(vvp_store DataVT:$val, PtrVT:$addr, i64:$stride, MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(STWithMask#"rrvml") $stride, $addr, $val, $mask, $avl)>;
}

// Packed (anomalous mask).
defm : VectorStore<v512f32, i64, v256i1, "VST",  "VST">;
defm : VectorStore<v512i32, i64, v256i1, "VST",  "VST">;

// Regular.
defm : VectorStore<v256f64, i64, v256i1, "VST",  "VST">;
defm : VectorStore<v256i64, i64, v256i1, "VST",  "VST">;
defm : VectorStore<v256f32, i64, v256i1, "VSTU", "VSTU">; 
defm : VectorStore<v256i32, i64, v256i1, "VSTL", "VSTL">; 

// Floating-point arithmetic

multiclass Unary<SDPatternOperator OpNode, ValueType ScalarVT, ValueType DataVT, ValueType MaskVT, string OpBaseName> {
  // Masked with select.
  def : Pat<(vvp_select (OpNode DataVT:$vx, (MaskVT srcvalue), (i32 srcvalue)),
                        DataVT:$vfalse,
                        MaskVT:$mask,
                        i32:$avl),
            (!cast<Instruction>(OpBaseName#"vml_v") $vx, $mask, $avl, $vfalse)>;

  // Unmasked.
  def : Pat<(OpNode DataVT:$vx, (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(OpBaseName#"vl") $vx, $avl)>;

  // Masked.
  def : Pat<(OpNode DataVT:$vx, MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(OpBaseName#"vml") $vx, $mask, $avl)>;
}

// Expand both 64bit and 32 bit variant (256 elements)
multiclass Unary_ShortLong<SDPatternOperator OpNode, ValueType LongScalarVT, ValueType LongDataVT, string LongOpBaseName, ValueType ShortScalarVT, ValueType ShortDataVT, string ShortOpBaseName> {
  defm : Unary<OpNode, LongScalarVT, LongDataVT, v256i1, LongOpBaseName>;
  defm : Unary<OpNode, ShortScalarVT, ShortDataVT, v256i1, ShortOpBaseName>;
}





multiclass Binary_rv<SDPatternOperator OpNode, ValueType ScalarVT, ValueType DataVT, ValueType MaskVT, string OpBaseName> {
  // Masked with select, broadcast.
  def : Pat<(vvp_select (OpNode (any_broadcast ScalarVT:$sx), DataVT:$vy, (MaskVT srcvalue), (i32 srcvalue)),
                        DataVT:$vfalse,
                        MaskVT:$mask,
                        i32:$avl),
            (!cast<Instruction>(OpBaseName#"rvml_v") ScalarVT:$sx, $vy, $mask, $avl, $vfalse)>;
  // Unmasked, broadcast.
  def : Pat<(OpNode (any_broadcast ScalarVT:$sx), DataVT:$vy, (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(OpBaseName#"rvl") ScalarVT:$sx, $vy, $avl)>;
  // Masked, broadcast.
  def : Pat<(OpNode (any_broadcast ScalarVT:$sx), DataVT:$vy, MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(OpBaseName#"rvml") ScalarVT:$sx, $vy, $mask, $avl)>;
}

multiclass Binary_vr<SDPatternOperator OpNode, ValueType ScalarVT, ValueType DataVT, ValueType MaskVT, string OpBaseName> {
  // Masked with select, broadcast.
  def : Pat<(vvp_select (OpNode DataVT:$vx, (DataVT (any_broadcast ScalarVT:$sy)), (MaskVT srcvalue), (i32 srcvalue)),
                        DataVT:$vfalse,
                        MaskVT:$mask,
                        i32:$avl),
            (!cast<Instruction>(OpBaseName#"vrml_v") $vx, ScalarVT:$sy, $mask, $avl, $vfalse)>;
  // Unmasked, broadcast.
  def : Pat<(OpNode DataVT:$vx, (DataVT (any_broadcast ScalarVT:$sy)), (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(OpBaseName#"vrl") $vx, ScalarVT:$sy, $avl)>;
  // Masked, broadcast.
  def : Pat<(OpNode DataVT:$vx, (DataVT (any_broadcast ScalarVT:$sy)), MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(OpBaseName#"vrml") $vx, ScalarVT:$sy, $mask, $avl)>;
}

multiclass Binary_vv<SDPatternOperator OpNode, ValueType ScalarVT, ValueType DataVT, ValueType MaskVT, string OpBaseName> {
  // Masked with select.
  def : Pat<(vvp_select (OpNode DataVT:$vx, DataVT:$vy, (MaskVT srcvalue), (i32 srcvalue)),
                        DataVT:$vfalse,
                        MaskVT:$mask,
                        i32:$avl),
            (!cast<Instruction>(OpBaseName#"vvml_v") $vx, $vy, $mask, $avl, $vfalse)>;

  // Unmasked.
  def : Pat<(OpNode DataVT:$vx, DataVT:$vy, (MaskVT true_mask), i32:$avl),
            (!cast<Instruction>(OpBaseName#"vvl") $vx, $vy, $avl)>;

  // Masked.
  def : Pat<(OpNode DataVT:$vx, DataVT:$vy, MaskVT:$mask, i32:$avl),
            (!cast<Instruction>(OpBaseName#"vvml") $vx, $vy, $mask, $avl)>;
}

// Binary operators that support broadcasts only on RHS.
multiclass Binary_vr_vv<SDPatternOperator OpNode, ValueType ScalarVT, ValueType DataVT, ValueType MaskVT, string OpBaseName> {
  defm : Binary_vr<OpNode, ScalarVT, DataVT, MaskVT, OpBaseName>;
  defm : Binary_vv<OpNode, ScalarVT, DataVT, MaskVT, OpBaseName>;
}
multiclass Binary_vr_vv_ShortLong<SDPatternOperator OpNode, ValueType LongScalarVT, ValueType LongDataVT, string LongOpBaseName, ValueType ShortScalarVT, ValueType ShortDataVT, string ShortOpBaseName> {
  defm : Binary_vr_vv<OpNode, LongScalarVT, LongDataVT, v256i1, LongOpBaseName>;
  defm : Binary_vr_vv<OpNode, ShortScalarVT, ShortDataVT, v256i1, ShortOpBaseName>;
}

// Binary operators that support broadcasts only on LHS.
multiclass Binary_rv_vv<SDPatternOperator OpNode, ValueType ScalarVT, ValueType DataVT, ValueType MaskVT, string OpBaseName> {
  defm : Binary_rv<OpNode, ScalarVT, DataVT, MaskVT, OpBaseName>;
  defm : Binary_vv<OpNode, ScalarVT, DataVT, MaskVT, OpBaseName>;
}
multiclass Binary_rv_vv_ShortLong<SDPatternOperator OpNode, ValueType LongScalarVT, ValueType LongDataVT, string LongOpBaseName, ValueType ShortScalarVT, ValueType ShortDataVT, string ShortOpBaseName> {
  defm : Binary_rv_vv<OpNode, LongScalarVT, LongDataVT, v256i1, LongOpBaseName>;
  defm : Binary_rv_vv<OpNode, ShortScalarVT, ShortDataVT, v256i1, ShortOpBaseName>;
}

// Binary operators that support broadcasts on LHS and RHS.
multiclass Binary_all<SDPatternOperator OpNode, ValueType ScalarVT, ValueType DataVT, ValueType MaskVT, string OpBaseName> {
  defm : Binary_rv<OpNode, ScalarVT, DataVT, MaskVT, OpBaseName>;
  defm : Binary_vr_vv<OpNode, ScalarVT, DataVT, MaskVT, OpBaseName>;
}
multiclass Binary_ShortLong<SDPatternOperator OpNode, ValueType LongScalarVT, ValueType LongDataVT, string LongOpBaseName, ValueType ShortScalarVT, ValueType ShortDataVT, string ShortOpBaseName> {
  defm : Binary_all<OpNode, LongScalarVT, LongDataVT, v256i1, LongOpBaseName>;
  defm : Binary_all<OpNode, ShortScalarVT, ShortDataVT, v256i1, ShortOpBaseName>;
}


multiclass Ternary<SDPatternOperator OpNode, ValueType ScalarVT, ValueType DataVT, ValueType MaskVT, string OpBaseName> {
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
multiclass Ternary_ShortLong<SDPatternOperator OpNode, ValueType LongScalarVT, ValueType LongDataVT, string LongOpBaseName, ValueType ShortScalarVT, ValueType ShortDataVT, string ShortOpBaseName> {
  defm : Ternary<OpNode, LongScalarVT, LongDataVT, v256i1, LongOpBaseName>;
  defm : Ternary<OpNode, ShortScalarVT, ShortDataVT, v256i1, ShortOpBaseName>;
}


// Integer arithmetic (256 elements)
defm : Unary_ShortLong<vvp_ctpop, i64, v256i64, "VPCNT", i32, v256i32, "PVPCNTLO">;

defm : Binary_rv_vv_ShortLong<c_vvp_add, i64, v256i64, "VADDSL", i32, v256i32, "VADDSWSX">;

defm : Binary_rv_vv_ShortLong<vvp_sub,  i64, v256i64, "VSUBSL", i32, v256i32, "VSUBSWSX">;
defm : Binary_rv_vv_ShortLong<c_vvp_mul, i64, v256i64, "VMULSL", i32, v256i32, "VMULSWSX">;
defm : Binary_ShortLong<vvp_sdiv, i64, v256i64, "VDIVSL", i32, v256i32, "VDIVSWSX">;
defm : Binary_ShortLong<vvp_udiv, i64, v256i64, "VDIVUL", i32, v256i32, "VDIVUW">;

defm : Binary_vr_vv_ShortLong<vvp_srl, i64, v256i64, "VSRL",  i32, v256i32, "PVSRLLO">;
defm : Binary_vr_vv_ShortLong<vvp_sra, i64, v256i64, "VSRAL", i32, v256i32, "PVSRALO">;
defm : Binary_vr_vv_ShortLong<vvp_shl, i64, v256i64, "VSLL",  i32, v256i32, "PVSLLLO">;

defm : Binary_rv_vv_ShortLong<c_vvp_and, i64, v256i64, "VAND", i32, v256i32, "PVANDLO">;
defm : Binary_rv_vv_ShortLong<c_vvp_xor, i64, v256i64, "VXOR", i32, v256i32, "PVXORLO">;
defm : Binary_rv_vv_ShortLong<c_vvp_or,  i64, v256i64, "VOR",  i32, v256i32, "PVORLO">;

// Floating-point arithmetic (256 elements)
defm : Unary_ShortLong<vvp_frcp, f64, v256f64, "VRCPD", f32, v256f32, "VRCPS">; 
defm : Unary_ShortLong<vvp_fsqrt, f64, v256f64, "VFSQRTD", f32, v256f32, "VFSQRTS">; 
defm : Binary_rv_vv_ShortLong<c_vvp_fadd, f64, v256f64, "VFADDD", f32, v256f32, "PVFADDUP">;
defm : Binary_rv_vv_ShortLong<vvp_fsub,  f64, v256f64, "VFSUBD", f32, v256f32, "PVFSUBUP">;
defm : Binary_rv_vv_ShortLong<c_vvp_fmul, f64, v256f64, "VFMULD", f32, v256f32, "PVFMULUP">;
defm : Binary_ShortLong<vvp_fdiv,  f64, v256f64, "VFDIVD", f32, v256f32, "VFDIVS">;

defm : Binary_rv_vv_ShortLong<c_vvp_fminnum, f64, v256f64, "VFMIND", f32, v256f32, "VFMINS">;
defm : Binary_rv_vv_ShortLong<c_vvp_fmaxnum, f64, v256f64, "VFMAXD", f32, v256f32, "VFMAXS">;

defm : Ternary_ShortLong<c_vvp_ffma, f64, v256f64, "VFMADD", f32, v256f32, "VFMADS">;
defm : Ternary_ShortLong<c_vvp_ffms, f64, v256f64, "VFMSBD", f32, v256f32, "VFMSBS">;
defm : Ternary_ShortLong<c_vvp_ffmsn, f64, v256f64, "VFNMSBD", f32, v256f32, "VFNMSBS">;
// TODO: vvp_ffman

///// Selection /////
multiclass VectorSelect<ValueType DataVT> {
    def :Pat<(DataVT (vvp_select DataVT:$vtrue, DataVT:$vfalse, v256i1:$vm, i32:$pivot)),
                     (VMRGvvml_v $vfalse, $vtrue, $vm, $pivot, $vfalse)>;
}

defm : VectorSelect<v256f64>;
defm : VectorSelect<v256i64>;
defm : VectorSelect<v256i32>;
defm : VectorSelect<v256f32>;

multiclass VectorSelect_Packed<ValueType PackedVT> {
    def : Pat<(PackedVT (vvp_select PackedVT:$vtrue, PackedVT:$vfalse, v512i1:$vm, i32:$pivot)),
                        (VMRGWvvml_v $vfalse, $vtrue, $vm, $pivot, $vfalse)>;
}

defm : VectorSelect_Packed<v512i32>;
defm : VectorSelect_Packed<v512f32>;


///// Comparison (VVP_SETCC) /////

multiclass Set_CC<ValueType MaskVT, ValueType DataVT, string FmkBaseName, string CmpBaseName, SDPatternOperator CCMatcher, SDPatternOperator CCConv, string MaskTag="m"> {
  // TODO: Fused broadcast. Requires adapting SPU reg type to element type (as done for PVFADDUP, etc).
  // TODO: Predicate inversion to fuse broadcast (may do this in cpp code).
  // // Unmasked + broadcast
  // def : Pat<(MaskVT (vvp_setcc (any_broadcast ScalarVT:$LHS), DataVT:$RHS, CCMatcher:$cond, (MaskVT true_mask), i32:$vl)),
  //                   (!cast<Instruction>(FmkBaseName#"vl") (CCConv $cond), (!cast<Instruction>(CmpBaseName#"rvl") $LHS, $RHS, $vl), $vl)>;
  // unmasked
  def : Pat<(MaskVT (vvp_setcc DataVT:$LHS, DataVT:$RHS, CCMatcher:$cond, (MaskVT true_mask), i32:$vl)),
                    (!cast<Instruction>(FmkBaseName#"vl") (CCConv $cond), (!cast<Instruction>(CmpBaseName#"vvl") $LHS, $RHS, $vl), $vl)>;
  // masked
  def : Pat<(MaskVT (vvp_setcc DataVT:$LHS, DataVT:$RHS, CCMatcher:$cond, MaskVT:$vm, i32:$vl)),
                    (!cast<Instruction>(FmkBaseName#"v"#MaskTag#"l") (CCConv $cond), (!cast<Instruction>(CmpBaseName#"vvl") $LHS, $RHS, $vl), $vm, $vl)>;
}

multiclass Set_CC_256<ValueType DataVT, string FmkBaseName, string CmpBaseName, SDPatternOperator CCMatcher, SDNodeXForm CCConv>
  : Set_CC<v256i1, DataVT, FmkBaseName, CmpBaseName, CCMatcher, CCConv, "m">;

// SETCC (256)
defm : Set_CC_256<v256i64,"VFMKL","VCMPUL",CCUIOp,icond2cc>;
defm : Set_CC_256<v256i64,"VFMKL","VCMPSL",CCSIOp,icond2cc>;
defm : Set_CC_256<v256f64,"VFMKL","VFCMPD",cond,fcond2cc>;

defm : Set_CC_256<v256i32,"VFMKW","VCMPUW",CCUIOp,icond2cc>;
defm : Set_CC_256<v256i32,"VFMKW","VCMPSWZX",CCSIOp,icond2cc>;
defm : Set_CC_256<v256f32,"VFMKS","VFCMPS",cond,fcond2cc>;

///// Conversion /////

// Pseudo instructions for i64 <> fp32 conversion
// These get expanded very late - add flags so LVLGen cathes the $vl register here.
multiclass PseudoCVT<dag ins_prefix, int Offset,string PseudoName> {
  let VE_Vector = 1, VE_VLInUse = 1 in {
    let VE_VLIndex = !add(3,Offset) in {
      def vml_v
        : Pseudo<(outs V64:$vx), !con(ins_prefix, (ins V64:$vy, VM:$vm, I32:$vl, V64:$vpt)),"# pseudo "#PseudoName#"vml_v">;
      def vml
        : Pseudo<(outs V64:$vx), !con(ins_prefix, (ins V64:$vy, VM:$vm, I32:$vl)), "# pseudo "#PseudoName#"vml">;
    }
    let VE_VLIndex = !add(2,Offset) in {
      def vl
        : Pseudo<(outs V64:$vx), !con(ins_prefix, (ins V64:$vy, I32:$vl)), "# pseudo VCVTSLvml_v">;
    }
  }
}

defm VCVTLS : PseudoCVT<(ins RDOp:$rd), 1, "VCVTLS">;
defm VCVTSL : PseudoCVT<(ins), 0, "VCVTSL">;

// x_to_y
multiclass conv_x_to_y<SDPatternOperator MatchOp, ValueType MaskVT, ValueType DestVT, ValueType SrcVT, string ConvBaseName, string MaskToken> {
  // With select.
  def : Pat<(vvp_select (DestVT (MatchOp SrcVT:$vx, (MaskVT srcvalue), (i32 srcvalue))),
                        DestVT:$vfalse,
                        MaskVT:$vm,
                        i32:$vl),
            (!cast<Instruction>(ConvBaseName#"v"#MaskToken#"l_v") $vx, $vm, $vl, $vfalse)>;

  // Unmasked.
  def : Pat<(DestVT (MatchOp SrcVT:$vx, (MaskVT true_mask), i32:$vl)),
                    (!cast<Instruction>(ConvBaseName#"vl") $vx, $vl)>;
  // Masked.
  def : Pat<(DestVT (MatchOp SrcVT:$vx, MaskVT:$vm, i32:$vl)),
                    (!cast<Instruction>(ConvBaseName#"v"#MaskToken#"l") $vx, $vm, $vl)>;
}

// x_to_y
multiclass conv_x_to_y_rd<SDPatternOperator MatchOp, ValueType MaskVT, ValueType DestVT, ValueType SrcVT, string ConvBaseName, string MaskToken, RD_VAL RDFlag> {
  // With select.
  def : Pat<(vvp_select (DestVT (MatchOp SrcVT:$vx, (MaskVT srcvalue), (i32 srcvalue))),
                        DestVT:$vfalse,
                        MaskVT:$vm,
                        i32:$vl),
            (!cast<Instruction>(ConvBaseName#"v"#MaskToken#"l_v") RDFlag, $vx, $vm, $vl, $vfalse)>;

  // Unmasked.
  def : Pat<(DestVT (MatchOp SrcVT:$vx, (MaskVT true_mask), i32:$vl)),
                    (!cast<Instruction>(ConvBaseName#"vl") RDFlag, $vx, $vl)>;

  // Masked.
  def : Pat<(DestVT (MatchOp SrcVT:$vx, MaskVT:$vm, i32:$vl)),
                    (!cast<Instruction>(ConvBaseName#"v"#MaskToken#"l_v") RDFlag, $vx, $vm, $vl, (SrcVT (IMPLICIT_DEF)))>;
}

multiclass both_x_to_y<ValueType MaskVT, ValueType FPVT, string FPTag, ValueType IVT, string ITag, string IExtTag="", RD_VAL RDFlag=RD_NONE, string ConvBaseName="VCVT", string MaskToken="m"> {
 defm : conv_x_to_y<vvp_sint_to_fp, MaskVT, FPVT, IVT, ConvBaseName#FPTag#ITag, MaskToken>;
 defm : conv_x_to_y_rd<vvp_fp_to_sint, MaskVT, IVT, FPVT, ConvBaseName#ITag#FPTag#IExtTag, MaskToken, RDFlag>;
}

// iN <> fpN
defm: both_x_to_y<v256i1, v256f32, "S", v256i32, "W", "SX", RD_RZ>;
defm: both_x_to_y<v256i1, v256f64, "D", v256i64, "L", "", RD_RZ>;
defm: both_x_to_y<v512i1, v512f32, "S", v512i32, "W", "", RD_RZ, "PVCVT">;

// t32 <> t64
defm: both_x_to_y<v256i1, v256f32, "S", v256i64, "L", "", RD_RZ>;
defm: both_x_to_y<v256i1, v256f64, "D", v256i32, "W", "SX", RD_RZ>;

// fpext, fpround, fptrunc (256 only)
defm : conv_x_to_y<vvp_fptrunc, v256i1, v256f32, v256f64, "VCVTSD", "m">; // Roudn to nearest fp (correct).
// defm : conv_x_to_y<vvp_fpround, v256i1, v256f32, v256f64, "VCVTSD", "m">; // Round to nearest integer (FIXME!) ties away from zero.
defm : conv_x_to_y<vvp_fpext,   v256i1, v256f64, v256f32, "VCVTDS", "m">;

  // CC_INE = 2, // Not Equal
// trunc (256 elements)
def : Pat<(v256i1 (vvp_itrunc v256i32:$src, (v256i1 srcvalue), i32:$vl)),
          (v256i1 (PVFMKWLOvl 2, (v256i32 (PVANDLOrvl (EXTRACT_SUBREG (ORim 1, 0), sub_i32), v256i32:$src, i32:$vl)), i32:$vl))>;
def : Pat<(v256i1 (vvp_itrunc v256i64:$src, (v256i1 srcvalue), i32:$vl)),
          (v256i1 (VFMKLvl 2, (v256i64 (VANDrvl (ORim 1, 0), v256i64:$src, i32:$vl)), i32:$vl))>;
def : Pat<(v256i32 (vvp_itrunc v256i64:$src, (v256i1 srcvalue), (i32 srcvalue))),
          (COPY_TO_REGCLASS $src, V64)>;

///// ARITHMETIC /////
// Integer arithmetic (512 elements)
defm : Binary_rv_vv<c_vvp_and, i64, v512i32, v512i1, "PVAND">; 
defm : Binary_rv_vv<c_vvp_or, i64, v512i32, v512i1, "PVOR">; 
defm : Binary_rv_vv<c_vvp_xor, i64, v512i32, v512i1, "PVXOR">; 

defm : Binary_rv_vv<c_vvp_add, i64, v512i32, v512i1, "PVADDU">; 
defm : Binary_rv_vv<vvp_sub,  i64, v512i32, v512i1, "PVSUBU">;
defm : Binary_vr_vv<vvp_srl, i64, v512i32, v512i1, "PVSRL">;
defm : Binary_vr_vv<vvp_sra, i64, v512i32, v512i1, "PVSRA">;
defm : Binary_vr_vv<vvp_shl, i64, v512i32, v512i1, "PVSLL">;

// Floating-point arithmetic (512 elements)
defm : Unary<vvp_frcp,    i64, v512f32, v512i1, "PVRCP">;

defm : Binary_rv_vv<c_vvp_fadd,    i64, v512f32, v512i1, "PVFADD">;
defm : Binary_rv_vv<c_vvp_fmul,    i64, v512f32, v512i1, "PVFMUL">;
defm : Binary_rv_vv<vvp_fsub,     i64, v512f32, v512i1, "PVFSUB">;
defm : Binary_rv_vv<c_vvp_fminnum, i64, v512f32, v512i1, "PVFMIN">;
defm : Binary_rv_vv<c_vvp_fmaxnum, i64, v512f32, v512i1, "PVFMAX">;

defm : Ternary<c_vvp_ffma, i64, v512f32, v512i1, "PVFMAD">;
defm : Ternary<c_vvp_ffms, i64, v512f32, v512i1, "PVFMSB">;
defm : Ternary<c_vvp_ffmsn, i64, v512f32, v512i1, "PVFNMSB">;

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
multiclass Reduce_GenericInt<ValueType VectorVT, RegisterClass ResRC, ValueType ResVT, string VVPRedOp, string RedInstName> {
  // Unmasked.
  def : Pat <(ResVT (!cast<SDPatternOperator>("vvp_reduce_"#VVPRedOp) VectorVT:$vx, (v256i1 true_mask), i32:$vl)),
             (COPY_TO_REGCLASS (!cast<Instruction>("LVSvi") (!cast<Instruction>(RedInstName#"vl") $vx, $vl), 0), ResRC)>;

  // Masked.
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


/// Mask arithmetic {
multiclass MaskBinaryArith<SDPatternOperator Op, Instruction Inst> {
  def : Pat <(v256i1 (Op v256i1:$mx, v256i1:$my)),
             (v256i1 (Inst v256i1:$mx, v256i1:$my))>;
}

defm: MaskBinaryArith<and,ANDMmm>;
defm: MaskBinaryArith<or,ORMmm>;
defm: MaskBinaryArith<xor,XORMmm>;

/// } Mask arithmetic


/// FNEG {

multiclass FNeg<ValueType DataVT> {
  // Masked with select.
  def : Pat<(vvp_select (vvp_fneg DataVT:$vx, (v256i1 srcvalue), (i32 srcvalue)),
                        DataVT:$vfalse,
                        v256i1:$mask,
                        i32:$avl),
            (VXORmvml_v (i32 1), $vx, $mask, $avl, $vfalse)>;
  
  // Unmasked.
  def : Pat<(vvp_fneg DataVT:$vx, (v256i1 true_mask), i32:$avl),
            (VXORmvl (i32 1), $vx, $avl)>;

  // Masked.
  def : Pat<(vvp_fneg DataVT:$vx, v256i1:$mask, i32:$avl),
            (VXORmvml (i32 1), $vx, $mask, $avl)>;
}

defm: FNeg<v256f32>;
defm: FNeg<v256f64>;

///// Packed FNeg /////

// Masked with select.
def : Pat<(vvp_select (vvp_fneg v512f32:$vx, (v512i1 srcvalue), (i32 srcvalue)),
                      v512f32:$vfalse,
                      v512i1:$mask,
                      i32:$avl),
          (v512f32 (PVXORrvml_v (packed_fneg_imm ), $vx, $mask, $avl, $vfalse))>;

// Unmasked.
def : Pat<(vvp_fneg v512f32:$vx, (v512i1 true_mask), i32:$avl),
          (v512f32 (PVXORrvl (packed_fneg_imm ), $vx, $avl))>;

// Masked.
def : Pat<(vvp_fneg v512f32:$vx, v512i1:$mask, i32:$avl),
          (v512f32 (PVXORrvml (packed_fneg_imm ), $vx, $mask, $avl))>;

/// } FNEG
