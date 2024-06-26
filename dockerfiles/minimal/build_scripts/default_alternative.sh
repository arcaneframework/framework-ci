#!/bin/sh

ARCH=`uname -m`

update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-14 100
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-14 100
update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-14 100

update-alternatives --set g++ /usr/bin/g++-14
update-alternatives --set gcc /usr/bin/gcc-14
update-alternatives --set gcov /usr/bin/gcov-14

update-alternatives --install /usr/bin/clang clang /usr/bin/clang-18 100
update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-18 100

update-alternatives --set clang /usr/bin/clang-18
update-alternatives --set clang++ /usr/bin/clang++-18

update-alternatives --set parmetis /usr/local/parmetis_openmpi/include/parmetis.h
update-alternatives --set h5pcc /usr/bin/h5pcc.openmpi
update-alternatives --set hdf5.pc /usr/lib/${ARCH}-linux-gnu/pkgconfig/hdf5-openmpi.pc
