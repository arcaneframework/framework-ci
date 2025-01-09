# README
## ubuntu-2204

This branch contains the workflow and dockerfiles to create
images with Ubuntu 22.04 and:
- GCC 12
- GCC 11
- CLang 16
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

### Available scripts in minimal image

```bash
# To define default tools:
source /root/scripts/default_alternatives.sh
```
```bash
# To use default gcc/g++ (GCC 12):
source /root/scripts/use_gcc.sh
```
```bash
# To use gcc/g++ 11:
source /root/scripts/use_gcc-11.sh
```
```bash
# To use gcc/g++ 12:
source /root/scripts/use_gcc-12.sh
```
```bash
# To use default clang/clang++ (Clang 16):
source /root/scripts/use_clang.sh
```
```bash
# To use clang/clang++ 16:
source /root/scripts/use_clang-16.sh
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
