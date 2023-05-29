provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "mirik12-terraform-state"
    key    = "globalvars/terraform.tfstate"
    region = "eu-central-1"
  }
}

#------------------------

output "company_name" {
  value = "ANDESA Soft International"
}

output "owner" {
  value = "Mirik"
}

output "tags" {
  value = {
    Project    = "Assembly 2023"
    CostCenter = "R&D"
    Country    = "Canada"
  }
}
