FROM debian:bullseye
# Utilise l'image officielle Debian Bullseye comme base pour construire ton image

RUN apt-get update && apt-get install -y nginx git curl openssl \
    && rm -rf /var/lib/apt/lists/*
# Met à jour la liste des paquets et installe nginx, git, curl, openssl  
# Puis supprime le cache des paquets pour alléger l'image finale

RUN mkdir -p /var/run/nginx /etc/nginx/ssl
# Crée les dossiers nécessaires : 
# - /var/run/nginx : pour les fichiers PID de nginx  
# - /etc/nginx/ssl : pour stocker les certificats SSL

COPY conf/nginx.conf /etc/nginx/nginx.conf
# Copie ton fichier de configuration nginx personnalisé dans l'image,  
# remplaçant la config par défaut

RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=Inception/CN=wlouaked.42.fr"
# Génère un certificat SSL auto-signé valide 365 jours  
# avec une clé RSA 2048 bits  
# Le certificat est enregistré dans /etc/nginx/ssl/inception.crt  
# La clé privée dans /etc/nginx/ssl/inception.key  
# Le champ CN (Common Name) du certificat est "wlouaked.42.fr"

EXPOSE 80 443
# Indique que le conteneur écoute sur les ports 80 et 443

CMD ["nginx", "-g", "daemon off;"]
# Démarre nginx en mode non daemonisé (en avant-plan) pour que le conteneur reste actif

#sudo docker run -d --name mon_nginx -p 8080:80 -p 4443:443 nginx:1.0
