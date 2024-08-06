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

sudo ufw deny 80/tcp
