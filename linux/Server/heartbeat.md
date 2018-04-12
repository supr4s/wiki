## HeartBeat

HeartBeat ou LinuxHA (High Availability) permet de gérer un cluster de serveur avec un failover d'adresse IP virtuel.


### Installation en ligne de commande


Toutes les commandes et instructions sont à passés sur les deux serveurs bien entendus :

```
sudo apt-get update && apt-get install heartbeat
```

### Configuration

On crée le fichier de configuration : 

```
nano /etc/heartbeat/ha.cf
```

Ici, ***linux1*** et ***linux2*** correspondent aux noms des serveurs. Linux1 pour le serveur maître et le 2 pour l'esclave.

Il est donc important voir impératif de vérifier que les noms d'hôtes sont bien configurés (/etc/hosts et hostname) car HeartBeat travaille avec des noms d'hôtes et non des IP. On peut aller plus loin avec divers enregistrements DNS soit dans les fichiers hosts soit par un serveur DNS. 

```
# Indication du fichier de log
logfile /var/log/heartbeat.log
# Les logs heartbeat seront gérés par syslog, dans la catégorie daemon
logfacility daemon
# On liste tous les membres de notre cluster heartbeat (par les noms  de préférences)
node linux1
node linux2
# On défini la périodicité de controle des noeuds entre eux (en  seconde)
keepalive 1
# Au bout de combien de seconde un noeud sera considéré comme "mort"
deadtime 10
# Quelle carte résau utiliser pour les broadcasts Heartbeat (eth0 dans mon cas)
bcast eth0
# Adresse du routeur pour vérifier la connexion au net - A ADAPTER
ping 192.168.1.1
# Rebascule-t-on automatiquement sur le primaire si celui-ci redevient  vivant ? oui*
auto_failback yes
```

Création de la clé d'authentification 

```
nano /etc/heartbeat/authkeys 
```

Le contenu possible (MaClefSecrete à adapter bien entendu). Trois modes de hachage : sha1, md5, crc.. 

```
auth 1
1 sha1 MaClefSecrete
```

On donne les droits à ce fichier. Sans cela, il y auras une erreur lors du démarrage d'HeartBeat. 

```

chmod 600 /etc/heartbeat/authkeys
```

Création du fichier haresources (indiquer le serveur maître, et l'IP virtuel à prendre). Ce fichier est à crée également sur le serveur esclave. 

```

nano /etc/heartbeat/haresources
```
```
linux1 192.168.1.253
```

Redémarrage d'HeartBeat sur les deux serveurs : 

```

service heartbeat restart
```

On peut maintenant vérifier qu'il y a bien une IP virtuel sur le serveur maître (la commande ifconfig renverras un eth0 avec un :0 pour indiquer l'IP virtuel active). 
Lors de l'arrêt du serveur maître, l'esclave prendra le relais. Si le maître redeviens actif, alors il reprendras le contrôle et donc l'IP virtuel.
