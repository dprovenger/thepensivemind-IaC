# aw.thepensivemind.com
# By Jorge Arrieta
# Version 0.01

# Configure terraform requirements
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = "us-east-1"
}

# Latest Ubuntu image lookup
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

# Fetching the existing Elastic IP dynamically
data "aws_eip" "existing_eip" {
  filter {
    name   = "tag:Environment"
    values = ["thepensivemind.com"]
  }
}


# EC2 web server instance creation
resource "aws_instance" "web-thepensivemind" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = "dev-linux-thepensivemind"
  subnet_id              = "subnet-fa80fc9c"
  vpc_security_group_ids = ["sg-0ea1c87624830a457"]

  tags = {
    "Environment" = "thepensivemind.com"
    "Terraform"   = "true"
  }
}

# Associating existing EIP to new instance
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.web-thepensivemind.id
  allocation_id = data.aws_eip.existing_eip.id
}