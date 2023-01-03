# README
## ubuntu-2204:gcc-12_clang-14_cuda-120

This branch contains the workflow and dockerfiles to create an
image with Ubuntu 22.04 and:
- GCC 12
- CLang 14
- CUDA 12.0

Two available versions:
- **minimal** : with the minimal set of packages to compile and 
  run Arcane Framework.
- **full** : with the maximum set of packages to compile and run
  Arcane Framework will all its capacities. Depends on the
  **minimal** image for its build.
