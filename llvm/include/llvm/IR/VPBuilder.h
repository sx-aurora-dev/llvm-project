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
  int StaticVectorLength;

  // get a valid mask/evl argument for the current predication contet
  Value& RequestPred();
  Value& RequestEVL();

public:
  VPBuilder(IRBuilder<> & _builder)
  : Builder(_builder)
  , Mask(nullptr)
  , ExplicitVectorLength(nullptr)
  , StaticVectorLength(-1)
  {}

  Module & getModule() const;
  LLVMContext & getContext() const { return Builder.getContext(); }

  // The cannonical vector type for this \p ElementTy
  VectorType& getVectorType(Type &ElementTy);

  // Predication context tracker
  VPBuilder& setMask(Value * _Mask) { Mask = _Mask;  return *this; }
  VPBuilder& setEVL(Value * _ExplicitVectorLength) { ExplicitVectorLength = _ExplicitVectorLength; return *this; }
  VPBuilder& setStaticVL(int VLen) { StaticVectorLength = VLen; return *this; }

  // Create a map-vectorized copy of the instruction \p Inst with the underlying IRBuilder instance.
  // This operation may return nullptr if the instruction could not be vectorized.
  Value* CreateVectorCopy(Instruction & Inst, ValArray VecOpArray);

  // shift the elements in \p SrcVal by Amount where the result lane is true.
  Value* CreateVectorShift(Value *SrcVal, Value *Amount, Twine Name="");

  // Memory
  Value& CreateContiguousStore(Value & Val, Value & Pointer, MaybeAlign Alignment);
  Value& CreateContiguousLoad(Value & Pointer, MaybeAlign Alignment);
  Value& CreateScatter(Value & Val, Value & PointerVec, MaybeAlign Alignment);
  Value& CreateGather(Value & PointerVec, MaybeAlign Alignment);
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
    Value *Create##OPC(IRBuilderType & Builder, Value *V1, Value *V2, \
                                       const Twine &Name = "") const { \
      auto * Inst = BinaryOperator::Create(Instruction::OPC, V1, V2, Name); \
      Builder.Insert(Inst); return Inst; \
    }
  #include "llvm/IR/Instruction.def"
  #define HANDLE_BINARY_INST(N, OPC, CLASS) \
    Value *Create##OPC(Value *V1, Value *V2, \
                                       const Twine &Name, BasicBlock *BB) const {\
      return BinaryOperator::Create(Instruction::OPC, V1, V2, Name, BB);\
    }
 #include "llvm/IR/Instruction.def"
  #define HANDLE_BINARY_INST(N, OPC, CLASS) \
    Value *Create##OPC(Value *V1, Value *V2, \
                                       const Twine &Name, Instruction *I) const {\
      return BinaryOperator::Create(Instruction::OPC, V1, V2, Name, I);\
    }
  #include "llvm/IR/Instruction.def"
  #undef HANDLE_BINARY_INST

  BinaryOperator *CreateFAddFMF(Value *V1, Value *V2,
                                       Instruction *FMFSource,
                                       const Twine &Name = "") {
    return BinaryOperator::CreateWithCopiedFlags(Instruction::FAdd, V1, V2, FMFSource, Name);
  }
  BinaryOperator *CreateFSubFMF(Value *V1, Value *V2,
                                       Instruction *FMFSource,
                                       const Twine &Name = "") {
    return BinaryOperator::CreateWithCopiedFlags(Instruction::FSub, V1, V2, FMFSource, Name);
  }
  template<typename IRBuilderType>
  BinaryOperator *CreateFSubFMF(IRBuilderType & Builder, Value *V1, Value *V2,
                                       Instruction *FMFSource,
                                       const Twine &Name = "") {
    auto * Inst = CreateFSubFMF(V1, V2, FMFSource, Name);
    Builder.Insert(Inst); return Inst;
  }
  BinaryOperator *CreateFMulFMF(Value *V1, Value *V2,
                                       Instruction *FMFSource,
                                       const Twine &Name = "") {
    return BinaryOperator::CreateWithCopiedFlags(Instruction::FMul, V1, V2, FMFSource, Name);
  }
  BinaryOperator *CreateFDivFMF(Value *V1, Value *V2,
                                       Instruction *FMFSource,
                                       const Twine &Name = "") {
    return BinaryOperator::CreateWithCopiedFlags(Instruction::FDiv, V1, V2, FMFSource, Name);
  }
  BinaryOperator *CreateFRemFMF(Value *V1, Value *V2,
                                       Instruction *FMFSource,
                                       const Twine &Name = "") {
    return BinaryOperator::CreateWithCopiedFlags(Instruction::FRem, V1, V2, FMFSource, Name);
  }
  BinaryOperator *CreateFNegFMF(Value *Op, Instruction *FMFSource,
                                       const Twine &Name = "") {
    Value *Zero = ConstantFP::getNegativeZero(Op->getType());
    return BinaryOperator::CreateWithCopiedFlags(Instruction::FSub, Zero, Op, FMFSource);
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
      auto * PredInst = Create##OPC(V1, V2, Name); Builder.Insert(PredInst); return PredInst; \
    }
  #include "llvm/IR/Instruction.def"
  #define HANDLE_BINARY_INST(N, OPC, CLASS) \
    Instruction *Create##OPC(Value *V1, Value *V2, \
                                       const Twine &Name, BasicBlock *BB) const {\
      return PredicatedBinaryOperator::Create(PC.Mod, PC.Mask, PC.VectorLength, Instruction::OPC, V1, V2, Name, BB);\
    }
  #include "llvm/IR/Instruction.def"
  #define HANDLE_BINARY_INST(N, OPC, CLASS) \
    Instruction *Create##OPC(Value *V1, Value *V2, \
                                       const Twine &Name, Instruction *I) const {\
      return PredicatedBinaryOperator::Create(PC.Mod, PC.Mask, PC.VectorLength, Instruction::OPC, V1, V2, Name, I);\
    }
  #include "llvm/IR/Instruction.def"
  #undef HANDLE_BINARY_INST

  Instruction *CreateFAddFMF(Value *V1, Value *V2,
                                       Instruction *FMFSource,
                                       const Twine &Name = "") {
    return PredicatedBinaryOperator::CreateWithCopiedFlags(PC.Mod, PC.Mask, PC.VectorLength, Instruction::FAdd, V1, V2, FMFSource, Name);
  }
  Instruction *CreateFSubFMF(Value *V1, Value *V2,
                                       Instruction *FMFSource,
                                       const Twine &Name = "") {
    return PredicatedBinaryOperator::CreateWithCopiedFlags(PC.Mod, PC.Mask, PC.VectorLength, Instruction::FSub, V1, V2, FMFSource, Name);
  }
  template<typename IRBuilderType>
  Instruction *CreateFSubFMF(IRBuilderType & Builder, Value *V1, Value *V2,
                                       Instruction *FMFSource,
                                       const Twine &Name = "") {
    auto * Inst = CreateFSubFMF(V1, V2, FMFSource, Name);
    Builder.Insert(Inst); return Inst;
  }
  Instruction *CreateFMulFMF(Value *V1, Value *V2,
                                       Instruction *FMFSource,
                                       const Twine &Name = "") {
    return PredicatedBinaryOperator::CreateWithCopiedFlags(PC.Mod, PC.Mask, PC.VectorLength, Instruction::FMul, V1, V2, FMFSource, Name);
  }
  Instruction *CreateFDivFMF(Value *V1, Value *V2,
                                       Instruction *FMFSource,
                                       const Twine &Name = "") {
    return PredicatedBinaryOperator::CreateWithCopiedFlags(PC.Mod, PC.Mask, PC.VectorLength, Instruction::FDiv, V1, V2, FMFSource, Name);
  }
  Instruction *CreateFRemFMF(Value *V1, Value *V2,
                                       Instruction *FMFSource,
                                       const Twine &Name = "") {
    return PredicatedBinaryOperator::CreateWithCopiedFlags(PC.Mod, PC.Mask, PC.VectorLength, Instruction::FRem, V1, V2, FMFSource, Name);
  }
  Instruction *CreateFNegFMF(Value *Op, Instruction *FMFSource,
                                       const Twine &Name = "") {
    Value *Zero = ConstantFP::getNegativeZero(Op->getType());
    return PredicatedBinaryOperator::CreateWithCopiedFlags(PC.Mod, PC.Mask, PC.VectorLength, Instruction::FSub, Zero, Op, FMFSource);
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
