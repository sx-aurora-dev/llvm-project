// def : Pat<(int_ve_vstot_vss v256f64:$vx, i64:$sy, i64:$sz), (VSTotrr v256f64:$vx, i64:$sy, i64:$sz, (GetVL (i32 0)))>;

//TODO: many of those patterns would actually be better of using custom lowering!

// Helpers to disregard inputs.
//TODO: This should probably be solved differently!
class NOOP<dag outs, dag ins> : Instruction {
  let Namespace = "VE";
  let Size = 0;

  field bits<0> Inst;

  let OutOperandList = outs;
  let InOperandList = ins;
  let AsmString = ";";
  let Pattern = [];
}

def NOOPdm : NOOP<(outs V64:$out), (ins VM:$m, V64:$in)> { let Constraints = "$out = $in"; }
def NOOPmi : NOOP<(outs VM:$out), (ins I32:$a, VM:$in)> { let Constraints = "$out = $in"; }
def NOOPmm : NOOP<(outs VM:$out), (ins VM:$m, VM:$in)> { let Constraints = "$out = $in"; }

// Vector Load

def : Pat<(v256i64 (vp_load i64:$addr, v256i1:$mask, i32:$avl)),
                   (VGTvm
                     (VADXlrm $addr, (VMPYlim 8, (VSEQlv $avl), $mask, (IMPLICIT_DEF), $avl), $mask, (IMPLICIT_DEF), $avl),
                     $mask,
                     $avl
                   )>;

def : Pat<(v256f64 (vp_load i64:$addr, v256i1:$mask, i32:$avl)),
                   (VGTvm
                     (VADXlrm $addr, (VMPYlim 8, (VSEQlv $avl), $mask, (IMPLICIT_DEF), $avl), $mask, (IMPLICIT_DEF), $avl),
                     $mask,
                     $avl
                   )>;

// Gather

def : Pat<(v256i64 (vp_gather (i64 zero), v256i64:$index, i64:$scale, v256i1:$mask, i32:$avl)),
                   (VGTvm
                     (VMPYlim $scale, $index, $mask, (IMPLICIT_DEF), $avl),
                     $mask,
                     $avl
                   )>;

def : Pat<(v256i64 (vp_gather i64:$base, v256i64:$index, i64:$scale, v256i1:$mask, i32:$avl)),
                   (VGTvm
                     (VADXlrm $base,
                       (VMPYlim $scale, $index, $mask, (IMPLICIT_DEF), $avl),
                       $mask,
                       (IMPLICIT_DEF), 
                       $avl),
                     $mask,
                     $avl
                   )>;

// Scatter

def : Pat<(vp_scatter v256i64:$val, (i64 zero), v256i64:$index, i64:$scale, v256i1:$mask, i32:$avl),
          (VSCvm
            $val,
            (VMPYlim $scale, $index, $mask, (IMPLICIT_DEF), $avl),
            $mask,
            $avl
          )>;

def : Pat<(vp_scatter v256i64:$val, i64:$base, v256i64:$index, i64:$scale, v256i1:$mask, i32:$avl),
          (VSCvm
            $val,
            (VADXlrm $base,
              (VMPYlim $scale, $index, $mask, (IMPLICIT_DEF), $avl),
              $mask,
              (IMPLICIT_DEF), 
              $avl),
            $mask,
            $avl
          )>;


def : Pat<(v256i32 (vp_load i64:$addr, v256i1:$mask, i32:$avl)),
          (VGTLsxvm
            (VADXlrm $addr, (VMPYlim 4, (VSEQlv $avl), $mask, (IMPLICIT_DEF), $avl), $mask, (IMPLICIT_DEF), $avl),
            $mask,
            $avl
          )>;
def : Pat<(v256f32 (vp_load i64:$addr, v256i1:$mask, i32:$avl)),
          (VGTLsxvm
            (VADXlrm $addr, (VMPYlim 4, (VSEQlv $avl), $mask, (IMPLICIT_DEF), $avl), $mask, (IMPLICIT_DEF), $avl),
            $mask,
            $avl
          )>;

// Vector Store

