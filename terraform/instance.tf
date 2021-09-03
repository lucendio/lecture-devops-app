# Create an AWS EC2 Instance (allows instances to be created, updated and deleted. Instancec also support provisioning)
# AMI = Amazon machine imgag -> template that contains software configs (operating system, application etc.)
resource "aws_instance" "devops" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = var.INSTANCE_TYPE
  key_name      = aws_key_pair.mykey.key_name
  vpc_security_group_ids = [aws_security_group.DevOps_Sec_Group.id]
  subnet_id = aws_subnet.DevOps-Subnet1.id
  # associate_public_ip_address = true
  # user_data = file("../scripts/installJenkins.sh")
  
  tags = {
    Name = "devops"
  }

  # connection {
  #   host        = coalesce(self.public_ip, self.private_ip)
  #   type        = "ssh"
  #   user        = var.INSTANCE_USERNAME
  #   private_key = file(var.PATH_TO_PRIVATE_KEY)
  # }
}

