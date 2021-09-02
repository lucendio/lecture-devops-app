#!/bin/bash
set -x

# Install necessary dependencies
sudo apt-get update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade
sudo apt-get update
sudo apt-get -y -qq install curl wget git vim apt-transport-https ca-certificates
sudo apt-get -y install nodejs npm
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
# Clone repository
sudo git clone https://github.com/benebet/lecture-devops-app.git
cd ./lecture-devops-app
# Install client dependencies
cd app/client
sudo npm install
# Install server dependencies
cd ../server
sudo npm install
# Build server
echo "Creating temp directory"
mkdir -p ./.local/temp
rm -rf ./.local/temp
echo "Copying server source to temp directory"
cp -r ./app/server/src ./.local/temp
echo "Copying package files to temp directory"
cp ./app/server/package* ./.local/temp/
echo "Installing server dependencies"
cd ./.local/temp/
npm install --prod --no-audit --no-fund
echo "Removing package files"
rm -rf ./package*
