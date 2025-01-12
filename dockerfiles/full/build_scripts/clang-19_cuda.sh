#!/bin/sh
set -e

# Script permettant de créer un launcher de clang++-19 pour compiler
# les parties CUDA avec Clang.
# Cela permet de compiler Arcane avec une autre version de Clang
# pour les fichiers c++ classiques facilement.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

update-alternatives --install /usr/bin/clang++_cuda clang++_cuda /usr/bin/clang++-19 92
