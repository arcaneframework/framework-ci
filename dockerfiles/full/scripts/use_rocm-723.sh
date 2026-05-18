#!/bin/sh

# Script permettant de configurer ROCM 7.2.3.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

echo "---------------------------------------------------------------------------"
echo "Configure ROCM-7.2.3"
echo "---------------------------------------------------------------------------"

update-alternatives --set rocm /opt/rocm-7.2.3

update-alternatives --set rocm_agent_enumerator /opt/rocm-7.2.3/bin/rocm_agent_enumerator
update-alternatives --set rocminfo /opt/rocm-7.2.3/bin/rocminfo

update-alternatives --set roc-obj /opt/rocm-7.2.3/bin/roc-obj
update-alternatives --set roc-obj-extract /opt/rocm-7.2.3/bin/roc-obj-extract
update-alternatives --set roc-obj-ls /opt/rocm-7.2.3/bin/roc-obj-ls

update-alternatives --set hipcc /opt/rocm-7.2.3/bin/hipcc
update-alternatives --set hipcc_cmake_linker_helper /opt/rocm-7.2.3/bin/hipcc_cmake_linker_helper

update-alternatives --set hipconfig /opt/rocm-7.2.3/bin/hipconfig
update-alternatives --set hipdemangleatp /opt/rocm-7.2.3/bin/hipdemangleatp
update-alternatives --set hipify-clang /opt/rocm-7.2.3/bin/hipify-clang

update-alternatives --set amdclang /opt/rocm-7.2.3/bin/amdclang
update-alternatives --set amdclang++ /opt/rocm-7.2.3/bin/amdclang++
update-alternatives --set amdflang /opt/rocm-7.2.3/bin/amdflang
update-alternatives --set amdlld /opt/rocm-7.2.3/bin/amdlld

hipcc --version
