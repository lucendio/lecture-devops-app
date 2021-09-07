#! /bin/bash


#!/bin/bash
set -e

# install ansible
if ! [ -x "$(command -v apt-add-repository)" ]; then 
    sudo apt-get --assume-yes update 
    sudo apt-get install --assume-yes software-properties-common
fi

if ! [ -x "$(command -v ansible)" ]; then
    sudo apt-add-repository -y ppa:ansible/ansible
    sudo apt-add-repository -y ppa:git-core/ppa
    sudo apt-get update
    sudo apt install python -y
    sudo apt install ansible -y

fi

sudo su -
sudo useradd ansibleadmin
sudo echo "ansibleadmin:ansible" | chpasswd
# modify the sudoers file at /etc/sudoers and add entry
echo 'ansibleadmin     ALL=(ALL)      NOPASSWD: ALL' | sudo tee -a /etc/sudoers
# this command is to add an entry to file : echo 'PasswordAuthentication yes' | sudo tee -a /etc/ssh/sshd_config
# the below sed command will find and replace words with spaces "PasswordAuthentication no" to "PasswordAuthentication yes"
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo adduser ansibleadmin sudo
# create new ssh key
[[ ! -f /home/ansibleadmin/.ssh/id_rsa ]] \
&& mkdir -p /home/ansibleadmin/.ssh \
&& ssh-keygen -f /home/ansibleadmin/.ssh/id_rsa -N '' \
&& chown -R ansibleadmin:ansibleadmin /home/ansibleadmin/.ssh
sudo service sshd restart


