### Quelques aides-mémoire powershell

Powershell ISE sous 2008 R2

```
Import-Module ServerManager
Add-WindowsFeature PowerShell-ISE
```

### Active Directory

Importation du module Active Directory

```
import-module ActiveDirectory
```

Éditer le chemin du profil (Profil Path) de l'utilisateur **mdupont** avec un chemin définis

```
Set-ADUser mdupont -ProfilePath '\\SRV-DC1\Profils$\Professeurs\mdupont\Profile'
```

Lister les **logins de session** d'un groupe Active Directory par ordre alphabétique

```
Get-ADGroupMember -identity "Mon_Groupe" -Recursive | Get-ADUser -property DisplayName | Select SamAccountName | sort -Property SamAccountName
```

Lister les **noms et prénoms d'utilisateur** d'un groupe Active Directory par ordre alphabétique

```
Get-ADGroupMember -identity "Mon_Groupe" -Recursive | Get-ADUser -property DisplayName | Select DisplayName | sort -Property DisplayName
```

Liste des noms de sessions d'un groupe trié par **ordre alphabétique** et exporté dans un **fichier texte**

```
$sessionname = Get-ADGroupMember -identity "Mon_Groupe" -Recursive | Get-ADUser -property DisplayName | Select SamAccountName | sort -Property SamAccountName
$sessionname | out-file 'C:\Powershell_Perso\sessionname.txt' -append
```

Petit script : on demande à l'utilisateur de rentrer le nom du groupe AD voulus pour afficher les logins de session. La liste s'exporteras ensuite format **.txt** avec un nom de fichier correspondant à la chaîne de caractères saisis par l'utilisateu

```
$groupe = Read-Host "Merci d'entrer le nom du groupe voulus : "
$sessionname = Get-ADGroupMember -identity $groupe -Recursive | Get-ADUser -property DisplayName | Select SamAccountName | sort -Property SamAccountName
$sessionname | out-file "C:\Powershell_Thomas\${groupe}.txt"
```

## Commandes en vrac
### Windows Server Backup

Supprimer les sauvegardes sauf les **10** plus récentes

```
wbadmin delete backup -keepVersions:10
```

Supprimer les sauvegardes d'**état du système** sauf les trois plus récentes 

```
wbadmin delete systemstatebackup -keepVersions:3
```

Suppression d'une sauvegarde crée le 31 Mars 2016 à 10h 

```
wbadmin delete systemstatebackup -version:03/31/2016-10:00
```



