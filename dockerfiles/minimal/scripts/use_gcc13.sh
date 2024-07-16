#!/bin/sh

# Script permettant de définir gcc-13 comme étant le gcc par défaut
# à utiliser.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

echo "---------------------------------------------------------------------------"
echo "Define GCC-13 alternative"
echo "---------------------------------------------------------------------------"

update-alternatives --set g++ /usr/bin/g++-13
update-alternatives --set gcc /usr/bin/gcc-13
update-alternatives --set gcov /usr/bin/gcov-13

g++ -v
gcc -v
gcov -v
