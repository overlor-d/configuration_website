#!/bin/sh

# Nettoyage et préparation du serveur
sudo systemctl stop nginx || true
sudo systemctl disable nginx || true
sudo apt purge nginx nginx-common nginx-full -y
sudo rm -rf /etc/nginx
sudo rm -rf /var/www/html
sudo apt autoremove -y
sudo apt clean
sudo apt autoclean
sudo ufw delete allow 'Nginx HTTP' || true
sudo ufw delete allow 'Nginx HTTPS' || true

# Mise à jour des paquets
sudo apt update
sudo apt upgrade -y

# Installation de Nginx
sudo apt install nginx -y

# Activation de Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Configuration principale de Nginx
sudo bash -c 'cat > /etc/nginx/nginx.conf <<EOF
user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
    worker_connections 768;
}

http {
    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    types_hash_max_size 2048;

    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    include /etc/nginx/conf.d/*.conf;

    server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html;
        index index.html index.htm index.nginx-debian.html;

        server_name _;

        location / {
            try_files \$uri \$uri/ =404;
        }
    }
}
EOF'

# Configuration du site par défaut
sudo bash -c 'cat > /etc/nginx/sites-available/default <<EOF
server {
    listen 80;
    server_name 85.215.196.128;

    root /var/www/html;
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF'

# Créer le répertoire et le fichier index.html
sudo mkdir -p /var/www/html
sudo bash -c 'cat > /var/www/html/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bienvenue sur mon site</title>
</head>
<body>
    <h1>Ça marche !</h1>
</body>
</html>
EOF'

# Définir les permissions correctes
sudo chown -R $USER:$USER /var/www/html
sudo chmod -R 755 /var/www/html

# Configuration du pare-feu
sudo ufw allow 22/tcp
sudo ufw allow 'Nginx HTTP'
sudo ufw enable

# Vérification et redémarrage de Nginx
sudo nginx -t
sudo systemctl restart nginx

# Vérification des ports ouverts
sudo ss -tuln | grep 80

# Fin du script
echo "Configuration terminée. Accédez à votre site web à l'adresse http://85.215.196.128/"
