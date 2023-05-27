variable "region" {
  description = "Please enter AWS region"
  type        = string
  default     = "ca-central-1"
}

variable "instance_type" {
  description = "Enter instance_type"
  type        = string
  default     = "t3.small"
}

variable "allow-ports" {
  description = "List of ports to open for server"
  type        = list(any)
  default     = ["80", "443", "22", "8080"]

}

variable "enable_detailed_monitoring" {
  description = "Write True or False"
  type        = bool
  default     = false
}

variable "common_tags" {
  description = "Common Tags to apply to all resources"
  type        = map(any)
  default = {
    Owner       = "Mirik"
    Project     = "Phoenix"
    CostCenter  = "12345"
    Environment = "development"
  }
}
