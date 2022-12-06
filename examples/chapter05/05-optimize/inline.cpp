#include <iostream>

struct X {
    static void im_inlined() { std::cout << "hi\n"; }
    static void me_too();
};
inline void X::me_too() {
    std::cout << "bye\n";
}

int main() {
    X x;
    X::im_inlined();
    x.me_too();

    return 0;
}
