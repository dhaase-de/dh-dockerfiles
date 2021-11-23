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
echo "PyTorch $(echo 'import torch; print(torch.__version__)' | python3)"
echo "Torchvision $(echo 'import torchvision; print(torchvision.__version__)' | python3)"
echo "OpenCV (Python) $(echo 'import cv2; print(cv2.__version__)' | python3)"
echo "Pillow $(echo 'import PIL; print(PIL.__version__)' | python3)"
echo "scikit-image $(echo 'import skimage; print(skimage.__version__)' | python3)"
echo "scikit-learn $(echo 'import sklearn; print(sklearn.__version__)' | python3)"
echo "SciPy $(echo 'import scipy; print(scipy.__version__)' | python3)"
echo "Matplotlib $(echo 'import matplotlib; print(matplotlib.__version__)' | python3)"
