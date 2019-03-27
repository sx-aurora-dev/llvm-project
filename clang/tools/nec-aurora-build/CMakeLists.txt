if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
  cmake_minimum_required(VERSION 2.8.8)
  project("NEC Aurora Offloading Build Wrapper Tools" CXX)
endif()

# Find NEC target compiler.
find_program(NECAURORA_TARGET_COMPILER ncc
  DOC "NEC target compiler."
  PATHS
    "/opt/nec/ve/bin/")

if(NOT NECAURORA_TARGET_COMPILER)
  message(STATUS "NEC target compiler could not be found, defaulting to GCC.")
  # Use a separate variable to print this message every time.
  find_program(NECAURORA_TARGET_COMPILER_GCC gcc)
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
