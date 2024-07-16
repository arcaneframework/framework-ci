#!/bin/sh

# Script permettant de définir gcc-12 comme étant le gcc par défaut
# à utiliser.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

echo "---------------------------------------------------------------------------"
echo "Define GCC-12 alternative"
echo "---------------------------------------------------------------------------"

update-alternatives --set g++ /usr/bin/g++-12
update-alternatives --set gcc /usr/bin/gcc-12
update-alternatives --set gcov /usr/bin/gcov-12

g++ -v
gcc -v
gcov -v
