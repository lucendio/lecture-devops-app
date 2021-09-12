#! /bin/bash

# sudo apt-get update -y
# sudo apt-get upgrade -y
# sudo add-apt-repository ppa:webupd8team/java
# sudo apt-get update -y
# sudo apt-get install oracle-java8-installer -y
# sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
# wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add -
# sudo apt-get update -y
# sudo apt-get install postgresql postgresql-contrib
# su - postgres
# createuser sonar
# psql
# ALTER USER sonar WITH ENCRYPTED password 'sonar';
# CREATE DATABASE sonar OWNER sonar;
# \q
# sudo adduser sonar
# wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-6.7.6.zip
# unzip sonarqube-6.7.6.zip
# sudo cp -r sonarqube-6.7.6 /opt/sonarqube
# sudo chown -R sonar:sonar /opt/sonarqube
