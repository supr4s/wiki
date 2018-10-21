#!/bin/bash
#Install ZSH
sudo apt-get update && sudo apt-get install zsh -y;

#Récupération de oh-my-zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)";

#Je change le thème par défaut par agnoster
sed -i 's/robbyrussel/agnoster/g' ~/.zshrc && clear && source ~/.zshrc;

#Définition de ZSH comme shell par défaut
chsh;
