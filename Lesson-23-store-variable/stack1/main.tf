provider "aws" {
  region = "eu-central-1"
}

data "terraform-remote-state" "global" {
  backend = "s3"
  config {
    bucket = "mirik12-terraform-state"
    key    = "globalvars/terraform.tfstate"
    region = "eu-central-1"
  }
}

locals {
    company_name = data.terraform_remote_state.gloval.outputs.company_name
    owner = data.terraform_remote_state.gloval.outputs.owner
    commands_tags = data.terraform_remote_state.gloval.outputs.tags
}

#-------------------------------------------------------------------

resource "aws_vpc" "vpc1" {
    cidr_block = "10.0.0.0/16"
    tags {
        Name = "Stack1-VPC1"
        Company = local.company_name
        Owner = local.owner
    }
}

resource "aws_vpc" "vpc2" {
    cidr_block = "10.0.0.0/16"
    tags = merge(local.common_tags, {Name = "Stack1-VPC2" })
}