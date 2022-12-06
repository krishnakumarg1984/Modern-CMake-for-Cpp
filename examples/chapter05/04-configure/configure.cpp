#include "configured/configure.h"

#include <iostream>

// special macros to convert definitions into c-strings:
#define str(s) #s
#define xstr(s) str(s)

int main() {
#ifdef FOO_ENABLE
    std::cout << "FOO_ENABLE: ON" << '\n';
#endif
    std::cout << "FOO_STRING1: " << xstr(FOO_STRING1) << '\n';
    std::cout << "FOO_STRING2: " << xstr(FOO_STRING2) << '\n';
    std::cout << "FOO_UNDEFINED: " << xstr(FOO_UNDEFINED) << '\n';
}
