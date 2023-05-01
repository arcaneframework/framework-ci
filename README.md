# README
## ubuntu-2304:gcc-13_clang-16

This branch contains the workflow and dockerfiles to create an
image with Ubuntu 23.04 and:
- GCC 13
- CLang 16

Two available versions:
- **minimal** : with the minimal set of packages to compile and 
  run Arcane Framework.
- **full** : with the maximum set of packages to compile and run
  Arcane Framework will all its capacities. Depends on the
  **minimal** image for its build.
- **doc** : with packages needed to build the documentation. Also
  depends on the **minimal** image for its build.
  