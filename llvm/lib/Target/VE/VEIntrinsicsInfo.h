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
  LVL,
  ADD_VL, CONVM_VL,
  OP_MMXX, OP_XMX,
  OP_M,
  OP_MMM, OP_MM,
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
  VE_INTRINSIC_DATA(lvl,                LVL,        VEISD::INT_LVL, 0),
  VE_INTRINSIC_DATA(vsc_vv,             ADD_VL,     VEISD::INT_VSC, 0),
  VE_INTRINSIC_DATA(vsc_vvm,            CONVM_VL,   VEISD::INT_VSC_M, 0),
  VE_INTRINSIC_DATA(vscl_vv,            ADD_VL,     VEISD::INT_VSCL, 0),
  VE_INTRINSIC_DATA(vscl_vvm,           CONVM_VL,   VEISD::INT_VSCL_M, 0),
  VE_INTRINSIC_DATA(vscu_vv,            ADD_VL,     VEISD::INT_VSCU, 0),
  VE_INTRINSIC_DATA(vscu_vvm,           CONVM_VL,   VEISD::INT_VSCU_M, 0),
  VE_INTRINSIC_DATA(vst_vss,            ADD_VL,     VEISD::INT_VST, 0),
  VE_INTRINSIC_DATA(vst2d_vss,          ADD_VL,     VEISD::INT_VST2D, 0),
  VE_INTRINSIC_DATA(vstl_vss,           ADD_VL,     VEISD::INT_VSTL, 0),
  VE_INTRINSIC_DATA(vstl2d_vss,         ADD_VL,     VEISD::INT_VSTL2D, 0),
  VE_INTRINSIC_DATA(vstu_vss,           ADD_VL,     VEISD::INT_VSTU, 0),
  VE_INTRINSIC_DATA(vstu2d_vss,         ADD_VL,     VEISD::INT_VSTU2D, 0),
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
  VE_INTRINSIC_DATA(vgt_vv,             ADD_VL,     VEISD::INT_VGT, 0),
  VE_INTRINSIC_DATA(vgt_vvm,            CONVM_VL,   VEISD::INT_VGT_M, 0),
  VE_INTRINSIC_DATA(vgtlsx_vv,          ADD_VL,     VEISD::INT_VGTLSX, 0),
  VE_INTRINSIC_DATA(vgtlsx_vvm,         CONVM_VL,   VEISD::INT_VGTLSX_M, 0),
  VE_INTRINSIC_DATA(vgtlzx_vv,          ADD_VL,     VEISD::INT_VGTLZX, 0),
  VE_INTRINSIC_DATA(vgtlzx_vvm,         CONVM_VL,   VEISD::INT_VGTLZX_M, 0),
  VE_INTRINSIC_DATA(vgtu_vv,            ADD_VL,     VEISD::INT_VGTU, 0),
  VE_INTRINSIC_DATA(vgtu_vvm,           CONVM_VL,   VEISD::INT_VGTU_M, 0),
  VE_INTRINSIC_DATA(vld_vss,            ADD_VL,     VEISD::INT_VLD, 0),
  VE_INTRINSIC_DATA(vld2d_vss,          ADD_VL,     VEISD::INT_VLD2D, 0),
  VE_INTRINSIC_DATA(vldl2dsx_vss,       ADD_VL,     VEISD::INT_VLDL2DSX, 0),
  VE_INTRINSIC_DATA(vldl2dzx_vss,       ADD_VL,     VEISD::INT_VLDL2DZX, 0),
  VE_INTRINSIC_DATA(vldlsx_vss,         ADD_VL,     VEISD::INT_VLDLSX, 0),
  VE_INTRINSIC_DATA(vldlzx_vss,         ADD_VL,     VEISD::INT_VLDLZX, 0),
  VE_INTRINSIC_DATA(vldu_vss,           ADD_VL,     VEISD::INT_VLDU, 0),
  VE_INTRINSIC_DATA(vldu2d_vss,         ADD_VL,     VEISD::INT_VLDU2D, 0),
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
  VE_INTRINSIC_DATA(lzvm_sm,            CONVM_VL,   VEISD::INT_LZVM, 0),
  VE_INTRINSIC_DATA(negm_MM,            OP_MM,      VEISD::INT_NEGM, 0),
  VE_INTRINSIC_DATA(negm_mm,            OP_MM,      VEISD::INT_NEGM, 0),
  VE_INTRINSIC_DATA(nndm_MMM,           OP_MMM,     VEISD::INT_NNDM, 0),
  VE_INTRINSIC_DATA(nndm_mmm,           OP_MMM,     VEISD::INT_NNDM, 0),
  VE_INTRINSIC_DATA(orm_MMM,            OP_MMM,     VEISD::INT_ORM, 0),
  VE_INTRINSIC_DATA(orm_mmm,            OP_MMM,     VEISD::INT_ORM, 0),
  VE_INTRINSIC_DATA(pcvm_sm,            CONVM_VL,   VEISD::INT_PCVM, 0),
  VE_INTRINSIC_DATA(pvadds_vsv,         ADD_VL,     VEISD::INT_PVADDS, 0),
  VE_INTRINSIC_DATA(pvadds_vsvMv,       CONVM_VL,   VEISD::INT_PVADDS_M, 0),
  VE_INTRINSIC_DATA(pvadds_vvv,         ADD_VL,     VEISD::INT_PVADDS, 0),
  VE_INTRINSIC_DATA(pvadds_vvvMv,       CONVM_VL,   VEISD::INT_PVADDS_M, 0),
  VE_INTRINSIC_DATA(pvaddu_vsv,         ADD_VL,     VEISD::INT_PVADDU, 0),
  VE_INTRINSIC_DATA(pvaddu_vsvMv,       CONVM_VL,   VEISD::INT_PVADDU_M, 0),
  VE_INTRINSIC_DATA(pvaddu_vvv,         ADD_VL,     VEISD::INT_PVADDU, 0),
  VE_INTRINSIC_DATA(pvaddu_vvvMv,       CONVM_VL,   VEISD::INT_PVADDU_M, 0),
  VE_INTRINSIC_DATA(pvand_vsv,          ADD_VL,     VEISD::INT_PVAND, 0),
  VE_INTRINSIC_DATA(pvand_vsvMv,        CONVM_VL,   VEISD::INT_PVAND_M, 0),
  VE_INTRINSIC_DATA(pvand_vvv,          ADD_VL,     VEISD::INT_PVAND, 0),
  VE_INTRINSIC_DATA(pvand_vvvMv,        CONVM_VL,   VEISD::INT_PVAND_M, 0),
  VE_INTRINSIC_DATA(pvbrd_vs_i64,       ADD_VL,     VEISD::INT_PVBRD, 0),
  VE_INTRINSIC_DATA(pvbrd_vsMv_i64,     CONVM_VL,   VEISD::INT_PVBRD_M, 0),
  VE_INTRINSIC_DATA(pvcmps_vsv,         ADD_VL,     VEISD::INT_PVCMPS, 0),
  VE_INTRINSIC_DATA(pvcmps_vsvMv,       CONVM_VL,   VEISD::INT_PVCMPS_M, 0),
  VE_INTRINSIC_DATA(pvcmps_vvv,         ADD_VL,     VEISD::INT_PVCMPS, 0),
  VE_INTRINSIC_DATA(pvcmps_vvvMv,       CONVM_VL,   VEISD::INT_PVCMPS_M, 0),
  VE_INTRINSIC_DATA(pvcmpu_vsv,         ADD_VL,     VEISD::INT_PVCMPU, 0),
  VE_INTRINSIC_DATA(pvcmpu_vsvMv,       CONVM_VL,   VEISD::INT_PVCMPU_M, 0),
  VE_INTRINSIC_DATA(pvcmpu_vvv,         ADD_VL,     VEISD::INT_PVCMPU, 0),
  VE_INTRINSIC_DATA(pvcmpu_vvvMv,       CONVM_VL,   VEISD::INT_PVCMPU_M, 0),
  VE_INTRINSIC_DATA(pveqv_vsv,          ADD_VL,     VEISD::INT_PVEQV, 0),
  VE_INTRINSIC_DATA(pveqv_vsvMv,        CONVM_VL,   VEISD::INT_PVEQV_M, 0),
  VE_INTRINSIC_DATA(pveqv_vvv,          ADD_VL,     VEISD::INT_PVEQV, 0),
  VE_INTRINSIC_DATA(pveqv_vvvMv,        CONVM_VL,   VEISD::INT_PVEQV_M, 0),
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
  VE_INTRINSIC_DATA(pvmaxs_vsv,         ADD_VL,     VEISD::INT_PVMAXS, 0),
  VE_INTRINSIC_DATA(pvmaxs_vsvMv,       CONVM_VL,   VEISD::INT_PVMAXS_M, 0),
  VE_INTRINSIC_DATA(pvmaxs_vvv,         ADD_VL,     VEISD::INT_PVMAXS, 0),
  VE_INTRINSIC_DATA(pvmaxs_vvvMv,       CONVM_VL,   VEISD::INT_PVMAXS_M, 0),
  VE_INTRINSIC_DATA(pvmins_vsv,         ADD_VL,     VEISD::INT_PVMINS, 0),
  VE_INTRINSIC_DATA(pvmins_vsvMv,       CONVM_VL,   VEISD::INT_PVMINS_M, 0),
  VE_INTRINSIC_DATA(pvmins_vvv,         ADD_VL,     VEISD::INT_PVMINS, 0),
  VE_INTRINSIC_DATA(pvmins_vvvMv,       CONVM_VL,   VEISD::INT_PVMINS_M, 0),
  VE_INTRINSIC_DATA(pvor_vsv,           ADD_VL,     VEISD::INT_PVOR, 0),
  VE_INTRINSIC_DATA(pvor_vsvMv,         CONVM_VL,   VEISD::INT_PVOR_M, 0),
  VE_INTRINSIC_DATA(pvor_vvv,           ADD_VL,     VEISD::INT_PVOR, 0),
  VE_INTRINSIC_DATA(pvor_vvvMv,         CONVM_VL,   VEISD::INT_PVOR_M, 0),
  VE_INTRINSIC_DATA(pvsla_vvsMv,        OP_XXXMX,   VEISD::INT_PVSLA, 0),
  VE_INTRINSIC_DATA(pvsla_vvvMv,        OP_XXXMX,   VEISD::INT_PVSLA, 0),
  VE_INTRINSIC_DATA(pvsll_vvsMv,        OP_XXXMX,   VEISD::INT_PVSLL, 0),
  VE_INTRINSIC_DATA(pvsll_vvvMv,        OP_XXXMX,   VEISD::INT_PVSLL, 0),
  VE_INTRINSIC_DATA(pvsra_vvsMv,        OP_XXXMX,   VEISD::INT_PVSRA, 0),
  VE_INTRINSIC_DATA(pvsra_vvvMv,        OP_XXXMX,   VEISD::INT_PVSRA, 0),
  VE_INTRINSIC_DATA(pvsrl_vvsMv,        OP_XXXMX,   VEISD::INT_PVSRL, 0),
  VE_INTRINSIC_DATA(pvsrl_vvvMv,        OP_XXXMX,   VEISD::INT_PVSRL, 0),
  VE_INTRINSIC_DATA(pvsubs_vsv,         ADD_VL,     VEISD::INT_PVSUBS, 0),
  VE_INTRINSIC_DATA(pvsubs_vsvMv,       CONVM_VL,   VEISD::INT_PVSUBS_M, 0),
  VE_INTRINSIC_DATA(pvsubs_vvv,         ADD_VL,     VEISD::INT_PVSUBS, 0),
  VE_INTRINSIC_DATA(pvsubs_vvvMv,       CONVM_VL,   VEISD::INT_PVSUBS_M, 0),
  VE_INTRINSIC_DATA(pvsubu_vsv,         ADD_VL,     VEISD::INT_PVSUBU, 0),
  VE_INTRINSIC_DATA(pvsubu_vsvMv,       CONVM_VL,   VEISD::INT_PVSUBU_M, 0),
  VE_INTRINSIC_DATA(pvsubu_vvv,         ADD_VL,     VEISD::INT_PVSUBU, 0),
  VE_INTRINSIC_DATA(pvsubu_vvvMv,       CONVM_VL,   VEISD::INT_PVSUBU_M, 0),
  VE_INTRINSIC_DATA(pvxor_vsv,          ADD_VL,     VEISD::INT_PVXOR, 0),
  VE_INTRINSIC_DATA(pvxor_vsvMv,        CONVM_VL,   VEISD::INT_PVXOR_M, 0),
  VE_INTRINSIC_DATA(pvxor_vvv,          ADD_VL,     VEISD::INT_PVXOR, 0),
  VE_INTRINSIC_DATA(pvxor_vvvMv,        CONVM_VL,   VEISD::INT_PVXOR_M, 0),
  VE_INTRINSIC_DATA(svm_sMs,            OP_XMX,     VEISD::INT_SVM, 0),
  VE_INTRINSIC_DATA(svm_sms,            OP_XMX,     VEISD::INT_SVM, 0),
  VE_INTRINSIC_DATA(tovm_sm,            CONVM_VL,   VEISD::INT_TOVM, 0),
  VE_INTRINSIC_DATA(vaddsl_vsv,         ADD_VL,     VEISD::INT_VADDSL, 0),
  VE_INTRINSIC_DATA(vaddsl_vsvmv,       CONVM_VL,   VEISD::INT_VADDSL_M, 0),
  VE_INTRINSIC_DATA(vaddsl_vvv,         ADD_VL,     VEISD::INT_VADDSL, 0),
  VE_INTRINSIC_DATA(vaddsl_vvvmv,       CONVM_VL,   VEISD::INT_VADDSL_M, 0),
  VE_INTRINSIC_DATA(vaddswsx_vsv,       ADD_VL,     VEISD::INT_VADDSWSX, 0),
  VE_INTRINSIC_DATA(vaddswsx_vsvmv,     CONVM_VL,   VEISD::INT_VADDSWSX_M, 0),
  VE_INTRINSIC_DATA(vaddswsx_vvv,       ADD_VL,     VEISD::INT_VADDSWSX, 0),
  VE_INTRINSIC_DATA(vaddswsx_vvvmv,     CONVM_VL,   VEISD::INT_VADDSWSX_M, 0),
  VE_INTRINSIC_DATA(vaddswzx_vsv,       ADD_VL,     VEISD::INT_VADDSWZX, 0),
  VE_INTRINSIC_DATA(vaddswzx_vsvmv,     CONVM_VL,   VEISD::INT_VADDSWZX_M, 0),
  VE_INTRINSIC_DATA(vaddswzx_vvv,       ADD_VL,     VEISD::INT_VADDSWZX, 0),
  VE_INTRINSIC_DATA(vaddswzx_vvvmv,     CONVM_VL,   VEISD::INT_VADDSWZX_M, 0),
  VE_INTRINSIC_DATA(vaddul_vsv,         ADD_VL,     VEISD::INT_VADDUL, 0),
  VE_INTRINSIC_DATA(vaddul_vsvmv,       CONVM_VL,   VEISD::INT_VADDUL_M, 0),
  VE_INTRINSIC_DATA(vaddul_vvv,         ADD_VL,     VEISD::INT_VADDUL, 0),
  VE_INTRINSIC_DATA(vaddul_vvvmv,       CONVM_VL,   VEISD::INT_VADDUL_M, 0),
  VE_INTRINSIC_DATA(vadduw_vsv,         ADD_VL,     VEISD::INT_VADDUW, 0),
  VE_INTRINSIC_DATA(vadduw_vsvmv,       CONVM_VL,   VEISD::INT_VADDUW_M, 0),
  VE_INTRINSIC_DATA(vadduw_vvv,         ADD_VL,     VEISD::INT_VADDUW, 0),
  VE_INTRINSIC_DATA(vadduw_vvvmv,       CONVM_VL,   VEISD::INT_VADDUW_M, 0),
  VE_INTRINSIC_DATA(vand_vsv,           ADD_VL,     VEISD::INT_VAND, 0),
  VE_INTRINSIC_DATA(vand_vsvmv,         CONVM_VL,   VEISD::INT_VAND_M, 0),
  VE_INTRINSIC_DATA(vand_vvv,           ADD_VL,     VEISD::INT_VAND, 0),
  VE_INTRINSIC_DATA(vand_vvvmv,         CONVM_VL,   VEISD::INT_VAND_M, 0),
  VE_INTRINSIC_DATA(vbrd_vs_f64,        ADD_VL,     VEISD::INT_VBRD, 0),
  VE_INTRINSIC_DATA(vbrd_vs_i64,        ADD_VL,     VEISD::INT_VBRD, 0),
  VE_INTRINSIC_DATA(vbrd_vsmv_f64,      CONVM_VL,   VEISD::INT_VBRD_M, 0),
  VE_INTRINSIC_DATA(vbrd_vsmv_i64,      CONVM_VL,   VEISD::INT_VBRD_M, 0),
  VE_INTRINSIC_DATA(vbrdl_vs_i32,       ADD_VL,     VEISD::INT_VBRDL, 0),
  VE_INTRINSIC_DATA(vbrdl_vsmv_i32,     CONVM_VL,   VEISD::INT_VBRDL_M, 0),
  VE_INTRINSIC_DATA(vbrdu_vs_f32,       ADD_VL,     VEISD::INT_VBRDU, 0),
  VE_INTRINSIC_DATA(vbrdu_vsmv_f32,     CONVM_VL,   VEISD::INT_VBRDU_M, 0),
  VE_INTRINSIC_DATA(vcmpsl_vsv,         ADD_VL,     VEISD::INT_VCMPSL, 0),
  VE_INTRINSIC_DATA(vcmpsl_vsvmv,       CONVM_VL,   VEISD::INT_VCMPSL_M, 0),
  VE_INTRINSIC_DATA(vcmpsl_vvv,         ADD_VL,     VEISD::INT_VCMPSL, 0),
  VE_INTRINSIC_DATA(vcmpsl_vvvmv,       CONVM_VL,   VEISD::INT_VCMPSL_M, 0),
  VE_INTRINSIC_DATA(vcmpswsx_vsv,       ADD_VL,     VEISD::INT_VCMPSWSX, 0),
  VE_INTRINSIC_DATA(vcmpswsx_vsvmv,     CONVM_VL,   VEISD::INT_VCMPSWSX_M, 0),
  VE_INTRINSIC_DATA(vcmpswsx_vvv,       ADD_VL,     VEISD::INT_VCMPSWSX, 0),
  VE_INTRINSIC_DATA(vcmpswsx_vvvmv,     CONVM_VL,   VEISD::INT_VCMPSWSX_M, 0),
  VE_INTRINSIC_DATA(vcmpswzx_vsv,       ADD_VL,     VEISD::INT_VCMPSWZX, 0),
  VE_INTRINSIC_DATA(vcmpswzx_vsvmv,     CONVM_VL,   VEISD::INT_VCMPSWZX_M, 0),
  VE_INTRINSIC_DATA(vcmpswzx_vvv,       ADD_VL,     VEISD::INT_VCMPSWZX, 0),
  VE_INTRINSIC_DATA(vcmpswzx_vvvmv,     CONVM_VL,   VEISD::INT_VCMPSWZX_M, 0),
  VE_INTRINSIC_DATA(vcmpul_vsv,         ADD_VL,     VEISD::INT_VCMPUL, 0),
  VE_INTRINSIC_DATA(vcmpul_vsvmv,       CONVM_VL,   VEISD::INT_VCMPUL_M, 0),
  VE_INTRINSIC_DATA(vcmpul_vvv,         ADD_VL,     VEISD::INT_VCMPUL, 0),
  VE_INTRINSIC_DATA(vcmpul_vvvmv,       CONVM_VL,   VEISD::INT_VCMPUL_M, 0),
  VE_INTRINSIC_DATA(vcmpuw_vsv,         ADD_VL,     VEISD::INT_VCMPUW, 0),
  VE_INTRINSIC_DATA(vcmpuw_vsvmv,       CONVM_VL,   VEISD::INT_VCMPUW_M, 0),
  VE_INTRINSIC_DATA(vcmpuw_vvv,         ADD_VL,     VEISD::INT_VCMPUW, 0),
  VE_INTRINSIC_DATA(vcmpuw_vvvmv,       CONVM_VL,   VEISD::INT_VCMPUW_M, 0),
  VE_INTRINSIC_DATA(vcp_vvmv,           OP_XXMX,    VEISD::INT_VCP, 0),
  VE_INTRINSIC_DATA(vdivsl_vsv,         ADD_VL,     VEISD::INT_VDIVSL, 0),
  VE_INTRINSIC_DATA(vdivsl_vsvmv,       CONVM_VL,   VEISD::INT_VDIVSL_M, 0),
  VE_INTRINSIC_DATA(vdivsl_vvs,         ADD_VL,     VEISD::INT_VDIVSL, 0),
  VE_INTRINSIC_DATA(vdivsl_vvsmv,       CONVM_VL,   VEISD::INT_VDIVSL_M, 0),
  VE_INTRINSIC_DATA(vdivsl_vvv,         ADD_VL,     VEISD::INT_VDIVSL, 0),
  VE_INTRINSIC_DATA(vdivsl_vvvmv,       CONVM_VL,   VEISD::INT_VDIVSL_M, 0),
  VE_INTRINSIC_DATA(vdivswsx_vsv,       ADD_VL,     VEISD::INT_VDIVSWSX, 0),
  VE_INTRINSIC_DATA(vdivswsx_vsvmv,     CONVM_VL,   VEISD::INT_VDIVSWSX_M, 0),
  VE_INTRINSIC_DATA(vdivswsx_vvs,       ADD_VL,     VEISD::INT_VDIVSWSX, 0),
  VE_INTRINSIC_DATA(vdivswsx_vvsmv,     CONVM_VL,   VEISD::INT_VDIVSWSX_M, 0),
  VE_INTRINSIC_DATA(vdivswsx_vvv,       ADD_VL,     VEISD::INT_VDIVSWSX, 0),
  VE_INTRINSIC_DATA(vdivswsx_vvvmv,     CONVM_VL,   VEISD::INT_VDIVSWSX_M, 0),
  VE_INTRINSIC_DATA(vdivswzx_vsv,       ADD_VL,     VEISD::INT_VDIVSWZX, 0),
  VE_INTRINSIC_DATA(vdivswzx_vsvmv,     CONVM_VL,   VEISD::INT_VDIVSWZX_M, 0),
  VE_INTRINSIC_DATA(vdivswzx_vvs,       ADD_VL,     VEISD::INT_VDIVSWZX, 0),
  VE_INTRINSIC_DATA(vdivswzx_vvsmv,     CONVM_VL,   VEISD::INT_VDIVSWZX_M, 0),
  VE_INTRINSIC_DATA(vdivswzx_vvv,       ADD_VL,     VEISD::INT_VDIVSWZX, 0),
  VE_INTRINSIC_DATA(vdivswzx_vvvmv,     CONVM_VL,   VEISD::INT_VDIVSWZX_M, 0),
  VE_INTRINSIC_DATA(vdivul_vsv,         ADD_VL,     VEISD::INT_VDIVUL, 0),
  VE_INTRINSIC_DATA(vdivul_vsvmv,       CONVM_VL,   VEISD::INT_VDIVUL_M, 0),
  VE_INTRINSIC_DATA(vdivul_vvs,         ADD_VL,     VEISD::INT_VDIVUL, 0),
  VE_INTRINSIC_DATA(vdivul_vvsmv,       CONVM_VL,   VEISD::INT_VDIVUL_M, 0),
  VE_INTRINSIC_DATA(vdivul_vvv,         ADD_VL,     VEISD::INT_VDIVUL, 0),
  VE_INTRINSIC_DATA(vdivul_vvvmv,       CONVM_VL,   VEISD::INT_VDIVUL_M, 0),
  VE_INTRINSIC_DATA(vdivuw_vsv,         ADD_VL,     VEISD::INT_VDIVUW, 0),
  VE_INTRINSIC_DATA(vdivuw_vsvmv,       CONVM_VL,   VEISD::INT_VDIVUW_M, 0),
  VE_INTRINSIC_DATA(vdivuw_vvs,         ADD_VL,     VEISD::INT_VDIVUW, 0),
  VE_INTRINSIC_DATA(vdivuw_vvsmv,       CONVM_VL,   VEISD::INT_VDIVUW_M, 0),
  VE_INTRINSIC_DATA(vdivuw_vvv,         ADD_VL,     VEISD::INT_VDIVUW, 0),
  VE_INTRINSIC_DATA(vdivuw_vvvmv,       CONVM_VL,   VEISD::INT_VDIVUW_M, 0),
  VE_INTRINSIC_DATA(veqv_vsv,           ADD_VL,     VEISD::INT_VEQV, 0),
  VE_INTRINSIC_DATA(veqv_vsvmv,         CONVM_VL,   VEISD::INT_VEQV_M, 0),
  VE_INTRINSIC_DATA(veqv_vvv,           ADD_VL,     VEISD::INT_VEQV, 0),
  VE_INTRINSIC_DATA(veqv_vvvmv,         CONVM_VL,   VEISD::INT_VEQV_M, 0),
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
  VE_INTRINSIC_DATA(vmaxsl_vsv,         ADD_VL,     VEISD::INT_VMAXSL, 0),
  VE_INTRINSIC_DATA(vmaxsl_vsvmv,       CONVM_VL,   VEISD::INT_VMAXSL_M, 0),
  VE_INTRINSIC_DATA(vmaxsl_vvv,         ADD_VL,     VEISD::INT_VMAXSL, 0),
  VE_INTRINSIC_DATA(vmaxsl_vvvmv,       CONVM_VL,   VEISD::INT_VMAXSL_M, 0),
  VE_INTRINSIC_DATA(vmaxswsx_vsv,       ADD_VL,     VEISD::INT_VMAXSWSX, 0),
  VE_INTRINSIC_DATA(vmaxswsx_vsvmv,     CONVM_VL,   VEISD::INT_VMAXSWSX_M, 0),
  VE_INTRINSIC_DATA(vmaxswsx_vvv,       ADD_VL,     VEISD::INT_VMAXSWSX, 0),
  VE_INTRINSIC_DATA(vmaxswsx_vvvmv,     CONVM_VL,   VEISD::INT_VMAXSWSX_M, 0),
  VE_INTRINSIC_DATA(vmaxswzx_vsv,       ADD_VL,     VEISD::INT_VMAXSWZX, 0),
  VE_INTRINSIC_DATA(vmaxswzx_vsvmv,     CONVM_VL,   VEISD::INT_VMAXSWZX_M, 0),
  VE_INTRINSIC_DATA(vmaxswzx_vvv,       ADD_VL,     VEISD::INT_VMAXSWZX, 0),
  VE_INTRINSIC_DATA(vmaxswzx_vvvmv,     CONVM_VL,   VEISD::INT_VMAXSWZX_M, 0),
  VE_INTRINSIC_DATA(vminsl_vsv,         ADD_VL,     VEISD::INT_VMINSL, 0),
  VE_INTRINSIC_DATA(vminsl_vsvmv,       CONVM_VL,   VEISD::INT_VMINSL_M, 0),
  VE_INTRINSIC_DATA(vminsl_vvv,         ADD_VL,     VEISD::INT_VMINSL, 0),
  VE_INTRINSIC_DATA(vminsl_vvvmv,       CONVM_VL,   VEISD::INT_VMINSL_M, 0),
  VE_INTRINSIC_DATA(vminswsx_vsv,       ADD_VL,     VEISD::INT_VMINSWSX, 0),
  VE_INTRINSIC_DATA(vminswsx_vsvmv,     CONVM_VL,   VEISD::INT_VMINSWSX_M, 0),
  VE_INTRINSIC_DATA(vminswsx_vvv,       ADD_VL,     VEISD::INT_VMINSWSX, 0),
  VE_INTRINSIC_DATA(vminswsx_vvvmv,     CONVM_VL,   VEISD::INT_VMINSWSX_M, 0),
  VE_INTRINSIC_DATA(vminswzx_vsv,       ADD_VL,     VEISD::INT_VMINSWZX, 0),
  VE_INTRINSIC_DATA(vminswzx_vsvmv,     CONVM_VL,   VEISD::INT_VMINSWZX_M, 0),
  VE_INTRINSIC_DATA(vminswzx_vvv,       ADD_VL,     VEISD::INT_VMINSWZX, 0),
  VE_INTRINSIC_DATA(vminswzx_vvvmv,     CONVM_VL,   VEISD::INT_VMINSWZX_M, 0),
  VE_INTRINSIC_DATA(vmrg_vvvm,          OP_XXXM,    VEISD::INT_VMRG, 0),
  VE_INTRINSIC_DATA(vmrgw_vvvM,         OP_XXXM,    VEISD::INT_VMRGW, 0),
  VE_INTRINSIC_DATA(vmulsl_vsv,         ADD_VL,     VEISD::INT_VMULSL, 0),
  VE_INTRINSIC_DATA(vmulsl_vsvmv,       CONVM_VL,   VEISD::INT_VMULSL_M, 0),
  VE_INTRINSIC_DATA(vmulsl_vvv,         ADD_VL,     VEISD::INT_VMULSL, 0),
  VE_INTRINSIC_DATA(vmulsl_vvvmv,       CONVM_VL,   VEISD::INT_VMULSL_M, 0),
  VE_INTRINSIC_DATA(vmulslw_vsv,        ADD_VL,     VEISD::INT_VMULSLW, 0),
  VE_INTRINSIC_DATA(vmulslw_vvv,        ADD_VL,     VEISD::INT_VMULSLW, 0),
  VE_INTRINSIC_DATA(vmulswsx_vsv,       ADD_VL,     VEISD::INT_VMULSWSX, 0),
  VE_INTRINSIC_DATA(vmulswsx_vsvmv,     CONVM_VL,   VEISD::INT_VMULSWSX_M, 0),
  VE_INTRINSIC_DATA(vmulswsx_vvv,       ADD_VL,     VEISD::INT_VMULSWSX, 0),
  VE_INTRINSIC_DATA(vmulswsx_vvvmv,     CONVM_VL,   VEISD::INT_VMULSWSX_M, 0),
  VE_INTRINSIC_DATA(vmulswzx_vsv,       ADD_VL,     VEISD::INT_VMULSWZX, 0),
  VE_INTRINSIC_DATA(vmulswzx_vsvmv,     CONVM_VL,   VEISD::INT_VMULSWZX_M, 0),
  VE_INTRINSIC_DATA(vmulswzx_vvv,       ADD_VL,     VEISD::INT_VMULSWZX, 0),
  VE_INTRINSIC_DATA(vmulswzx_vvvmv,     CONVM_VL,   VEISD::INT_VMULSWZX_M, 0),
  VE_INTRINSIC_DATA(vmulul_vsv,         ADD_VL,     VEISD::INT_VMULUL, 0),
  VE_INTRINSIC_DATA(vmulul_vsvmv,       CONVM_VL,   VEISD::INT_VMULUL_M, 0),
  VE_INTRINSIC_DATA(vmulul_vvv,         ADD_VL,     VEISD::INT_VMULUL, 0),
  VE_INTRINSIC_DATA(vmulul_vvvmv,       CONVM_VL,   VEISD::INT_VMULUL_M, 0),
  VE_INTRINSIC_DATA(vmuluw_vsv,         ADD_VL,     VEISD::INT_VMULUW, 0),
  VE_INTRINSIC_DATA(vmuluw_vsvmv,       CONVM_VL,   VEISD::INT_VMULUW_M, 0),
  VE_INTRINSIC_DATA(vmuluw_vvv,         ADD_VL,     VEISD::INT_VMULUW, 0),
  VE_INTRINSIC_DATA(vmuluw_vvvmv,       CONVM_VL,   VEISD::INT_VMULUW_M, 0),
  VE_INTRINSIC_DATA(vmv_vsv,            ADD_VL,     VEISD::INT_VMV, 0),
  VE_INTRINSIC_DATA(vor_vsv,            ADD_VL,     VEISD::INT_VOR, 0),
  VE_INTRINSIC_DATA(vor_vsvmv,          CONVM_VL,   VEISD::INT_VOR_M, 0),
  VE_INTRINSIC_DATA(vor_vvv,            ADD_VL,     VEISD::INT_VOR, 0),
  VE_INTRINSIC_DATA(vor_vvvmv,          CONVM_VL,   VEISD::INT_VOR_M, 0),
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
  VE_INTRINSIC_DATA(vsubsl_vsv,         ADD_VL,     VEISD::INT_VSUBSL, 0),
  VE_INTRINSIC_DATA(vsubsl_vsvmv,       CONVM_VL,   VEISD::INT_VSUBSL_M, 0),
  VE_INTRINSIC_DATA(vsubsl_vvv,         ADD_VL,     VEISD::INT_VSUBSL, 0),
  VE_INTRINSIC_DATA(vsubsl_vvvmv,       CONVM_VL,   VEISD::INT_VSUBSL_M, 0),
  VE_INTRINSIC_DATA(vsubswsx_vsv,       ADD_VL,     VEISD::INT_VSUBSWSX, 0),
  VE_INTRINSIC_DATA(vsubswsx_vsvmv,     CONVM_VL,   VEISD::INT_VSUBSWSX_M, 0),
  VE_INTRINSIC_DATA(vsubswsx_vvv,       ADD_VL,     VEISD::INT_VSUBSWSX, 0),
  VE_INTRINSIC_DATA(vsubswsx_vvvmv,     CONVM_VL,   VEISD::INT_VSUBSWSX_M, 0),
  VE_INTRINSIC_DATA(vsubswzx_vsv,       ADD_VL,     VEISD::INT_VSUBSWZX, 0),
  VE_INTRINSIC_DATA(vsubswzx_vsvmv,     CONVM_VL,   VEISD::INT_VSUBSWZX_M, 0),
  VE_INTRINSIC_DATA(vsubswzx_vvv,       ADD_VL,     VEISD::INT_VSUBSWZX, 0),
  VE_INTRINSIC_DATA(vsubswzx_vvvmv,     CONVM_VL,   VEISD::INT_VSUBSWZX_M, 0),
  VE_INTRINSIC_DATA(vsubul_vsv,         ADD_VL,     VEISD::INT_VSUBUL, 0),
  VE_INTRINSIC_DATA(vsubul_vsvmv,       CONVM_VL,   VEISD::INT_VSUBUL_M, 0),
  VE_INTRINSIC_DATA(vsubul_vvv,         ADD_VL,     VEISD::INT_VSUBUL, 0),
  VE_INTRINSIC_DATA(vsubul_vvvmv,       CONVM_VL,   VEISD::INT_VSUBUL_M, 0),
  VE_INTRINSIC_DATA(vsubuw_vsv,         ADD_VL,     VEISD::INT_VSUBUW, 0),
  VE_INTRINSIC_DATA(vsubuw_vsvmv,       CONVM_VL,   VEISD::INT_VSUBUW_M, 0),
  VE_INTRINSIC_DATA(vsubuw_vvv,         ADD_VL,     VEISD::INT_VSUBUW, 0),
  VE_INTRINSIC_DATA(vsubuw_vvvmv,       CONVM_VL,   VEISD::INT_VSUBUW_M, 0),
  VE_INTRINSIC_DATA(vxor_vsv,           ADD_VL,     VEISD::INT_VXOR, 0),
  VE_INTRINSIC_DATA(vxor_vsvmv,         CONVM_VL,   VEISD::INT_VXOR_M, 0),
  VE_INTRINSIC_DATA(vxor_vvv,           ADD_VL,     VEISD::INT_VXOR, 0),
  VE_INTRINSIC_DATA(vxor_vvvmv,         CONVM_VL,   VEISD::INT_VXOR_M, 0),
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
