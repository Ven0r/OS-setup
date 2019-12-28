#!/bin/bash

sudo cp /etc/apt/sources.list /etc/apt/sources-list.bak
sudo cp sources.list /etc/apt/

apt update
apt-get upgrade -y
apt-get dist-upgrade -y

echo "-------------------------------------------------------------------"
echo "----- update, upgrade, and dist-upgrade complete, Next Phase ------"
echo "-------------------------------------------------------------------"

sudo apt install glances zsh neovim hexedit exiftool exif qbittorrent chromium-browser openvpn -y

echo "-------------------------------------------------------------------"
echo "---------- Lots of cool software installed, Next Phase ------------"
echo "-------------------------------------------------------------------"

sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

echo "-------------------------------------------------------------------"
echo "---------- Installed Oh-my-zsh, Next Phase ------------"
echo "-------------------------------------------------------------------"

#source bash-vim-setup.sh

sudo service postgresql start
msfdb init

echo "-------------------------------------------------------------------"
echo "--------------- Metasploit configured, Next Phase -----------------"
echo "-------------------------------------------------------------------"

echo "Cleaning Up" &&
    apt -f install &&
    apt -y autoremove &&
    apt -y autoclean &&
    apt -y clean

echo "-------------------------------------------------------------------"
echo "-------------------- System Clean, Rebooting ----------------------"
echo "-------------------------------------------------------------------"

sudo reboot

