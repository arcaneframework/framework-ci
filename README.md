# README
## ubuntu-2204:gcc-12_clang-16

This branch contains the workflow and dockerfiles to create an
image with Ubuntu 22.04 and:
- GCC 12
- CLang 16

Two available versions:
- **minimal** : with the minimal set of packages to compile and 
  run Arcane Framework.
- **full** : with the maximum set of packages to compile and run
  Arcane Framework will all its capacities. Depends on the
  **minimal** image for its build.
- **doc** : with packages needed to build the documentation. Also
  depends on the **minimal** image for its build.
  