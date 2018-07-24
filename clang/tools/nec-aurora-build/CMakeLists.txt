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

set(NECAURORA_TARGET_COMPILER "/opt/nec/ve/bin/ncc" CACHE FILEPATH "")

if(NECAURORA_INSTALL_TOOLCHAIN_SYMLINK)
  set(NECAURORA_TOOLCHAIN_SYMLINK_PATH "${NECAURORA_TARGET_COMPILER}" CACHE
      FILEPATH "")
endif()


configure_file(config.h.in config.h @ONLY)
include_directories(${CMAKE_CURRENT_BINARY_DIR})

add_executable(necaurora-ofld-cc1-wrapper necaurora-ofld-cc1-wrapper.cpp)


if(NECAURORA_USE_TOOLCHAIN_WRAPPERS)
    add_executable(necaurora-ofld-tool-wrapper necaurora-ofld-tool-wrapper.cpp)
endif()

install(TARGETS necaurora-ofld-cc1-wrapper DESTINATION bin)

if(NECAURORA_USE_TOOLCHAIN_WRAPPERS)
    install(TARGETS necaurora-ofld-tool-wrapper DESTINATION bin)
    install_symlink(${CMAKE_INSTALL_PREFIX}/bin/necaurora-ofld-tool-wrapper
                    ${CMAKE_INSTALL_PREFIX}/bin/necaurora-linker-wrapper)

    install_symlink(${CMAKE_INSTALL_PREFIX}/bin/necaurora-ofld-tool-wrapper
                    ${CMAKE_INSTALL_PREFIX}/bin/necaurora-asm-wrapper)
endif()


if(NECAURORA_INSTALL_TOOLCHAIN_SYMLINK)#
    install_symlink(${NECAURORA_TOOLCHAIN_SYMLINK_PATH}
                    ${CMAKE_INSTALL_PREFIX}/bin/necaurora-linker-wrapper)

    install_symlink(${NECAURORA_TOOLCHAIN_SYMLINK_PATH}
                    ${CMAKE_INSTALL_PREFIX}/bin/necaurora-asm-wrapper)
endif()
