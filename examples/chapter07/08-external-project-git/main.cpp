#include "yaml-cpp/yaml.h"

#include <iostream>
#include <string>

int main() {
    std::string name { "Guest" };

    YAML::Node config = YAML::LoadFile("config.yaml");
    if ( config["name"] )
        name = config["name"].as<std::string>();

    std::cout << "Welcome " << name << '\n';

    return 0;
}
