sudo su -
sudo useradd admin
sudo echo "admin:admin123" | chpasswd
echo 'admin     ALL=(ALL)      NOPASSWD: ALL' | sudo tee -a /etc/sudoers
