#!/bin/sh

# Script permettant de définir les compilateurs hosts par défaut pour
# CUDA. Permet aussi de configurer l'environnement pour pouvoir utiliser
# CUDA convenablement.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

echo "---------------------------------------------------------------------------"
echo "Configure CUDA-12.6"
echo "---------------------------------------------------------------------------"

. /root/scripts/use_gcc-13.sh
. /root/scripts/use_clang-18-wtc-gcc-13.sh

. /root/scripts/configure_cuda_driver.sh

nvcc --version
