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
  LOAD, STORE,
  OP_MMM, OP_MM, OP_SM,
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
 * IntrinsicsWithChain - the table should be sorted by Intrinsic ID - in
 * the alphabetical order.
 */
static const IntrinsicData IntrinsicsWithChain[] = {
  // dummy data
  VE_INTRINSIC_DATA(lvm_mmss,           LOAD,   VEISD::INT_LVM, 0),
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
  VE_INTRINSIC_DATA(lvm_MMss,           LOAD,       VEISD::INT_LVM, 0),
  VE_INTRINSIC_DATA(lvm_mmss,           LOAD,       VEISD::INT_LVM, 0),
  VE_INTRINSIC_DATA(lzvm_sm,            OP_SM,      VEISD::INT_LZVM, 0),
  VE_INTRINSIC_DATA(negm_MM,            OP_MM,      VEISD::INT_NEGM, 0),
  VE_INTRINSIC_DATA(negm_mm,            OP_MM,      VEISD::INT_NEGM, 0),
  VE_INTRINSIC_DATA(nndm_MMM,           OP_MMM,     VEISD::INT_NNDM, 0),
  VE_INTRINSIC_DATA(nndm_mmm,           OP_MMM,     VEISD::INT_NNDM, 0),
  VE_INTRINSIC_DATA(orm_MMM,            OP_MMM,     VEISD::INT_ORM, 0),
  VE_INTRINSIC_DATA(orm_mmm,            OP_MMM,     VEISD::INT_ORM, 0),
  VE_INTRINSIC_DATA(pcvm_sm,            OP_SM,      VEISD::INT_PCVM, 0),
  VE_INTRINSIC_DATA(svm_sMs,            STORE,      VEISD::INT_SVM, 0),
  VE_INTRINSIC_DATA(svm_sms,            STORE,      VEISD::INT_SVM, 0),
  VE_INTRINSIC_DATA(tovm_sm,            OP_SM,      VEISD::INT_TOVM, 0),
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
         "Intrinsic data tables should be sorted by Intrinsic ID");
  assert((std::adjacent_find(std::begin(IntrinsicsWithoutChain),
                             std::end(IntrinsicsWithoutChain)) ==
          std::end(IntrinsicsWithoutChain)) &&
         (std::adjacent_find(std::begin(IntrinsicsWithChain),
                             std::end(IntrinsicsWithChain)) ==
          std::end(IntrinsicsWithChain)) &&
         "Intrinsic data tables should have unique entries");
}
} // End llvm namespace

#endif
