//===-- VEIntrinsicsInfo.h - VE Intrinsics ----------------------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the details for lowering VE intrinsics
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_VE_VEINTRINSICSINFO_H
#define LLVM_LIB_TARGET_VE_VEINTRINSICSINFO_H

#include "VEISelLowering.h"
#include "VEInstrInfo.h"

namespace llvm {

enum IntrinsicType : uint16_t {
  GATHER_M, SCATTER_M,
  OP_MMXX, OP_XMX,
  OP_M,
  OP_MMM, OP_MM, OP_XM,
  OP_XXMX,
  OP_XXXM,
  OP_XXXMX,
  OP_XXXXMX,
  OP_MXX, OP_MXXM,
};

struct IntrinsicData {

  uint16_t      Id;
  IntrinsicType Type;
  uint16_t      Opc0;
  uint16_t      Opc1;

  bool operator<(const IntrinsicData &RHS) const {
    return Id < RHS.Id;
  }
  bool operator==(const IntrinsicData &RHS) const {
    return RHS.Id == Id;
  }
  friend bool operator<(const IntrinsicData &LHS, unsigned Id) {
    return LHS.Id < Id;
  }
};

#define VE_INTRINSIC_DATA(id, type, op0, op1) \
  { Intrinsic::ve_##id, type, op0, op1 }

/*
 * IntrinsicsVoid - the table should be sorted by Intrinsic ID - in
 * the alphabetical order.
 */
static const IntrinsicData IntrinsicsVoid[] = {
  VE_INTRINSIC_DATA(vsc_vvm,            SCATTER_M,  VEISD::INT_VSC_M, 0),
  VE_INTRINSIC_DATA(vscl_vvm,           SCATTER_M,  VEISD::INT_VSCL_M, 0),
  VE_INTRINSIC_DATA(vscu_vvm,           SCATTER_M,  VEISD::INT_VSCU_M, 0),
};

/*
 * Find Intrinsic data by intrinsic ID
 */
static const IntrinsicData* getIntrinsicVoid(unsigned IntNo) {
  const IntrinsicData *Data =  std::lower_bound(std::begin(IntrinsicsVoid),
                                                std::end(IntrinsicsVoid),
                                                IntNo);
  if (Data != std::end(IntrinsicsVoid) && Data->Id == IntNo)
    return Data;
  return nullptr;
}

/*
 * IntrinsicsWithChain - the table should be sorted by Intrinsic ID - in
 * the alphabetical order.
 */
static const IntrinsicData IntrinsicsWithChain[] = {
  VE_INTRINSIC_DATA(vgt_vvm,            GATHER_M,   VEISD::INT_VGT_M, 0),
  VE_INTRINSIC_DATA(vgtlsx_vvm,         GATHER_M,   VEISD::INT_VGTLSX_M, 0),
  VE_INTRINSIC_DATA(vgtlzx_vvm,         GATHER_M,   VEISD::INT_VGTLZX_M, 0),
  VE_INTRINSIC_DATA(vgtu_vvm,           GATHER_M,   VEISD::INT_VGTU_M, 0),
};

/*
 * Find Intrinsic data by intrinsic ID
 */
static const IntrinsicData* getIntrinsicWithChain(unsigned IntNo) {
  const IntrinsicData *Data =  std::lower_bound(std::begin(IntrinsicsWithChain),
                                                std::end(IntrinsicsWithChain),
                                                IntNo);
  if (Data != std::end(IntrinsicsWithChain) && Data->Id == IntNo)
    return Data;
  return nullptr;
}

/*
 * IntrinsicsWithoutChain - the table should be sorted by Intrinsic ID - in
 * the alphabetical order.
 */
static const IntrinsicData  IntrinsicsWithoutChain[] = {
  VE_INTRINSIC_DATA(andm_MMM,           OP_MMM,     VEISD::INT_ANDM, 0),
  VE_INTRINSIC_DATA(andm_mmm,           OP_MMM,     VEISD::INT_ANDM, 0),
  VE_INTRINSIC_DATA(eqvm_MMM,           OP_MMM,     VEISD::INT_EQVM, 0),
  VE_INTRINSIC_DATA(eqvm_mmm,           OP_MMM,     VEISD::INT_EQVM, 0),
  VE_INTRINSIC_DATA(extract_vm512l,     OP_MM,      VEISD::INT_EXTML, 0),
  VE_INTRINSIC_DATA(extract_vm512u,     OP_MM,      VEISD::INT_EXTMU, 0),
  VE_INTRINSIC_DATA(insert_vm512l,      OP_MMM,     VEISD::INT_INSML, 0),
  VE_INTRINSIC_DATA(insert_vm512u,      OP_MMM,     VEISD::INT_INSMU, 0),
  VE_INTRINSIC_DATA(lvm_MMss,           OP_MMXX,    VEISD::INT_LVM, 0),
  VE_INTRINSIC_DATA(lvm_mmss,           OP_MMXX,    VEISD::INT_LVM, 0),
  VE_INTRINSIC_DATA(lzvm_sm,            OP_XM,      VEISD::INT_LZVM, 0),
  VE_INTRINSIC_DATA(negm_MM,            OP_MM,      VEISD::INT_NEGM, 0),
  VE_INTRINSIC_DATA(negm_mm,            OP_MM,      VEISD::INT_NEGM, 0),
  VE_INTRINSIC_DATA(nndm_MMM,           OP_MMM,     VEISD::INT_NNDM, 0),
  VE_INTRINSIC_DATA(nndm_mmm,           OP_MMM,     VEISD::INT_NNDM, 0),
  VE_INTRINSIC_DATA(orm_MMM,            OP_MMM,     VEISD::INT_ORM, 0),
  VE_INTRINSIC_DATA(orm_mmm,            OP_MMM,     VEISD::INT_ORM, 0),
  VE_INTRINSIC_DATA(pcvm_sm,            OP_XM,      VEISD::INT_PCVM, 0),
  VE_INTRINSIC_DATA(pvadds_vsvMv,       OP_XXXMX,   VEISD::INT_PVADDS, 0),
  VE_INTRINSIC_DATA(pvadds_vvvMv,       OP_XXXMX,   VEISD::INT_PVADDS, 0),
  VE_INTRINSIC_DATA(pvaddu_vsvMv,       OP_XXXMX,   VEISD::INT_PVADDU, 0),
  VE_INTRINSIC_DATA(pvaddu_vvvMv,       OP_XXXMX,   VEISD::INT_PVADDU, 0),
  VE_INTRINSIC_DATA(pvand_vsvMv,        OP_XXXMX,   VEISD::INT_PVAND, 0),
  VE_INTRINSIC_DATA(pvand_vvvMv,        OP_XXXMX,   VEISD::INT_PVAND, 0),
  VE_INTRINSIC_DATA(pvbrd_vsMv_i64,     OP_XXMX,    VEISD::INT_PVBRD, 0),
  VE_INTRINSIC_DATA(pvcmps_vsvMv,       OP_XXXMX,   VEISD::INT_PVCMPS, 0),
  VE_INTRINSIC_DATA(pvcmps_vvvMv,       OP_XXXMX,   VEISD::INT_PVCMPS, 0),
  VE_INTRINSIC_DATA(pvcmpu_vsvMv,       OP_XXXMX,   VEISD::INT_PVCMPU, 0),
  VE_INTRINSIC_DATA(pvcmpu_vvvMv,       OP_XXXMX,   VEISD::INT_PVCMPU, 0),
  VE_INTRINSIC_DATA(pveqv_vsvMv,        OP_XXXMX,   VEISD::INT_PVEQV, 0),
  VE_INTRINSIC_DATA(pveqv_vvvMv,        OP_XXXMX,   VEISD::INT_PVEQV, 0),
  VE_INTRINSIC_DATA(pvfadd_vsvMv,       OP_XXXMX,   VEISD::INT_PVFADD, 0),
  VE_INTRINSIC_DATA(pvfadd_vvvMv,       OP_XXXMX,   VEISD::INT_PVFADD, 0),
  VE_INTRINSIC_DATA(pvfcmp_vsvMv,       OP_XXXMX,   VEISD::INT_PVFCMP, 0),
  VE_INTRINSIC_DATA(pvfcmp_vvvMv,       OP_XXXMX,   VEISD::INT_PVFCMP, 0),
  VE_INTRINSIC_DATA(pvfmad_vsvvMv,      OP_XXXXMX,  VEISD::INT_PVFMAD, 0),
  VE_INTRINSIC_DATA(pvfmad_vvsvMv,      OP_XXXXMX,  VEISD::INT_PVFMAD, 0),
  VE_INTRINSIC_DATA(pvfmad_vvvvMv,      OP_XXXXMX,  VEISD::INT_PVFMAD, 0),
  VE_INTRINSIC_DATA(pvfmax_vsvMv,       OP_XXXMX,   VEISD::INT_PVFMAX, 0),
  VE_INTRINSIC_DATA(pvfmax_vvvMv,       OP_XXXMX,   VEISD::INT_PVFMAX, 0),
  VE_INTRINSIC_DATA(pvfmin_vsvMv,       OP_XXXMX,   VEISD::INT_PVFMIN, 0),
  VE_INTRINSIC_DATA(pvfmin_vvvMv,       OP_XXXMX,   VEISD::INT_PVFMIN, 0),
  VE_INTRINSIC_DATA(pvfmkaf_M,          OP_M,       VEISD::INT_PVFMKAF, 0),
  VE_INTRINSIC_DATA(pvfmkat_M,          OP_M,       VEISD::INT_PVFMKAT, 0),
  VE_INTRINSIC_DATA(pvfmks_Mcv,         OP_MXX,     VEISD::INT_PVFMKS, 0),
  VE_INTRINSIC_DATA(pvfmks_McvM,        OP_MXXM,    VEISD::INT_PVFMKS_M, 0),
  VE_INTRINSIC_DATA(pvfmkw_Mcv,         OP_MXX,     VEISD::INT_PVFMKW, 0),
  VE_INTRINSIC_DATA(pvfmkw_McvM,        OP_MXXM,    VEISD::INT_PVFMKW_M, 0),
  VE_INTRINSIC_DATA(pvfmsb_vsvvMv,      OP_XXXXMX,  VEISD::INT_PVFMSB, 0),
  VE_INTRINSIC_DATA(pvfmsb_vvsvMv,      OP_XXXXMX,  VEISD::INT_PVFMSB, 0),
  VE_INTRINSIC_DATA(pvfmsb_vvvvMv,      OP_XXXXMX,  VEISD::INT_PVFMSB, 0),
  VE_INTRINSIC_DATA(pvfmul_vsvMv,       OP_XXXMX,   VEISD::INT_PVFMUL, 0),
  VE_INTRINSIC_DATA(pvfmul_vvvMv,       OP_XXXMX,   VEISD::INT_PVFMUL, 0),
  VE_INTRINSIC_DATA(pvfnmad_vsvvMv,     OP_XXXXMX,  VEISD::INT_PVFNMAD, 0),
  VE_INTRINSIC_DATA(pvfnmad_vvsvMv,     OP_XXXXMX,  VEISD::INT_PVFNMAD, 0),
  VE_INTRINSIC_DATA(pvfnmad_vvvvMv,     OP_XXXXMX,  VEISD::INT_PVFNMAD, 0),
  VE_INTRINSIC_DATA(pvfnmsb_vsvvMv,     OP_XXXXMX,  VEISD::INT_PVFNMSB, 0),
  VE_INTRINSIC_DATA(pvfnmsb_vvsvMv,     OP_XXXXMX,  VEISD::INT_PVFNMSB, 0),
  VE_INTRINSIC_DATA(pvfnmsb_vvvvMv,     OP_XXXXMX,  VEISD::INT_PVFNMSB, 0),
  VE_INTRINSIC_DATA(pvfsub_vsvMv,       OP_XXXMX,   VEISD::INT_PVFSUB, 0),
  VE_INTRINSIC_DATA(pvfsub_vvvMv,       OP_XXXMX,   VEISD::INT_PVFSUB, 0),
  VE_INTRINSIC_DATA(pvmaxs_vsvMv,       OP_XXXMX,   VEISD::INT_PVMAXS, 0),
  VE_INTRINSIC_DATA(pvmaxs_vvvMv,       OP_XXXMX,   VEISD::INT_PVMAXS, 0),
  VE_INTRINSIC_DATA(pvmins_vsvMv,       OP_XXXMX,   VEISD::INT_PVMINS, 0),
  VE_INTRINSIC_DATA(pvmins_vvvMv,       OP_XXXMX,   VEISD::INT_PVMINS, 0),
  VE_INTRINSIC_DATA(pvor_vsvMv,         OP_XXXMX,   VEISD::INT_PVOR, 0),
  VE_INTRINSIC_DATA(pvor_vvvMv,         OP_XXXMX,   VEISD::INT_PVOR, 0),
  VE_INTRINSIC_DATA(pvsla_vvsMv,        OP_XXXMX,   VEISD::INT_PVSLA, 0),
  VE_INTRINSIC_DATA(pvsla_vvvMv,        OP_XXXMX,   VEISD::INT_PVSLA, 0),
  VE_INTRINSIC_DATA(pvsll_vvsMv,        OP_XXXMX,   VEISD::INT_PVSLL, 0),
  VE_INTRINSIC_DATA(pvsll_vvvMv,        OP_XXXMX,   VEISD::INT_PVSLL, 0),
  VE_INTRINSIC_DATA(pvsra_vvsMv,        OP_XXXMX,   VEISD::INT_PVSRA, 0),
  VE_INTRINSIC_DATA(pvsra_vvvMv,        OP_XXXMX,   VEISD::INT_PVSRA, 0),
  VE_INTRINSIC_DATA(pvsrl_vvsMv,        OP_XXXMX,   VEISD::INT_PVSRL, 0),
  VE_INTRINSIC_DATA(pvsrl_vvvMv,        OP_XXXMX,   VEISD::INT_PVSRL, 0),
  VE_INTRINSIC_DATA(pvsubs_vsvMv,       OP_XXXMX,   VEISD::INT_PVSUBS, 0),
  VE_INTRINSIC_DATA(pvsubs_vvvMv,       OP_XXXMX,   VEISD::INT_PVSUBS, 0),
  VE_INTRINSIC_DATA(pvsubu_vsvMv,       OP_XXXMX,   VEISD::INT_PVSUBU, 0),
  VE_INTRINSIC_DATA(pvsubu_vvvMv,       OP_XXXMX,   VEISD::INT_PVSUBU, 0),
  VE_INTRINSIC_DATA(pvxor_vsvMv,        OP_XXXMX,   VEISD::INT_PVXOR, 0),
  VE_INTRINSIC_DATA(pvxor_vvvMv,        OP_XXXMX,   VEISD::INT_PVXOR, 0),
  VE_INTRINSIC_DATA(svm_sMs,            OP_XMX,     VEISD::INT_SVM, 0),
  VE_INTRINSIC_DATA(svm_sms,            OP_XMX,     VEISD::INT_SVM, 0),
  VE_INTRINSIC_DATA(tovm_sm,            OP_XM,      VEISD::INT_TOVM, 0),
  VE_INTRINSIC_DATA(vaddsl_vsvmv,       OP_XXXMX,   VEISD::INT_VADDSL, 0),
  VE_INTRINSIC_DATA(vaddsl_vvvmv,       OP_XXXMX,   VEISD::INT_VADDSL, 0),
  VE_INTRINSIC_DATA(vaddswsx_vsvmv,     OP_XXXMX,   VEISD::INT_VADDSWSX, 0),
  VE_INTRINSIC_DATA(vaddswsx_vvvmv,     OP_XXXMX,   VEISD::INT_VADDSWSX, 0),
  VE_INTRINSIC_DATA(vaddswzx_vsvmv,     OP_XXXMX,   VEISD::INT_VADDSWZX, 0),
  VE_INTRINSIC_DATA(vaddswzx_vvvmv,     OP_XXXMX,   VEISD::INT_VADDSWZX, 0),
  VE_INTRINSIC_DATA(vaddul_vsvmv,       OP_XXXMX,   VEISD::INT_VADDUL, 0),
  VE_INTRINSIC_DATA(vaddul_vvvmv,       OP_XXXMX,   VEISD::INT_VADDUL, 0),
  VE_INTRINSIC_DATA(vadduw_vsvmv,       OP_XXXMX,   VEISD::INT_VADDUW, 0),
  VE_INTRINSIC_DATA(vadduw_vvvmv,       OP_XXXMX,   VEISD::INT_VADDUW, 0),
  VE_INTRINSIC_DATA(vand_vsvmv,         OP_XXXMX,   VEISD::INT_VAND, 0),
  VE_INTRINSIC_DATA(vand_vvvmv,         OP_XXXMX,   VEISD::INT_VAND, 0),
  VE_INTRINSIC_DATA(vbrd_vsmv_f64,      OP_XXMX,    VEISD::INT_VBRD, 0),
  VE_INTRINSIC_DATA(vbrd_vsmv_i64,      OP_XXMX,    VEISD::INT_VBRD, 0),
  VE_INTRINSIC_DATA(vbrdl_vsmv_i32,     OP_XXMX,    VEISD::INT_VBRDL, 0),
  VE_INTRINSIC_DATA(vbrdu_vsmv_f32,     OP_XXMX,    VEISD::INT_VBRDU, 0),
  VE_INTRINSIC_DATA(vcmpsl_vsvmv,       OP_XXXMX,   VEISD::INT_VCMPSL, 0),
  VE_INTRINSIC_DATA(vcmpsl_vvvmv,       OP_XXXMX,   VEISD::INT_VCMPSL, 0),
  VE_INTRINSIC_DATA(vcmpswsx_vsvmv,     OP_XXXMX,   VEISD::INT_VCMPSWSX, 0),
  VE_INTRINSIC_DATA(vcmpswsx_vvvmv,     OP_XXXMX,   VEISD::INT_VCMPSWSX, 0),
  VE_INTRINSIC_DATA(vcmpswzx_vsvmv,     OP_XXXMX,   VEISD::INT_VCMPSWZX, 0),
  VE_INTRINSIC_DATA(vcmpswzx_vvvmv,     OP_XXXMX,   VEISD::INT_VCMPSWZX, 0),
  VE_INTRINSIC_DATA(vcmpul_vsvmv,       OP_XXXMX,   VEISD::INT_VCMPUL, 0),
  VE_INTRINSIC_DATA(vcmpul_vvvmv,       OP_XXXMX,   VEISD::INT_VCMPUL, 0),
  VE_INTRINSIC_DATA(vcmpuw_vsvmv,       OP_XXXMX,   VEISD::INT_VCMPUW, 0),
  VE_INTRINSIC_DATA(vcmpuw_vvvmv,       OP_XXXMX,   VEISD::INT_VCMPUW, 0),
  VE_INTRINSIC_DATA(vcp_vvmv,           OP_XXMX,    VEISD::INT_VCP, 0),
  VE_INTRINSIC_DATA(vdivsl_vsvmv,       OP_XXXMX,   VEISD::INT_VDIVSL, 0),
  VE_INTRINSIC_DATA(vdivsl_vvsmv,       OP_XXXMX,   VEISD::INT_VDIVSL, 0),
  VE_INTRINSIC_DATA(vdivsl_vvvmv,       OP_XXXMX,   VEISD::INT_VDIVSL, 0),
  VE_INTRINSIC_DATA(vdivswsx_vsvmv,     OP_XXXMX,   VEISD::INT_VDIVSWSX, 0),
  VE_INTRINSIC_DATA(vdivswsx_vvsmv,     OP_XXXMX,   VEISD::INT_VDIVSWSX, 0),
  VE_INTRINSIC_DATA(vdivswsx_vvvmv,     OP_XXXMX,   VEISD::INT_VDIVSWSX, 0),
  VE_INTRINSIC_DATA(vdivswzx_vsvmv,     OP_XXXMX,   VEISD::INT_VDIVSWZX, 0),
  VE_INTRINSIC_DATA(vdivswzx_vvsmv,     OP_XXXMX,   VEISD::INT_VDIVSWZX, 0),
  VE_INTRINSIC_DATA(vdivswzx_vvvmv,     OP_XXXMX,   VEISD::INT_VDIVSWZX, 0),
  VE_INTRINSIC_DATA(vdivul_vsvmv,       OP_XXXMX,   VEISD::INT_VDIVUL, 0),
  VE_INTRINSIC_DATA(vdivul_vvsmv,       OP_XXXMX,   VEISD::INT_VDIVUL, 0),
  VE_INTRINSIC_DATA(vdivul_vvvmv,       OP_XXXMX,   VEISD::INT_VDIVUL, 0),
  VE_INTRINSIC_DATA(vdivuw_vsvmv,       OP_XXXMX,   VEISD::INT_VDIVUW, 0),
  VE_INTRINSIC_DATA(vdivuw_vvsmv,       OP_XXXMX,   VEISD::INT_VDIVUW, 0),
  VE_INTRINSIC_DATA(vdivuw_vvvmv,       OP_XXXMX,   VEISD::INT_VDIVUW, 0),
  VE_INTRINSIC_DATA(veqv_vsvmv,         OP_XXXMX,   VEISD::INT_VEQV, 0),
  VE_INTRINSIC_DATA(veqv_vvvmv,         OP_XXXMX,   VEISD::INT_VEQV, 0),
  VE_INTRINSIC_DATA(vex_vvmv,           OP_XXMX,    VEISD::INT_VEX, 0),
  VE_INTRINSIC_DATA(vfaddd_vsvmv,       OP_XXXMX,   VEISD::INT_VFADDD, 0),
  VE_INTRINSIC_DATA(vfaddd_vvvmv,       OP_XXXMX,   VEISD::INT_VFADDD, 0),
  VE_INTRINSIC_DATA(vfadds_vsvmv,       OP_XXXMX,   VEISD::INT_VFADDS, 0),
  VE_INTRINSIC_DATA(vfadds_vvvmv,       OP_XXXMX,   VEISD::INT_VFADDS, 0),
  VE_INTRINSIC_DATA(vfcmpd_vsvmv,       OP_XXXMX,   VEISD::INT_VFCMPD, 0),
  VE_INTRINSIC_DATA(vfcmpd_vvvmv,       OP_XXXMX,   VEISD::INT_VFCMPD, 0),
  VE_INTRINSIC_DATA(vfcmps_vsvmv,       OP_XXXMX,   VEISD::INT_VFCMPS, 0),
  VE_INTRINSIC_DATA(vfcmps_vvvmv,       OP_XXXMX,   VEISD::INT_VFCMPS, 0),
  VE_INTRINSIC_DATA(vfdivd_vsvmv,       OP_XXXMX,   VEISD::INT_VFDIVD, 0),
  VE_INTRINSIC_DATA(vfdivd_vvvmv,       OP_XXXMX,   VEISD::INT_VFDIVD, 0),
  VE_INTRINSIC_DATA(vfdivs_vsvmv,       OP_XXXMX,   VEISD::INT_VFDIVS, 0),
  VE_INTRINSIC_DATA(vfdivs_vvvmv,       OP_XXXMX,   VEISD::INT_VFDIVS, 0),
  VE_INTRINSIC_DATA(vfmadd_vsvvmv,      OP_XXXXMX,  VEISD::INT_VFMADD, 0),
  VE_INTRINSIC_DATA(vfmadd_vvsvmv,      OP_XXXXMX,  VEISD::INT_VFMADD, 0),
  VE_INTRINSIC_DATA(vfmadd_vvvvmv,      OP_XXXXMX,  VEISD::INT_VFMADD, 0),
  VE_INTRINSIC_DATA(vfmads_vsvvmv,      OP_XXXXMX,  VEISD::INT_VFMADS, 0),
  VE_INTRINSIC_DATA(vfmads_vvsvmv,      OP_XXXXMX,  VEISD::INT_VFMADS, 0),
  VE_INTRINSIC_DATA(vfmads_vvvvmv,      OP_XXXXMX,  VEISD::INT_VFMADS, 0),
  VE_INTRINSIC_DATA(vfmaxd_vsvmv,       OP_XXXMX,   VEISD::INT_VFMAXD, 0),
  VE_INTRINSIC_DATA(vfmaxd_vvvmv,       OP_XXXMX,   VEISD::INT_VFMAXD, 0),
  VE_INTRINSIC_DATA(vfmaxs_vsvmv,       OP_XXXMX,   VEISD::INT_VFMAXS, 0),
  VE_INTRINSIC_DATA(vfmaxs_vvvmv,       OP_XXXMX,   VEISD::INT_VFMAXS, 0),
  VE_INTRINSIC_DATA(vfmind_vsvmv,       OP_XXXMX,   VEISD::INT_VFMIND, 0),
  VE_INTRINSIC_DATA(vfmind_vvvmv,       OP_XXXMX,   VEISD::INT_VFMIND, 0),
  VE_INTRINSIC_DATA(vfmins_vsvmv,       OP_XXXMX,   VEISD::INT_VFMINS, 0),
  VE_INTRINSIC_DATA(vfmins_vvvmv,       OP_XXXMX,   VEISD::INT_VFMINS, 0),
  VE_INTRINSIC_DATA(vfmkaf_m,           OP_M,       VEISD::INT_VFMKAF, 0),
  VE_INTRINSIC_DATA(vfmkat_m,           OP_M,       VEISD::INT_VFMKAT, 0),
  VE_INTRINSIC_DATA(vfmkd_mcv,          OP_MXX,     VEISD::INT_VFMKD, 0),
  VE_INTRINSIC_DATA(vfmkd_mcvm,         OP_MXXM,    VEISD::INT_VFMKD_M, 0),
  VE_INTRINSIC_DATA(vfmkl_mcv,          OP_MXX,     VEISD::INT_VFMKL, 0),
  VE_INTRINSIC_DATA(vfmkl_mcvm,         OP_MXXM,    VEISD::INT_VFMKL_M, 0),
  VE_INTRINSIC_DATA(vfmks_mcv,          OP_MXX,     VEISD::INT_VFMKS, 0),
  VE_INTRINSIC_DATA(vfmks_mcvm,         OP_MXXM,    VEISD::INT_VFMKS_M, 0),
  VE_INTRINSIC_DATA(vfmkw_mcv,          OP_MXX,     VEISD::INT_VFMKW, 0),
  VE_INTRINSIC_DATA(vfmkw_mcvm,         OP_MXXM,    VEISD::INT_VFMKW_M, 0),
  VE_INTRINSIC_DATA(vfmsbd_vsvvmv,      OP_XXXXMX,  VEISD::INT_VFMSBD, 0),
  VE_INTRINSIC_DATA(vfmsbd_vvsvmv,      OP_XXXXMX,  VEISD::INT_VFMSBD, 0),
  VE_INTRINSIC_DATA(vfmsbd_vvvvmv,      OP_XXXXMX,  VEISD::INT_VFMSBD, 0),
  VE_INTRINSIC_DATA(vfmsbs_vsvvmv,      OP_XXXXMX,  VEISD::INT_VFMSBS, 0),
  VE_INTRINSIC_DATA(vfmsbs_vvsvmv,      OP_XXXXMX,  VEISD::INT_VFMSBS, 0),
  VE_INTRINSIC_DATA(vfmsbs_vvvvmv,      OP_XXXXMX,  VEISD::INT_VFMSBS, 0),
  VE_INTRINSIC_DATA(vfmuld_vsvmv,       OP_XXXMX,   VEISD::INT_VFMULD, 0),
  VE_INTRINSIC_DATA(vfmuld_vvvmv,       OP_XXXMX,   VEISD::INT_VFMULD, 0),
  VE_INTRINSIC_DATA(vfmuls_vsvmv,       OP_XXXMX,   VEISD::INT_VFMULS, 0),
  VE_INTRINSIC_DATA(vfmuls_vvvmv,       OP_XXXMX,   VEISD::INT_VFMULS, 0),
  VE_INTRINSIC_DATA(vfnmadd_vsvvmv,     OP_XXXXMX,  VEISD::INT_VFNMADD, 0),
  VE_INTRINSIC_DATA(vfnmadd_vvsvmv,     OP_XXXXMX,  VEISD::INT_VFNMADD, 0),
  VE_INTRINSIC_DATA(vfnmadd_vvvvmv,     OP_XXXXMX,  VEISD::INT_VFNMADD, 0),
  VE_INTRINSIC_DATA(vfnmads_vsvvmv,     OP_XXXXMX,  VEISD::INT_VFNMADS, 0),
  VE_INTRINSIC_DATA(vfnmads_vvsvmv,     OP_XXXXMX,  VEISD::INT_VFNMADS, 0),
  VE_INTRINSIC_DATA(vfnmads_vvvvmv,     OP_XXXXMX,  VEISD::INT_VFNMADS, 0),
  VE_INTRINSIC_DATA(vfnmsbd_vsvvmv,     OP_XXXXMX,  VEISD::INT_VFNMSBD, 0),
  VE_INTRINSIC_DATA(vfnmsbd_vvsvmv,     OP_XXXXMX,  VEISD::INT_VFNMSBD, 0),
  VE_INTRINSIC_DATA(vfnmsbd_vvvvmv,     OP_XXXXMX,  VEISD::INT_VFNMSBD, 0),
  VE_INTRINSIC_DATA(vfnmsbs_vsvvmv,     OP_XXXXMX,  VEISD::INT_VFNMSBS, 0),
  VE_INTRINSIC_DATA(vfnmsbs_vvsvmv,     OP_XXXXMX,  VEISD::INT_VFNMSBS, 0),
  VE_INTRINSIC_DATA(vfnmsbs_vvvvmv,     OP_XXXXMX,  VEISD::INT_VFNMSBS, 0),
  VE_INTRINSIC_DATA(vfsubd_vsvmv,       OP_XXXMX,   VEISD::INT_VFSUBD, 0),
  VE_INTRINSIC_DATA(vfsubd_vvvmv,       OP_XXXMX,   VEISD::INT_VFSUBD, 0),
  VE_INTRINSIC_DATA(vfsubs_vsvmv,       OP_XXXMX,   VEISD::INT_VFSUBS, 0),
  VE_INTRINSIC_DATA(vfsubs_vvvmv,       OP_XXXMX,   VEISD::INT_VFSUBS, 0),
  VE_INTRINSIC_DATA(vmaxsl_vsvmv,       OP_XXXMX,   VEISD::INT_VMAXSL, 0),
  VE_INTRINSIC_DATA(vmaxsl_vvvmv,       OP_XXXMX,   VEISD::INT_VMAXSL, 0),
  VE_INTRINSIC_DATA(vmaxswsx_vsvmv,     OP_XXXMX,   VEISD::INT_VMAXSWSX, 0),
  VE_INTRINSIC_DATA(vmaxswsx_vvvmv,     OP_XXXMX,   VEISD::INT_VMAXSWSX, 0),
  VE_INTRINSIC_DATA(vmaxswzx_vsvmv,     OP_XXXMX,   VEISD::INT_VMAXSWZX, 0),
  VE_INTRINSIC_DATA(vmaxswzx_vvvmv,     OP_XXXMX,   VEISD::INT_VMAXSWZX, 0),
  VE_INTRINSIC_DATA(vminsl_vsvmv,       OP_XXXMX,   VEISD::INT_VMINSL, 0),
  VE_INTRINSIC_DATA(vminsl_vvvmv,       OP_XXXMX,   VEISD::INT_VMINSL, 0),
  VE_INTRINSIC_DATA(vminswsx_vsvmv,     OP_XXXMX,   VEISD::INT_VMINSWSX, 0),
  VE_INTRINSIC_DATA(vminswsx_vvvmv,     OP_XXXMX,   VEISD::INT_VMINSWSX, 0),
  VE_INTRINSIC_DATA(vminswzx_vsvmv,     OP_XXXMX,   VEISD::INT_VMINSWZX, 0),
  VE_INTRINSIC_DATA(vminswzx_vvvmv,     OP_XXXMX,   VEISD::INT_VMINSWZX, 0),
  VE_INTRINSIC_DATA(vmrg_vvvm,          OP_XXXM,    VEISD::INT_VMRG, 0),
  VE_INTRINSIC_DATA(vmrgw_vvvM,         OP_XXXM,    VEISD::INT_VMRGW, 0),
  VE_INTRINSIC_DATA(vmulsl_vsvmv,       OP_XXXMX,   VEISD::INT_VMULSL, 0),
  VE_INTRINSIC_DATA(vmulsl_vvvmv,       OP_XXXMX,   VEISD::INT_VMULSL, 0),
  VE_INTRINSIC_DATA(vmulswsx_vsvmv,     OP_XXXMX,   VEISD::INT_VMULSWSX, 0),
  VE_INTRINSIC_DATA(vmulswsx_vvvmv,     OP_XXXMX,   VEISD::INT_VMULSWSX, 0),
  VE_INTRINSIC_DATA(vmulswzx_vsvmv,     OP_XXXMX,   VEISD::INT_VMULSWZX, 0),
  VE_INTRINSIC_DATA(vmulswzx_vvvmv,     OP_XXXMX,   VEISD::INT_VMULSWZX, 0),
  VE_INTRINSIC_DATA(vmulul_vsvmv,       OP_XXXMX,   VEISD::INT_VMULUL, 0),
  VE_INTRINSIC_DATA(vmulul_vvvmv,       OP_XXXMX,   VEISD::INT_VMULUL, 0),
  VE_INTRINSIC_DATA(vmuluw_vsvmv,       OP_XXXMX,   VEISD::INT_VMULUW, 0),
  VE_INTRINSIC_DATA(vmuluw_vvvmv,       OP_XXXMX,   VEISD::INT_VMULUW, 0),
  VE_INTRINSIC_DATA(vor_vsvmv,          OP_XXXMX,   VEISD::INT_VOR, 0),
  VE_INTRINSIC_DATA(vor_vvvmv,          OP_XXXMX,   VEISD::INT_VOR, 0),
  VE_INTRINSIC_DATA(vsfa_vvssmv,        OP_XXXXMX,  VEISD::INT_VSFA, 0),
  VE_INTRINSIC_DATA(vslal_vvsmv,        OP_XXXMX,   VEISD::INT_VSLAL, 0),
  VE_INTRINSIC_DATA(vslal_vvvmv,        OP_XXXMX,   VEISD::INT_VSLAL, 0),
  VE_INTRINSIC_DATA(vslaw_vvsmv,        OP_XXXMX,   VEISD::INT_VSLAW, 0),
  VE_INTRINSIC_DATA(vslaw_vvvmv,        OP_XXXMX,   VEISD::INT_VSLAW, 0),
  VE_INTRINSIC_DATA(vsll_vvsmv,         OP_XXXMX,   VEISD::INT_VSLL, 0),
  VE_INTRINSIC_DATA(vsll_vvvmv,         OP_XXXMX,   VEISD::INT_VSLL, 0),
  VE_INTRINSIC_DATA(vsral_vvsmv,        OP_XXXMX,   VEISD::INT_VSRAL, 0),
  VE_INTRINSIC_DATA(vsral_vvvmv,        OP_XXXMX,   VEISD::INT_VSRAL, 0),
  VE_INTRINSIC_DATA(vsraw_vvsmv,        OP_XXXMX,   VEISD::INT_VSRAW, 0),
  VE_INTRINSIC_DATA(vsraw_vvvmv,        OP_XXXMX,   VEISD::INT_VSRAW, 0),
  VE_INTRINSIC_DATA(vsrl_vvsmv,         OP_XXXMX,   VEISD::INT_VSRL, 0),
  VE_INTRINSIC_DATA(vsrl_vvvmv,         OP_XXXMX,   VEISD::INT_VSRL, 0),
  VE_INTRINSIC_DATA(vsubsl_vsvmv,       OP_XXXMX,   VEISD::INT_VSUBSL, 0),
  VE_INTRINSIC_DATA(vsubsl_vvvmv,       OP_XXXMX,   VEISD::INT_VSUBSL, 0),
  VE_INTRINSIC_DATA(vsubswsx_vsvmv,     OP_XXXMX,   VEISD::INT_VSUBSWSX, 0),
  VE_INTRINSIC_DATA(vsubswsx_vvvmv,     OP_XXXMX,   VEISD::INT_VSUBSWSX, 0),
  VE_INTRINSIC_DATA(vsubswzx_vsvmv,     OP_XXXMX,   VEISD::INT_VSUBSWZX, 0),
  VE_INTRINSIC_DATA(vsubswzx_vvvmv,     OP_XXXMX,   VEISD::INT_VSUBSWZX, 0),
  VE_INTRINSIC_DATA(vsubul_vsvmv,       OP_XXXMX,   VEISD::INT_VSUBUL, 0),
  VE_INTRINSIC_DATA(vsubul_vvvmv,       OP_XXXMX,   VEISD::INT_VSUBUL, 0),
  VE_INTRINSIC_DATA(vsubuw_vsvmv,       OP_XXXMX,   VEISD::INT_VSUBUW, 0),
  VE_INTRINSIC_DATA(vsubuw_vvvmv,       OP_XXXMX,   VEISD::INT_VSUBUW, 0),
  VE_INTRINSIC_DATA(vxor_vsvmv,         OP_XXXMX,   VEISD::INT_VXOR, 0),
  VE_INTRINSIC_DATA(vxor_vvvmv,         OP_XXXMX,   VEISD::INT_VXOR, 0),
  VE_INTRINSIC_DATA(xorm_MMM,           OP_MMM,     VEISD::INT_XORM, 0),
  VE_INTRINSIC_DATA(xorm_mmm,           OP_MMM,     VEISD::INT_XORM, 0),
};

/*
 * Retrieve data for Intrinsic without chain.
 * Return nullptr if intrinsic is not defined in the table.
 */
static const IntrinsicData* getIntrinsicWithoutChain(unsigned IntNo) {
  const IntrinsicData *Data = std::lower_bound(std::begin(IntrinsicsWithoutChain),
                                               std::end(IntrinsicsWithoutChain),
                                               IntNo);
  if (Data != std::end(IntrinsicsWithoutChain) && Data->Id == IntNo)
    return Data;
  return nullptr;
}

static void verifyIntrinsicTables() {
  assert(std::is_sorted(std::begin(IntrinsicsWithoutChain),
                        std::end(IntrinsicsWithoutChain)) &&
         std::is_sorted(std::begin(IntrinsicsWithChain),
                        std::end(IntrinsicsWithChain)) &&
         std::is_sorted(std::begin(IntrinsicsVoid),
                        std::end(IntrinsicsVoid)) &&
         "Intrinsic data tables should be sorted by Intrinsic ID");
  assert((std::adjacent_find(std::begin(IntrinsicsWithoutChain),
                             std::end(IntrinsicsWithoutChain)) ==
          std::end(IntrinsicsWithoutChain)) &&
         (std::adjacent_find(std::begin(IntrinsicsWithChain),
                             std::end(IntrinsicsWithChain)) ==
          std::end(IntrinsicsWithChain)) &&
         (std::adjacent_find(std::begin(IntrinsicsVoid),
                             std::end(IntrinsicsVoid)) ==
          std::end(IntrinsicsVoid)) &&
         "Intrinsic data tables should have unique entries");
}
} // End llvm namespace

#endif
