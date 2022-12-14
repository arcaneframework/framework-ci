# Ubuntu 20.04 minimal dependencies for Arcane.
# Version with GCC 11 / CLang 15 / CMake 3.22.1.

FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/Paris

# On update puis installe add-apt-repository.
# On ajoute le repo pour avoir gcc-11.
# On installe les packages pour compiler Arcane.
# On met la version par défaut du compiler gcc en version 11.
RUN apt-get update -y \
    && apt-get install -y software-properties-common \
    && add-apt-repository ppa:ubuntu-toolchain-r/test -y \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
    apt-utils \
    wget \
    rsync \
    build-essential \
    gcc-11 \
    g++-11 \
    make \
    cmake \
    ccache \
    ninja-build \
    iputils-ping \
    python3 \
    git \
    gfortran \
    libc6-dev \
    libglib2.0-dev \
    libxml2-dev \
    libhdf5-dev libhdf5-openmpi-dev \
    libparmetis-dev \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 100 \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 100 \
    && update-alternatives --install /usr/bin/cpp cpp-bin /usr/bin/cpp-11 100 \
    && update-alternatives --set g++ /usr/bin/g++-11 \
    && update-alternatives --set gcc /usr/bin/gcc-11 \
    && update-alternatives --set cpp-bin /usr/bin/cpp-11

# On installe dotnet 6.
RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install -y apt-transport-https dotnet-sdk-6.0 \
    && rm -rf /var/lib/apt/lists/*

# On installe la version 3.22 de CMake.
RUN cd /tmp \
    && wget https://github.com/Kitware/CMake/releases/download/v3.22.1/cmake-3.22.1-Linux-x86_64.tar.gz \
    && tar xf cmake-3.22.1-Linux-x86_64.tar.gz \
    && cd /tmp/cmake-3.22.1-linux-x86_64/ \
    && rsync -au . /usr/local \
    && cd .. && rm -rf /tmp/*

# On installe CLang 15.
# On met la version par défaut du compiler clang en version 15.
RUN cd /tmp \
    && wget https://apt.llvm.org/llvm.sh \
    && chmod +x llvm.sh \
    && ./llvm.sh 15 \
    && rm -rf /tmp/* \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-15 90 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-15 90 \
    && update-alternatives --set clang /usr/bin/clang-15 \
    && update-alternatives --set clang++ /usr/bin/clang++-15
