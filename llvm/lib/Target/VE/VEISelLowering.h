//===-- VEISelLowering.h - VE DAG Lowering Interface ------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file defines the interfaces that VE uses to lower LLVM code into a
// selection DAG.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_VE_VEISELLOWERING_H
#define LLVM_LIB_TARGET_VE_VEISELLOWERING_H

#include "VE.h"
#include "llvm/CodeGen/TargetLowering.h"

namespace llvm {
  class VESubtarget;

  namespace VEISD {
    enum NodeType : unsigned {
      FIRST_NUMBER = ISD::BUILTIN_OP_END,
      CMPICC,      // Compare two GPR operands, set icc+xcc.
      CMPFCC,      // Compare two FP operands, set fcc.
      BRICC,       // Branch to dest on icc condition
      BRXCC,       // Branch to dest on xcc condition (64-bit only).
      BRFCC,       // Branch to dest on fcc condition
      SELECT,
      SELECT_ICC,  // Select between two values using the current ICC flags.
      SELECT_XCC,  // Select between two values using the current XCC flags.
      SELECT_FCC,  // Select between two values using the current FCC flags.

      EH_SJLJ_SETJMP,           // SjLj exception handling setjmp.
      EH_SJLJ_LONGJMP,          // SjLj exception handling longjmp.
      EH_SJLJ_SETUP_DISPATCH,   // SjLj exception handling setup_dispatch.

      Hi, Lo,      // Hi/Lo operations, typically on a global address.

      FTOI,        // FP to Int within a FP register.
      ITOF,        // Int to FP within a FP register.
      FTOX,        // FP to Int64 within a FP register.
      XTOF,        // Int64 to FP within a FP register.

      MAX,
      MIN,
      FMAX,
      FMIN,

      GETFUNPLT,   // load function address through %plt insturction
      GETSTACKTOP, // retrieve address of stack top (first address of
                   // locals and temporaries)
      GETTLSADDR,  // load address for TLS access

      MEMBARRIER,  // Compiler barrier only; generate a no-op.

      CALL,        // A call instruction.
      RET_FLAG,    // Return with a flag operand.
      GLOBAL_BASE_REG, // Global base reg for PIC.
      FLUSHW,      // FLUSH register windows to stack.

      VEC_BROADCAST,   // a scalar value is broadcast across all vector lanes (Operand 0: the broadcast register)
      VEC_SEQ,         // sequence vector match (Operand 0: the constant stride)

      VEC_VMV,

      /// Scatter and gather instructions.
      VEC_GATHER,
      VEC_SCATTER,

      VEC_LVL,

      /// A wrapper node for TargetConstantPool, TargetJumpTable,
      /// TargetExternalSymbol, TargetGlobalAddress, TargetGlobalTLSAddress,
      /// MCSymbol and TargetBlockAddress.
      Wrapper,

#ifdef OBSOLETE_VE_INTRIN
      // Intrinsics
      INT_LVM,      // for int_ve_lvm_mmss or int_ve_lvm_MMss
      INT_SVM,      // for int_ve_svm_sms or int_ve_svm_sMs

