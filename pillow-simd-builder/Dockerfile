# build Pillow-SIMD for the PyTorch 1.10.0 docker image (Ubuntu 18.04, Python 3.7.11)

FROM ubuntu:18.04

# from https://github.com/python-pillow/docker-images/blob/main/ubuntu-18.04-bionic-amd64/Dockerfile
RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get -y install \
    cmake \
    ghostscript \
    git \
    libffi-dev \
    libfreetype6-dev \
    libfribidi-dev \
    libharfbuzz-dev \
    libjpeg-turbo-progs \
    libjpeg8-dev \
    liblcms2-dev \
    libopenjp2-7-dev \
    libssl-dev \
    libsqlite3-dev \
    libtiff5-dev \
    libwebp-dev \
    netpbm \
    tcl8.6-dev \
    tk8.6-dev \
    wget \
    xvfb \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /home/build && cd /home/build

RUN wget https://www.python.org/ftp/python/3.7.11/Python-3.7.11.tgz \
    && tar xzf Python-3.7.11.tgz \
    && cd Python-3.7.11 \
    && ./configure \
    && make altinstall \
    && cd .. \
    && rm -r Python-3.7.11 Python-3.7.11.tgz

RUN python3.7 -m pip install virtualenv \
    && python3.7 -m virtualenv --system-site-packages /home/build/venv \
    && /home/build/venv/bin/pip install --no-cache-dir --upgrade pip \
    && /home/build/venv/bin/pip install --no-cache-dir cffi numpy olefile pytest pytest-cov pytest-timeout

RUN cd /home/build && git clone https://github.com/uploadcare/pillow-simd.git

RUN mkdir /home/build/out
COPY scripts/make-pillow-simd.sh /home/build/
WORKDIR /home/build
