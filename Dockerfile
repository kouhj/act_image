FROM ubuntu:jammy

ARG DEBIAN_FRONTEND=noninteractive

RUN set -x && apt-get update && apt-get upgrade -y && \
    apt-get install -y apt-utils sudo && \
    apt-get install -y \
        zstd bind9-dnsutils\
        build-essential gcc-multilib g++-multilib \
        lib32gcc-s1 libncurses5 libncurses5-dev zlib1g-dev libssl-dev \
        time git subversion rsync curl gawk wget jq tree \
        unzip flex gettext python3-distutils-extra \
        proot qemu-user qemu-utils tmux ack vim && \
    apt-get clean && \
    rm -rf /var/cache/apt/* /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    useradd -m builder && \
    echo 'builder ALL=NOPASSWD: ALL' > /etc/sudoers.d/builder

USER builder
WORKDIR /home/builder

# set dummy git config
RUN git config --global builder.name "builder" && git config --global builder.email "builder@example.com"

