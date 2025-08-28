#!/bin/sh

# Script permettant de définir clang-21 comme étant le clang par défaut
# à utiliser.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

echo "---------------------------------------------------------------------------"
echo "Define CLang-21 alternative"
echo "---------------------------------------------------------------------------"

update-alternatives --set clang /usr/bin/clang-21
update-alternatives --set clang++ /usr/bin/clang++-21

clang -v
clang++ -v
