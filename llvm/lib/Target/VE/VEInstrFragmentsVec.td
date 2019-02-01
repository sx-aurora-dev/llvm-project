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
// Load Mask instructions
//===----------------------------------------------------------------------===//

// (vNi1 (LVM (vNi1 vx), (i64 index), (i64 val)))

def VELoadMask :
    SDTypeProfile<1, 3, [SDTCisVec<0>, SDTCVecEltisVT<0, i1>,
                         SDTCisSameAs<1, 0>, SDTCisInt<2>,
                         SDTCisVT<3, i64>]>;
def VElvm : SDNode<"VEISD::INT_LVM", VELoadMask>;

//===----------------------------------------------------------------------===//
// Store Mask instructions
//===----------------------------------------------------------------------===//

// (i64 (SVM (vNi1 vx), (i64 index)))

def VEStoreMask :
    SDTypeProfile<1, 2, [SDTCisVT<0, i64>,
                         SDTCisVec<1>, SDTCVecEltisVT<1, i1>,
                         SDTCisInt<2>]>;
def VEsvm : SDNode<"VEISD::INT_SVM", VEStoreMask>;

//===----------------------------------------------------------------------===//
// Vector Load instructions
//===----------------------------------------------------------------------===//

// (v256i64 (VLD (i64 base), (i64 skip), (i64 vl)))

def VEVecLoad :
    SDTypeProfile<1, 3, [SDTCisVec<0>, SDTCisVT<1, i64>, SDTCisVT<2, i64>]>;
