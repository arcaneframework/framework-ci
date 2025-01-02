#!/bin/sh

# Script permettant d'installer des packages Python avec PIP.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation de PythonNet et de NumPy.
pip install --break-system-packages \
  pythonnet \
  numpy

# Cleanup
rm -rf ${HOME}/.cache
