add_llvm_component_library(LLVMNOELLE_PDG

  PDGAnalysis.cpp
  PDG.cpp
  PDGPrinter.cpp

  ADDITIONAL_HEADER_DIRS
  ${LLVM_MAIN_INCLUDE_DIR}/llvm/NOELLE
  ${LLVM_MAIN_INCLUDE_DIR}/llvm/NOELLE/PDG

  DEPENDS
  intrinsics_gen

  COMPONENT_NAME
  NOELLE_PDG

  LINK_COMPONENTS
  AggressiveInstCombine
  Analysis
  Core
  InstCombine
  Support
  TransformUtils
  )