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

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_webserver.id
}

resource "aws_instance" "my_webserver" {
  ami                    = "ami-07151644aeb34558a" # Amazon Linux AMI
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my-webserver.id]
  key_name               = "terraform"
  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Mirik",
    l_name = "Kys",
    names  = ["Vova", "Alisa", "Yana", "Mike", "John", "Maria", "KK", "dsdf"]
  })

  tags = {
    Name  = "Web Server Build by Terraform"
    Owner = "Mirik"
  }
  lifecycle {
    # prevent_destroy = true
    # ignore_changes = ["ami", "user_data"]
    create_before_destroy = true
  }
}



resource "aws_security_group" "my-webserver" {
  name        = "WebServer Security Group"
  description = "My First SecurityGroup"


  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      description = "ingress value"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
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
