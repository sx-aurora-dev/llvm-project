//===----------------------------------------------------------------------===//
// Vector Instruction Patterns
//===----------------------------------------------------------------------===//

// Pattern Matchings for Generic Vector Instructions

// Load and store for
// v256i32, v256i64, v512i32, v256f32, v256f64, v512f32.

def : Pat<(v256i32 (load ADDRri:$addr)), 
          (v256i32 (VLDLsxir 4, (LEAasx ADDRri:$addr)))>;

def : Pat<(v256f32 (load ADDRri:$addr)), 
          (v256f32 (VLDUir 4, (LEAasx ADDRri:$addr)))>;

def : Pat<(v256f64 (load ADDRri:$addr)), 
          (v256f64 (VLDir 8, (LEAasx ADDRri:$addr)))>;

def : Pat<(v256i64 (load ADDRri:$addr)), 
          (v256i64 (VLDir 8, (LEAasx ADDRri:$addr)))>;

def : Pat<(v512i32 (load ADDRri:$addr)), 
          (v512i32 (VLDir 8, (LEAasx ADDRri:$addr)))>;

def : Pat<(v512f32 (load ADDRri:$addr)), 
          (v512f32 (VLDir 8, (LEAasx ADDRri:$addr)))>;

def : Pat<(store v256i32:$vx, ADDRri:$addr), 
          (VSTLir v256i32:$vx, 4, (LEAasx ADDRri:$addr))>;

def : Pat<(store v256f32:$vx, ADDRri:$addr), 
          (VSTUir v256f32:$vx, 4, (LEAasx ADDRri:$addr))>;

def : Pat<(store v256f64:$vx, ADDRri:$addr), 
          (VSTir v256f64:$vx, 8, (LEAasx ADDRri:$addr))>;

def : Pat<(store v256i64:$vx, ADDRri:$addr), 
          (VSTir v256i64:$vx, 8, (LEAasx ADDRri:$addr))>;

def : Pat<(store v512i32:$vx, ADDRri:$addr), 
          (VSTir v512i32:$vx, 8, (LEAasx ADDRri:$addr))>;

def : Pat<(store v512f32:$vx, ADDRri:$addr), 
          (VSTir v512f32:$vx, 8, (LEAasx ADDRri:$addr))>;

// fadd, fsub, fmul, and fdiv for
// v256f32, v256f64, v512f32.

def : Pat<(fadd v256f32:$vy, v256f32:$vz), (VFADsv v256f32:$vy, v256f32:$vz)>;
def : Pat<(fadd v256f64:$vy, v256f64:$vz), (VFADdv v256f64:$vy, v256f64:$vz)>;
def : Pat<(fadd v512f32:$vy, v512f32:$vz), (VFADpv v512f32:$vy, v512f32:$vz)>;

def : Pat<(fsub v256f32:$vy, v256f32:$vz), (VFSBsv v256f32:$vy, v256f32:$vz)>;
def : Pat<(fsub v256f64:$vy, v256f64:$vz), (VFSBdv v256f64:$vy, v256f64:$vz)>;
def : Pat<(fsub v512f32:$vy, v512f32:$vz), (VFSBpv v512f32:$vy, v512f32:$vz)>;

def : Pat<(fmul v256f32:$vy, v256f32:$vz), (VFMPsv v256f32:$vy, v256f32:$vz)>;
def : Pat<(fmul v256f64:$vy, v256f64:$vz), (VFMPdv v256f64:$vy, v256f64:$vz)>;
def : Pat<(fmul v512f32:$vy, v512f32:$vz), (VFMPpv v512f32:$vy, v512f32:$vz)>;

def : Pat<(fdiv v256f32:$vy, v256f32:$vz), (VFDVsv v256f32:$vy, v256f32:$vz)>;
def : Pat<(fdiv v256f64:$vy, v256f64:$vz), (VFDVdv v256f64:$vy, v256f64:$vz)>;
def : Pat<(fdiv v512f32:$vy, v512f32:$vz), (VFDVpv v512f32:$vy, v512f32:$vz)>;

