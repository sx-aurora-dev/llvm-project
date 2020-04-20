//===-- InstrinsicInst.cpp - Intrinsic Instruction Wrappers ---------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file implements methods that make it really easy to deal with intrinsic
// functions.
//
// All intrinsic function calls are instances of the call instruction, so these
// are all subclasses of the CallInst class.  Note that none of these classes
// has state or virtual methods, which is an important part of this gross/neat
// hack working.
//
// In some cases, arguments to intrinsics need to be generic and are defined as
// type pointer to empty struct { }*.  To access the real item of interest the
// cast instruction needs to be stripped away.
//
//===----------------------------------------------------------------------===//

#include "llvm/IR/IntrinsicInst.h"
#include "llvm/ADT/StringSwitch.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DebugInfoMetadata.h"
#include "llvm/IR/GlobalVariable.h"
#include "llvm/IR/Metadata.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/PatternMatch.h"
#include "llvm/IR/Operator.h"

#include "llvm/Support/raw_ostream.h"
using namespace llvm;

//===----------------------------------------------------------------------===//
/// DbgVariableIntrinsic - This is the common base class for debug info
/// intrinsics for variables.
///

Value *DbgVariableIntrinsic::getVariableLocation(bool AllowNullOp) const {
  Value *Op = getArgOperand(0);
  if (AllowNullOp && !Op)
    return nullptr;

  auto *MD = cast<MetadataAsValue>(Op)->getMetadata();
  if (auto *V = dyn_cast<ValueAsMetadata>(MD))
    return V->getValue();

  // When the value goes to null, it gets replaced by an empty MDNode.
  assert(!cast<MDNode>(MD)->getNumOperands() && "Expected an empty MDNode");
  return nullptr;
}

Optional<uint64_t> DbgVariableIntrinsic::getFragmentSizeInBits() const {
  if (auto Fragment = getExpression()->getFragmentInfo())
    return Fragment->SizeInBits;
  return getVariable()->getSizeInBits();
}

int llvm::Intrinsic::lookupLLVMIntrinsicByName(ArrayRef<const char *> NameTable,
                                               StringRef Name) {
  assert(Name.startswith("llvm."));

  // Do successive binary searches of the dotted name components. For
  // "llvm.gc.experimental.statepoint.p1i8.p1i32", we will find the range of
  // intrinsics starting with "llvm.gc", then "llvm.gc.experimental", then
  // "llvm.gc.experimental.statepoint", and then we will stop as the range is
  // size 1. During the search, we can skip the prefix that we already know is
  // identical. By using strncmp we consider names with differing suffixes to
  // be part of the equal range.
  size_t CmpEnd = 4; // Skip the "llvm" component.
  const char *const *Low = NameTable.begin();
  const char *const *High = NameTable.end();
  const char *const *LastLow = Low;
  while (CmpEnd < Name.size() && High - Low > 0) {
    size_t CmpStart = CmpEnd;
    CmpEnd = Name.find('.', CmpStart + 1);
    CmpEnd = CmpEnd == StringRef::npos ? Name.size() : CmpEnd;
    auto Cmp = [CmpStart, CmpEnd](const char *LHS, const char *RHS) {
      return strncmp(LHS + CmpStart, RHS + CmpStart, CmpEnd - CmpStart) < 0;
    };
    LastLow = Low;
    std::tie(Low, High) = std::equal_range(Low, High, Name.data(), Cmp);
  }
  if (High - Low > 0)
    LastLow = Low;

  if (LastLow == NameTable.end())
    return -1;
  StringRef NameFound = *LastLow;
  if (Name == NameFound ||
      (Name.startswith(NameFound) && Name[NameFound.size()] == '.'))
    return LastLow - NameTable.begin();
  return -1;
}

Value *InstrProfIncrementInst::getStep() const {
  if (InstrProfIncrementInstStep::classof(this)) {
    return const_cast<Value *>(getArgOperand(4));
  }
  const Module *M = getModule();
  LLVMContext &Context = M->getContext();
  return ConstantInt::get(Type::getInt64Ty(Context), 1);
}

