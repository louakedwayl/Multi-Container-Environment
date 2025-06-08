#!/bin/bash
set -e


# Attendre que MariaDB soit accessible
until mysql -h "$DB_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SELECT 1;" > /dev/null 2>&1; do
  echo "⏳ Attente de la base de données..."
  sleep 2
done

echo "✅ Base de données accessible."

if [ ! -f "$WP_PATH/wp-config.php" ]; then
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

    # Installer WP seulement si pas déjà installé
    if ! wp core is-installed --path="$WP_PATH" --allow-root; then
        echo "🚀 Installation automatique de WordPress..."
        wp core install \
            --path="$WP_PATH" \
            --url="https://wlouaked.42.fr" \
            --title="Mon Site" \
            --admin_user="$ADMIN_USER" \
            --admin_password="$ADMIN_PASSWORD" \
            --admin_email="$ADMIN_EMAIL" \
            --skip-email \
            --allow-root
    fi
else
    echo "ℹ️ WordPress est déjà configuré."
fi

if wp core is-installed --path="$WP_PATH" --allow-root; then
    echo "✅ WordPress est installé, vérification des utilisateurs..."

    if ! wp user get "$ADMIN_USER" --allow-root --path="$WP_PATH" > /dev/null 2>&1; then
        wp user create "$ADMIN_USER" "$ADMIN_USER@student.42.fr" --role=administrator --user_pass="$ADMIN_PASSWORD" --allow-root --path="$WP_PATH"
        echo "✅ Utilisateur $ADMIN_USER créé."
    else
        echo "ℹ️ Utilisateur $ADMIN_USER déjà existant."
    fi

    if ! wp user get "$WAYL_USER" --allow-root --path="$WP_PATH" > /dev/null 2>&1; then
        wp user create "$WAYL_USER" "$WAYL_USER@student.42.fr" --role=author --user_pass="$WAYL_PASSWORD" --allow-root --path="$WP_PATH"
        echo "✅ Utilisateur $WAYL_USER créé."
    else
        echo "ℹ️ Utilisateur $WAYL_USER déjà existant."
    fi
else
    echo "⚠️ WordPress n'est pas installé."
fi

if wp user get admin --allow-root --path="$WP_PATH" > /dev/null 2>&1; then
    wp user delete admin --reassign=$ADMIN_USER --allow-root --path="$WP_PATH" --yes
    echo "✅ Utilisateur admin supprimé et ses contenus transférés à $ADMIN_USER."
else
    echo "ℹ️ Utilisateur admin n'existe pas, rien à faire."
fi

