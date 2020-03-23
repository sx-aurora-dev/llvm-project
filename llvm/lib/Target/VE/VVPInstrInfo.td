///// V(E) - VP internal nodes
// fp node types

def SDTFPBinOpVVP : SDTypeProfile<1, 4, [   // vvp_fadd, etc.
  SDTCisSameAs<0, 1>, SDTCisSameAs<0, 2>, SDTCisFP<0>, SDTCisInt<3>, SDTCisSameNumEltsAs<0, 3>, IsVLVT<4>
]>;

def SDTFPTernaryOpVVP : SDTypeProfile<1, 5, [  // vvp_ffma
  SDTCisSameAs<0, 1>, SDTCisSameAs<0, 2>, SDTCisSameAs<0, 3>, SDTCisFP<0>, SDTCisInt<4>, SDTCisSameNumEltsAs<0, 4>, IsVLVT<5>
]>;

// int node types
def SDTIntBinOpVVP : SDTypeProfile<1, 4, [     // vp_add, vp_and, etc.
  SDTCisSameAs<0, 1>, SDTCisSameAs<0, 2>, SDTCisInt<0>, SDTCisSameNumEltsAs<0, 3>, IsVLVT<4>
]>;

def SDTIntShiftOpVVP : SDTypeProfile<1, 4, [   // shl, sra, srl
  SDTCisSameAs<0, 1>, SDTCisInt<0>, SDTCisInt<2>, SDTCisSameNumEltsAs<0, 3>, IsVLVT<4>
]>;

// load store
def SDTLoadVVP : SDTypeProfile<1, 3, [       // vvp load
  SDTCisVec<0>, SDTCisPtrTy<1>, SDTCisSameNumEltsAs<0, 2>, IsVLVT<3>
]>;

def SDTStoreVVP: SDTypeProfile<0, 4, [       // vvp store
  SDTCisVec<0>, SDTCisPtrTy<1>, SDTCisVec<2>, SDTCisSameNumEltsAs<0, 2>, IsVLVT<3>
]>;

// scatter (Value, PtrVec, Mask, Vlen)
def SDTScatterVVP: SDTypeProfile<0, 4, [     // vvp scatter
  SDTCisVec<0>, SDTCisVec<1>, SDTCisVec<2>, SDTCisSameNumEltsAs<0, 2>, IsVLVT<3>
]>;

// gather (PtrVec, Mask, Vlen)
def SDTGatherVVP: SDTypeProfile<1, 3, [     // vvp gather
  SDTCisVec<0>, SDTCisVec<1>, SDTCisSameNumEltsAs<0, 2>, IsVLVT<3> 
]>;

// select (SelMask, OnTrue, OnFalse, OpMask, VL)
def SDTSelectVVP : SDTypeProfile<1, 4, [       // vp_select
  SDTCisVec<0>, SDTCisSameNumEltsAs<0, 1>, SDTCisSameAs<0, 2>, SDTCisSameAs<2, 3>, IsVLVT<4>
]>;

// setcc (lhs, rhs, cc, mask, vl)
def SDTSetCCVVP : SDTypeProfile<1, 5, [        // vp_setcc
  SDTCisVec<0>, SDTCisVec<1>, SDTCisSameNumEltsAs<0, 1>, SDTCisSameAs<1, 2>, SDTCisVT<3, OtherVT>, SDTCisInt<4>, SDTCisSameNumEltsAs<0, 4>, IsVLVT<5>
]>;

// s/uint_to_fp
def SDTIntToFPOpVVP : SDTypeProfile<1, 3, [    // [su]int_to_fp
  SDTCisFP<0>, SDTCisInt<1>, SDTCisSameNumEltsAs<0, 1>, SDTCisSameNumEltsAs<0, 2>, IsVLVT<3>
]>;
def SDTFPToIntOpVVP : SDTypeProfile<1, 3, [    // fp_to_[su]int
  SDTCisInt<0>, SDTCisFP<1>, SDTCisSameNumEltsAs<0, 1>, SDTCisSameNumEltsAs<0, 2>, IsVLVT<3>
]>;

