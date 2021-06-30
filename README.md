# README

Ce dépot contient les scripts pour l'intégration continue (CI) de Arcane.

Il permet de découpler le code gérant le CI du code source
d'Arcane. Il n'y a donc aucun code spécifique pour le CI dans le dépot
Arcane.

Il permet aussi d'avoir un temps illimité pour le CI via 'GitHub' tant
que le dépot de Arcane est privé.

Actuellement, le CI utilise le mécanisme de 'GitHub', appelé 'GitHub
Actions'. Ce mécanisme utilise des scripts au format YAML qui sont dans
le répertoire `.github/workflows`. Il y a un script par action
possible. Il est possible d'accéder aux actions via l'interface WEB de
git en cliquant sur l'onglet 'Actions' sous le nom du dépot:

<img src="./docs/action_screenshot.png" />

Le CI fonctionne à la fois sous windows et linux

Afin d'éviter d'être dépendant de produits externes et d'être portable
entre les plateformes, le CI utilise uniquement des scripts CMake.

Lors de l'exécution d'un workflow, ce dépot a besoin d'accéder au
dépot contenant les sources de Arcane. Comme ce dépot est privé, il
est nécessaire de s'authentifier. Pour cela, GitHub utilise des tokens
conservés dans la partie `secrets`. Le secret 'ArcaneFrameworkCI'
permet d'accéder au dépot Arcane. Il doit être spécifié dans le
workflow lors du checkout de Arcane.

## Compilation des packages

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

## Workflows

Les workflows disponibles sont:

- install_vcpkg_packages.yml
- ci-direct.yml

### install_vcpkg_packages

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

### ci-direct

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

## Utilisation de 'Github CLI'

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

## TODO

- [ ] Ajouter l'exécution de plus de tests (par exemple des tests parallèles)
- [ ] Regarder pourquoi l'installation séparée ne fonctionne pas.
- [ ] Sous windows, recopier les DLLs dans les répertoires des
  exécutables pour que les tests Arcane fonctionnent (les tests
  arccore fonctionnent bien car ils ne dépendent que de packages
  instalés par `vcpkg` et ce dernier gère la copie).