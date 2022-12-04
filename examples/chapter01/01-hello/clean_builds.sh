#!/usr/bin/env bash

printf "Deleting compiled executables and other build artefacts ...\n"

find . -name "*.out" -print -delete 2>/dev/null
find . -name "*.x" -print -delete 2>/dev/null
find . -type d \( -name "debug" -o -name "release" \) -print -exec rm -rf "{}" \; 2>/dev/null
find . -type d -name "build" -print -exec rm -rf "{}" \; 2>/dev/null
find . -type d -name ".ccls-cache" -print -exec rm -rf "{}" \; 2>/dev/null

echo "Removed build-output files. DONE!"
