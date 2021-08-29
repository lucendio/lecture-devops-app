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
4. sudo mount -t vboxsf lecture-devops-app shared_folder
5. cd shared_folder

Ordner kann hinzugefügt werden und ist dann sowohl in der VB, als auch im Host verfügbar.


=============================

### Terraform

`initialize provider plugins`
terraform init

`always after using, otherwhise you have to pay`
terraform destroy



=============================
