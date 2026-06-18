#!/bin/sh
set -e

# Script permettant de compiler et d'installer Cuda 13.1 (avec
# un minimum de packages).

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

ARCH=`uname -m`

if [ "$ARCH" = "x86_64" ]; then
  ARCH_A="x86_64"
elif [ "$ARCH" = "aarch64" ]; then
  ARCH_A="sbsa"
else
  exit 1
fi

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

# Patch pour CUDA 13.1 et GCC 15 (https://github.com/ggml-org/llama.cpp/issues/19100)
sed -i 's/__func__(double rsqrt(double a));/__func__(double rsqrt(double a) noexcept(true));/' /usr/local/cuda-13.1/targets/${ARCH_A}-linux/include/crt/math_functions.h
sed -i 's/__func__(float rsqrtf(float a));/__func__(float rsqrtf(float a) noexcept(true));/' /usr/local/cuda-13.1/targets/${ARCH_A}-linux/include/crt/math_functions.h
sed -i '629s/rsqrt(double x);/rsqrt(double x) noexcept(true);/' /usr/local/cuda-13.1/targets/${ARCH_A}-linux/include/crt/math_functions.h
sed -i '653s/);/) noexcept(true);/' /usr/local/cuda-13.1/targets/${ARCH_A}-linux/include/crt/math_functions.h

# Patch pour CUDA 13.1 et Clang 20
sed -i 's/__func__(double rsqrt(const double a))/__func__(double rsqrt(const double a) noexcept(true))/' /usr/local/cuda-13.1/targets/${ARCH_A}-linux/include/crt/math_functions.hpp
sed -i 's/__func__(float rsqrtf(const float a))/__func__(float rsqrtf(const float a) noexcept(true))/' /usr/local/cuda-13.1/targets/${ARCH_A}-linux/include/crt/math_functions.hpp

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
cd /
rm -rf /var/lib/apt/lists/*
rm -rf /var/cache/*
rm -rf /var/log/*
