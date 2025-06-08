#!/bin/bash
set -e

mysqld_safe &

pid="$!"

# Timeout de 30 secondes max
timeout=30
while ! mysqladmin ping --silent; do
    echo "Waiting for MariaDB to be ready..."
    sleep 1
    timeout=$((timeout - 1))
    if [ $timeout -le 0 ]; then
        echo "Timeout waiting for MariaDB to start"
        exit 1
    fi
done

mysql -u root -p"$MYSQL_ROOT_PASSWORD" < /init.sql

wait $pid

