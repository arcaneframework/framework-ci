#!/bin/sh

# Script permettant de compiler et d'installer Cuda 12.5 (avec
# un minimum de packages).

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Initialisation
cd /tmp
ARCH=`uname -m`

if [ "$ARCH" = "x86_64" ]; then
  ARCH_A="x86_64"
elif [ "$ARCH" = "aarch64" ]; then
  ARCH_A="sbsa"
else
  exit 1;
fi

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/${ARCH_A}/cuda-keyring_1.1-1_all.deb
dpkg -i cuda-keyring_1.1-1_all.deb

# À noter que CUDA 12.5 est compatible uniquement avec g++-13 max et clang-17 max.
apt-get update
apt-get -y install \
  cuda-compiler-12-5 \
  cuda-cudart-dev-12-5 \
  cuda-cupti-dev-12-5 \
  cuda-nvtx-12-5 \
  cuda-command-line-tools-12-5 \
  cuda-gdb-12-5 \
  cuda-nvdisasm-12-5 \
  cuda-toolkit-12-5-config-common \
  gcc-13 g++-13 \
  clang-17

update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-13 90
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-13 90
update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-13 90

update-alternatives --install /usr/bin/clang clang /usr/bin/clang-17 90
update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-17 90

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
cd /
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/*
