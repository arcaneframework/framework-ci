#!/bin/sh

# Script permettant de définir clang-18 comme étant le clang par défaut à
# utiliser, avec la toolchain GCC-13 pour être compatible avec CUDA 12.6.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

echo "---------------------------------------------------------------------------"
echo "Define CLang-18 alternative with GCC-13 toolchain"
echo "---------------------------------------------------------------------------"

update-alternatives --set clang /usr/bin/clang-18-gcc-13
update-alternatives --set clang++ /usr/bin/clang++-18-gcc-13

clang -v
clang++ -v
