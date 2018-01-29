project(libveoshim CXX)

cmake_minimum_required(VERSION 2.8)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

add_library(veoshim SHARED veoshim.cpp)

set_target_properties(veoshim PROPERTIES PUBLIC_HEADER "veoshim.h")

target_link_libraries(veoshim ffi dl)

install(TARGETS veoshim 
        LIBRARY DESTINATION lib
        PUBLIC_HEADER DESTINATION include)