      INT_ANDM,     // for int_ve_andm_mmm or int_ve_andm_MMM
      INT_ORM,      // for int_ve_orm_mmm or int_ve_orm_MMM
      INT_XORM,     // for int_ve_xorm_mmm or int_ve_xorm_MMM
      INT_EQVM,     // for int_ve_eqvm_mmm or int_ve_eqvm_MMM
      INT_NNDM,     // for int_ve_nndm_mmm or int_ve_nndm_MMM
      INT_NEGM,     // for int_ve_negm_mm or int_ve_negm_MM
      INT_PCVM,     // for int_ve_pcvm_sm
      INT_LZVM,     // for int_ve_lzvm_sm
      INT_TOVM,     // for int_ve_tovm_sm
      INT_VADDUL,       // for int_ve_vaddul_vvv or int_ve_vaddul_vsv
      INT_VADDUW,       // for int_ve_vadduw_vvv or int_ve_vadduw_vsv
      INT_VADDSWSX,     // for int_ve_vaddswsx_vvv or int_ve_vaddswsx_vsv
      INT_VADDSWZX,     // for int_ve_vaddswzx_vvv or int_ve_vaddswzx_vsv
      INT_VADDSL,       // for int_ve_vaddsl_vvv or int_ve_vaddsl_vsv
      INT_PVADDU,       // for int_ve_pvaddu_vvv or int_ve_pvaddu_vsv
      INT_PVADDS,       // for int_ve_pvadds_vvv or int_ve_pvadds_vsv
      INT_VADDUL_M,     // for int_ve_vaddul_vvvmv or int_ve_vaddul_vsvmv
      INT_VADDUW_M,     // for int_ve_vadduw_vvvmv or int_ve_vadduw_vsvmv
      INT_VADDSWSX_M,   // for int_ve_vaddswsx_vvvmv or int_ve_vaddswsx_vsvmv
      INT_VADDSWZX_M,   // for int_ve_vaddswzx_vvvmv or int_ve_vaddswzx_vsvmv
      INT_VADDSL_M,     // for int_ve_vaddsl_vvvmv or int_ve_vaddsl_vsvmv
      INT_PVADDU_M,     // for int_ve_pvaddu_vvvMv or int_ve_pvaddu_vsvMv
      INT_PVADDS_M,     // for int_ve_pvadds_vvvMv or int_ve_pvadds_vsvMv
      INT_VSUBUL,       // for int_ve_vsubul_vvv or int_ve_vsubul_vsv
      INT_VSUBUW,       // for int_ve_vsubuw_vvv or int_ve_vsubuw_vsv
      INT_VSUBSWSX,     // for int_ve_vsubswsx_vvv or int_ve_vsubswsx_vsv
      INT_VSUBSWZX,     // for int_ve_vsubswzx_vvv or int_ve_vsubswzx_vsv
      INT_VSUBSL,       // for int_ve_vsubsl_vvv or int_ve_vsubsl_vsv
      INT_PVSUBU,       // for int_ve_pvsubu_vvv or int_ve_pvsubu_vsv
      INT_PVSUBS,       // for int_ve_pvsubs_vvv or int_ve_pvsubs_vsv
      INT_VSUBUL_M,     // for int_ve_vsubul_vvvmv or int_ve_vsubul_vsvmv
      INT_VSUBUW_M,     // for int_ve_vsubuw_vvvmv or int_ve_vsubuw_vsvmv
      INT_VSUBSWSX_M,   // for int_ve_vsubswsx_vvvmv or int_ve_vsubswsx_vsvmv
      INT_VSUBSWZX_M,   // for int_ve_vsubswzx_vvvmv or int_ve_vsubswzx_vsvmv
      INT_VSUBSL_M,     // for int_ve_vsubsl_vvvmv or int_ve_vsubsl_vsvmv
      INT_PVSUBU_M,     // for int_ve_pvsubu_vvvMv or int_ve_pvsubu_vsvMv
      INT_PVSUBS_M,     // for int_ve_pvsubs_vvvMv or int_ve_pvsubs_vsvMv
      INT_VCMPUL,       // for int_ve_vcmpul_vvv or int_ve_vcmpul_vsv
      INT_VCMPUW,       // for int_ve_vcmpuw_vvv or int_ve_vcmpuw_vsv
      INT_VCMPSWSX,     // for int_ve_vcmpswsx_vvv or int_ve_vcmpswsx_vsv
      INT_VCMPSWZX,     // for int_ve_vcmpswzx_vvv or int_ve_vcmpswzx_vsv
      INT_VCMPSL,       // for int_ve_vcmpsl_vvv or int_ve_vcmpsl_vsv
      INT_PVCMPU,       // for int_ve_pvcmpu_vvv or int_ve_pvcmpu_vsv
      INT_PVCMPS,       // for int_ve_pvcmps_vvv or int_ve_pvcmps_vsv
      INT_VCMPUL_M,     // for int_ve_vcmpul_vvvmv or int_ve_vcmpul_vsvmv
      INT_VCMPUW_M,     // for int_ve_vcmpuw_vvvmv or int_ve_vcmpuw_vsvmv
      INT_VCMPSWSX_M,   // for int_ve_vcmpswsx_vvvmv or int_ve_vcmpswsx_vsvmv
      INT_VCMPSWZX_M,   // for int_ve_vcmpswzx_vvvmv or int_ve_vcmpswzx_vsvmv
      INT_VCMPSL_M,     // for int_ve_vcmpsl_vvvmv or int_ve_vcmpsl_vsvmv
      INT_PVCMPU_M,     // for int_ve_pvcmpu_vvvMv or int_ve_pvcmpu_vsvMv
      INT_PVCMPS_M,     // for int_ve_pvcmps_vvvMv or int_ve_pvcmps_vsvMv
      INT_VMAXSWSX,     // for int_ve_vmaxswsx_vvv or int_ve_vmaxswsx_vsv
      INT_VMAXSWZX,     // for int_ve_vmaxswzx_vvv or int_ve_vmaxswzx_vsv
      INT_PVMAXS,       // for int_ve_pvmaxs_vvv or int_ve_pvmaxs_vsv
      INT_VMAXSL,       // for int_ve_vmaxsl_vvv or int_ve_vmaxsl_vsv
      INT_VMAXSWSX_M,   // for int_ve_vmaxswsx_vvvmv or int_ve_vmaxswsx_vsvmv
      INT_VMAXSWZX_M,   // for int_ve_vmaxswzx_vvvmv or int_ve_vmaxswzx_vsvmv
      INT_PVMAXS_M,     // for int_ve_pvmaxs_vvvMv or int_ve_pvmaxs_vsvMv
      INT_VMAXSL_M,     // for int_ve_vmaxsl_vvvmv or int_ve_vmaxsl_vsvmv
      INT_VMINSWSX,     // for int_ve_vminswsx_vvv or int_ve_vminswsx_vsv
      INT_VMINSWZX,     // for int_ve_vminswzx_vvv or int_ve_vminswzx_vsv
      INT_PVMINS,       // for int_ve_pvmins_vvv or int_ve_pvmins_vsv
      INT_VMINSL,       // for int_ve_vminsl_vvv or int_ve_vminsl_vsv
      INT_VMINSWSX_M,   // for int_ve_vminswsx_vvvmv or int_ve_vminswsx_vsvmv
      INT_VMINSWZX_M,   // for int_ve_vminswzx_vvvmv or int_ve_vminswzx_vsvmv
      INT_PVMINS_M,     // for int_ve_pvmins_vvvMv or int_ve_pvmins_vsvMv
      INT_VMINSL_M,     // for int_ve_vminsl_vvvmv or int_ve_vminsl_vsvmv
      INT_VMULUL,       // for int_ve_vmulul_vvv or int_ve_vmulul_vsv
      INT_VMULUW,       // for int_ve_vmuluw_vvv or int_ve_vmuluw_vsv
      INT_VMULSWSX,     // for int_ve_vmulswsx_vvv or int_ve_vmulswsx_vsv
      INT_VMULSWZX,     // for int_ve_vmulswzx_vvv or int_ve_vmulswzx_vsv
      INT_VMULSL,       // for int_ve_vmulsl_vvv or int_ve_vmulsl_vsv
      INT_VMULSLW,      // for int_ve_vmulslw_vvv or int_ve_vmulslw_vsv
      INT_VMULUL_M,     // for int_ve_vmulul_vvvmv or int_ve_vmulul_vsvmv
      INT_VMULUW_M,     // for int_ve_vmuluw_vvvmv or int_ve_vmuluw_vsvmv
      INT_VMULSWSX_M,   // for int_ve_vmulswsx_vvvmv or int_ve_vmulswsx_vsvmv
      INT_VMULSWZX_M,   // for int_ve_vmulswzx_vvvmv or int_ve_vmulswzx_vsvmv
      INT_VMULSL_M,     // for int_ve_vmulsl_vvvmv or int_ve_vmulsl_vsvmv
      INT_VMULSLW_M,
      INT_VDIVUL,       // for int_ve_vdivul_vvvmv, int_ve_vdivul_vsvmv, or
                        // int_ve_vdivul_vvsmv
      INT_VDIVUW,       // for int_ve_vdivuw_vvvmv, int_ve_vdivuw_vsvmv, or
                        // int_ve_vdivuw_vvsmv
      INT_VDIVSWSX,     // for int_ve_vdivswsx_vvvmv, int_ve_vdivswsx_vsvmv, or
                        // int_ve_vdivswsx_vvsmv
      INT_VDIVSWZX,     // for int_ve_vdivswzx_vvvmv, int_ve_vdivswzx_vsvmv, or
                        // int_ve_vdivswzx_vvsmv
      INT_VDIVSL,       // for int_ve_vdivsl_vvvmv, int_ve_vdivsl_vsvmv, or
                        // int_ve_vdivsl_vvsmv
      INT_VDIVUL_M,     // for int_ve_vdivul_vvvmv, int_ve_vdivul_vsvmv, or
                        // int_ve_vdivul_vvsmv
      INT_VDIVUW_M,     // for int_ve_vdivuw_vvvmv, int_ve_vdivuw_vsvmv, or
                        // int_ve_vdivuw_vvsmv
      INT_VDIVSWSX_M,   // for int_ve_vdivswsx_vvvmv, int_ve_vdivswsx_vsvmv, or
                        // int_ve_vdivswsx_vvsmv
      INT_VDIVSWZX_M,   // for int_ve_vdivswzx_vvvmv, int_ve_vdivswzx_vsvmv, or
                        // int_ve_vdivswzx_vvsmv
      INT_VDIVSL_M,     // for int_ve_vdivsl_vvvmv, int_ve_vdivsl_vsvmv, or
                        // int_ve_vdivsl_vvsmv
      INT_VFADDD,       // for int_ve_vfaddd_vvv or int_ve_vfaddd_vsv
      INT_VFADDS,       // for int_ve_vfadds_vvv or int_ve_vfadds_vsv
      INT_PVFADD,       // for int_ve_pvfadd_vvv or int_ve_pvfadd_vsv
      INT_VFADDD_M,     // for int_ve_vfaddd_vvvmv or int_ve_vfaddd_vsvmv
      INT_VFADDS_M,     // for int_ve_vfadds_vvvmv or int_ve_vfadds_vsvmv
      INT_PVFADD_M,     // for int_ve_pvfadd_vvvMv or int_ve_pvfadd_vsvMv
      INT_VFSUBD,       // for int_ve_vfsubd_vvv or int_ve_vfsubd_vsv
      INT_VFSUBS,       // for int_ve_vfsubs_vvv or int_ve_vfsubs_vsv
      INT_PVFSUB,       // for int_ve_pvfsub_vvv or int_ve_pvfsub_vsv
      INT_VFSUBD_M,     // for int_ve_vfsubd_vvvmv or int_ve_vfsubd_vsvmv
      INT_VFSUBS_M,     // for int_ve_vfsubs_vvvmv or int_ve_vfsubs_vsvmv
      INT_PVFSUB_M,     // for int_ve_pvfsub_vvvMv or int_ve_pvfsub_vsvMv
      INT_VFMULD,       // for int_ve_vfmuld_vvv or int_ve_vfmuld_vsv
      INT_VFMULS,       // for int_ve_vfmuls_vvv or int_ve_vfmuls_vsv
      INT_PVFMUL,       // for int_ve_pvfmul_vvv or int_ve_pvfmul_vsv
      INT_VFMULD_M,     // for int_ve_vfmuld_vvvmv or int_ve_vfmuld_vsvmv
      INT_VFMULS_M,     // for int_ve_vfmuls_vvvmv or int_ve_vfmuls_vsvmv
      INT_PVFMUL_M,     // for int_ve_pvfmul_vvvMv or int_ve_pvfmul_vsvMv
      INT_VFDIVD,       // for int_ve_vfdivd_vvv or int_ve_vfdivd_vsv
      INT_VFDIVS,       // for int_ve_vfdivs_vvv or int_ve_vfdivs_vsv
      INT_VFDIVD_M,     // for int_ve_vfdivd_vvvmv or int_ve_vfdivd_vsvmv
      INT_VFDIVS_M,     // for int_ve_vfdivs_vvvmv or int_ve_vfdivs_vsvmv
      INT_VFCMPD,       // for int_ve_vfcmpd_vvv or int_ve_vfcmpd_vsv
      INT_VFCMPS,       // for int_ve_vfcmps_vvv or int_ve_vfcmps_vsv
      INT_PVFCMP,       // for int_ve_pvfcmp_vvv or int_ve_pvfcmp_vsv
      INT_VFCMPD_M,     // for int_ve_vfcmpd_vvvmv or int_ve_vfcmpd_vsvmv
      INT_VFCMPS_M,     // for int_ve_vfcmps_vvvmv or int_ve_vfcmps_vsvmv
      INT_PVFCMP_M,     // for int_ve_pvfcmp_vvvMv or int_ve_pvfcmp_vsvMv
      INT_VFMAXD,       // for int_ve_vfmaxd_vvv or int_ve_vfmaxd_vsv
      INT_VFMAXS,       // for int_ve_vfmaxs_vvv or int_ve_vfmaxs_vsv
      INT_PVFMAX,       // for int_ve_pvfmax_vvv or int_ve_pvfmax_vsv
      INT_VFMAXD_M,     // for int_ve_vfmaxd_vvvmv or int_ve_vfmaxd_vsvmv
      INT_VFMAXS_M,     // for int_ve_vfmaxs_vvvmv or int_ve_vfmaxs_vsvmv
      INT_PVFMAX_M,     // for int_ve_pvfmax_vvvMv or int_ve_pvfmax_vsvMv
      INT_VFMIND,       // for int_ve_vfmind_vvv or int_ve_vfmind_vsv
      INT_VFMINS,       // for int_ve_vfmins_vvv or int_ve_vfmins_vsv
      INT_PVFMIN,       // for int_ve_pvfmin_vvv or int_ve_pvfmin_vsv
      INT_VFMIND_M,     // for int_ve_vfmind_vvvmv or int_ve_vfmind_vsvmv
      INT_VFMINS_M,     // for int_ve_vfmins_vvvmv or int_ve_vfmins_vsvmv
      INT_PVFMIN_M,     // for int_ve_pvfmin_vvvMv or int_ve_pvfmin_vsvMv
      INT_VFMADD,       // for int_ve_vfmadd_vvv, int_ve_vfmadd_vsv, or
                        // for int_ve_vfmadd_vvs
      INT_VFMADS,       // for int_ve_vfmads_vvv, int_ve_vfmads_vsv, or
                        // for int_ve_vfmads_vvs
      INT_PVFMAD,       // for int_ve_pvfmad_vvvv, int_ve_pvfmad_vsv, or
                        // for int_ve_pvfmad_vvs
      INT_VFMADD_M,     // for int_ve_vfmadd_vvvmv, int_ve_vfmadd_vsvmv, or
                        // for int_ve_vfmadd_vvsmv
      INT_VFMADS_M,     // for int_ve_vfmads_vvvmv, int_ve_vfmads_vsvmv, or
                        // for int_ve_vfmads_vvsmv
      INT_PVFMAD_M,     // for int_ve_pvfmad_vvvvMv, int_ve_pvfmad_vsvMv, or
                        // for int_ve_pvfmad_vvsMv
      INT_VFMSBD,       // for int_ve_vfmsbd_vvv, int_ve_vfmsbd_vsv, or
                        // for int_ve_vfmsbd_vvs
      INT_VFMSBS,       // for int_ve_vfmsbs_vvv, int_ve_vfmsbs_vsv, or
                        // for int_ve_vfmsbs_vvs
      INT_PVFMSB,       // for int_ve_pvfmsb_vvvv, int_ve_pvfmsb_vsv, or
                        // for int_ve_pvfmsb_vvs
      INT_VFMSBD_M,     // for int_ve_vfmsbd_vvvmv, int_ve_vfmsbd_vsvmv, or
                        // for int_ve_vfmsbd_vvsmv
      INT_VFMSBS_M,     // for int_ve_vfmsbs_vvvmv, int_ve_vfmsbs_vsvmv, or
                        // for int_ve_vfmsbs_vvsmv
      INT_PVFMSB_M,     // for int_ve_pvfmsb_vvvvMv, int_ve_pvfmsb_vsvMv, or
                        // for int_ve_pvfmsb_vvsMv
      INT_VFNMADD,      // for int_ve_vfnmadd_vvv, int_ve_vfnmadd_vsv, or
                        // for int_ve_vfmmadd_vvs
      INT_VFNMADS,      // for int_ve_vfnmads_vvv, int_ve_vfnmads_vsv, or
                        // for int_ve_vfmmads_vvs
      INT_PVFNMAD,      // for int_ve_pvfnmad_vvvv, int_ve_pvfnmad_vsv, or
                        // for int_ve_pvfnmad_vvs
      INT_VFNMADD_M,    // for int_ve_vfnmadd_vvvmv, int_ve_vfnmadd_vsvmv, or
                        // for int_ve_vfmmadd_vvsmv
      INT_VFNMADS_M,    // for int_ve_vfnmads_vvvmv, int_ve_vfnmads_vsvmv, or
                        // for int_ve_vfmmads_vvsmv
      INT_PVFNMAD_M,    // for int_ve_pvfnmad_vvvvMv, int_ve_pvfnmad_vsvMv, or
                        // for int_ve_pvfnmad_vvsMv
      INT_VFNMSBD,      // for int_ve_vfnmsbd_vvv, int_ve_vfnmsbd_vsv, or
                        // for int_ve_vfmmsbd_vvs
      INT_VFNMSBS,      // for int_ve_vfnmsbs_vvv, int_ve_vfnmsbs_vsv, or
                        // for int_ve_vfmmsbs_vvs
      INT_PVFNMSB,      // for int_ve_pvfnmsb_vvvv, int_ve_pvfnmsb_vsv, or
                        // for int_ve_pvfnmsb_vvs
      INT_VFNMSBD_M,    // for int_ve_vfnmsbd_vvvmv, int_ve_vfnmsbd_vsvmv, or
                        // for int_ve_vfmmsbd_vvsmv
      INT_VFNMSBS_M,    // for int_ve_vfnmsbs_vvvmv, int_ve_vfnmsbs_vsvmv, or
                        // for int_ve_vfmmsbs_vvsmv
      INT_PVFNMSB_M,    // for int_ve_pvfnmsb_vvvvMv, int_ve_pvfnmsb_vsvMv, or
                        // for int_ve_pvfnmsb_vvsMv
      INT_VAND,     // for int_ve_vand_vvv or int_ve_vand_vsv
      INT_PVAND,    // for int_ve_pvand_vvv or int_ve_pvand_vsv
      INT_VAND_M,   // for int_ve_vand_vvvmv or int_ve_vand_vsvmv
      INT_PVAND_M,  // for int_ve_pvand_vvvMv or int_ve_pvand_vsvMv
      INT_VOR,      // for int_ve_vor_vvv or int_ve_vor_vsv
      INT_PVOR,     // for int_ve_pvor_vvv or int_ve_pvor_vsv
      INT_VOR_M,    // for int_ve_vor_vvvmv or int_ve_vor_vsvmv
      INT_PVOR_M,   // for int_ve_pvor_vvvMv or int_ve_pvor_vsvMv
      INT_VXOR,     // for int_ve_vxor_vvv or int_ve_vxor_vsv
      INT_PVXOR,    // for int_ve_pvxor_vvv or int_ve_pvxor_vsv
      INT_VXOR_M,   // for int_ve_vxor_vvvmv or int_ve_vxor_vsvmv
      INT_PVXOR_M,  // for int_ve_pvxor_vvvMv or int_ve_pvxor_vsvMv
      INT_VEQV,     // for int_ve_veqv_vvv or int_ve_veqv_vsv
      INT_PVEQV,    // for int_ve_pveqv_vvv or int_ve_pveqv_vsv
      INT_VEQV_M,   // for int_ve_veqv_vvvmv or int_ve_veqv_vsvmv
      INT_PVEQV_M,  // for int_ve_pveqv_vvvMv or int_ve_pveqv_vsvMv
      INT_VBRD,     // for int_ve_vbrd_vs_f64, int_ve_vbrd_vs_i64,
      INT_VBRDU,    // for int_ve_vbrdu_vs_f32
      INT_VBRDL,    // for int_ve_vbrdl_vs_i32
      INT_PVBRD,    // for int_ve_pvbrd_vs_i64
      INT_VBRD_M,   // for int_ve_vbrd_vsmv_f64, int_ve_vbrd_vsmv_i64,
      INT_VBRDU_M,  // for int_ve_vbrdu_vsmv_f32
      INT_VBRDL_M,  // for int_ve_vbrdl_vsmv_i32
      INT_PVBRD_M,  // for int_ve_pvbrd_vsMv_i64
      INT_VSLL,     // for int_ve_vsll_vvv or int_ve_vsll_vvs
      INT_PVSLL,    // for int_ve_pvsll_vvv or int_ve_pvsll_vvs
      INT_VSLL_M,   // for int_ve_vsll_vvvmv or int_ve_vsll_vvsmv
      INT_PVSLL_M,  // for int_ve_pvsll_vvvMv or int_ve_pvsll_vvsMv
      INT_VSRL,     // for int_ve_vsrl_vvv or int_ve_vsrl_vvs
      INT_PVSRL,    // for int_ve_pvsrl_vvv or int_ve_pvsrl_vvs
      INT_VSRL_M,   // for int_ve_vsrl_vvvmv or int_ve_vsrl_vvsmv
      INT_PVSRL_M,  // for int_ve_pvsrl_vvvMv or int_ve_pvsrl_vvsMv
      INT_VSLAW,    // for int_ve_vslaw_vvv or int_ve_vslaw_vvs
      INT_VSLAL,    // for int_ve_vslal_vvv or int_ve_vslal_vvs
      INT_PVSLA,    // for int_ve_pvsla_vvv or int_ve_pvsla_vvs
      INT_VSLAW_M,  // for int_ve_vslaw_vvvmv or int_ve_vslaw_vvsmv
      INT_VSLAL_M,  // for int_ve_vslal_vvvmv or int_ve_vslal_vvsmv
      INT_PVSLA_M,  // for int_ve_pvsla_vvvMv or int_ve_pvsla_vvsMv
      INT_VSRAW,    // for int_ve_vsraw_vvv or int_ve_vsraw_vvs
      INT_VSRAL,    // for int_ve_vsral_vvv or int_ve_vsral_vvs
      INT_PVSRA,    // for int_ve_pvsra_vvv or int_ve_pvsra_vvs
      INT_VSRAW_M,  // for int_ve_vsraw_vvvmv or int_ve_vsraw_vvsmv
      INT_VSRAL_M,  // for int_ve_vsral_vvvmv or int_ve_vsral_vvsmv
      INT_PVSRA_M,  // for int_ve_pvsra_vvvMv or int_ve_pvsra_vvsMv
      INT_VSFA,     // for int_ve_vsfa_vvss
      INT_VSFA_M,   // for int_ve_vsfa_vvssmv
      INT_VMRG_M,   // for int_ve_vmrg_vvvm
      INT_VMRGW_M,  // for int_ve_vmrgw_vvvM
      INT_VCP_M,    // for int_ve_vcp_vvmv
      INT_VEX_M,    // for int_ve_vex_vvmv
      INT_VFMKL,    // for int_ve_vfmkl_mcv
      INT_VFMKL_M,  // for int_ve_vfmkl_mcvm
      INT_VFMKW,    // for int_ve_vfmkw_mcv
      INT_VFMKW_M,  // for int_ve_vfmkw_mcvm
      INT_VFMKD,    // for int_ve_vfmkd_mcv
      INT_VFMKD_M,  // for int_ve_vfmkd_mcvm
      INT_VFMKS,    // for int_ve_vfmks_mcv
      INT_VFMKS_M,  // for int_ve_vfmks_mcvm
      INT_VFMKAT,   // for int_ve_vfmkat_mcv
      INT_VFMKAF,   // for int_ve_vfmkaf_mcv
      INT_PVFMKW,   // for int_ve_pvfmkw_Mcv
      INT_PVFMKW_M, // for int_ve_pvfmkw_McvM
      INT_PVFMKS,   // for int_ve_pvfmks_Mcv
      INT_PVFMKS_M, // for int_ve_pvfmks_McvM
      INT_PVFMKAT,  // for int_ve_pvfmkat_mcv
      INT_PVFMKAF,  // for int_ve_pvfmkaf_mcv
      INT_VGT,      // for int_ve_vgt_vv
      INT_VGTU,     // for int_ve_vgtu_vv
      INT_VGTLSX,   // for int_ve_vgtlsx_vv
      INT_VGTLZX,   // for int_ve_vgtlzx_vv
      INT_VGT_M,    // for int_ve_vgt_vvm
      INT_VGTU_M,   // for int_ve_vgtu_vvm
      INT_VGTLSX_M, // for int_ve_vgtlsx_vvm
      INT_VGTLZX_M, // for int_ve_vgtlzx_vvm
      INT_VSC,      // for int_ve_vsc_vv
      INT_VSCU,     // for int_ve_vscu_vv
      INT_VSCL,     // for int_ve_vscl_vv
      INT_VSC_M,    // for int_ve_vsc_vvm
      INT_VSCU_M,   // for int_ve_vscu_vvm
      INT_VSCL_M,   // for int_ve_vscl_vvm
      INT_EXTMU,    // for int_ve_extract_vm512u
      INT_EXTML,    // for int_ve_extract_vm512l
      INT_INSMU,    // for int_ve_insert_vm512u
      INT_INSML,    // for int_ve_insert_vm512l
      INT_VLD,      // for int_ve_vld_vss
      INT_VLDU,     // for int_ve_vldu_vss
      INT_VLDLSX,   // for int_ve_vldlsx_vss
      INT_VLDLZX,   // for int_ve_vldlzx_vss
      INT_VLD2D,    // for int_ve_vld2d_vss
      INT_VLDU2D,   // for int_ve_vldu2d_vss
      INT_VLDL2DSX, // for int_ve_vldl2dsx_vss
      INT_VLDL2DZX, // for int_ve_vldl2dzx_vss
      INT_VST,      // for int_ve_vst_vss
      INT_VSTU,     // for int_ve_vstu_vss
      INT_VSTL,     // for int_ve_vstl_vss
      INT_VST2D,    // for int_ve_vst2d_vss
      INT_VSTU2D,   // for int_ve_vstu2d_vss
      INT_VSTL2D,   // for int_ve_vstl2d_vss
      INT_LVL,      // for int_ve_lvl
      INT_VMV,      // for int_ve_vmv_vsv
      INT_VFSQRTD,  // for int_ve_vfsqrtd_vv
      INT_VFSQRTS,  // for int_ve_vfsqrts_vv
      INT_VRSQRTD,  // for int_ve_vrsqrtd_vv
      INT_VRSQRTS,  // for int_ve_vrsqrts_vv
      INT_PVRSQRT,  // for int_ve_pvrsqrt_vv
      INT_VRCPD,    // for int_ve_vrcpd_vv
      INT_VRCPS,    // for int_ve_vrcps_vv
      INT_PVRCP,    // for int_ve_pvrcp_vv
      INT_VCVTWDSX,     // for int_ve_vcvtwdsx_vv
      INT_VCVTWDSX_M,   // for int_ve_vcvtwdsx_vvmv
      INT_VCVTWDSXRZ,   // for int ve_vcvtwdsxrz_vv
      INT_VCVTWDSXRZ_M, // for int_ve_vcvtwdsxrz_vvmv
      INT_VCVTWDZX,     // for int_ve_vcvtwdzx_vv
      INT_VCVTWDZX_M,   // for int_ve_vcvtwdzx_vvmv
      INT_VCVTWDZXRZ,   // for int_ve_vcvtwdzxrz_vv
      INT_VCVTWDZXRZ_M, // for int_ve_vcvtwdzxrz_vvmv
      INT_VCVTWSSX,     // for int_ve_vcvtwssx_vv
      INT_VCVTWSSX_M,   // for int_ve_vcvtwssx_vvmv
      INT_VCVTWSSXRZ,   // for int_ve_vcvtwssxrz_vv
      INT_VCVTWSSXRZ_M, // for int_ve_vcvtwssxrz_vvmv
      INT_VCVTWSZX,     // for int_ve_vcvtwszx_vv
      INT_VCVTWSZX_M,   // for int_ve_vcvtwszx_vvmv
      INT_VCVTWSZXRZ,   // for int_ve_vcvtwszxrz_vv
      INT_VCVTWSZXRZ_M, // for int_ve_vcvtwszxrz_vvmv
      INT_PVCVTWS,      // for int_ve_pvcvtws_vv
      INT_PVCVTWS_M,    // for int_ve_pvcvtws_vvmv
      INT_PVCVTWSRZ,    // for int_ve_pvctwsrz_vv
      INT_PVCVTWSRZ_M,  // for int_ve_pvctwsrz_vvmv
      INT_VCVTLD,       // for int_ve_vcvtld_vv
      INT_VCVTLD_M,     // for int_ve_vcvtld_vvmv
      INT_VCVTLDRZ,     // for int_ve_vcvtldrz_vv
      INT_VCVTLDRZ_M,   // for int_ve_vcvtldrz_vvmv
      INT_VCVTDW,       // for int_ve_vcvtdw_vv
      INT_VCVTSW,       // for int_ve_vcvtsw_vv
      INT_PVCVTSW,      // for int_ve_pvcvtsw_vv
      INT_VCVTDL,       // for int_ve_vcvtdl_vv
      INT_VCVTDS,       // for int_ve_vcvtds_vv
      INT_VCVTSD,       // for int_ve_vcvtsd_vv
      INT_VSHF,         // for int_ve_vshf_vvvs
      INT_VSUMWSX,      // for int_ve_vsumwsx_vv
      INT_VSUMWSX_M,    // for int_ve_vsumwsx_vvm
      INT_VSUMWZX,      // for int_ve_vsumwzx_vv
      INT_VSUMWZX_M,    // for int_ve_vsumwzx_vvm
      INT_VSUML,        // for int_ve_vsuml_vv
      INT_VSUML_M,      // for int_ve_vsuml_vvm
      INT_VFSUMD,       // for int_ve_vfsums_vv
      INT_VFSUMD_M,     // for int_ve_vfsums_vvm
      INT_VFSUMS,       // for int_ve_vfsums_vv
      INT_VFSUMS_M,     // for int_ve_vfsums_vvm
      INT_VRMAXSWFSTSX, // for int_ve_vrmaxswfstsx_vv
      INT_VRMAXSWLSTSX, // for int_ve_vrmaxswlstsx_vv
      INT_VRMAXSWFSTZX, // for int_ve_vrmaxswfstzx_vv
      INT_VRMAXSWLSTZX, // for int_ve_vrmaxswlstzx_vv
      INT_VRMINSWFSTSX, // for int_ve_vrminswfstsx_vv
      INT_VRMINSWLSTSX, // for int_ve_vrminswlstsx_vv
      INT_VRMINSWFSTZX, // for int_ve_vrminswfstzx_vv
      INT_VRMINSWLSTZX, // for int_ve_vrminswlstzx_vv
      INT_VRMAXSLFST,   // for int_ve_vrmaxslfst_vv
      INT_VRMAXSLLST,   // for int_ve_vrmaxsllst_vv
      INT_VRMINSLFST,   // for int_ve_vrminslfst_vv
      INT_VRMINSLLST,   // for int_ve_vrminsllst_vv
      INT_VFRMAXDFST,   // for int_ve_vfrmaxdfst_vv
      INT_VFRMAXDLST,   // for int_ve_vfrmaxdlst_vv
      INT_VFRMAXSFST,   // for int_ve_vfrmaxsfst_vv
      INT_VFRMAXSLST,   // for int_ve_vfrmaxslst_vv
      INT_VFRMINDFST,   // for int_ve_vfrmindfst_vv
      INT_VFRMINDLST,   // for int_ve_vfrmindlst_vv
      INT_VFRMINSFST,   // for int_ve_vfrminsfst_vv
      INT_VFRMINSLST,   // for int_ve_vfrminslst_vv
      INT_VSEQ,         // for int_ve_vseq_v
      INT_PVSEQLO,      // for int_ve_pvseqlo_v
      INT_PVSEQUP,      // for int_ve_pvsequp_v
      INT_PVSEQ,        // for int_ve_pvseq_v
      INT_VSEQ_M,
      INT_PVSEQLO_M,
      INT_PVSEQUP_M,
      INT_PVSEQ_M,
      INT_LSV,          // for int_ve_lsv_vvss
      INT_LVS,          // for int_lvs_svs_u64, int_lvs_svs_f64, and
                        // int_ve_lvs_svs_f32
      INT_PFCHV,        // for int_ve_pfchv
#endif // OBSOLETE_VE_INTRIN
    };
  }