// add, sub, mul, sdiv, and udiv for
// v256i32, v256i64, v512i32.

def : Pat<(add v256i32:$vy, v256i32:$vz), (VADSwsxv v256i32:$vy, v256i32:$vz)>;
def : Pat<(add v256i64:$vy, v256i64:$vz), (VADDlv v256i64:$vy, v256i64:$vz)>;
def : Pat<(add v512i32:$vy, v512i32:$vz), (VADSpv v512i32:$vy, v512i32:$vz)>;

def : Pat<(sub v256i32:$vy, v256i32:$vz), (VSBSwsxv v256i32:$vy, v256i32:$vz)>;
def : Pat<(sub v256i64:$vy, v256i64:$vz), (VSUBlv v256i64:$vy, v256i64:$vz)>;
def : Pat<(sub v512i32:$vy, v512i32:$vz), (VSBSpv v512i32:$vy, v512i32:$vz)>;

def : Pat<(mul v256i32:$vy, v256i32:$vz), (VMPSwsxv v256i32:$vy, v256i32:$vz)>;
def : Pat<(mul v256i64:$vy, v256i64:$vz), (VMPYlv v256i64:$vy, v256i64:$vz)>;

def : Pat<(sdiv v256i32:$vy, v256i32:$vz), (VDVSwsxv v256i32:$vy, v256i32:$vz)>;
def : Pat<(sdiv v256i64:$vy, v256i64:$vz), (VDVXlv v256i64:$vy, v256i64:$vz)>;

def : Pat<(udiv v256i32:$vy, v256i32:$vz), (VDIVwv v256i32:$vy, v256i32:$vz)>;
def : Pat<(udiv v256i64:$vy, v256i64:$vz), (VDIVlv v256i64:$vy, v256i64:$vz)>;

// Bitconvert for mask registers between 
// v4i64 or v8i64 and v256i1 or v512i1 respectively

def : Pat<(v256i1 (bitconvert v4i64:$v)),
          (v256i1 (V2VM (COPY_TO_REGCLASS $v, V64)))>;

def : Pat<(v4i64 (bitconvert v256i1:$vm)),
          (v4i64 (COPY_TO_REGCLASS (VM2V $vm), V64))>;

def : Pat<(v512i1 (bitconvert v8i64:$v)),
          (v512i1 (V2VMP (COPY_TO_REGCLASS $v, V64)))>;

def : Pat<(v8i64 (bitconvert v512i1:$vmp)),
          (v8i64 (COPY_TO_REGCLASS (VMP2V $vmp), V64))>;

// Series of SCALAR_TO_VECTOR for all VE vector types,
// v256i32, v256i64, v512i32, v256f32, v256f64, v512f32.
//
// NOTE: Need to use sub_f32 for v512i32 since v512i32 uses
//       upper 32 bits (0..31) first.

def: Pat<(v256i32 (scalar_to_vector i32:$val)),
         (v256i32 (LSVi (v256i32 (IMPLICIT_DEF)), 0,
                        (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32)))>;
def: Pat<(v256f32 (scalar_to_vector f32:$val)),
         (v256f32 (LSVi (v256f32 (IMPLICIT_DEF)), 0,
                        (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32)))>;
def: Pat<(v512i32 (scalar_to_vector i32:$val)),
         (v512i32 (LSVi (v512i32 (IMPLICIT_DEF)), 0,
                        (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32)))>;
def: Pat<(v512f32 (scalar_to_vector f32:$val)),
         (v512f32 (LSVi (v512f32 (IMPLICIT_DEF)), 0,
                        (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32)))>;
def: Pat<(v256f64 (scalar_to_vector f64:$val)),
         (v256f64 (LSVi (v256f64 (IMPLICIT_DEF)), 0,
                        (COPY_TO_REGCLASS $val, I64)))>;
