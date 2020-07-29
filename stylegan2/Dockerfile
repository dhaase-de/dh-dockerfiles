FROM tensorflow/tensorflow:1.15.0-gpu-py3
LABEL maintainer "Daniel Haase <dockerhub@dhaase.de>"

RUN pip install scipy==1.3.3 requests==2.22.0 Pillow==6.2.1

# run 'git clone https://github.com/NVlabs/stylegan2.git' in this dir before building the image
COPY stylegan2 /home/lib/stylegan2

COPY scripts/entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
