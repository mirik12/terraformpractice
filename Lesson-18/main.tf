#Terraform Loops": Count and For if

provider "aws" {
  region = "eu-central-1"
}

variable "aws_users" {
  description = "List of IAM users to create"
  default     = ["Vova", "Mirik", "Alisa", "Sasha", "Misha", "Vlad"]
}

resource "aws_iam_user" "user1" {
  name = "yana"
}

resource "aws_iam_user" "users" {
  count = length(var.aws_users)
  name  = element(var.aws_users, count.index)
}

output "created_iam_users_all" {
  value = aws_iam_user.users
}

output "created_iam_users_id" {
  value = aws_iam_user.users[*].id
}

output "created_iam_users_custom" {
  value = [
    for user in aws_iam_user.users :
    "Username: ${user.name} has ARN: ${user.arn}"
  ]
}

output "created_iam_users_map" {
  value = {
    for user in aws_iam_user.users :
    user.unique_id => user.id // AIDAWCU5ABUCMQVYWAU5I : Vlad
  }
}

// Print List of users with name 4 characters ONLY
output "custom_if_length" {
  value = [
    for x in aws_iam_user.users :
    x.name
    if length(x.name) == 4
  ]
}



#-----------------------------------------------------------------------------

resource "aws_instance" "servers" {
  count         = 3
  ami           = "ami-07151644aeb34558a"
  instance_type = "t3.micro"
  tags = {
    Name = "Server Number ${count.index + 1}"
  }
}

// Print nice MAP of InstanceID: PiblicIP
output "server_all" {
  value = {
    for server in aws_instance.servers :
    server.id => server.public_ip
  }
}
