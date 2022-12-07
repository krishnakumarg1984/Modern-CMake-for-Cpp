#include <iostream>

extern void a();
extern void b();
// extern void duplicated();

void duplicated() {
    std::cout << "duplicated MAIN" << std::endl;
}

int main() {
    a();
    b();
    duplicated();

    return 0;
}
