#!/bin/sh
set -e

# On installe les packages pour compiler la documentation Arcane et Alien.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

apt-get update
apt-get install -y --no-install-recommends \
  texlive-full \
  graphviz \
  python3-sphinx \
  python3-breathe \
  python3-exhale

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
rm -rf /var/lib/apt/lists/*
rm -rf /var/cache/*
rm -rf /var/log/*
