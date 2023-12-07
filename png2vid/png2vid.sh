#!/bin/bash

# robust bash scripting
set -o errexit
set -o nounset

# get absolute path of this script
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

docker run \
    --mount "source=$(pwd),target=/home/work,type=bind" \
    --user "$(id -u):$(id -g)" \
    -it \
    --rm \
    dhaasede/png2vid:latest \
    "$@"
