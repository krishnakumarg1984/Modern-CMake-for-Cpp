cmake_minimum_required(VERSION 3.20.0)
project(Standard CXX)

# set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

include(CheckIPOSupported)
check_ipo_supported(RESULT ipo_supported)
if(ipo_supported)
  message("IPO is supported")
  set(CMAKE_INTERPROCEDURAL_OPTIMIZATION True)
endif()

add_executable(Standard main.cpp)
