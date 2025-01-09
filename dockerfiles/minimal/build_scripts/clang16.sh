#!/bin/sh
set -e

# Script permettant de compiler et d'installer MPICH et d'installer les
# alternatives.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Initialisation
cd /tmp

apt-get update -y
apt-get install -y software-properties-common gnupg

wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
./llvm.sh 16

update-alternatives --install /usr/bin/clang clang /usr/bin/clang-16 100
update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-16 100

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
cd /
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/*
