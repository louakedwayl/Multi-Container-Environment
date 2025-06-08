#!/bin/bash
set -e #si une commande echoue exit le script

# Démarrer MariaDB en arrière-plan
mysqld_safe &

# Récupérer le PID du dernier processus lancé en arrière-plan
pid="$!"

# Boucle until jusqu'a ce que la condition mysqladmin ping --silent soit vrai 
# cad boucle sur le retour de ping Si MariaDB n’est pas prêt, la commande échoue 
#(retourne un code différent de 0), donc la boucle continue.
#Si MariaDB est prêt, la commande réussit (retourne 0), alors la boucle s’arrête.
until mysqladmin ping --silent; do
    echo "Waiting for MariaDB to be ready..."
    sleep 1
done

# Exécuter le script SQL d'initialisation
mysql < /init.sql

# Attendre la fin du serveur MariaDB (en avant-plan)
wait $pid