Optional<RoundingMode> ConstrainedFPIntrinsic::getRoundingMode() const {
  unsigned NumOperands = getNumArgOperands();
  Metadata *MD =
      cast<MetadataAsValue>(getArgOperand(NumOperands - 2))->getMetadata();
  if (!MD || !isa<MDString>(MD))
    return None;
  return StrToRoundingMode(cast<MDString>(MD)->getString());
}

Optional<fp::ExceptionBehavior>
ConstrainedFPIntrinsic::getExceptionBehavior() const {
  unsigned NumOperands = getNumArgOperands();
  assert(NumOperands >= 1 && "underflow");
  Metadata *MD =
      cast<MetadataAsValue>(getArgOperand(NumOperands - 1))->getMetadata();
  if (!MD || !isa<MDString>(MD))
    return None;
  return StrToExceptionBehavior(cast<MDString>(MD)->getString());
}

FCmpInst::Predicate
ConstrainedFPCmpIntrinsic::getPredicate() const {
  Metadata *MD =
      cast<MetadataAsValue>(getArgOperand(2))->getMetadata();
  if (!MD || !isa<MDString>(MD))
    return FCmpInst::BAD_FCMP_PREDICATE;
  return StringSwitch<FCmpInst::Predicate>(cast<MDString>(MD)->getString())
           .Case("oeq", FCmpInst::FCMP_OEQ)
           .Case("ogt", FCmpInst::FCMP_OGT)
           .Case("oge", FCmpInst::FCMP_OGE)
           .Case("olt", FCmpInst::FCMP_OLT)
           .Case("ole", FCmpInst::FCMP_OLE)
           .Case("one", FCmpInst::FCMP_ONE)
           .Case("ord", FCmpInst::FCMP_ORD)
           .Case("uno", FCmpInst::FCMP_UNO)
           .Case("ueq", FCmpInst::FCMP_UEQ)
           .Case("ugt", FCmpInst::FCMP_UGT)
           .Case("uge", FCmpInst::FCMP_UGE)
           .Case("ult", FCmpInst::FCMP_ULT)
           .Case("ule", FCmpInst::FCMP_ULE)
           .Case("une", FCmpInst::FCMP_UNE)
           .Default(FCmpInst::BAD_FCMP_PREDICATE);
}

bool ConstrainedFPIntrinsic::isUnaryOp() const {
  switch (getIntrinsicID()) {
    default:
      return false;
#define INSTRUCTION(NAME, NARG, ROUND_MODE, INTRINSIC)                         \
    case Intrinsic::INTRINSIC:                                                 \
      return NARG == 1;
#include "llvm/IR/ConstrainedOps.def"
  }
}

bool ConstrainedFPIntrinsic::isTernaryOp() const {
  switch (getIntrinsicID()) {
    default:
      return false;
#define INSTRUCTION(NAME, NARG, ROUND_MODE, INTRINSIC)                         \
    case Intrinsic::INTRINSIC:                                                 \
      return NARG == 3;
#include "llvm/IR/ConstrainedOps.def"
  }
}

bool ConstrainedFPIntrinsic::classof(const IntrinsicInst *I) {
  switch (I->getIntrinsicID()) {
#define INSTRUCTION(NAME, NARGS, ROUND_MODE, INTRINSIC)                        \
  case Intrinsic::INTRINSIC:
#include "llvm/IR/ConstrainedOps.def"
    return true;
  default:
    return false;
  }
}

ElementCount VPIntrinsic::getStaticVectorLength() const {
  auto GetVectorLengthOfType = [](const Type *T) -> ElementCount {
    auto VT = cast<VectorType>(T);
    auto ElemCount = VT->getElementCount();
    return ElemCount;
  };

  auto VPMask = getMaskParam();
  if (VPMask) {
    return GetVectorLengthOfType(VPMask->getType());
  }

  // only compose does not have a mask param
  assert(getIntrinsicID() == Intrinsic::vp_compose);
  return GetVectorLengthOfType(getType());
}

