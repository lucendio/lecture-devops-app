
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

# Create route table and association
resource "aws_route_table" "DevOps_RouteTable" {
    vpc_id = aws_vpc.DevOps-VPC.id

    route {
        cidr_block = "0.0.0.0/0"
        # fetch internet gatway id
        gateway_id = aws_internet_gateway.DevOps-IntGW.id
    }

    tags = {
        Name = "DevOps_Routetable"
    }
}

# Create route table association between subnet and route table
resource "aws_route_table_association" "DevOps_Assn" {
    subnet_id = aws_subnet.DevOps-Subnet1.id
    route_table_id = aws_route_table.DevOps_RouteTable.id
}

# Create an AWS EC2 Instance (allows instances to be created, updated and deleted. Instancec also support provisioning)
# AMI = Amazon machine imgag -> template that contains software configs (operating system, application etc.)
resource "aws_instance" "devops" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = var.INSTANCE_TYPE
  key_name = "EC2"
  vpc_security_group_ids = [aws_security_group.DevOps_Sec_Group.id]
  subnet_id = aws_subnet.DevOps-Subnet1.id
  associate_public_ip_address = true
  
  tags = {
    Name = "devops"
  }
}

