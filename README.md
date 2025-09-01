# README

Ce dépot contient les scripts pour l'intégration continue (CI) de Arcane.

- [README](#readme)
- [Compilation des packages](#compilation-des-packages)
- [Images Docker](#images-docker)
  - [Les types](#les-types)
  - [Les tags](#les-tags)
  - [Sélection du compilateur (images v3 et après)](#sélection-du-compilateur-images-v3-et-après)
  - [Les architectures](#les-architectures)
  - [Images disponibles](#images-disponibles)
- [Workflows](#workflows)
  - [install\_vcpkg\_packages](#install_vcpkg_packages)
  - [ci-direct](#ci-direct)
  - [image\_creator](#image_creator)
- [Utilisation de 'Github CLI'](#utilisation-de-github-cli)
- [TODO](#todo)

Actuellement, le CI utilise le mécanisme de 'GitHub', appelé 'GitHub
Actions'. Ce mécanisme utilise des scripts au format YAML qui sont dans
le répertoire `.github/workflows`. Il y a un script par action
possible. Il est possible d'accéder aux actions via l'interface WEB de
git en cliquant sur l'onglet 'Actions' sous le nom du dépot:

<img src="./docs/action_screenshot.png" />

Le CI fonctionne à la fois sous windows et linux

Afin d'éviter d'être dépendant de produits externes et d'être portable
entre les plateformes, le CI utilise uniquement des scripts CMake.


# Compilation des packages

Actuellement pour avoir la même configuration entre windows et linux
(ubuntu), on utilise [vcpkg](https://vcpkg.io) pour installer les
packages nécessaires à Arcane. 

L'utilisation classique de `vcpkg` suppose qu'on en fasse un
sous-module dans notre dépot. On utilise donc `vcpkg` à une version
donnée, ce qui implique aussi d'avoir une version donnée des packages
(il n'est pas possible actuellement dans vcpkg d'avoir plusieurs
versions d'un même produit). Tant qu'on ne met pas à jour ce
sous-module, les versions installées des produits seront les mêmes. Il
est préférable d'utiliser une version taggé de `vcpkg`. 

Après avoit fait un checkout du sous-module, il faut lancer la
commande `bootstrap.sh` ou `bootstrap.bat` pour compiler `vcpkg`. Cela
va créer un exécutable `vcpkg` dans les sources de ce sous-module. Il
est ensuite possible d'installer un package via des commandes telles
que: 

~~~sh
vcpkg install glib
~~~

Les produits installés par `vcpkg` sont mis dans le sous-répertoire `installed` du dépot.

NOTE: Sous Linux, `vcpkg` utilise des bibliothèques statiques
(`.a`). Sous windows, il utilise des bibliothèques dynamiques (DLL).

# Images Docker
## Les types

Actuellement, il y a trois types d'images :
- **minimal** : contient le minimum de packages pour pouvoir utiliser
  Arcane.
- **full** : contient le maximum de package pour pouvoir utiliser le
  maximum des fonctionnalités d'Arcane. Dépend de **minimal** pour être
  construite.
- **doc** : contient les packages nécessaires pour compiler la
  documentation. Dépend aussi de **minimal** pour être construite.

## Les tags

Il y a quatre types de tags :
1. Dernière version du compilateur et de l'image (exemple : `gcc_full_latest`)
2. Dernière version du compilateur (exemple : `gcc_full_stable`)
3. Version du compilateur au choix (exemple : `gcc-14_full_stable`)
4. Versions du compilateur de l'image au choix, avec date de création 
   (exemple : `clang-21_full_20250830`)

(Les images `stable` sont construites depuis le 30/08/2025 (image v4). Les images v3
utilisaient `latest` à la place.)

Cela permet de choisir le compilateur voulu et le niveau de stabilité voulu selon
l'utilisation faite de l'image.

Le tag `1.` permet d'avoir la dernière version du compilateur.
C'est l'image qui sera le plus souvent mise à jour. Par exemple, si vous
compilez Arcane et que vous vous fichez de la version de `gcc` ou de `clang`,
ce tag convient. Ces images v4 `latest` sont expérimentales et Arcane peut ne
pas compiler dedans.

Le tag `2.` permet d'avoir la dernière version du compilateur mais dans une
image stable (où Arcane compile).

Le tag `3.` permet de choisir une version majeur de compilateur. Si la
version du compilateur importe pour vous, ce tag convient.

Le tag `4.` est le plus stable car son tag contient la date de création de
l'image. En effet, il permet de choisir une image
qui ne changera jamais (sauf si plusieurs images sont générées le même
jour, dans le cas de hotfix par exemple). Si vous souhaitez avoir le même
environnement de travail, les mêmes versions des outils en permanance
(pour reproduire des bugs par exemple), ce tag convient.

## Sélection du compilateur (images v3 et après)

Les images créées contiennent plusieurs compilateurs. Par exemple, si vous
choisissez le tag `gcc_full_latest`, vous aurez aussi le compilateur `clang`.

Il y a aussi plusieurs versions de compilateur dans la même image. Par exemple,
dans les images `20250830`, il y a `gcc-13` et `gcc-14`.

Ces images contiennent des scripts permettant de définir la version du
compilateur à utiliser par défaut. La liste des scripts disponibles est
disponible dans le README des branches construisant les images :
- https://github.com/arcaneframework/framework-ci/tree/image/ubuntu-2404
- https://github.com/arcaneframework/framework-ci/tree/image/ubuntu-2204

Ces scripts sont situés dans le dossier `/root/scripts` et le nom de ces scripts
correspond aux tags.

Exemple : pour l'image `ubuntu-2404:clang-21_full_stable`, on est sûr d'avoir
le script `/root/scripts/use_clang-21.sh` et ce script permet de définir
`clang-21` comme le clang par défaut (`clang` et `clang++`).

Le fonctionnement est le même sans numéro de version :
pour l'image `ubuntu-2404:gcc_minimal_stable`, on est sûr d'avoir
le script `/root/scripts/use_gcc.sh` et ce script permet de définir
le `gcc` ayant la version majeure la plus récente comme le gcc par défaut
(`gcc` et `g++`).

D'autres scripts sont aussi disponibles comme `/root/scripts/use_openmpi.sh`
et `/root/scripts/use_mpich.sh` pour utiliser OpenMPI ou MPICH.

Pour les images ayant des tags sans compilateur spécifié (comme
`ubuntu-2404:full_stable`), il y a quand même un compilateur `C++`
et tout ce qu'il faut pour compiler Arcane (on peut laisser CMake chercher).

## Les architectures

À partir des versions 20230906 (donc les images générées le 06/09/2023 et après),
deux architectures sont supportées par image :
- AMD64
- ARM64

Les images précédentes n'ont été générées que pour l'architecture AMD64.

## Images disponibles

Pour voir directement toutes les images disponibles ou pour les dates de
création, voir dans la partie "Package".

Voici les images disponibles :
- `ubuntu-2404:`
  - `gcc`
  - `clang`
  - `gcc-14`
  - `gcc-13`
  - `clang-21`
  - `clang-19`
    - `_minimal_stable`
    - `_minimal_datedecompil`

- `ubuntu-2404:`
  - `gcc`
  - `clang`
  - `cuda`
  - `rocm`
  - `gcc-14`
  - `gcc-13`
  - `clang-21`
  - `clang-19`
  - `cuda-130`
  - `rocm-643`
    - `_full_stable`
    - `_full_datedecompil`

- `ubuntu-2404:`
  - `gcc`
  - `clang`
    - `_minimal_latest`

- `ubuntu-2404:`
  - `gcc`
  - `clang`
  - `cuda`
  - `rocm`
    - `_full_latest`

- `ubuntu-2204:`
  - `gcc`
  - `clang`
  - `gcc-12`
  - `gcc-11`
  - `clang-16`
    - `_minimal_latest`

- `ubuntu-2204:`
  - `gcc`
  - `clang`
  - `cuda`
  - `rocm`
  - `gcc-12`
  - `gcc-11`
  - `clang-16`
  - `cuda-126`
  - `rocm-571`
    - `_full_latest`

Exemples :
- `ubuntu-2404:clang-21_full_stable`
- `ubuntu-2204:clang-14_full_latest`

Et les liens correspondants :
- `ghcr.io/arcaneframework/ubuntu-2404:clang-21_full_stable`
- `ghcr.io/arcaneframework/ubuntu-2204:clang-14_full_latest`

<br>

Pour générer la documentation, voici l'image actuellement disponible :
- `ubuntu-2404:gcc_doc_latest`

L'image de génération de documentation n'est utile que pour générer
la documentation, il n'y a donc qu'un tag recommandé. Les autres tags
peuvent ne plus fonctionner du jour au lendemain. En revanche,
lorsque l'on change d'OS pour ce type d'image, l'ancienne image perdurera
(mais ne sera plus forcement mise à jour).
En bref, le tag `gcc_doc_latest` fonctionnera toujours mais la version
de gcc n'est pas connu.


# Workflows

Les workflows disponibles sont:

- install_vcpkg_packages.yml
- ci-direct.yml
- image_creator.yml

## install_vcpkg_packages

Ce workflow permet de compiler (via `vcpkg`) les packages nécessaires
et de les publier dans le 'GitHub Packages' sous la forme de packages
Nuget. Il ne faut le lancer que si cette liste de package change ou si
on a mis à jour la version de `vcpkg`.

La variable `VCPKG_PUSH_HASH_PACKAGE_NAME` du workflow indique le nom
du package Nuget qui contiendra les produits installés. Il faut donc
incrémenter le numéro de version de cette variable si on fait évoluer
la liste des packages installés ou leur version. A noter qu'il n'est
pas possible avec Nuget de re-publier un packages existant avec le
même nom.

l'étape 'Install vpckg packages' de ce workflow est celle qui installe
les packages nécessaires pour Arcane. C'est dans cette étape qu'on
spécifie la liste des packages à installer.

Après la compilation et l'installation des packages, on utilise le
script `_build/vcpkg_cache/DoTar.cmake` pour publier les packages. Ce
script fait un tar du répertoire contenant `vcpkg` et les produits
installés et le publie sous la forme d'un package nuget.

NOTE: normalement `vcpkg` dispose d'un mécanisme interne pour faire
tout cela automatiquement mais cela ne fonctionne pas bien sous Linux
(TODO: ajouter références aux bugs) pour certains packages.

Pour éviter entre deux exécutions du workflow d'avoir à tout
recompiler (par exemple si on ajoute juste un package), on ajoute une
étape en début du workflow pour récupérer une ancienne version des
packages, dont le nom est donné par la variable
`VCPKG_PREINSTALL_HASH_PACKAGE_NAME`. Cette étape exécute le script
`_build/vcpkg_cache/DoUntar.cmake` pour faire cela.

## ci-direct

Le workflow `ci-direct` est celui qui permet de compiler Arcane en
même temps que les composantes Arccon, Arccore et Axlstar. Ce workflow
se lance manuellement et il est possible de spécifier lors du
lancement la branche ou le tag du dépot Arcane à utiliser (par exemple
`dev/cea`, `dev/ifen` ou `main`).

Ce workflow va d'abord récupérer une version des packages installés
par `vcpkg`. La variable `VCPKG_INSTALL_HASH_PACKAGE_NAME` permet de
spécifier cela. Elle doit correspondre à une version installée via le
workflow `install_vcpkg_packages` (et spécifiée par la variable
`VCPKG_PUSH_HASH_PACKAGE_NAME` de ce workflow). C'est le script
`_build/vcpkg_cache/DoUntar.cmake` qui effectue cette action.

Ensuite, le workflow effectue le configure de Arcane et la
compilation. La configuration se fait de manière classique (via cmake)
mais on ajoute deux variables:

- CMAKE_TOOLCHAIN_FILE qui contient le fichier cmake utilisé par
  `vcpkg` pour se configurer
- VCPKG_INSTALLED_DIR qui contient le répertoire ou sont installés les
  packages de `vcpkg`.

La variable cmake VCPKG_INSTALLED_DIR permet de spécifier le
répertoire où `vcpkg` a installé les produits. En spécifiant dans
cmake une toolchain spécifique pour `vcpkg`, c'est ce dernier qui va
gérer automatiquement les variables nécessaire pour rechercher les
packages (par exemple fait la distinction entre les packages de debug
et optimisées). Sous windows, `vcpkg` va aussi automatiquement
recopier dans le répertoire de l'exécutable les DLLs nécessaires à son
exécution (mais uniquement les DLLs associées à des packages installés
par `vcpkg`).

## image_creator

Ce workflow permet de construire des images Docker contenant le
nécessaire pour compiler, installer et lancer Arcane.

Les Dockerfiles et leur workflow se trouvent dans différentes branches.
En effet, il y a plusieurs versions du même workflow `image_creator`.
Ces branches dédiées ont un nom ayant la structure suivante :
`image/os-versionos`

Exemples :
- `image/ubuntu-2404`
- `image/ubuntu-2204`

Si l'on veut générer une image spécifique, on doit aller dans la partie
"Actions", choisir le workflow "Image Creator", cliquer sur "Run workflow"
et choisir la branche correspondante au couple "os-versionos" voulu.

Les images sont accessibles dans la partie "Package" de ce dépôt.

# Utilisation de 'Github CLI'

Il existe une version en ligne de commande (CLI) pour appeler l'API
GitHub: [GitHub CLI](https://github.com/cli/cli). Il est possible de
récupérer et d'installer cet outil. Une fois configuré, il est
possible de se placer directement dans ce dépot et de lancer le
workflow via une commande telle que:

~~~sh
# Lance le workflow 'ci-direct' sur la branche 'dev/cea' du framework Arcane
gh workflow run ci-direct.yml -f framework_branch=dev/cea
~~~

Cet outil permet de faire beaucoup plus de choses comme suivre les
workflow, faire des 'pull request', ...

# TODO

- [ ] Ajouter l'exécution de plus de tests (par exemple des tests parallèles)
- [ ] Regarder pourquoi l'installation séparée ne fonctionne pas.
- [ ] Sous windows, recopier les DLLs dans les répertoires des
  exécutables pour que les tests Arcane fonctionnent (les tests
  arccore fonctionnent bien car ils ne dépendent que de packages
  instalés par `vcpkg` et ce dernier gère la copie).