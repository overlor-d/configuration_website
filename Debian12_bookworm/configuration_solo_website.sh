#!/bin/sh

sudo systemctl stop nginx
sudo systemctl disable nginx
sudo apt purge nginx nginx-common nginx-full -y
sudo rm -rf /etc/nginx
sudo rm -rf /var/www/html
sudo apt autoremove -y
sudo apt clean
sudo apt autoclean
sudo ufw delete allow 'Nginx HTTP'
sudo ufw delete allow 'Nginx HTTPS'

sudo apt update
sudo apt upgrade -y

sudo apt install nginx -y

sudo systemctl start nginx
sudo systemctl enable nginx

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

sudo bash -c 'cat > /etc/nginx/sites-available/default <<EOF
server {
    listen 80;
    server_name votre_adresse_ip_publique;

    root /var/www/html;
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF'

sudo sed -i 's/votre_adresse_ip_publique/85.215.196.128/' /etc/nginx/sites-available/default

sudo mkdir -p /var/www/html
sudo bash -c 'cat > /var/www/html/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome on my title</title>
</head>
<body>
    <h1>Online !<br>abcdefghijklmnopqrstuvwxyz!?éèàê0123456789<br>ABCDEFGHIJKLMNOPQRSTUVWXYZ&{}()[]</h1>
</body>
</html>
EOF'

sudo chown -R $USER:$USER /var/www/html
sudo chmod -R 755 /var/www/html

sudo ufw allow 22/tcp
sudo ufw allow 'Nginx HTTP'
sudo ufw enable

sudo nginx -t
sudo systemctl restart nginx

sudo ufw allow 80/tcp
sudo ufw reload

sudo ss -tuln | grep 80

echo "Configuration terminée. Accédez à votre site web à l'adresse http://85.215.196.128/"
