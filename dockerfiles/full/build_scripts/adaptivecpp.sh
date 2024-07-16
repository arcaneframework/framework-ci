#!/bin/sh

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
  libomp-16-dev \
  llvm-16-dev \
  libclang-16-dev

cmake \
  -S .. \
  -B . \
  -GNinja \
  -DCMAKE_BUILD_TYPE=Release \
  -DWITH_OPENCL_BACKEND=OFF

cmake --build . --target install

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
cd /
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/*
