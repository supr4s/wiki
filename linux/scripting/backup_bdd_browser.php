<?php
#stage 2016
#definition des differentes variables de la BDD
$DBUSER='MonUser';
$DBPASSWD='MonMotDePasse';
$DBNAME='NomDeLaBDD';
$FILENAME='BDD_backup';

#sauvegarde du backup sous le nom qu'on lui a donnee via la variable $FILENAME
system("mysqldump --user='$DBUSER' --password='$DBPASSWD' '$DBNAME' > '$FILENAME'.sql");

#suppression du fichier apres le backup par soucis de securite (verifier que le nom est correctement orthographie)
#ici le fichier s'appelleras script.php

system("rm -Rf script.php");

?>
