#!/bin/bash

echo "ADMIN_USER=$ADMIN_USER"
echo "ADMIN_PASSWORD=$ADMIN_PASSWORD"

sleep 10

if [ ! -f "$WP_PATH/wp-config.php" ]; then
    # Installer WordPress seulement si pas encore configuré
    if [ ! -d "$WP_PATH/wp-includes" ]; then
        echo "⬇️ Téléchargement de WordPress..."
        wp core download --path="$WP_PATH" --allow-root
    fi

    echo "📄 Création du fichier wp-config.php..."
    wp config create \
        --path="$WP_PATH" \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --dbhost="$DB_HOST" \
        --skip-check \
        --allow-root

    echo "⚠️ WordPress téléchargé et configuré, mais pas installé !"
else
    echo "ℹ️ WordPress est déjà configuré."
fi

# Vérifier si WP est installé (présence de tables dans la base)
if wp core is-installed --path="$WP_PATH" --allow-root; then
    echo "✅ WordPress est installé, vérification des utilisateurs..."

    # Créer utilisateur maya si absent
    if ! wp user get maya --allow-root --path="$WP_PATH" > /dev/null 2>&1; then
        wp user create maya maya@student.42.fr --role=administrator --user_pass=mya222 --allow-root --path="$WP_PATH"
        echo "✅ Utilisateur maya créé."
    else
        echo "ℹ️ Utilisateur maya déjà existant."
    fi

    # Créer utilisateur wayl si absent
    if ! wp user get wayl --allow-root --path="$WP_PATH" > /dev/null 2>&1; then
        wp user create wayl wayl@student.42.fr --role=author --user_pass=waylpass --allow-root --path="$WP_PATH"
        echo "✅ Utilisateur wayl créé."
    else
        echo "ℹ️ Utilisateur wayl déjà existant."
    fi

else
    echo "⚠️ WordPress n'est pas installé. Merci d'installer manuellement via wp core install."
fi

if wp user get admin --allow-root --path="$WP_PATH" > /dev/null 2>&1; then
    wp user delete admin --reassign=$ADMIN_USER --allow-root --path="$WP_PATH" --yes
    echo "✅ Utilisateur admin supprimé et ses contenus transférés à $ADMIN_USER."
else
    echo "ℹ️ Utilisateur admin n'existe pas, rien à faire."
fi

