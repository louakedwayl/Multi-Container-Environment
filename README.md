# inception

Ce projet a pour but d’approfondir vos connaissances en vous faisant utiliser Docker. Vous allez virtualiser plusieurs images Docker en les créant dans votre nouvelle machine virtuelle personnelle.

## Créer plusieurs conteneurs Docker :

### Un conteneur NGINX (serveur web, avec SSL/TLS).

### Un conteneur WordPress (site web dynamique).

### Un conteneur MariaDB (base de données).

## Les connecter dans un réseau Docker privé pour qu’ils puissent échanger entre eux.

## Stocker les données (WordPress et MariaDB) dans des volumes persistants pour ne pas perdre tes infos quand tu arrêtes les conteneurs.

## Automatiser le tout avec docker-compose.yml.

## Gérer quelques contraintes supplémentaires (droits utilisateurs, gestion des images, sécurité, etc.).


### installation

```bash
make
```

### Pour se connecter a la database :

```bash
docker exec -it mariadb mysql -u user -p
```

### Choisir la base de données :

```bash
USE inception_db;
```

### Lister les tables de la base :

```bash
SHOW TABLES;
```
