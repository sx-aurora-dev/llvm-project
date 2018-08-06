if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
  cmake_minimum_required(VERSION 2.8.8)
  project("NEC Aurora Offloading Build Wrapper Tools" CXX)
endif()

option(NECAURORA_USE_TOOLCHAIN_WRAPPERS
       "build and install executable wrapper around ncc/gcc for easy switching"
       OFF)

option(NECAURORA_INSTALL_TOOLCHAIN_SYMLINK
       "install linker and asm wrapper as an symlink to TOOLCHAIN_SYMLINK_PATH
        incompatible with USE_TOLCHAIN_WRAPPERS"
       ON)

if(NECAURORA_INSTALL_TOOLCHAIN_SYMLINK AND 
    NECAURORA_USE_TOOLCHAIN_WRAPPERS)
  message(SEND_ERROR "Options: INSTALL_TOOLCHAIN_SYMLINK and USE_TOOLCHAIN_WRAPPERS are mutually exclusive" )
endif()

# TODO: Make this more dynamically
set(NECAURORA_TARGET_COMPILER "/opt/nec/ve/bin/ncc" CACHE FILEPATH "")

if(NECAURORA_INSTALL_TOOLCHAIN_SYMLINK)
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
endif()

install(TARGETS necaurora-ofld-cc1-wrapper DESTINATION bin)

target_link_libraries(necaurora-ofld-tool-wrapper
                      ${NECAURORA_LIBELF_LIBRARIES})

if(NECAURORA_USE_TOOLCHAIN_WRAPPERS)
  install(TARGETS necaurora-ofld-tool-wrapper DESTINATION bin)
  add_clang_symlink(necaurora-linker-wrapper necaurora-ofld-tool-wrapper)
  add_clang_symlink(necaurora-asm-wrapper necaurora-ofld-tool-wrapper)
endif()

if(NECAURORA_INSTALL_TOOLCHAIN_SYMLINK)
    install_symlink(${NECAURORA_TOOLCHAIN_SYMLINK_PATH}
                    ${CMAKE_INSTALL_PREFIX}/bin/necaurora-linker-wrapper)

    install_symlink(${NECAURORA_TOOLCHAIN_SYMLINK_PATH}
                    ${CMAKE_INSTALL_PREFIX}/bin/necaurora-asm-wrapper)
#  TODO: This clang method to create symlinks does not work, 
#        because the ncc compiler is not a target
#  add_clang_symlink(necaurora-linker-wrapper ${NECAURORA_TOOLCHAIN_SYMLINK_PATH})
#  add_clang_symlink(necaurora-asm-wrapper ${NECAURORA_TOOLCHAIN_SYMLINK_PATH})
endif()
