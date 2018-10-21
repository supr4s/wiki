#!/bin/bash
#Install ZSH
sudo apt-get update && sudo apt-get install git zsh -y;

#Récupération de oh-my-zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)";

#Je change le thème par défaut par agnoster (powerline shell)
sed -i 's/robbyrussel/agnoster/g' ~/.zshrc && clear && source ~/.zshrc;

#Définition de ZSH comme shell par défaut
chsh;

######### TIPS ########
# https://opensource.com/article/18/9/tips-productivity-zsh
# https://doc.ubuntu-fr.org/zsh
## EXEMPLES
# 1°) /var/my_folder au lieu de cd /var/my_folder
# 2°) dirs -v pour afficher les répertoires dans lesquels on a navigué. On tape ensuite la chiffre correspondant pour y aller
# 3°) Appuer deux fois (ou trois suivant la taille) sur TAB pour ensuite parcourir les choix proposés
# 4°) Créer un alias : $ alias la='ls -a'
# 5°) Plusieurs options possibles en remplacement de la commande find : https://linuxgazette.net/184/silva.html
