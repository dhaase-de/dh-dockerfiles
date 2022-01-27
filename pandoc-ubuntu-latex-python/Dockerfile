FROM pandoc/ubuntu-latex:2.16.2
LABEL maintainer "Daniel Haase <dockerhub@dhaase.de>"

# install Python3 and system tools
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install --no-install-recommends --assume-yes \
    less \
    mc \
    python3 \
    python3-pip \
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

# collect further version information
COPY ./scripts/versions.sh /home/build/
RUN /home/build/versions.sh > /home/build/versions.txt

# collect build information
COPY Dockerfile /home/build/

# use root as workdir
WORKDIR /
