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

Instruction *PredicatedBinaryOperator::Create(
    Module *Mod, Value *Mask, Value *VectorLen, Instruction::BinaryOps Opc,
    Value *V1, Value *V2, const Twine &Name, BasicBlock *InsertAtEnd,
    Instruction *InsertBefore) {
  assert(!(InsertAtEnd && InsertBefore));
  auto VPID = VPIntrinsic::GetForOpcode(Opc);

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
  auto TypeTokens = VPIntrinsic::GetTypeTokens(VPID);
  auto *VPFunc = Intrinsic::getDeclaration(
      Mod, VPID,
      VPIntrinsic::EncodeTypeTokens(TypeTokens, &VecTy, nullptr, VecTy));

  // Encode default environment fp behavior
  LLVMContext &Ctx = V1->getContext();
  SmallVector<Value *, 6> BinOpArgs({V1, V2});
  if (VPIntrinsic::HasRoundingModeParam(VPID)) {
    BinOpArgs.push_back(
        GetConstrainedFPRounding(Ctx, fp::RoundingMode::rmToNearest));
  }
  if (VPIntrinsic::HasExceptionBehaviorParam(VPID)) {
    BinOpArgs.push_back(
        GetConstrainedFPExcept(Ctx, fp::ExceptionBehavior::ebIgnore));
  }

  BinOpArgs.push_back(Mask);
  BinOpArgs.push_back(VectorLen);

  CallInst *CI;
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
