#include <llvm/IR/InstrTypes.h>
#include <llvm/IR/Instruction.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/IntrinsicInst.h>
#include <llvm/IR/PredicatedInst.h>

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

} // namespace llvm