void VPIntrinsic::setMaskParam(Value *NewMask) {
  auto MaskPos = GetMaskParamPos(getIntrinsicID());
  assert(MaskPos.hasValue());
  this->setOperand(MaskPos.getValue(), NewMask);
}

void VPIntrinsic::setVectorLengthParam(Value *NewVL) {
  auto VLPos = GetVectorLengthParamPos(getIntrinsicID());
  assert(VLPos.hasValue());
  this->setOperand(VLPos.getValue(), NewVL);
}

Value *VPIntrinsic::getMaskParam() const {
  auto maskPos = GetMaskParamPos(getIntrinsicID());
  if (maskPos)
    return getArgOperand(maskPos.getValue());
  return nullptr;
}

Value *VPIntrinsic::getVectorLengthParam() const {
  auto vlenPos = GetVectorLengthParamPos(getIntrinsicID());
  if (vlenPos)
    return getArgOperand(vlenPos.getValue());
  return nullptr;
}

Optional<int> VPIntrinsic::GetMaskParamPos(Intrinsic::ID IntrinsicID) {
  switch (IntrinsicID) {
  default:
    return None;

#define REGISTER_VP_INTRINSIC(VPID, MASKPOS, VLENPOS)                          \
  case Intrinsic::VPID:                                                        \
    return MASKPOS;
#include "llvm/IR/VPIntrinsics.def"
  }
}

Optional<int> VPIntrinsic::GetVectorLengthParamPos(Intrinsic::ID IntrinsicID) {
  switch (IntrinsicID) {
  default:
    return None;

#define REGISTER_VP_INTRINSIC(VPID, MASKPOS, VLENPOS)                          \
  case Intrinsic::VPID:                                                        \
    return VLENPOS;
#include "llvm/IR/VPIntrinsics.def"
  }
}

bool VPIntrinsic::IsVPIntrinsic(Intrinsic::ID ID) {
  switch (ID) {
  default:
    return false;

#define REGISTER_VP_INTRINSIC(VPID, MASKPOS, VLENPOS)                          \
  case Intrinsic::VPID:                                                        \
    break;
#include "llvm/IR/VPIntrinsics.def"
  }
  return true;
}

Intrinsic::ID VPIntrinsic::GetConstrainedIntrinsicForVP(Intrinsic::ID VPID) {
  switch (VPID) {
  default:
    return Intrinsic::not_intrinsic;

#define HANDLE_VP_TO_CONSTRAINED_INTRIN(VPID, CFPID)                           \
  case Intrinsic::VPID:                                                        \
    return Intrinsic::CFPID;
#include "llvm/IR/VPIntrinsics.def"
  }
}

Intrinsic::ID VPIntrinsic::GetFunctionalIntrinsicForVP(Intrinsic::ID VPID) {
  switch (VPID) {
  default:
    return Intrinsic::not_intrinsic;

#define HANDLE_VP_TO_INTRIN(VPID, IID)                                         \
  case Intrinsic::VPID:                                                        \
    return Intrinsic::IID;
#include "llvm/IR/VPIntrinsics.def"
  }
}

// Equivalent non-predicated opcode
unsigned VPIntrinsic::GetFunctionalOpcodeForVP(Intrinsic::ID ID) {
  switch (ID) {
  default:
    return Instruction::Call;

#define HANDLE_VP_TO_OC(VPID, OC)                                              \
  case Intrinsic::VPID:                                                        \
    return Instruction::OC;
#include "llvm/IR/VPIntrinsics.def"
  }
}

Intrinsic::ID VPIntrinsic::GetForOpcode(unsigned OC) {
  switch (OC) {
  default:
    return Intrinsic::not_intrinsic;

#define HANDLE_VP_TO_OC(VPID, OC)                                              \
  case Instruction::OC:                                                        \
    return Intrinsic::VPID;
#include "llvm/IR/VPIntrinsics.def"
  }
}

