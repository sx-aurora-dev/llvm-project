// def : Pat<(int_ve_vstot_vss v256f64:$vx, i64:$sy, i64:$sz), (VSTotrr v256f64:$vx, i64:$sy, i64:$sz, (GetVL (i32 0)))>;

//TODO: many of those patterns would actually be better of using custom lowering!

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
def : Pat<(v256i64 (vp_load i64:$addr, (v256i1 true_mask), i32:$avl)), (vld_vIsl 4, $addr, $avl)>;
// 256 x f64
def : Pat<(v256f64 (vp_load i64:$addr, (v256i1 true_mask), i32:$avl)), (vld_vIsl 4, $addr, $avl)>;


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
def : Pat<(v256i32 (vp_load i64:$addr, (v256i1 true_mask), i32:$avl)), (vldlzx_vIsl 4, $addr, $avl)>;

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
def : Pat<(v256f32 (vp_load i64:$addr, (v256i1 true_mask), i32:$avl)), (vldu_vIsl 4, $addr, $avl)>;



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
// 256 x f64 // TODO use multiclass
def : Pat<(vp_scatter v256f64:$val, (i64 zero), v256i64:$index, i64:$scale, v256i1:$mask, i32:$avl),
          (vsc_vvssml
            $val,
            (vmulul_vsvmvl $scale, $index, $mask, (IMPLICIT_DEF), $avl),
            0, 0,
            $mask,
            $avl
          )>;
def : Pat<(vp_scatter v256f64:$val, i64:$base, v256i64:$index, i64:$scale, v256i1:$mask, i32:$avl),
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

