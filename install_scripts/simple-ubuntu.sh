#!/bin/bash

sudo cp /etc/apt/sources.list /etc/apt/sources-list.bak
sudo cp sources.list /etc/apt/

sudo apt update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

echo "-------------------------------------------------------------------"
echo "----- update, upgrade, and dist-upgrade complete, Next Phase ------"
echo "-------------------------------------------------------------------"

echo "-------------------------------------------------------------------"
echo "----- Installing zsh, neovim, chrome, openvpn, +more Next Phase ---"
echo "-------------------------------------------------------------------"

sudo apt install glances zsh neovim build-essential python3-setuptools qbittorrent git -y

echo "-------------------------------------------------------------------"
echo "----- Installing ohmyzsh Next Phase ---"
echo "-------------------------------------------------------------------"

wget -q https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
chmod +x install.sh
./install.sh --unattended
ZSH=${ZSH:-~/.oh-my-zsh}

#export SHELL="$ZSH"
# Change default shell to ZSH
chsh -s /usr/bin/zsh
#Fix .zsh path, add $HOME/.local/bin to PATH
sed -i '4iexport PATH=$PATH:$HOME/.local/bin' $HOME/.zshrc

#Change zsh theme
sed -i -e 's/ZSH_THEME=.*/ZSH_THEME="bira"/g' $HOME/.zshrc

#add alias in .zshrc
echo -e 'alias lh="ls -lAh"\nalias la="ls -la"\nalias ll="ls -l"' >> $HOME/.zshrc
echo -e 'alias g="git"\nalias vim="nvim"' >> $HOME/.zshrc

rm install.sh
chsh -s /usr/bin/zsh

git config --global user.email "you@example.com"
git config --global user.name "Your Name"

ssh-keygen -t rsa -b 4096 -N "" -C "venor@venor.com" -f $HOME/.ssh/venor -q
#source bash-vim-setup.sh

echo "Cleaning Up" &&
    apt -f install &&
    apt -y autoremove &&
    apt -y autoclean &&
    apt -y clean

echo "-------------------------------------------------------------------"
echo "-------------------- System Clean, Rebooting ----------------------"
echo "-------------------------------------------------------------------"

sudo reboot