bool VPIntrinsic::canIgnoreVectorLengthParam() const {
  using namespace PatternMatch;

  ElementCount EC = getStaticVectorLength();

  // No vlen param - no lanes masked-off by it.
  auto *VLParam = getVectorLengthParam();
  if (!VLParam)
    return true;

  // Note that the VP intrinsic causes undefined behavior if the Explicit Vector
  // Length parameter is strictly greater-than the number of vector elements of
  // the operation. This function returns true when this is detected statically
  // in the IR.

  // Check whether "W == vscale * EC.Min"
  if (EC.Scalable) {
    // Undig the DL
    auto ParMod = this->getModule();
    if (!ParMod)
      return false;
    const auto &DL = ParMod->getDataLayout();

    // Compare vscale patterns
    uint64_t ParamFactor;
    if (EC.Min > 1 &&
        match(VLParam, m_c_BinOp(m_ConstantInt(ParamFactor), m_VScale(DL)))) {
      return ParamFactor >= EC.Min;
    }
    if (match(VLParam, m_VScale(DL))) {
      return ParamFactor;
    }
    return false;
  }

  // standard SIMD operation
  auto VLConst = dyn_cast<ConstantInt>(VLParam);
  if (!VLConst)
    return false;

  uint64_t VLNum = VLConst->getZExtValue();
  if (VLNum >= EC.Min)
    return true;

  return false;
}

CmpInst::Predicate VPIntrinsic::getCmpPredicate() const {
  return static_cast<CmpInst::Predicate>(
      cast<ConstantInt>(getArgOperand(2))->getZExtValue());
}

Optional<fp::RoundingMode> VPIntrinsic::getRoundingMode() const {
  auto RmParamPos = GetRoundingModeParamPos(getIntrinsicID());
  if (!RmParamPos)
    return None;

  Metadata *MD = dyn_cast<MetadataAsValue>(getArgOperand(RmParamPos.getValue()))
                     ->getMetadata();
  if (!MD || !isa<MDString>(MD))
    return None;
  StringRef RoundingArg = cast<MDString>(MD)->getString();
  return StrToRoundingMode(RoundingArg);
}

Optional<fp::ExceptionBehavior> VPIntrinsic::getExceptionBehavior() const {
  auto EbParamPos = GetExceptionBehaviorParamPos(getIntrinsicID());
  if (!EbParamPos)
    return None;

  Metadata *MD = dyn_cast<MetadataAsValue>(getArgOperand(EbParamPos.getValue()))
                     ->getMetadata();
  if (!MD || !isa<MDString>(MD))
    return None;
  StringRef ExceptionArg = cast<MDString>(MD)->getString();
  return StrToExceptionBehavior(ExceptionArg);
}

/// \return The vector to reduce if this is a reduction operation.
Value *VPIntrinsic::getReductionVectorParam() const {
  auto PosOpt = GetReductionVectorParamPos(getIntrinsicID());
  if (!PosOpt.hasValue())
    return nullptr;
  return getArgOperand(PosOpt.getValue());
}

Optional<int> VPIntrinsic::GetReductionVectorParamPos(Intrinsic::ID VPID) {
  switch (VPID) {
  default:
    return None;

#define HANDLE_VP_REDUCTION(VPID, ACCUPOS, VECTORPOS)                          \
  case Intrinsic::VPID:                                                        \
    return VECTORPOS;
#include "llvm/IR/VPIntrinsics.def"
  }
}

/// \return The accumulator initial value if this is a reduction operation.
Value *VPIntrinsic::getReductionAccuParam() const {
  auto PosOpt = GetReductionAccuParamPos(getIntrinsicID());
  if (!PosOpt.hasValue())
    return nullptr;
  return getArgOperand(PosOpt.getValue());
}

