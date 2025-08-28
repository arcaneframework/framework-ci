#!/bin/sh
set -e

# Script permettant de compiler et d'installer AdaptiveCPP.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Initialisation
cd /tmp

git clone https://github.com/AdaptiveCpp/AdaptiveCpp
cd AdaptiveCpp

mkdir build
cd build

apt-get update
apt-get -y install \
  libboost-fiber-dev \
  libboost-context-dev \
  libomp-19-dev \
  llvm-19-dev \
  libclang-19-dev \
  lld-19

cmake \
  -S .. \
  -B . \
  -GNinja \
  -DCMAKE_BUILD_TYPE=Release \
  -DWITH_OPENCL_BACKEND=OFF

# -DACPP_EXPERIMENTAL_LLVM=ON \
# -DLLVM_DIR=/usr/lib/llvm-21/cmake

cmake --build . --target install

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
cd /
rm -rf /var/lib/apt/lists/*
rm -rf /var/cache/*
rm -rf /var/log/*
rm -rf /tmp/*
