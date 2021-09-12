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

## Ansible-Nodes

1. ubuntu pw in den nodes ändern

## Ansible-Controller

2. ssh key generieren
3. sudo vim /etc/ansible/hosts
-> 
[tomcat]
 172.20.10.61

[docker]
172.20.10.131

4. ssh-copy-id DockerHost, ssh-copy-id TomcatHost
`testing`
(5. cd /etc/ansible)
(6. ansible groupname -m ping -i hosts -> ansible tomcat -m ping -i hosts)
7. run ansible-galaxy install zaxos.tomcat-ansible-role
8.

`run playbook`

 ansible-playbook installTomcat.yaml -i hosts --check


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

sudp passwd
sudo passwd ubuntu
passwd


=============================

### Sonar

openjdk-8-jre-headless

sudo bash

ALTER USER sonar WITH ENCRYPTED password 'sonar';
CREATE DATABASE sonar OWNER sonar;

sudo vim /opt/sonarqube/bin/linux-x86-64/sonar.sh

sudo vim /opt/sonarqube/conf/sonar.properties



sonar.jdbc.username=sonar
sonar.jdbc.password=sonar
sonar.jdbc.url=jdbc:postgresql://localhost/sonar
sonar.web.host=0.0.0.0
sonar.web.port=9000
sonar.web.javaAdditionalOpts=-server
sonar.search.javaOpts=-Xmx512m -Xms512m -XX:+HeapDumpOnOutOfMemoryError
sonar.log.level=INFO
sonar.path.logs=logs

sudo vim /etc/systemd/system/sonar.service

sudo vim /etc/apache2/sites-available/sonar.conf


sudo vim /etc/sysctl.conf

sudo vim /etc/security/limits.conf


sonar   -   nofile   65536
sonar   -   nproc    4096

ALTER USER sonar WITH ENCRYPTED password 'sonar';
CREATE DATABASE sonar OWNER sonar;
GRANT ALL PRIVILEGES ON DATABASE sonar to sonar;


sonar-scanner \
  -Dsonar.projectKey=admin \
  -Dsonar.sources=. \
  -Dsonar.host.url=http://18.193.46.100:9000 \
  -Dsonar.login=e8baee64f88ae2a26cf1d08685b21da5383baed9