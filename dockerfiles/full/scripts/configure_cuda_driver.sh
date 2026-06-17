#!/bin/sh

# Script permettant de configurer l'environnement pour pouvoir utiliser
# CUDA convenablement.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

echo "---------------------------------------------------------------------------"
echo "Configure CUDA driver"
echo "---------------------------------------------------------------------------"

ARCH=`uname -m`

if [ -e /usr/lib/libcuda.so.1 ]; then
  echo "Nvidia driver found (1)."
  if [ -L "/usr/local/cuda/lib64/libcuda.so.1" ]; then
    LINK=$(readlink "/usr/local/cuda/lib64/libcuda.so.1")
    if [ "$LINK" = "/usr/local/cuda/lib64/stubs/libcuda.so" ]; then
      echo "Removing symlink..."
      rm -rf /usr/local/cuda/lib64/libcuda.so.1
    fi
  fi

elif [ -e /usr/lib/${ARCH}-linux-gnu/libcuda.so.1 ]; then
  echo "Nvidia driver found (2)."
  if [ -L "/usr/local/cuda/lib64/libcuda.so.1" ]; then
    LINK=$(readlink "/usr/local/cuda/lib64/libcuda.so.1")
    if [ "$LINK" = "/usr/local/cuda/lib64/stubs/libcuda.so" ]; then
      echo "Removing symlink..."
      rm -rf /usr/local/cuda/lib64/libcuda.so.1
    fi
  fi

else
  echo "Nvidia driver not found. Use stub libcuda.so lib."
  if [ -e /usr/local/cuda/lib64/libcuda.so.1 ]; then
    echo "Symlink already created."
  else
    echo "Creating symlink..."
    ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/libcuda.so.1
  fi
fi
