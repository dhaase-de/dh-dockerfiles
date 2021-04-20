FROM nvidia/cuda:9.2-runtime-ubuntu18.04
LABEL maintainer "Daniel Haase <dockerhub@dhaase.de>"

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install --no-install-recommends --assume-yes \
    less \
    mc \
    vim \
    python3 \
    python3-numpy \
    python3-opencv \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    && rm -rf /var/lib/apt/lists/*

# use old system pip to install newer pip version locally
RUN pip3 install --upgrade pip

# install TensorFlow and Keras and further dependencies for DL-SL
RUN pip install tensorflow==1.10.0 keras==2.2.4 imageio pillow scikit-image

# collect build information
COPY Dockerfile /home/build/

# run 'git clone https://github.com/qc17-THU/DL-SR.git' in this dir before building the image
# also copy the trained models and the test data s described in the DL-SR readme
COPY DL-SR /home/lib/DL-SR

# install requirements for DL-SR
#RUN pip install imageio pillow scikit-image

COPY scripts/entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