def : Pat<(vp_store v256i64:$value, v256i64:$addr, v256i1:$mask, i32:$avl), (VSCvm $value, $addr, $mask, $avl)>;
def : Pat<(vp_store v256i64:$value, i64:$addr, v256i1:$mask, i32:$avl), (VSTirm $value, 8, $addr, $mask, $avl)>;
def : Pat<(vp_store v256f64:$value, i64:$addr, v256i1:$mask, i32:$avl), (VSTirm $value, 8, $addr, $mask, $avl)>;

def : Pat<(vp_store v256i32:$value, i64:$addr, v256i1:$mask, i32:$avl), (VSTLirm $value, 4, $addr, $mask, $avl)>;
def : Pat<(vp_store v256f32:$value, i64:$addr, v256i1:$mask, i32:$avl), (VSTUirm $value, 4, $addr, $mask, $avl)>;


// Arithmetic ops

def : Pat<(v256f64 (vp_fadd v256f64:$vx, v256f64:$vy, v256i1:$mask, i32:$avl)), (VFADdvm $vx, $vy, $mask, (v256f64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f64 (vp_fsub v256f64:$vx, v256f64:$vy, v256i1:$mask, i32:$avl)), (VFSBdvm $vx, $vy, $mask, (v256f64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f64 (vp_fmul v256f64:$vx, v256f64:$vy, v256i1:$mask, i32:$avl)), (VFMPdvm $vx, $vy, $mask, (v256f64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f64 (vp_fdiv v256f64:$vx, v256f64:$vy, v256i1:$mask, i32:$avl)), (VFDVdvm $vx, $vy, $mask, (v256f64 (IMPLICIT_DEF)), $avl)>;

def : Pat<(v256f32 (vp_fadd v256f32:$vx, v256f32:$vy, v256i1:$mask, i32:$avl)), (VFADsvm $vx, $vy, $mask, (v256f32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f32 (vp_fsub v256f32:$vx, v256f32:$vy, v256i1:$mask, i32:$avl)), (VFSBsvm $vx, $vy, $mask, (v256f32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f32 (vp_fmul v256f32:$vx, v256f32:$vy, v256i1:$mask, i32:$avl)), (VFMPsvm $vx, $vy, $mask, (v256f32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f32 (vp_fdiv v256f32:$vx, v256f32:$vy, v256i1:$mask, i32:$avl)), (VFDVsvm $vx, $vy, $mask, (v256f32 (IMPLICIT_DEF)), $avl)>;

def : Pat<(v256f64 (vp_fma v256f64:$vz, v256f64:$vw, v256f64:$vy, v256i1:$mask, i32:$avl)), (VFMADdvm $vy, $vz, $vw, $mask, (v256f64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f32 (vp_fma v256f32:$vz, v256f32:$vw, v256f32:$vy, v256i1:$mask, i32:$avl)), (VFMADsvm $vy, $vz, $vw, $mask, (v256f64 (IMPLICIT_DEF)), $avl)>;

def : Pat<(v256i64 (vp_add v256i64:$vx, v256i64:$vy, v256i1:$mask, i32:$avl)),  (VADXlvm $vx, $vy, $mask, (v256i64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i64 (vp_sub v256i64:$vx, v256i64:$vy, v256i1:$mask, i32:$avl)),  (VSBXlvm $vx, $vy, $mask, (v256i64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i64 (vp_mul v256i64:$vx, v256i64:$vy, v256i1:$mask, i32:$avl)),  (VMPXlvm $vx, $vy, $mask, (v256i64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i64 (vp_sdiv v256i64:$vx, v256i64:$vy, v256i1:$mask, i32:$avl)), (VDVXlvm $vx, $vy, $mask, (v256i64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i64 (vp_udiv v256i64:$vx, v256i64:$vy, v256i1:$mask, i32:$avl)), (VDIVlvm $vx, $vy, $mask, (v256i64 (IMPLICIT_DEF)), $avl)>;

def : Pat<(v256i32 (vp_add v256i32:$vx, v256i32:$vy, v256i1:$mask, i32:$avl)),  (VADSwsxvm $vx, $vy, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i32 (vp_sub v256i32:$vx, v256i32:$vy, v256i1:$mask, i32:$avl)),  (VSBSwsxvm $vx, $vy, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i32 (vp_mul v256i32:$vx, v256i32:$vy, v256i1:$mask, i32:$avl)),  (VMPSwsxvm $vx, $vy, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i32 (vp_sdiv v256i32:$vx, v256i32:$vy, v256i1:$mask, i32:$avl)), (VDVSwsxvm $vx, $vy, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i32 (vp_udiv v256i32:$vx, v256i32:$vy, v256i1:$mask, i32:$avl)), (VDIVwvm $vx, $vy, $mask,   (v256i32 (IMPLICIT_DEF)), $avl)>;

// Logic ops

def : Pat<(v256i64 (vp_and v256i64:$vx, v256i64:$vy, v256i1:$mask, i32:$avl)), (VANDvm $vx, $vy, $mask, (v256i64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i64 (vp_or  v256i64:$vx, v256i64:$vy, v256i1:$mask, i32:$avl)), (VORvm $vx, $vy, $mask, (v256i64 (IMPLICIT_DEF)),   $avl)>;
def : Pat<(v256i64 (vp_xor v256i64:$vx, v256i64:$vy, v256i1:$mask, i32:$avl)), (VXORvm $vx, $vy, $mask, (v256i64 (IMPLICIT_DEF)), $avl)>;

def : Pat<(v256i32 (vp_and v256i32:$vx, v256i32:$vy, v256i1:$mask, i32:$avl)), (VANDvm $vx, $vy, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i32 (vp_or  v256i32:$vx, v256i32:$vy, v256i1:$mask, i32:$avl)), (VORvm $vx, $vy, $mask, (v256i32 (IMPLICIT_DEF)),   $avl)>;
def : Pat<(v256i32 (vp_xor v256i32:$vx, v256i32:$vy, v256i1:$mask, i32:$avl)), (VXORvm $vx, $vy, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;

def : Pat<(v256i1 (vp_and v256i1:$ma, v256i1:$mb, v256i1:$mask, i32:$avl)), (NOOPmi $avl, (NOOPmm $mask, (ANDM $ma, $mb)))>;
def : Pat<(v256i1 (vp_or  v256i1:$ma, v256i1:$mb, v256i1:$mask, i32:$avl)), (NOOPmi $avl, (NOOPmm $mask, (ORM $ma, $mb)))>;
def : Pat<(v256i1 (vp_xor v256i1:$ma, v256i1:$mb, v256i1:$mask, i32:$avl)), (NOOPmi $avl, (NOOPmm $mask, (XORM $ma, $mb)))>;

// Shifts

def : Pat<(v256i64 (vp_srl v256i64:$val, v256i64:$n, v256i1:$mask, i32:$avl)), (VSRLvm $n, $val, $mask,  (v256i64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i64 (vp_sra v256i64:$val, v256i64:$n, v256i1:$mask, i32:$avl)), (VSRAXvm $n, $val, $mask, (v256i64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i64 (vp_shl v256i64:$val, v256i64:$n, v256i1:$mask, i32:$avl)), (VSLLvm $n, $val, $mask,  (v256i64 (IMPLICIT_DEF)), $avl)>;

def : Pat<(v256i32 (vp_srl v256i32:$val, v256i32:$n, v256i1:$mask, i32:$avl)), (VSRLlvm $n, $val, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i32 (vp_sra v256i32:$val, v256i32:$n, v256i1:$mask, i32:$avl)), (VSRAvm $n, $val, $mask,  (v256i32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i32 (vp_shl v256i32:$val, v256i32:$n, v256i1:$mask, i32:$avl)), (VSLLlvm $n, $val, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;

// Reductions
// TODO (check allowReassociation bit)
//    VP_REDUCE_FADD, VP_REDUCE_FMUL,
//    VP_REDUCE_ADD, VP_REDUCE_MUL,
//    VP_REDUCE_AND, VP_REDUCE_OR, VP_REDUCE_XOR,
//    VP_REDUCE_SMAX, VP_REDUCE_SMIN, VP_REDUCE_UMAX, VP_REDUCE_UMIN,