Optional<int> VPIntrinsic::GetReductionAccuParamPos(Intrinsic::ID VPID) {
  switch (VPID) {
  default:
    return None;

#define HANDLE_VP_REDUCTION(VPID, ACCUPOS, VECTORPOS)                          \
  case Intrinsic::VPID:                                                        \
    return ACCUPOS;
#include "llvm/IR/VPIntrinsics.def"
  }
}

/// \return the alignment of the pointer used by this load/store/gather or
/// scatter.
MaybeAlign VPIntrinsic::getPointerAlignment() const {
  Optional<int> PtrParamOpt = GetMemoryPointerParamPos(getIntrinsicID());
  assert(PtrParamOpt.hasValue() && "no pointer argument!");
  unsigned AlignVal = this->getParamAlignment(PtrParamOpt.getValue());
  if (AlignVal) {
    return MaybeAlign(AlignVal);
  }
  return None;
}

/// \return The pointer operand of this load,store, gather or scatter.
Value *VPIntrinsic::getMemoryPointerParam() const {
  auto PtrParamOpt = GetMemoryPointerParamPos(getIntrinsicID());
  if (!PtrParamOpt.hasValue())
    return nullptr;
  return getArgOperand(PtrParamOpt.getValue());
}

Optional<int> VPIntrinsic::GetMemoryPointerParamPos(Intrinsic::ID VPID) {
  switch (VPID) {
  default:
    return None;

#define HANDLE_VP_IS_MEMOP(VPID, POINTERPOS, DATAPOS)                          \
  case Intrinsic::VPID:                                                        \
    return POINTERPOS;
#include "llvm/IR/VPIntrinsics.def"
  }
}

/// \return The data (payload) operand of this store or scatter.
Value *VPIntrinsic::getMemoryDataParam() const {
  auto DataParamOpt = GetMemoryDataParamPos(getIntrinsicID());
  if (!DataParamOpt.hasValue())
    return nullptr;
  return getArgOperand(DataParamOpt.getValue());
}

Optional<int> VPIntrinsic::GetMemoryDataParamPos(Intrinsic::ID VPID) {
  switch (VPID) {
  default:
    return None;

#define HANDLE_VP_IS_MEMOP(VPID, POINTERPOS, DATAPOS)                          \
  case Intrinsic::VPID:                                                        \
    return DATAPOS;
#include "llvm/IR/VPIntrinsics.def"
  }
}

