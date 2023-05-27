provider "aws" {}

data "aws_availability_zones" "working" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_vpcs" "my_vpcs" {}

# data "aws_vpc" "prod_vpc" {
#   tags = {
#     Name = "prod"
#   }
# }

data "aws_vpc" "prod_vpc" {
  filter {
    name   = "tag:Name"
    values = ["prod"]
  }
}

output "prod_vpc_id" {
  value = data.aws_vpc.prod_vpc.id
}

output "pod_vpc_cidr" {
  value = data.aws_vpc.prod_vpc.cidr_block
}


output "data_aws_availability_zones" {
  value = data.aws_availability_zones.working.names

}

output "data_aws_caller_identity" {
  value = data.aws_caller_identity.current.account_id
}

output "data_aws_region" {
  value = data.aws_region.current.name
}

output "data_aws_region_description" {
  value = data.aws_region.current.description
}

output "aws_vpcs" {
  value = data.aws_vpcs.my_vpcs.ids
}
