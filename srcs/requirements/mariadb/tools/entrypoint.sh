#!/bin/bash
set -e

mysqld_safe &

pid="$!"

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

cat > /tmp/init_dynamic.sql <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED VIA mysql_native_password USING PASSWORD('${MYSQL_ROOT_PASSWORD}');

CREATE DATABASE IF NOT EXISTS inception_db;

CREATE USER IF NOT EXISTS 'wlouaked'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
CREATE USER IF NOT EXISTS 'wlouaked'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';

GRANT ALL PRIVILEGES ON inception_db.* TO 'wlouaked'@'%';
GRANT ALL PRIVILEGES ON inception_db.* TO 'wlouaked'@'localhost';

FLUSH PRIVILEGES;
EOF

mysql -u root -p"$MYSQL_ROOT_PASSWORD" < /tmp/init_dynamic.sql

wait $pid

