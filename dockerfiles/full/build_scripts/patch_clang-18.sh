#!/bin/sh

# Script permettant de créer un launcher de clang-18 utilisant
# la toolchain de g++-13.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

ARCH=`uname -m`

cp /root/build_scripts/clang++-18-gcc-13.in /usr/bin/clang++-18-gcc-13
cp /root/build_scripts/clang-18-gcc-13.in /usr/bin/clang-18-gcc-13

sed -i "s/@ARCH@/${ARCH}/g" /usr/bin/clang++-18-gcc-13
sed -i "s/@ARCH@/${ARCH}/g" /usr/bin/clang-18-gcc-13

chmod u+x /usr/bin/clang++-18-gcc-13
chmod u+x /usr/bin/clang-18-gcc-13

update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-18-gcc-13 91
update-alternatives --install /usr/bin/clang clang /usr/bin/clang-18-gcc-13 91
