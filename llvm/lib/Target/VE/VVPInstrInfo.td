///// V(E) - VP internal nodes
// fp node types
def SDTFPBinOpVVP : SDTypeProfile<1, 4, [   // vvp_fadd, etc.
  SDTCisSameAs<0, 1>, SDTCisSameAs<0, 2>, SDTCisFP<0>, SDTCisInt<3>, SDTCisSameNumEltsAs<0, 3>, SDTCisInt<4>
]>;

def SDTFPTernaryOpVVP : SDTypeProfile<1, 5, [  // vvp_ffma
  SDTCisSameAs<0, 1>, SDTCisSameAs<0, 2>, SDTCisSameAs<0, 3>, SDTCisFP<0>, SDTCisInt<4>, SDTCisSameNumEltsAs<0, 4>, SDTCisInt<5>
]>;

// int node types
def SDTIntBinOpVVP : SDTypeProfile<1, 4, [     // vp_add, vp_and, etc.
  SDTCisSameAs<0, 1>, SDTCisSameAs<0, 2>, SDTCisInt<0>, SDTCisInt<4>, SDTCisSameNumEltsAs<0, 3>
]>;

def SDTIntShiftOpVVP : SDTypeProfile<1, 4, [   // shl, sra, srl
  SDTCisSameAs<0, 1>, SDTCisInt<0>, SDTCisInt<2>, SDTCisInt<4>, SDTCisSameNumEltsAs<0, 3>
]>;

// load store
def SDTLoadVVP : SDTypeProfile<1, 3, [       // vvp load
  SDTCisVec<0>, SDTCisPtrTy<1>, SDTCisSameNumEltsAs<0, 2>, SDTCisInt<3> 
]>;

def SDTStoreVVP: SDTypeProfile<0, 4, [       // vvp store
  SDTCisVec<0>, SDTCisPtrTy<1>, SDTCisVec<2>, SDTCisSameNumEltsAs<0, 2>, SDTCisInt<3>
]>;

// load store
def vvp_load    : SDNode<"VEISD::VVP_LOAD",  SDTLoadVVP, [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;
def vvp_store   : SDNode<"VEISD::VVP_STORE", SDTStoreVVP, [SDNPHasChain, SDNPMayStore, SDNPMemOperand]>;

// int
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
def vvp_ffma    : SDNode<"VEISD::VVP_FFMA",  SDTFPTernaryOpVVP>; // x + (y*z)

class vvp_commutative<SDNode RootOp> :
  PatFrags<(ops node:$lhs, node:$rhs, node:$mask, node:$vlen),
                       [(RootOp node:$lhs, node:$rhs, node:$mask, node:$vlen),
                        (RootOp node:$rhs, node:$lhs, node:$mask, node:$vlen)]>;

class vvp_fma_commutative<SDNode RootOp> :
  PatFrags<(ops node:$X, node:$Y, node:$Z, node:$mask, node:$vlen),
                       [(RootOp node:$X, node:$Y, node:$Z, node:$mask, node:$vlen),
                        (RootOp node:$X, node:$Z, node:$Y, node:$mask, node:$vlen)]>;


// commutative match
def c_vv_fadd     : vvp_commutative<vvp_fadd>;
def c_vv_fmul     : vvp_commutative<vvp_fmul>;
def c_vv_add     : vvp_commutative<vvp_add>;
def c_vv_mul     : vvp_commutative<vvp_mul>;

def c_vv_ffma     : vvp_fma_commutative<vvp_ffma>;
