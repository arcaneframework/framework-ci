#!/bin/sh

# Script permettant de définir gcc-11 comme étant le gcc par défaut
# à utiliser.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

echo "---------------------------------------------------------------------------"
echo "Define GCC-11 alternative"
echo "---------------------------------------------------------------------------"

update-alternatives --set g++ /usr/bin/g++-11
update-alternatives --set gcc /usr/bin/gcc-11
update-alternatives --set gcov /usr/bin/gcov-11

g++ -v
gcc -v
gcov -v
