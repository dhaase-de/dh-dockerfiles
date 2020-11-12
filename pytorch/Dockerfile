FROM pytorch/pytorch:1.7.0-cuda11.0-cudnn8-runtime
LABEL maintainer "Daniel Haase <dockerhub@dhaase.de>"

# install system tools
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install --no-install-recommends --assume-yes \
    less \
    mc \
    nano \
    vim \
    && rm -rf /var/lib/apt/lists/*

# install Python3 modules
RUN pip install --upgrade pip && \
    pip install --no-cache-dir \
    'scikit-image' \
    'opencv-python-headless>=4.4.0,<5.0' \
    'onnx==1.8.0' \
    'tensorflow==2.2.0' \
    'tensorflow-addons==0.11.2'

# workaround, as onnx-tf==1.6.0 is not yet on PyPI (https://github.com/onnx/onnx-tensorflow/issues/738)
COPY ./python3/*.whl /home/build/python3/
RUN pip install /home/build/python3/*.whl

# collect further version information
COPY ./scripts/versions.sh /home/build/
RUN /home/build/versions.sh > /home/build/versions.txt

# collect build information
COPY Dockerfile /home/build/

# use root as workdir
WORKDIR /
