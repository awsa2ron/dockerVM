FROM ubuntu:20.04

ENV USER docker
ENV PASSWD docker

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
    golang \
    bash-completion \
    libtool \
    sudo

RUN apt-get install -y \
# aws kinesis video stream
#    libssl-dev \
#    libcurl4-openssl-dev \
#    liblog4cplus-dev \
# aws kinesis video stream WebRTC
#    liblog4cplus-1.1-9 \
#    liblog4cplus-dev \
#    libcap-dev \
# install cross compile toolchain
#    gcc-arm-linux-gnueabi \
#    g++-arm-linux-gnueabi \
#    binutils-arm-linux-gnueabi \
#    gcc-mips-linux-gnu \
#    g++-mips-linux-gnu \
#    binutils-mips-linux-gnu
    zlib1g-dev \
    lib32ncurses5 \
    iproute2

# Uncomment to add user
RUN useradd -rm -d /home/${USER} -s /bin/bash -g root -G sudo -u 1000 ${USER} && \
echo "${USER}:${PASSWD}" | chpasswd
USER ${USER}
WORKDIR /home/${USER}

# install aws CLI version 
RUN pip3 install awscli --upgrade --user

COPY .gitconfig .
RUN echo "source /usr/share/bash-completion/bash_completion" >> ~/.bashrc
#RUN echo "source /etc/bash_completion.d/git-prompt" >> ~/.bashrc
RUN echo 'export PATH="/usr/local/bin/:$PATH"' >> ~/.bashrc
