#!/bin/sh

# Script permettant de définir clang-17 comme étant le clang par défaut
# à utiliser.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

echo "---------------------------------------------------------------------------"
echo "Define CLang-17 alternative"
echo "---------------------------------------------------------------------------"

update-alternatives --set clang /usr/bin/clang-17
update-alternatives --set clang++ /usr/bin/clang++-17

clang --version
clang++ --version
