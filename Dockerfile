FROM catthehacker/ubuntu:full-latest

ARG DEBIAN_FRONTEND=noninteractive

RUN set -x && apt-get update && apt-get upgrade -y && \
    apt-get install -y apt-utils sudo && \
    apt-get clean && \
    useradd -m actor && \
    echo 'actor ALL=NOPASSWD: ALL' > /etc/sudoers.d/builder

USER actor
WORKDIR /home/actor

# set dummy git config
RUN git config --global actor.name "actor" && git config --global actor.email "actor@example.com"

