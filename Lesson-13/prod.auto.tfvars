#Auto fill parameters for prod
#File can be names as: "terraform.rfvars" or "prod.auto.tfvars" "dev.auto.tfvars"

region                     = "eu-central-1"
instance_type              = "t2.small"
enable_detailed_monitoring = true
allow-ports                = ["80", "443"]
common_tags = {
  Owner       = "Mirik"
  Project     = "Phoenix"
  CostCenter  = "123477"
  Environment = "prod"
}

