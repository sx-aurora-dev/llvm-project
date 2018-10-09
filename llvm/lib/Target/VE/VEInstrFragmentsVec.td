//===-- VEInstrFragmentsVec.td - VE Vector ISA -------------*- tablegen -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file provides pattern fragments useful for VE Vector instructions.
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Load instructions
//===----------------------------------------------------------------------===//

// (vNi1 (LVM (vNi1 vx), (i64 index), (i64 val)))

def VELoadMask :
    SDTypeProfile<1, 3, [SDTCisVec<0>, SDTCVecEltisVT<0, i1>,
                         SDTCisSameAs<1, 0>, SDTCisInt<2>,
                         SDTCisVT<3, i64>]>;
def VElvm : SDNode<"VEISD::INT_LVM", VELoadMask>;

//===----------------------------------------------------------------------===//
// Store instructions
//===----------------------------------------------------------------------===//

// (i64 (SVM (vNi1 vx), (i64 index)))

def VEStoreMask :
    SDTypeProfile<1, 2, [SDTCisVT<0, i64>,
                         SDTCisVec<1>, SDTCVecEltisVT<1, i1>,
                         SDTCisInt<2>]>;
def VEsvm : SDNode<"VEISD::INT_SVM", VEStoreMask>;

//===----------------------------------------------------------------------===//
// 2-op logical instructions
//===----------------------------------------------------------------------===//

// (vNi1 (ANDM (vNi1 vy), (vNi1 vz)))

def VE2OpMMM :
    SDTypeProfile<1, 2, [SDTCisVec<0>, SDTCVecEltisVT<0, i1>,
                         SDTCisSameAs<1, 0>, SDTCisSameAs<2, 0>]>;
def VEandm : SDNode<"VEISD::INT_ANDM", VE2OpMMM>;
def VEorm  : SDNode<"VEISD::INT_ORM", VE2OpMMM>;
def VExorm : SDNode<"VEISD::INT_XORM", VE2OpMMM>;
def VEeqvm : SDNode<"VEISD::INT_EQVM", VE2OpMMM>;
def VEnndm : SDNode<"VEISD::INT_NNDM", VE2OpMMM>;

//===----------------------------------------------------------------------===//
// 1-op logical instructions
//===----------------------------------------------------------------------===//

// (vNi1 (NEGM (vNi1 vy)))

def VE1OpMM :
    SDTypeProfile<1, 1, [SDTCisVec<0>, SDTCVecEltisVT<0, i1>,
                         SDTCisSameAs<1, 0>]>;
def VEnegm : SDNode<"VEISD::INT_NEGM", VE1OpMM>;

//===----------------------------------------------------------------------===//
// 1-op instructions
//===----------------------------------------------------------------------===//

// (i64 (PCVM (vNi1 vy)))

def VE1OpSM :
    SDTypeProfile<1, 1, [SDTCisInt<0>, SDTCisVec<1>, SDTCVecEltisVT<1, i1>]>;
def VEpcvm : SDNode<"VEISD::INT_PCVM", VE1OpSM>;
def VElzvm : SDNode<"VEISD::INT_LZVM", VE1OpSM>;
def VEtovm : SDNode<"VEISD::INT_TOVM", VE1OpSM>;

//===----------------------------------------------------------------------===//
// 2-op vector with mask and base register instructions
//===----------------------------------------------------------------------===//

// Either of 
// (v256f64 (VADDlvm (v256f64 vy), (v256f64 vz), (v256i1 vm), (v256f64 base)))
// (v256f64 (VADDlvm (i64 sy), (v256f64 vz), (v256i1 vm), (v256f64 base)))

def VE2OpVXVMV :
    SDTypeProfile<1, 4, [SDTCisVec<0>, 
                         SDTCisSameAs<2, 0>,
                         SDTCisVec<3>, SDTCVecEltisVT<3, i1>,
                         SDTCisSameAs<4, 0>]>;
def VEvaddul : SDNode<"VEISD::INT_VADDUL", VE2OpVXVMV>;
def VEvsubul : SDNode<"VEISD::INT_VSUBUL", VE2OpVXVMV>;
def VEvcmpul : SDNode<"VEISD::INT_VCMPUL", VE2OpVXVMV>;
def VEvadduw : SDNode<"VEISD::INT_VADDUW", VE2OpVXVMV>;
def VEvsubuw : SDNode<"VEISD::INT_VSUBUW", VE2OpVXVMV>;
def VEvcmpuw : SDNode<"VEISD::INT_VCMPUW", VE2OpVXVMV>;
def VEvaddswsx : SDNode<"VEISD::INT_VADDSWSX", VE2OpVXVMV>;
def VEvsubswsx : SDNode<"VEISD::INT_VSUBSWSX", VE2OpVXVMV>;
def VEvcmpswsx : SDNode<"VEISD::INT_VCMPSWSX", VE2OpVXVMV>;
def VEvaddswzx : SDNode<"VEISD::INT_VADDSWZX", VE2OpVXVMV>;
def VEvsubswzx : SDNode<"VEISD::INT_VSUBSWZX", VE2OpVXVMV>;
def VEvcmpswzx : SDNode<"VEISD::INT_VCMPSWZX", VE2OpVXVMV>;
def VEvaddsl : SDNode<"VEISD::INT_VADDSL", VE2OpVXVMV>;
def VEvsubsl : SDNode<"VEISD::INT_VSUBSL", VE2OpVXVMV>;
def VEvcmpsl : SDNode<"VEISD::INT_VCMPSL", VE2OpVXVMV>;
def VEpvaddu : SDNode<"VEISD::INT_PVADDU", VE2OpVXVMV>;
def VEpvsubu : SDNode<"VEISD::INT_PVSUBU", VE2OpVXVMV>;
def VEpvcmpu : SDNode<"VEISD::INT_PVCMPU", VE2OpVXVMV>;
def VEpvadds : SDNode<"VEISD::INT_PVADDS", VE2OpVXVMV>;
def VEpvsubs : SDNode<"VEISD::INT_PVSUBS", VE2OpVXVMV>;
def VEpvcmps : SDNode<"VEISD::INT_PVCMPS", VE2OpVXVMV>;
def VEvmaxswsx : SDNode<"VEISD::INT_VMAXSWSX", VE2OpVXVMV>;
def VEvminswsx : SDNode<"VEISD::INT_VMINSWSX", VE2OpVXVMV>;
def VEvmaxswzx : SDNode<"VEISD::INT_VMAXSWZX", VE2OpVXVMV>;
def VEvminswzx : SDNode<"VEISD::INT_VMINSWZX", VE2OpVXVMV>;
def VEpvmaxs : SDNode<"VEISD::INT_PVMAXS", VE2OpVXVMV>;
def VEpvmins : SDNode<"VEISD::INT_PVMINS", VE2OpVXVMV>;

