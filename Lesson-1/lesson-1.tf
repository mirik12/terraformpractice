provider "aws" {}


resource "aws_instance" "my_ubuntu" {
  // count = 3
  ami           = "ami-03aefa83246f44ef2"
  instance_type = "t2.micro"
  key_name      = "terraform"

  tags = {
    Name    = "My Ubuntu Server"
    Owner   = "Mirik"
    Project = "Terraform lessons"
  }
}

resource "aws_instance" "my_amazon" {
  ami           = "ami-0288447644a3d0c2b"
  instance_type = "t4g.small"
  key_name      = "test"

  tags = {
    Name    = "My Amazon Server"
    Owner   = "Mirik"
    Project = "Terraform lessons"
  }
}