  class VETargetLowering : public TargetLowering {
    const VESubtarget *Subtarget;
  public:
    VETargetLowering(const TargetMachine &TM, const VESubtarget &STI);
    SDValue LowerOperation(SDValue Op, SelectionDAG &DAG) const override;

    /// computeKnownBitsForTargetNode - Determine which of the bits specified
    /// in Mask are known to be either zero or one and return them in the
    /// KnownZero/KnownOne bitsets.
    void computeKnownBitsForTargetNode(const SDValue Op,
                                       KnownBits &Known,
                                       const APInt &DemandedElts,
                                       const SelectionDAG &DAG,
                                       unsigned Depth = 0) const override;

    MachineBasicBlock *
    EmitInstrWithCustomInserter(MachineInstr &MI,
                                MachineBasicBlock *MBB) const override;

    const char *getTargetNodeName(unsigned Opcode) const override;

#if 0
    SDValue PerformDAGCombine(SDNode *N, DAGCombinerInfo &DCI) const override;
#endif

    ConstraintType getConstraintType(StringRef Constraint) const override;
    ConstraintWeight
    getSingleConstraintMatchWeight(AsmOperandInfo &info,
                                   const char *constraint) const override;
    void LowerAsmOperandForConstraint(SDValue Op,
                                      std::string &Constraint,
                                      std::vector<SDValue> &Ops,
                                      SelectionDAG &DAG) const override;

