#!/bin/sh
set -e

# Script permettant d'installer ROCM.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

apt-get update
apt-get install -y \
  librocprim-dev \
  libroctx-dev \
  librocm-core-dev \
  librccl-dev \
  hipcc-rocm

hipcc --version

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
rm -rf /var/lib/apt/lists/*
rm -rf /var/cache/*
rm -rf /var/log/*
