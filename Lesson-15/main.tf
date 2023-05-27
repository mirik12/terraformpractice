provider "aws" {
  region = "eu-central-1"

}

resource "null_resource" "command1" {
  provisioner "local-exec" {
    command = "echo Terraform START: $(date) >> log.txt"
  }
}

resource "null_resource" "command2" {
  provisioner "local-exec" {
    command = "ping -c 5 www.google.com"
  }

  #   depends_on = [ null_resource.command1 ]
}

resource "null_resource" "command3" {
  provisioner "local-exec" {
    # command = "python -c 'print('Hello World')'"
    command     = "print('Hello World')"
    interpreter = ["python3", "-c"]
  }
}

resource "null_resource" "command4" {
  provisioner "local-exec" {
    command = "echo $NAME1 $NAME2 $NAME3 >> names.txt"
    environment = {
      NAME1 = "Mirik"
      NAME2 = "YANA"
      NAME3 = "Natasha"
    }
  }
}

resource "aws_instance" "myserver" {
  ami           = "ami-07151644aeb34558a"
  instance_type = "t3.micro"
  provisioner "local-exec" {
    command = "echo Hello from AWS Instance Creations!"
  }

}

resource "null_resource" "command6" {
  provisioner "local-exec" {
    command = "echo Terraform END: $(date) >> log.txt"
  }
  depends_on = [null_resource.command1, null_resource.command2, null_resource.command3, null_resource.command4, aws_instance.myserver]
}
