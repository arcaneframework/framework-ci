#!/bin/sh

# Script permettant de définir gcc-15 comme étant le gcc par défaut
# à utiliser.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

echo "---------------------------------------------------------------------------"
echo "Define GCC-15 alternative"
echo "---------------------------------------------------------------------------"

update-alternatives --set g++ /usr/bin/g++-15
update-alternatives --set gcc /usr/bin/gcc-15
update-alternatives --set gcov /usr/bin/gcov-15

g++ -v
gcc -v
gcov -v
