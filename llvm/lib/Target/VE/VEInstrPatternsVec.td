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

multiclass vbrd_elem32<ValueType v32, ValueType s32, SDPatternOperator ImmOp, SDNodeXForm ImmCast, int SubRegIdx> {
  // VBRDil
  def : Pat<(v32 (vec_broadcast (s32 ImmOp:$sy), i32:$vl)),
            (VBRDil (ImmCast $sy), i32:$vl)>;

  // VBRDrl
  def : Pat<(v32 (vec_broadcast s32:$sy, i32:$vl)),
            (VBRDrl
              (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, SubRegIdx),
              i32:$vl)>;
}

defm : vbrd_elem32<v256f32, f32, simm7fp, LO7FP, sub_f32>;
defm : vbrd_elem32<v256i32, i32, simm7, LO7, sub_i32>;

multiclass vbrd_elem64<ValueType v64, ValueType s64, SDPatternOperator ImmOp, SDNodeXForm ImmCast> {
  // VBRDil
  def : Pat<(v64 (vec_broadcast (s64 ImmOp:$sy), i32:$vl)),
            (VBRDil (ImmCast $sy), i32:$vl)>;

  // VBRDrl
  def : Pat<(v64 (vec_broadcast s64:$sy, i32:$vl)),
            (VBRDrl s64:$sy, i32:$vl)>;
}

defm : vbrd_elem64<v256f64, f64, simm7fp, LO7FP>;
defm : vbrd_elem64<v256i64, i64, simm7, LO7>;

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
            (v512i32 (VLDirl 8, $addr,
                             (EXTRACT_SUBREG (LEAzii 0, 0, 256), sub_i32)))>;
  def : Pat<(v512f32 (load I64:$addr)),
            (v512f32 (VLDirl 8, $addr,
                             (EXTRACT_SUBREG (LEAzii 0, 0, 256), sub_i32)))>;
  def : Pat<(v256i32 (load I64:$addr)),
            (v256i32 (VLDLSXirl 4, $addr,
                         (EXTRACT_SUBREG (LEAzii 0, 0, 256), sub_i32)))>;
  def : Pat<(v256f32 (load I64:$addr)),
            (v256f32 (VLDUirl 4, $addr,
                         (EXTRACT_SUBREG (LEAzii 0, 0, 256), sub_i32)))>;
  def : Pat<(v256f64 (load I64:$addr)),
            (v256f64 (VLDirl 8, $addr,
                         (EXTRACT_SUBREG (LEAzii 0, 0, 256), sub_i32)))>;
  def : Pat<(v256i64 (load I64:$addr)),
            (v256i64 (VLDirl 8, $addr,
                         (EXTRACT_SUBREG (LEAzii 0, 0, 256), sub_i32)))>;
  def : Pat<(store v256i32:$vx, I64:$addr),
            (VSTLirvl 4, $addr, v256i32:$vx,
                      (EXTRACT_SUBREG (LEAzii 0, 0, 256), sub_i32))>;
  def : Pat<(store v256f32:$vx, I64:$addr),
            (VSTUirvl 4, $addr, v256f32:$vx,
                      (EXTRACT_SUBREG (LEAzii 0, 0, 256), sub_i32))>;
  def : Pat<(store v256i64:$vx, I64:$addr),
            (VSTirvl 8, $addr, v256i64:$vx,
                     (EXTRACT_SUBREG (LEAzii 0, 0, 256), sub_i32))>;
  def : Pat<(store v256f64:$vx, I64:$addr),
            (VSTirvl 8, $addr, v256f64:$vx,
                     (EXTRACT_SUBREG (LEAzii 0, 0, 256), sub_i32))>;
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
