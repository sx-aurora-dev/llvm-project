///// V(E) - VP internal nodes // experimenting
def SDTFPBinOpVVP : SDTypeProfile<1, 4, [   // vp_fadd, etc.
  SDTCisSameAs<0, 1>, SDTCisSameAs<0, 2>, SDTCisFP<0>, SDTCisInt<3>, SDTCisSameNumEltsAs<0, 3>, SDTCisInt<4>
]>;

def SDTLoadVVP : SDTypeProfile<1, 3, [       // vvp load
  SDTCisVec<0>, SDTCisPtrTy<1>, SDTCisSameNumEltsAs<0, 2>, SDTCisInt<3> 
]>;

def SDTStoreVVP: SDTypeProfile<0, 4, [       // vvp store
  SDTCisVec<0>, SDTCisPtrTy<1>, SDTCisVec<2>, SDTCisSameNumEltsAs<0, 2>, SDTCisInt<3>
]>;

def vvp_load    : SDNode<"VEISD::VVP_LOAD",  SDTLoadVVP, [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;
def vvp_store   : SDNode<"VEISD::VVP_STORE", SDTStoreVVP, [SDNPHasChain, SDNPMayStore, SDNPMemOperand]>;
def vvp_fadd    : SDNode<"VEISD::VVP_FADD",  SDTFPBinOpVVP>;


// Vector Load and Store
multiclass VectorLoad<ValueType DataVT, ValueType PtrVt, ValueType MaskVT, int immStride, SDNode GTWithMask, SDNode LDNoMask> {
  // w/o mask
  def : Pat<(DataVT (vvp_load PtrVt:$addr, (MaskVT true_mask), i32:$avl)),
                    (LDNoMask immStride, $addr, $avl)>;
  // with mask
  def : Pat<(DataVT (vvp_load PtrVt:$addr, MaskVT:$mask, i32:$avl)),
            (GTWithMask
              (vaddul_vsvmvl $addr, (vmulul_vIvmvl immStride, (vseq_vl $avl), $mask, (IMPLICIT_DEF), $avl), $mask, (IMPLICIT_DEF), $avl),
              0, 0,
              $mask,
              $avl)>;
}

// Load patterns
defm : VectorLoad<v256f64, i64, v256i1, 8, vgt_vvssml, vld_vIsl>;
defm : VectorLoad<v256i64, i64, v256i1, 8, vgt_vvssml, vld_vIsl>;
defm : VectorLoad<v256f32, i64, v256i1, 4, vgtu_vvssml, vldu_vIsl>;
defm : VectorLoad<v256i32, i64, v256i1, 4, vgtlzx_vvssml, vldlzx_vIsl>;

multiclass VectorStore<ValueType DataVT, ValueType PtrVt, ValueType MaskVT, int immStride, SDNode STWithMask, SDNode STNoMask> {
  // w/o mask
  def : Pat<(vvp_store DataVT:$val, PtrVt:$addr, (MaskVT true_mask), i32:$avl),
            (STNoMask $val, immStride, $addr, $avl)>;
  // with mask
  def : Pat<(vvp_store DataVT:$val, PtrVt:$addr, MaskVT:$mask, i32:$avl),
            (STWithMask $val, immStride, $addr, $mask, $avl)>;
}

defm : VectorStore<v256f64, i64, v256i1, 8, vst_vIsml, vst_vIsl>;
defm : VectorStore<v256i64, i64, v256i1, 8, vst_vIsml, vst_vIsl>;
defm : VectorStore<v256f32, i64, v256i1, 4, vstu_vIsml, vstu_vIsl>; 
defm : VectorStore<v256i32, i64, v256i1, 4, vstl_vIsml, vstl_vIsl>; 

// Floating-point arithmetic

multiclass VectorBinaryArith<SDPatternOperator OpNode, ValueType DataVT, ValueType ScalarVT, ValueType MaskVT, SDNode OpWithMask, SDNode OpNoMask> {
  // w/o mask
  def : Pat<(OpNode DataVT:$vx, DataVT:$vy, (MaskVT true_mask), i32:$avl),
            (OpNoMask $vx, $vy, $avl)>;
  // with mask
  def : Pat<(OpNode DataVT:$vx, DataVT:$vy, MaskVT:$mask, i32:$avl),
            (OpWithMask $vx, $vy, $mask, (v256f64 (IMPLICIT_DEF)), $avl)>;
}

// TODO fold select into operation
defm : VectorBinaryArith<vvp_fadd, v256f64, f64, v256i1, vfaddd_vvvmvl, vfaddd_vvvl>;
defm : VectorBinaryArith<vvp_fadd, v256f32, f32, v256i1, vfadds_vvvmvl, vfadds_vvvl>;

// def : Pat<(v256f64 (vvp_fadd v256f64:$vx, v256f64:$vy, v256i1:$mask, i32:$avl)), (vfaddd_vvvmvl $vx, $vy, $mask, (v256f64 (IMPLICIT_DEF)), $avl)>;
// def : Pat<(v256f32 (vvp_fadd v256f32:$vx, v256f32:$vy, v256i1:$mask, i32:$avl)), (vfadds_vvvmvl $vx, $vy, $mask, (v256f32 (IMPLICIT_DEF)), $avl)>;