Function *VPIntrinsic::GetDeclarationForParams(Module *M, Intrinsic::ID VPID,
                                               ArrayRef<Value *> Params,
                                               Type *VecRetTy) {
  assert(VPID != Intrinsic::not_intrinsic && "todo dispatch to default insts");

  bool IsArithOp = VPIntrinsic::IsBinaryVPOp(VPID) ||
                   VPIntrinsic::IsUnaryVPOp(VPID) ||
                   VPIntrinsic::IsTernaryVPOp(VPID);
  bool IsCmpOp = (VPID == Intrinsic::vp_icmp) || (VPID == Intrinsic::vp_fcmp);
  bool IsReduceOp = VPIntrinsic::IsVPReduction(VPID);
  bool IsShuffleOp =
      (VPID == Intrinsic::vp_compress) || (VPID == Intrinsic::vp_expand) ||
      (VPID == Intrinsic::vp_vshift) || (VPID == Intrinsic::vp_select) ||
      (VPID == Intrinsic::vp_compose);
  bool IsMemoryOp =
      (VPID == Intrinsic::vp_store) || (VPID == Intrinsic::vp_load) ||
      (VPID == Intrinsic::vp_store) || (VPID == Intrinsic::vp_load);
  bool IsCastOp =
      (VPID == Intrinsic::vp_fptosi) || (VPID == Intrinsic::vp_fptoui) ||
      (VPID == Intrinsic::vp_sitofp) || (VPID == Intrinsic::vp_uitofp) ||
      (VPID == Intrinsic::vp_fpext) || (VPID == Intrinsic::vp_fptrunc);

  Type *VecTy = nullptr;
  Type *VecPtrTy = nullptr;

  if (IsArithOp || IsCmpOp || IsCastOp) {
    Value &FirstOp = *Params[0];

    // Fetch the VP intrinsic
    VecTy = cast<VectorType>(FirstOp.getType());

  } else if (IsReduceOp) {
    auto VectorPosOpt = GetReductionVectorParamPos(VPID);
    Value *VectorParam = Params[VectorPosOpt.getValue()];

    VecTy = VectorParam->getType();

  } else if (IsMemoryOp) {
    auto DataPosOpt = VPIntrinsic::GetMemoryDataParamPos(VPID);
    auto PtrPosOpt = VPIntrinsic::GetMemoryPointerParamPos(VPID);
    VecPtrTy = Params[PtrPosOpt.getValue()]->getType();

    if (DataPosOpt.hasValue()) {
      // store-kind operation
      VecTy = Params[DataPosOpt.getValue()]->getType();
    } else {
      // load-kind operation
      VecTy = VecPtrTy->getPointerElementType();
    }

  } else if (IsShuffleOp) {
    VecTy = (VPID == Intrinsic::vp_select) ? Params[1]->getType()
                                           : Params[0]->getType();
  }

  auto TypeTokens = VPIntrinsic::GetTypeTokens(VPID);
  auto *VPFunc = Intrinsic::getDeclaration(
      M, VPID,
      VPIntrinsic::EncodeTypeTokens(TypeTokens, VecRetTy, VecPtrTy, *VecTy));
  assert(VPFunc && "not a VP intrinsic");

  return VPFunc;
}

VPIntrinsic::TypeTokenVec VPIntrinsic::GetTypeTokens(Intrinsic::ID ID) {
  switch (ID) {
  default:
    llvm_unreachable("not implemented!");

  case Intrinsic::vp_cos:
  case Intrinsic::vp_sin:
  case Intrinsic::vp_exp:
  case Intrinsic::vp_exp2:

  case Intrinsic::vp_log:
  case Intrinsic::vp_log2:
  case Intrinsic::vp_log10:
  case Intrinsic::vp_sqrt:
  case Intrinsic::vp_ceil:
  case Intrinsic::vp_floor:
  case Intrinsic::vp_round:
  case Intrinsic::vp_trunc:
  case Intrinsic::vp_rint:
  case Intrinsic::vp_nearbyint:

  case Intrinsic::vp_and:
  case Intrinsic::vp_or:
  case Intrinsic::vp_xor:
  case Intrinsic::vp_ashr:
  case Intrinsic::vp_lshr:
  case Intrinsic::vp_shl:
  case Intrinsic::vp_add:
  case Intrinsic::vp_sub:
  case Intrinsic::vp_mul:
  case Intrinsic::vp_sdiv:
  case Intrinsic::vp_udiv:
  case Intrinsic::vp_srem:
  case Intrinsic::vp_urem:

  case Intrinsic::vp_fadd:
  case Intrinsic::vp_fsub:
  case Intrinsic::vp_fmul:
  case Intrinsic::vp_fdiv:
  case Intrinsic::vp_frem:
  case Intrinsic::vp_pow:
  case Intrinsic::vp_powi:
  case Intrinsic::vp_maxnum:
  case Intrinsic::vp_minnum:
  case Intrinsic::vp_vshift:
    return TypeTokenVec{VPTypeToken::Vector};

  case Intrinsic::vp_select:
    return TypeTokenVec{VPTypeToken::Returned};

  case Intrinsic::vp_reduce_and:
  case Intrinsic::vp_reduce_or:
  case Intrinsic::vp_reduce_xor:

  case Intrinsic::vp_reduce_add:
  case Intrinsic::vp_reduce_mul:
  case Intrinsic::vp_reduce_fadd:
  case Intrinsic::vp_reduce_fmul:

  case Intrinsic::vp_reduce_fmin:
  case Intrinsic::vp_reduce_fmax:
  case Intrinsic::vp_reduce_smin:
  case Intrinsic::vp_reduce_smax:
  case Intrinsic::vp_reduce_umin:
  case Intrinsic::vp_reduce_umax:
    return TypeTokenVec{VPTypeToken::Vector};

  case Intrinsic::vp_gather:
  case Intrinsic::vp_load:
    return TypeTokenVec{VPTypeToken::Returned, VPTypeToken::Pointer};

  case Intrinsic::vp_scatter:
  case Intrinsic::vp_store:
    return TypeTokenVec{VPTypeToken::Pointer, VPTypeToken::Vector};

  case Intrinsic::vp_fpext:
  case Intrinsic::vp_fptrunc:
  case Intrinsic::vp_fptoui:
  case Intrinsic::vp_fptosi:
  case Intrinsic::vp_sitofp:
  case Intrinsic::vp_uitofp:
    return TypeTokenVec{VPTypeToken::Returned, VPTypeToken::Vector};

  case Intrinsic::vp_icmp:
  case Intrinsic::vp_fcmp:
    return TypeTokenVec{VPTypeToken::Vector};
  }
}

