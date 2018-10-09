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
