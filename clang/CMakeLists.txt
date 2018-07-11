if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
# this is a standalone build
  cmake_minimum_required(VERSION 2.8.8)
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

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
  project(${SOTOC_PROJECT_NAME} C CXX)
endif()

################################################################################
# Find Clang and set definitions and include directories accordingly
################################################################################

if($ENV{CLANG_ROOT})
  set(CLANG_CONFIG_HINT HINTS $ENV{CLANG_ROOT}/lib/cmake/clang)
endif()

find_package(Clang REQUIRED CONFIG HINTS ${CLANG_CONFIG_HINT})
include_directories(${CLANG_INCLUDE_DIRS})
link_directories(${CLANG_LIBRARY_DIRS})
add_definitions(${CLANG_DEFINITIONS})

add_definitions(
-D__STDC_LIMIT_MACROS
-D__STDC_CONSTANT_MACROS
)


################################################################################
# Add actual binary
################################################################################

#TODO: Use "-stdlib=libc++" if set in llvm build after integration
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++ -std=c++11 -Wno-unused-parameter -fno-strict-aliasing -fno-exceptions -fno-rtti")

add_executable(${SOTOC_PROJECT_NAME} ${SOTOC_SOURCES})

target_link_libraries(${SOTOC_PROJECT_NAME} ${USE_LLVM_LIBS} ${USE_CLANG_LIBS})

install(TARGETS ${SOTOC_PROJECT_NAME} DESTINATION bin)

option(SOTOC_ENABLE_TESTS OFF)

if(SOTOC_ENABLE_TESTS)
  add_subdirectory(test)
endif()
