#!/bin/bash

echo "First we will change root password"
sudo passwd root

echo "Good, now give me the name of the new user:"
read new_user

adduser $new_user
adduser $new_user sudo

echo "Configuring SSH, new port will be 47022, root login disabled, you should login with "$new_user
sudo cp ./files/sshd_config /etc/ssh/sshd_config

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install vim tmux unattended-upgrades apt-listchanges git

git clone https://github.com/davidriff/RiffHelpMe
sudo cp ./RiffHelpMe/RiffHelpMe.sh /usr/local/bin/RiffHelpMe
sudo cp -ar ./RiffHelpMe/RiffHelpMe/ /opt/

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
cp ./files/vimrc ~/.vimrc
vim -c PluginInstall



sudo cp ./files/fail2ban.conf /etc/fail2ban/fail2ban.local
sudo cp ./files/jail.conf /etc/fail2ban/jail.local

