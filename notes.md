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
* * * * * (every minute)

`nexus conf`
1. Pipeline syntax
2. select nexus artifact uploader
3. Nexus3
4. cope PRIVATE ip address + PORT
5. enter user (nexus) + pw (nexus)
6. go to nexus server -> repo -> name = repository in jenkins
7. go to pom.xml groupid = groupid
8. version = snapshot version
9. click add artifacts
10. artifactID = pom.xml artifactID
11. type = war
12. file = target/artififactid-version.war
13. click generate pipeline script 
14. copy snippet

=============================

### Ansible

## Ansible-Controller

ssh-copy-id DockerHost
ssh-copy-id TomcatHost

1. cd .. playbooks
2. sudo vim host
-m = module
groupname = tomcat/docker
3. ansible groupname -m

=============================

### Nexus

`nexus pw`
sudo cat /opt/sonatype-work/nexus3/admin.password

1. enter new pw
2. choose Enable anonymous access
3. click settings -> repos

`How to create a repo (one to store snapchat artefacts, one to store release artefacts) `

1. create repo
2. npm (hosted)
3. devops-client-SNAPCHAT


=============================

### troubleshooting

`time issue`

sudo ntpdate ntp.ubuntu.com
