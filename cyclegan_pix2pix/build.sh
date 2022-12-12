#!/bin/bash

# robust bash scripting
set -o errexit
set -o nounset

# get absolute path of this script
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

cd "$SCRIPT_DIR"
mkdir -p bak
[ ! -f build*.log ] || mv build*.log bak/
docker build "$SCRIPT_DIR" | tee "build_$(date +%Y-%m-%d_%H:%M:%S).log"
