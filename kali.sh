#!/bin/bash

sudo cp /etc/apt/sources.list /etc/apt/sources-list.bak
sudo cp sources.list /etc/apt/

apt update
apt-get upgrade -y
apt-get dist-upgrade -y

echo "-------------------------------------------------------------------"
echo "----- update, upgrade, and dist-upgrade complete, Next Phase ------"
echo "-------------------------------------------------------------------"

apt install glances zsh neovim hexedit exif qbittorrent chromium openvpn -y

echo "-------------------------------------------------------------------"
echo "----- Installing zsh, neovim, chrome, openvpn, +more Next Phase ---"
echo "-------------------------------------------------------------------"

cd /root/Documents/

git clone https://github.com/danielmiessler/SecLists.git 

echo "-------------------------------------------------------------------"
echo "------------------ Getting SecLists from Github  ------------------"
echo "-------------------------------------------------------------------"

git clone https://github.com/swisskyrepo/PayloadsAllTheThings.git 
cd ~

echo "-------------------------------------------------------------------"
echo "---------   Getting PayloadsalltheThings from Github  -------------"
echo "-------------------------------------------------------------------"

echo "-------------------------------------------------------------------"
echo "---------- Lots of cool software installed, Next Phase ------------"
echo "-------------------------------------------------------------------"

wget -q https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
chmod +x install.sh
./install.sh --unattended
ZSH=${ZSH:-~/.oh-my-zsh}
#export SHELL="$ZSH"
# Change default shell to ZSH
chsh -s /usr/bin/zsh
#Fix .zsh path, add /root/.loca/bin to PATH
sed -i '4iexport PATH=$PATH:/root/.local/bin' $HOME/.zshrc

#Change zsh theme
sed -i -e 's/ZSH_THEME=.*/ZSH_THEME="robbyrussell"/g' $HOME/.zshrc

#add alias in .zshrc
echo -e 'alias lh="ls -lAh"\nalias la="ls -la"\nalias ll="ls -l"' >> $HOME/.zshrc
echo -e 'alias g="git"\nalias vim="nvim"' >> $HOME/.zshrc
rm install.sh
chsh -s /usr/bin/zsh

cd /root/
git config --global user.email "you@example.com"
git config --global user.name "Your Name"

chmod +x firefox_build.sh
./firefox_build.sh

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

#sudo reboot
