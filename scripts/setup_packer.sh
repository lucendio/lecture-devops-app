#!/bin/bash
set -x

# Install necessary dependencies
echo "Install necessary dependencies"
sudo apt-get update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade
sudo apt-get update
sudo apt-get -y -qq install curl wget git vim apt-transport-https ca-certificates
echo "Install nodejs npm"
sudo apt-get -y install nodejs npm
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
# Clone repository
echo "Clone repository"
sudo git clone https://github.com/benebet/lecture-devops-app.git
cd ./lecture-devops-app
# Install client dependencies
echo "Install client dependencies"
cd app/client
sudo npm install
# Install server dependencies
echo "Install server dependencies"
cd ../server
sudo npm install
# Build server
echo "Build server"
cd ..
cd ..
echo "Creating temp directory"
sudo mkdir -p .local/temp
sudo rm -rf .local/temp
echo "Copying server source to temp directory"
sudo cp -r app/server/src .local/temp
echo "Copying package files to temp directory"
sudo cp app/server/package* .local/temp/
echo "Installing server dependencies"
cd .local/temp/
sudo npm install --prod --no-audit --no-fund
echo "Removing package files"
sudo rm -rf ./package*
