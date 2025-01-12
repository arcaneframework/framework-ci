#!/bin/sh
set -e

# Script permettant d'installer ROCM.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Initialisation
cd /tmp
ARCH=`uname -m`

if [ "$ARCH" = "x86_64" ]; then
  ARCH_A="amd64"
elif [ "$ARCH" = "aarch64" ]; then
  exit 0
else
  exit 1
fi

UBUNTU_NAME="noble"
ROCM_VERSION="6.3.1"

mkdir --parents --mode=0755 /etc/apt/keyrings
wget https://repo.radeon.com/rocm/rocm.gpg.key -O - | gpg --dearmor | tee /etc/apt/keyrings/rocm.gpg > /dev/null
echo "deb [arch=${ARCH_A} signed-by=/etc/apt/keyrings/rocm.gpg] https://repo.radeon.com/amdgpu/${ROCM_VERSION}/ubuntu ${UBUNTU_NAME} main" | tee /etc/apt/sources.list.d/amdgpu.list
echo "deb [arch=${ARCH_A} signed-by=/etc/apt/keyrings/rocm.gpg] https://repo.radeon.com/rocm/apt/${ROCM_VERSION} ${UBUNTU_NAME} main" | tee --append /etc/apt/sources.list.d/rocm.list
echo 'Package: *\nPin: release o=repo.radeon.com\nPin-Priority: 600' | tee /etc/apt/preferences.d/rocm-pin-600

apt-get update
apt-get install -y rocm-hip-runtime-dev rocprim-dev roctracer-dev rocm-core

hipcc --version

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
cd /
rm -rf /var/lib/apt/lists/*
rm -rf /var/cache/*
rm -rf /var/log/*
rm -rf /tmp/*
