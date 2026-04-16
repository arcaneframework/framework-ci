#!/bin/sh

# Script permettant de définir clang-20 comme étant le clang par défaut
# à utiliser.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

echo "---------------------------------------------------------------------------"
echo "Define CLang-20 alternative"
echo "---------------------------------------------------------------------------"

update-alternatives --set clang /usr/bin/clang-20
update-alternatives --set clang++ /usr/bin/clang++-20

clang -v
clang++ -v
