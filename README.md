# README
## ubuntu-2004:gcc-11_clang-13_cuda-118

This branch contains the workflow and the dockerfiles to create
image with Ubuntu 20.04 and:
- GCC 11
- CLang 13
- CUDA 11.8

Two available versions:
- **minimal** : with the minimal set of packages to compile and 
  run Arcane Framework.
- **full** : with the maximum set of packages to compile and run
  Arcane Framework will all its capacities. Depends on the
  **minimal** image for its build.
