#!/bin/sh

# Script permettant d'installer des packages Python avec PIP.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation de PythonNet.
pip install --break-system-packages pythonnet

# Cleanup
rm -rf ${HOME}/.cache
