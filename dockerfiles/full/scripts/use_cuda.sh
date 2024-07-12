#!/bin/sh

# Script permettant de définir les compilateurs hosts par défaut pour
# CUDA.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Default gcc : gcc-13
update-alternatives --set g++ /usr/bin/g++-13
update-alternatives --set gcc /usr/bin/gcc-13
update-alternatives --set gcov /usr/bin/gcov-13

# Default clang : clang-17
update-alternatives --set clang /usr/bin/clang-17
update-alternatives --set clang++ /usr/bin/clang++-17
