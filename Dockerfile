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
    bash-completion


# install aws CLI version 1
RUN pip3 install awscli --upgrade --user

# install cross compile toolchain
RUN apt-get install -y \
    libssl-dev \
    libcurl4-openssl-dev \
    liblog4cplus-dev

# install cross compile toolchain
RUN apt-get install -y \
    gcc-arm-linux-gnueabi \
    g++-arm-linux-gnueabi \
    binutils-arm-linux-gnueabi


# Uncomment to add user
RUN useradd -rm -d /home/${USER} -s /bin/bash -g root -G sudo -u 1000 ${USER} && \
echo "${USER}:${PASSWD}" | chpasswd
USER ${USER}
WORKDIR /home/${USER}

COPY .gitconfig .
RUN echo "source /usr/share/bash-completion/bash_completion" >> ~/.bashrc
RUN echo "source /etc/bash_completion.d/git-prompt" >> ~/.bashrc
RUN echo "export PS1='\w$(__git_ps1 " (%s)")\$ '" >> ~/.bashrc

