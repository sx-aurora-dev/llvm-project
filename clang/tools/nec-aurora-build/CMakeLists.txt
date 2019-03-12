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

find_package(NECAURORA_LIBELF)
if(NOT NECAURORA_LIBELF_FOUND)
  # TODO: Really fatal error? Can we just exclude static linking?
  message(FATAL_ERROR "LIBELF not found.")
endif()
configure_file(config.h.in config.h @ONLY)
include_directories(${CMAKE_CURRENT_BINARY_DIR})

add_executable(necaurora-ofld-cc1-wrapper
               necaurora-ofld-cc1-wrapper.cpp
               necaurora-utils.cpp)

add_executable(necaurora-ofld-tool-wrapper
               necaurora-ofld-tool-wrapper.cpp
               necaurora-utils.cpp)
target_link_libraries(necaurora-ofld-tool-wrapper
                      ${NECAURORA_LIBELF_LIBRARIES})

install(TARGETS necaurora-ofld-cc1-wrapper DESTINATION bin)


install(TARGETS necaurora-ofld-tool-wrapper DESTINATION bin)
add_clang_symlink(necaurora-linker-wrapper necaurora-ofld-tool-wrapper)
add_clang_symlink(necaurora-asm-wrapper necaurora-ofld-tool-wrapper)
