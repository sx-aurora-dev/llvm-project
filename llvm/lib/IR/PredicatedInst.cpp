#include <llvm/IR/InstrTypes.h>
#include <llvm/IR/Instruction.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/IntrinsicInst.h>
#include <llvm/IR/PredicatedInst.h>

namespace {
using namespace llvm;
using ShortValueVec = SmallVector<Value *, 4>;
} // namespace

namespace llvm {

bool PredicatedInstruction::canIgnoreVectorLengthParam() const {
  auto VPI = dyn_cast<VPIntrinsic>(this);
  if (!VPI)
    return true;

  return VPI->canIgnoreVectorLengthParam();
}

FastMathFlags PredicatedInstruction::getFastMathFlags() const {
  return cast<Instruction>(this)->getFastMathFlags();
}

void PredicatedOperator::copyIRFlags(const Value *V, bool IncludeWrapFlags) {
  auto *I = dyn_cast<Instruction>(this);
  if (I)
    I->copyIRFlags(V, IncludeWrapFlags);
}

bool
PredicatedInstruction::isVectorReduction() const {
  auto VPI = dyn_cast<VPIntrinsic>(this);
  if (VPI)
    return isa<VPReductionIntrinsic>(VPI);
  auto II = dyn_cast<IntrinsicInst>(this);
  if (!II) return false;

  switch (II->getIntrinsicID()) {
  default:
    return false; 
  
  case Intrinsic::vector_reduce_add:
  case Intrinsic::vector_reduce_mul:
  case Intrinsic::vector_reduce_and:
  case Intrinsic::vector_reduce_or:
  case Intrinsic::vector_reduce_xor:
  case Intrinsic::vector_reduce_smin:
  case Intrinsic::vector_reduce_smax:
  case Intrinsic::vector_reduce_umin:
  case Intrinsic::vector_reduce_umax:
  case Intrinsic::vector_reduce_fadd:
  case Intrinsic::vector_reduce_fmul:
  case Intrinsic::vector_reduce_fmin:
  case Intrinsic::vector_reduce_fmax:
    return true;
  }
}

Instruction *PredicatedUnaryOperator::Create(
    Module *Mod, Value *Mask, Value *VectorLen, Instruction::UnaryOps Opc,
    Value *V, const Twine &Name, BasicBlock *InsertAtEnd,
    Instruction *InsertBefore) {
  assert(!(InsertAtEnd && InsertBefore));
  auto VPID = VPIntrinsic::getForOpcode(Opc);

  // Default Code Path
  if ((!Mod || (!Mask && !VectorLen)) || VPID == Intrinsic::not_intrinsic) {
    if (InsertAtEnd) {
      return UnaryOperator::Create(Opc, V, Name, InsertAtEnd);
    } else {
      return UnaryOperator::Create(Opc, V, Name, InsertBefore);
    }
  }

  assert(Mod && "Need a module to emit VP Intrinsics");

  // Fetch the VP intrinsic
  auto &VecTy = cast<VectorType>(*V->getType());
  auto *VPFunc =
      VPIntrinsic::getDeclarationForParams(Mod, VPID, &VecTy, {V});

  // Encode default environment fp behavior

#if 0
  // TODO
  LLVMContext &Ctx = V1->getContext();
  SmallVector<OperandBundleDef, 2> ConstraintBundles;
  if (VPIntrinsic::HasRoundingMode(VPID))
    ConstraintBundles.emplace_back(
        "cfp-round",
        GetConstrainedFPRounding(Ctx, RoundingMode::NearestTiesToEven));
  if (VPIntrinsic::HasExceptionMode(VPID))
    ConstraintBundles.emplace_back(
        "cfp-except",
        GetConstrainedFPExcept(Ctx, fp::ExceptionBehavior::ebIgnore));

  CallInst *CI;
  if (InsertAtEnd) {
    CI = CallInst::Create(VPFunc, BinOpArgs, ConstraintBundles, Name, InsertAtEnd);
  } else {
    CI = CallInst::Create(VPFunc, BinOpArgs, ConstraintBundles, Name, InsertBefore);
  }
#endif

  CallInst *CI;
  SmallVector<Value *, 3> UnOpArgs({V, Mask, VectorLen});
  if (InsertAtEnd) {
    CI = CallInst::Create(VPFunc, UnOpArgs, Name, InsertAtEnd);
  } else {
    CI = CallInst::Create(VPFunc, UnOpArgs, Name, InsertBefore);
  }

  // the VP inst does not touch memory if the exception behavior is
  // "fpecept.ignore"
  CI->setDoesNotAccessMemory();
  return CI;
}

Instruction *PredicatedBinaryOperator::Create(
    Module *Mod, Value *Mask, Value *VectorLen, Instruction::BinaryOps Opc,
    Value *V1, Value *V2, const Twine &Name, BasicBlock *InsertAtEnd,
    Instruction *InsertBefore) {
  assert(!(InsertAtEnd && InsertBefore));
  auto VPID = VPIntrinsic::getForOpcode(Opc);

  // Default Code Path
  if ((!Mod || (!Mask && !VectorLen)) || VPID == Intrinsic::not_intrinsic) {
    if (InsertAtEnd) {
      return BinaryOperator::Create(Opc, V1, V2, Name, InsertAtEnd);
    } else {
      return BinaryOperator::Create(Opc, V1, V2, Name, InsertBefore);
    }
  }

  assert(Mod && "Need a module to emit VP Intrinsics");

  // Fetch the VP intrinsic
  auto &VecTy = cast<VectorType>(*V1->getType());
  auto *VPFunc =
      VPIntrinsic::getDeclarationForParams(Mod, VPID, &VecTy, {V1, V2});

  // Encode default environment fp behavior

#if 0
  // TODO
  LLVMContext &Ctx = V1->getContext();
  SmallVector<OperandBundleDef, 2> ConstraintBundles;
  if (VPIntrinsic::HasRoundingMode(VPID))
    ConstraintBundles.emplace_back(
        "cfp-round",
        GetConstrainedFPRounding(Ctx, RoundingMode::NearestTiesToEven));
  if (VPIntrinsic::HasExceptionMode(VPID))
    ConstraintBundles.emplace_back(
        "cfp-except",
        GetConstrainedFPExcept(Ctx, fp::ExceptionBehavior::ebIgnore));

  CallInst *CI;
  if (InsertAtEnd) {
    CI = CallInst::Create(VPFunc, BinOpArgs, ConstraintBundles, Name, InsertAtEnd);
  } else {
    CI = CallInst::Create(VPFunc, BinOpArgs, ConstraintBundles, Name, InsertBefore);
  }
#endif

  CallInst *CI;
  SmallVector<Value *, 4> BinOpArgs({V1, V2, Mask, VectorLen});
  if (InsertAtEnd) {
    CI = CallInst::Create(VPFunc, BinOpArgs, Name, InsertAtEnd);
  } else {
    CI = CallInst::Create(VPFunc, BinOpArgs, Name, InsertBefore);
  }

  // the VP inst does not touch memory if the exception behavior is
  // "fpecept.ignore"
  CI->setDoesNotAccessMemory();
  return CI;
}

} // namespace llvm
