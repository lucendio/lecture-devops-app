resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "devops" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
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