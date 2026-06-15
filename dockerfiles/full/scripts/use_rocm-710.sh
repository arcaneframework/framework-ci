#!/bin/sh

# Script permettant de configurer ROCM 7.1.0.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

ARCH=`uname -m`
if [ "$ARCH" = "aarch64" ]; then
  echo "ROCM is not available on ARM64 architecture"
  exit 0
fi

echo "---------------------------------------------------------------------------"
echo "Configure ROCM-7.1.0"
echo "---------------------------------------------------------------------------"

. /root/scripts/use_gcc-15.sh
. /root/scripts/use_clang-22.sh

hipcc --version
