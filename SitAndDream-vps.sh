#!/bin/bash

echo "First we will change root password"
sudo passwd root

echo "Good, now give me the name of the new user:"
read new_user

sudo adduser $new_user
sudo adduser $new_user sudo

echo "Configuring SSH, root login disabled, you should login with "$new_user
#sudo cp ./files/sshd_config /etc/ssh/sshd_config
echo "give me new port for ssh"
read new_ssh_port
sudo sed -i 's/Port 22/Port '$new_ssh_port'/g' /etc/ssh/sshd_config
sudo sed -i 's/X11Forwarding yes/X11Forwarding no/g' /etc/ssh/sshd_config
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y fail2ban vim tmux unattended-upgrades apt-listchanges git

git clone https://github.com/davidriff/RiffHelpMe
sudo cp ./RiffHelpMe/RiffHelpMe.sh /usr/local/bin/RiffHelpMe
sudo cp -ar ./RiffHelpMe/RiffHelpMe/ /opt/

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
cp ./files/vimrc ~/.vimrc
vim -c PluginInstall

sudo cp ./files/fail2ban.conf /etc/fail2ban/fail2ban.local
sudo cp ./files/jail.conf /etc/fail2ban/jail.local

'PS1="\[\e[31;1m\][\t] \u@\h en \w: \[\033[00m\]"' >> /home/$new_user/.bashrc

