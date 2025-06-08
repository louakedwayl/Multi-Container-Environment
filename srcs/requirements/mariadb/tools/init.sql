-- Forcer root à utiliser mysql_native_password (connexion par mdp)
ALTER USER 'root'@'localhost' IDENTIFIED VIA mysql_native_password USING PASSWORD('123soleil456');

-- Création de la base de données 'inception_db' si elle n'existe pas déjà
CREATE DATABASE IF NOT EXISTS inception_db;

-- Création de l'utilisateur 'wlouaked' avec son mot de passe
CREATE USER IF NOT EXISTS 'wlouaked'@'%' IDENTIFIED BY 'password_inception';

-- Attribution des privilèges complets sur inception_db à cet utilisateur
GRANT ALL PRIVILEGES ON inception_db.* TO 'wlouaked'@'%';

-- Appliquer immédiatement les changements de privilèges
FLUSH PRIVILEGES;

