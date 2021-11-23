#!/bin/bash

# robust bash scripting
set -o errexit
set -o nounset

# build Pillow-SIMD (from git)
. /home/build/venv/bin/activate
cd /home/build/pillow-simd \
&& git checkout v7.0.0.post3 \
&& python setup.py build \
&& python setup.py bdist_wheel

# copy results to /home/build/out
cp --verbose /home/build/pillow-simd/dist/*.whl /home/build/out
for FILENAME in $(ldd /home/build/pillow-simd/build/lib.linux-x86_64-*/PIL/*.so | grep "^\s" | grep " => " | sort | awk '{ print $3 }' | uniq); do
    cp --verbose "$FILENAME" /home/build/out
done
