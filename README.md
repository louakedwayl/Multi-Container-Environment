# inception

Ce projet a pour but d’approfondir vos connaissances en vous faisant utiliser Docker. Vous allez virtualiser plusieurs images Docker en les créant dans votre nouvelle machine virtuelle personnelle.

## 🛠️ Conteneurs à créer

- **NGINX**
  - Serveur web
  - Avec **SSL/TLS**

- **WordPress**
  - Site web dynamique

- **MariaDB**
  - Base de données

---

## 🔗 Réseau

- Connecter les conteneurs dans un **réseau Docker privé**  
- Permettre aux services d’échanger entre eux

---

## 💾 Persistance des données

- Stocker les données de :
  - **WordPress**
  - **MariaDB**
- Utiliser des **volumes persistants** pour éviter toute perte lors de l’arrêt des conteneurs

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