    unsigned
    getInlineAsmMemConstraint(StringRef ConstraintCode) const override {
      if (ConstraintCode == "o")
        return InlineAsm::Constraint_o;
      return TargetLowering::getInlineAsmMemConstraint(ConstraintCode);
    }

    std::pair<unsigned, const TargetRegisterClass *>
    getRegForInlineAsmConstraint(const TargetRegisterInfo *TRI,
                                 StringRef Constraint, MVT VT) const override;

    bool isOffsetFoldingLegal(const GlobalAddressSDNode *GA) const override;
    MVT getScalarShiftAmountTy(const DataLayout &, EVT) const override {
      return MVT::i32;
    }

    Register getRegisterByName(const char* RegName, EVT VT,
                               const MachineFunction &MF) const override;

    /// Override to support customized stack guard loading.
    bool useLoadStackGuardNode() const override;
    void insertSSPDeclarations(Module &M) const override;

    /// getSetCCResultType - Return the ISD::SETCC ValueType
    EVT getSetCCResultType(const DataLayout &DL, LLVMContext &Context,
                           EVT VT) const override;

    SDValue
    LowerFormalArguments(SDValue Chain, CallingConv::ID CallConv, bool isVarArg,
                         const SmallVectorImpl<ISD::InputArg> &Ins,
                         const SDLoc &dl, SelectionDAG &DAG,
                         SmallVectorImpl<SDValue> &InVals) const override;
    SDValue LowerFormalArguments_64(SDValue Chain, CallingConv::ID CallConv,
                                    bool isVarArg,
                                    const SmallVectorImpl<ISD::InputArg> &Ins,
                                    const SDLoc &dl, SelectionDAG &DAG,
                                    SmallVectorImpl<SDValue> &InVals) const;

