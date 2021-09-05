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

#Docker Installation:
wget -qO- https://get.docker.com/ | sh
service docker start
usermod -a -G docker ansibleadmin
sudo systemctl enable docker
sudo yum install python2-pip
sudo pip2 install docker-py