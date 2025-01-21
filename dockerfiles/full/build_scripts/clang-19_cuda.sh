#!/bin/sh
set -e

# Script permettant de créer un launcher de clang++-19 pour compiler
# les parties CUDA avec Clang.
# Cela permet de compiler Arcane avec une autre version de Clang
# pour les fichiers c++ classiques facilement.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

update-alternatives --install /usr/bin/clang++-cuda clang++-cuda /usr/lib/llvm-19/bin/clang++ 92
