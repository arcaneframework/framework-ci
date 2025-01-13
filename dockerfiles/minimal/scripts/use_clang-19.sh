#!/bin/sh

# Script permettant de définir clang-19 comme étant le clang par défaut
# à utiliser.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

echo "---------------------------------------------------------------------------"
echo "Define CLang-19 alternative"
echo "---------------------------------------------------------------------------"

update-alternatives --set clang /usr/bin/clang-19
update-alternatives --set clang++ /usr/bin/clang++-19

clang -v
clang++ -v
