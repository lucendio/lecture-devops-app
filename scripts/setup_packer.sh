#!/bin/bash
set -x

# Install necessary dependencies
sudo apt-get update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade
sudo apt-get update
sudo apt-get -y -qq install curl wget git vim apt-transport-https ca-certificates
sudo apt install nodejs npm
sudo nodejs --version
# Clone repository
sudo git clone https://github.com/benebet/lecture-devops-app.git
sudo ls -la
sudo cd ./lecture-devops-app
# Install client dependencies
sudo cd app/client
sudo npm install
# Install server dependencies
sudo cd ../server
sudo npm install
