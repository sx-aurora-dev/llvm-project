#ifndef LLVM_IR_VPBUILDER_H
#define LLVM_IR_VPBUILDER_H

#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/Value.h>
#include <llvm/IR/Instruction.h>
#include <llvm/IR/InstrTypes.h>
#include <llvm/IR/PredicatedInst.h>
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
};





namespace PatternMatch {
  // Factory class to generate instructions in a context
  template<typename MatcherContext>
  class MatchContextBuilder {
    public:
      // MatchContextBuilder(MatcherContext MC);
  };


// Context-free instruction builder
template<>
class MatchContextBuilder<EmptyContext> {
public:
  MatchContextBuilder(EmptyContext & EC) {}

  #define HANDLE_BINARY_INST(N, OPC, CLASS) \
    Instruction *Create##OPC(Value *V1, Value *V2, \
                                       const Twine &Name = "") const {\
      return BinaryOperator::Create(Instruction::OPC, V1, V2, Name);\
    } \
    template<typename IRBuilderType> \
    Instruction *Create##OPC(IRBuilderType & Builder, Value *V1, Value *V2, \
                                       const Twine &Name = "") const { \
      auto * Inst = BinaryOperator::Create(Instruction::OPC, V1, V2, Name); \
      Builder.Insert(Inst); return Inst; \
    } \
    Instruction *Create##OPC(Value *V1, Value *V2, \
                                       const Twine &Name, BasicBlock *BB) const {\
      return BinaryOperator::Create(Instruction::OPC, V1, V2, Name, BB);\
    } \
    Instruction *Create##OPC(Value *V1, Value *V2, \
                                       const Twine &Name, Instruction *I) const {\
      return BinaryOperator::Create(Instruction::OPC, V1, V2, Name, I);\
    } \
    Instruction *Create##OPC##FMF(Value *V1, Value *V2, Instruction *FMFSource, \
                                       const Twine &Name = "") const {\
      return BinaryOperator::CreateWithCopiedFlags(Instruction::OPC, V1, V2, FMFSource, Name);\
    } \
    template<typename IRBuilderType> \
    Instruction *Create##OPC##FMF(IRBuilderType& Builder, Value *V1, Value *V2, Instruction *FMFSource, \
                                       const Twine &Name = "") const {\
      auto * Inst = BinaryOperator::CreateWithCopiedFlags(Instruction::OPC, V1, V2, FMFSource, Name);\
      Builder.Insert(Inst); return Inst; \
    }
  #include "llvm/IR/Instruction.def"
  #undef HANDLE_BINARY_INST

  UnaryOperator *CreateFNegFMF(Value *Op, Instruction *FMFSource,
                                       const Twine &Name = "") {
    return UnaryOperator::CreateFNegFMF(Op, FMFSource, Name);
  }

  template<typename IRBuilderType>
  Value *CreateFPTrunc(IRBuilderType & Builder, Value *V, Type *DestTy, const Twine & Name = Twine()) { return Builder.CreateFPTrunc(V, DestTy, Name); }
  template<typename IRBuilderType>
  Value *CreateFPExt(IRBuilderType & Builder, Value *V, Type *DestTy, const Twine & Name = Twine()) { return Builder.CreateFPExt(V, DestTy, Name); }
};



// Context-free instruction builder
template<>
class MatchContextBuilder<PredicatedContext> {
  PredicatedContext & PC;
public:
  MatchContextBuilder(PredicatedContext & PC) : PC(PC) {}

  #define HANDLE_BINARY_INST(N, OPC, CLASS) \
    Instruction *Create##OPC(Value *V1, Value *V2, \
                                       const Twine &Name = "") const {\
      return PredicatedBinaryOperator::Create(PC.Mod, PC.Mask, PC.VectorLength, Instruction::OPC, V1, V2, Name);\
    } \
    template<typename IRBuilderType> \
    Instruction *Create##OPC(IRBuilderType & Builder, Value *V1, Value *V2, \
                                       const Twine &Name = "") const {\
      auto * PredInst = Create##OPC(V1, V2, Name); \
      Builder.Insert(PredInst); \
      return PredInst; \
    } \
    Instruction *Create##OPC(Value *V1, Value *V2, \
                                       const Twine &Name, BasicBlock *BB) const {\
      return PredicatedBinaryOperator::Create(PC.Mod, PC.Mask, PC.VectorLength, Instruction::OPC, V1, V2, Name, BB);\
    } \
    Instruction *Create##OPC(Value *V1, Value *V2, \
                                       const Twine &Name, Instruction *I) const {\
      return PredicatedBinaryOperator::Create(PC.Mod, PC.Mask, PC.VectorLength, Instruction::OPC, V1, V2, Name, I);\
    } \
    Instruction *Create##OPC##FMF(Value *V1, Value *V2, Instruction *FMFSource, \
                                       const Twine &Name = "") const {\
      return PredicatedBinaryOperator::CreateWithCopiedFlags(PC.Mod, PC.Mask, PC.VectorLength, Instruction::OPC, V1, V2, FMFSource, Name);\
    } \
    template<typename IRBuilderType> \
    Instruction *Create##OPC##FMF(IRBuilderType& Builder, Value *V1, Value *V2, Instruction *FMFSource, \
                                       const Twine &Name = "") const {\
      auto * Inst = PredicatedBinaryOperator::CreateWithCopiedFlags(PC.Mod, PC.Mask, PC.VectorLength, Instruction::OPC, V1, V2, FMFSource, Name);\
      Builder.Insert(Inst); return Inst; \
    }
  #include "llvm/IR/Instruction.def"
  #undef HANDLE_BINARY_INST

  Instruction *CreateFNegFMF(Value *Op, Instruction *FMFSource,
                                       const Twine &Name = "") {
    return PredicatedUnaryOperator::CreateWithCopiedFlags(PC.Mod, PC.Mask, PC.VectorLength, Instruction::FNeg, Op, FMFSource, Name);
  }

  // TODO predicated casts
  template<typename IRBuilderType>
  Value *CreateFPTrunc(IRBuilderType & Builder, Value *V, Type *DestTy, const Twine & Name = Twine()) { return Builder.CreateFPTrunc(V, DestTy, Name); }
  template<typename IRBuilderType>
  Value *CreateFPExt(IRBuilderType & Builder, Value *V, Type *DestTy, const Twine & Name = Twine()) { return Builder.CreateFPExt(V, DestTy, Name); }
};

}

} // namespace llvm

#endif // LLVM_IR_VPBUILDER_H
