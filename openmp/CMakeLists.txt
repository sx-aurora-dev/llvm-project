project(libveoshim CXX)

cmake_minimum_required(VERSION 2.8)

add_library(veoshim SHARED veoshim.cpp)

set_target_properties(veoshim PROPERTIES PUBLIC_HEADER "veoshim.h")

install(TARGETS veoshim 
        LIBRARY DESTINATION lib
        PUBLIC_HEADER DESTINATION include)
