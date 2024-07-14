#!/bin/sh

# Script permettant de définir les compilateurs hosts par défaut pour
# CUDA.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Initialisation
ARCH=`uname -m`

# Default gcc : gcc-13
update-alternatives --set g++ /usr/bin/g++-13
update-alternatives --set gcc /usr/bin/gcc-13
update-alternatives --set gcov /usr/bin/gcov-13

# Default clang : clang-17
update-alternatives --set clang /usr/bin/clang-17
update-alternatives --set clang++ /usr/bin/clang++-17

if [ -e /usr/lib/libcuda.so.1 ]
then
  echo "Nvidia driver found."
else
  echo "Nvidia driver not found. Use stub libcuda.so lib."
  if [ -e /usr/local/cuda/lib64/libcuda.so.1 ]
  then
    echo "Symlink already created."
  else
    echo "Creating symlink..."
    ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/libcuda.so.1
  fi
fi
