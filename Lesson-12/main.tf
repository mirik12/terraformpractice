#----------------------------------------------------------
# My Terraform
#
# Variables
#
# Made by Mirik
#----------------------------------------------------------


provider "aws" {
  region = var.region
}

resource "aws_default_vpc" "default" {} # This need to be added since AWS Provider v4.29+ to get VPC id

data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}


resource "aws_eip" "my_static_ip" {
  vpc      = true # Need to add in new AWS Provider version
  instance = aws_instance.my_server.id
  //tags     = var.common_tags
  tags = merge(var.common_tags, { Name = "${var.common_tags["Environment"]} Server IP" })

  /*
  tags = {
    Name    = "Server IP"
    Owner   = "Mirik"
    Project = "Phoenix"
  }
*/

}



resource "aws_instance" "my_server" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.my_server.id]
  monitoring             = var.enable_detailed_monitoring

  tags = merge(var.common_tags, { Name = "${var.common_tags["Environment"]} Server Build by Terraform" })

}


resource "aws_security_group" "my_server" {
  name   = "My Security Group"
  vpc_id = aws_default_vpc.default.id # This need to be added since AWS Provider v4.29+ to set VPC id

  dynamic "ingress" {
    for_each = var.allow-ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, { Name = "${var.common_tags["Environment"]} Server SecurityGroup" })

}
