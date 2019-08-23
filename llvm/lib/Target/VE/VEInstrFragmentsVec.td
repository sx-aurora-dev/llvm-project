//===-- VEInstrFragmentsVec.td - VE Vector ISA -------------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
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
def INT_LVM : SDNode<"VEISD::INT_LVM", VELoadMask>;

//===----------------------------------------------------------------------===//
// Store Mask instructions
//===----------------------------------------------------------------------===//

// (i64 (SVM (vNi1 vx), (i64 index)))

def VEStoreMask :
    SDTypeProfile<1, 2, [SDTCisVT<0, i64>,
                         SDTCisVec<1>, SDTCVecEltisVT<1, i1>,
                         SDTCisInt<2>]>;
def INT_SVM : SDNode<"VEISD::INT_SVM", VEStoreMask>;

//===----------------------------------------------------------------------===//
// Vector Load instructions
//===----------------------------------------------------------------------===//

// (v256i64 (VLD (i64 base), (i64 skip), (VLS vl)))

def VEVecLoad :
    SDTypeProfile<1, 3, [SDTCisVec<0>, SDTCisVT<1, i64>, SDTCisVT<2, i64>]>;
def INT_VLD : SDNode<"VEISD::INT_VLD", VEVecLoad,
                     [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;
def INT_VLDU : SDNode<"VEISD::INT_VLDU", VEVecLoad,
                      [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;
def INT_VLDLSX : SDNode<"VEISD::INT_VLDLSX", VEVecLoad,
                        [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;
def INT_VLDLZX : SDNode<"VEISD::INT_VLDLZX", VEVecLoad,
                        [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;
def INT_VLD2D : SDNode<"VEISD::INT_VLD2D", VEVecLoad,
                       [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;
def INT_VLDU2D : SDNode<"VEISD::INT_VLDU2D", VEVecLoad,
                        [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;
def INT_VLDL2DSX : SDNode<"VEISD::INT_VLDL2DSX", VEVecLoad,
                          [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;
def INT_VLDL2DZX : SDNode<"VEISD::INT_VLDL2DZX", VEVecLoad,
                          [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;

//===----------------------------------------------------------------------===//
// Vector Store instructions
//===----------------------------------------------------------------------===//

// (VST (v256i64 vx), (i64 base), (i64 skip), (VLS vl))

def VEVecStore :
    SDTypeProfile<0, 4, [SDTCisVec<0>, SDTCisVT<1, i64>, SDTCisVT<2, i64>]>;
def INT_VST : SDNode<"VEISD::INT_VST", VEVecStore,
                     [SDNPHasChain, SDNPMayStore, SDNPMemOperand]>;
def INT_VSTU : SDNode<"VEISD::INT_VSTU", VEVecStore,
                      [SDNPHasChain, SDNPMayStore, SDNPMemOperand]>;
def INT_VSTL : SDNode<"VEISD::INT_VSTL", VEVecStore,
                      [SDNPHasChain, SDNPMayStore, SDNPMemOperand]>;
def INT_VST2D : SDNode<"VEISD::INT_VST2D", VEVecStore,
                       [SDNPHasChain, SDNPMayStore, SDNPMemOperand]>;
def INT_VSTU2D : SDNode<"VEISD::INT_VSTU2D", VEVecStore,
                        [SDNPHasChain, SDNPMayStore, SDNPMemOperand]>;
def INT_VSTL2D : SDNode<"VEISD::INT_VSTL2D", VEVecStore,
                        [SDNPHasChain, SDNPMayStore, SDNPMemOperand]>;

//===----------------------------------------------------------------------===//
// Load VL
//===----------------------------------------------------------------------===//

// (VLS (LVL (VLS val)))

def VELoadVL :
    SDTypeProfile<1, 1, [SDTCisVT<0, i32>, SDTCisVT<1, i32>]>;
def INT_LVL : SDNode<"VEISD::INT_LVL", VELoadVL>;

//===----------------------------------------------------------------------===//
// Gather instructions with hidden VL
//===----------------------------------------------------------------------===//

// (v256i64 (VGT (v256i64 vy), (VLS vl)))

def VEGather :
    SDTypeProfile<1, 2, [SDTCisVec<0>,
                         SDTCisSameAs<1, 0>]>;
def INT_VGT    : SDNode<"VEISD::INT_VGT", VEGather,
                        [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;
def INT_VGTU   : SDNode<"VEISD::INT_VGTU", VEGather,
                        [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;
def INT_VGTLSX : SDNode<"VEISD::INT_VGTLSX", VEGather,
                        [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;
def INT_VGTLZX : SDNode<"VEISD::INT_VGTLZX", VEGather,
                        [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;

//===----------------------------------------------------------------------===//
// Gather instructions with mask and hidden VL
//===----------------------------------------------------------------------===//

// (v256i64 (VGT (v256i64 vy), (vNi1 vm), (VLS vl)))

def VEGatherMask :
    SDTypeProfile<1, 3, [SDTCisVec<0>,
                         SDTCisSameAs<1, 0>,
                         SDTCisVec<2>, SDTCVecEltisVT<2, i1>]>;
def INT_VGT_M    : SDNode<"VEISD::INT_VGT_M", VEGatherMask,
                          [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;
def INT_VGTU_M   : SDNode<"VEISD::INT_VGTU_M", VEGatherMask,
                          [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;
def INT_VGTLSX_M : SDNode<"VEISD::INT_VGTLSX_M", VEGatherMask,
                          [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;
def INT_VGTLZX_M : SDNode<"VEISD::INT_VGTLZX_M", VEGatherMask,
                          [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;

//===----------------------------------------------------------------------===//
// Scatter instructionos with hidden VL
//===----------------------------------------------------------------------===//

// (VSC (v256i64 vx), (v256i64 vy), (VLS vl))

def VEScatter :
    SDTypeProfile<0, 3, [SDTCisVec<0>,
                         SDTCisSameAs<1, 0>]>;
def INT_VSC  : SDNode<"VEISD::INT_VSC", VEScatter,
                      [SDNPHasChain, SDNPMayStore, SDNPMemOperand]>;
def INT_VSCU : SDNode<"VEISD::INT_VSCU", VEScatter,
                      [SDNPHasChain, SDNPMayStore, SDNPMemOperand]>;
def INT_VSCL : SDNode<"VEISD::INT_VSCL", VEScatter,
                      [SDNPHasChain, SDNPMayStore, SDNPMemOperand]>;

//===----------------------------------------------------------------------===//
// Scatter instructionos with mask and hidden VL
//===----------------------------------------------------------------------===//

// (VSC (v256i64 vx), (v256i64 vy), (vNi1 vm), (VLS vl))

def VEScatterMask :
    SDTypeProfile<0, 4, [SDTCisVec<0>,
                         SDTCisSameAs<1, 0>,
                         SDTCisVec<2>, SDTCVecEltisVT<2, i1>]>;
def INT_VSC_M  : SDNode<"VEISD::INT_VSC_M", VEScatterMask,
                        [SDNPHasChain, SDNPMayStore, SDNPMemOperand]>;
def INT_VSCU_M : SDNode<"VEISD::INT_VSCU_M", VEScatterMask,
                        [SDNPHasChain, SDNPMayStore, SDNPMemOperand]>;
def INT_VSCL_M : SDNode<"VEISD::INT_VSCL_M", VEScatterMask,
                        [SDNPHasChain, SDNPMayStore, SDNPMemOperand]>;

//===----------------------------------------------------------------------===//
// 0-op instruction with hidden VL
//===----------------------------------------------------------------------===//

// (v256i64 (VSEQ (VLS vl)))

def VE0OpVL :
    SDTypeProfile<1, 1, [SDTCisVec<0>]>;
def INT_VSEQ : SDNode<"VEISD::INT_VSEQ", VE0OpVL>;
def INT_PVSEQLO : SDNode<"VEISD::INT_PVSEQLO", VE0OpVL>;
def INT_PVSEQUP : SDNode<"VEISD::INT_PVSEQUP", VE0OpVL>;
def INT_PVSEQ : SDNode<"VEISD::INT_PVSEQ", VE0OpVL>;

//===----------------------------------------------------------------------===//
// 0-op instruction with vector mask register and hidden VL
//===----------------------------------------------------------------------===//

// (v256i1 (VFMKAT (VLS vl)))

def VE0OpMVL :
    SDTypeProfile<1, 1, [SDTCisVec<0>, SDTCVecEltisVT<0, i1>]>;
def INT_VFMKAT : SDNode<"VEISD::INT_VFMKAT", VE0OpMVL>;
def INT_VFMKAF : SDNode<"VEISD::INT_VFMKAF", VE0OpMVL>;
def INT_PVFMKAT : SDNode<"VEISD::INT_PVFMKAT", VE0OpMVL>;
def INT_PVFMKAF : SDNode<"VEISD::INT_PVFMKAF", VE0OpMVL>;
def INT_VSEQ_M : SDNode<"VEISD::INT_VSEQ_M", VE0OpMVL>;
def INT_PVSEQLO_M : SDNode<"VEISD::INT_PVSEQLO_M", VE0OpMVL>;
def INT_PVSEQUP_M : SDNode<"VEISD::INT_PVSEQUP_M", VE0OpMVL>;
def INT_PVSEQ_M : SDNode<"VEISD::INT_PVSEQ_M", VE0OpMVL>;

//===----------------------------------------------------------------------===//
// 1-op logical instructions
//===----------------------------------------------------------------------===//

// (vNi1 (NEGM (vNi1 vy)))

def VE1OpMM :
    SDTypeProfile<1, 1, [SDTCisVec<0>, SDTCVecEltisVT<0, i1>,
                         SDTCisSameAs<1, 0>]>;
def INT_NEGM : SDNode<"VEISD::INT_NEGM", VE1OpMM>;

// (v256i1 (EXTMU (v512i1 vy)))

def VE1OpMM2 :
    SDTypeProfile<1, 1, [SDTCisVec<0>, SDTCVecEltisVT<0, i1>,
                         SDTCisVec<1>, SDTCVecEltisVT<1, i1>]>;
def INT_EXTMU : SDNode<"VEISD::INT_EXTMU", VE1OpMM2>;
def INT_EXTML : SDNode<"VEISD::INT_EXTML", VE1OpMM2>;

//===----------------------------------------------------------------------===//
// 2-op logical instructions
//===----------------------------------------------------------------------===//

// (vNi1 (ANDM (vNi1 vy), (vNi1 vz)))

def VE2OpMMM :
    SDTypeProfile<1, 2, [SDTCisVec<0>, SDTCVecEltisVT<0, i1>,
                         SDTCisSameAs<1, 0>, SDTCisSameAs<2, 0>]>;
def INT_ANDM : SDNode<"VEISD::INT_ANDM", VE2OpMMM>;
def INT_ORM  : SDNode<"VEISD::INT_ORM",  VE2OpMMM>;
def INT_XORM : SDNode<"VEISD::INT_XORM", VE2OpMMM>;
def INT_EQVM : SDNode<"VEISD::INT_EQVM", VE2OpMMM>;
def INT_NNDM : SDNode<"VEISD::INT_NNDM", VE2OpMMM>;

// (v512i1 (INSMU (v512i1 vy), (v256i1 vz)))

def VE2OpMMM2 :
    SDTypeProfile<1, 2, [SDTCisVec<0>, SDTCVecEltisVT<0, i1>,
                         SDTCisSameAs<1, 0>,
                         SDTCisVec<2>, SDTCVecEltisVT<2, i1>]>;
def INT_INSMU : SDNode<"VEISD::INT_INSMU", VE2OpMMM2>;
def INT_INSML : SDNode<"VEISD::INT_INSML", VE2OpMMM2>;

//===----------------------------------------------------------------------===//
// 2-op prefetch instructions with hidden VL
//===----------------------------------------------------------------------===//

// (PFCH (i64 sy), (i64 sz), (VLS vl)))

def VE2OpSSVL :
    SDTypeProfile<0, 3, [SDTCisInt<0>, SDTCisInt<1>]>;
def INT_PFCHV : SDNode<"VEISD::INT_PFCHV", VE2OpSSVL,
                       [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;

//===----------------------------------------------------------------------===//
// 1-op instructions with hidden VL
//===----------------------------------------------------------------------===//

// (i64 (PCVM (vNi1 vy), (VLS vl)))

def VE1OpSMVL :
    SDTypeProfile<1, 2, [SDTCisInt<0>, SDTCisVec<1>, SDTCVecEltisVT<1, i1>]>;
def INT_PCVM : SDNode<"VEISD::INT_PCVM", VE1OpSMVL>;
def INT_LZVM : SDNode<"VEISD::INT_LZVM", VE1OpSMVL>;
def INT_TOVM : SDNode<"VEISD::INT_TOVM", VE1OpSMVL>;

//===----------------------------------------------------------------------===//
// 1-op instructios with hidden VL
//===----------------------------------------------------------------------===//

// Either of
// (v256f64 (VBRD (f64 sy), (VLS vl)))
// (v256f64 (VBRD (i64 sy), (VLS vl)))

def VE1OpVSVL :
    SDTypeProfile<1, 2, [SDTCisVec<0>]>;
def INT_VBRD : SDNode<"VEISD::INT_VBRD", VE1OpVSVL>;
def INT_VBRDU : SDNode<"VEISD::INT_VBRDU", VE1OpVSVL>;
def INT_VBRDL : SDNode<"VEISD::INT_VBRDL", VE1OpVSVL>;
def INT_PVBRD : SDNode<"VEISD::INT_PVBRD", VE1OpVSVL>;

// Either of
// (v256f64 (VRSQRT (v256f64 vy), (VLS vl)))

def VE1OpVVVL :
    SDTypeProfile<1, 2, [SDTCisVec<0>, SDTCisSameAs<1, 0>]>;
def INT_VFSQRTD : SDNode<"VEISD::INT_VFSQRTD", VE1OpVVVL>;
def INT_VFSQRTS : SDNode<"VEISD::INT_VFSQRTS", VE1OpVVVL>;
def INT_VRSQRTD : SDNode<"VEISD::INT_VRSQRTD", VE1OpVVVL>;
def INT_VRSQRTS : SDNode<"VEISD::INT_VRSQRTS", VE1OpVVVL>;
def INT_PVRSQRT : SDNode<"VEISD::INT_PVRSQRT", VE1OpVVVL>;
def INT_VRCPD : SDNode<"VEISD::INT_VRCPD", VE1OpVVVL>;
def INT_VRCPS : SDNode<"VEISD::INT_VRCPS", VE1OpVVVL>;
def INT_PVRCP : SDNode<"VEISD::INT_PVRCP", VE1OpVVVL>;
def INT_VCVTWDSX : SDNode<"VEISD::INT_VCVTWDSX", VE1OpVVVL>;
def INT_VCVTWDSXRZ : SDNode<"VEISD::INT_VCVTWDSXRZ", VE1OpVVVL>;
def INT_VCVTWDZX : SDNode<"VEISD::INT_VCVTWDZX", VE1OpVVVL>;
def INT_VCVTWDZXRZ : SDNode<"VEISD::INT_VCVTWDZXRZ", VE1OpVVVL>;
def INT_VCVTWSSX : SDNode<"VEISD::INT_VCVTWSSX", VE1OpVVVL>;
def INT_VCVTWSSXRZ : SDNode<"VEISD::INT_VCVTWSSXRZ", VE1OpVVVL>;
def INT_VCVTWSZX : SDNode<"VEISD::INT_VCVTWSZX", VE1OpVVVL>;
def INT_VCVTWSZXRZ : SDNode<"VEISD::INT_VCVTWSZXRZ", VE1OpVVVL>;
def INT_PVCVTWS : SDNode<"VEISD::INT_PVCVTWS", VE1OpVVVL>;
def INT_PVCVTWSRZ : SDNode<"VEISD::INT_PVCVTWSRZ", VE1OpVVVL>;
def INT_VCVTLD : SDNode<"VEISD::INT_VCVTLD", VE1OpVVVL>;
def INT_VCVTLDRZ : SDNode<"VEISD::INT_VCVTLDRZ", VE1OpVVVL>;
def INT_VCVTDW : SDNode<"VEISD::INT_VCVTDW", VE1OpVVVL>;
def INT_VCVTSW : SDNode<"VEISD::INT_VCVTSW", VE1OpVVVL>;
def INT_PVCVTSW : SDNode<"VEISD::INT_PVCVTSW", VE1OpVVVL>;
def INT_VCVTDL : SDNode<"VEISD::INT_VCVTDL", VE1OpVVVL>;
def INT_VCVTDS : SDNode<"VEISD::INT_VCVTDS", VE1OpVVVL>;
def INT_VCVTSD : SDNode<"VEISD::INT_VCVTSD", VE1OpVVVL>;
def INT_VSUMWSX : SDNode<"VEISD::INT_VSUMWSX", VE1OpVVVL>;
def INT_VSUMWZX : SDNode<"VEISD::INT_VSUMWZX", VE1OpVVVL>;
def INT_VSUML : SDNode<"VEISD::INT_VSUML", VE1OpVVVL>;
def INT_VFSUMD : SDNode<"VEISD::INT_VFSUMD", VE1OpVVVL>;
def INT_VFSUMS : SDNode<"VEISD::INT_VFSUMS", VE1OpVVVL>;
def INT_VRMAXSWFSTSX : SDNode<"VEISD::INT_VRMAXSWFSTSX", VE1OpVVVL>;
def INT_VRMAXSWLSTSX : SDNode<"VEISD::INT_VRMAXSWLSTSX", VE1OpVVVL>;
def INT_VRMAXSWFSTZX : SDNode<"VEISD::INT_VRMAXSWFSTZX", VE1OpVVVL>;
def INT_VRMAXSWLSTZX : SDNode<"VEISD::INT_VRMAXSWLSTZX", VE1OpVVVL>;
def INT_VRMINSWFSTSX : SDNode<"VEISD::INT_VRMINSWFSTSX", VE1OpVVVL>;
def INT_VRMINSWLSTSX : SDNode<"VEISD::INT_VRMINSWLSTSX", VE1OpVVVL>;
def INT_VRMINSWFSTZX : SDNode<"VEISD::INT_VRMINSWFSTZX", VE1OpVVVL>;
def INT_VRMINSWLSTZX : SDNode<"VEISD::INT_VRMINSWLSTZX", VE1OpVVVL>;
def INT_VRMAXSLFST : SDNode<"VEISD::INT_VRMAXSLFST", VE1OpVVVL>;
def INT_VRMAXSLLST : SDNode<"VEISD::INT_VRMAXSLLST", VE1OpVVVL>;
def INT_VRMINSLFST : SDNode<"VEISD::INT_VRMINSLFST", VE1OpVVVL>;
def INT_VRMINSLLST : SDNode<"VEISD::INT_VRMINSLLST", VE1OpVVVL>;
def INT_VFRMAXDFST : SDNode<"VEISD::INT_VFRMAXDFST", VE1OpVVVL>;
def INT_VFRMAXDLST : SDNode<"VEISD::INT_VFRMAXDLST", VE1OpVVVL>;
def INT_VFRMAXSFST : SDNode<"VEISD::INT_VFRMAXSFST", VE1OpVVVL>;
def INT_VFRMAXSLST : SDNode<"VEISD::INT_VFRMAXSLST", VE1OpVVVL>;
def INT_VFRMINDFST : SDNode<"VEISD::INT_VFRMINDFST", VE1OpVVVL>;
def INT_VFRMINDLST : SDNode<"VEISD::INT_VFRMINDLST", VE1OpVVVL>;
def INT_VFRMINSFST : SDNode<"VEISD::INT_VFRMINSFST", VE1OpVVVL>;
def INT_VFRMINSLST : SDNode<"VEISD::INT_VFRMINSLST", VE1OpVVVL>;

//===----------------------------------------------------------------------===//
// 1-op instructions with mask and hidden VL
//===----------------------------------------------------------------------===//

// (v256f64 (VSUMWSX (v256f64 sz), (vNi1 vy), (VLS vl)))

def VE1OpVVMVL :
    SDTypeProfile<1, 3, [SDTCisVec<0>,
                         SDTCisSameAs<1, 0>,
                         SDTCisVec<2>, SDTCVecEltisVT<2, i1>]>;
def INT_VSUMWSX_M : SDNode<"VEISD::INT_VSUMWSX_M", VE1OpVVMVL>;
def INT_VSUMWZX_M : SDNode<"VEISD::INT_VSUMWZX_M", VE1OpVVMVL>;
def INT_VSUML_M : SDNode<"VEISD::INT_VSUML_M", VE1OpVVMVL>;
def INT_VFSUMD_M : SDNode<"VEISD::INT_VFSUMD_M", VE1OpVVMVL>;
def INT_VFSUMS_M : SDNode<"VEISD::INT_VFSUMS_M", VE1OpVVMVL>;

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

// (v256f64 (VRSQRT (v256f64 sz), (vNi1 vy), (v256f64 base), (VLS vl)))

def VE1OpVVMVVL :
    SDTypeProfile<1, 4, [SDTCisVec<0>,
                         SDTCisSameAs<1, 0>,
                         SDTCisVec<2>, SDTCVecEltisVT<2, i1>,
                         SDTCisSameAs<3, 0>]>;
def INT_VFSQRTD_M : SDNode<"VEISD::INT_VFSQRTD_M", VE1OpVVMVVL>;
def INT_VFSQRTS_M : SDNode<"VEISD::INT_VFSQRTS_M", VE1OpVVMVVL>;
def INT_VRSQRTD_M : SDNode<"VEISD::INT_VRSQRTD_M", VE1OpVVMVVL>;
def INT_VRSQRTS_M : SDNode<"VEISD::INT_VRSQRTS_M", VE1OpVVMVVL>;
def INT_PVRSQRT_M : SDNode<"VEISD::INT_PVRSQRT_M", VE1OpVVMVVL>;
def INT_VRCPD_M : SDNode<"VEISD::INT_VRCPD_M", VE1OpVVMVVL>;
def INT_VRCPS_M : SDNode<"VEISD::INT_VRCPS_M", VE1OpVVMVVL>;
def INT_PVRCP_M : SDNode<"VEISD::INT_PVRCP_M", VE1OpVVMVVL>;
def INT_VCVTWDSX_M : SDNode<"VEISD::INT_VCVTWDSX_M", VE1OpVVMVVL>;
def INT_VCVTWDSXRZ_M : SDNode<"VEISD::INT_VCVTWDSXRZ_M", VE1OpVVMVVL>;
def INT_VCVTWDZX_M : SDNode<"VEISD::INT_VCVTWDZX_M", VE1OpVVMVVL>;
def INT_VCVTWDZXRZ_M : SDNode<"VEISD::INT_VCVTWDZXRZ_M", VE1OpVVMVVL>;
def INT_VCVTWSSX_M : SDNode<"VEISD::INT_VCVTWSSX_M", VE1OpVVMVVL>;
def INT_VCVTWSSXRZ_M : SDNode<"VEISD::INT_VCVTWSSXRZ_M", VE1OpVVMVVL>;
def INT_VCVTWSZX_M : SDNode<"VEISD::INT_VCVTWSZX_M", VE1OpVVMVVL>;
def INT_VCVTWSZXRZ_M : SDNode<"VEISD::INT_VCVTWSZXRZ_M", VE1OpVVMVVL>;
def INT_PVCVTWS_M : SDNode<"VEISD::INT_PVCVTWS_M", VE1OpVVMVVL>;
def INT_PVCVTWSRZ_M : SDNode<"VEISD::INT_PVCVTWSRZ_M", VE1OpVVMVVL>;
def INT_VCVTLD_M : SDNode<"VEISD::INT_VCVTLD_M", VE1OpVVMVVL>;
def INT_VCVTLDRZ_M : SDNode<"VEISD::INT_VCVTLDRZ_M", VE1OpVVMVVL>;
def INT_VCP_M : SDNode<"VEISD::INT_VCP_M", VE1OpVVMVVL>;
def INT_VEX_M : SDNode<"VEISD::INT_VEX_M", VE1OpVVMVVL>;

//===----------------------------------------------------------------------===//
// 2-op instructions
//===----------------------------------------------------------------------===//

// (f64 (LVS (v256f64 vz), (i32 sy)))

def VE2OpSVS :
    SDTypeProfile<1, 2, [SDTCisVec<1>, SDTCisInt<2>]>;
def INT_LVS : SDNode<"VEISD::INT_LVS", VE2OpSVS>;

//===----------------------------------------------------------------------===//
// 2-op instruction with base mask and hidden VL
//===----------------------------------------------------------------------===//

// (v256i1 (VFMKL (i64 cf), (v256f64 vz), (VLS vl)))

def VE2OpMSVVL :
    SDTypeProfile<1, 3, [SDTCisVec<0>, SDTCVecEltisVT<0, i1>,
                         SDTCisInt<1>,
                         SDTCisVec<2>]>;
def INT_VFMKL : SDNode<"VEISD::INT_VFMKL", VE2OpMSVVL>;
def INT_VFMKW : SDNode<"VEISD::INT_VFMKW", VE2OpMSVVL>;
def INT_VFMKD : SDNode<"VEISD::INT_VFMKD", VE2OpMSVVL>;
def INT_VFMKS : SDNode<"VEISD::INT_VFMKS", VE2OpMSVVL>;
def INT_PVFMKW : SDNode<"VEISD::INT_PVFMKW", VE2OpMSVVL>;
def INT_PVFMKS : SDNode<"VEISD::INT_PVFMKS", VE2OpMSVVL>;

// (v256i1 (VFMKLM (i64 cf), (v256f64 vz), (v256i1 base), (VLS vl)))

def VE2OpMSVMVL :
    SDTypeProfile<1, 4, [SDTCisVec<0>, SDTCVecEltisVT<0, i1>,
                         SDTCisInt<1>,
                         SDTCisVec<2>,
                         SDTCisSameAs<3, 0>]>;
def INT_VFMKL_M : SDNode<"VEISD::INT_VFMKL_M", VE2OpMSVMVL>;
def INT_VFMKW_M : SDNode<"VEISD::INT_VFMKW_M", VE2OpMSVMVL>;
def INT_VFMKD_M : SDNode<"VEISD::INT_VFMKD_M", VE2OpMSVMVL>;
def INT_VFMKS_M : SDNode<"VEISD::INT_VFMKS_M", VE2OpMSVMVL>;
def INT_PVFMKW_M : SDNode<"VEISD::INT_PVFMKW_M", VE2OpMSVMVL>;
def INT_PVFMKS_M : SDNode<"VEISD::INT_PVFMKS_M", VE2OpMSVMVL>;

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
def INT_VMULUL : SDNode<"VEISD::INT_VMULUL", VE2OpVXVVL>;
def INT_VMULUW : SDNode<"VEISD::INT_VMULUW", VE2OpVXVVL>;
def INT_VMULSWSX : SDNode<"VEISD::INT_VMULSWSX", VE2OpVXVVL>;
def INT_VMULSWZX : SDNode<"VEISD::INT_VMULSWZX", VE2OpVXVVL>;
def INT_VMULSL : SDNode<"VEISD::INT_VMULSL", VE2OpVXVVL>;
def INT_VMULSLW : SDNode<"VEISD::INT_VMULSLW", VE2OpVXVVL>;
def INT_VAND : SDNode<"VEISD::INT_VAND", VE2OpVXVVL>;
def INT_PVAND : SDNode<"VEISD::INT_PVAND", VE2OpVXVVL>;
def INT_VOR : SDNode<"VEISD::INT_VOR", VE2OpVXVVL>;
def INT_PVOR : SDNode<"VEISD::INT_PVOR", VE2OpVXVVL>;
def INT_VXOR : SDNode<"VEISD::INT_VXOR", VE2OpVXVVL>;
def INT_PVXOR : SDNode<"VEISD::INT_PVXOR", VE2OpVXVVL>;
def INT_VEQV : SDNode<"VEISD::INT_VEQV", VE2OpVXVVL>;
def INT_PVEQV : SDNode<"VEISD::INT_PVEQV", VE2OpVXVVL>;
def INT_VMV : SDNode<"VEISD::INT_VMV", VE2OpVXVVL>;
def INT_VFADDD : SDNode<"VEISD::INT_VFADDD", VE2OpVXVVL>;
def INT_VFADDS : SDNode<"VEISD::INT_VFADDS", VE2OpVXVVL>;
def INT_PVFADD : SDNode<"VEISD::INT_PVFADD", VE2OpVXVVL>;
def INT_VFSUBD : SDNode<"VEISD::INT_VFSUBD", VE2OpVXVVL>;
def INT_VFSUBS : SDNode<"VEISD::INT_VFSUBS", VE2OpVXVVL>;
def INT_PVFSUB : SDNode<"VEISD::INT_PVFSUB", VE2OpVXVVL>;
def INT_VFMULD : SDNode<"VEISD::INT_VFMULD", VE2OpVXVVL>;
def INT_VFMULS : SDNode<"VEISD::INT_VFMULS", VE2OpVXVVL>;
def INT_PVFMUL : SDNode<"VEISD::INT_PVFMUL", VE2OpVXVVL>;
def INT_VFDIVD : SDNode<"VEISD::INT_VFDIVD", VE2OpVXVVL>;
def INT_VFDIVS : SDNode<"VEISD::INT_VFDIVS", VE2OpVXVVL>;
def INT_VFCMPD : SDNode<"VEISD::INT_VFCMPD", VE2OpVXVVL>;
def INT_VFCMPS : SDNode<"VEISD::INT_VFCMPS", VE2OpVXVVL>;
def INT_PVFCMP : SDNode<"VEISD::INT_PVFCMP", VE2OpVXVVL>;
def INT_VFMAXD : SDNode<"VEISD::INT_VFMAXD", VE2OpVXVVL>;
def INT_VFMAXS : SDNode<"VEISD::INT_VFMAXS", VE2OpVXVVL>;
def INT_PVFMAX : SDNode<"VEISD::INT_PVFMAX", VE2OpVXVVL>;
def INT_VFMIND : SDNode<"VEISD::INT_VFMIND", VE2OpVXVVL>;
def INT_VFMINS : SDNode<"VEISD::INT_VFMINS", VE2OpVXVVL>;
def INT_PVFMIN : SDNode<"VEISD::INT_PVFMIN", VE2OpVXVVL>;

// Either of 
// (v256f64 (VSRAXvm (v256f64 vy), (v256f64 vz), (VLS vl)))
// (v256f64 (VSRAXrm2 (v256f64 vz), (i64 sy), (VLS vl)))

def VE2OpVVXVL :
    SDTypeProfile<1, 3, [SDTCisVec<0>, 
                         SDTCisSameAs<1, 0>]>;
def INT_VSLL : SDNode<"VEISD::INT_VSLL", VE2OpVVXVL>;
def INT_VSRL : SDNode<"VEISD::INT_VSRL", VE2OpVVXVL>;
def INT_VSLAW : SDNode<"VEISD::INT_VSLAW", VE2OpVVXVL>;
def INT_VSLAL : SDNode<"VEISD::INT_VSLAL", VE2OpVVXVL>;
def INT_VSRAW : SDNode<"VEISD::INT_VSRAW", VE2OpVVXVL>;
def INT_VSRAL : SDNode<"VEISD::INT_VSRAL", VE2OpVVXVL>;
def INT_PVSLL : SDNode<"VEISD::INT_PVSLL", VE2OpVVXVL>;
def INT_PVSRL : SDNode<"VEISD::INT_PVSRL", VE2OpVVXVL>;
def INT_PVSLA : SDNode<"VEISD::INT_PVSLA", VE2OpVVXVL>;
def INT_PVSRA : SDNode<"VEISD::INT_PVSRA", VE2OpVVXVL>;

// Either of 
// (v256f64 (VDVXlrm (v256f64 vy), (v256f64 vz), (VLS vl)))
// (v256f64 (VDVXlim (i64 sy), (v256f64 vz), (VLS vl)))
// (v256f64 (VDVXlim2 (v256f64 vz), (i64 sy), (VLS vl)))

def VE2OpVXXVL :
    SDTypeProfile<1, 3, [SDTCisVec<0>]>;
def INT_VDIVUL : SDNode<"VEISD::INT_VDIVUL", VE2OpVXXVL>;
def INT_VDIVUW : SDNode<"VEISD::INT_VDIVUW", VE2OpVXXVL>;
def INT_VDIVSWSX : SDNode<"VEISD::INT_VDIVSWSX", VE2OpVXXVL>;
def INT_VDIVSWZX : SDNode<"VEISD::INT_VDIVSWZX", VE2OpVXXVL>;
def INT_VDIVSL : SDNode<"VEISD::INT_VDIVSL", VE2OpVXXVL>;

// Either of 
// (v256f64 (VSHFr (v256f64 vy), (v256f64 vz), (I64 sy), (VLS vl)))

def VE2OpVVVXVL :
    SDTypeProfile<1, 4, [SDTCisVec<0>, 
                         SDTCisSameAs<1, 0>,
                         SDTCisSameAs<2, 0>,
                         SDTCisInt<3>]>;
def INT_VSHF : SDNode<"VEISD::INT_VSHF", VE2OpVVVXVL>;

//===----------------------------------------------------------------------===//
// 2-op instructions with mask and hidden VL
//===----------------------------------------------------------------------===//

// Either of 
// (v256f64 (VMRG (v256f64 vy), (v256f64 vz), (v256i1 vm), (VLS vl)))
// (v256f64 (VMRG (i64 sy), (v256f64 vz), (v256i1 vm), (VLS vl)))

def VE2OpVXVMVL :
    SDTypeProfile<1, 4, [SDTCisVec<0>, 
                         SDTCisSameAs<2, 0>,
                         SDTCisVec<3>, SDTCVecEltisVT<3, i1>]>;
def INT_VMV_M : SDNode<"VEISD::INT_VMV_M", VE2OpVXVMVL>;
def INT_VMRG_M : SDNode<"VEISD::INT_VMRG_M", VE2OpVXVMVL>;
def INT_VMRGW_M : SDNode<"VEISD::INT_VMRGW_M", VE2OpVXVMVL>;


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
def INT_VMULUL_M : SDNode<"VEISD::INT_VMULUL_M", VE2OpVXVMVVL>;
def INT_VMULUW_M : SDNode<"VEISD::INT_VMULUW_M", VE2OpVXVMVVL>;
def INT_VMULSWSX_M : SDNode<"VEISD::INT_VMULSWSX_M", VE2OpVXVMVVL>;
def INT_VMULSWZX_M : SDNode<"VEISD::INT_VMULSWZX_M", VE2OpVXVMVVL>;
def INT_VMULSL_M : SDNode<"VEISD::INT_VMULSL_M", VE2OpVXVMVVL>;
def INT_VMULSLW_M : SDNode<"VEISD::INT_VMULSLW_M", VE2OpVXVMVVL>;
def INT_VAND_M : SDNode<"VEISD::INT_VAND_M", VE2OpVXVMVVL>;
def INT_PVAND_M : SDNode<"VEISD::INT_PVAND_M", VE2OpVXVMVVL>;
def INT_VOR_M : SDNode<"VEISD::INT_VOR_M", VE2OpVXVMVVL>;
def INT_PVOR_M : SDNode<"VEISD::INT_PVOR_M", VE2OpVXVMVVL>;
def INT_VXOR_M : SDNode<"VEISD::INT_VXOR_M", VE2OpVXVMVVL>;
def INT_PVXOR_M : SDNode<"VEISD::INT_PVXOR_M", VE2OpVXVMVVL>;
def INT_VEQV_M : SDNode<"VEISD::INT_VEQV_M", VE2OpVXVMVVL>;
def INT_PVEQV_M : SDNode<"VEISD::INT_PVEQV_M", VE2OpVXVMVVL>;
def INT_VFADDD_M : SDNode<"VEISD::INT_VFADDD_M", VE2OpVXVMVVL>;
def INT_VFADDS_M : SDNode<"VEISD::INT_VFADDS_M", VE2OpVXVMVVL>;
def INT_PVFADD_M : SDNode<"VEISD::INT_PVFADD_M", VE2OpVXVMVVL>;
def INT_VFSUBD_M : SDNode<"VEISD::INT_VFSUBD_M", VE2OpVXVMVVL>;
def INT_VFSUBS_M : SDNode<"VEISD::INT_VFSUBS_M", VE2OpVXVMVVL>;
def INT_PVFSUB_M : SDNode<"VEISD::INT_PVFSUB_M", VE2OpVXVMVVL>;
def INT_VFMULD_M : SDNode<"VEISD::INT_VFMULD_M", VE2OpVXVMVVL>;
def INT_VFMULS_M : SDNode<"VEISD::INT_VFMULS_M", VE2OpVXVMVVL>;
def INT_PVFMUL_M : SDNode<"VEISD::INT_PVFMUL_M", VE2OpVXVMVVL>;
def INT_VFDIVD_M : SDNode<"VEISD::INT_VFDIVD_M", VE2OpVXVMVVL>;
def INT_VFDIVS_M : SDNode<"VEISD::INT_VFDIVS_M", VE2OpVXVMVVL>;
def INT_VFCMPD_M : SDNode<"VEISD::INT_VFCMPD_M", VE2OpVXVMVVL>;
def INT_VFCMPS_M : SDNode<"VEISD::INT_VFCMPS_M", VE2OpVXVMVVL>;
def INT_PVFCMP_M : SDNode<"VEISD::INT_PVFCMP_M", VE2OpVXVMVVL>;
def INT_VFMAXD_M : SDNode<"VEISD::INT_VFMAXD_M", VE2OpVXVMVVL>;
def INT_VFMAXS_M : SDNode<"VEISD::INT_VFMAXS_M", VE2OpVXVMVVL>;
def INT_PVFMAX_M : SDNode<"VEISD::INT_PVFMAX_M", VE2OpVXVMVVL>;
def INT_VFMIND_M : SDNode<"VEISD::INT_VFMIND_M", VE2OpVXVMVVL>;
def INT_VFMINS_M : SDNode<"VEISD::INT_VFMINS_M", VE2OpVXVMVVL>;
def INT_PVFMIN_M : SDNode<"VEISD::INT_PVFMIN_M", VE2OpVXVMVVL>;

// Either of 
// (v256f64 (VSRAXvm (v256f64 vy), (v256f64 vz), (v256i1 vm), (v256f64 base),
//                   (VLS vl)))
// (v256f64 (VSRAXrm2 (v256f64 vz), (i64 sy), (v256i1 vm), (v256f64 base),
//                    (VLS vl)))

def VE2OpVVXMVVL :
    SDTypeProfile<1, 5, [SDTCisVec<0>, 
                         SDTCisSameAs<1, 0>,
                         SDTCisVec<3>, SDTCVecEltisVT<3, i1>,
                         SDTCisSameAs<4, 0>]>;
def INT_VSLL_M : SDNode<"VEISD::INT_VSLL_M", VE2OpVVXMVVL>;
def INT_VSRL_M : SDNode<"VEISD::INT_VSRL_M", VE2OpVVXMVVL>;
def INT_VSLAW_M : SDNode<"VEISD::INT_VSLAW_M", VE2OpVVXMVVL>;
def INT_VSLAL_M : SDNode<"VEISD::INT_VSLAL_M", VE2OpVVXMVVL>;
def INT_VSRAW_M : SDNode<"VEISD::INT_VSRAW_M", VE2OpVVXMVVL>;
def INT_VSRAL_M : SDNode<"VEISD::INT_VSRAL_M", VE2OpVVXMVVL>;
def INT_PVSLL_M : SDNode<"VEISD::INT_PVSLL_M", VE2OpVVXMVVL>;
def INT_PVSRL_M : SDNode<"VEISD::INT_PVSRL_M", VE2OpVVXMVVL>;
def INT_PVSLA_M : SDNode<"VEISD::INT_PVSLA_M", VE2OpVVXMVVL>;
def INT_PVSRA_M : SDNode<"VEISD::INT_PVSRA_M", VE2OpVVXMVVL>;

// Either of 
// (v256f64 (VDVXlrm (v256f64 vy), (v256f64 vz), (v256i1 vm), (v256f64 base),
//                   (VLS vl)))
// (v256f64 (VDVXlim (i64 sy), (v256f64 vz), (v256i1 vm), (v256f64 base),
//                   (VLS vl)))
// (v256f64 (VDVXlim2 (v256f64 vz), (i64 sy), (v256i1 vm), (v256f64 base),
//                    (VLS vl)))

def VE2OpVXXMVVL :
    SDTypeProfile<1, 5, [SDTCisVec<0>, 
                         SDTCisVec<3>, SDTCVecEltisVT<3, i1>,
                         SDTCisSameAs<4, 0>]>;
def INT_VDIVUL_M : SDNode<"VEISD::INT_VDIVUL_M", VE2OpVXXMVVL>;
def INT_VDIVUW_M : SDNode<"VEISD::INT_VDIVUW_M", VE2OpVXXMVVL>;
def INT_VDIVSWSX_M : SDNode<"VEISD::INT_VDIVSWSX_M", VE2OpVXXMVVL>;
def INT_VDIVSWZX_M : SDNode<"VEISD::INT_VDIVSWZX_M", VE2OpVXXMVVL>;
def INT_VDIVSL_M : SDNode<"VEISD::INT_VDIVSL_M", VE2OpVXXMVVL>;

//===----------------------------------------------------------------------===//
// 3-op vector instruction
//===----------------------------------------------------------------------===//

// (v256f64 (LSV (v256f64 vz), (i32 sy), (i64 sz)))

def VE3OpVVSS :
    SDTypeProfile<1, 3, [SDTCisVec<0>, 
                         SDTCisSameAs<1, 0>,
                         SDTCisInt<2>, SDTCisInt<3>]>;
def INT_LSV : SDNode<"VEISD::INT_LSV", VE3OpVVSS>;

//===----------------------------------------------------------------------===//
// 3-op vector instruction with hidden VL
//===----------------------------------------------------------------------===//

// Either of 
// (v256f64 (VFMADdvm (v256f64 vy), (v256f64 vz), (v256f64 vw),
//                    (VLS vl)))
// (v256f64 (VFMADdrm (i64 sy), (v256f64 vz), (v256f64 vw),
//                    (VLS vl)))
// (v256f64 (VFMADdr2m (v256f64 vz), (i64 sy), (v256f64 vw),
//                     (VLS vl)))

def VE3OpVXXVVL :
    SDTypeProfile<1, 4, [SDTCisVec<0>, 
                         SDTCisSameAs<3, 0>]>;
def INT_VFMADD : SDNode<"VEISD::INT_VFMADD", VE3OpVXXVVL>;
def INT_VFMADS : SDNode<"VEISD::INT_VFMADS", VE3OpVXXVVL>;
def INT_PVFMAD : SDNode<"VEISD::INT_PVFMAD", VE3OpVXXVVL>;
def INT_VFMSBD : SDNode<"VEISD::INT_VFMSBD", VE3OpVXXVVL>;
def INT_VFMSBS : SDNode<"VEISD::INT_VFMSBS", VE3OpVXXVVL>;
def INT_PVFMSB : SDNode<"VEISD::INT_PVFMSB", VE3OpVXXVVL>;
def INT_VFNMADD : SDNode<"VEISD::INT_VFNMADD", VE3OpVXXVVL>;
def INT_VFNMADS : SDNode<"VEISD::INT_VFNMADS", VE3OpVXXVVL>;
def INT_PVFNMAD : SDNode<"VEISD::INT_PVFNMAD", VE3OpVXXVVL>;
def INT_VFNMSBD : SDNode<"VEISD::INT_VFNMSBD", VE3OpVXXVVL>;
def INT_VFNMSBS : SDNode<"VEISD::INT_VFNMSBS", VE3OpVXXVVL>;
def INT_PVFNMSB : SDNode<"VEISD::INT_PVFNMSB", VE3OpVXXVVL>;

// (v256f64 (VSFArm (v256f64 vz), (i64 sy), (i64 sz), (VLS vl)))

def VE3OpVVSSVL :
    SDTypeProfile<1, 4, [SDTCisVec<0>, 
                         SDTCisSameAs<1, 0>,
                         SDTCisSameAs<3, 2>]>;
def INT_VSFA : SDNode<"VEISD::INT_VSFA", VE3OpVVSSVL>;

//===----------------------------------------------------------------------===//
// 3-op vector instruction with mask, base register, and hidden VL
//===----------------------------------------------------------------------===//

// Either of 
// (v256f64 (VFMADdvm (v256f64 vy), (v256f64 vz), (v256f64 vw),
//                    (v256i1 vm), (v256f64 base), (VLS vl)))
// (v256f64 (VFMADdrm (i64 sy), (v256f64 vz), (v256f64 vw),
//                    (v256i1 vm), (v256f64 base), (VLS vl)))
// (v256f64 (VFMADdr2m (v256f64 vz), (i64 sy), (v256f64 vw),
//                     (v256i1 vm), (v256f64 base), (VLS vl)))

def VE3OpVXXVMVVL :
    SDTypeProfile<1, 6, [SDTCisVec<0>, 
                         SDTCisSameAs<3, 0>,
                         SDTCisVec<4>, SDTCVecEltisVT<4, i1>,
                         SDTCisSameAs<5, 0>]>;
def INT_VFMADD_M : SDNode<"VEISD::INT_VFMADD_M", VE3OpVXXVMVVL>;
def INT_VFMADS_M : SDNode<"VEISD::INT_VFMADS_M", VE3OpVXXVMVVL>;
def INT_PVFMAD_M : SDNode<"VEISD::INT_PVFMAD_M", VE3OpVXXVMVVL>;
def INT_VFMSBD_M : SDNode<"VEISD::INT_VFMSBD_M", VE3OpVXXVMVVL>;
def INT_VFMSBS_M : SDNode<"VEISD::INT_VFMSBS_M", VE3OpVXXVMVVL>;
def INT_PVFMSB_M : SDNode<"VEISD::INT_PVFMSB_M", VE3OpVXXVMVVL>;
def INT_VFNMADD_M : SDNode<"VEISD::INT_VFNMADD_M", VE3OpVXXVMVVL>;
def INT_VFNMADS_M : SDNode<"VEISD::INT_VFNMADS_M", VE3OpVXXVMVVL>;
def INT_PVFNMAD_M : SDNode<"VEISD::INT_PVFNMAD_M", VE3OpVXXVMVVL>;
def INT_VFNMSBD_M : SDNode<"VEISD::INT_VFNMSBD_M", VE3OpVXXVMVVL>;
def INT_VFNMSBS_M : SDNode<"VEISD::INT_VFNMSBS_M", VE3OpVXXVMVVL>;
def INT_PVFNMSB_M : SDNode<"VEISD::INT_PVFNMSB_M", VE3OpVXXVMVVL>;

// (v256f64 (VSFArm (v256f64 vz), (i64 sy), (i64 sz),
//                  (v256i1 vm), (v256f64 base), (VLS vl)))

def VE3OpVVSSMVVL :
    SDTypeProfile<1, 6, [SDTCisVec<0>, 
                         SDTCisSameAs<1, 0>,
                         SDTCisSameAs<3, 2>,
                         SDTCisVec<4>, SDTCVecEltisVT<4, i1>,
                         SDTCisSameAs<5, 0>]>;
def INT_VSFA_M : SDNode<"VEISD::INT_VSFA_M", VE3OpVVSSMVVL>;

