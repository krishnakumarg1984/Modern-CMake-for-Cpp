#include "message.pb.h"

#include <fstream>

int main() {
    Message m;
    m.set_id(123);
    m.PrintDebugString();

    std::fstream fo("./hello.data", std::ios::binary | std::ios::out);
    m.SerializeToOstream(&fo);
    fo.close();

    return 0;
}
