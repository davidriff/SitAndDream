#!/usr/bin/env python

import json
import os

install_string="sudo apt-get install -y"
uninstall_string="sudo apt-get purge -y"


with open('config.json') as config_file:    
        config = json.load(config_file)

SitAndDream=config["SitAndDream"]

install=SitAndDream["install"][0]
uninstall=SitAndDream["uninstall"][0]
configure=SitAndDream["configure"][0]

for item in install:
    if install[str(item)]==True:
        install_string=install_string+" "+install[str(item)]

for item in uninstall:
    if uninstall[str(item)]==True:
        uninstall_string=uninstall_string+" "+uninstall[str(item)]

os.system("sudo apt-get update")
os.system(uninstall_string)
os.system("sudo apt-get clean")
os.system(install_string)
os.system("sudo apt-get autoremove")
os.system("sudo apt-get upgrade")



#configuration
for item in configure:
    if configure[str(item)]==True:
    	if str(item)=="vim-plugins":
            os.system("git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle")
            os.system("cp ./files/vimrc ~/.vimrc")
            os.system("vim -c PluginInstall")
            os.system("'autocmd vimenter * NERDTree' >> ~/.vimrc")

	if str(item)=="firewall":
	    os.system("sudo cp ./files/iptables-for-client-mode /etc/init.d/firewall.sh")
	    os.system("sudo update-rc.d firewall.sh defaults")

	if str(item)=="fail2ban":
            os.system("sudo cp ./files/fail2ban.conf /etc/fail2ban/fail2ban.local")
            os.system("sudo cp ./files/jail.conf /etc/fail2ban/jail.local")

	if str(item)=="ssh":
            os.system("sudo cp ./files/sshd_config /etc/ssh/sshd_config")

        if str(item)=="RiffHelpMe":
    	    os.system("git clone https://github.com/davidriff/RiffHelpMe ~/Riff-apps/RiffHelpMe/")
            os.system("sudo cp ~/Riff-apps/RiffHelpMe/RiffHelpMe.sh /usr/bin/RiffHelpMe")
            os.system("sudo cp -ar ~/Riff-apps/RiffHelpMe/RiffHelpMe/ /etc/")

        if str(item)=="coucou":
            os.system("git clone https://github.com/davidriff/coucou ~/Riff-apps/coucou/")
            os.system("sudo cp ~/Riff-apps/coucou/coucou.py /etc/init.d/coucou.py")
            os.system("sudo update-rc.d coucou.py defaults")
