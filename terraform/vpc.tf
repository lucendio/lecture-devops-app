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
    # to show the public ip in terraform.tfstate
    map_public_ip_on_launch = "true"
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

# Create route table and association
resource "aws_route_table" "DevOps_RouteTable" {
    vpc_id = aws_vpc.DevOps-VPC.id

    route {
        cidr_block = "0.0.0.0/0"
        # fetch internet gatway id<
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