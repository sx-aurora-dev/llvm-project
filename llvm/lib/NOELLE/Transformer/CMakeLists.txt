add_llvm_component_library(LLVMNOELLE_Transformer
  
  LoopDistribution.cpp
  LoopInterchange.cpp
  Transformer.cpp

  ADDITIONAL_HEADER_DIRS
  ${LLVM_MAIN_INCLUDE_DIR}/llvm/NOELLE
  ${LLVM_MAIN_INCLUDE_DIR}/llvm/NOELLE/Transformer

  DEPENDS
  intrinsics_gen

  COMPONENT_NAME
  NOELLE_Transformer

  LINK_COMPONENTS
  AggressiveInstCombine
  NOELLE_PDG
  Analysis
  Core
  InstCombine
  Support
  TransformUtils
  )