// fpext, fpround
def SDTFPRoundOpVVP  : SDTypeProfile<1, 3, [   // fround
  SDTCisFP<0>, SDTCisFP<1>, SDTCisOpSmallerThanOp<0, 1>, SDTCisSameNumEltsAs<0, 1>, SDTCisSameNumEltsAs<0, 2>, IsVLVT<3>
]>;
def SDTFPExtOpVVP  : SDTypeProfile<1, 3, [  // fextend
  SDTCisFP<0>, SDTCisFP<1>, SDTCisOpSmallerThanOp<1, 0>, SDTCisSameNumEltsAs<0, 1>, SDTCisSameNumEltsAs<0, 2>, IsVLVT<3>
]>;

// gather scatter
def vvp_scatter : SDNode<"VEISD::VVP_SCATTER",  SDTScatterVVP,
                        [SDNPHasChain, SDNPMayStore, SDNPMemOperand]>;
def vvp_gather  : SDNode<"VEISD::VVP_GATHER",  SDTGatherVVP,
                        [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;

// sext, zext
def SDTIntExtendOpVVP : SDTypeProfile<1, 3, [  // sext, zext, anyext
  SDTCisInt<0>, SDTCisInt<1>, SDTCisOpSmallerThanOp<1, 0>, SDTCisSameNumEltsAs<0, 1>, SDTCisSameNumEltsAs<0,2>, IsVLVT<3>
]>;

// reductions
def SDTReduceStartVVP : SDTypeProfile<1, 4, [    // vvp_reduce (with start arg)
  SDTCisVec<2>, SDTCisInt<3>, SDTCisVec<3>, SDTCisSameNumEltsAs<2,3>, IsVLVT<4>
]>;
def SDTReduceVVP : SDTypeProfile<1, 3, [    // vp_reduce (w/o start arg)
  SDTCisVec<1>, SDTCisInt<2>, SDTCisVec<2>, SDTCisSameNumEltsAs<1,2>, IsVLVT<3>
]>;



// load store
def vvp_load    : SDNode<"VEISD::VVP_LOAD",  SDTLoadVVP, [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;
def vvp_store   : SDNode<"VEISD::VVP_STORE", SDTStoreVVP, [SDNPHasChain, SDNPMayStore, SDNPMemOperand]>;

// int
def vvp_and    : SDNode<"VEISD::VVP_AND",  SDTIntBinOpVVP>;
def vvp_or     : SDNode<"VEISD::VVP_OR",  SDTIntBinOpVVP>;
def vvp_xor    : SDNode<"VEISD::VVP_XOR",  SDTIntBinOpVVP>;

def vvp_add    : SDNode<"VEISD::VVP_ADD",  SDTIntBinOpVVP>;
def vvp_sub    : SDNode<"VEISD::VVP_SUB",  SDTIntBinOpVVP>;
def vvp_mul    : SDNode<"VEISD::VVP_MUL",  SDTIntBinOpVVP>;
def vvp_sdiv   : SDNode<"VEISD::VVP_SDIV",  SDTIntBinOpVVP>;
def vvp_udiv   : SDNode<"VEISD::VVP_UDIV",  SDTIntBinOpVVP>;

def vvp_srl    : SDNode<"VEISD::VVP_SRL",  SDTIntShiftOpVVP>;
def vvp_sra    : SDNode<"VEISD::VVP_SRA",  SDTIntShiftOpVVP>;
def vvp_shl    : SDNode<"VEISD::VVP_SHL",  SDTIntShiftOpVVP>;

// fp
def vvp_fadd    : SDNode<"VEISD::VVP_FADD",  SDTFPBinOpVVP>;     // x + y
def vvp_fsub    : SDNode<"VEISD::VVP_FSUB",  SDTFPBinOpVVP>;     // x - y
def vvp_fmul    : SDNode<"VEISD::VVP_FMUL",  SDTFPBinOpVVP>;     // x * y
def vvp_fdiv    : SDNode<"VEISD::VVP_FDIV",  SDTFPBinOpVVP>;     // x / y
def vvp_fminnum    : SDNode<"VEISD::VVP_FMINNUM",  SDTFPBinOpVVP>;     // min(x, y)
def vvp_fmaxnum    : SDNode<"VEISD::VVP_FMAXNUM",  SDTFPBinOpVVP>;     // max(x, y)
def vvp_ffma    : SDNode<"VEISD::VVP_FFMA",  SDTFPTernaryOpVVP>; // x + (y*z)

// select // select(SelM,OnT,OnF,VL) = SelM[lane] ? OnT[lane] : OnF[lane] 
def vvp_select : SDNode<"VEISD::VVP_SELECT", SDTSelectVVP>;      

// setcc (lhs, rhs, cc, mask, vl)
def vvp_setcc  : SDNode<"VEISD::VVP_SETCC", SDTSetCCVVP>;      


// x_to_y
// def vvp_uint_to_fp    : SDNode<"VEISD::VVP_UINT_TO_FP", SDTIntToFPOpVVP>; // not supported on VE
// def vvp_fp_to_uint    : SDNode<"VEISD::VVP_FP_TO_UINT", SDTFPToIntOpVVP>; // not supported on VE
def vvp_sint_to_fp    : SDNode<"VEISD::VVP_SINT_TO_FP", SDTIntToFPOpVVP>;
def vvp_fp_to_sint    : SDNode<"VEISD::VVP_FP_TO_SINT", SDTFPToIntOpVVP>;

// fpext, fpround
def vvp_fpround      : SDNode<"VEISD::VVP_FPROUND", SDTFPRoundOpVVP>;
def vvp_fpext        : SDNode<"VEISD::VVP_FPEXT", SDTFPExtOpVVP>;

// zext, sext
def vvp_sext       : SDNode<"VEISD::VVP_SEXT", SDTIntExtendOpVVP>;
def vvp_zext       : SDNode<"VEISD::VVP_ZEXT", SDTIntExtendOpVVP>;

// reductions
def vvp_reduce_fadd          : SDNode<"VEISD::VVP_REDUCE_FADD", SDTReduceVVP>;
def vvp_reduce_strict_fadd   : SDNode<"VEISD::VVP_REDUCE_STRICT_FADD", SDTReduceStartVVP>;


class vvp_commutative<SDNode RootOp> :
  PatFrags<(ops node:$lhs, node:$rhs, node:$mask, node:$vlen),
                       [(RootOp node:$lhs, node:$rhs, node:$mask, node:$vlen),
                        (RootOp node:$rhs, node:$lhs, node:$mask, node:$vlen)]>;

class vvp_fma_commutative<SDNode RootOp> :
  PatFrags<(ops node:$X, node:$Y, node:$Z, node:$mask, node:$vlen),
                       [(RootOp node:$X, node:$Y, node:$Z, node:$mask, node:$vlen),
                        (RootOp node:$X, node:$Z, node:$Y, node:$mask, node:$vlen)]>;


// commutative match
def c_vv_fadd        : vvp_commutative<vvp_fadd>;
def c_vv_fmul        : vvp_commutative<vvp_fmul>;
def c_vv_add         : vvp_commutative<vvp_add>;
def c_vv_mul         : vvp_commutative<vvp_mul>;
def c_vv_and         : vvp_commutative<vvp_and>;
def c_vv_or          : vvp_commutative<vvp_xor>;
def c_vv_xor         : vvp_commutative<vvp_or>;

def c_vv_fminnum     : vvp_commutative<vvp_fminnum>;
def c_vv_fmaxnum     : vvp_commutative<vvp_fmaxnum>;

def c_vv_ffma     : vvp_fma_commutative<vvp_ffma>;
