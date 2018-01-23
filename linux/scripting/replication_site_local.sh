#!/bin/bash
#définition des parametres pour la connexion au FTP
SOURCE='/'
echo "Indiquez le chemin du répertoire de destination (ex: /var/www/html/)"
read DESTINATION
echo "Saisissez l'adresse (IP ou FQDN) pour la connexion au FTP : "
read FTP
echo "Saisissez le login pour la connexion FTP : "
read LOGINFTP
echo "Saisissez le password du login FTP : "
read -s PASSWORDFTP
echo 'Téléchargement de la copie du site......'
/usr/bin/lftp -u $LOGINFTP,$PASSWORDFTP $FTP -e 'mirror -e -P 20 '$SOURCE' '$DESTINATION'; quit'
echo 'Fin du téléchargement, chemin du répertoire copié : '$DESTINATION' '

#A MODIFIER - Chemin ou se situe le premier fichier : script.php
CHEMIN='//root/Bureau/scripts/script_finaux/script.php'

#suppression du fichier SQL par précaution
#BDD_backup.sql définis dans le fichier script.php
BACKUP=$(sed -rn "s/.*\<FILENAME=['\"]?([^'\";]*).*/\1/p"  $CHEMIN);
/usr/bin/lftp -u $LOGINFTP,$PASSWORDFTP $FTP -e 'rm -f '$BACKUP'.sql; quit'
echo 'Suppression du fichier SQL terminé....'

#création de la base de données automatiquement
#Récupérer les variables dans le script php pour la BDD
echo 'Connexion MySQL et réplication de la BDD....'
#définition des variables admin MySQL 
echo "Saisissez le login root de la BDD : "
read LOGINADMINBDD
echo "Saisissez le passwoord root de la BDD : "
read -s PASSADMINBDD

#définition des variables pour la création de la BDD - récupère les variables du script.php définis plus-haut
DBUSER=$(sed -rn "s/.*\<DBUSER=['\"]?([^'\";]*).*/\1/p"  $CHEMIN);
DBPASSWD=$(sed -rn "s/.*\<DBPASSWD=['\"]?([^'\";]*).*/\1/p"  $CHEMIN);
DBNAME=$(sed -rn "s/.*\<DBNAME=['\"]?([^'\";]*).*/\1/p"  $CHEMIN);

echo 'Création de la nouvelle BDD....'
mysql -u $LOGINADMINBDD -p$PASSADMINBDD -e 'CREATE DATABASE '$DBNAME' CHARACTER SET UTF8;' -e 'CREATE USER '$DBUSER';' -e 'set password for '$DBUSER' = PASSWORD("'$DBPASSWD'");' -e 'GRANT ALL PRIVILEGES ON '$DBNAME'.* TO '$DBUSER'@localhost IDENTIFIED by "'$DBPASSWD'";' -e 'set password for '$DBUSER' = PASSWORD("'$DBPASSWD'");'
echo 'Importation des tables....'
mysql -u $DBUSER -p$DBPASSWD $DBNAME < $DESTINATION/$BACKUP.sql 
echo 'Importation finis !!'
