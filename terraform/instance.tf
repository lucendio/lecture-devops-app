
resource "aws_instance" "devops" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = var.INSTANCE_TYPE
}

# Create a VPC
resource "aws_vpc" "DevOps-VPC"{
    cidr_block = var.CIDR_BLOCK[0]

    tags = {
        Name = "DevOps-VPC"
    }

}

# Create Subnet
resource "aws_subnet" "DevOps-Subnet1" {
    vpc_id = aws_vpc.DevOps-VPC.id
    cidr_block = var.CIDR_BLOCK[1]

    tags = {
        Name = "DevOps-Subnet1"
    }
}

# Create Internet Gateway (connection between VPC and internet)
resource "aws_internet_gateway" "DevOps-IntGW" {
    vpc_id = aws_vpc.DevOps-VPC.id

    tags = {
        Name = "DevOps-InternetGW"
    }
}


# Create Secutity Group (acts like virtuel firewall to controll inbound and outbound traffic)
resource "aws_security_group" "DevOps_Sec_Group" {
  name = "DevOps Security Group"
  description = "To allow inbound and outbound traffic to DevOps"
  vpc_id = aws_vpc.DevOps-VPC.id

# specify the inbound traffic

# allow dynamic incoming ports 
  dynamic ingress {
      iterator = port
      for_each = var.PORTS
       content {
            from_port = port.value
            to_port = port.value
            protocol = "tcp"
            # specify range of block
            cidr_blocks = ["0.0.0.0/0"]
       }
  }

# -1 -> all, only work from port 0 to port 0, 0.0.0.0/0 -> all IP-addresses
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  } 

  tags = {
      Name = "allow traffic"
  }
}
