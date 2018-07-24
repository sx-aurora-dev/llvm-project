if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
# this is a standalone build
  cmake_minimum_required(VERSION 2.8.8)
  set(SOTOC_STANDALONE_BUILD True)
endif()

################################################################################
# Base config
################################################################################

set(SOTOC_PROJECT_NAME sotoc)

set(USE_CLANG_LIBS clangFrontend
                   LLVMSupport
                   clangRewrite
                   clangDriver
                   clangSerialization
                   clangParse
                   clangRewriteFrontend
                   clangSema
                   clangAnalysis
                   clangEdit
                   clangAST
                   clangLex
                   clangBasic
                   clangTooling)

set(SOTOC_SOURCES src/main.cpp
                  src/TargetCode.cpp
                  src/TargetCodeFragment.cpp
                  src/Visitors.cpp
                  src/TypeDeclResolver.cpp)


################################################################################
# Standalone build
################################################################################

#TODO: Remove standalone build?
if (SOTOC_STANDALONE_BUILD)
  project(${SOTOC_PROJECT_NAME} C CXX)
  # Find Clang and set definitions and include directories accordingly
  if($ENV{CLANG_ROOT})
    set(CLANG_CONFIG_HINT HINTS $ENV{CLANG_ROOT}/lib/cmake/clang)
  endif()
  
  find_package(Clang REQUIRED CONFIG HINTS ${CLANG_CONFIG_HINT})

  #TODO: Check which flags are really required, make more generic
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++ -std=c++11 -Wno-unused-parameter -fno-strict-aliasing -fno-exceptions -fno-rtti")

  add_executable(${SOTOC_PROJECT_NAME} ${SOTOC_SOURCES})

################################################################################
# In-tree build
################################################################################

else()
  #set(CLANG_CONFIG_HINT ${CMAKE_BINARY_DIR}/lib/cmake/clang)
  #set(CLANG_LIBRARY_DIRS ${CMAKE_BINARY_DIR}/lib)
  #set(CLANG_INCLUDE_DIRS ${CMAKE_SOURCE_DIR}/include ${CMAKE_SOURCE_DIR}/tools/clang/include )
  #libomptarget_say("_________A__________${CLANG_INCLUDE_DIRS}")
  #libomptarget_say("_________B__________${CLANG_LIBRARY_DIRS}")
  #libomptarget_say("_________C__________${LLVMCONFIG_FILE}")
  add_clang_executable(${SOTOC_PROJECT_NAME} ${SOTOC_SOURCES})
endif()
#  include_directories(${CLANG_INCLUDE_DIRS})
#  link_directories(${CLANG_LIBRARY_DIRS})
#  add_definitions(${CLANG_DEFINITIONS})
  
#  add_definitions(
#  -D__STDC_LIMIT_MACROS
#  -D__STDC_CONSTANT_MACROS
#  )

################################################################################
# Link, install and tests
################################################################################

target_link_libraries(${SOTOC_PROJECT_NAME} PRIVATE ${USE_LLVM_LIBS} ${USE_CLANG_LIBS})

install(TARGETS ${SOTOC_PROJECT_NAME} DESTINATION bin)

option(SOTOC_ENABLE_TESTS OFF)

if(SOTOC_ENABLE_TESTS)
  add_subdirectory(test)
endif()
