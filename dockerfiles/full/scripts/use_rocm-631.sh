#!/bin/sh

# Script permettant de configurer ROCM 6.3.1.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

echo "---------------------------------------------------------------------------"
echo "Configure ROCM-6.3.1"
echo "---------------------------------------------------------------------------"

update-alternatives --set rocm /opt/rocm-6.3.1

update-alternatives --set rocm_agent_enumerator /opt/rocm-6.3.1/bin/rocm_agent_enumerator
update-alternatives --set rocminfo /opt/rocm-6.3.1/bin/rocminfo

update-alternatives --set roc-obj /opt/rocm-6.3.1/bin/roc-obj
update-alternatives --set roc-obj-extract /opt/rocm-6.3.1/bin/roc-obj-extract
update-alternatives --set roc-obj-ls /opt/rocm-6.3.1/bin/roc-obj-ls
update-alternatives --set hipcc /opt/rocm-6.3.1/bin/hipcc
update-alternatives --set hipcc.pl /opt/rocm-6.3.1/bin/hipcc.pl
update-alternatives --set hipcc_cmake_linker_helper /opt/rocm-6.3.1/bin/hipcc_cmake_linker_helper
update-alternatives --set hipconfig /opt/rocm-6.3.1/bin/hipconfig
update-alternatives --set hipconfig.pl /opt/rocm-6.3.1/bin/hipconfig.pl
update-alternatives --set hipconvertinplace-perl.sh /opt/rocm-6.3.1/bin/hipconvertinplace-perl.sh
update-alternatives --set hipconvertinplace.sh /opt/rocm-6.3.1/bin/hipconvertinplace.sh
update-alternatives --set hipdemangleatp /opt/rocm-6.3.1/bin/hipdemangleatp
update-alternatives --set hipexamine-perl.sh /opt/rocm-6.3.1/bin/hipexamine-perl.sh
update-alternatives --set hipexamine.sh /opt/rocm-6.3.1/bin/hipexamine.sh
update-alternatives --set hipify-perl /opt/rocm-6.3.1/bin/hipify-perl
update-alternatives --set hipify-clang /opt/rocm-6.3.1/bin/hipify-clang
update-alternatives --set amdclang /opt/rocm-6.3.1/bin/amdclang
update-alternatives --set amdclang++ /opt/rocm-6.3.1/bin/amdclang++
update-alternatives --set amdflang /opt/rocm-6.3.1/bin/amdflang
update-alternatives --set amdlld /opt/rocm-6.3.1/bin/amdlld

hipcc --version
