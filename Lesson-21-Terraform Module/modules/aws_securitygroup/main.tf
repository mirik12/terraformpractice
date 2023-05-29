provider "aws" {
  region = "eu-central-1"
}

resource "aws_security_group" "user_security_group" {
  name        = "user-sg"
  description = "Security group for users"
  vpc_id      = aws_vpc.main.id

  ingress {
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
    Name = "user-sg"
  }
}
