#!/bin/bash
set -x

# Install necessary dependencies
sudo apt-get update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade
sudo apt-get update
sudo apt-get -y -qq install curl wget git vim apt-transport-https ca-certificates
sudo npm install -g npm
# Clone repository
sudo git clone https://github.com/benebet/lecture-devops-app.git
sudo cd lecture-devops-app
# Install client dependencies
sudo cd app/client
sudo npm install
# Install server dependencies
sudo cd ../server
sudo npm install

# Setup sudo to allow no-password sudo for "hashicorp" group and adding "terraform" user
# sudo groupadd -r hashicorp
# sudo useradd -m -s /bin/bash terraform
# sudo usermod -a -G hashicorp terraform
# sudo cp /etc/sudoers /etc/sudoers.orig
# echo "terraform  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/terraform

# Installing SSH key
# sudo mkdir -p /home/terraform/.ssh
# sudo chmod 700 /home/terraform/.ssh
# sudo cp /tmp/tf-packer.pub /home/terraform/.ssh/authorized_keys
# sudo chmod 600 /home/terraform/.ssh/authorized_keys
# sudo chown -R terraform /home/terraform/.ssh
# sudo usermod --shell /bin/bash terraform

# Create GOPATH for Terraform user & download the webapp from github

# sudo -H -i -u terraform -- env bash << EOF
# whoami
# echo ~terraform
# cd /home/terraform
# export GOROOT=/usr/lib/go
# export GOPATH=/home/terraform/go
# export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
# go get -d github.com/hashicorp/learn-go-webapp-demo
# EOF
