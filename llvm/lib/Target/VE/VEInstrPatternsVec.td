//===-- VEInstrPatternsVec.td - VEC_-type SDNodes and isel for VE Target --===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file describes the VEC_* prefixed intermediate SDNodes and their
// isel patterns.
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Vector Instruction Patterns for vectorize subtarget which is being
// implemented experimatally.
//===----------------------------------------------------------------------===//

// Pattern Matchings for Generic Vector Instructions

///// repl_f32 , repl_i32 /////

// def : Pat<(i32 (bitconvert f32:$op)), (l2i (SRALri (f2l $op), 32))>;
// def : Pat<(f32 (bitconvert i32:$op)), (l2f (SLLri (i2l $op), 32))>;

// Sub-register replication.
def: Pat<(i64 (repl_f32 f32:$val)),
            (ORrr
              (SRLri (f2l $val), 32),
              (zero_i32 (f2l $val)))>;
def: Pat<(i64 (repl_i32 i32:$val)),
            (ORrr
              (zero_f32 (i2l $val)),
              (SLLri (i2l $val), 32))>;


///// Mask insert, extract, popcount /////

// Mask Insert & Extract
// \p InnerMaskToken compensates for incosistency in LVM/SVM naming scheme with regards to vm256 vs. vm512.
multiclass insert_extract_mask_imm<ValueType MaskVT, string MaskToken, string InnerMaskToken> {
  // extract at imm
  def : Pat<(i64 (vm_extract MaskVT:$vm, uimm7:$idx)),
                 (!cast<Instruction>("SVM"#MaskToken#"i") MaskVT:$vm, (LO7 $idx))>;
  // insert at imm
  def : Pat<(MaskVT (vm_insert MaskVT:$vm, uimm7:$idx, i64:$sy)),
                    (!cast<Instruction>("LVM"#InnerMaskToken#"ir_"#MaskToken) (LO7 $idx), i64:$sy, MaskVT:$vm)>;
}

multiclass insert_extract_mask_reg<ValueType MaskVT, string MaskToken, string InnerMaskToken> {
  // extract at sx
  def : Pat<(i64 (vm_extract MaskVT:$vm, i64:$idx)),
                 (!cast<Instruction>("SVM"#MaskToken#"r") MaskVT:$vm, i64:$idx)>;
 
  // insert at sx
  def : Pat<(MaskVT (vm_insert MaskVT:$vm, i64:$idx, i64:$sy)),
                    (!cast<Instruction>("LVM"#InnerMaskToken#"rr_"#MaskToken) i64:$idx, i64:$sy, MaskVT:$vm)>;
  // TODO mimm encoding for $sy
}

defm: insert_extract_mask_imm<v256i1, "m", "">;
defm: insert_extract_mask_reg<v256i1, "m", "">;
defm: insert_extract_mask_imm<v512i1, "y", "y">;

// mask bit popcount
def : Pat<(i64 (vm_popcount v256i1:$vm, i32:$avl)),
               (PCVMml v256i1:$vm, i32:$avl)>;

///// Mask Load & Store /////

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


///// Mask Arithmetic /////

class Mask_Binary<ValueType MaskVT, SDPatternOperator MaskOp, string InstName> :
  Pat<(MaskVT (MaskOp MaskVT:$ma, MaskVT:$mb)), (!cast<Instruction>(InstName#"mm") $ma, $mb)>;

def: Mask_Binary<v256i1, and, "ANDM">;
def: Mask_Binary<v256i1, or,  "ORM">;
def: Mask_Binary<v256i1, xor, "XORM">;

// FIXME: Valid but very inefficient (incurs repetitive unpacking and packing).
// split pattern (unpack splice, pack)
// class SplitPat<ValueType PackedVT, ValueType RegularVT, SDNode N, Instruction VEOp, SubRegIndex subreg_lo, SubRegIndex subreg_hi>
//   : Pat<(PackedVT (N PackedVT:$A, PackedVT:$B)),
//         (PackedVT
//           (INSERT_SUBREG
//             (INSERT_SUBREG
//               (PackedVT (IMPLICIT_DEF)),
//               (RegularVT (VEOp (RegularVT (EXTRACT_SUBREG $A, subreg_hi)), (RegularVT (EXTRACT_SUBREG $B, subreg_hi)))),
//               subreg_hi),
//             (RegularVT (VEOp (RegularVT (EXTRACT_SUBREG $A, subreg_lo)), (RegularVT (EXTRACT_SUBREG $B, subreg_lo)))),
//             subreg_lo))>;
// 
// // mask unpacking
// class SplitMaskPat<SDNode N, Instruction VEMaskOp> : SplitPat<v512i1, v256i1, N, VEMaskOp, sub_vm_odd, sub_vm_even>;
// 
// def: SplitMaskPat<and, ANDMmm>;
// def: SplitMaskPat<or,   ORMmm>;
// def: SplitMaskPat<xor, XORMmm>;


//// Insert & Extract Vector Element /////

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


///// vec_narrow /////

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


///// vec_broadcast /////

multiclass vbrd_elem32<ValueType v32, ValueType s32, SDPatternOperator ImmOp,
                       SDNodeXForm ImmCast, OutPatFrag SuperRegCast> {
  // VBRDil
  def : Pat<(v32 (vec_broadcast (s32 ImmOp:$sy), i32:$vl)),
            (VBRDil (ImmCast $sy), i32:$vl)>;

  // VBRDrl
  def : Pat<(v32 (vec_broadcast s32:$sy, i32:$vl)),
            (VBRDrl (SuperRegCast $sy), i32:$vl)>;
}

multiclass vbrd_elem64<ValueType v64, ValueType s64,
                       SDPatternOperator ImmOp, SDNodeXForm ImmCast> {
  // VBRDil
  def : Pat<(v64 (vec_broadcast (s64 ImmOp:$sy), i32:$vl)),
            (VBRDil (ImmCast $sy), i32:$vl)>;

  // VBRDrl
  def : Pat<(v64 (vec_broadcast s64:$sy, i32:$vl)),
            (VBRDrl s64:$sy, i32:$vl)>;
}

multiclass extract_insert_elem32<ValueType v32, ValueType s32,
                                 OutPatFrag SubRegCast,
                                 OutPatFrag SuperRegCast> {
  // LVSvi
  def: Pat<(s32 (extractelt v32:$vec, uimm7:$idx)),
           (SubRegCast (LVSvi v32:$vec, (ULO7 $idx)))>;
  // LVSvr
  def: Pat<(s32 (extractelt v32:$vec, i64:$idx)),
           (SubRegCast (LVSvr v32:$vec, $idx))>;

  // LSVir
  def: Pat<(v32 (insertelt v32:$vec, s32:$val, uimm7:$idx)),
           (LSVir_v (ULO7 $idx), (SuperRegCast $val), $vec)>;
  // LSVrr
  def: Pat<(v32 (insertelt v32:$vec, s32:$val, i64:$idx)),
           (LSVrr_v $idx, (SuperRegCast $val), $vec)>;
}

multiclass extract_insert_elem64<ValueType v64, ValueType s64> {
  // LVSvi
  def: Pat<(s64 (extractelt v64:$vec, uimm7:$idx)),
           (LVSvi v64:$vec, (ULO7 $idx))>;
  // LVSvr
  def: Pat<(s64 (extractelt v64:$vec, i64:$idx)),
           (LVSvr v64:$vec, $idx)>;

  // LSVir
  def: Pat<(v64 (insertelt v64:$vec, s64:$val, uimm7:$idx)),
           (LSVir_v (ULO7 $idx), $val, $vec)>;
  // LSVrr
  def: Pat<(v64 (insertelt v64:$vec, s64:$val, i64:$idx)),
           (LSVrr_v $idx, $val, $vec)>;
}

multiclass patterns_elem32<ValueType v32, ValueType s32,
                           SDPatternOperator ImmOp, SDNodeXForm ImmCast,
                           OutPatFrag SubRegCast, OutPatFrag SuperRegCast> {
  defm : vbrd_elem32<v32, s32, ImmOp, ImmCast, SuperRegCast>;
  defm : extract_insert_elem32<v32, s32, SubRegCast, SuperRegCast>;
}

multiclass patterns_elem64<ValueType v64, ValueType s64,
                           SDPatternOperator ImmOp, SDNodeXForm ImmCast> {
  defm : vbrd_elem64<v64, s64, ImmOp, ImmCast>;
  defm : extract_insert_elem64<v64, s64>;
}

defm : patterns_elem32<v256i32, i32, simm7, LO7, l2i, i2l>;
defm : patterns_elem32<v256f32, f32, simm7fp, LO7FP, l2f, f2l>;

defm : patterns_elem64<v256i64, i64, simm7, LO7>;
defm : patterns_elem64<v256f64, f64, simm7fp, LO7FP>;

defm : vbrd_elem64<v512i32, i64, simm7, LO7>;
defm : vbrd_elem64<v512f32, i64, simm7, LO7>;
defm : vbrd_elem64<v512i32, f64, simm7fp, LO7FP>;
defm : vbrd_elem64<v512f32, f64, simm7fp, LO7FP>;

///// vec_seq /////

def: Pat<(v512i32 (vec_seq i32:$vl)),
         (PVSEQl $vl)>;
def: Pat<(v256i64 (vec_seq i32:$vl)),
         (VSEQl $vl)>;
def: Pat<(v256i32 (vec_seq i32:$vl)),
         (PVSEQLOl $vl)>;
def: Pat<(v256f32 (vec_seq i32:$vl)),
         (PVSEQUPl $vl)>;


///// vec_vmv /////

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



///// vec_tomask /////

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


///// Others /////

// Casts
def : Pat<(v256i64 (anyext v256i32:$src)),
          (COPY_TO_REGCLASS $src, V64)>; // TODO INSERT_SUBREG

// bitconvert
multiclass NoopConv<ValueType AVT, ValueType BVT, RegisterClass RT=V64> {
  def : Pat<(AVT (bitconvert BVT:$src)), (COPY_TO_REGCLASS $src, RT)>;
  def : Pat<(BVT (bitconvert AVT:$src)), (COPY_TO_REGCLASS $src, RT)>;
}

defm : NoopConv<v512i64,v512f64,VP>;

defm : NoopConv<v512i32,v256i64>;
defm : NoopConv<v512f32,v256i64>;
defm : NoopConv<v512i32,v256f64>;
defm : NoopConv<v512f32,v256f64>;

defm : NoopConv<v512i32,v512f32>;
defm : NoopConv<v256i64,v256f64>;
defm : NoopConv<v4i1,v256i1,VM>;
defm : NoopConv<v8i1,v512i1,VM512>;

// actual conversions (TODO lift to VVP)
def : Pat<(v256i32 (bitconvert v256f32:$src)),
          (VSRLvil (COPY_TO_REGCLASS $src, V64), 32, (VLEN 256))>;
def : Pat<(v256f32 (bitconvert v256i32:$src)),
          (VSLLvil (COPY_TO_REGCLASS $src, V64), 32, (VLEN 256))>;


//===----------------------------------------------------------------------===//
// Minimum vector instruction patterns for vector intrinsic instructions.
//===----------------------------------------------------------------------===//

// Broadcast for vector mask register.
def : Pat<(v256i1 (vec_broadcast (i32 0), (i32 256))),
          (LVMim_m 3, 0,
          (LVMim_m 2, 0,
          (LVMim_m 1, 0,
          (LVMim 0, 0))))>;
def : Pat<(v512i1 (vec_broadcast (i32 0), (i32 512))),
          (LVMyim_y 7, 0,
          (LVMyim_y 6, 0,
          (LVMyim_y 5, 0,
          (LVMyim_y 4, 0,
          (LVMyim_y 3, 0,
          (LVMyim_y 2, 0,
          (LVMyim_y 1, 0,
          (LVMyim 0, 0))))))))>;

// Load/store for mask register using stack/symbol is implemented in custom
// lower.  Only load/store for mask registers using frame index is implemented
// here.

// Load and store for particular types.
// v512i32, v512f32, v256i32, v256f32, v256i64, and v256f64

// let Predicates = [IsSimdSubTarget] in {
//   def : Pat<(v512i32 (load I64:$addr)),
//             (v512i32 (VLDirl 8, $addr, (VLEN 256)))>;
//   def : Pat<(v512f32 (load I64:$addr)),
//             (v512f32 (VLDirl 8, $addr, (VLEN 256)))>;
//   def : Pat<(v256i32 (load I64:$addr)),
//             (v256i32 (VLDLSXirl 4, $addr, (VLEN 256)))>;
//   def : Pat<(v256f32 (load I64:$addr)),
//             (v256f32 (VLDUirl 4, $addr, (VLEN 256)))>;
//   def : Pat<(v256f64 (load I64:$addr)),
//             (v256f64 (VLDirl 8, $addr, (VLEN 256)))>;
//   def : Pat<(v256i64 (load I64:$addr)),
//             (v256i64 (VLDirl 8, $addr, (VLEN 256)))>;
//   def : Pat<(store v256i32:$vx, I64:$addr),
//             (VSTLirvl 4, $addr, v256i32:$vx, (VLEN 256))>;
//   def : Pat<(store v256f32:$vx, I64:$addr),
//             (VSTUirvl 4, $addr, v256f32:$vx, (VLEN 256))>;
//   def : Pat<(store v256i64:$vx, I64:$addr),
//             (VSTirvl 8, $addr, v256i64:$vx, (VLEN 256))>;
//   def : Pat<(store v256f64:$vx, I64:$addr),
//             (VSTirvl 8, $addr, v256f64:$vx, (VLEN 256))>;
// }

///// Packing support /////

/// Overpacked types: v512x64 ///
// These are all lowered to subregister transfers.

multiclass Packing_Overpack<ValueType PackVT, ValueType VecVT> {
  // vec_pack
  def : Pat<(PackVT (vec_pack VecVT:$vlo, VecVT:$vhi, (i32 srcvalue))),
            (INSERT_SUBREG (INSERT_SUBREG
                           (PackVT (IMPLICIT_DEF)),
                           $vlo, sub_pack_lo),
                           $vhi, sub_pack_hi)>;

  // vec_unpack_lo/hi
  def : Pat<(VecVT (vec_unpack_lo PackVT:$vp, (i32 srcvalue))),
            (EXTRACT_SUBREG $vp, sub_pack_lo)>;
  def : Pat<(VecVT (vec_unpack_hi PackVT:$vp, (i32 srcvalue))),
            (EXTRACT_SUBREG $vp, sub_pack_hi)>;
}

defm : Packing_Overpack<v512i64, v256i64>;
defm : Packing_Overpack<v512f64, v256f64>;

///// vec_pack /////

// Packing (type based)
def : Pat<(v512i32 (vec_pack v256i32:$vlo, v256i32:$vhi, i32:$avl)),
          (VSHFvvil $vlo, $vhi, 13, $avl)>;
def : Pat<(v512f32 (vec_pack v256f32:$vlo, v256f32:$vhi, i32:$avl)),
          (VSHFvvil $vlo, $vhi, 8, $avl)>;
def : Pat<(v512i1 (vec_pack v256i1:$vlo, v256i1:$vhi, (i32 srcvalue))),
          (INSERT_SUBREG (INSERT_SUBREG
                         (v512i1 (IMPLICIT_DEF)),
                         $vlo, sub_vm_odd),
                         $vhi, sub_vm_even)>;

///// vec_swap, vec_unpack_lo, vec_unpack_hi /////

multiclass Unpack_Swap<ValueType PackVT> {
  def : Pat<(PackVT (vec_swap PackVT:$vp, i32:$avl)),
            (VSHFvvil $vp, $vp, 4, $avl)>; // exchange hi and lo

  // no-op unpacks
  def : Pat<(v256i32 (vec_unpack_lo PackVT:$vp, (i32 srcvalue))),
            (COPY_TO_REGCLASS $vp, V64)>;
  def : Pat<(v256f32 (vec_unpack_hi PackVT:$vp, (i32 srcvalue))),
            (COPY_TO_REGCLASS $vp, V64)>;

  // shuffle unpacks
  def : Pat<(v256f32 (vec_unpack_lo PackVT:$vp, i32:$avl)),
            (VSHFvvil $vp, $vp, 4, $avl)>; // always pick lo
  def : Pat<(v256i32 (vec_unpack_hi PackVT:$vp, i32:$avl)),
            (VSHFvvil $vp, $vp, 0, $avl)>; // always pick hi
}

// mask unpacking
def : Pat<(v256i1 (vec_unpack_lo v512i1:$vm, (i32 srcvalue))),
          (EXTRACT_SUBREG $vm, sub_vm_odd)>;
def : Pat<(v256i1 (vec_unpack_hi v512i1:$vm, (i32 srcvalue))),
          (EXTRACT_SUBREG $vm, sub_vm_even)>;

defm: Unpack_Swap<v512i32>;
defm: Unpack_Swap<v512f32>;
