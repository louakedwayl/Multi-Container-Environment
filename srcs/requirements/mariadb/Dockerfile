# Utilise l'image officielle Debian Bullseye comme base
FROM debian:bullseye

# Met à jour les paquets et installe MariaDB server,
# puis nettoie le cache des paquets pour réduire la taille de l'image
RUN apt-get update && apt-get install -y mariadb-server \
    && rm -rf /var/lib/apt/lists/*

# Copie la configuration personnalisée de MariaDB dans le dossier de configuration
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copie le script d'entrée (entrypoint) et rend ce script exécutable
COPY ./tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose le port 3306 pour MariaDB (port par défaut)
EXPOSE 3306

# Définit le script d'entrée qui sera lancé au démarrage du container
ENTRYPOINT ["/entrypoint.sh"]

