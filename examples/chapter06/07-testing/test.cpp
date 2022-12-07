#include <iostream>

extern int start_program(int, const char**);

int main() {
    auto exit_code = start_program(0, nullptr);
    if ( exit_code == 0 ) {
        std::cout << "Non-zero exit code expected" << std::endl;
    }

    const char* arguments[2] = { "hello", "world" };

    exit_code = start_program(2, arguments);
    if ( exit_code != 0 ) {
        std::cout << "Zero exit code expected" << std::endl;
    }

    return 0;
}
