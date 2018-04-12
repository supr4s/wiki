## Présentation d’OwnCloud

OwnCloud est un logiciel libre offrant une plateforme de services de stockage, partage de fichiers et d'applications diverses en ligne. Très pratique si l’on souhaite l’intégrer dans son LAN pour un espace de stockage privé.

### Préparation du serveur WEB

OwnCloud seras installé ici sous un OS Debian 8 utilisant le serveur Web Apache.

Installation des différentes librairies d’Apache et préparation de la plate-forme web (en droit root) avec une base de donnée.

Pendant l’installation de mysql il sera demandé de créer un nouveau mot de passe pour l’utilisateur root.

```
apt-get update

apt-get install apache2 php5 php5-common php5-gd

apt-get install php5-sqlite curl libcurl3 libcurl3-dev php5-curl

apt-get install mysql-server mysql-client
```

### Installation d’OwnCloud

Mis à jour du dépôts pour OwnCloud 

```
echo 'deb http://download.opensuse.org/repositories/isv:ownCloud:community/Debian_8.0/ /' >> /etc/apt/sources.list.d/owncloud.list

wget -qO - http://download.opensuse.org/repositories/isv:ownCloud:community/Debian_8.0/Release.key | apt-key add -

apt-get update

apt-get install owncloud
```

Si l’installation c’est bien déroulé, le dossier Owncloud devrais apparaître dans /var/www.
Définir l’utilisateur choisis en tant que groupe propriétaire sur les répertoires utiles au fonctionnement d’OwnCloud.

```cd /var/www

chown www-data:www-data -R owncloud/

chmod 770 –R owncloud/
```

Activer les modules rewrite (réécriture d’URL) et headers (requêtes/réponses http) pour qu’OwnCloud fonctionne correctement. 

```
a2enmod rewrite 

 a2enmod headers
 ```

Redémarrage du service Apache. 

```
service apache2 restart
```

## Vérification

Testez ensuite la bonne installation d’OwnCloud et du serveur web en allant à l’adresse http://IpDuServeurWeb/owncloud. La page d’accueil devrais donc apparaître. 

### Configuration d'OwnCloud

Il suffit ensuite de créer un compte administrateur, et de garder " SQLite " en choix de base de donnée pour une utilisation standard. Sinon, pour une utilisation volumineuse, renseigner MySQL/MariaDB, crée un utilisateur et une base de donnée dédie owncloud en lui donnant tout les droits (via l'interface de commande MySQL).
Ensuite, il faut se rendre dans le panneau d'administration et crée des utilisateurs avec mot de passe. On peut également crée des groupes pour pouvoir placer différents utilisateurs dans ces groupes, définir les droits que l'on souhaite, l'espace alloué etc...

Vérifier en testant les comptes utilisateurs, les différents droits, les dossiers partagés, la date de dernière modification etc..

Certificat TLS pour une communication crypté (https)
Se rendre dans le répertoire /etc/apache2/sites-available puis créer un fichier owncloud.https.conf
```
 cd /etc/apache2/sites-available 


 nano owncloud.https.conf
 ```

Insérer les lignes suivantes :
```
NameVirtualHost *:443
# Hôte virtuel qui écoute sur le port HTTPS 443
<VirtualHost *:443>
DocumentRoot /var/www/
# Activation du mode SSL
SSLEngine On 
SSLOptions +FakeBasicAuth +ExportCertData +StrictRequire
# On indique ou est le certificat
SSLCertificateFile /etc/ssl/certs/owncloud.crt
SSLCertificateKeyFile /etc/ssl/private/owncloud.key
</VirtualHost>
```

Activation du module SSL dans apache2 

```
 a2nmod ssl 
 ```

Ajouter le nouveau site aux sites actifs d'Apache2

```
 a2ensite owncloud.https.conf
```


Création du certificat signé automatiquement

```
 cd /etc/apache2/ && mkdir CertOwncloud && cd CertOwncloud 


 openssl genrsa -out owncloud.key 1024 


 openssl req -new -key owncloud.key -out owncloud.csr 
 ```

Il faut ensuite remplir les données du certificat, puis : 

```
 openssl x509 -req -days 365 -in owncloud.csr -signkey owncloud.key -out owncloud.crt 


 cp owncloud.crt /etc/ssl/certs 


 cp owncloud.key /etc/ssl/private 
 
 ```

Vérification de la configuration d’Apache2 avant son redémarrage : 

```
 apachectl configtest 


 service apache2 restart 
 ```

Il faut ensuite vérifier dans le navigateur que le HTTPS est bien utilisé en entrant « https://AdresseIpDuServeur/ownCloud » On peut également forcer l’utilisation automatique du HTTPS dans le panneau de configuration d’OwnCloud. (cocher la case)
