#!/bin/bash

#Jenkins Installation:
apt update
apt install openjdk-8-jdk --yes
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
echo "deb https://pkg.jenkins.io/debian binary/" >> /etc/apt/sources.list
apt update
apt install -y jenkins
systemctl status jenkins
find /usr/lib/jvm/java-1.8* | head -n 3