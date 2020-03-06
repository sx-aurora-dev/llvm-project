// def : Pat<(int_ve_vstot_vss v256f64:$vx, i64:$sy, i64:$sz), (VSTotrr v256f64:$vx, i64:$sy, i64:$sz, (GetVL (i32 0)))>;

// Arithmetic ops

// 256 x f64
def : Pat<(v256f64 (vp_fminnum v256f64:$vx, v256f64:$vy, v256i1:$mask, i32:$avl)), (vfmaxd_vvvmvl $vx, $vy, $mask, (v256f64 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f64 (vp_fmaxnum v256f64:$vx, v256f64:$vy, v256i1:$mask, i32:$avl)), (vfmind_vvvmvl $vx, $vy, $mask, (v256f64 (IMPLICIT_DEF)), $avl)>;

// 256 x f32
def : Pat<(v256f32 (vp_fminnum v256f32:$vx, v256f32:$vy, v256i1:$mask, i32:$avl)), (vfmaxs_vvvmvl $vx, $vy, $mask, (v256f32 (IMPLICIT_DEF)), $avl)>;
def : Pat<(v256f32 (vp_fmaxnum v256f32:$vx, v256f32:$vy, v256i1:$mask, i32:$avl)), (vfmins_vvvmvl $vx, $vy, $mask, (v256f32 (IMPLICIT_DEF)), $avl)>;

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
// def : Pat<(v256i1 (setcc v256i32:$A, v256i32:$B, cond:$cond)),
//           (vfmkw_mvIl (vcmpuw_vvvvl $A, $B, (v256i32 (IMPLICIT_DEF)), (lea_imm32 256)), (icond2cc $cond), (lea_imm32 256))>;
// def : Pat<(v256i1 (setcc v256i64:$A, v256i64:$B, cond:$cond)),
//           (vfmkl_mvIl (vcmpul_vvvvl $A, $B, (v256i64 (IMPLICIT_DEF)), (lea_imm32 256)), (icond2cc $cond), (lea_imm32 256))>;

// def : Pat<(v256i1 (vp_setcc v256i32:$A, v256i32:$B, cond:$cond, v256i1:$mask, i32:$avl)),
//           (vfmkw_mvIml (vcmpuw_vvvmvl $A, $B, $mask, (v256i32 (IMPLICIT_DEF)), $avl), (icond2cc $cond), $mask, $avl)>;
// def : Pat<(v256i1 (vp_setcc v256i64:$A, v256i64:$B, cond:$cond, v256i1:$mask, i32:$avl)),
//           (vfmkl_mvIml (vcmpul_vvvmvl $A, $B, $mask, (v256i64 (IMPLICIT_DEF)), $avl), (icond2cc $cond), $mask, $avl)>;



// v256 x i64
def : Pat<(i64 (vp_reduce_add v256i64:$val, v256i1:$mask, i32:$avl)), (lvsl_svs (vsuml_vvml $val, $mask, $avl), 0)>;
def : Pat<(i64 (vp_reduce_and v256i64:$val, v256i1:$mask, i32:$avl)), (lvsl_svs (vrand_vvml $val, $mask, $avl), 0)>;
def : Pat<(i64 (vp_reduce_or  v256i64:$val, v256i1:$mask, i32:$avl)), (lvsl_svs (vror_vvml $val, $mask, $avl), 0)>;
def : Pat<(i64 (vp_reduce_xor v256i64:$val, v256i1:$mask, i32:$avl)), (lvsl_svs (vrxor_vvml $val, $mask, $avl), 0)>;

// v256 x f64
def : Pat<(f64 (vp_reduce_fadd f64:$start, v256f64:$val, v256i1:$mask, i32:$avl)), (FADrr $start, (lvsl_svs (vfsumd_vvml $val, $mask, $avl), 0))>; // TODO only acceptable if may reassociate
// def : Pat<(f64 (vp_reduce_fmin v256f64:$val, v256i1:$mask, i32:$avl)), (lvsl_svs (vfsumd_vvml $val, $mask, $avl), 0)>; // TODO masked vfrmax instruction missing
// def : Pat<(f64 (vp_reduce_fmax v256f64:$val, v256i1:$mask, i32:$avl)), (lvsl_svs (vfmaxd_vvml $val, $mask, $avl), 0)>; // TODO masked vfrmin instruction missing
