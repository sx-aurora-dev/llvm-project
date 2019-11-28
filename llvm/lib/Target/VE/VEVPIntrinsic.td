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


/////// Vector Load ///////

// (masked)
// 256 x i64
def : Pat<(v256i64 (vp_load i64:$addr, v256i1:$mask, i32:$avl)),
                   (vgt_vvssml
                     (vaddul_vsvmvl $addr, (vmulul_vIvmvl 8, (vseq_vl $avl), $mask, (IMPLICIT_DEF), $avl), $mask, (IMPLICIT_DEF), $avl),
                     0, 0,
                     $mask,
                     $avl
                   )>;
// 256 x f64
def : Pat<(v256f64 (vp_load i64:$addr, v256i1:$mask, i32:$avl)),
                   (vgt_vvssml
                     (vaddul_vsvmvl $addr, (vmulul_vIvmvl 8, (vseq_vl $avl), $mask, (IMPLICIT_DEF), $avl), $mask, (IMPLICIT_DEF), $avl),
                     0, 0,
                     $mask,
                     $avl
                   )>;

// (unmasked)
// 256 x i64
def : Pat<(v256i64 (vp_load i64:$addr, (v256i1 m_alltrue), i32:$avl)), (vld_vIsl 4, $addr, $avl)>;
// 256 x f64
def : Pat<(v256f64 (vp_load i64:$addr, (v256i1 m_alltrue), i32:$avl)), (vld_vIsl 4, $addr, $avl)>;


// 256 x i32
// (masked)
def : Pat<(v256i32 (vp_load i64:$addr, v256i1:$mask, i32:$avl)),
                   (vgtlzx_vvssml
                     (vaddul_vsvmvl $addr, (vmulul_vIvmvl 8, (vseq_vl $avl), $mask, (IMPLICIT_DEF), $avl), $mask, (IMPLICIT_DEF), $avl),
                     0, 0,
                     $mask,
                     $avl
                   )>;
// (unmasked)
def : Pat<(v256i32 (vp_load i64:$addr, (v256i1 m_alltrue), i32:$avl)), (vldlzx_vIsl 4, $addr, $avl)>;

// 256 x f32
// (masked)
def : Pat<(v256f32 (vp_load i64:$addr, v256i1:$mask, i32:$avl)),
                   (vgtu_vvssml
                     (vaddul_vsvmvl $addr, (vmulul_vIvmvl 8, (vseq_vl $avl), $mask, (IMPLICIT_DEF), $avl), $mask, (IMPLICIT_DEF), $avl),
                     0, 0,
                     $mask,
                     $avl
                   )>;
// (unmasked)
def : Pat<(v256f32 (vp_load i64:$addr, (v256i1 m_alltrue), i32:$avl)), (vldu_vIsl 4, $addr, $avl)>;



// Gather

// 256 x i64
def : Pat<(v256i64 (vp_gather (i64 zero), v256i64:$index, i64:$scale, v256i1:$mask, i32:$avl)),
                   (vgt_vvssml
                     (vmulul_vsvmvl $scale, $index, $mask, (IMPLICIT_DEF), $avl),
                     0, 0,
                     $mask,
                     $avl
                   )>;
def : Pat<(v256i64 (vp_gather i64:$base, v256i64:$index, i64:$scale, v256i1:$mask, i32:$avl)),
                   (vgt_vvssml
                     (vaddul_vsvmvl
                       $base,
                       (vmulul_vsvmvl $scale, $index, $mask, (IMPLICIT_DEF), $avl),
                       $mask,
                       (IMPLICIT_DEF), 
                       $avl),
                     0, 0,
                     $mask,
                     $avl
                   )>;

// 256 x f64
def : Pat<(v256f64 (vp_gather (i64 zero), v256i64:$index, i64:$scale, v256i1:$mask, i32:$avl)),
                   (vgt_vvssml
                     (vmulul_vsvmvl $scale, $index, $mask, (IMPLICIT_DEF), $avl),
                     0, 0,
                     $mask,
                     $avl
                   )>;
def : Pat<(v256f64 (vp_gather i64:$base, v256i64:$index, i64:$scale, v256i1:$mask, i32:$avl)),
                   (vgt_vvssml
                     (vaddul_vsvmvl
                       $base,
                       (vmulul_vsvmvl $scale, $index, $mask, (IMPLICIT_DEF), $avl),
                       $mask,
                       (IMPLICIT_DEF), 
                       $avl),
                     0, 0,
                     $mask,
                     $avl
                   )>;

