#!/bin/sh

# Script permettant de configurer l'environnement initial.
# Nécessaire uniquement si /etc/profile et/ou /etc/bash.bashrc ne sont sourcés
# (par exemple avec les options --norc --noprofile).

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

export OMPI_MCA_osc=sm
echo "OMPI_MCA_osc=${OMPI_MCA_osc}"

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

if [ -f "/root/scripts/config_env_full.sh" ]; then
    . /root/scripts/config_env_full.sh
fi
