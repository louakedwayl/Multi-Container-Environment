# Utiliser une version stable et légère de Debian
FROM debian:bullseye

# Variables d’environnement pour réutiliser facilement
ENV PHP_VERSION=7.4
ENV WP_PATH=/var/www/wordpress

# Mise à jour, installation des dépendances, nettoyage
RUN apt update -y && apt upgrade -y && \
    apt-get install -y --no-install-recommends \
        php${PHP_VERSION} php${PHP_VERSION}-fpm php${PHP_VERSION}-mysql \
        wget mariadb-client sed ca-certificates curl unzip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Créer les répertoires nécessaires
RUN mkdir -p /run/php $WP_PATH && \
    chown -R www-data:www-data $WP_PATH && \
    chmod -R 755 $WP_PATH

# Configuration de PHP-FPM pour écouter sur l'adresse réseau
RUN sed -i "s|^listen = .*|listen = 0.0.0.0:9000|" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf && \
    sed -i "s|^;listen.owner = .*|listen.owner = www-data|" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf && \
    sed -i "s|^;listen.group = .*|listen.group = www-data|" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf && \
    sed -i "s|^;listen.mode = .*|listen.mode = 0660|" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf && \
    sed -i "s|^;pid = .*|pid = /run/php/php${PHP_VERSION}-fpm.pid|" /etc/php/${PHP_VERSION}/fpm/php-fpm.conf

# Copier le script de configuration
COPY conf/setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup.sh

# Installer WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# Port exposé pour PHP-FPM
EXPOSE 9000

# Commande par défaut : exécute le script puis lance PHP-FPM en avant-plan
CMD ["/bin/bash", "-c", "/usr/local/bin/setup.sh && exec php-fpm${PHP_VERSION} -F"]