bool VPIntrinsic::isReductionOp() const {
  return IsVPReduction(getIntrinsicID());
}

bool VPIntrinsic::IsVPReduction(Intrinsic::ID ID) {
  switch (ID) {
  default:
    return false;

#define HANDLE_VP_REDUCTION(VPID, ACCUPOS, VECTORPOS)                          \
  case Intrinsic::VPID:                                                        \
    break;
#include "llvm/IR/VPIntrinsics.def"
  }

  return true;
}

bool VPIntrinsic::isConstrainedOp() const {
  return (getRoundingMode() != None &&
          getRoundingMode() != fp::RoundingMode::rmToNearest) ||
         (getExceptionBehavior() != None &&
          getExceptionBehavior() != fp::ExceptionBehavior::ebIgnore);
}

bool VPIntrinsic::isUnaryOp() const { return IsUnaryVPOp(getIntrinsicID()); }

bool VPIntrinsic::IsUnaryVPOp(Intrinsic::ID VPID) {
  switch (VPID) {
  default:
    return false;

#define HANDLE_VP_UNARYOP(VPID)                                                \
  case Intrinsic::VPID:                                                        \
    return true;
#include "llvm/IR/VPIntrinsics.def"
  }
}

bool VPIntrinsic::isBinaryOp() const { return IsBinaryVPOp(getIntrinsicID()); }

bool VPIntrinsic::IsBinaryVPOp(Intrinsic::ID VPID) {
  switch (VPID) {
  default:
    return false;

#define HANDLE_VP_IS_BINARY(VPID)                                              \
  case Intrinsic::VPID:                                                        \
    return true;
#include "llvm/IR/VPIntrinsics.def"
  }
}

bool VPIntrinsic::isTernaryOp() const {
  return IsTernaryVPOp(getIntrinsicID());
}

bool VPIntrinsic::IsTernaryVPOp(Intrinsic::ID VPID) {
  switch (VPID) {
  default:
    return false;

#define HANDLE_VP_IS_TERNARY(VPID)                                             \
  case Intrinsic::VPID:                                                        \
    return true;
#include "llvm/IR/VPIntrinsics.def"
  }
}

bool VPIntrinsic::isCompareOp() const {
  return IsCompareVPOp(getIntrinsicID());
}

bool VPIntrinsic::IsCompareVPOp(Intrinsic::ID VPID) {
  switch (VPID) {
  default:
    return false;

#define HANDLE_VP_IS_XCMP(VPID)                                                \
  case Intrinsic::VPID:                                                        \
    return true;
#include "llvm/IR/VPIntrinsics.def"
  }
}

