#! /bin/bash

#! /bin/bash

sudo apt update
sudo apt install openjdk-8-jdk -y
cd /opt/
sudo wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz
sudo tar xf latest-unix.tar.gz
sudo mv nexus-3.* nexus3
cd /opt/nexus3/bin/
sudo touch nexus.rc
sudo ln -s /opt/nexus3/bin/nexus /etc/init.d/nexus
cd /etc/init.d
sudo systemctl enable nexus
sudo systemctl start nexus