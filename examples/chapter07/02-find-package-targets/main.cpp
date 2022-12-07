#include <fstream>

#include "message.pb.h"

// using namespace std;

int main() {
    Message m;
    m.set_id(123);
    m.PrintDebugString();

    std::fstream fo("./hello.data", std::ios::binary | std::ios::out);
    m.SerializeToOstream(&fo);
    fo.close();

    return 0;
}
