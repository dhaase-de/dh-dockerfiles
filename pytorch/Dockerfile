FROM pytorch/pytorch:1.10.0-cuda11.3-cudnn8-runtime
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
RUN pip install --upgrade 'pip' && \
    pip install --no-cache-dir \
    'opencv-python-headless>=4.4.0,<5.0' \ 
    'scikit-image' \
    'scikit-learn' \
    'scipy' \
    'matplotlib'

# install latest version of torchvision with matching CUDA version
# see: https://github.com/pytorch/vision/issues/2912#issuecomment-717547022
RUN pip install --upgrade 'torchvision==0.11.1+cu113' -f https://download.pytorch.org/whl/torch_stable.html

# collect further version information
COPY ./scripts/versions.sh /home/build/
RUN /home/build/versions.sh > /home/build/versions.txt

# collect build information
COPY Dockerfile /home/build/

# use root as workdir
WORKDIR /
