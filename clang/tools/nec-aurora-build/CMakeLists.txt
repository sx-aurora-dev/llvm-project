if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
  cmake_minimum_required(VERSION 2.8.8)
  project("NEC Aurora Offloading Build Wrapper Tools" CXX)
endif()

# Set Clang and RVClang target compiler variables
if (CMAKE_BUILD_TYPE MATCHES RELEASE)
  set(NECAURORA_TARGET_COMPILER_CLANG
      "${CMAKE_INSTALL_PREFIX}/bin/clang"
      CACHE
      FILEPATH
      "Path to clang used as VE target compiler")
  set(NECAURORA_TARGET_COMPILER_RVCLANG
      "${CMAKE_INSTALL_PREFIX}/bin/rvclang"
      CACHE FILEPATH
      "Path to rvclang used as VE target compiler")
else() # most likely there won't be an install step
  set(NECAURORA_TARGET_COMPILER_CLANG
      "${CMAKE_BINARY_DIR}/bin/clang"
      CACHE
      FILEPATH
      "Path to clang used as VE target compiler")
  set(NECAURORA_TARGET_COMPILER_RVCLANG
      "${CMAKE_BINARY_DIR}/bin/rvclang"
      CACHE FILEPATH
      "Path to rvclang used as VE target compiler")
endif()

# Find NEC target compiler.
find_program(NECAURORA_TARGET_COMPILER_NCC
  NAMES
    ncc
    ncc-2.3.1
    ncc-2.3.0
  DOC "NEC target compiler."
  PATHS
    "/opt/nec/ve/bin/"
    ENV PATH)

# It is okay if we do not find ncc, we can fallback to Clang or RVCLang and
# will handlle the missing ncc in code.
if (NECAURORA_TARGET_COMPILER_NCC)
  set(TARGET_COMPILER_NCC "${NECAURORA_TARGET_COMPILER_NCC}")
  set(NECAURORA_DEFAULT_TARGET_COMPILER
      "ncc"
      CACHE STRING
      "Default target compiler for NEC OpenMP target (-fopenmp-nec-compiler=<this_value>)")
else()
  set(TARGET_COMPILER_NCC "ncc") # We check whether it exists at runtime
  set(NECAURORA_DEFAULT_TARGET_COMPILER
      "${NECAURORA_TARGET_COMPILER_CLANG}"
      CACHE STRING
      "Default target compiler for NEC OpenMP target (-fopenmp-nec-compiler=<this_value>)")
  message(WARNING "Could not find ncc compiler. ncc might not be available as VE target compiler")
endif()


message("OMPT for SX-Aurora: Using the default target compiler option \"${NECAURORA_DEFAULT_TARGET_COMPILER}\"" )

find_library(
   NECAURORA_LIBVEORUN_STATIC
  NAMES
    libveorun.a
  PATHS
    /usr/lib
    /usr/local/lib
    /opt/local/lib
    /sw/lib
    /opt/nec/ve/lib
    ENV LIBRARY_PATH
    ENV LD_LIBRARY_PATH)

set(NECAURORA_STATIC_LINKING_AVAILABLE 1)

if (NECAURORA_LIBVEORUN_STATIC)
    message(STATUS "Found libveorun.a")
    set(LIBVEORUN_STATIC_PATH "${NECAURORA_LIBVEORUN_STATIC}")
endif()

find_package(NECAURORA_LIBELF)
if(NOT NECAURORA_LIBELF_FOUND)
  # TODO: Really fatal error? Can we just exclude static linking?
  message(FATAL_ERROR "LIBELF not found.")
endif()

configure_file(config.h.in config.h @ONLY)
include_directories(${CMAKE_CURRENT_BINARY_DIR})

add_executable(necaurora-ofld-wrapper
               necaurora-ofld-wrapper.cpp
               compiler.cpp
               linker.cpp
               utils.cpp)

target_link_libraries(necaurora-ofld-wrapper
                      ${NECAURORA_LIBELF_LIBRARIES})

install(TARGETS necaurora-ofld-wrapper DESTINATION bin)
