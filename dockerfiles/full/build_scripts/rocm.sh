#!/bin/sh
set -e

# Script permettant d'installer ROCM.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

ARCH=`uname -m`
if [ "$ARCH" = "aarch64" ]; then
  exit 0
fi

apt-get update
apt-get install -y \
  librocprim-dev \
  libroctx-dev \
  librocm-core-dev \
  librccl-dev \
  hipcc-rocm \
  libclang-rt-22-dev

hipcc --version

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
rm -rf /var/lib/apt/lists/*
rm -rf /var/cache/*
rm -rf /var/log/*
