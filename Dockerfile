FROM ubuntu:18.04

ENV USER aaron
ENV PASSWD xk3124919

# install sudo vim git python
RUN apt-get update && apt-get install -y \
    apt-utils \
    sudo \
    vim \
    git \
    cmake \
    g++ \
    autoconf \
    pkg-config \
    python3 \
    python3-pip \
    golang \
    bash-completion \
    libtool \
# aws kinesis video stream
    libssl-dev \
    libcurl4-openssl-dev \
    liblog4cplus-dev \
# install cross compile toolchain
    gcc-arm-linux-gnueabi \
    g++-arm-linux-gnueabi \
    binutils-arm-linux-gnueabi



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
