#!/bin/sh

# Script permettant de définir les compilateurs hosts par défaut pour
# CUDA. Permet aussi de configurer l'environnement pour pouvoir utiliser
# CUDA convenablement.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Initialisation
ARCH=`uname -m`

echo "---------------------------------------------------------------------------"
echo "Configure CUDA-12.6"
echo "---------------------------------------------------------------------------"

if [ -e /usr/lib/libcuda.so.1 ]; then
  echo "Nvidia driver found."
else
  echo "Nvidia driver not found. Use stub libcuda.so lib."
  if [ -e /usr/local/cuda/lib64/libcuda.so.1 ]; then
    echo "Symlink already created."
  else
    echo "Creating symlink..."
    ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/libcuda.so.1
  fi
fi

nvcc --version
