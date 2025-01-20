#!/bin/sh

# Script permettant de configurer CLang 19 de manière à pouvoir compiler les
# parties CUDA avec Clang.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

echo "---------------------------------------------------------------------------"
echo "Configure Clang and CUDA to compile .cu with clang++-19"
echo "---------------------------------------------------------------------------"

. /root/scripts/use_cuda-126.sh

update-alternatives --set clang++-cuda /usr/lib/llvm-19/bin/clang++
