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
  libomp-20-dev \
  llvm-20-dev \
  libclang-20-dev \
  lld-20

cmake \
  -S .. \
  -B . \
  -GNinja \
  -DCMAKE_BUILD_TYPE=Release \
  -DWITH_OPENCL_BACKEND=OFF \
  -DROCM_PATH=/usr/lib/rocm \
  -DROCM_DEVICE_LIBS_PATH=/usr/lib/rocm/llvm/lib/clang/20/amdgcn/bitcode

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
