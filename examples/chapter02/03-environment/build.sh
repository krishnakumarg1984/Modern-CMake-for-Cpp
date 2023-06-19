#!/bin/bash
export myenv=first
echo myenv is now $myenv
cmake -B build .
cd build || exit
export myenv=second
echo myenv is now $myenv
cmake --build .
