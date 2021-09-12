#! /bin/bash

sudo apt update
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash 
sudo apt install nodejs -y 
sudo apt install nodejs-legacy -y