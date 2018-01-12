cmake_minimum_required(VERSION 2.8.8)

project("NEC Aurora Offloading Build Wrappers")

add_executable(necaurora-ofld-cc1-wrapper necaurora-ofld-cc1-wrapper.cpp)
add_executable(necaurora-ofld-tool-wrapper necaurora-ofld-tool-wrapper.cpp)

macro(install_symlink filepath sympath)
    install(CODE "execute_process(COMMAND ${CMAKE_COMMAND} -E create_symlink ${filepath} ${sympath})")
    install(CODE "message(\"-- Created symlink: ${sympath} -> ${filepath}\")")
endmacro(install_symlink)

install(TARGETS necaurora-ofld-tool-wrapper
                necaurora-ofld-cc1-wrapper
        DESTINATION bin)

install_symlink(${CMAKE_INSTALL_PREFIX}/bin/necaurora-ofld-tool-wrapper
                ${CMAKE_INSTALL_PREFIX}/bin/necaurora-linker-wrapper)

install_symlink(${CMAKE_INSTALL_PREFIX}/bin/necaurora-ofld-tool-wrapper
                ${CMAKE_INSTALL_PREFIX}/bin/necaurora-asm-wrapper)
