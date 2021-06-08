FROM ubuntu:20.04

ARG USER=docker
ARG PASSWD=docker
ARG UID=1000
ARG GID=1000

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Set environment variables
ENV TERM xterm-256color

# install sudo vim git python
RUN apt-get update && apt-get install -y \
    apt-utils \
    vim \
    git \
    cmake \
    g++ \
    autoconf \
    pkg-config \
    wget \
    python \
    python3 \
    python3-pip \
    bash-completion \
    libtool \
    iproute2 \
    sudo

RUN apt-get install -y \
    libncurses-dev \
    openssl \
    libssl-dev \
    bc \
    curl

# Uncomment to add user
RUN groupadd -g $GID -o $USER
RUN useradd -rm -d /home/${USER} -s /bin/bash -g $GID -G docker,sudo -u $UID ${USER} && \
echo "${USER}:${PASSWD}" | chpasswd
USER ${USER}
WORKDIR /home/${USER}

# install aws CLI version 
RUN pip3 install awscli --upgrade --user

# git
COPY .gitconfig .
RUN echo "source /usr/share/bash-completion/bash_completion" >> ~/.bashrc
RUN echo 'export PATH="/usr/local/bin/:$PATH"' >> ~/.bashrc

# rust
RUN wget https://static.rust-lang.org/rustup/rustup-init.sh
RUN sh rustup-init.sh -y && rm rustup-init.sh
