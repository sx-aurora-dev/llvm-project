if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
  cmake_minimum_required(VERSION 2.8.8)
  project("NEC Aurora Offloading Build Wrapper Tools" CXX)
endif()

# Find NEC target compiler.
find_program(NECAURORA_TARGET_COMPILER_NCC
  NAMES
    ncc
    ncc-3.1.0
    ncc-3.0.8
    ncc-3.0.7
    ncc-3.0.6
    ncc-3.0.4
    ncc-3.0.1
    ncc-2.5.1
    ncc-2.4.1
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
else()
    set(TARGET_COMPILER_NCC "/opt/nec/ve/bin/ncc")
    message(WARNING "- sotoc: Could not find ncc compiler. Defaulting to path ${TARGET_COMPILER_NCC}")
endif()

# Set Clang and RVClang target compiler variables
set(NECAURORA_TARGET_COMPILER_CLANG
    "${CMAKE_INSTALL_PREFIX}/bin/clang"
    CACHE
    FILEPATH
    "Path to clang used as VE target compiler")
set(NECAURORA_TARGET_COMPILER_RVCLANG
    "${CMAKE_INSTALL_PREFIX}/bin/rvclang"
    CACHE FILEPATH
    "Path to rvclang used as VE target compiler")

set(NECAURORA_DEFAULT_TARGET_COMPILER
    "ncc"
    CACHE STRING
    "Default target compiler for NEC OpenMP target (-fopenmp-nec-compiler=<this_value>)")
message("- sotoc: Using the default target compiler option \"${NECAURORA_DEFAULT_TARGET_COMPILER}\"" )

  find_library(
      NECAURORA_LIBAVEOVE_STATIC
    NAMES
      libaveoVE.a
    PATHS
      /usr/lib
      /usr/local/lib
      /opt/lcoal/lib
      /sw/lib
      /opt/nec/ve/lib
      ENV LIBRARY_PATH)

find_library(
    NECAURORA_LIBURPCVE_STATIC
  NAMES
    liburpcVE_omp.a
  PATHS
    /usr/lib
    /usr/local/lib
    /opt/lcoal/lib
    /sw/lib
    /opt/nec/ve/lib
    ENV LIBRARY_PATH)

find_library(
    NECAURORA_LIBVEIO
  NAMES
    libveio.so
  PATHS
    /usr/lib
    /usr/local/lib
    /opt/lcoal/lib
    /sw/lib
    /opt/nec/ve/lib
    ENV LIBRARY_PATH)

# We have all libraries: We can have the wrapper statically link stuff
if(NECAURORA_LIBAVEOVE_STATIC AND NECAURORA_LIBURPCVE_STATIC AND NECAURORA_LIBVEIO)
  get_filename_component(LIBVEIO_DIR ${NECAURORA_LIBVEIO} DIRECTORY)
  set(STATIC_LIBRARY_PATHS "${NECAURORA_LIBAVEOVE_STATIC}")
  set(STATIC_LIBRARY_PATHS "${STATIC_LIBRARY_PATHS} ${NECAURORA_LIBURPCVE_STATIC}")
  set(STATIC_LIBRARY_PATHS "${STATIC_LIBRARY_PATHS} -Wl,-rpath,${LIBVEIO_DIR} -lveio")
else()
  unset(STATIC_LIBRARY_PATHS)
endif()

find_package(NECAURORA_LIBELF)
if(NOT NECAURORA_LIBELF_FOUND)
  message(FATAL_ERROR "- sotoc: LIBELF not found.")
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