// 256 x i32
def : Pat<(v256i32 (vp_gather (i64 zero), v256i64:$index, i64:$scale, v256i1:$mask, i32:$avl)),
                   (vgtlzx_vvssml
                     (vmulul_vsvmvl $scale, $index, $mask, (IMPLICIT_DEF), $avl),
                     0, 0,
                     $mask,
                     $avl
                   )>;
def : Pat<(v256i32 (vp_gather i64:$base, v256i64:$index, i64:$scale, v256i1:$mask, i32:$avl)),
                   (vgtlzx_vvssml
                     (vaddul_vsvmvl
                       $base,
                       (vmulul_vsvmvl $scale, $index, $mask, (IMPLICIT_DEF), $avl),
                       $mask,
                       (IMPLICIT_DEF), 
                       $avl),
                     0, 0,
                     $mask,
                     $avl
                   )>;
// 256 x f32
def : Pat<(v256f32 (vp_gather (i64 zero), v256i64:$index, i64:$scale, v256i1:$mask, i32:$avl)),
                   (vgtu_vvssml
                     (vmulul_vsvmvl $scale, $index, $mask, (IMPLICIT_DEF), $avl),
                     0, 0,
                     $mask,
                     $avl
                   )>;
def : Pat<(v256f32 (vp_gather i64:$base, v256i64:$index, i64:$scale, v256i1:$mask, i32:$avl)),
                   (vgtu_vvssml
                     (vaddul_vsvmvl
                       $base,
                       (vmulul_vsvmvl $scale, $index, $mask, (IMPLICIT_DEF), $avl),
                       $mask,
                       (IMPLICIT_DEF), 
                       $avl),
                     0, 0,
                     $mask,
                     $avl
                   )>;

// Scatter

// 256 x i32
def : Pat<(vp_scatter v256i32:$val, (i64 zero), v256i64:$index, i64:$scale, v256i1:$mask, i32:$avl),
          (vscl_vvssml
            $val,
            (vmulul_vsvmvl $scale, $index, $mask, (IMPLICIT_DEF), $avl),
            0, 0,
            $mask,
            $avl
          )>;
def : Pat<(vp_scatter v256i32:$val, i64:$base, v256i64:$index, i64:$scale, v256i1:$mask, i32:$avl),
          (vscl_vvssml
            $val,
            (vaddul_vsvmvl $base,
              (vmulul_vsvmvl $scale, $index, $mask, (IMPLICIT_DEF), $avl),
              $mask,
              (IMPLICIT_DEF), 
              $avl),
            0, 0,
            $mask,
            $avl
          )>;
// 256 x f32
def : Pat<(vp_scatter v256f32:$val, (i64 zero), v256i64:$index, i64:$scale, v256i1:$mask, i32:$avl),
          (vscu_vvssml
            $val,
            (vmulul_vsvmvl $scale, $index, $mask, (IMPLICIT_DEF), $avl),
            0, 0,
            $mask,
            $avl
          )>;
def : Pat<(vp_scatter v256f32:$val, i64:$base, v256i64:$index, i64:$scale, v256i1:$mask, i32:$avl),
          (vscu_vvssml
            $val,
            (vaddul_vsvmvl $base,
              (vmulul_vsvmvl $scale, $index, $mask, (IMPLICIT_DEF), $avl),
              $mask,
              (IMPLICIT_DEF), 
              $avl),
            0, 0,
            $mask,
            $avl
          )>;

// 256 x i64
def : Pat<(vp_scatter v256i64:$val, (i64 zero), v256i64:$index, i64:$scale, v256i1:$mask, i32:$avl),
          (vsc_vvssml
            $val,
            (vmulul_vsvmvl $scale, $index, $mask, (IMPLICIT_DEF), $avl),
            0, 0,
            $mask,
            $avl
          )>;
def : Pat<(vp_scatter v256i64:$val, i64:$base, v256i64:$index, i64:$scale, v256i1:$mask, i32:$avl),
          (vsc_vvssml
            $val,
            (vaddul_vsvmvl $base,
              (vmulul_vsvmvl $scale, $index, $mask, (IMPLICIT_DEF), $avl),
              $mask,
              (IMPLICIT_DEF), 
              $avl),
            0, 0,
            $mask,
            $avl
          )>;


