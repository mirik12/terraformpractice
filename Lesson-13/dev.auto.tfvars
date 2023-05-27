#Auto fill parameters for DEV
#File can be names as: "terraform.rfvars" or "prod.auto.tfvars" "dev.auto.tfvars"

region                     = "eu-central-1"
instance_type              = "t2.micro"
enable_detailed_monitoring = false
allow-ports                = ["80", "443", "22", "8080"]
common_tags = {
  Owner       = "Mirik"
  Project     = "Phoenix"
  CostCenter  = "12345"
  Environment = "dev"
}

