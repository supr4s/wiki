## Introduction
L'installation du miroir BlackArch sous une distribution ArchLinux (ici Manjaro) va nous permettre d'installer tout les outils disponibles sous BlackArch (qui est un OS de pentesters/sécurité rappellons-le) sous une distribution de type ArchLinux de notre choix et ainsi avoir tout les paquets sur notre distri !

**OS utilisé :** Manjaro 16.06

## Installation

Ajout du dépôt BlackArch dans /etc/pacman.conf

```
sudo echo "[blackarch]
Server = http://blackarch.pi3rrot.net/blackarch/$repo/os/$arch
SigLevel = Optional TrustAll" > /etc/pacman.conf
```

Installation des clés de signature du miroir

```
sudo pacman-key -r 4345771566D76038C7FEB43863EC0ADBEA87E4E3
```

```
sudo pacman-key --lsign-key 4345771566D76038C7FEB43863EC0ADBEA87E4E3
```

## Mise à jour des paquets

```
sudo pacman -Syyu
```

Pour installer par défaut tout les paquets

```
sudo pacman -S blackarch
```

Pour voir les différents outils par catégories

```
sudo pacman -Sg | grep blackarch
```

Pour installer tout les outils d'une catégorie spécifiée

```
sudo pacman -S blackarch-<categorie>
```

## En cas d'erreur lors de la mise à jour des paquets

Un peu bourrin mais sa passe toujours ;)

```
sudo pacman-Syyu --force
```
