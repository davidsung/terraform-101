terraform {
  required_version = ">= 0.12.26"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.21.0"
    }
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "amazon_linux_2" {
  ami           = data.aws_ami.amazon_linux_2.id
  subnet_id     = tolist(data.aws_subnet_ids.all.ids)[0]
  instance_type = "t3.small"
}

output "vpc_id" {
  value = data.aws_vpc.default.id
}

output "subnet_ids" {
  value = data.aws_subnet_ids.all.ids
}

output "ami_id" {
  value = data.aws_ami.amazon_linux_2.id
}

output "instance_id" {
  value = aws_instance.amazon_linux_2.id
}

output "instance_public_ip" {
  value = aws_instance.amazon_linux_2.public_ip
}
