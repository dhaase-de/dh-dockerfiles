##
## BUILD STAGE
##

# https://gitlab.com/nvidia/container-images/cuda/-/blob/master/dist/ubuntu18.04/10.1/base/Dockerfile
FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04 AS builder

# install required packages
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install --no-install-recommends --assume-yes \
    build-essential \
    git \
    libatlas-base-dev \
    libboost-all-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    libhdf5-serial-dev \
    liblmdb-dev \
    libleveldb-dev \
    libopencv-dev \
    libprotobuf-dev \
    libsnappy-dev \
    protobuf-compiler \
    python3 \
    python3-dev \
    python3-numpy \
    python3-opencv \
    python3-pip \
    python3-setuptools \
    python3-skimage \
    python3-sklearn \
    && rm -rf /var/lib/apt/lists/*

# update install tools
RUN pip3 install --upgrade pip setuptools

# install TensorFlow
RUN pip3 install protobuf tensorflow==1.9.0

# build Caffe
ENV CAFFE_ROOT=/home/build/caffe
WORKDIR $CAFFE_ROOT
RUN git clone https://github.com/BVLC/caffe.git . && git checkout 9b891540183ddc834a02b2bd81b31afae71b2153 && mkdir ./distribute && echo $(git describe --tags) > ./distribute/version.txt
COPY caffe/* $CAFFE_ROOT/
RUN ./make.sh

# collect further version information
COPY scripts/versions.sh /home/build/
RUN /home/build/versions.sh > /home/build/versions.txt

##
##
##

FROM nvidia/cuda:10.1-cudnn7-runtime-ubuntu18.04
LABEL maintainer "Daniel Haase <dockerhub@dhaase.de>"

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install --no-install-recommends --assume-yes \
    less \
    mc \
    vim \
    libatlas-base-dev \
    libboost-all-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    libhdf5-serial-dev \
    liblmdb-dev \
    libleveldb-dev \
    libopencv-dev \
    libprotobuf-dev \
    libsnappy-dev \
    python3 \
    python3-numpy \
    python3-opencv \
    python3-pip \
    python3-setuptools \
    python3-skimage \
    python3-sklearn \
    && rm -rf /var/lib/apt/lists/*

# update install tools
RUN pip3 install --upgrade pip setuptools

# install TensorFlow
RUN pip3 install protobuf tensorflow==1.9.0

# install Caffe
COPY --from=builder /home/build/caffe/distribute/ /home/build/caffe/distribute/
ENV PATH="/home/build/caffe/distribute/bin:${PATH}" LD_LIBRARY_PATH="/home/build/caffe/distribute/lib:${LD_LIBRARY_PATH}" PYTHONPATH="/home/build/caffe/distribute/python:${PYTHONPATH}"

# collect build information
COPY Dockerfile /home/build/
#COPY build*.log /home/build/
COPY --from=builder /home/build/versions.txt /home/build/versions.txt

# show version info by default
#CMD ["cat", "/home/build/versions.txt"]
