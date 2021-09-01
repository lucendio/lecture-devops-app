
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
