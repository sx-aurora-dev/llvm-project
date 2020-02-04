///// V(E) - VP internal nodes
def SDTFPBinOpVVP : SDTypeProfile<1, 4, [   // vvp_fadd, etc.
  SDTCisSameAs<0, 1>, SDTCisSameAs<0, 2>, SDTCisFP<0>, SDTCisInt<3>, SDTCisSameNumEltsAs<0, 3>, SDTCisInt<4>
]>;

def SDTFPTernaryOpVVP : SDTypeProfile<1, 5, [  // vvp_ffma
  SDTCisSameAs<0, 1>, SDTCisSameAs<0, 2>, SDTCisSameAs<0, 3>, SDTCisFP<0>, SDTCisInt<4>, SDTCisSameNumEltsAs<0, 4>, SDTCisInt<5>
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
def vvp_fsub    : SDNode<"VEISD::VVP_FSUB",  SDTFPBinOpVVP>;
def vvp_fmul    : SDNode<"VEISD::VVP_FMUL",  SDTFPBinOpVVP>;
def vvp_fdiv    : SDNode<"VEISD::VVP_FDIV",  SDTFPBinOpVVP>;
def vvp_ffma    : SDNode<"VEISD::VVP_FFMA",  SDTFPTernaryOpVVP>;
