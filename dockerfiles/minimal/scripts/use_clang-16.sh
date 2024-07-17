#!/bin/sh

# Script permettant de définir clang-16 comme étant le clang par défaut
# à utiliser.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

echo "---------------------------------------------------------------------------"
echo "Define CLang-16 alternative"
echo "---------------------------------------------------------------------------"

update-alternatives --set clang /usr/bin/clang-16
update-alternatives --set clang++ /usr/bin/clang++-16

clang -v
clang++ -v
