#!/bin/bash

#Jenkins Installation:
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt install openjdk-8-jdk -y
sudo apt update
sudo apt install jenkins -y
sudo systemctl start jenkins
sleep 3m
[[ ! -f tools/ ]] \
&& sudo mkdir -p tools \
&& sudo wget https://github.com/jenkinsci/plugin-installation-manager-tool/releases/download/2.11.0/jenkins-plugin-manager-2.11.0.jar \
&& sudo java -jar jenkins-plugin-manager-2.11.0.jar --war /usr/lib/jenkins/jenkins.war --plugin-download-directory /var/lib/jenkins/plugins --plugins nodejs \
&& sudo java -jar jenkins-plugin-manager-2.11.0.jar --war /usr/lib/jenkins/jenkins.war --plugin-download-directory /var/lib/jenkins/plugins --plugins mongodb \
&& sudo java -jar jenkins-plugin-manager-2.11.0.jar --war /usr/lib/jenkins/jenkins.war --plugin-download-directory /var/lib/jenkins/plugins --plugins publish-over-ssh \
&& sudo chown jenkins:jenkins /var/lib/jenkins/plugins/nodejs.jpi
&& sudo chown jenkins:jenkins /var/lib/jenkins/plugins/publish-over-ssh.jpi
&& sudo chown jenkins:jenkins /var/lib/jenkins/plugins/mongodb.jpi
sudo service jenkins restart
