# README
## ubuntu-2404

This branch contains the workflow and dockerfiles to create
images with Ubuntu 24.04 and:
- GCC 14
- GCC 13
- CLang 18
- CLang 17 (full only)
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
- **doc** : with packages needed to build the documentation. Also
  depends on the **minimal** image for its build (AMD64 only).
