# !/usr/bin/env bash

SELF_PATH=$(dirname $(readlink -f $0))
PREFIX=$(readlink -m ${SELF_PATH}/..)
LIB_PATH=${PREFIX}/lib
INC_PATH=${PREFIX}/include
BIN_PATH=${PREFIX}/bin

CMAKE_PREFIX=${PREFIX}/lib/cmake

export PATH=${BIN_PATH}:${PATH}
export LD_LIBRARY_PATH=${LIB_PATH}:${LD_LIBRARY_PATH}
export CPATH=${INC_PATH}:${LD_LIBRARYPATH}
export CMAKE_MODULE_PATH=${CMAKE_PREFIX}/clang:${CMAKE_PREFIX}/llvm:${CMAKE_MODULE_PATH}
