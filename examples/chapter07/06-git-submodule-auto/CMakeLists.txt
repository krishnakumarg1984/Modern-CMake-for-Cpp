cmake_minimum_required(VERSION 3.20.0)
project(GitSubmoduleAuto
  LANGUAGES CXX
)

add_executable(welcome main.cpp)
configure_file(config.yaml config.yaml COPYONLY)

# find_package(yaml-cpp QUIET)# an older version is usually available, can
# specify the exact version requirement here

if(NOT TARGET yaml-cpp)
  message("yaml-cpp not found, initializing git submodule")
  execute_process(
    COMMAND git submodule update --init -- external/yaml-cpp
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
  add_subdirectory(extern/yaml-cpp)
endif()
target_link_libraries(welcome PRIVATE yaml-cpp)
