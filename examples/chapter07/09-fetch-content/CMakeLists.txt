cmake_minimum_required(VERSION 3.20.0)
project(ExternalProjectGit
  LANGUAGES CXX
)

add_executable(welcome main.cpp)
configure_file(config.yaml config.yaml COPYONLY)

include(FetchContent)
fetchcontent_declare(
  external-yaml-cpp
  GIT_REPOSITORY https://github.com/jbeder/yaml-cpp.git
  # GIT_TAG yaml-cpp-0.6.3
  GIT_TAG yaml-cpp-0.7.0)
fetchcontent_makeavailable(external-yaml-cpp)
target_link_libraries(welcome PRIVATE yaml-cpp)

include(CMakePrintHelpers)
cmake_print_properties(TARGETS yaml-cpp PROPERTIES TYPE SOURCE_DIR)
