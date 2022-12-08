cmake_minimum_required(VERSION 3.20.0)
project(GitSubmoduleManual
  LANGUAGES CXX
)

add_executable(welcome main.cpp)
configure_file(config.yaml config.yaml COPYONLY)

add_subdirectory(extern/yaml-cpp)
target_link_libraries(welcome PRIVATE yaml-cpp)
