# Multi-Container-Environment

## Introduction

Docker is a containerization platform that allows you to package applications and their dependencies into isolated and portable containers. This technology has revolutionized application deployment by ensuring they run identically regardless of the execution environment.
The goal of this project is to create a complete web services infrastructure using Docker and Docker Compose. I had to set up multiple containers that communicate with each other to form a cohesive system: an NGINX web server configured with TLS, a MariaDB database, and a functional WordPress site with php-fpm.
Each service runs in its own container, built from the penultimate stable version of Alpine or Debian. All these services are orchestrated via Docker Compose, and data is persisted through Docker volumes.

## 🛠️ Containers to create

```bash
    NGINX
        Web server
        With SSL/TLS
    WordPress
        Dynamic website
    MariaDB
        Database
```

## 🔗 Network

Connect containers in a private Docker network
Allow services to communicate with each other

💾 Data persistence

Store data from:
WordPress
MariaDB
Use persistent volumes to prevent any loss when stopping containers

### installation

```bash
make
```

### To connect to the database:

```bash
docker exec -it mariadb mysql -u user -p
```

### Select the database:

```bash
USE inception_db;
```

### List the tables in the database:

```bash
SHOW TABLES;
```
