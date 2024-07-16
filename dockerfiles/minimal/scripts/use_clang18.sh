#!/bin/sh

# Script permettant de définir clang-18 comme étant le clang par défaut
# à utiliser.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

echo "---------------------------------------------------------------------------"
echo "Define CLang-18 alternative"
echo "---------------------------------------------------------------------------"

update-alternatives --set clang /usr/bin/clang-18
update-alternatives --set clang++ /usr/bin/clang++-18

clang --version
clang++ --version
