#!/bin/sh

# Script permettant de créer un launcher de clang-17 utilisant
# la toolchain de g++-13.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

cp /root/build_scripts/clang++-17-gcc13 /usr/bin/
cp /root/build_scripts/clang-17-gcc13 /usr/bin/

chmod u+x /usr/bin/clang++-17-gcc13
chmod u+x /usr/bin/clang-17-gcc13

update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-17-gcc13 91
update-alternatives --install /usr/bin/clang clang /usr/bin/clang-17-gcc13 91
