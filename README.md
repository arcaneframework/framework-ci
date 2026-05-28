# README
## ubuntu-2604

This branch contains the workflow and dockerfiles to create
images with Ubuntu 26.04 and:
- GCC 15
- CLang 22
- CLang 20
- CUDA 13.1 (full only)
- ROCM 7.1.0 (full/AMD64 only)

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
# To use default gcc/g++ (GCC 15):
source /root/scripts/use_gcc.sh
```
```bash
# To use gcc/g++ 15:
source /root/scripts/use_gcc-15.sh
```
```bash
# To use default clang/clang++ (Clang 22):
source /root/scripts/use_clang.sh
```
```bash
# To use clang/clang++ 22:
source /root/scripts/use_clang-22.sh
```
```bash
# To use clang/clang++ 20:
source /root/scripts/use_clang-20.sh
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
# To use CUDA 13.1:
source /root/scripts/use_cuda-131.sh
```
```bash
# To use default ROCM:
source /root/scripts/use_rocm.sh
```
```bash
# To use ROCM 7.1.0:
source /root/scripts/use_rocm-710.sh
```
