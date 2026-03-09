//===- VE.cpp -------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "ABIInfoImpl.h"
#include "TargetInfo.h"
#include "llvm/IR/DerivedTypes.h"

using namespace clang;
using namespace clang::CodeGen;

// Rewrite the type of inline asm operands for vector mask registers.
// ConvertTypeForMem converts ext_vector_type(256) bool to i256 for memory
// representation, but inline asm with "v" constraint needs <256 x i1> to
// select VMRegClass instead of V64RegClass.
static llvm::Type *VEAdjustInlineAsmType(CodeGen::CodeGenFunction &CGF,
                                         StringRef Constraint,
                                         llvm::Type *Ty) {
  if (Constraint == "v") {
    if (auto *IntTy = dyn_cast<llvm::IntegerType>(Ty)) {
      unsigned BitWidth = IntTy->getBitWidth();
      if (BitWidth == 256 || BitWidth == 512) {
        llvm::Type *Int1Ty = llvm::Type::getInt1Ty(CGF.getLLVMContext());
        return llvm::FixedVectorType::get(Int1Ty, BitWidth);
      }
    }
  }
  return Ty;
}

//===----------------------------------------------------------------------===//
// VE ABI Implementation.
//
namespace {
class VEABIInfo : public DefaultABIInfo {
public:
  VEABIInfo(CodeGenTypes &CGT) : DefaultABIInfo(CGT) {}

private:
  ABIArgInfo classifyReturnType(QualType RetTy) const;
  ABIArgInfo classifyArgumentType(QualType RetTy) const;
  void computeInfo(CGFunctionInfo &FI) const override;
};
} // end anonymous namespace

ABIArgInfo VEABIInfo::classifyReturnType(QualType Ty) const {
  if (Ty->isAnyComplexType())
    return ABIArgInfo::getDirect();
  uint64_t Size = getContext().getTypeSize(Ty);
  if (Size < 64 && Ty->isIntegerType())
    return ABIArgInfo::getExtend(Ty);
  return DefaultABIInfo::classifyReturnType(Ty);
}

ABIArgInfo VEABIInfo::classifyArgumentType(QualType Ty) const {
  if (Ty->isAnyComplexType())
    return ABIArgInfo::getDirect();
  uint64_t Size = getContext().getTypeSize(Ty);
  if (Size < 64 && Ty->isIntegerType())
    return ABIArgInfo::getExtend(Ty);
  return DefaultABIInfo::classifyArgumentType(Ty);
}

void VEABIInfo::computeInfo(CGFunctionInfo &FI) const {
  FI.getReturnInfo() = classifyReturnType(FI.getReturnType());
  for (auto &Arg : FI.arguments())
    Arg.info = classifyArgumentType(Arg.type);
}

namespace {
class VETargetCodeGenInfo : public TargetCodeGenInfo {
public:
  VETargetCodeGenInfo(CodeGenTypes &CGT)
      : TargetCodeGenInfo(std::make_unique<VEABIInfo>(CGT)) {}
  // VE ABI requires the arguments of variadic and prototype-less functions
  // are passed in both registers and memory.
  bool isNoProtoCallVariadic(const CallArgList &args,
                             const FunctionNoProtoType *fnType) const override {
    return true;
  }

  llvm::Type *adjustInlineAsmType(CodeGen::CodeGenFunction &CGF,
                                  StringRef Constraint,
                                  llvm::Type *Ty) const override {
    return VEAdjustInlineAsmType(CGF, Constraint, Ty);
  }
};
} // end anonymous namespace

std::unique_ptr<TargetCodeGenInfo>
CodeGen::createVETargetCodeGenInfo(CodeGenModule &CGM) {
  return std::make_unique<VETargetCodeGenInfo>(CGM.getTypes());
}