// 256 x f64
def : Pat<(v256f64 (vp_fadd v256f64:$vx, v256f64:$vy, v256i1:$mask, i32:$avl)), (vfaddd_vvvmvl $vx, $vy, $mask, (v256f64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f64 (vp_fsub v256f64:$vx, v256f64:$vy, v256i1:$mask, i32:$avl)), (vfsubd_vvvmvl $vx, $vy, $mask, (v256f64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f64 (vp_fmul v256f64:$vx, v256f64:$vy, v256i1:$mask, i32:$avl)), (vfmuld_vvvmvl $vx, $vy, $mask, (v256f64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f64 (vp_fdiv v256f64:$vx, v256f64:$vy, v256i1:$mask, i32:$avl)), (vfdivd_vvvmvl $vx, $vy, $mask, (v256f64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f64 (vp_fminnum v256f64:$vx, v256f64:$vy, v256i1:$mask, i32:$avl)), (vfmaxd_vvvmvl $vx, $vy, $mask, (v256f64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f64 (vp_fmaxnum v256f64:$vx, v256f64:$vy, v256i1:$mask, i32:$avl)), (vfmind_vvvmvl $vx, $vy, $mask, (v256f64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f64 (vp_fma v256f64:$vz, v256f64:$vw, v256f64:$vy, v256i1:$mask, i32:$avl)), (vfmadd_vvvvmvl $vy, $vz, $vw, $mask, (v256f64 (IMPLICIT_DEF)), $avl)>;

// 256 x f32
def : Pat<(v256f32 (vp_fadd v256f32:$vx, v256f32:$vy, v256i1:$mask, i32:$avl)), (vfadds_vvvmvl $vx, $vy, $mask, (v256f32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f32 (vp_fsub v256f32:$vx, v256f32:$vy, v256i1:$mask, i32:$avl)), (vfsubs_vvvmvl $vx, $vy, $mask, (v256f32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f32 (vp_fmul v256f32:$vx, v256f32:$vy, v256i1:$mask, i32:$avl)), (vfmuls_vvvmvl $vx, $vy, $mask, (v256f32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f32 (vp_fdiv v256f32:$vx, v256f32:$vy, v256i1:$mask, i32:$avl)), (vfdivs_vvvmvl $vx, $vy, $mask, (v256f32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f32 (vp_fminnum v256f32:$vx, v256f32:$vy, v256i1:$mask, i32:$avl)), (vfmaxs_vvvmvl $vx, $vy, $mask, (v256f32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f32 (vp_fmaxnum v256f32:$vx, v256f32:$vy, v256i1:$mask, i32:$avl)), (vfmins_vvvmvl $vx, $vy, $mask, (v256f32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f32 (vp_fma v256f32:$vz, v256f32:$vw, v256f32:$vy, v256i1:$mask, i32:$avl)), (vfmads_vvvvmvl $vy, $vz, $vw, $mask, (v256f64 (IMPLICIT_DEF)), $avl)>;

// 256 x i64
def : Pat<(v256i64 (vp_add v256i64:$vx, v256i64:$vy, v256i1:$mask, i32:$avl)),  (vaddul_vvvmvl $vx, $vy, $mask, (v256i64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i64 (vp_sub v256i64:$vx, v256i64:$vy, v256i1:$mask, i32:$avl)),  (vsubul_vvvmvl $vx, $vy, $mask, (v256i64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i64 (vp_mul v256i64:$vx, v256i64:$vy, v256i1:$mask, i32:$avl)),  (vmulul_vvvmvl $vx, $vy, $mask, (v256i64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i64 (vp_sdiv v256i64:$vx, v256i64:$vy, v256i1:$mask, i32:$avl)), (vdivsl_vvvmvl $vx, $vy, $mask, (v256i64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i64 (vp_udiv v256i64:$vx, v256i64:$vy, v256i1:$mask, i32:$avl)), (vdivul_vvvmvl $vx, $vy, $mask, (v256i64 (IMPLICIT_DEF)), $avl)>;

// 256 x i32
def : Pat<(v256i32 (vp_add v256i32:$vx, v256i32:$vy, v256i1:$mask, i32:$avl)),  (vadduw_vvvmvl   $vx, $vy, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i32 (vp_sub v256i32:$vx, v256i32:$vy, v256i1:$mask, i32:$avl)),  (vsubuw_vvvmvl   $vx, $vy, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i32 (vp_mul v256i32:$vx, v256i32:$vy, v256i1:$mask, i32:$avl)),  (vmuluw_vvvmvl   $vx, $vy, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i32 (vp_sdiv v256i32:$vx, v256i32:$vy, v256i1:$mask, i32:$avl)), (vdivswsx_vvvmvl $vx, $vy, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i32 (vp_udiv v256i32:$vx, v256i32:$vy, v256i1:$mask, i32:$avl)), (vdivuw_vvvmvl   $vx, $vy, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;

// Logic ops

// 256 x i64
def : Pat<(v256i64 (vp_and v256i64:$vx, v256i64:$vy, v256i1:$mask, i32:$avl)), (vand_vvvmvl $vx, $vy, $mask, (v256i64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i64 (vp_or  v256i64:$vx, v256i64:$vy, v256i1:$mask, i32:$avl)), (vor_vvvmvl  $vx, $vy, $mask, (v256i64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i64 (vp_xor v256i64:$vx, v256i64:$vy, v256i1:$mask, i32:$avl)), (vxor_vvvmvl $vx, $vy, $mask, (v256i64 (IMPLICIT_DEF)), $avl)>;

// 256 x i32
def : Pat<(v256i32 (vp_and v256i32:$vx, v256i32:$vy, v256i1:$mask, i32:$avl)), (vand_vvvmvl $vx, $vy, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i32 (vp_or  v256i32:$vx, v256i32:$vy, v256i1:$mask, i32:$avl)), (vor_vvvmvl  $vx, $vy, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i32 (vp_xor v256i32:$vx, v256i32:$vy, v256i1:$mask, i32:$avl)), (vxor_vvvmvl $vx, $vy, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;

// Mask Arith

def : Pat<(v256i1 (vp_and v256i1:$ma, v256i1:$mb, (v256i1 true_mask), (i32 no_avl_256))), (andm_mmm $ma, $mb)>;
def : Pat<(v256i1 (vp_or  v256i1:$ma, v256i1:$mb, (v256i1 true_mask), (i32 no_avl_256))), (orm_mmm $ma, $mb)>;
def : Pat<(v256i1 (vp_xor v256i1:$ma, v256i1:$mb, (v256i1 true_mask), (i32 no_avl_256))), (xorm_mmm $ma, $mb)>;

// TODO multiclass
def : Pat<(v256i1 (and v256i1:$ma, v256i1:$mb)), (andm_mmm $ma, $mb)>;
def : Pat<(v256i1 (or  v256i1:$ma, v256i1:$mb)), (orm_mmm $ma, $mb)>;
def : Pat<(v256i1 (xor v256i1:$ma, v256i1:$mb)), (xorm_mmm $ma, $mb)>;

// Shifts

def : Pat<(v256i64 (vp_srl v256i64:$val, v256i64:$n, v256i1:$mask, i32:$avl)), (vsrl_vvvmvl $n, $val, $mask, (v256i64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i64 (vp_sra v256i64:$val, v256i64:$n, v256i1:$mask, i32:$avl)), (vsral_vvvmvl  $n, $val, $mask, (v256i64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i64 (vp_shl v256i64:$val, v256i64:$n, v256i1:$mask, i32:$avl)), (vsll_vvvmvl  $n, $val, $mask, (v256i64 (IMPLICIT_DEF)), $avl)>;

def : Pat<(v256i32 (vp_srl v256i32:$val, v256i32:$n, v256i1:$mask, i32:$avl)), (vsrl_vvvmvl $n, $val, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i32 (vp_sra v256i32:$val, v256i32:$n, v256i1:$mask, i32:$avl)), (vsral_vvvmvl  $n, $val, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i32 (vp_shl v256i32:$val, v256i32:$n, v256i1:$mask, i32:$avl)), (vslaw_vvvmvl $n, $val, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;

// Comparison & Selection
def : Pat<(v256f64 (vp_select v256i1:$mask, v256f64:$ontrue, v256f64:$onfalse, i32:$avl)),
          (vmrg_vvvml $onfalse, $ontrue, $mask, $avl)>;
def : Pat<(v256i64 (vp_select v256i1:$mask, v256i64:$ontrue, v256i64:$onfalse, i32:$avl)),
          (vmrg_vvvml $onfalse, $ontrue, $mask, $avl)>;

// TODO auto-generate
def : Pat<(v256i1 (setcc v256i32:$A, v256i32:$B, cond:$cond)),
          (vfmkw_mvIl (vcmpuw_vvvvl $A, $B, (v256i32 (IMPLICIT_DEF)), (lea_imm32 256)), (icond2cc $cond), (lea_imm32 256))>;
def : Pat<(v256i1 (setcc v256i64:$A, v256i64:$B, cond:$cond)),
          (vfmkl_mvIl (vcmpul_vvvvl $A, $B, (v256i64 (IMPLICIT_DEF)), (lea_imm32 256)), (icond2cc $cond), (lea_imm32 256))>;

def : Pat<(v256i1 (vp_setcc v256i32:$A, v256i32:$B, cond:$cond, v256i1:$mask, i32:$avl)),
          (vfmkw_mvIml (vcmpuw_vvvmvl $A, $B, $mask, (v256i32 (IMPLICIT_DEF)), $avl), (icond2cc $cond), $mask, $avl)>;
def : Pat<(v256i1 (vp_setcc v256i64:$A, v256i64:$B, cond:$cond, v256i1:$mask, i32:$avl)),
          (vfmkl_mvIml (vcmpul_vvvmvl $A, $B, $mask, (v256i64 (IMPLICIT_DEF)), $avl), (icond2cc $cond), $mask, $avl)>;


// Reductions

def : Pat<(v256f64 (vec_vmv v256f64:$v, i32:$amount, v256i1:$mask, i32:$avl)),
          (vmv_vsvmvl $amount, $v, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f32 (vec_vmv v256f32:$v, i32:$amount, v256i1:$mask, i32:$avl)),
          (vmv_vsvmvl $amount, $v, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256i32 (vec_vmv v256i32:$v, i32:$amount, v256i1:$mask, i32:$avl)),
          (vmv_vsvmvl $amount, $v, $mask, (v256i32 (IMPLICIT_DEF)), $avl)>;

def : Pat<(i64 (vec_popcount v256i1:$mask, i32:$avl)),
          (pcvm_sml $mask, $avl)>;

// v256 x i64
def : Pat<(i64 (vp_reduce_add v256i64:$val, v256i1:$mask, i32:$avl)), (lvsl_svs (vsuml_vvml $val, $mask, $avl), 0)>;
def : Pat<(i64 (vp_reduce_and v256i64:$val, v256i1:$mask, i32:$avl)), (lvsl_svs (vrand_vvml $val, $mask, $avl), 0)>;
def : Pat<(i64 (vp_reduce_or  v256i64:$val, v256i1:$mask, i32:$avl)), (lvsl_svs (vror_vvml $val, $mask, $avl), 0)>;
def : Pat<(i64 (vp_reduce_xor v256i64:$val, v256i1:$mask, i32:$avl)), (lvsl_svs (vrxor_vvml $val, $mask, $avl), 0)>;

// v256 x f64
def : Pat<(f64 (vp_reduce_fadd f64:$start, v256f64:$val, v256i1:$mask, i32:$avl)), (FADrr $start, (lvsl_svs (vfsumd_vvml $val, $mask, $avl), 0))>; // TODO only acceptable if may reassociate
// def : Pat<(f64 (vp_reduce_fmin v256f64:$val, v256i1:$mask, i32:$avl)), (lvsl_svs (vfsumd_vvml $val, $mask, $avl), 0)>; // TODO masked vfrmax instruction missing
// def : Pat<(f64 (vp_reduce_fmax v256f64:$val, v256i1:$mask, i32:$avl)), (lvsl_svs (vfmaxd_vvml $val, $mask, $avl), 0)>; // TODO masked vfrmin instruction missing




// V(E) - VP internal nodes // experimenting
def SDTFPBinOpVVP : SDTypeProfile<1, 4, [   // vp_fadd, etc.
  SDTCisSameAs<0, 1>, SDTCisSameAs<0, 2>, SDTCisFP<0>, SDTCisInt<3>, SDTCisSameNumEltsAs<0, 3>, SDTCisInt<4>
]>;

def SDTLoadVVP : SDTypeProfile<1, 3, [       // vp load
  SDTCisVec<0>, SDTCisPtrTy<1>, SDTCisSameNumEltsAs<0, 2>, SDTCisInt<3> 
]>;

def vvp_load    : SDNode<"VEISD::VVP_LOAD", SDTLoadVVP, [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;
def vvp_fadd    : SDNode<"VEISD::VVP_FADD", SDTFPBinOpVVP>;

// 256 x f64
// TODO pattern w/o mask
def : Pat<(v256f64 (vvp_load i64:$addr, v256i1:$mask, i32:$avl)),
                   (vgt_vvssml
                     (vaddul_vsvmvl $addr, (vmulul_vIvmvl 8, (vseq_vl $avl), $mask, (IMPLICIT_DEF), $avl), $mask, (IMPLICIT_DEF), $avl),
                     0, 0,
                     $mask,
                     $avl
                   )>;

// TODO pattern w/o mask
def : Pat<(v256f64 (vvp_fadd v256f64:$vx, v256f64:$vy, v256i1:$mask, i32:$avl)), (vfaddd_vvvmvl $vx, $vy, $mask, (v256f64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f64 (vvp_fadd v256f64:$vx, v256f64:$vy, v256i1:$mask, i32:$avl)), (vfaddd_vvvmvl $vx, $vy, $mask, (v256f64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f32 (vvp_fadd v256f32:$vx, v256f32:$vy, v256i1:$mask, i32:$avl)), (vfadds_vvvmvl $vx, $vy, $mask, (v256f32 (IMPLICIT_DEF)), $avl)>;
