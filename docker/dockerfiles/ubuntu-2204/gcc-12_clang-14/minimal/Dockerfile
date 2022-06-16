# Ubuntu 22.04 minimal dependencies for Arcane.
# Version with GCC 12 / CLang 14 / CMake 3.23.2.

# Based on https://github.com/arcaneframework/alien/blob/main/docker/base/ubuntu-20.04/Dockerfile

FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/Paris

# On installe les packages pour compiler Arcane.
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
    apt-utils \
    wget \
    rsync \
    build-essential \
    gcc-12 \
    g++-12 \
    clang-14 \
    make \
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
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-12 100 \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 100 \
    && update-alternatives --install /usr/bin/cpp cpp-bin /usr/bin/cpp-12 100 \
    && update-alternatives --set g++ /usr/bin/g++-12 \
    && update-alternatives --set gcc /usr/bin/gcc-12 \
    && update-alternatives --set cpp-bin /usr/bin/cpp-12 \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-14 90 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-14 90 \
    && update-alternatives --set clang /usr/bin/clang-14 \
    && update-alternatives --set clang++ /usr/bin/clang++-14

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
