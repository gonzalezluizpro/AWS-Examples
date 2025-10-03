# Terraform for EC2 Apache with Amazon Linux 2023

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.4"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "eu-central-1"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
  key_name   = "tf-ec2-key"
  public_key = tls_private_key.ssh.public_key_openssh
}

resource "local_file" "private_key" {
  content              = tls_private_key.ssh.private_key_pem
  filename             = "${path.module}/ec2-key.pem"
  file_permission      = "0600"
  directory_permission = "0700"
}

locals {
  user_data = <<-EOF
  #!/bin/bash
  dnf -y update
  dnf -y install httpd
  systemctl enable httpd
  systemctl start httpd
  echo "<h1>✅ Apache on EC2 (Amazon Linux 2023)</h1>" > /var/www/html/index.html
  EOF
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = aws_key_pair.kp.key_name
  user_data              = local.user_data

  tags = {
    Name = "tf-web"
  }
}

output "public_ip" {
  value = aws_instance.web.public_ip
}

output "ssh_command" {
  value       = "ssh -i ec2-key.pem ec2-user@${aws_instance.web.public_dns}"
  description = "Run this to connect"
}

output "http_url" {
  value       = "http://${aws_instance.web.public_dns}"
  description = "Open this in your browser"
}
