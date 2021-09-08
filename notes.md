Personal Notes
=============================

### Vagrant

`shows running enviroments (and IDs)`
vagrant global-status

`destroy env`
vagrant destroy ID 

`starts env`
vagrant up

`destoys unused/directory problems`
vagrant global-status  --prune

`connect to vagrant box`
vagrant ssh

=============================

### Virtual Box

#### Shared folders erstellen:
1. bei VB shardfolder -> lecture-devops-app hinzugefügt (auf mount) (automatisch erstelltes löschen) (nicht permanent)
2. VB starten
3. mkdir shared_folder
4. sudo mount -t vboxsf devops shared_folder
5. cd shared_folder

Ordner kann hinzugefügt werden und ist dann sowohl in der VB, als auch im Host verfügbar.


=============================

### Terraform

`initialize provider plugins`
terraform init

`always after using, otherwhise you have to pay`
terraform destroy

=============================

### ssh to the EC2 instance

chmod 600 mykey
sudo ssh <public_ip> -l ubuntu -i mykey

=============================


### see user-date launched on instance

cd /var/lib/cloud/instances/<instance-id>/

=============================

### Jenkins

`jenkins pw`
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

-> Konfiguration der Hilfsprogramme 
-> add Maven -> apply -> save

1. login
2. -> new Item (Element anlegen)
3. enter job name: devops pipeline job
4. click pipeline
5. descroption: 3 stage contionous delivery pipeline
6. scroll to Pipeline -> pipeline script from SCM
7. SCM -> Git -> https://github.com/s84117/lecture-devops-app.git
8. -> apply -> save
9. build now 

`Poll SCM`
-> configure
-> choose Poll SCM
Schedule:
***** (every minute)



=============================

### ansibleUser

## switched to Ansible-Managed-Node

ip addr
copy ip-address (Ip adress of managed node) 172.20.10.74/24

## switched to Ansible-Controller

ssh-copy-id -i ~/.ssh/id_rsa ansibleadmin@172.20.10.205

ssh-copy-id 172.20.10.93