// Vector Store
// 256 x i64
def : Pat<(vp_store v256i64:$value, v256i64:$addr, v256i1:$mask, i32:$avl), (vsc_vvssml $value, $addr, 0, 0, $mask, $avl)>;
def : Pat<(vp_store v256i64:$value, i64:$addr, v256i1:$mask, i32:$avl), (vst_vIsml $value, 8, $addr, $mask, $avl)>;
// 256 x f64
def : Pat<(vp_store v256f64:$value, v256i64:$addr, v256i1:$mask, i32:$avl), (vsc_vvssml $value, $addr, 0, 0, $mask, $avl)>; 
def : Pat<(vp_store v256f64:$value, i64:$addr, v256i1:$mask, i32:$avl), (vst_vIsml $value, 8, $addr, $mask, $avl)>;
// 256 x i32
def : Pat<(vp_store v256i32:$value, v256i64:$addr, v256i1:$mask, i32:$avl), (vscl_vvssml $value, $addr, 0, 0, $mask, $avl)>;
def : Pat<(vp_store v256i32:$value, i64:$addr, v256i1:$mask, i32:$avl), (vstl_vssml $value, 4, $addr, $mask, $avl)>;
// 256 x f32
def : Pat<(vp_store v256f32:$value, v256i64:$addr, v256i1:$mask, i32:$avl), (vscu_vvssml $value, $addr, 0, 0, $mask, $avl)>;
def : Pat<(vp_store v256f32:$value, i64:$addr, v256i1:$mask, i32:$avl), (vstu_vssml $value, 4, $addr, $mask, $avl)>;


// Arithmetic ops

