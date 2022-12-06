cmake_minimum_required(VERSION 3.20.0)
project(PropagatedProperties CXX)

add_library(source1 empty.cpp)
set_property(TARGET source1 PROPERTY INTERFACE_LIB_VERSION 4)
set_property(
    TARGET source1
    APPEND
    PROPERTY COMPATIBLE_INTERFACE_STRING LIB_VERSION
)

add_library(source2 empty.cpp)
set_property(TARGET source2 PROPERTY INTERFACE_LIB_VERSION 4)

add_library(destination empty.cpp)
target_link_libraries(destination source1 source2)

# https://stackoverflow.com/questions/42577241/cmake-graphviz-auto-generated/42577803#42577803
# https://embeddeduse.com/2022/03/01/visualising-module-dependencies-with-cmake-and-graphviz/
add_custom_target(
    graphviz
    ALL
    COMMAND ${CMAKE_COMMAND} "--graphviz=dependencies_dag.dot" .
    COMMAND dot -Tpng dependencies_dag.dot -o dependencies_dag.png
    WORKING_DIRECTORY "${CMAKE_BINARY_DIR}"
)

set_target_properties(graphviz PROPERTIES EXCLUDE_FROM_DEFAULT_BUILD 1)
