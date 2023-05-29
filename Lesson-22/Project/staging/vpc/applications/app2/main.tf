# Future Terraform Code :)

# Do it yourself!

terraform {
  backend "s3" {
    bucket = "mirik12-terraformstate1"                     // Bucket where to SAVE Terraform State
    key    = "dev/vpc/applications/app2/terraform.tfstate" // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                                   // Region where bycket created
  }
}
