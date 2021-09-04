packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "region" {
  type    = string
  default = "us-east-1"
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "amazon-ebs" "ubuntu" {
  ami_name      = "packer_todoapp-${local.timestamp}"
  instance_type = "t2.micro"
  region        = var.region
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  sources = ["source.amazon-ebs.ubuntu"]

  post-processor "manifest" {
        output = "manifest.json"
        strip_path = true
    }

  provisioner "shell" {
    script = "./scripts/setup_packer.sh"
  }
}
