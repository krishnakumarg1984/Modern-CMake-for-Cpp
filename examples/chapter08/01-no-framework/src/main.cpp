#include <iostream>

#include "calc.h"

int main() {
    Calc c;
    std::cout << "2 + 2 = " << c.Sum(2, 2) << '\n';
    std::cout << "3 * 3 = " << c.Multiply(3, 3) << '\n';

    return 0;
}
