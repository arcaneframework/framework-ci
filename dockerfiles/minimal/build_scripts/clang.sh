#!/bin/sh
set -e

# Script permettant de compiler et d'installer Clang 19 et d'installer les
# alternatives.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Initialisation
cd /tmp

apt-get update
apt-get install -y software-properties-common gnupg

wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
./llvm.sh 19

update-alternatives --install /usr/bin/clang clang /usr/bin/clang-19 100
update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-19 100

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
cd /
rm -rf /var/lib/apt/lists/*
rm -rf /var/cache/*
rm -rf /var/log/*
rm -rf /tmp/*