    SDValue LowerCall(TargetLowering::CallLoweringInfo &CLI,
                      SmallVectorImpl<SDValue> &InVals) const override;

    bool CanLowerReturn(CallingConv::ID CallConv, MachineFunction &MF,
                        bool isVarArg,
                        const SmallVectorImpl<ISD::OutputArg> &ArgsFlags,
                        LLVMContext &Context) const override;
    SDValue LowerReturn(SDValue Chain, CallingConv::ID CallConv, bool isVarArg,
                        const SmallVectorImpl<ISD::OutputArg> &Outs,
                        const SmallVectorImpl<SDValue> &OutVals,
                        const SDLoc &dl, SelectionDAG &DAG) const override;

    SDValue LowerGlobalAddress(SDValue Op, SelectionDAG &DAG) const;
    SDValue LowerGlobalTLSAddress(SDValue Op, SelectionDAG &DAG) const;
    SDValue LowerToTLSGeneralDynamicModel(SDValue Op, SelectionDAG &DAG) const;
    SDValue LowerToTLSLocalExecModel(SDValue Op, SelectionDAG &DAG) const;
    SDValue LowerConstantPool(SDValue Op, SelectionDAG &DAG) const;
    SDValue LowerBlockAddress(SDValue Op, SelectionDAG &DAG) const;
    SDValue LowerBUILD_VECTOR(SDValue Op, SelectionDAG &DAG) const;

