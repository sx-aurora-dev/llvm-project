#include <llvm/IR/VPBuilder.h>
#include <llvm/IR/Intrinsics.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/PredicatedInst.h>
#include <llvm/ADT/SmallVector.h>

namespace {
  using namespace llvm;
  using ShortTypeVec = VPIntrinsic::ShortTypeVec;
  using ShortValueVec = SmallVector<Value*, 4>;
}

namespace llvm {

Module &
VPBuilder::getModule() const {
  return *Builder.GetInsertBlock()->getParent()->getParent();
}

Value&
VPBuilder::GetMaskForType(VectorType & VecTy) {
  if (Mask) return *Mask;

  auto * boolTy = Builder.getInt1Ty();
  auto * maskTy = VectorType::get(boolTy, StaticVectorLength);
  return *ConstantInt::getAllOnesValue(maskTy);
}

Value&
VPBuilder::GetEVLForType(VectorType & VecTy) {
  if (ExplicitVectorLength) return *ExplicitVectorLength;

  auto * intTy = Builder.getInt32Ty();
  return *ConstantInt::get(intTy, StaticVectorLength);
}

Value*
VPBuilder::CreateVectorCopy(Instruction & Inst, ValArray VecOpArray) {
  auto OC = Inst.getOpcode();
  auto VPID = VPIntrinsic::GetForOpcode(OC);
  if (VPID == Intrinsic::not_intrinsic) {
    return nullptr;
  }

  abort(); // TODO implement

  return nullptr;
}


VectorType&
VPBuilder::getVectorType(Type &ElementTy) {
  return *VectorType::get(&ElementTy, StaticVectorLength);
}

Value&
VPBuilder::CreateContiguousStore(Value & Val, Value & Pointer, Align Alignment) {
  auto & VecTy = cast<VectorType>(*Val.getType());
  auto * StoreFunc = Intrinsic::getDeclaration(&getModule(), Intrinsic::vp_store, {Val.getType(), Pointer.getType()});
  ShortValueVec Args{&Val, &Pointer, &GetMaskForType(VecTy), &GetEVLForType(VecTy)};
  CallInst &StoreCall = *Builder.CreateCall(StoreFunc, Args);
  if (Alignment != None) StoreCall.addParamAttr(1, Attribute::getWithAlignment(getContext(), Alignment));
  return StoreCall;
}

Value&
VPBuilder::CreateContiguousLoad(Value & Pointer, Align Alignment) {
  auto & PointerTy = cast<PointerType>(*Pointer.getType());
  auto & VecTy = getVectorType(*PointerTy.getPointerElementType());

  auto * LoadFunc = Intrinsic::getDeclaration(&getModule(), Intrinsic::vp_load, {&VecTy, &PointerTy});
  ShortValueVec Args{&Pointer, &GetMaskForType(VecTy), &GetEVLForType(VecTy)};
  CallInst &LoadCall= *Builder.CreateCall(LoadFunc, Args);
  if (Alignment != None) LoadCall.addParamAttr(1, Attribute::getWithAlignment(getContext(), Alignment));
  return LoadCall;
}

Value&
VPBuilder::CreateScatter(Value & Val, Value & PointerVec, Align Alignment) {
  auto & VecTy = cast<VectorType>(*Val.getType());
  auto * ScatterFunc = Intrinsic::getDeclaration(&getModule(), Intrinsic::vp_scatter, {Val.getType(), PointerVec.getType()});
  ShortValueVec Args{&Val, &PointerVec, &GetMaskForType(VecTy), &GetEVLForType(VecTy)};
  CallInst &ScatterCall = *Builder.CreateCall(ScatterFunc, Args);
  if (Alignment != None) ScatterCall.addParamAttr(1, Attribute::getWithAlignment(getContext(), Alignment));
  return ScatterCall;
}

Value&
VPBuilder::CreateGather(Value & PointerVec, Align Alignment) {
  auto & PointerVecTy = cast<VectorType>(*PointerVec.getType());
  auto & ElemTy = *cast<PointerType>(*PointerVecTy.getVectorElementType()).getPointerElementType();
  auto & VecTy = *VectorType::get(&ElemTy, PointerVecTy.getNumElements());
  auto * GatherFunc = Intrinsic::getDeclaration(&getModule(), Intrinsic::vp_gather, {&VecTy, &PointerVecTy});

  ShortValueVec Args{&PointerVec, &GetMaskForType(VecTy), &GetEVLForType(VecTy)};
  CallInst &GatherCall = *Builder.CreateCall(GatherFunc, Args);
  if (Alignment != None) GatherCall.addParamAttr(1, Attribute::getWithAlignment(getContext(), Alignment));
  return GatherCall;
}

} // namespace llvm
