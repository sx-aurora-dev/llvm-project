if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
  cmake_minimum_required(VERSION 2.8.8)
  project("NEC Aurora Offloading Build Wrapper Tools" CXX)
endif()

# Find NEC target compiler.
find_program(NECAURORA_TARGET_COMPILER
  NAMES
    ncc
    ncc-2.3.1
    ncc-2.3.0
  DOC "NEC target compiler."
  PATHS
    "/opt/nec/ve/bin/"
    ENV PATH)

# if ncc was not found and gcc is not set stop
if(NOT NECAURORA_TARGET_COMPILER AND NOT NECAURORA_TARGET_COMPILER_GCC)
  message(FATAL_ERROR "NEC target compiler not found and GCC not set, exiting.")
# if ncc was not found vut gcc is set, use gcc
elseif(NOT NECAURORA_TARGET_COMPILER)
  message(STATUS "NEC target compiler not found but GCC is set, using GCC.")
  set(NECAURORA_TARGET_COMPILER "${NECAURORA_TARGET_COMPILER_GCC}")
endif()

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
