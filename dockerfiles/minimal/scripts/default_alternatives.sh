#!/bin/sh

# Script permettant de définir les alternatives par défaut de l'image.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

echo "---------------------------------------------------------------------------"
echo "Define default alternatives"
echo "---------------------------------------------------------------------------"

. /root/scripts/use_gcc-14.sh
. /root/scripts/use_clang-21.sh
. /root/scripts/use_openmpi.sh

if [ -f "/root/scripts/default_alternatives_full.sh" ]; then
    . /root/scripts/default_alternatives_full.sh
fi
