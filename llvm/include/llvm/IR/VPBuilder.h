#ifndef LLVM_IR_VPBUILDER_H
#define LLVM_IR_VPBUILDER_H

#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/Value.h>
#include <llvm/IR/Instruction.h>
#include <llvm/IR/InstrTypes.h>
#include <llvm/IR/PatternMatch.h>

namespace llvm {

using ValArray = ArrayRef<Value*>;

class VPBuilder {
  IRBuilder<> & Builder;

  // Explicit mask parameter
  Value * Mask;
  // Explicit vector length parameter
  Value * ExplicitVectorLength;
  // Compile-time vector length
  ElementCount StaticVectorLength;

  // get a valid mask/evl argument for the current predication contet
  Value& RequestPred();
  Value& RequestEVL();

public:
  VPBuilder(IRBuilder<> &_builder)
      : Builder(_builder), Mask(nullptr), ExplicitVectorLength(nullptr),
        StaticVectorLength(ElementCount::getFixed(0)) {}

  Module & getModule() const;
  LLVMContext & getContext() const { return Builder.getContext(); }

  // The cannonical vector type for this \p ElementTy
  VectorType& getVectorType(Type &ElementTy);

  Value* getAllTrueMask();

  // Predication context tracker
  VPBuilder &setMask(Value *_Mask) {
    Mask = _Mask;
    return *this;
  }
  VPBuilder &setEVL(Value *_ExplicitVectorLength) {
    ExplicitVectorLength = _ExplicitVectorLength;
    return *this;
  }
  VPBuilder &setStaticVL(unsigned FixedVL) {
    StaticVectorLength = ElementCount::getFixed(FixedVL);
    return *this;
  }
  VPBuilder &setStaticVL(ElementCount ScalableVL) {
    assert(false && "TODO implement vscale handling");
    StaticVectorLength = ScalableVL;
    return *this;
  }

  // Create a map-vectorized copy of the instruction \p Inst with the underlying IRBuilder instance.
  // This operation may return nullptr if the instruction could not be vectorized.
  Value* CreateVectorCopy(Instruction & Inst, ValArray VecOpArray);

  // shift the elements in \p SrcVal by Amount where the result lane is true.
  Value* CreateVectorShift(Value *SrcVal, Value *Amount, Twine Name="");

  // Memory
  Value& CreateContiguousStore(Value & Val, Value & Pointer, MaybeAlign Alignment);
  Value& CreateContiguousLoad(Type *ReturnTy, Value & Pointer, MaybeAlign Alignment);
  Value& CreateScatter(Value & Val, Value & PointerVec, MaybeAlign Alignment);
  Value& CreateGather(Type *ReturnTy, Value & PointerVec, MaybeAlign Alignment);
  Value &createSelect(Value &OnTrue, Value &OnFalse, Value &Mask, Value &Pivot,
                      Twine Name = "");
};

} // namespace llvm

#endif // LLVM_IR_VPBUILDER_H
