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
// Instruction format superclass
//===----------------------------------------------------------------------===//

multiclass vbrd_elem32<ValueType v32, ValueType s32, SDPatternOperator ImmOp,
                       SDNodeXForm ImmCast, SDNodeXForm SuperRegCast> {
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
                                 SDNodeXForm SubRegCast,
                                 SDNodeXForm SuperRegCast> {
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
                           SDNodeXForm SubRegCast, SDNodeXForm SuperRegCast> {
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

//===----------------------------------------------------------------------===//
// Minimum vector instruction patterns for vector intrinsic instructions.
//===----------------------------------------------------------------------===//

// Boardcast for vector mask register.
let Predicates = [IsIntrinsicSubTarget] in {
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
}

// Load and store for partiuclar types.
// v512i32, v512f32, v256i32, v256f32, v256i64, and v256f64

let Predicates = [IsIntrinsicSubTarget] in {
  def : Pat<(v512i32 (load I64:$addr)),
            (v512i32 (VLDirl 8, $addr, (VLEN 256)))>;
  def : Pat<(v512f32 (load I64:$addr)),
            (v512f32 (VLDirl 8, $addr, (VLEN 256)))>;
  def : Pat<(v256i32 (load I64:$addr)),
            (v256i32 (VLDLSXirl 4, $addr, (VLEN 256)))>;
  def : Pat<(v256f32 (load I64:$addr)),
            (v256f32 (VLDUirl 4, $addr, (VLEN 256)))>;
  def : Pat<(v256f64 (load I64:$addr)),
            (v256f64 (VLDirl 8, $addr, (VLEN 256)))>;
  def : Pat<(v256i64 (load I64:$addr)),
            (v256i64 (VLDirl 8, $addr, (VLEN 256)))>;
  def : Pat<(store v256i32:$vx, I64:$addr),
            (VSTLirvl 4, $addr, v256i32:$vx, (VLEN 256))>;
  def : Pat<(store v256f32:$vx, I64:$addr),
            (VSTUirvl 4, $addr, v256f32:$vx, (VLEN 256))>;
  def : Pat<(store v256i64:$vx, I64:$addr),
            (VSTirvl 8, $addr, v256i64:$vx, (VLEN 256))>;
  def : Pat<(store v256f64:$vx, I64:$addr),
            (VSTirvl 8, $addr, v256f64:$vx, (VLEN 256))>;
}

// Load/store for mask register using stack/symbol is implemented in custom
// lower.  Only load/store for mask registers using frame index is implemented
// here.

// Load and store for
// v256i1, v512i1

let Predicates = [IsIntrinsicSubTarget] in {
  def : Pat<(v256i1 (load ADDRrii:$addr)),
            (LDVMrii ADDRrii:$addr)>;
  def : Pat<(v512i1 (load ADDRrii:$addr)),
            (LDVM512rii ADDRrii:$addr)>;
  def : Pat<(store v256i1:$vx, ADDRrii:$addr),
            (STVMrii ADDRrii:$addr, $vx)>;
  def : Pat<(store v512i1:$vx, ADDRrii:$addr),
            (STVM512rii ADDRrii:$addr, $vx)>;
}
