if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
  cmake_minimum_required(VERSION 2.8.8)
  project("NEC Aurora Offloading Build Wrapper Tools" CXX)
endif()

option(NECAURORA_USE_TOOLCHAIN_WRAPPERS
       "Build and install executable wrapper around ncc/gcc for easy switching."
       ON)

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

if(NOT NECAURORA_USE_TOOLCHAIN_WRAPPERS)
  set(NECAURORA_TOOLCHAIN_SYMLINK_PATH "${NECAURORA_TARGET_COMPILER}" CACHE
      FILEPATH "")
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


if(NECAURORA_USE_TOOLCHAIN_WRAPPERS)
    add_executable(necaurora-ofld-tool-wrapper
                   necaurora-ofld-tool-wrapper.cpp
                   necaurora-utils.cpp)
    target_link_libraries(necaurora-ofld-tool-wrapper
                          ${NECAURORA_LIBELF_LIBRARIES})
endif()

install(TARGETS necaurora-ofld-cc1-wrapper DESTINATION bin)


if(NECAURORA_USE_TOOLCHAIN_WRAPPERS)
  install(TARGETS necaurora-ofld-tool-wrapper DESTINATION bin)
  add_clang_symlink(necaurora-linker-wrapper necaurora-ofld-tool-wrapper)
  add_clang_symlink(necaurora-asm-wrapper necaurora-ofld-tool-wrapper)
else()
    install_symlink(${NECAURORA_TOOLCHAIN_SYMLINK_PATH}
                    ${CMAKE_INSTALL_PREFIX}/bin/necaurora-linker-wrapper)

    install_symlink(${NECAURORA_TOOLCHAIN_SYMLINK_PATH}
                    ${CMAKE_INSTALL_PREFIX}/bin/necaurora-asm-wrapper)
#  TODO: This clang method to create symlinks does not work, 
#        because the ncc compiler is not a target
#  add_clang_symlink(necaurora-linker-wrapper ${NECAURORA_TOOLCHAIN_SYMLINK_PATH})
#  add_clang_symlink(necaurora-asm-wrapper ${NECAURORA_TOOLCHAIN_SYMLINK_PATH})
endif()
