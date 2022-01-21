# This file sets up a CMakeCache for the second stage of a simple distribution
# bootstrap build for VE.

include(${CMAKE_CURRENT_LIST_DIR}/VectorEngine.cmake)
set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING "")
set(CMAKE_C_FLAGS_RELWITHDEBINFO "-O3 -gline-tables-only -DNDEBUG" CACHE STRING "")
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-O3 -gline-tables-only -DNDEBUG" CACHE STRING "")
