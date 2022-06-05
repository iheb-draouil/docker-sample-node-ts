# Cette image est basée sur l'image node:18 déjà existante dans Docker hub qui a été développée par l'équipe Node elle-même
FROM node:18

# Ceci définit un nouveau répertoire "setup" sous le répertoire "/var" existant
# Nous allons utiliser ce répertoire pour compiler TypeScript en JavaScript
# Nous déplacerons ensuite les fichiers JavaScript compilés dans le répertoire "www"
RUN mkdir /var/setup

# Ce répertoire hébergera les fichiers de l'application
RUN mkdir /var/www

# Cela demande à Docker de copier les fichiers source du projet à l'intérieur de l'image sous le répertoire "/var/setup"
# ".dockerignore" s'assure que nous ne copierons jamais les répertoires "node_modules" et "dist" s'ils existent
COPY . /var/setup

# Cela définira le répertoire courant sur "/var/setup"
# Cela signifie que toutes les instructions que nous exécutons à partir de maintenant seront exécutées dans ce répertoire
WORKDIR /var/setup

# Cette instruction installe toutes les dépendances spécifiées dans package.json verrouillées sur les versions spécifiées dans package-lock.json
# Les seules dépendances dont nous avons besoin pour ce tutoriel sont le compilateur TypeScript
RUN npm install

# Cela exécute le script "build" dans package.json
# Ceci est un alias de la commande << tsc >> qui est la commande qui va compiler les fichiers typescript
# Le résultat de cette commande sera la création du répertoire "dist" sous "/var/setup"
# Le répertoire "dist" est spécifié dans tsconfig.json
# Le compilateur ne recherchera que les fichiers à l'intérieur du "src" qui est également configuré dans tsconfig.json
RUN npm run build

# Cela copier les fichiers JavaScript compilés dans le répertoire "/var/www"
# Remarquez que nous n'exécutons pas << cp /var/setup/dist/* /var/www >> C'est parce que notre workdir est "/var/setup"
RUN cp dist/* /var/www

# Puisque nous n'avons plus besoin des fichiers du projet, nous pouvons supprimer le répertoire "/var/setup" avec tout son contenu

# Nous passons au répertoire racine "/" car "/var/setup" sera ensuite supprimé
WORKDIR /

# Cela supprime le répertoire "/var/setup"
RUN rm -Rf /var/setup

# Lorsqu'un conteneur est créé à partir de cette image, cela démarrera le serveur
ENTRYPOINT ["/usr/local/bin/node", "/var/www/index.js"]