# inception

Ce projet a pour but d’approfondir vos connaissances en vous faisant utiliser Docker. Vous allez virtualiser plusieurs images Docker en les créant dans votre nouvelle machine virtuelle personnelle.

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
