# README
## ubuntu-2404

This branch contains the workflow and dockerfiles to create
images with Ubuntu 24.04 and:
- GCC 14
- GCC 13
- CLang 18
- CUDA 12.6 (full only)

Two available architectures:
- AMD64
- ARM64

Three available versions:
- **minimal** : with the minimal set of packages to compile and 
  run Arcane Framework.
- **full** : with the maximum set of packages to compile and run
  Arcane Framework will all its capacities. Depends on the
  **minimal** image for its build.
- **doc** : with packages needed to build the documentation. Also
  depends on the **minimal** image for its build (AMD64 only).

### Available scripts in minimal image

```bash
# To define default tools:
source /root/scripts/default_alternatives.sh
```
```bash
# To use default gcc/g++ (GCC 14):
source /root/scripts/use_gcc.sh
```
```bash
# To use gcc/g++ 13:
source /root/scripts/use_gcc-13.sh
```
```bash
# To use gcc/g++ 14:
source /root/scripts/use_gcc-14.sh
```
```bash
# To use default clang/clang++ (Clang 18):
source /root/scripts/use_clang.sh
```
```bash
# To use clang/clang++ 18:
source /root/scripts/use_clang-18.sh
```
```bash
# To use OpenMPI:
source /root/scripts/use_openmpi.sh
```
```bash
# To use MPICH:
source /root/scripts/use_mpich.sh
```

### Available scripts in full image (in addition to those in the minimal image)

```bash
# To use default CUDA:
source /root/scripts/use_cuda.sh
```
```bash
# To use CUDA 126:
source /root/scripts/use_cuda-126.sh
```
```bash
# To use Clang 18 with toolchain GCC 13:
# (usefull to build cuda code with clang)
source /root/scripts/use_clang-18-wtc-gcc-13.sh
```
