#!/bin/sh

# Script permettant de définir gcc-14 comme étant le gcc par défaut
# à utiliser.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

echo "---------------------------------------------------------------------------"
echo "Define GCC-14 alternative"
echo "---------------------------------------------------------------------------"

update-alternatives --set g++ /usr/bin/g++-14
update-alternatives --set gcc /usr/bin/gcc-14
update-alternatives --set gcov /usr/bin/gcov-14

g++ --version
gcc --version
gcov --version
