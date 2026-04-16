#!/bin/sh

# Script permettant de définir clang-22 comme étant le clang par défaut
# à utiliser.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

echo "---------------------------------------------------------------------------"
echo "Define CLang-22 alternative"
echo "---------------------------------------------------------------------------"

update-alternatives --set clang /usr/bin/clang-22
update-alternatives --set clang++ /usr/bin/clang++-22

clang -v
clang++ -v
