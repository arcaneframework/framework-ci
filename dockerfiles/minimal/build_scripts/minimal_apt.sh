#!/bin/sh
set -e

# On installe les packages pour compiler Arcane.
# Les packages gcc g++ sont là pour éviter que d'autres les installes
# et déconfigure les alternatives déjà séléctionnées.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

apt-get update
apt-get install -y --no-install-recommends \
  apt-utils \
  gnupg \
  wget \
  curl \
  rsync \
  build-essential \
  gcc-15 g++-15 \
  gcc g++ \
  clang-22 \
  clang-20 \
  make \
  cmake \
  ccache \
  ninja-build \
  mold \
  iputils-ping \
  python3-dev \
  python3-pip \
  git \
  gfortran \
  libc6-dev \
  libglib2.0-dev \
  libboost-program-options-dev \
  libopenblas-dev \
  libxml2-dev \
  libhdf5-dev \
  libhdf5-openmpi-dev \
  libopenmpi-dev \
  libmetis-dev \
  libtbb-dev \
  libunwind-dev \
  libdw-dev \
  ca-certificates \
  dotnet10 \
  jq

update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-15 100
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-15 100
update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-15 100

update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 100

update-alternatives --install /usr/bin/clang clang /usr/bin/clang-22 100
update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-22 100

update-alternatives --install /usr/bin/clang clang /usr/bin/clang-20 90
update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-20 90

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
rm -rf /var/lib/apt/lists/*
rm -rf /var/cache/*
rm -rf /var/log/*
