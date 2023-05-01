# Ubuntu 23.04 minimal dependencies for Arcane.
# Version with GCC 13 / CLang 16.

FROM ubuntu:23.04

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/Paris

# On installe les packages pour compiler Arcane.
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
    apt-utils \
    wget \
    rsync \
    build-essential \
    gcc-13 \
    g++-13 \
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
    libopenmpi-dev \
    libtbb-dev \
    ca-certificates \
    dotnet7 \
    cmake \
    && rm -rf /var/lib/apt/lists/* \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-13 100 \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-13 100 \
    && update-alternatives --install /usr/bin/cpp cpp-bin /usr/bin/cpp-13 100 \
    && update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-13 100 \
    && update-alternatives --set g++ /usr/bin/g++-13 \
    && update-alternatives --set gcc /usr/bin/gcc-13 \
    && update-alternatives --set cpp-bin /usr/bin/cpp-13 \
    && update-alternatives --set gcov /usr/bin/gcov-13
