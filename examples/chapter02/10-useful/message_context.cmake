cmake_minimum_required(VERSION 3.20.0)

function(foo)
    # list(APPEND CMAKE_MESSAGE_INDENT "  ")
    list(APPEND CMAKE_MESSAGE_CONTEXT "foo")
    # list(APPEND CMAKE_MESSAGE_CONTEXT "${CMAKE_CURRENT_FUNCTION}")

    message("foo message")
endfunction()

# list(APPEND CMAKE_MESSAGE_CONTEXT "top") list(APPEND CMAKE_MESSAGE_CONTEXT
# "${CMAKE_CURRENT_FUNCTION_LIST_DIR}")

message("Before `foo`")
foo()
message("After `foo`")
