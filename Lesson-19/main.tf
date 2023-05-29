#----------------------------------------------------------
# My Terraform
#
# Provision Resources in Multiply AWS Regions / Accounts
#
# Made by Mirik
#----------------------------------------------------------

provider "aws" {
  region = "eu-central-1"
  access_key = "xxxxxxxxxxxxxx"
  secret_key = "yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy"

  assume_role {
    role_arn = "arn:aws:iam::1234567890:role/RemoteAdministrators"
    session_name = "TERRAFORM-SESSION"
  }
}

provider "aws" {
  region = "ca-central-1"
  alias  = "CA"
}

provider "aws" {
  region = "us-east-1"
  alias  = "USA"
}

#-------------------------------------------------------------------------

data "aws_ami" "default_region_latest_ubuntu" {
  owners      = ["418014825732"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

data "aws_ami" "usa_latest_ubuntu" {
  provider    = aws.USA
  owners      = ["418014825732"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

data "aws_ami" "ca_latest_ubuntu" {
  provider    = aws.CA
  owners      = ["418014825732"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}



resource "aws_instance" "my_canada_server" {
  provider      = aws.CA
  ami           = data.aws_ami.ca_latest_ubuntu.id
  instance_type = "t3.micro"
  tags = {
    Name = "Canada Server"
  }
}

resource "aws_instance" "my_usa_server" {
  provider      = aws.USA
  ami           = data.aws_ami.usa_latest_ubuntu.id
  instance_type = "t3.micro"
  tags = {
    Name = "Usa Server"
  }
}

resource "aws_instance" "my_default_server" {
  ami           = data.aws_ami.default_region_latest_ubuntu.id
  instance_type = "t3.micro"
  tags = {
    Name = "Default Server"
  }
}
