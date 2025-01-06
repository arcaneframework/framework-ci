#!/bin/sh

# Script permettant d'installer des packages Python avec PIP.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation de PythonNet.
pip install \
  pythonnet \
  numpy

# Cleanup
rm -rf ${HOME}/.cache