    SDValue LowerBitcast(SDValue Op, SelectionDAG &DAG) const;

    SDValue LowerVECTOR_SHUFFLE(SDValue Op, SelectionDAG &DAG) const;

    SDValue LowerMGATHER_MSCATTER(SDValue Op, SelectionDAG &DAG) const;

    SDValue LowerMLOAD(SDValue Op, SelectionDAG &DAG) const;

    SDValue LowerEH_SJLJ_SETJMP(SDValue Op, SelectionDAG &DAG) const;
    SDValue LowerEH_SJLJ_LONGJMP(SDValue Op, SelectionDAG &DAG) const;
    SDValue LowerEH_SJLJ_SETUP_DISPATCH(SDValue Op, SelectionDAG &DAG) const;

    unsigned getSRetArgSize(SelectionDAG &DAG, SDValue Callee) const;
    SDValue withTargetFlags(SDValue Op, unsigned TF, SelectionDAG &DAG) const;
    SDValue makeHiLoPair(SDValue Op, unsigned HiTF, unsigned LoTF,
                         SelectionDAG &DAG) const;
    SDValue makeAddress(SDValue Op, SelectionDAG &DAG) const;

    SDValue LowerINTRINSIC_VOID(SDValue Op, SelectionDAG &DAG) const;
    SDValue LowerINTRINSIC_W_CHAIN(SDValue Op, SelectionDAG &DAG) const;
    SDValue LowerINTRINSIC_WO_CHAIN(SDValue Op, SelectionDAG &DAG) const;

