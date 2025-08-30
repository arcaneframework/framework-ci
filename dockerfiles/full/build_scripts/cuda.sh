#!/bin/sh
set -e

# Script permettant de compiler et d'installer Cuda 13.0 (avec
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
  exit 1
fi

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/${ARCH_A}/cuda-keyring_1.1-1_all.deb
dpkg -i cuda-keyring_1.1-1_all.deb

# À noter que CUDA 13.0 est compatible avec g++-15 max et clang-20 max.
# Le driver n'est pas inclus. Le driver de l'host sera utilisé.
# Le package libcurand-dev-13-0 est nécessaire pour AdaptiveCpp.
apt-get update
apt-get -y install \
  cuda-compiler-13-0 \
  cuda-cudart-dev-13-0 \
  cuda-cupti-dev-13-0 \
  cuda-nvtx-13-0 \
  cuda-command-line-tools-13-0 \
  cuda-gdb-13-0 \
  cuda-nvdisasm-13-0 \
  cuda-toolkit-13-0-config-common \
  libcurand-dev-13-0

/usr/local/cuda/bin/nvcc --version

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
cd /
rm -rf /var/lib/apt/lists/*
rm -rf /var/cache/*
rm -rf /var/log/*
rm -rf /tmp/*
