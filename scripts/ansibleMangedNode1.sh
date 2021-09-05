#! /bin/bash

#!/bin/bash
sudo su -
sudo useradd ansibleadmin
sudo echo "ansibleadmin:ansible" | chpasswd
echo 'ansibl_eadmin     ALL=(ALL)      NOPASSWD: ALL' | sudo tee -a /etc/sudoers
echo 'ubuntu     ALL=(ALL)      NOPASSWD: ALL' | sudo tee -a /etc/sudoers
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo adduser ansibleadmin sudo
sudo mkdir -p /home/ansibleadmin/.ssh
sudo chown -R ansibleadmin:ansibleadmin /home/ansibleadmin/.ssh
sudo service sshd restart
