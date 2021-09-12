# userdata for the Jenkins server ...
data "template_file" "jenkins_server" {
  template = "${file("../scripts/installJenkins.sh")}"
}

# userdata for the Ansible Controller
data "template_file" "ansible_controller" {
  template = "${file("../scripts/installAnsibleCN.sh")}"
}

# userdata for the AnsibleMN_TomcatHost
data "template_file" "AnsibleMN_TomcatHost" {
  template = "${file("../scripts/ansibleMN_Tomcat.sh")}"
}

# userdata for the AnsibleMN_DockerHost
data "template_file" "AnsibleMN_DockerHost" {
  template = "${file("../scripts/ansibleMN_Docker.sh")}"
}

# userdata for the AnsibleMN_DockerHost
data "template_file" "Nexus" {
  template = "${file("../scripts/installNexus.sh")}"
}

# userdata for the Sonar
data "template_file" "Sonar" {
  template = "${file("../scripts/installSonar.sh")}"
}

# userdata for the AnsibleMN_DockerHost
data "template_file" "MongoDB_server" {
  template = "${file("../scripts/installMongoDB.sh")}"
}

# userdata for the Sonar
data "template_file" "Node_server" {
  template = "${file("../scripts/installNode.sh")}"
}


# # Create an AWS EC2 Instance (allows instances to be created, updated and deleted. Instancec also support provisioning)
# AMI = Amazon machine imgag -> template that contains software configs (operating system, application etc.)
resource "aws_instance" "Jenkins" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = var.INSTANCE_TYPE
  key_name      = aws_key_pair.mykey.key_name
  vpc_security_group_ids = [aws_security_group.DevOps_Sec_Group.id]
  subnet_id = aws_subnet.DevOps-Subnet1.id
  associate_public_ip_address = true
  user_data = "${data.template_file.jenkins_server.rendered}"
  
  tags = {
    Name = "Jenkins-Server"
  }
}

# # Create an AWS EC" Instance to host Ansible Controller (control node)
# resource "aws_instance" "AnsibleController" {
#   ami           = var.AMIS[var.AWS_REGION]
#   instance_type = var.INSTANCE_TYPE
#   key_name      = aws_key_pair.mykey.key_name
#   vpc_security_group_ids = [aws_security_group.DevOps_Sec_Group.id]
#   subnet_id = aws_subnet.DevOps-Subnet1.id
#   associate_public_ip_address = true
#   user_data = "${data.template_file.ansible_controller.rendered}"
  
#   tags = {
#     Name = "Ansible-ConrolNode"
#   }
# }

# # Create/Launch an AWS EC2 Instance(Ansible Manged Node1) to host Apache Tomcat Server
# resource "aws_instance" "AnsibleMN_TomcatHost" {
#   ami           = var.AMIS[var.AWS_REGION]
#   instance_type = var.INSTANCE_TYPE
#   key_name      = aws_key_pair.mykey.key_name
#   vpc_security_group_ids = [aws_security_group.DevOps_Sec_Group.id]
#   subnet_id = aws_subnet.DevOps-Subnet1.id
#   associate_public_ip_address = true
#   user_data = "${data.template_file.AnsibleMN_TomcatHost.rendered}"
  
#   tags = {
#     Name = "AnsibleMN-Tomcat"
#   }
# }


# # Create/Launch an AWS EC2 Instance(Ansible Manged Node2) to host Apache Tomcat Server
# resource "aws_instance" "AnsibleMN_DockerHost" {
#   ami           = var.AMIS[var.AWS_REGION]
#   instance_type = var.INSTANCE_TYPE
#   key_name      = aws_key_pair.mykey.key_name
#   vpc_security_group_ids = [aws_security_group.DevOps_Sec_Group.id]
#   subnet_id = aws_subnet.DevOps-Subnet1.id
#   associate_public_ip_address = true
#   user_data = "${data.template_file.AnsibleMN_DockerHost.rendered}"
  
#   tags = {
#     Name = "AnsibleMN-Docker"
#   }
# }

# # Create/Launch an AWS EC2 Instance(Ansible Manged Node2) to host Apache Tomcat Server
resource "aws_instance" "Nexus" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = var.INSTANCE_TYPE_FOR_NEXUS
  key_name      = aws_key_pair.mykey.key_name
  vpc_security_group_ids = [aws_security_group.DevOps_Sec_Group.id]
  subnet_id = aws_subnet.DevOps-Subnet1.id
  associate_public_ip_address = true
  user_data = "${data.template_file.Nexus.rendered}"
  
  tags = {
    Name = "Nexus-Server"
  }
}

# # # Create/Launch an AWS EC2 Instance to host SonarQube Host
# resource "aws_instance" "Sonar" {
#   ami           = var.AMIS[var.AWS_REGION]
#   instance_type = var.INSTANCE_TYPE_FOR_NEXUS
#   key_name      = aws_key_pair.mykey.key_name
#   vpc_security_group_ids = [aws_security_group.DevOps_Sec_Group.id]
#   subnet_id = aws_subnet.DevOps-Subnet1.id
#   associate_public_ip_address = true
#   user_data = "${data.template_file.Sonar.rendered}"
  
#   tags = {
#     Name = "Sonar-Server"
#   }
# }

resource "aws_instance" "Node" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = var.INSTANCE_TYPE
  key_name      = aws_key_pair.mykey.key_name
  vpc_security_group_ids = [aws_security_group.DevOps_Sec_Group.id]
  subnet_id = aws_subnet.DevOps-Subnet1.id
  associate_public_ip_address = true
  user_data = "${data.template_file.Node_server.rendered}"
  
  tags = {
    Name = "Node-Server"
  }
}

resource "aws_instance" "MongoDB" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = var.INSTANCE_TYPE
  key_name      = aws_key_pair.mykey.key_name
  vpc_security_group_ids = [aws_security_group.DevOps_Sec_Group.id]
  subnet_id = aws_subnet.DevOps-Subnet1.id
  associate_public_ip_address = true
  user_data = "${data.template_file.MongoDB_server.rendered}"
  
  tags = {
    Name = "MongoDB-Server"
  }
}
