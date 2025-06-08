# inception
Ce projet a pour but d’approfondir vos connaissances en vous faisant utiliser Docker. Vous allez virtualiser plusieurs images Docker en les créant dans votre nouvelle machine virtuelle personnelle.


Pour se connecter a la database :

docker exec -it mariadb mysql -u user -p

Lister les users :

SELECT User, Host FROM mysql.user;
