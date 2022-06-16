# Ubuntu 22.04 minimal dependencies for Arcane.
# Version with GCC 11 / CUDA 11.7 / CMake 3.23.2.

# Based on https://github.com/arcaneframework/alien/blob/main/docker/base/ubuntu-20.04/Dockerfile

FROM nvidia/cuda:11.7.0-devel-ubuntu22.04

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/Paris

# On installe les packages pour compiler Arcane.
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
    apt-utils \
    build-essential \
    gcc-11 \
    g++-11 \
    ccache \
    ninja-build \
    iputils-ping \
    python3 \
    git \
    gfortran \
    libglib2.0-dev \
    libxml2-dev \
    libhdf5-openmpi-dev \
    libparmetis-dev \
    wget \
    rsync \
    ca-certificates \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/* \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 100 \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 100 \
    && update-alternatives --install /usr/bin/cpp cpp-bin /usr/bin/cpp-11 100 \
    && update-alternatives --set g++ /usr/bin/g++-11 \
    && update-alternatives --set gcc /usr/bin/gcc-11 \
    && update-alternatives --set cpp-bin /usr/bin/cpp-11

# On installe dotnet 6.
RUN update-ca-certificates -f \
    && wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install -y apt-transport-https dotnet-sdk-6.0 \
    && rm -rf /var/lib/apt/lists/*

# On installe la version 3.23.2 de CMake.
RUN cd /tmp \
    && wget https://github.com/Kitware/CMake/releases/download/v3.23.2/cmake-3.23.2-linux-x86_64.tar.gz \
    && tar xf cmake-3.23.2-linux-x86_64.tar.gz \
    && cd /tmp/cmake-3.23.2-linux-x86_64/ \
    && rsync -au . /usr/local \
    && cd .. && rm -rf /tmp/*

# On installe CLang 13.
RUN cd /tmp \
    && wget https://apt.llvm.org/llvm.sh \
    && chmod +x llvm.sh \
    && ./llvm.sh 13 \
    && rm -rf /tmp/* \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-13 90 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-13 90 \
    && update-alternatives --set clang /usr/bin/clang-13 \
    && update-alternatives --set clang++ /usr/bin/clang++-13