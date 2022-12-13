# Ubuntu 22.04 minimal dependencies for Arcane.
# Version with GCC 11 / CLang 13 / CUDA 11.8.

FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/Paris

# On installe les packages pour compiler Arcane.
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
    apt-utils \
    wget \
    rsync \
    build-essential \
    gcc-11 \
    g++-11 \
    clang-13 \
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
    libhdf5-openmpi-dev \
    libparmetis-dev \
    ca-certificates \
    dotnet6 \
    cmake \
    && rm -rf /var/lib/apt/lists/* \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 100 \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 100 \
    && update-alternatives --install /usr/bin/cpp cpp-bin /usr/bin/cpp-11 100 \
    && update-alternatives --set g++ /usr/bin/g++-11 \
    && update-alternatives --set gcc /usr/bin/gcc-11 \
    && update-alternatives --set cpp-bin /usr/bin/cpp-11 \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-13 90 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-13 90 \
    && update-alternatives --set clang /usr/bin/clang-13 \
    && update-alternatives --set clang++ /usr/bin/clang++-13