//                         SDTCisVT<3, i64>]>;
def VEvld : SDNode<"VEISD::INT_VLD", VEVecLoad,
                   [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;
def VEvldu : SDNode<"VEISD::INT_VLDU", VEVecLoad,
                    [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;
def VEvldlsx : SDNode<"VEISD::INT_VLDLSX", VEVecLoad,
                      [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;
def VEvldlzx : SDNode<"VEISD::INT_VLDLZX", VEVecLoad,
                      [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;
def VEvld2d : SDNode<"VEISD::INT_VLD2D", VEVecLoad,
                     [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;
def VEvldu2d : SDNode<"VEISD::INT_VLDU2D", VEVecLoad,
                      [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;
def VEvldl2dsx : SDNode<"VEISD::INT_VLDL2DSX", VEVecLoad,
                        [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;
def VEvldl2dzx : SDNode<"VEISD::INT_VLDL2DZX", VEVecLoad,
                        [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;

//===----------------------------------------------------------------------===//
// Vector Store instructions
//===----------------------------------------------------------------------===//

// (VST (v256i64 vx), (i64 base), (i64 skip), (i64 vl))

def VEVecStore :
    SDTypeProfile<0, 4, [SDTCisVec<0>, SDTCisVT<1, i64>, SDTCisVT<2, i64>]>;
//                         SDTCisVT<3, i64>]>;
def VEvst : SDNode<"VEISD::INT_VST", VEVecStore,
                   [SDNPHasChain, SDNPMayStore, SDNPMemOperand]>;
def VEvstu : SDNode<"VEISD::INT_VSTU", VEVecStore,
                    [SDNPHasChain, SDNPMayStore, SDNPMemOperand]>;
def VEvstl : SDNode<"VEISD::INT_VSTL", VEVecStore,
                    [SDNPHasChain, SDNPMayStore, SDNPMemOperand]>;
def VEvst2d : SDNode<"VEISD::INT_VST2D", VEVecStore,
                     [SDNPHasChain, SDNPMayStore, SDNPMemOperand]>;
def VEvstu2d : SDNode<"VEISD::INT_VSTU2D", VEVecStore,
                      [SDNPHasChain, SDNPMayStore, SDNPMemOperand]>;
def VEvstl2d : SDNode<"VEISD::INT_VSTL2D", VEVecStore,
                      [SDNPHasChain, SDNPMayStore, SDNPMemOperand]>;

//===----------------------------------------------------------------------===//
// Load VL
//===----------------------------------------------------------------------===//

// (LVL (i32 val))

def VELoadVL :
    SDTypeProfile<0, 1, [SDTCisVT<0, i32>]>;
def VElvl : SDNode<"VEISD::INT_LVL", VELoadVL, [SDNPHasChain]>;

//===----------------------------------------------------------------------===//
// Gather with mask instructions
//===----------------------------------------------------------------------===//

// (v256i64 (VGT (v256i64 vy), (vNi1 vm)))

def VEGatherMask :
    SDTypeProfile<1, 2, [SDTCisVec<0>,
                         SDTCisSameAs<1, 0>,
                         SDTCisVec<2>, SDTCVecEltisVT<2, i1>]>;
def VEvgt_m    : SDNode<"VEISD::INT_VGT_M", VEGatherMask,
                        [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;
def VEvgtu_m   : SDNode<"VEISD::INT_VGTU_M", VEGatherMask,
                        [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;
def VEvgtlsx_m : SDNode<"VEISD::INT_VGTLSX_M", VEGatherMask,
                        [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;
def VEvgtlzx_m : SDNode<"VEISD::INT_VGTLZX_M", VEGatherMask,
                        [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;

//===----------------------------------------------------------------------===//
// Scatter with mask instructions
//===----------------------------------------------------------------------===//

// (VSC (v256i64 vx), (v256i64 vy), (vNi1 vm))

def VEScatterMask :
    SDTypeProfile<0, 3, [SDTCisVec<0>,
                         SDTCisSameAs<1, 0>,
                         SDTCisVec<2>, SDTCVecEltisVT<2, i1>]>;
def VEvsc_m  : SDNode<"VEISD::INT_VSC_M", VEScatterMask,
                      [SDNPHasChain, SDNPMayStore, SDNPMemOperand]>;
def VEvscu_m : SDNode<"VEISD::INT_VSCU_M", VEScatterMask,
                      [SDNPHasChain, SDNPMayStore, SDNPMemOperand]>;
def VEvscl_m : SDNode<"VEISD::INT_VSCL_M", VEScatterMask,
                      [SDNPHasChain, SDNPMayStore, SDNPMemOperand]>;

//===----------------------------------------------------------------------===//
// 0-op vector with base mask register instructions
//===----------------------------------------------------------------------===//

// (v256i1 (VFMKAT))

def VE0OpM :
    SDTypeProfile<1, 0, [SDTCisVec<0>, SDTCVecEltisVT<0, i1>]>;
def VEvfmkat : SDNode<"VEISD::INT_VFMKAT", VE0OpM>;
def VEvfmkaf : SDNode<"VEISD::INT_VFMKAF", VE0OpM>;
def VEpvfmkat : SDNode<"VEISD::INT_PVFMKAT", VE0OpM>;
def VEpvfmkaf : SDNode<"VEISD::INT_PVFMKAF", VE0OpM>;

//===----------------------------------------------------------------------===//
// 1-op logical instructions
//===----------------------------------------------------------------------===//

// (vNi1 (NEGM (vNi1 vy)))

def VE1OpMM :
    SDTypeProfile<1, 1, [SDTCisVec<0>, SDTCVecEltisVT<0, i1>,
                         SDTCisSameAs<1, 0>]>;
def VEnegm : SDNode<"VEISD::INT_NEGM", VE1OpMM>;

// (v256i1 (EXTMU (v512i1 vy)))

def VE1OpMM2 :
    SDTypeProfile<1, 1, [SDTCisVec<0>, SDTCVecEltisVT<0, i1>,
                         SDTCisVec<1>, SDTCVecEltisVT<1, i1>]>;
def VEextmu : SDNode<"VEISD::INT_EXTMU", VE1OpMM2>;
def VEextml : SDNode<"VEISD::INT_EXTML", VE1OpMM2>;

//===----------------------------------------------------------------------===//
// 2-op logical instructions
//===----------------------------------------------------------------------===//

// (vNi1 (ANDM (vNi1 vy), (vNi1 vz)))

def VE2OpMMM :
    SDTypeProfile<1, 2, [SDTCisVec<0>, SDTCVecEltisVT<0, i1>,
                         SDTCisSameAs<1, 0>, SDTCisSameAs<2, 0>]>;
def VEandm : SDNode<"VEISD::INT_ANDM", VE2OpMMM>;
def VEorm  : SDNode<"VEISD::INT_ORM",  VE2OpMMM>;
def VExorm : SDNode<"VEISD::INT_XORM", VE2OpMMM>;
def VEeqvm : SDNode<"VEISD::INT_EQVM", VE2OpMMM>;
def VEnndm : SDNode<"VEISD::INT_NNDM", VE2OpMMM>;

// (v512i1 (INSMU (v512i1 vy), (v256i1 vz)))

def VE2OpMMM2 :
    SDTypeProfile<1, 2, [SDTCisVec<0>, SDTCVecEltisVT<0, i1>,
                         SDTCisSameAs<1, 0>,
                         SDTCisVec<2>, SDTCVecEltisVT<2, i1>]>;
def VEinsmu : SDNode<"VEISD::INT_INSMU", VE2OpMMM2>;
def VEinsml : SDNode<"VEISD::INT_INSML", VE2OpMMM2>;

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
// 1-op instructios with hidden VL instructions
//===----------------------------------------------------------------------===//

// Either of
// (v256f64 (VBRD (f64 sy), (VLS vl)))
// (v256f64 (VBRD (i64 sy), (VLS vl)))

def VE1OpVS :
    SDTypeProfile<1, 2, [SDTCisVec<0>]>;
def INT_VBRD : SDNode<"VEISD::INT_VBRD", VE1OpVS>;
def INT_VBRDU : SDNode<"VEISD::INT_VBRDU", VE1OpVS>;
def INT_VBRDL : SDNode<"VEISD::INT_VBRDL", VE1OpVS>;
def INT_PVBRD : SDNode<"VEISD::INT_PVBRD", VE1OpVS>;

//===----------------------------------------------------------------------===//
// 1-op instructions with mask, base register, and hidden VL
//===----------------------------------------------------------------------===//

// Either of
// (v256f64 (VBRDM (f64 sy), (vNi1 vy), (v256f64 base), (VLS vl)))
// (v256f64 (VBRDM (i64 sy), (vNi1 vy), (v256f64 base), (VLS vl)))

def VE1OpVSMV :
    SDTypeProfile<1, 4, [SDTCisVec<0>,
                         SDTCisVec<2>, SDTCVecEltisVT<2, i1>,
                         SDTCisSameAs<3, 0>]>;
def INT_VBRD_M : SDNode<"VEISD::INT_VBRD_M", VE1OpVSMV>;
def INT_VBRDU_M : SDNode<"VEISD::INT_VBRDU_M", VE1OpVSMV>;
def INT_VBRDL_M : SDNode<"VEISD::INT_VBRDL_M", VE1OpVSMV>;
def INT_PVBRD_M : SDNode<"VEISD::INT_PVBRD_M", VE1OpVSMV>;

// (v256f64 (VCP (v256f64 sz), (vNi1 vy), (v256f64 base)))

def VE1OpVVMV :
    SDTypeProfile<1, 3, [SDTCisVec<0>,
                         SDTCisSameAs<1, 0>,
                         SDTCisVec<2>, SDTCVecEltisVT<2, i1>,
                         SDTCisSameAs<3, 0>]>;
def VEvcp : SDNode<"VEISD::INT_VCP", VE1OpVVMV>;
def VEvex : SDNode<"VEISD::INT_VEX", VE1OpVVMV>;

//===----------------------------------------------------------------------===//
// 2-op vector with base mask register instructions
//===----------------------------------------------------------------------===//

// (v256i1 (VFMKL (i64 cf), (v256f64 vz)))

def VE2OpMSV :
    SDTypeProfile<1, 2, [SDTCisVec<0>, SDTCVecEltisVT<0, i1>,
                         SDTCisInt<1>,
                         SDTCisVec<2>]>;
def VEvfmkl : SDNode<"VEISD::INT_VFMKL", VE2OpMSV>;
def VEvfmkw : SDNode<"VEISD::INT_VFMKW", VE2OpMSV>;
def VEvfmkd : SDNode<"VEISD::INT_VFMKD", VE2OpMSV>;
def VEvfmks : SDNode<"VEISD::INT_VFMKS", VE2OpMSV>;
def VEpvfmkw : SDNode<"VEISD::INT_PVFMKW", VE2OpMSV>;
def VEpvfmks : SDNode<"VEISD::INT_PVFMKS", VE2OpMSV>;

// (v256i1 (VFMKLM (i64 cf), (v256f64 vz), (v256i1 base)))

def VE2OpMSVM :
    SDTypeProfile<1, 3, [SDTCisVec<0>, SDTCVecEltisVT<0, i1>,
                         SDTCisInt<1>,
                         SDTCisVec<2>,
                         SDTCisSameAs<3, 0>]>;
def VEvfmklm : SDNode<"VEISD::INT_VFMKL_M", VE2OpMSVM>;
def VEvfmkwm : SDNode<"VEISD::INT_VFMKW_M", VE2OpMSVM>;
def VEvfmkdm : SDNode<"VEISD::INT_VFMKD_M", VE2OpMSVM>;
def VEvfmksm : SDNode<"VEISD::INT_VFMKS_M", VE2OpMSVM>;
def VEpvfmkwm : SDNode<"VEISD::INT_PVFMKW_M", VE2OpMSVM>;
def VEpvfmksm : SDNode<"VEISD::INT_PVFMKS_M", VE2OpMSVM>;

//===----------------------------------------------------------------------===//
// 2-op instructions with hidden VL
//===----------------------------------------------------------------------===//

// Either of 
// (v256f64 (VADDlvm (v256f64 vy), (v256f64 vz), (VLS vl)))
// (v256f64 (VADDlvm (i64 sy), (v256f64 vz), (VLS vl)))

def VE2OpVXVVL :
    SDTypeProfile<1, 3, [SDTCisVec<0>, 
                         SDTCisSameAs<2, 0>]>;
def INT_VADDUL : SDNode<"VEISD::INT_VADDUL", VE2OpVXVVL>;
def INT_VADDUW : SDNode<"VEISD::INT_VADDUW", VE2OpVXVVL>;
def INT_VADDSWSX : SDNode<"VEISD::INT_VADDSWSX", VE2OpVXVVL>;
def INT_VADDSWZX : SDNode<"VEISD::INT_VADDSWZX", VE2OpVXVVL>;
def INT_VADDSL : SDNode<"VEISD::INT_VADDSL", VE2OpVXVVL>;
def INT_PVADDU : SDNode<"VEISD::INT_PVADDU", VE2OpVXVVL>;
def INT_PVADDS : SDNode<"VEISD::INT_PVADDS", VE2OpVXVVL>;
def INT_VSUBUL : SDNode<"VEISD::INT_VSUBUL", VE2OpVXVVL>;
def INT_VSUBUW : SDNode<"VEISD::INT_VSUBUW", VE2OpVXVVL>;
def INT_VSUBSWSX : SDNode<"VEISD::INT_VSUBSWSX", VE2OpVXVVL>;
def INT_VSUBSWZX : SDNode<"VEISD::INT_VSUBSWZX", VE2OpVXVVL>;
def INT_VSUBSL : SDNode<"VEISD::INT_VSUBSL", VE2OpVXVVL>;
def INT_PVSUBU : SDNode<"VEISD::INT_PVSUBU", VE2OpVXVVL>;
def INT_PVSUBS : SDNode<"VEISD::INT_PVSUBS", VE2OpVXVVL>;
def INT_VCMPUL : SDNode<"VEISD::INT_VCMPUL", VE2OpVXVVL>;
def INT_VCMPUW : SDNode<"VEISD::INT_VCMPUW", VE2OpVXVVL>;
def INT_VCMPSWSX : SDNode<"VEISD::INT_VCMPSWSX", VE2OpVXVVL>;
def INT_VCMPSWZX : SDNode<"VEISD::INT_VCMPSWZX", VE2OpVXVVL>;
def INT_VCMPSL : SDNode<"VEISD::INT_VCMPSL", VE2OpVXVVL>;
def INT_PVCMPU : SDNode<"VEISD::INT_PVCMPU", VE2OpVXVVL>;
def INT_PVCMPS : SDNode<"VEISD::INT_PVCMPS", VE2OpVXVVL>;
def INT_VMAXSWSX : SDNode<"VEISD::INT_VMAXSWSX", VE2OpVXVVL>;
def INT_VMAXSWZX : SDNode<"VEISD::INT_VMAXSWZX", VE2OpVXVVL>;
def INT_PVMAXS : SDNode<"VEISD::INT_PVMAXS", VE2OpVXVVL>;
def INT_VMAXSL : SDNode<"VEISD::INT_VMAXSL", VE2OpVXVVL>;
def INT_VMINSWSX : SDNode<"VEISD::INT_VMINSWSX", VE2OpVXVVL>;
def INT_VMINSWZX : SDNode<"VEISD::INT_VMINSWZX", VE2OpVXVVL>;
def INT_PVMINS : SDNode<"VEISD::INT_PVMINS", VE2OpVXVVL>;
def INT_VMINSL : SDNode<"VEISD::INT_VMINSL", VE2OpVXVVL>;

//===----------------------------------------------------------------------===//
// 2-op instructions with mask, base register, and hidden VL
//===----------------------------------------------------------------------===//

// Either of 
// (v256f64 (VADDlvm (v256f64 vy), (v256f64 vz), (v256i1 vm), (v256f64 base),
//                   (VLS vl)))
// (v256f64 (VADDlvm (i64 sy), (v256f64 vz), (v256i1 vm), (v256f64 base),
//                   (VLS vl)))

def VE2OpVXVMVVL :
    SDTypeProfile<1, 5, [SDTCisVec<0>, 
                         SDTCisSameAs<2, 0>,
                         SDTCisVec<3>, SDTCVecEltisVT<3, i1>,
                         SDTCisSameAs<4, 0>]>;
def INT_VADDUL_M : SDNode<"VEISD::INT_VADDUL_M", VE2OpVXVMVVL>;
def INT_VADDUW_M : SDNode<"VEISD::INT_VADDUW_M", VE2OpVXVMVVL>;
def INT_VADDSWSX_M : SDNode<"VEISD::INT_VADDSWSX_M", VE2OpVXVMVVL>;
def INT_VADDSWZX_M : SDNode<"VEISD::INT_VADDSWZX_M", VE2OpVXVMVVL>;
def INT_VADDSL_M : SDNode<"VEISD::INT_VADDSL_M", VE2OpVXVMVVL>;
def INT_PVADDU_M : SDNode<"VEISD::INT_PVADDU_M", VE2OpVXVMVVL>;
def INT_PVADDS_M : SDNode<"VEISD::INT_PVADDS_M", VE2OpVXVMVVL>;
def INT_VSUBUL_M : SDNode<"VEISD::INT_VSUBUL_M", VE2OpVXVMVVL>;
def INT_VSUBUW_M : SDNode<"VEISD::INT_VSUBUW_M", VE2OpVXVMVVL>;
def INT_VSUBSWSX_M : SDNode<"VEISD::INT_VSUBSWSX_M", VE2OpVXVMVVL>;
def INT_VSUBSWZX_M : SDNode<"VEISD::INT_VSUBSWZX_M", VE2OpVXVMVVL>;
def INT_VSUBSL_M : SDNode<"VEISD::INT_VSUBSL_M", VE2OpVXVMVVL>;
def INT_PVSUBU_M : SDNode<"VEISD::INT_PVSUBU_M", VE2OpVXVMVVL>;
def INT_PVSUBS_M : SDNode<"VEISD::INT_PVSUBS_M", VE2OpVXVMVVL>;
def INT_VCMPUL_M : SDNode<"VEISD::INT_VCMPUL_M", VE2OpVXVMVVL>;
def INT_VCMPUW_M : SDNode<"VEISD::INT_VCMPUW_M", VE2OpVXVMVVL>;
def INT_VCMPSWSX_M : SDNode<"VEISD::INT_VCMPSWSX_M", VE2OpVXVMVVL>;
def INT_VCMPSWZX_M : SDNode<"VEISD::INT_VCMPSWZX_M", VE2OpVXVMVVL>;
def INT_VCMPSL_M : SDNode<"VEISD::INT_VCMPSL_M", VE2OpVXVMVVL>;
def INT_PVCMPU_M : SDNode<"VEISD::INT_PVCMPU_M", VE2OpVXVMVVL>;
def INT_PVCMPS_M : SDNode<"VEISD::INT_PVCMPS_M", VE2OpVXVMVVL>;
def INT_VMAXSWSX_M : SDNode<"VEISD::INT_VMAXSWSX_M", VE2OpVXVMVVL>;
def INT_VMAXSWZX_M : SDNode<"VEISD::INT_VMAXSWZX_M", VE2OpVXVMVVL>;
def INT_PVMAXS_M : SDNode<"VEISD::INT_PVMAXS_M", VE2OpVXVMVVL>;
def INT_VMAXSL_M : SDNode<"VEISD::INT_VMAXSL_M", VE2OpVXVMVVL>;
def INT_VMINSWSX_M : SDNode<"VEISD::INT_VMINSWSX_M", VE2OpVXVMVVL>;
def INT_VMINSWZX_M : SDNode<"VEISD::INT_VMINSWZX_M", VE2OpVXVMVVL>;
def INT_PVMINS_M : SDNode<"VEISD::INT_PVMINS_M", VE2OpVXVMVVL>;
def INT_VMINSL_M : SDNode<"VEISD::INT_VMINSL_M", VE2OpVXVMVVL>;

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
def VEvfaddd : SDNode<"VEISD::INT_VFADDD", VE2OpVXVMV>;
def VEvfadds : SDNode<"VEISD::INT_VFADDS", VE2OpVXVMV>;
def VEpvfadd : SDNode<"VEISD::INT_PVFADD", VE2OpVXVMV>;
def VEvmulul : SDNode<"VEISD::INT_VMULUL", VE2OpVXVMV>;
def VEvmuluw : SDNode<"VEISD::INT_VMULUW", VE2OpVXVMV>;
def VEvmulswsx : SDNode<"VEISD::INT_VMULSWSX", VE2OpVXVMV>;
def VEvmulswzx : SDNode<"VEISD::INT_VMULSWZX", VE2OpVXVMV>;
def VEvmulsl : SDNode<"VEISD::INT_VMULSL", VE2OpVXVMV>;
def VEvfsubd : SDNode<"VEISD::INT_VFSUBD", VE2OpVXVMV>;
def VEvfsubs : SDNode<"VEISD::INT_VFSUBS", VE2OpVXVMV>;
def VEvfmuld : SDNode<"VEISD::INT_VFMULD", VE2OpVXVMV>;
def VEvfmuls : SDNode<"VEISD::INT_VFMULS", VE2OpVXVMV>;
def VEvfdivd : SDNode<"VEISD::INT_VFDIVD", VE2OpVXVMV>;
def VEvfdivs : SDNode<"VEISD::INT_VFDIVS", VE2OpVXVMV>;
def VEvfcmpd : SDNode<"VEISD::INT_VFCMPD", VE2OpVXVMV>;
def VEvfcmps : SDNode<"VEISD::INT_VFCMPS", VE2OpVXVMV>;
def VEvfmaxd : SDNode<"VEISD::INT_VFMAXD", VE2OpVXVMV>;
def VEvfmaxs : SDNode<"VEISD::INT_VFMAXS", VE2OpVXVMV>;
def VEvfmind : SDNode<"VEISD::INT_VFMIND", VE2OpVXVMV>;
def VEvfmins : SDNode<"VEISD::INT_VFMINS", VE2OpVXVMV>;
def VEpvfsub : SDNode<"VEISD::INT_PVFSUB", VE2OpVXVMV>;
def VEpvfmul : SDNode<"VEISD::INT_PVFMUL", VE2OpVXVMV>;
def VEpvfcmp : SDNode<"VEISD::INT_PVFCMP", VE2OpVXVMV>;
def VEpvfmax : SDNode<"VEISD::INT_PVFMAX", VE2OpVXVMV>;
def VEpvfmin : SDNode<"VEISD::INT_PVFMIN", VE2OpVXVMV>;
def VEvand : SDNode<"VEISD::INT_VAND", VE2OpVXVMV>;
def VEvor : SDNode<"VEISD::INT_VOR", VE2OpVXVMV>;
def VEvxor : SDNode<"VEISD::INT_VXOR", VE2OpVXVMV>;
def VEveqv : SDNode<"VEISD::INT_VEQV", VE2OpVXVMV>;
def VEpvand : SDNode<"VEISD::INT_PVAND", VE2OpVXVMV>;
def VEpvor : SDNode<"VEISD::INT_PVOR", VE2OpVXVMV>;
def VEpvxor : SDNode<"VEISD::INT_PVXOR", VE2OpVXVMV>;
def VEpveqv : SDNode<"VEISD::INT_PVEQV", VE2OpVXVMV>;

// Either of 
// (v256f64 (VDVXlrm (v256f64 vy), (v256f64 vz), (v256i1 vm), (v256f64 base)))
// (v256f64 (VDVXlim (i64 sy), (v256f64 vz), (v256i1 vm), (v256f64 base)))
// (v256f64 (VDVXlim2 (v256f64 vz), (i64 sy), (v256i1 vm), (v256f64 base)))

def VE2OpVXXMV :
    SDTypeProfile<1, 4, [SDTCisVec<0>, 
                         SDTCisVec<3>, SDTCVecEltisVT<3, i1>,
                         SDTCisSameAs<4, 0>]>;
def VEvdivul : SDNode<"VEISD::INT_VDIVUL", VE2OpVXXMV>;
def VEvdivuw : SDNode<"VEISD::INT_VDIVUW", VE2OpVXXMV>;
def VEvdivswsx : SDNode<"VEISD::INT_VDIVSWSX", VE2OpVXXMV>;
def VEvdivswzx : SDNode<"VEISD::INT_VDIVSWZX", VE2OpVXXMV>;
def VEvdivsl : SDNode<"VEISD::INT_VDIVSL", VE2OpVXXMV>;

// Either of 
// (v256f64 (VSRAXvm (v256f64 vy), (v256f64 vz), (v256i1 vm), (v256f64 base)))
// (v256f64 (VSRAXrm2 (v256f64 vz), (i64 sy), (v256i1 vm), (v256f64 base)))

def VE2OpVVXMV :
    SDTypeProfile<1, 4, [SDTCisVec<0>, 
                         SDTCisSameAs<1, 0>,
                         SDTCisVec<3>, SDTCVecEltisVT<3, i1>,
                         SDTCisSameAs<4, 0>]>;
def VEvsll : SDNode<"VEISD::INT_VSLL", VE2OpVVXMV>;
def VEvsrl : SDNode<"VEISD::INT_VSRL", VE2OpVVXMV>;
def VEvslaw : SDNode<"VEISD::INT_VSLAW", VE2OpVVXMV>;
def VEvslal : SDNode<"VEISD::INT_VSLAL", VE2OpVVXMV>;
def VEvsraw : SDNode<"VEISD::INT_VSRAW", VE2OpVVXMV>;
def VEvsral : SDNode<"VEISD::INT_VSRAL", VE2OpVVXMV>;
def VEpvsll : SDNode<"VEISD::INT_PVSLL", VE2OpVVXMV>;
def VEpvsrl : SDNode<"VEISD::INT_PVSRL", VE2OpVVXMV>;
def VEpvsla : SDNode<"VEISD::INT_PVSLA", VE2OpVVXMV>;
def VEpvsra : SDNode<"VEISD::INT_PVSRA", VE2OpVVXMV>;

// Either of 
// (v256f64 (VMRG (v256f64 vy), (v256f64 vz), (v256i1 vm)))
// (v256f64 (VMRG (i64 sy), (v256f64 vz), (v256i1 vm)))

def VE2OpVXVM :
    SDTypeProfile<1, 3, [SDTCisVec<0>, 
                         SDTCisSameAs<2, 0>,
                         SDTCisVec<3>, SDTCVecEltisVT<3, i1>]>;
def VEvmrg : SDNode<"VEISD::INT_VMRG", VE2OpVXVM>;
def VEvmrgw : SDNode<"VEISD::INT_VMRGW", VE2OpVXVM>;

//===----------------------------------------------------------------------===//
// 3-op vector with mask and base register instructions
//===----------------------------------------------------------------------===//

// Either of 
// (v256f64 (VFMADdvm (v256f64 vy), (v256f64 vz), (v256f64 vw),
//                    (v256i1 vm), (v256f64 base)))
// (v256f64 (VFMADdrm (i64 sy), (v256f64 vz), (v256f64 vw),
//                    (v256i1 vm), (v256f64 base)))
// (v256f64 (VFMADdr2m (v256f64 vz), (i64 sy), (v256f64 vw),
//                     (v256i1 vm), (v256f64 base)))

def VE3OpVXXVMV :
    SDTypeProfile<1, 5, [SDTCisVec<0>, 
                         SDTCisSameAs<3, 0>,
                         SDTCisVec<4>, SDTCVecEltisVT<4, i1>,
                         SDTCisSameAs<5, 0>]>;
def VEvfmadd : SDNode<"VEISD::INT_VFMADD", VE3OpVXXVMV>;
def VEvfmads : SDNode<"VEISD::INT_VFMADS", VE3OpVXXVMV>;
def VEvfmsbd : SDNode<"VEISD::INT_VFMSBD", VE3OpVXXVMV>;
def VEvfmsbs : SDNode<"VEISD::INT_VFMSBS", VE3OpVXXVMV>;
def VEvfnmadd : SDNode<"VEISD::INT_VFNMADD", VE3OpVXXVMV>;
def VEvfnmads : SDNode<"VEISD::INT_VFNMADS", VE3OpVXXVMV>;
def VEvfnmsbd : SDNode<"VEISD::INT_VFNMSBD", VE3OpVXXVMV>;
def VEvfnmsbs : SDNode<"VEISD::INT_VFNMSBS", VE3OpVXXVMV>;
def VEpvfmad : SDNode<"VEISD::INT_PVFMAD", VE3OpVXXVMV>;
def VEpvfmsb : SDNode<"VEISD::INT_PVFMSB", VE3OpVXXVMV>;
def VEpvfnmad : SDNode<"VEISD::INT_PVFNMAD", VE3OpVXXVMV>;
def VEpvfnmsb : SDNode<"VEISD::INT_PVFNMSB", VE3OpVXXVMV>;

// (v256f64 (VSFArm (v256f64 vz), (i64 sy), (i64 sz),
//                  (v256i1 vm), (v256f64 base)))

def VE3OpVVSSMV :
    SDTypeProfile<1, 5, [SDTCisVec<0>, 
                         SDTCisSameAs<1, 0>,
                         SDTCisSameAs<3, 2>,
                         SDTCisVec<4>, SDTCVecEltisVT<4, i1>,
                         SDTCisSameAs<5, 0>]>;
def VEvsfa : SDNode<"VEISD::INT_VSFA", VE3OpVVSSMV>;

