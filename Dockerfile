FROM ubuntu:jammy

ARG DEBIAN_FRONTEND=noninteractive

RUN set -x && apt-get update && apt-get upgrade -y && \
    apt-get install -y apt-utils sudo && \
    useradd -m builder && \
    echo 'builder ALL=NOPASSWD: ALL' > /etc/sudoers.d/builder

USER builder
WORKDIR /home/builder

# set dummy git config
RUN git config --global builder.name "builder" && git config --global builder.email "builder@example.com"

