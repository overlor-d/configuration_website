### 1. Arrêter et Désactiver Nginx

D'abord, arrêtez Nginx et désactivez-le pour qu'il ne se lance pas au démarrage :

```bash
sudo systemctl stop nginx
sudo systemctl disable nginx
```

### 2. Supprimer les Paquets Nginx

Ensuite, supprimez les paquets Nginx :

```bash
sudo apt purge nginx nginx-common nginx-full -y
```

### 3. Supprimer les Fichiers de Configuration

Supprimez les fichiers de configuration de Nginx :

```bash
sudo rm -rf /etc/nginx
```

### 4. Supprimer le Répertoire Web

Supprimez le répertoire web par défaut et son contenu :

```bash
sudo rm -rf /var/www/html
```

### 5. Nettoyer les Paquets Orphelins

Supprimez les paquets qui ne sont plus nécessaires :

```bash
sudo apt autoremove -y
```

### 6. Nettoyer les Fichiers Temporaires

Nettoyez les fichiers temporaires et le cache des paquets :

```bash
sudo apt clean
sudo apt autoclean
```

### 7. Vérifier et Nettoyer les Règles du Pare-feu

Assurez-vous que les règles du pare-feu ne contiennent plus de règles pour Nginx :

```bash
sudo ufw delete allow 'Nginx HTTP'
sudo ufw delete allow 'Nginx HTTPS'
```

Vérifiez le statut du pare-feu pour vous assurer qu'il n'y a plus de règles inutiles :

```bash
sudo ufw status
```

### 8. Redémarrer le Serveur

Enfin, redémarrez votre serveur pour appliquer toutes les modifications :

```bash
sudo reboot
```

### Résumé des Commandes

Voici un résumé de toutes les commandes :

```bash
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
sudo reboot
```

Ces étapes devraient vous permettre de supprimer complètement Nginx et de nettoyer votre système. Si vous avez d'autres questions ou besoins supplémentaires, n'hésitez pas à demander !