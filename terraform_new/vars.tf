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

