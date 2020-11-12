#!/bin/bash

# robust bash scripting
set -o errexit
set -o nounset

# get absolute path of this script
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

echo -n "$(cat /etc/os-release | grep '^NAME=' | sed 's/^.*=["]*\([^"]*\)["]*$/\1/') " 
echo "$(cat /etc/os-release | grep '^VERSION=' | sed 's/^.*=["]*\([^"]*\)["]*$/\1/')" 
conda list cudatoolkit | grep --invert-match '^#' | sed 's/cudatoolkit/CUDA/' | sed 's/\s\+/ /g'
python3 --version
echo "OpenCV (Python) $(echo 'import cv2; print(cv2.__version__)' | python3)"
echo "ONNX $(echo 'import onnx; print(onnx.__version__)' | python3)"
echo "ONNX-Tensorflow $(echo 'import onnx_tf; import pkg_resources; print(pkg_resources.get_distribution("onnx-tf").version)' | python3)"
echo "Tensorflow $(echo 'import tensorflow as tf; print(tf.__version__)' | python3)"
echo "Tensorflow-Addons $(echo 'import tensorflow_addons as tfa; print(tfa.__version__)' | python3)"
echo "PyTorch $(echo 'import torch; print(torch.__version__)' | python3)"
echo "Torchvision $(echo 'import torchvision; print(torchvision.__version__)' | python3)"
