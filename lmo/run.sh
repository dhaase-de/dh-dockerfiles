#!/bin/bash

# robust bash scripting
set -o errexit
set -o nounset

# get absolute path of this script
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

IMAGE_TAG="dhaasede/lmo:v2021.07.22.01-lmo4.0.2a"

# data dirs
LMO_DIR="$HOME/lmo"
LIGEN_DIR="$LMO_DIR/ligen"
CFG_FILENAME="$LMO_DIR/cfg.txt"

# create data dirs if necessary
mkdir -p "$LIGEN_DIR"
if [[ ! -e "$CFG_FILENAME" ]]; then
    # if config file does not exist on host, copy it from image
    echo "File '$CFG_FILENAME' was not found, copying from image..."
    id=$(docker create "$IMAGE_TAG")
    docker cp "$id":"/var/www/html/config/cfg.txt" "$CFG_FILENAME"
    docker rm -v "$id"
fi

# run
docker \
    run \
    -it \
    --rm \
    --mount="source=$LIGEN_DIR,target=/var/www/html/ligen,type=bind" \
    --mount="source=$CFG_FILENAME,target=/var/www/html/config/cfg.txt,type=bind" \
    -u $(id -u ${USER}):$(id -g ${USER}) \
    -p 80:80 \
    "$IMAGE_TAG"
