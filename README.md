# README
## ubuntu-2204:gcc-12_clang-15_cuda-122

This branch contains the workflow and dockerfiles to create
images with Ubuntu 22.04 and:
- GCC 12
- CLang 15
- CUDA 12.2

Two available architectures:
- AMD64
- ARM64

Three available versions:
- **minimal** : with the minimal set of packages to compile and 
  run Arcane Framework.
- **full** : with the maximum set of packages to compile and run
  Arcane Framework will all its capacities. Depends on the
  **minimal** image for its build.
