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
  wget \
  curl \
  rsync \
  build-essential \
  gcc-12 g++-12 \
  gcc-11 g++-11 \
  gcc g++ \
  make \
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
  libtbb2-dev \
  libunwind-dev \
  ca-certificates \
  dotnet6 \
  jq

update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 90
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 90
update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-11 90

update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-12 100
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 100
update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-12 100

update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 100

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
rm -rf /var/lib/apt/lists/*
rm -rf /var/cache/*
rm -rf /var/log/*
