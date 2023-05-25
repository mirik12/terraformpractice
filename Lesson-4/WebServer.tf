#------------------------------------
# My Terraform
#
#Build WebServer during Bootsrap
#
#Made by Mirik
#-------------------------------

provider "aws" {
  region = "eu-central-1"
}


resource "aws_instance" "my_webserver" {
  ami                    = "ami-07151644aeb34558a" # Amazon Linux AMI
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my-webserver.id]
  key_name               = "terraform"
  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Mirik",
    l_name = "Kys",
    names  = ["Vova", "Alisa", "Yana", "Mike", "John", "Maria"]
  })

  tags = {
    Name  = "Web Server Build by Terraform"
    Owner = "Mirik"
  }
}


resource "aws_security_group" "my-webserver" {
  name        = "WebServer Security Group"
  description = "My First SecurityGroup"


  ingress {
    description = "80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name  = "Web Server SecurityGroup"
    Owner = "Mirik"
  }
}
