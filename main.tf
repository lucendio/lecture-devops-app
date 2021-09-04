terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.15.1"
}

data "aws_ami" "app_ami" {
  most_recent = true
  owners      = ["amazon"]

filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "todoapp" {
  key_name = resource.aws_key_pair.deployer.key_name
  security_groups = [resource.aws_security_group.allow_ssh.name]
  ami           = "${data.aws_ami.app_ami.id}"
  instance_type = "t2.micro"

  tags = {
    Name = "TODO_APP_INSTANCE"
  }
}

resource "aws_key_pair" "deployer" {
  key_name = "deployer-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

output "instance_public_ip" {
  description = "Public IP Address of AWS instance"
  value = aws_instance.todoapp.public_ip
}
