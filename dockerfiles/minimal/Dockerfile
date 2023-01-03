# Ubuntu 22.04 minimal dependencies for Arcane.
# Version with GCC 12 / CLang 14 / CUDA 12.0.

FROM nvidia/cuda:12.0.0-devel-ubuntu22.04

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
    libhdf5-openmpi-dev \
    libparmetis-dev \
    ca-certificates \
    dotnet6 \
    cmake \
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
