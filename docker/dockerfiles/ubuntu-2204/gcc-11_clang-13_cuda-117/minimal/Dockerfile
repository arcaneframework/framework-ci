# Ubuntu 22.04 minimal dependencies for Arcane.
# Version with GCC 11 / CUDA 11.7 / CMake 3.22.1.

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
    dotnet6 \
    cmake \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/* \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 100 \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 100 \
    && update-alternatives --install /usr/bin/cpp cpp-bin /usr/bin/cpp-11 100 \
    && update-alternatives --set g++ /usr/bin/g++-11 \
    && update-alternatives --set gcc /usr/bin/gcc-11 \
    && update-alternatives --set cpp-bin /usr/bin/cpp-11

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