    SDValue LowerDYNAMIC_STACKALLOC(SDValue Op, SelectionDAG &DAG) const;

    SDValue LowerATOMIC_FENCE(SDValue Op, SelectionDAG &DAG) const;
    SDValue LowerATOMIC_LOAD(SDValue Op, SelectionDAG &DAG) const;
    SDValue LowerATOMIC_STORE(SDValue Op, SelectionDAG &DAG) const;

    // Should we expand the build vector with shuffles?
    bool shouldExpandBuildVectorWithShuffles(EVT VT,
        unsigned DefinedValues) const override;

    SDValue LowerEXTRACT_VECTOR_ELT(SDValue Op, SelectionDAG &DAG) const;
    SDValue LowerINSERT_VECTOR_ELT(SDValue Op, SelectionDAG &DAG) const;

    bool isFPImmLegal(const APFloat &Imm, EVT VT,
                      bool ForCodeSize) const override;

    bool ShouldShrinkFPConstant(EVT VT) const override {
      // Do not shrink FP constpool if VT == MVT::f128.
      // (ldd, call _Q_fdtoq) is more expensive than two ldds.
      return VT != MVT::f128;
    }

    /// Returns true if the target allows unaligned memory accesses of the
    /// specified type.
    bool allowsMisalignedMemoryAccesses(EVT VT, unsigned AS,
                                        unsigned Align,
                                        MachineMemOperand::Flags Flags,
                                        bool *Fast) const override;

