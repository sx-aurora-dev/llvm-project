add_llvm_component_library(LLVMNOELLE_LDA
  
  LoopDependenceAnalysis.cpp
  LoopHotness.cpp

  ADDITIONAL_HEADER_DIRS
  ${LLVM_MAIN_INCLUDE_DIR}/llvm/NOELLE
  ${LLVM_MAIN_INCLUDE_DIR}/llvm/NOELLE/LDA

  DEPENDS
  intrinsics_gen

  COMPONENT_NAME
  NOELLE_LDA

  LINK_COMPONENTS
  AggressiveInstCombine
  Analysis
  Core
  InstCombine
  Support
  TransformUtils
  )