def: Pat<(v256i64 (scalar_to_vector i64:$val)),
         (v256i64 (LSVi (v256i64 (IMPLICIT_DEF)), 0, $val))>;

// Series of INSERT_VECOR_ELT for all VE vector types,
// v256i32, v256i64, v256f32, v256f64.
// v512i32 and v512f32 is expanded by LowerINSERT_VECTOR_ELT().

def: Pat<(v256i32 (insertelt v256i32:$vec, i32:$val, uimm7:$idx)),
         (v256i32 (LSVi v256i32:$vec, imm:$idx,
                        (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32)))>;
def: Pat<(v256i32 (insertelt v256i32:$vec, i32:$val, i64:$idx)),
         (v256i32 (LSVr v256i32:$vec,
                        (EXTRACT_SUBREG $idx, sub_i32),
                        (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32)))>;

def: Pat<(v256f32 (insertelt v256f32:$vec, f32:$val, uimm7:$idx)),
         (v256f32 (LSVi v256f32:$vec, imm:$idx,
                        (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32)))>;
def: Pat<(v256f32 (insertelt v256f32:$vec, f32:$val, i64:$idx)),
         (v256f32 (LSVr v256f32:$vec,
                        (EXTRACT_SUBREG $idx, sub_f32),
                        (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32)))>;

def: Pat<(v256f64 (insertelt v256f64:$vec, f64:$val, uimm7:$idx)),
         (v256f64 (LSVi v256f64:$vec, imm:$idx,
                        (COPY_TO_REGCLASS $val, I64)))>;
def: Pat<(v256f64 (insertelt v256f64:$vec, f64:$val, i64:$idx)),
         (v256f64 (LSVr v256f64:$vec,
                        (EXTRACT_SUBREG $idx, sub_i32),
                        (COPY_TO_REGCLASS $val, I64)))>;

def: Pat<(v256i64 (insertelt v256i64:$vec, i64:$val, uimm7:$idx)),
         (v256i64 (LSVi v256i64:$vec, imm:$idx, $val))>;
def: Pat<(v256i64 (insertelt v256i64:$vec, i64:$val, i64:$idx)),
         (v256i64 (LSVr v256i64:$vec,
                        (EXTRACT_SUBREG $idx, sub_i32), $val))>;

// Series of EXTRACT_VECOR_ELT for all VE vector types,
// v256i32, v256i64, v256f32, v256f64.
// v512i32 and v512f32 is expanded by LowerEXTRACT_VECTOR_ELT().

def: Pat<(i32 (extractelt v256i32:$vec, uimm7:$idx)),
         (EXTRACT_SUBREG (LVSi v256i32:$vec, imm:$idx), sub_i32)>;
def: Pat<(i32 (extractelt v256i32:$vec, i64:$idx)),
         (EXTRACT_SUBREG (LVSr v256i32:$vec, $idx), sub_i32)>;

def: Pat<(f32 (extractelt v256f32:$vec, uimm7:$idx)),
         (EXTRACT_SUBREG (LVSi v256f32:$vec, imm:$idx), sub_f32)>;
def: Pat<(f32 (extractelt v256f32:$vec, i64:$idx)),
         (EXTRACT_SUBREG (LVSr v256f32:$vec, $idx), sub_f32)>;

def: Pat<(f64 (extractelt v256f64:$vec, uimm7:$idx)),
         (LVSi v256f64:$vec, imm:$idx)>;
def: Pat<(f64 (extractelt v256f64:$vec, i64:$idx)),
         (LVSr v256f64:$vec, $idx)>;

def: Pat<(i64 (extractelt v256i64:$vec, uimm7:$idx)),
         (LVSi v256i64:$vec, imm:$idx)>;
def: Pat<(i64 (extractelt v256i64:$vec, i64:$idx)),
         (LVSr v256i64:$vec, $idx)>;

