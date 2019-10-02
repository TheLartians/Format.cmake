cmake_minimum_required(VERSION 3.6)

project("Format.cmake test")

add_subdirectory(.. ${CMAKE_CURRENT_BINARY_DIR}/format)

add_executable(test test.cpp)