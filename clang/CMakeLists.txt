
############################################################
#   base
############################################################

cmake_minimum_required(VERSION 2.8.8)


############################################################
#   setting Project informations
############################################################

set(PROJECT_NAME sotoc)

set(LIBRARY_LIST clangFrontend  clangRewrite clangSerialization clangDriver clangParse clangRewriteFrontend clangStaticAnalyzerFrontend clangSema)
set(LIBRARY_LIST ${LIBRARY_LIST} clangAnalysis clangEdit clangAST clangLex clangBasic clangTooling )
set(COMPONENT_LIST mcparser bitreader support mc option)

############################################################
#   generate makefiles
############################################################

project(${PROJECT_NAME})

find_package(LLVM REQUIRED CONFIG)
message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

include_directories(${LLVM_INCLUDE_DIRS})
if(LLVM_BUILD_MAIN_SRC_DIR)
  include_directories(${LLVM_BUILD_MAIN_SRC_DIR}/tools/clang/include)
  include_directories(${LLVM_BUILD_BINARY_DIR}/tools/clang/include)
endif()
link_directories(${LLVM_LIBRARY_DIRS})
add_definitions(${LLVM_DEFINITIONS})

add_definitions(
-D__STDC_LIMIT_MACROS
-D__STDC_CONSTANT_MACROS
)

add_executable(${PROJECT_NAME} src/main.cpp
                               src/TargetCode.cpp
                               src/TargetCodeFragment.cpp
                               src/Visitors.cpp
                               src/TypeDeclResolver.cpp)

target_link_libraries(${PROJECT_NAME} ${LIBRARY_LIST})
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wno-unused-parameter -fno-strict-aliasing -fno-exceptions -fno-rtti")

#llvm_map_components_to_libnames(llvm_libs ${COMPONENT_LIST})
#target_link_libraries(${PROJECT_NAME} ${llvm_libs})
target_link_libraries(${PROJECT_NAME}
  LLVMX86AsmParser # MC, MCParser, Support, X86Desc, X86Info
  LLVMX86Desc # MC, Support, X86AsmPrinter, X86Info
  LLVMX86AsmPrinter # MC, Support, X86Utils
  LLVMX86Info # MC, Support, Target
  LLVMX86Utils # Core, Support
  LLVMipo
  LLVMScalarOpts
  LLVMInstCombine
  LLVMTransformUtils
  LLVMAnalysis
  LLVMTarget
  LLVMOption # Support
  LLVMMCParser # MC, Support
  LLVMMC # Object, Support
  LLVMObject # BitReader, Core, Support
  LLVMBitReader # Core, Support
  LLVMCore # Support
  LLVMSupport 
)

install(TARGETS ${PROJECT_NAME} DESTINATION bin)
