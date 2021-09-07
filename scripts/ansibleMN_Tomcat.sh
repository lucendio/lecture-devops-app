#! /bin/bash

#!/bin/bash
sudo su -
sudo useradd ansibleadmin
sudo echo "ansibleadmin:ansible" | chpasswd
# modify the sudoers file at /etc/sudoers and add entry
echo 'ansibleadmin     ALL=(ALL)      NOPASSWD: ALL' | sudo tee -a /etc/sudoers
# this command is to add an entry to file : echo 'PasswordAuthentication yes' | sudo tee -a /etc/ssh/sshd_config
# the below sed command will find and replace words with spaces "PasswordAuthentication no" to "PasswordAuthentication yes"
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo adduser ansibleadmin sudo
sudo mkdir -p /home/ansibleadmin/.ssh
sudo chown -R ansibleadmin:ansibleadmin /home/ansibleadmin/.ssh
sudo service sshd restart
