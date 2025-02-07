FROM python:3.9-slim
# Cette ligne indique l'image de base à utiliser pour la construction de l'image Docker.
# Ici, l'image de base est python:3.9-slim, qui est une version allégée de l'image officielle de Python 3.9.
# Elle contient les outils et bibliothèques essentiels pour exécuter des applications Python
# mais est optimisée pour être plus petite que les images Python standard.

WORKDIR /app
# Définit le répertoire de travail dans le conteneur Docker.
# Cela signifie que toutes les actions ultérieures,
# comme la copie de fichiers ou l'exécution de commandes,
# seront effectuées dans le chemin /app à l'intérieur du conteneur.

COPY requirements.txt requirements.txt
# Copie le fichier requirements.txt de votre projet (situé sur votre machine ou dans votre répertoire source)
# dans le répertoire /app du conteneur, en concervant le nom du fichier: requirements.txt.


RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*
# Cette commande est exécutée lors de la construction de l'image.
# Elle met à jour la liste des paquets disponibles,
# installe Git dans le conteneur (ce qui peut être nécessaire pour les dépendances ou scripts qui utilisent Git),
# puis supprime les fichiers de liste de paquets pour réduire la taille de l'image.
# Les options utilisées sont :
#     * apt-get update : met à jour la liste des paquets.
#     * apt-get install -y git : installe Git sans demander de confirmation grâce à l'option -y.
#     * rm -rf /var/lib/apt/lists/* : supprime les fichiers de liste de paquets pour garder l'image légère.

RUN pip install --upgrade pip setuptools wheel
# Mise à jour de pip, setuptools et wheel
# Setuptools et wheel facilitent la distribution et l'installation des packages Python :
# Développeurs : Peuvent facilement empaqueter leurs projets en utilisant setuptools et générer des distributions wheel.
# Utilisateurs finaux : Peuvent installer les packages plus rapidement et sans avoir besoin de compiler le code source.

RUN pip install --no-cache-dir -r requirements.txt
# Exécute pip install pour installer les paquets Python listés dans le fichier requirements.txt.
# L'option --no-cache-dir empêche pip de garder une copie des fichiers de paquet téléchargés,
# ce qui est une autre mesure pour garder l'image Docker légère.
# L'option -r indique à pip de lire à partir du fichier de requirements spécifié (requirements.txt dans ce cas).

COPY . .
# Copie tous les autres fichiers et dossiers du répertoire courant (de votre machine ou répertoire source)
# dans le répertoire de travail actuel du conteneur Docker (cf. WORKDIR /app).

CMD ["mage", "start"]
# Définit la commande par défaut qui sera exécutée lorsque le conteneur Docker est lancé.
# Ici, cela suppose que "mage" soit un exécutable configuré dans l'image et que vous souhaitez exécuter avec l'argument "start".
# Cette commande n'est exécutée que lorsque le conteneur est lancé, pas au moment de la construction de l'image.