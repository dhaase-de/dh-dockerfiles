#!/bin/bash

# robust bash scripting
set -o errexit
set -o nounset

# get absolute path of this script
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
cd "$SCRIPT_DIR"

# use max number of cores for the compilation
CORE_COUNT=$(cat /proc/cpuinfo | grep processor | wc -l)

# compile and test
make -j$CORE_COUNT all
make -j$CORE_COUNT pycaffe
make -j$CORE_COUNT test
make -j$CORE_COUNT distribute

# tests (only work with NVIDIA GPUs)
#make -j$CORE_COUNT runtest
