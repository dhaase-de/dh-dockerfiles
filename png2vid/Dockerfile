FROM ubuntu:23.04

RUN apt-get update && apt-get install --no-install-recommends --assume-yes \
    ffmpeg \
    python3 \
    && rm -rf /var/lib/apt/lists/*

COPY scripts/entrypoint.py /
WORKDIR /home/work
ENTRYPOINT ["/entrypoint.py"]