Optional<int>
VPIntrinsic::GetExceptionBehaviorParamPos(Intrinsic::ID IntrinsicID) {
  switch (IntrinsicID) {
  default:
    return None;

#define HANDLE_VP_FPCONSTRAINT(VPID, ROUNDPOS, EXCEPTPOS)                      \
  case Intrinsic::VPID:                                                        \
    return EXCEPTPOS;
#include "llvm/IR/VPIntrinsics.def"
  }
}

Optional<int> VPIntrinsic::GetRoundingModeParamPos(Intrinsic::ID IntrinsicID) {
  switch (IntrinsicID) {
  default:
    return None;

#define HANDLE_VP_FPCONSTRAINT(VPID, ROUNDPOS, EXCEPTPOS)                      \
  case Intrinsic::VPID:                                                        \
    return ROUNDPOS;
#include "llvm/IR/VPIntrinsics.def"
  }
}

Intrinsic::ID VPIntrinsic::GetForIntrinsic(Intrinsic::ID IntrinsicID) {
  Optional<Intrinsic::ID> ConstrainedID;
  switch (IntrinsicID) {
  default:
    return Intrinsic::not_intrinsic;

#define HANDLE_VP_TO_CONSTRAINED_INTRIN(VPID, CFPID) return Intrinsic::VPID;
#define HANDLE_VP_TO_INTRIN(VPID, IID) return Intrinsic::VPID;
#include "llvm/IR/VPIntrinsics.def"
  }
}

VPIntrinsic::ShortTypeVec
VPIntrinsic::EncodeTypeTokens(VPIntrinsic::TypeTokenVec TTVec, Type *VecRetTy,
                              Type *VecPtrTy, Type &VectorTy) {
  ShortTypeVec STV;

  for (auto Token : TTVec) {
    switch (Token) {
    default:
      llvm_unreachable("unsupported token"); // unsupported VPTypeToken

    case VPIntrinsic::VPTypeToken::Vector:
      STV.push_back(&VectorTy);
      break;
    case VPIntrinsic::VPTypeToken::Pointer:
      STV.push_back(VecPtrTy);
      break;
    case VPIntrinsic::VPTypeToken::Returned:
      assert(VecRetTy);
      STV.push_back(VecRetTy);
      break;
    case VPIntrinsic::VPTypeToken::Mask:
      auto NumElems = VectorTy.getVectorNumElements();
      auto MaskTy =
          VectorType::get(Type::getInt1Ty(VectorTy.getContext()), NumElems);
      STV.push_back(MaskTy);
      break;
    }
  }

  return STV;
}

Instruction::BinaryOps BinaryOpIntrinsic::getBinaryOp() const {
  switch (getIntrinsicID()) {
  case Intrinsic::uadd_with_overflow:
  case Intrinsic::sadd_with_overflow:
  case Intrinsic::uadd_sat:
  case Intrinsic::sadd_sat:
    return Instruction::Add;
  case Intrinsic::usub_with_overflow:
  case Intrinsic::ssub_with_overflow:
  case Intrinsic::usub_sat:
  case Intrinsic::ssub_sat:
    return Instruction::Sub;
  case Intrinsic::umul_with_overflow:
  case Intrinsic::smul_with_overflow:
    return Instruction::Mul;
  default:
    llvm_unreachable("Invalid intrinsic");
  }
}

bool BinaryOpIntrinsic::isSigned() const {
  switch (getIntrinsicID()) {
  case Intrinsic::sadd_with_overflow:
  case Intrinsic::ssub_with_overflow:
  case Intrinsic::smul_with_overflow:
  case Intrinsic::sadd_sat:
  case Intrinsic::ssub_sat:
    return true;
  default:
    return false;
  }
}

unsigned BinaryOpIntrinsic::getNoWrapKind() const {
  if (isSigned())
    return OverflowingBinaryOperator::NoSignedWrap;
  else
    return OverflowingBinaryOperator::NoUnsignedWrap;
}
