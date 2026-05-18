#!/bin/sh
set -e

# Script permettant d'installer des packages Python avec PIP.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation de PythonNet et de NumPy.
# pip install --break-system-packages \
#   pythonnet \
#   numpy
pip install --break-system-packages \
  numpy

# Cleanup
rm -rf ${HOME}/.cache
