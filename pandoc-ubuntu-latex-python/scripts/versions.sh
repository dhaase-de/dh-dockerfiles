#!/bin/bash

# robust bash scripting
set -o errexit
set -o nounset

# get absolute path of this script
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

echo -n "$(cat /etc/os-release | grep '^NAME=' | sed 's/^.*=["]*\([^"]*\)["]*$/\1/') " 
echo "$(cat /etc/os-release | grep '^VERSION=' | sed 's/^.*=["]*\([^"]*\)["]*$/\1/')" 
python3 --version
echo "OpenCV (Python) $(echo 'import cv2; print(cv2.__version__)' | python3)"
echo "scikit-image $(echo 'import skimage; print(skimage.__version__)' | python3)"
echo "scikit-learn $(echo 'import sklearn; print(sklearn.__version__)' | python3)"
echo "SciPy $(echo 'import scipy; print(scipy.__version__)' | python3)"
echo "Matplotlib $(echo 'import matplotlib; print(matplotlib.__version__)' | python3)"
