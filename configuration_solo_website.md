### Manuel pour Mettre en Ligne un Site Web avec Nginx sur Debian 12 (Bookworm)

Ce manuel vous guidera à travers les étapes nécessaires pour installer et configurer Nginx sur Debian 12 afin de mettre en ligne un site web dans le répertoire par défaut `/var/www/html`.

#### Pré-requis
- Accès root ou sudo sur le serveur
- Une adresse IP publique

#### Étapes :

### 1. Mise à Jour du Système

Mettez à jour les paquets existants pour vous assurer que tout est à jour :

```bash
sudo apt update
sudo apt upgrade -y
```

### 2. Installation de Nginx

Installez Nginx :

```bash
sudo apt install nginx -y
```

### 3. Vérification et Activation de Nginx

Assurez-vous que Nginx fonctionne :

```bash
sudo systemctl status nginx
```

Activez Nginx pour qu'il démarre au boot :

```bash
sudo systemctl enable nginx
```

### 4. Configuration de Nginx pour Utiliser le Répertoire Par Défaut

Par défaut, Nginx utilise le répertoire `/var/www/html`. Nous allons vérifier et modifier le fichier de configuration par défaut.

#### a. Modifier le Fichier de Configuration Principal de Nginx

Ouvrez et modifiez le fichier de configuration principal de Nginx :

```bash
sudo nano /etc/nginx/nginx.conf
```

Assurez-vous que les directives suivantes sont présentes et non commentées :

```nginx
user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
    worker_connections 768;
    # multi_accept on;
}

http {
    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    types_hash_max_size 2048;

    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;

    server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html;
        index index.html index.htm index.nginx-debian.html;

        server_name _;

        location / {
            try_files $uri $uri/ =404;
        }
    }
}
```

#### b. Modifier le Fichier de Configuration du Site par Défaut

Ouvrez le fichier de configuration par défaut :

```bash
sudo nano /etc/nginx/sites-available/default
```

Assurez-vous que le contenu est le suivant :

```nginx
server {
    listen 80;
    server_name votre_adresse_ip_publique;

    root /var/www/html;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

Remplacez `votre_adresse_ip_publique` par votre adresse IP publique (par exemple, `85.215.196.128`).

Enregistrez et fermez le fichier (`Ctrl+X`, puis `Y`, puis `Enter`).

#### c. Désactiver les Configurations de Site Supplémentaires

Supprimez les configurations de site supplémentaires pour éviter les conflits :

```bash
sudo rm /etc/nginx/sites-enabled/mon_site
```

### 5. Redémarrer Nginx

Redémarrez Nginx pour appliquer les modifications :

```bash
sudo systemctl restart nginx
```

### 6. Créer votre Page Web

Créez un fichier `index.html` dans le répertoire `/var/www/html` :

```bash
sudo nano /var/www/html/index.html
```

Ajoutez le contenu suivant :

```html
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
```

Enregistrez et fermez le fichier (`Ctrl+X`, puis `Y`, puis `Enter`).

### 7. Vérifier les Permissions

Assurez-vous que le répertoire et les fichiers ont les bonnes permissions :

```bash
sudo chown -R $USER:$USER /var/www/html
sudo chmod -R 755 /var/www/html
```

### 8. Configuration du Pare-feu

Assurez-vous que le pare-feu permet les connexions sur le port 80 :

```bash
sudo ufw allow 22/tcp
sudo ufw allow 'Nginx HTTP'
sudo ufw enable
```

### 9. Vérifier les Ports Ouverts

Vérifiez que Nginx écoute bien sur le port 80 :

```bash
sudo ss -tuln | grep 80
```

### 10. Vérification des Journaux de Nginx

Consultez les journaux de Nginx pour voir s'il y a des erreurs :

```bash
sudo tail -f /var/log/nginx/error.log
```

### 11. Tester la Configuration de Nginx

Testez la configuration de Nginx pour vous assurer qu'elle est correcte :

```bash
sudo nginx -t
```

### 12. Redémarrer le Serveur

Parfois, un simple redémarrage du serveur peut résoudre des problèmes de connectivité :

```bash
sudo reboot
```

### Vérification Finale

Après avoir suivi ces étapes, accédez à votre site web en ouvrant un navigateur et en allant à `http://votre_adresse_ip_publique`. Vous devriez voir votre page avec le message "Ça marche !".

### Résolution des Problèmes

- **Nginx ne démarre pas :**
  - Vérifiez les journaux de Nginx : `sudo tail -f /var/log/nginx/error.log`
  - Testez la configuration de Nginx : `sudo nginx -t`

- **Page par défaut de Nginx s'affiche :**
  - Assurez-vous que le fichier de configuration dans `/etc/nginx/sites-available/default` est correctement configuré.
  - Redémarrez Nginx après toute modification : `sudo systemctl restart nginx`

- **Erreur `ERR_CONNECTION_REFUSED` :**
  - Assurez-vous que Nginx est en cours d'exécution : `sudo systemctl status nginx`
  - Vérifiez que Nginx écoute sur le port 80 : `sudo ss -tuln | grep 80`
  - Vérifiez les règles du pare-feu : `sudo ufw status`

### Conclusion

Vous avez maintenant mis en place un site web simple sur un serveur Debian 12 (Bookworm) avec Nginx. Pour toute personnalisation supplémentaire, vous pouvez ajuster le fichier de configuration de Nginx selon vos besoins. Si vous avez d'autres questions ou des besoins spécifiques, n'hésitez pas à demander !
