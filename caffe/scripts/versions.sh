#!/bin/bash

# robust bash scripting
set -o errexit
set -o nounset

# get absolute path of this script
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

echo -n "$(cat /etc/os-release | grep '^NAME=' | sed 's/^.*=["]*\([^"]*\)["]*$/\1/') " 
echo "$(cat /etc/os-release | grep '^VERSION=' | sed 's/^.*=["]*\([^"]*\)["]*$/\1/')" 
cat /usr/local/cuda/version.txt
echo -n "cuDNN "
echo -n "$(cat /usr/include/cudnn.h | grep "#define CUDNN_MAJOR" | sed 's/^#define CUDNN_MAJOR //')."
echo -n "$(cat /usr/include/cudnn.h | grep "#define CUDNN_MINOR" | sed 's/^#define CUDNN_MINOR //')."
echo "$(cat /usr/include/cudnn.h | grep "#define CUDNN_PATCHLEVEL" | sed 's/^#define CUDNN_PATCHLEVEL //')"
echo "OpenCV (Python) $(echo 'import cv2; print(cv2.__version__)' | python3)"
echo "Tensorflow $(echo 'import tensorflow as tf; print(tf.__version__)' | python3)"
echo "Caffe $(cat /home/build/caffe/distribute/version.txt)"