def : Pat<(v256f64 (vp_fadd v256f64:$vx, v256f64:$vy, v256i1:$mask, i32:$avl)), (vfaddd_vvvmvl $vx, $vy, $mask, (v256f64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f64 (vp_fsub v256f64:$vx, v256f64:$vy, v256i1:$mask, i32:$avl)), (vfsubd_vvvmvl $vx, $vy, $mask, (v256f64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f64 (vp_fmul v256f64:$vx, v256f64:$vy, v256i1:$mask, i32:$avl)), (vfmuld_vvvmvl $vx, $vy, $mask, (v256f64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f64 (vp_fdiv v256f64:$vx, v256f64:$vy, v256i1:$mask, i32:$avl)), (vfdivd_vvvmvl $vx, $vy, $mask, (v256f64 (IMPLICIT_DEF)), $avl)>;

def : Pat<(v256f32 (vp_fadd v256f32:$vx, v256f32:$vy, v256i1:$mask, i32:$avl)), (vfadds_vvvmvl $vx, $vy, $mask, (v256f32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f32 (vp_fsub v256f32:$vx, v256f32:$vy, v256i1:$mask, i32:$avl)), (vfsubs_vvvmvl $vx, $vy, $mask, (v256f32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f32 (vp_fmul v256f32:$vx, v256f32:$vy, v256i1:$mask, i32:$avl)), (vfmuls_vvvmvl $vx, $vy, $mask, (v256f32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f32 (vp_fdiv v256f32:$vx, v256f32:$vy, v256i1:$mask, i32:$avl)), (vfdivs_vvvmvl $vx, $vy, $mask, (v256f32 (IMPLICIT_DEF)), $avl)>;

def : Pat<(v256f64 (vp_fma v256f64:$vz, v256f64:$vw, v256f64:$vy, v256i1:$mask, i32:$avl)), (vfmadd_vvvvmvl $vy, $vz, $vw, $mask, (v256f64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f32 (vp_fma v256f32:$vz, v256f32:$vw, v256f32:$vy, v256i1:$mask, i32:$avl)), (vfmads_vvvvmvl $vy, $vz, $vw, $mask, (v256f64 (IMPLICIT_DEF)), $avl)>;

def : Pat<(v256i64 (vp_add v256i64:$vx, v256i64:$vy, v256i1:$mask, i32:$avl)),  (vaddul_vvvmvl $vx, $vy, $mask, (v256i64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i64 (vp_sub v256i64:$vx, v256i64:$vy, v256i1:$mask, i32:$avl)),  (vsubul_vvvmvl $vx, $vy, $mask, (v256i64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i64 (vp_mul v256i64:$vx, v256i64:$vy, v256i1:$mask, i32:$avl)),  (vmulul_vvvmvl $vx, $vy, $mask, (v256i64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i64 (vp_sdiv v256i64:$vx, v256i64:$vy, v256i1:$mask, i32:$avl)), (vdivsl_vvvmvl $vx, $vy, $mask, (v256i64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i64 (vp_udiv v256i64:$vx, v256i64:$vy, v256i1:$mask, i32:$avl)), (vdivul_vvvmvl $vx, $vy, $mask, (v256i64 (IMPLICIT_DEF)), $avl)>;

def : Pat<(v256i32 (vp_add v256i32:$vx, v256i32:$vy, v256i1:$mask, i32:$avl)),  (vadduw_vvvmvl   $vx, $vy, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i32 (vp_sub v256i32:$vx, v256i32:$vy, v256i1:$mask, i32:$avl)),  (vsubuw_vvvmvl   $vx, $vy, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i32 (vp_mul v256i32:$vx, v256i32:$vy, v256i1:$mask, i32:$avl)),  (vmuluw_vvvmvl   $vx, $vy, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i32 (vp_sdiv v256i32:$vx, v256i32:$vy, v256i1:$mask, i32:$avl)), (vdivswsx_vvvmvl $vx, $vy, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i32 (vp_udiv v256i32:$vx, v256i32:$vy, v256i1:$mask, i32:$avl)), (vdivuw_vvvmvl   $vx, $vy, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;

// Logic ops

def : Pat<(v256i64 (vp_and v256i64:$vx, v256i64:$vy, v256i1:$mask, i32:$avl)), (vand_vvvmvl $vx, $vy, $mask, (v256i64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i64 (vp_or  v256i64:$vx, v256i64:$vy, v256i1:$mask, i32:$avl)), (vor_vvvmvl  $vx, $vy, $mask, (v256i64 (IMPLICIT_DEF)),   $avl)>;
def : Pat<(v256i64 (vp_xor v256i64:$vx, v256i64:$vy, v256i1:$mask, i32:$avl)), (vxor_vvvmvl $vx, $vy, $mask, (v256i64 (IMPLICIT_DEF)), $avl)>;

def : Pat<(v256i32 (vp_and v256i32:$vx, v256i32:$vy, v256i1:$mask, i32:$avl)), (vand_vvvmvl $vx, $vy, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i32 (vp_or  v256i32:$vx, v256i32:$vy, v256i1:$mask, i32:$avl)), (vor_vvvmvl  $vx, $vy, $mask, (v256i32 (IMPLICIT_DEF)),   $avl)>;
def : Pat<(v256i32 (vp_xor v256i32:$vx, v256i32:$vy, v256i1:$mask, i32:$avl)), (vxor_vvvmvl $vx, $vy, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;

def : Pat<(v256i1 (vp_and v256i1:$ma, v256i1:$mb, v256i1:$mask, i32:$avl)), (NOOPmi $avl, (NOOPmm $mask, (ANDM $ma, $mb)))>;
def : Pat<(v256i1 (vp_or  v256i1:$ma, v256i1:$mb, v256i1:$mask, i32:$avl)), (NOOPmi $avl, (NOOPmm $mask, (ORM $ma, $mb)))>;
def : Pat<(v256i1 (vp_xor v256i1:$ma, v256i1:$mb, v256i1:$mask, i32:$avl)), (NOOPmi $avl, (NOOPmm $mask, (XORM $ma, $mb)))>;

// Shifts

def : Pat<(v256i64 (vp_srl v256i64:$val, v256i64:$n, v256i1:$mask, i32:$avl)), (vsrl_vvvmvl $n, $val, $mask, (v256i64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i64 (vp_sra v256i64:$val, v256i64:$n, v256i1:$mask, i32:$avl)), (vsral_vvvmvl  $n, $val, $mask, (v256i64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i64 (vp_shl v256i64:$val, v256i64:$n, v256i1:$mask, i32:$avl)), (vsll_vvvmvl  $n, $val, $mask, (v256i64 (IMPLICIT_DEF)), $avl)>;

def : Pat<(v256i32 (vp_srl v256i32:$val, v256i32:$n, v256i1:$mask, i32:$avl)), (vsrl_vvvmvl $n, $val, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i32 (vp_sra v256i32:$val, v256i32:$n, v256i1:$mask, i32:$avl)), (vsral_vvvmvl  $n, $val, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i32 (vp_shl v256i32:$val, v256i32:$n, v256i1:$mask, i32:$avl)), (vslaw_vvvmvl $n, $val, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;

// Reductions
// TODO (check allowReassociation bit)
//    VP_REDUCE_FADD, VP_REDUCE_FMUL,
//    VP_REDUCE_ADD, VP_REDUCE_MUL,
//    VP_REDUCE_AND, VP_REDUCE_OR, VP_REDUCE_XOR,
//    VP_REDUCE_SMAX, VP_REDUCE_SMIN, VP_REDUCE_UMAX, VP_REDUCE_UMIN,
