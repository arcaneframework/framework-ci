#!/bin/sh
set -e

# On installe les packages pour compiler la documentation Arcane et Alien.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

apt-get update
apt-get install -y --no-install-recommends \
  dot2tex

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
rm -rf /var/lib/apt/lists/*
rm -rf /var/cache/*
rm -rf /var/log/*
