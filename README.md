# README
## ubuntu-2204

This branch contains the workflow and dockerfiles to create
images with Ubuntu 22.04 and:
- GCC 12
- GCC 11
- CLang 16
- CUDA 12.5 (full only)

Two available architectures:
- AMD64
- ARM64

Three available versions:
- **minimal** : with the minimal set of packages to compile and 
  run Arcane Framework.
- **full** : with the maximum set of packages to compile and run
  Arcane Framework will all its capacities. Depends on the
  **minimal** image for its build.
