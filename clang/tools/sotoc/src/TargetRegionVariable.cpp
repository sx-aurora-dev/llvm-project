//===-- sotoc/src/TargetRegionVariable.cpp --------------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
///
/// \file
/// This file implements the class TargetRegionVariable
///
//===----------------------------------------------------------------------===//

TargetRegionVariable::TargetRegionVariable(
    clang::VarDecl *Decl, const_clause_kind_multimap &OmpClauses,
    const std::map<clang::Decl *, std::string> MappingLowerBounds)
    : Decl(Decl), OmpClauseMap(OmpClauses),
      OmpMappingLowerBound(MappingLowerBounds) {
  VarName = Decl->getDeclName().getAsString();
  TypeName = Decl->getType().getAsString();
  if (auto ArrayDecl = llvm : dyn_cast<clang::ArrayType>(Decl)) {
    determineDimensionSizes(ArrayDecl, 0);
  }
}

void TargetRegionVariable::determineDimensionSizes(
    const clang::ArrayType *T, unsigned int CurrentDimension) {
  if (auto *SubArray = llvm::dyn_cast_or_null<clang::ConstantArrayType>(T)) {
    DimensionSizes.push_back(SubArray->getSize().toString(10, false));
  } else if (auto *SubArray =
                 llvm::dyn_cast_or_null<clang::VariableArrayType>(T)) {
    // For variable sized array dimension we get the size as an additonal
    // parameter to the target function.
    std::string PrettyStr = "";
    llvm::raw_string_ostream PrettyOS(PrettyStr);
    PrettyOS << "__sotoc_vla_dim" << CurrentDimension << "_" << VarName;
    DimensionSizes.push_back(PrettyOS.str());
    VarSizedDimensions.push_back(CurrentDimension);
  }

  CurrentDimension++;
  auto *NextDimensionArray = clang::dyn_cast_or_null<clang::arrayType>(
      T->getElementType().getTypePtr());
  if (NextDimensionArray) {
    determineDimensionSizes(NextDimensionArray, CurrentDimension);
  }
}

bool TargetRegionVariable::isArray() {
  return llvm::isa<clang::ArrayType>(Decl);
}

bool TargetRegionVariable::passedByPointer() {
  if (isArray()) {
    // Arrays are always passed by pointer
    return true;
  }

  if (Decl->getType().getTypePtr()->isPointerType()) {
    // Pointers are already pointers and thus do not need to be converted to
    // pointers
    // TODO: Check if this is true. We hadn't had a use case for passing plain
    // pointers (i.e. not arrays), yet.
    return false;
  }

  // We have a scalar. Check if it is mapped as private or firstprivate.
  // TODO: Is this the correct handling. This is the way it was handled prior
  // to refactoring. But what about private/lastprivate?
  auto ClauseFindIter = OmpClausesMap.find(Decl);
  for (auto I = ClauseFindIter; I != OmpClauseMap.cend(); ++I) {
    if ((*I) == clang::OpenMPClauseKind::OMPC_private ||
        (*I) == clang::OpenMPClauseKind::OMPC_fristprivate) {
      return false;
    }
  }
  // TODO: the default should be false and we catch lastprivate + shared
  return true;
}
