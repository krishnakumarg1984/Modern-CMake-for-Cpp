cmake_minimum_required(VERSION 3.20.0)
project(BankApp CXX)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_executable(terminal_app terminal_app.cpp)
add_executable(gui_app gui_app.cpp)

target_link_libraries(terminal_app calculations)
target_link_libraries(gui_app calculations drawing)

add_library(calculations calculations.cpp)
add_library(drawing drawing.cpp)

add_custom_target(
    checksum
    ALL
    COMMAND sh -c "cksum terminal_app>terminal.ck"
    COMMAND sh -c "cksum gui_app>gui.ck"
    BYPRODUCTS terminal.ck gui.ck
    COMMENT "Checking the sums..."
)

add_dependencies(checksum terminal_app gui_app)

# https://stackoverflow.com/questions/42577241/cmake-graphviz-auto-generated/42577803#42577803
# https://embeddeduse.com/2022/03/01/visualising-module-dependencies-with-cmake-and-graphviz/
add_custom_target(
    graphviz
    ALL
    COMMAND ${CMAKE_COMMAND} "--graphviz=dependencies_dag.dot" .
    COMMAND dot -Tpng dependencies_dag.dot -o dependencies_dag.png
    BYPRODUCTS dependencies_dag.dot dependencies_dag.png
    WORKING_DIRECTORY "${CMAKE_BINARY_DIR}"
)

set_target_properties(graphviz PROPERTIES EXCLUDE_FROM_DEFAULT_BUILD 1)