    bool mergeStoresAfterLegalization(EVT) const override { return true; }

    bool canMergeStoresTo(unsigned AddressSpace, EVT MemVT,
                          const SelectionDAG &DAG) const override;

    unsigned getJumpTableEncoding() const override;

    const MCExpr *
    LowerCustomJumpTableEntry(const MachineJumpTableInfo *MJTI,
                              const MachineBasicBlock *MBB, unsigned uid,
                              MCContext &Ctx) const override;

    bool shouldInsertFencesForAtomic(const Instruction *I) const override {
      // VE uses Release consistency, so need fence for each atomics.
      return true;
    }
    Instruction *emitLeadingFence(IRBuilder<> &Builder, Instruction *Inst,
                                  AtomicOrdering Ord) const override;
    Instruction *emitTrailingFence(IRBuilder<> &Builder, Instruction *Inst,
                                   AtomicOrdering Ord) const override;

    AtomicExpansionKind shouldExpandAtomicRMWInIR(AtomicRMWInst *AI) const override;

    void ReplaceNodeResults(SDNode *N,
                            SmallVectorImpl<SDValue>& Results,
                            SelectionDAG &DAG) const override;

    MachineBasicBlock *expandSelectCC(MachineInstr &MI, MachineBasicBlock *BB,
                                      unsigned BROpcode) const;
    MachineBasicBlock *emitEHSjLjSetJmp(MachineInstr &MI,
                                        MachineBasicBlock *MBB) const;
    MachineBasicBlock *emitEHSjLjLongJmp(MachineInstr &MI,
                                         MachineBasicBlock *MBB) const;
    MachineBasicBlock *EmitSjLjDispatchBlock(MachineInstr &MI,
                                             MachineBasicBlock *BB) const;
    void SetupEntryBlockForSjLj(MachineInstr &MI, MachineBasicBlock *MBB,
                                MachineBasicBlock *DispatchBB, int FI) const;
    void updateVL(MachineFunction &MF) const;
    void finalizeLowering(MachineFunction &MF) const override;

  private:
    // VE supports only vector FMA
    bool isFMAFasterThanFMulAndFAdd(EVT VT) const override { return VT.isVector() ? true : false; }
  };
} // end namespace llvm

#endif    // VE_ISELLOWERING_H
