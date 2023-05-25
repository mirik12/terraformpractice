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
  user_data              = <<EOF
#!/bin/bash
sudo yum -y update
sudo yum -y install httpd
myip='curl http://169.254.169.254/latest/meta-data/local-ipv4'
echo "<h2>WebServer with IP: $myip</h2><br>Build By Terraform!" > var/www/html/index.html
sudo service httpd start
chkconfig httpd on
EOF

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
