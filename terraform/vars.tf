variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}

variable "AWS_REGION" {
  default = "eu-central-1"
}

variable "AMIS" {
  type = map(string)
  default = {
    eu-central-1 = "ami-01299931803ce83f6"
  }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}

variable "CIDR_BLOCK" {
    type = list(string)
    default = ["172.20.0.0/16","172.20.10.0/24"]
}

variable "PORTS" {
    type = list(number)
    default = [22,80,443,8080,8081,9000]
}