#!/bin/sh
set -e

# Script permettant de créer un launcher de clang++-21 pour compiler
# les parties CUDA avec Clang.
# Cela permet de compiler Arcane avec une autre version de Clang ou GCC
# pour les fichiers c++ classiques simplement.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

update-alternatives --install /usr/bin/clang++-cuda clang++-cuda /usr/lib/llvm-21/bin/clang++ 92
