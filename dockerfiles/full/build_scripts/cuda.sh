#!/bin/sh
set -e

# Script permettant de compiler et d'installer Cuda 13.1 (avec
# un minimum de packages).

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# À noter que CUDA 13.1 est compatible avec g++-15 max et clang-20 max.
# Le driver n'est pas inclus. Le driver de l'host sera utilisé.
# Le package libcurand-dev-13-1 est nécessaire pour AdaptiveCpp.
apt-get update
apt-get -y install \
  cuda-compiler-13-1 \
  cuda-cudart-dev-13-1 \
  cuda-cupti-dev-13-1 \
  cuda-nvtx-13-1 \
  cuda-command-line-tools-13-1 \
  cuda-gdb-13-1 \
  cuda-nvdisasm-13-1 \
  cuda-toolkit-13-1-config-common \
  libcurand-dev-13-1

/usr/local/cuda/bin/nvcc --version

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
cd /
rm -rf /var/lib/apt/lists/*
rm -rf /var/cache/*
rm -rf /var/log/*
